Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887444;
	b=QuKaveMJHXJ03Jlt6S1XE0ctBb15GPve1KjpLYn8v8cr5I1U0yzFNV+DhRMNz12FnjLQ
	 oD5iXxV9HhwgCHPuHTJLQLDW6ovv5QKt/tWxyViZBA0oZ638CfN6SCYGnuaS+viv59f62
	 KJEIp33ySi1j5PEnqD3kiv53bDlUsS05tXeXkr+XH0VnunzHnJsUCwIDGnQEBxJBOx7DI
	 zGBvzMhnUUrFsBalcgvaEbkYckHi0JFqIeuu0/omeRMpfzitmmDaWcc27xpffrTGQFyf9
	 SkQbbyuMoO7Ko6HsbtINU7btZZq/jKaXV5cZaCohGNTwvWr3E2pw9gW3r3wVVhOBuRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887444;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=g7Ypoc7bTw0h79WXpS8bGOQQwHQOyWiNmH6kpqMLaqU=;
	b=KmKXgCuKoClRaiudGUGKPDqtunVriMUlcLO/GtjCZFHLYrDRRQlxaJra3MbX87tvrY+e
	 iD114JNEgO7tdEQFNLrN1C4EgiNsHVM8uxMsSv3makspMKsJ+d5zzTrYLkc8Hhnn6yPJJ
	 co6U/swzphehjjYVN08t6RN7QTr2EWi1PWui59V+ZMgGzmWtHb63oaxXlyYN65tAfmoVQ
	 fuDdCCj99RcD1d8yWV5IU5kGUg7I127vqmCusK+Oltmlm0noEnw84c3TIXukHCoyfcGuf
	 OiAVsaMKnnBlmFJE6EpqfN9tgvWJR+q6OtWDqheAIUXCwUO0qF0FQ5J8RuoGq8vw22Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Ht6fAH/S";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UG4HHbC1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46475606A32F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46475606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ht6fAH/S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UG4HHbC1
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tKaY444546
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 14:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=g7Ypoc7bTw0h79WXpS8bGOQQwHQOyWiNmH6
	kpqMLaqU=; b=Ht6fAH/Su4tQ8Ct6j22wwfjFMWgAWfYbFJZoox1DsX/f/DsZHhM
	z8MIA92pZZJI5N2mRtMNTd37pbTDvv9cc6PGjA2BJ9SSXWjnErdEdPyQlW6Z7WV9
	jVB2oReIPNaq4eW4ZSNtVqgReOCh1PMb7f0cDIZrdmLMefOZvf0/Um1N0uIvF9WP
	xCFHCJiNaSs1Bot+8SE+L5YubLHsGkF5BhwByh8tciiA723xEk5ObSHONjCWWBUu
	sO67XpNVSXJe/u+8AAi+HTl7cbq2q5gUW30yebBm7MbdioBE9GZfX2f8hKEloQkG
	GCtCu4JTi1Mzxi3/UY0wMTt2/xgAaBjqu6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaahbw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:04:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so2315317b3a.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793887442; x=1794492242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7Ypoc7bTw0h79WXpS8bGOQQwHQOyWiNmH6kpqMLaqU=;
        b=UG4HHbC1RC8Z5EMPdQww32czF0qa+6Wrx2CdwgAa/QKvrm2wn7/Q1g3RyGJH0ItPBI
         fPTY5kQRlKutAVwSNWWEMzUKbSwahsBkoejLZVlSAwqDotKf55gI+dLtVi13NsIXYBBi
         fnqtMhiB7Rq7J09Ln7FN3yKJ4x9+WJNIouW/G7+md7ruAMRhNAGrIkPjQXcvdnSZAgY/
         qt7YHYZzkuM1rXUAQr61dE8RBdX+ALm7ikNLg/yoWzOhScGsfy+sEA5yp+G/Av6RkNmu
         o67ugupAsvQwkgBP1n4z2XZ27Oij/4ZTyBq4udzuYGPfCarOGM2iiDpryruCn0Fvmycb
         Z8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887442; x=1794492242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7Ypoc7bTw0h79WXpS8bGOQQwHQOyWiNmH6kpqMLaqU=;
        b=UtDxpTQ4G5IcFh1DybKrqPftMMtZbmmCtREOz5d4pZt2ujMt+z2sEyKpOn9QN1xBRQ
         6kLFRwQZzkJmSZ9PRXF95n2afO6wDczYSGmhFx+SrJ20FFJFf4Xy3X3eKgks8pDDS4Yn
         4V4z0+AaYIHHQXsD2Y/+Qcn53rZwx/zcyGdV/vzG5fEghdTDfeGnMk0yz+yuLSlzFa33
         atQpJC6nEwkSm/3rK61wKV9bc30u2MBBVkGze0xeRi9TMlqW64L3+C7vBPzKn7iWxBXa
         odCOqJiSmW9WQfhAT9ow5EVJCtyn+26xsh+QAbNsfW7MBAkrkOIoqDFw1ahIrIynnrs/
         TflQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0sKdmgZjMdMpW2XIxc+CU3UX8pErVgFDjh07C1V02RGqzzeie/4VjMulB4WeEwONmMdh//5k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m1CNvOmhhXu0BonT64FYlpL61yXtV/XLnCMFRKBHxWrqybhxF
	koPEawgFZxfyMee5ZLNbsrQBZXYLFKx+ZbxVprdugOy5gb51LaI1iTPfrKjnkF5giRXwZvyMXU+
	KDuuvPG3+BfEjZqDFCDhHct5jtaoieRDdLHl5zwQvYeVwXd+SU2P0eo2eD/s=
