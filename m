Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA841D625
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202729; cv=none; b=V8zFJuRlKeb7ndo6VSkJzO44sSlvshN1phTy4NOsQRyVORVHnPLmY6P/2ADlQzj8mHem843kfOONthV0E/LPsN+JRdKUNxCf1TmLpPyVjcCoQwxiCr+XPFqwZhgiC6Is1VWbTdcZ5U+v6m8PJqiaQRgZOaVCgFESwUdR1Nda2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202729; c=relaxed/simple;
	bh=HYna8fn7t2KA7gRid/Wc1EDMEsLvCN2XW1uoIOUWEDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4EiAnJ0MvfeGsV2db9znPxR8lHNt/OYW38dRn+p/YmbCg7xkfO4cUhL+15/znTEoHWa7MVOak5NzN5y6VleSIlVDQvb0TkIAp/qwUeGRVF8zIkT7MfRtAm0wVTxRLl6mKX6MOp7ubONmsDEAUsI66xO9rPYHiv4Myuju+yH8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Atm7+S0s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFjFec2w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Atm7+S0s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFjFec2w"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiZPW3747263
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iKq0++/woNlx+aXAGS5PFN7c8L7JOhXQvmy
	HSz6bOiQ=; b=Atm7+S0sGr35PbHte6pf546y8ZkLsfTrZoabHggGCXxofDSLHMj
	QJATD/Z3iKD9xHRuBiR+p0jjkHmQf2z+PiCLW5/m5rHYz62/1HPOEUIjIylzY92U
	MCQ0eIXfWwS8flkzbTlU7PVw4SLahGdBR5Xqt5djnUv8QuEdLm2HjFg+QrBNG2qR
	fADqSG+YfJUpeAmTt83L858bb1oQ9bfD6kz5mlYyDoteA2VLID+rIzyl0c6s7QuX
	IxCRPCfA2ZXhegoj1zGNWswrLEAtKL6L6ZAliDx0R9bA1rI1+deQl0QoCn5GHBVg
	pVkU1ZiMxQu7e///33YivwH9/LaIm7ExKNA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3phwq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:52:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso3190202a12.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784202726; x=1784807526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iKq0++/woNlx+aXAGS5PFN7c8L7JOhXQvmyHSz6bOiQ=;
        b=UFjFec2ws+ngBw7c55fWcNOlPCQYdLkQVyEVqeWknmDw02Vrna/0XoMhJderdad9W/
         2vKDiWkzSq0AwaIRzI6F9KfUDS1FipoyHfibeD+D+XncW6ZrslrxngaTRvL6I95mu3Vs
         QN2saYw8BNgp/z0SfeMyptiKe+KT4T0Qv9CqFhuB8EA4CzaEbwSim4+wO4LAkklUmT+3
         OZ+x5F0v53R0B6EWGl0+KLkUPsY4puH4VWVrrVupBO7skvn7CYA6bDk4CemYUUtQW0PY
         s/BKQLOstTmVaTWYm70dXsanlshHbfxQQ/TH2beJbTS0uHs2mbqTQMvm4qLysmStayPo
         F9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784202726; x=1784807526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKq0++/woNlx+aXAGS5PFN7c8L7JOhXQvmyHSz6bOiQ=;
        b=b71CZKPk6EULxo6LZUcFor2sFivTJfQniHV6wR07k/mx3l9GFi1DPZ0Hw/9IaQIOai
         pvZGKn23qJuCkUqXszcnOIZ4AtP4jpxop6N/6WHTH5SzAarOCYcpRTKrCzO+CI7mEwHo
         lW3Ht+J4G2LmrEc35fyoCz4YuICT0rcb1lyvP+3ZCbEVh/7F109dzIoO82N41lHdpiWc
         4Crvss1xr42B1FAvGmb82v7zOXcPeW4z73rmu1TLH2/2tWoJRHsG33BpOZfS5HU087EU
         22oLYoAhsEvLp+Qt90PacLTTj5q0c+9+JIV9sB5wr3jWFIOsTbf8SLY5Dm7NLUtLkLXU
         7G9g==
X-Forwarded-Encrypted: i=1; AHgh+RrdKL4hMbmt52JIjDCtbmaOgZ7kq1zCWO6kcP+PoHOO5Hi6OTv5CmKIaFLS7OQ7bV6aTqOl14I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+I7zHwJJcy9x2h8fz4K4KFX4O5gG/PnXawEzWhY8UmS7SXuAa
	qDa+MGR6zqUG1++ZvGNvmq+9Dyw66W3z3THpayCHIg6hc62pkEywqdWiGI6IDOkhxxcGEcpaAuT
	8l5JGkRwe6QF/d6nm8OFvxDcx7qk3K+PNkOPk/ka9rxwt8/DTStxkj1lkk8w=
