import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: __ENV.K6_VIRTUAL_USERS || 10,  // 가상 사용자 수
  duration: __ENV.K6_DURATION || '30s',  // 테스트 지속 시간
  thresholds: {
    http_req_duration: ['p(95)<500'],  // 95%의 요청이 500ms 이내여야 함
    http_req_failed: ['rate<0.01'],    // 실패율 1% 미만
  },
};

export default function () {
  const response = http.get('http://localhost:8080/');  // 테스트할 API 엔드포인트
  
  check(response, {
    'is status 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  sleep(1);  // 각 요청 사이에 1초 대기
}