X-Gm-Gg: AYBFou0+58tknUkt9aCfMCKG+JD4mFkMv91I76/FIAMqa/33xglzSKDx2a0w14LTush
	kvF3W6E6E+PPhEbGgbXEdDn0dL5uI44cChsUnBnmIAJNypTUDFP+RrSnLhxmnFbruWW5c4UPVk/
	19gamyffBqr3oabbl1DhekOg3dobRyqi8jAwZnlBkvvrqF6aFxkqvG4Sz+MbFL1Xes3RM61Oqdv
	UE7GuGANqEgEgBrDWgM5Uv+5q8bGnMNMDqk6nXHSMgLEWTuVBeaB5D/DYK8gh2lVxsdsmZ28P8P
	x54iPcU35z70IwwaENSKULORrnyuOxhU6MRWAHjRjV8ltuWFuTWL7C18Gs3ziVNMgRAM0WUUyxJ
	GffcbPywHqsRUP33Iq13Rzc1KWf/gw3XIYo86VClNTBcs7aW48X1g3MRUezMzKkVBaT8AxYHPwC
	pVta/ITv1Bhu9qvv1g3XaavmFZ1mMkUVIMp24d2iV2
X-Received: by 2002:a05:6a20:6a10:b0:3e2:9b5:b16e with SMTP id adf61e73a8af0-3e928a7a8f6mr17299115637.7.1793887442017;
        Thu, 05 Nov 2026 06:04:02 -0800 (PST)
X-Received: by 2002:a05:6a20:6a10:b0:3e2:9b5:b16e with SMTP id adf61e73a8af0-3e928a7a8f6mr17299071637.7.1793887441433;
        Thu, 05 Nov 2026 06:04:01 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691f520sm2241031a12.13.2026.11.05.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:04:01 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, vincent.donnefort@arm.com
Cc: linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: Only cache resolved frequency in cpufreq_driver_resolve_freq()
Date: Thu,  5 Nov 2026 22:03:57 +0800
Message-ID: <20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NSBTYWx0ZWRfX7IfLf2A88Lrj
 5bohVD+/1+4t03Tz5VsvN4cPod33dngMJproHCeMiMD6AHC/VFX172U7PzGNLWgS4d+fBuR4+73
 X7STjGBgO59qc5aebuWO90uNRbaeQtW75ITIls7IE3nV/RjRZA8IbWhKNgQdK7wuSHIrWerMv63
 SRTuRbeOY9UgG95p9OrG9ewHVGsXnGca9pglLnlZ2tGH89O8JNtMRSoM4sFdJrk8sBHxpLT4aMH
 UPcQpGsfI7zQa+fZ2lpNm8IzeYlpjnNNIYTtFwHf4g807YfSWYt8x/6zstgXtunP284k/QPdOF+
 Z3K+dzpSg+AsLbFQFFYVm9DYhX4IZeE5GlzEI43O3HKd27U29wrR7jfIW7mkl1VJGOjNaZFdU+3
 C5V6sGodvbGzjcn96XXhGO60bjhH0mgxLSk1Dv+/NIFshNgO09nSm5ceWBXWMRDbAoBl374toNB
 jddC4eQ4OFd4jbKS4ZQ==
X-Proofpoint-GUID: 6tzbvZO6T0TwzBDS5fibrd7nZGcp3jcr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NSBTYWx0ZWRfX/sCDFUXgdOTF
 qFyf4pqXA52F1hbNpe5cS5+DK8z1jZrBkgIt8DBDhWXqa2s5Gkp3NYIJQ2rAjtDLEXkoKGrgpma
 Y8i2+XmcydL2tDoTlStc4qlCVSpeiOU=
