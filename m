Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885908;
	b=uxU/NO7g9RWC51NCwf4Vu/fhPF6wckDIKG1pEvytTttdcsDYevA8O6BW8zvMhnmVTepx
	 qIylxKXvduu85cH4TVLFIS05UUo45+E0DojsSgn71MHSeM1pnDwJyYuC/Lvry8g3TJQyt
	 ps1Z7x4U/0FuJ098dzt+15oJKVqb40415XkiqzxCIawpW+a4iDNgdzSOEM3pVHCcDG/LZ
	 5Yj5nX/Xh0UGw3jpKPCmrqr21/7HqfmirUxbvcDX7lbH4IULsLRNKoY72Ipakw33gg+tC
	 BpdtGZqDYEdWxo2FCZErCAgFMB3Hhw2/clnwzTkZlxnNCu1dQ5utyLtSPcCrTG0jJfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885908;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wgo56krwWP6+nuckTvIM2kU9owPJ0evgUp5Ov0Hc770=;
	b=h9poGl6iwSYFqbsl2HSYp7fcr+pBsB9GguSs4XgR6aHO4pu7rCW6LkD1BcKhnmdy4YaA
	 dbjjRhKyfsT9UVcUH46JGQJvM1aLRrgV3hHSVAIDw+IJZ/fqVUyjlIJYF+t9gbIynutke
	 lsDaELO4+Q40ZA3Obf6Q9zHnWk6X3BleglbODbwTA+LwqF4bRnnBCPycRRXd3b4fHye9T
	 i96VZbXQ0TW9o3jSWe3xXQGSdvJapUVL1bMS3tg/WsNU8Wi6MEksJYEBG+n6Ng5scAHKe
	 C6ybaty3CRjSUy08S3Xq7w+m9qxVxvEZDw8Di4pxeD8M1yH52jc4bVqByTmxsNHfinw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ST7MwXAn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFOygiF9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EA606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ST7MwXAn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFOygiF9
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tGwI444517
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 13:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wgo56krwWP6+nuckTvIM2kU9owPJ0evgUp5
	Ov0Hc770=; b=ST7MwXAnA/4NnC5vKPvD6Ob8cVn5zxekMF7POKc4eTiAwkVOp3q
	3bXqI6a+OgV/S60mICBcBT0rOW4MdpnpUA0DKqVEm5WgPAe6Tx1INiaMnavgyaqI
	Dd+gwhIvnzou4YJ3pU7KD2HemD8/wjaGRD8radM5/xWdcEfaw9EKy+xLgOmOvHit
	QEzbCyi7q1tlA8PWKuMK0HSD4duYcD4st/f3UUZZd/nTblJW9Mfqnhz9Tim21Mmy
	03B9Chas59l8Xth+yB5A1V/ItyecZeZE4ahOT4sUPJYbyisl4cEFO7JX/cVlyKXv
	VahmZan4CVwBOx71DCH35EaSnJyl62Bse3A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaah8vm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:38:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so2249013a12.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885905; x=1794490705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgo56krwWP6+nuckTvIM2kU9owPJ0evgUp5Ov0Hc770=;
        b=ZFOygiF9tU6L817rlGvKuDlpS9OFlrOEPm41jruyRqITfJEcjS3U99Kq4paeXB+elC
         IZHjTJNibNpO0WKjClffzf7U4IfktvT0UQ7HsadbP9X77cVc49FljN0/ksbRqDn4gqYp
         nwVbYY7k0paGfKqILF9V/llwquU7rEZ/qav/pAgUQ6gDDEiQYLsPEtbfWt7yi5WChOyW
         pO/hYBGiKzJAphuHXfBmzx3WIxdfQYz6G+c5Dyp0oitPjPGzrGXawVX80Uo3t0qN+o2h
         IQoHH3xHaJElAvl8ozAMoROawBtkREk7PgoDVv2aBGig52Gr66innr3k61TtdgfkjU3d
         RX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885905; x=1794490705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgo56krwWP6+nuckTvIM2kU9owPJ0evgUp5Ov0Hc770=;
        b=EilSlCAfMHffe3zgjJoU7TC1XpK5cc4AAPaXZPsyEWeLT3xOfod1IFCuj9rB7j2rjo
         KRZr1BoH81yKMhVhXvmaTFLEO9kMYYsKyJo9EQSsSpmpZq2MLO5SIKnqyOrJxvE3jw69
         jLE/ReECoKatZDri+ToPQbO6ZLTf6/c73aTpofUmyL2Ici1MG2JfJ4qD5g6ENg24/4H2
         281h/rJyfMhHbgmM8OstiAvXUfhwhdrUQxkDjYDIWUZhlN0pc+v8a2ym9+1PIbDkfPve
         /E1wBQ/ovnXXg/hl8UTRqSI1odplEw6bXpTH+4A08TuxMXZfzuZxmTXTh40iVsk4y72J
         0KUQ==
