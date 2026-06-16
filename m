Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8744CF40
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624864; cv=none; b=VwTDitnF5hXrCdlddlnAJWdjg1DT9hzJXd0mPrBbT4oYtx5kHWNIIlTwCzju1OISwpd1MKUrG0hspyoCS5ajEbGgJCY/bDCByNQQQCjHbOHaUj5QLPDWHWz4MhI6cEXI1qvyz1Z4flmj9hMLVko0wk5rj9+tRyKbwhIWKsA8KsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624864; c=relaxed/simple;
	bh=e1pGdssdQsaRpIBh+4JFRNHi4dhtOKvcr+672dc0fYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+VPZLT300uXTku9X6OGC12N1j6mg2ajK1Ql/dtcvsiAQq4jcAQl9vApxy1R2NbmbnukVFVUHsjW7gM4KhBG43ve5a/S6IOuZI0/PjfcuJVOUrHXbMOqTacHY+QNNqtoE05EEaMjunZaFdRHa2/elHXdcNxP/PW/GQ6rPo2Ya8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EC372epp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EzaSqc3+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EC372epp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EzaSqc3+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFeKSo029066
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eJW0DORVNViUcs7XgxbuIXaC6bb6dBOgIPg
	icankNzk=; b=EC372eppeUcYA6AlOW+1agnLRrMAoU89X2U8ZHgfWSmNA4GWZcP
	+VnthYRIZ0fpePnfUj5NPG20VD3QShj+Bmpe9BnBHUqad+ioYma2cQ5c+0VVY4wB
	vxQCrrMZYIwMYNmqF+4nFqC7TZi50/kIcJtPk8XHYH0JAxuFAm3wOsYf4Q/Id0Pl
	sObjOeSJmXLYuSBfaIZfIYm61dpqDT+fHHQRUn8V0n3TBL/jfOkVZtZ8yW2XqizR
	m8V+mZK1micVsP6UBOcalPA8oxZPVDdT0OK+jVPtj6gfhZDSUeW/iLdkpG6vBHIa
	LCzcJcvgbSS2Vg+keGzrzSoQKGUwgaWH0Ew==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52u08s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:47:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84233efcaadso3393110b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781624861; x=1782229661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJW0DORVNViUcs7XgxbuIXaC6bb6dBOgIPgicankNzk=;
        b=EzaSqc3++LQKMmfgpoF0xlb9lMxaCfxu1WQNEkHI5LoQlUjdNWK9oW8DczEwQLXns8
         o4Ia5ROk7OlIZXkeEYCDYbqc/2/rpvWwE+Ly92sL/CyWfanVZnCGzduWNgymXk7YTQTj
         RWeo5H/KFl/P+6XFvNxk9IjDT9kWg4YHEXDGbN1w3yOnmT9snptr4qWZ+FpdVVnN9mT8
         3VLRml+4kRCtqIWrTwiHZrc/HE5oRbvwejO2E7aDPN6s3xOUCMWmrQW8Q7SwMqQ2XNqc
         Hua/gD5s5+Xuo7xEDikU+wkT7E0uf5RhhYIVKEa0oG0bipiBCXkRlqe3MYrqbWdxtdTD
         3k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781624861; x=1782229661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJW0DORVNViUcs7XgxbuIXaC6bb6dBOgIPgicankNzk=;
        b=fLfhCX4osWL+bD+RXgdD/pa3jYsi6AegZVtI8Z17x6f9c1MveLIKB7fFv4M+Wu0n2E
         3B3a1FC7P2ER6i7z2XaqHyKb2+Fl672ER6LHIxKFlidn2XBZTUmT+wIwSTheLRD8XtxL
         mp2w8QQu8urkIXkT1PeO7eZQmK7jsRnyobgmT9RMYMNp3Jliyr3RaPjsHOftxppwaAEQ
         Ul4vD3qPGdoJozEYn3HLAZQE1QVL4cnmC9I4BxS5aZ8sj/LwCZjp2O+V2aq0VYwSoqtm
         GMMnY44WiiDqPxM4WwCQUleeI5bnS3uGZdpsbbF5yQOGnEKKRNdQxaI1dPSo4qRfBDPp
         8KXg==
X-Forwarded-Encrypted: i=1; AFNElJ9PeEh4OfqSxkbiM9bkdF6/I2SSxUfsq1ge8hVe0SZ9bDiHZs2lYxoaeeT1cDlDBkz2cTy2Fho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCViCBTsBORUc1nrZJrBYi2YSJTm64vx5HS4pPtbEmhL8favEu
	AHhIUAlG1PIOX1Q5xu6J2Q+8xlKmtOTXIQ2bHWGO/rGm08sX8QmwU2X36okIeGC3leM2nfii6+w
	899u93+aphX8xHCl9haDdWT2Aja6eKCnKL1Jp/g9JN4d5GmXDsztlebpVSbM=