X-Proofpoint-ORIG-GUID: 6tzbvZO6T0TwzBDS5fibrd7nZGcp3jcr
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec8cd3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ms24wCUOMMaWQVvSF_YA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050055

Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") added
policy->cached_resolved_idx so that "a subsequent fast_switch operation
can avoid repeating the same lookup", and made cpufreq_set_policy()
invalidate the cache instead of filling it. That is, the cached index is
only meant to be used by the frequency switch immediately following the
resolution that has produced it.

However, two other places now access the cache without synchronizing
with its other users:

 * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq()
   in __cpufreq_driver_target()"), __cpufreq_driver_target() reads the
   resolved index back from the cache before calling ->target_index().
   sugov_work() calls it without sg_policy->update_lock, so the scheduler
   path (a tick on the policy CPU or a remote update) can overwrite the
   index via cpufreq_driver_resolve_freq() meanwhile. This matters when
   sugov_hold_freq() discards the lower frequency resolved there, leaving
   the CPU below the frequency schedutil has kept for it.

  CPU0 (sugov_work())                  CPU0 (tick interrupt)
  __cpufreq_driver_target(f_i)
    __resolve_freq()
      cached_resolved_idx = i
                                       sugov_update_single_freq()
                                         get_next_freq()
                                           cpufreq_driver_resolve_freq(f_k)
                                             cached_resolved_idx = k
    __target_index(cached_resolved_idx)
      ->target_index(policy, k)

 * Since commit 151717690694 ("cpufreq: Make policy min/max hard
   requirements"), cpufreq_set_policy() updates the cache as a side effect
   of __resolve_freq(), which can race with governors switching frequencies
   without policy->rwsem (schedutil, ondemand, conservative), and a similar
   race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
   inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
   apple-soc-cpufreq ->fast_switch() read the cached index directly too.

  CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem held)
  __cpufreq_driver_target(f_i)
    __resolve_freq()
      cached_resolved_idx = i
                                       cpufreq_set_policy()
                                         __resolve_freq(min)
                                           cached_resolved_idx = j_min
    __target_index(cached_resolved_idx)
      ->target_index(policy, j_min)

In both cases, schedutil does not call the driver again until its
selection changes, so the CPU can get stuck at a frequency it has not
selected. All drivers implementing ->target_index() are affected.

The cache is only consumed by ->fast_switch() right after
cpufreq_driver_resolve_freq(), so only update it there and use a local
index in __cpufreq_driver_target().

Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
v1 -> v2:
- Initialize idx in __cpufreq_driver_target() to avoid a
  -Wmaybe-uninitialized warning with W=2, as reported by Sashiko.
- Link to V1: https://lore.kernel.org/all/20261104153042.3987338-1-zhongqiu.han@oss.qualcomm.com/

 drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..68009918e80a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
+/*
+ * Note that this does not update the cached frequency lookup in @policy,
+ * because it may be running in parallel with a frequency switch carried out by
+ * the governor that uses the cached index.  If @resolved_idx is not NULL, the
+ * index of the resolved frequency in the frequency table is stored in the
+ * location pointed to by it instead.
+ */
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *resolved_idx)
 {
 	unsigned int idx;
 
@@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
-	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = target_freq;
+	if (resolved_idx)
+		*resolved_idx = idx;
 	return policy->freq_table[idx].frequency;
 }
 
@@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 {
 	unsigned int min = READ_ONCE(policy->min);
 	unsigned int max = READ_ONCE(policy->max);
+	unsigned int freq, idx;
 
 	/*
 	 * If this function runs in parallel with cpufreq_set_policy(), it may
@@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	target_freq = clamp_val(target_freq, min, max);
+	freq = __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE,
+			      &idx);
+
+	/*
+	 * Cache the lookup result for the subsequent ->fast_switch() call, which
+	 * is the only user of it.
+	 */
+	if (policy->freq_table) {
+		policy->cached_resolved_idx = idx;
+		policy->cached_target_freq = target_freq;
+	}
+
+	return freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2355,12 +2376,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int idx = 0;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
 	target_freq = __resolve_freq(policy, target_freq, policy->min,
-				     policy->max, relation);
+				     policy->max, relation, &idx);
 
 	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
@@ -2393,7 +2415,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2666,14 +2688,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
 	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_H);
+			      CPUFREQ_RELATION_H, NULL);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
 		policy->update_limits = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_L);
+			      CPUFREQ_RELATION_L, NULL);
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-- 
2.43.0