X-Gm-Gg: AfdE7cnrc/8PILG1Cv+R9SKV9FlKhmE549ySyo/iA7Li6K1ZAF2Dz3TqgdbNVvIU2Xk
	YCTQCkRkluiwqDQilSWN1ZYQnksfErlyLwhaEDmlD689vJjXjg1HXuYp38Qp30PrrsOmHKnqUw4
	8fBZvvQAAQE8bBOFp1qKGG7RCMZxVLDZVpYuthrHuh8pyvKA4JxCXUkgYT+bNXemBiz/msbARpm
	q5KyVE0DBECdnReLHG3WMbzGpqq2a8MZAlDHSo2EwYxgwS+OUi9URrwSaqPA9SjSZ4S81bWj8d0
	cY0YTwrpcPxFiEQ0Rzes9fayLJ5FUdGKmPP2FOXqQargSuY5f+av7CcvKnA6HXgS3/oSu9sxWa+
	RrrbFPBHccy8vmYEl2ZCcD6+f7QOpprLiQVIDa0yrzvMm10HgLrUupLUYVZyrNuuri3M=
X-Received: by 2002:a05:6a20:4307:b0:3c3:7dfd:22c6 with SMTP id adf61e73a8af0-3c37dfd2500mr4604564637.73.1784202726218;
        Thu, 16 Jul 2026 04:52:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:4307:b0:3c3:7dfd:22c6 with SMTP id adf61e73a8af0-3c37dfd2500mr4604549637.73.1784202725782;
        Thu, 16 Jul 2026 04:52:05 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258ff402asm1631213a12.22.2026.07.16.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:52:05 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, christian.loehle@arm.com,
        liaochang1@huawei.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: Publish util hooks only after all sg_cpu are initialized
Date: Thu, 16 Jul 2026 19:51:58 +0800
Message-ID: <20260716115159.848403-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gKixN3wQ3S8oU7suqJPHPDIrfpbovsOM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyMiBTYWx0ZWRfX5kI2zzUmQPk+
 BW+ofAOLUaLdtkWZTx5Bzy5pK43jACq78PeaM9pDJShhU8JNhGKzYz/6K+OfOOiJ5RmhoW+HodJ
 K4k4wYHhN06h3L19UV5ZpXdcF7CWyTA=
X-Proofpoint-GUID: gKixN3wQ3S8oU7suqJPHPDIrfpbovsOM
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58c5e6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cKKUN8DYBXwKWaGdE6wA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyMiBTYWx0ZWRfX6BtB3Ej9PK+Z
 /bFxJvPem6qpC9d5sww9UB9+gB0H1KkOgZM8O3N0izuliQNrndogx7Ia7zD6bjQ049TJ4SYH2/u
 5JqB1f0chJ3feIxNhwLC2/fU+vc2krK0xFBi3FyOMPhprVrO/oCmsm9QMnFl/2tczm2/4+BbMY6
 Isarb2sa8k2eopqgGBZdGMMQSnJxhYtfkzuz9mfK3KsXS9DfIO1OzMxKzxym22KakM4N4iiUbp8
 6HOZwmw50ZcW1C3Ew9amzSXuOZMr/RlVCy8FfQf/cB4FNjjlUFSu7YNumWuPwmTEjDz0inrs4Nz
 y7uUPrb+5Vsaig6vneUm3UKgUxjmVCcVSXs8lbGO9/qQAz/1ZOODYyIAMjCmgCnmBeUYW/0GYYI
 C4zX22B0b2UKEguOAyqTeXyyzF8d2JZaLVsCm4t6qkZBhfDDg2OJyJDrnwRzzKfKl3wmmo3XIDf
 DzPLYrDcF9EkDFEXCrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160122

Commit 16a03c71bba0 ("cpufreq: schedutil: Merge initialization code of
sg_cpu in single loop") merged the per-CPU initialization and the
utilization-hook registration into a single loop in sugov_start().

For a shared cpufreq policy this re-introduces the race originally fixed
by commit ab2f7cf141aa ("cpufreq: schedutil: Fix sugov_start() versus
sugov_update_shared() race").

The scheduler's util path reaches the hook under RCU-sched and never takes
policy->rwsem, so the rwsem held across sugov_start() cannot serialize the
two. Once the first CPU's hook is published, sugov_update_shared() may run
and, via sugov_next_freq_shared(), read/write each sibling sugov_cpu
(iowait_boost, util, bw_min, ...) concurrently with the memset() still
initializing them, with no lock common to both sides: the update side holds
sg_policy->update_lock while the init side holds only policy->rwsem, which
the scheduler's util path never takes.

The walk only accesses scalar members, never a pointer like ->sg_policy,
so it does not crash today; it merely uses stale (or zero on first start)
values that skew the frequency selection and tracepoints. It is still a
genuine data race, and a latent crash once any pointer member is
dereferenced there.

Restore the two-phase approach: initialize all per-CPU structures first,
and only then publish the per-CPU utilization update hooks.

Fixes: 16a03c71bba0 ("cpufreq: schedutil: Merge initialization code of sg_cpu in single loop")
Cc: stable@vger.kernel.org
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dc0835ceee98..6ad080de8644 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -872,8 +872,19 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
+	}
+
+	/*
+	 * Publish the hooks only after all per-CPU data is initialized, so a
+	 * shared policy's sugov_update_shared() never reads an uninitialized
+	 * sibling sugov_cpu.
+	 */
+	for_each_cpu(cpu, policy->cpus) {
+		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
+
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
+
 	return 0;
 }
 
-- 
2.43.0