X-Gm-Gg: Acq92OHw0tMAEg2RX0nc9l3RC3SiEN0fjd3h694Gc7rlCHZVj6NErsqw81PO94YCmlK
	B0z1YObaXVTKC8bOe36lYHPhIUrOLl6FJWGg0qBeunsxfwlZEX4IoQ+WW7fV5Sp3ck83guN5cTk
	xUZZmV2K06ChjAVa5oP03+YicvSAH7tqAh8STOx+9NnKzlc5SNqysFauiznkHpAZK5lNDF+ToUu
	8c7y7p9NGWXssnZ5WmBzRFbfK92zZuocOhDxUOfbRknp5Rc75uy8irT7l4BGJnqkfgOv8lrhVpn
	6p0vu8SXfnFemqOLwzt1NAhakQQe7Cp/idFEwHA4BfVbHfrba4Clu9eh8ZhUitYoq/NY+yW+Ttd
	qszAvgrDv/dhsFrVceiZbXqxE7wACfhSXzycUoFiEE4RPYZ9//xgH3kpc6Wm6xecPLEtozfkgaC
	JxWoeKS1i9alpq
X-Received: by 2002:a05:6a00:3a16:b0:842:33f3:da68 with SMTP id d2e1a72fcca58-8434cd0b4d2mr20606362b3a.8.1781624860400;
        Tue, 16 Jun 2026 08:47:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a16:b0:842:33f3:da68 with SMTP id d2e1a72fcca58-8434cd0b4d2mr20606306b3a.8.1781624859917;
        Tue, 16 Jun 2026 08:47:39 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf039fsm13163418b3a.20.2026.06.16.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:47:39 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, christian.loehle@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on the adjust_perf path
Date: Tue, 16 Jun 2026 23:47:33 +0800
Message-ID: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE2MCBTYWx0ZWRfX5GWuL+XPn2qG
 4Np9UB/M+Ckgg2zVmV/b0EPsV41KIzJ06clzNx+p7ysfpDSRE0uxAf4x4nnljZhAMCi8uDJn1VU
 2WLHzePNKcswB/YLVGKpemUwIEPwAJQ=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a31701d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4H1OJQDQ-noEIwH9yNQA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE2MCBTYWx0ZWRfX5MQuOhVVK5lY
 I28xzheKivkeJqmBO02UJSMzGIltTWQJhYjT79W5NcvYxs4qogy7F1Jcv8kDkrWKFF5sD5jvBoM
 F4zY9r5MGFa0u2tzF1gc9OV82mMqoThebKCssvnh67CmHuRmTBD2d1ryL99y69fYKIkejRoI/yK
 pgDdNHMjsXENiHZliotiNQeqRNzF9ZhJ0K55H05CMgXfmfSi7MAanbtJmR1aBudMt8mytJiv6Q5
 ovM1LmPln1DWkJPMVVKAsP0wxuJkavz8DSLPGATYxFgQtLVb1//WoRJgqWRMQpg91DubNarKlEL
 wjxnhIpJRwcZ8287hmnRTbM5zRBh1i+nuUHFutqCURXvBnSK9tXsksGojAYt490VFYCv23t+epa
 Tly7AfJmZ2NWlr+kHpj/emhN+UlMbSLnuyWxYmxViA1/M60ur7OAfLGdFN5BPVJtIPL+0QuWfpd
 99pk1a93VR4B9O05Rjw==
X-Proofpoint-ORIG-GUID: C8mAwX4mru7j9agbb2QcEoXYyKHa220P
X-Proofpoint-GUID: C8mAwX4mru7j9agbb2QcEoXYyKHa220P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160160

The need_freq_update flag makes sugov_should_update_freq() return true
regardless of the rate_limit_us throttling, and is cleared in
sugov_update_next_freq(). sugov_update_single_freq() and
sugov_update_shared() go through that helper, so the flag does not
persist there.

However, sugov_update_single_perf() (used by drivers implementing the
->adjust_perf() callback, e.g. intel_pstate or amd-pstate in passive mode)
calls cpufreq_driver_adjust_perf() directly and never goes through
sugov_update_next_freq(), so the need_freq_update flag is not cleared in
that path.

Before commit 75da043d8f88 ("cpufreq/sched: Set need_freq_update in
ignore_dl_rate_limit()"), this was effectively harmless because
sugov_should_update_freq() still honoured the rate limit even when
need_freq_update was set. After that change, the flag forces
sugov_should_update_freq() to always return true, so once set, it stays
effective indefinitely on the adjust_perf path.

As a result, cpufreq_driver_adjust_perf() gets called on every scheduler
utilization update (with the runqueue lock held) rather than being
throttled by rate_limit_us, even if the driver itself may skip redundant
hardware updates.

Clear need_freq_update at the end of the adjust_perf path as well.

Fixes: 75da043d8f88 ("cpufreq/sched: Set need_freq_update in ignore_dl_rate_limit()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ae9fd211cec1..a4e689eefdfb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -486,6 +486,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
 				   sg_cpu->util, max_cap);
 
+	sg_policy->need_freq_update = false;
 	sg_policy->last_freq_update_time = time;
 }
 
-- 
2.43.0