X-Gm-Message-State: APuU4Z+l/0lgh8dolhWnG06mS/Dx8vOWtcLOJJveeJ+I2mmPicnc8YmL
	5kxXr3K/aSn/ZzcWvP7pT3GXDlaXv2Rju5IbXXsnsBMwRIJLcgHusTseSmtHA0W1wVEtadtpfJH
	f1ry8WMc3UOnQ8RoPEdgPCjh2nhMtbncxIN3bGOuJbFRQ7/Va8NsL4uU9tBX4Vsh3+vg=
X-Gm-Gg: AYBFou1iLyuq+pWeuymVfBTiY4nyzdzBtE/69uknFEMO9aK6s8VLW6a5FIWFL6ct8AN
	/1cnvOu2BsPcR8WqaBsTYMnCVOJUvOTY2jaflXh6ElRXCXlk114Y11Nz+R6/QMmH/iXK5mQuXj+
	Jim4WLDozjaD2KynJgayZIUfAH0DHtgPOtFnzwkb2x7HKrw3wi3FjzWu2Lw6fMlR6TEvsBBl+OB
	2gKPicOPFnXrCUPHrhxmz2wC/TUxf21+TqGIXsfOF+PsDgVfY+AbPVakJ8gbl8qwjYRxePiVPrk
	NCPX3OQisREV0v5wIZiMfpAjNUPyS5ekCXscrGjkBAUaz4EXgIlHt+foGf6CZLnpSqZjii42hKa
	fgmVKKtKSmWCNbXraG24Quk7MJRFN6C3rIZmR3U8WUGF3EdmMkWirznfz31lI8AJJtpkn0d2fXD
	FFxI+9tk+ZuGUYqHgJFL1eQCLC6qj61pLEZr+seHk=
X-Received: by 2002:a05:6a21:7309:b0:3e8:b7fd:6266 with SMTP id adf61e73a8af0-3e9289cf9c5mr17688542637.42.1793885905074;
        Thu, 05 Nov 2026 05:38:25 -0800 (PST)
X-Received: by 2002:a05:6a21:7309:b0:3e8:b7fd:6266 with SMTP id adf61e73a8af0-3e9289cf9c5mr17688522637.42.1793885904487;
        Thu, 05 Nov 2026 05:38:24 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4694a0e0sm2341480a12.20.2026.11.05.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:38:24 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: zhongqiu.han@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: [PATCH] cpufreq: Only cache resolved frequency in cpufreq_driver_resolve_freq()
Date: Thu,  5 Nov 2026 21:38:21 +0800
Message-ID: <20261105133821.1251727-1-zhongqiu.han@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX8oD1wgabog0H
 hjLe/WEOoiuLQP7Qqp/sQ260Lg/YTy0cdjxZMmOQJeUm8Z20zYqjvT/gg7wIeLichn7gppM0XKN
 XmwKn69rA2Fwtz+3zD64RdQAJCsal6UUlmomOtjH/fwAV5adKl6PdNfFaomQM3h5ygzzEHGkjFP
 ryGcp0Jc/fv+Vn7JIs006sQzROA1KU8hmtFlqvSTWmHyCSMaoLSobe7vkRu9PLWB0dj/gbntRy6
 YUCaGHGjmkk74fgBQp7rYUahR+xJ+2rBmtkJ5UViTo6rDIbeuKguQaGKkR0RARe+TOjXWnzwU63
 MtF6XUGEo5YFxZSkMW/t1I7hQNP9NMglF2hElsr9PtaS3jdSYYsga0ezicIqb5qmlfra67b76oY
 xvvfvsWzIR/rdRdQ6vflASX+/Jm1EVPP/eP/vg1DmsMaXiyBm6IZTIsv/j++QMub52gDI3cgTtH
 6FkcELKAT3Z0mLqxvXg==
X-Proofpoint-GUID: rMQ-XwUJiDkqrMVCPWxJ_QNv7BlCVTy9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX36mkXeefZAPY
 iB+WcvlVX4xrcOZ6uWqyuTtajZIMFtVqwwB3l5ZOTPvfU3PcZr79l8pKGnW9losOnjbchgqzEI/
 Lzy7j0yW4Ob3NNCoKg7JKl7cSEe/LwU=
X-Proofpoint-ORIG-GUID: rMQ-XwUJiDkqrMVCPWxJ_QNv7BlCVTy9
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec86d2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZLhjMWIiCFWLY5ZuiNwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050054

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
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
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

