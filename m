Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704903;
	b=4tNijpUibnJvBBYL1++Azeds3peQtAXZseTUzMlmHGzFaB0P25fPeGTeLcU2XmjlDlOx
	 CaPW5/eD/zWtFxz/Ne70PDm1gIhjPlfCzB/0HKU3j3PNn3bp2Hj2t5jOeqnI80L1qIb8c
	 GJnx6ae8xBE03FP1FuPw5jJlN/kvDDQN9AwRATz/2FV1k3IYK+yqQ88pKPiLW7TDqE9OC
	 k6uixUjgjRYkCGu4/TNiglqf4DoyAFGDvsDch5k6tAioAzJYfeccFS11Ji27cgt4wAC4W
	 U6yX2OGD7R36L2nrGOssY1AHO2S2/uCff0B5AWpCI01p4AeQZp31ZOO77wVKSyXrSMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704903;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Change-ID:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aSwLV1CBcuXDV7sv0OALbaamU2BuWrR2qGPK92B099k=;
	b=YwQ6NsVNyInm8y2REsv8mGG/TYt/QuLwlqrjfFNXWdqa7euKhmhndvBvPHetnEyq/peC
	 IWiK/z9ha+0ugI4b4Nx6V5VHFQfFqSbRJhnKiAjtSJUS10tU4wj9Xh1raaEG2Dnzzx+9I
	 vDfQ8cF1DBZNvvP/PGPPN3YBindViPiXaggpuW53oI9CMnMMdjeCSWfgg5RP4ZZZHD8oT
	 9hm6vzdqk0P1jKRbFemOatbJqJiBWc2L4+VTvCaweN2GYGvHPgcl28bOSQnfXo6E94dxF
	 Xf4EYfaNm1yjEL23ObkDhhy/qtY3BLbfnZ3m4Y0bukpnhnTugcRqmH4RzHK1b1D/tIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P+1cc2w8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PnXW6+U0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89106606A838
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89106606A838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P+1cc2w8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PnXW6+U0
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAPlr2555060
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 11:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aSwLV1CBcuXDV7sv0OALba
	amU2BuWrR2qGPK92B099k=; b=P+1cc2w8oJC3yzQgPPiOqHDtK7+2IhP2qRDRGz
	S9kjt62s7L+Asd8laUMgzkWuhZkN6p6mQk0SvKq7Qr5mx7k2XP8B9OUw5BihXeDC
	XvB+cgBJA4dWljoUDfd7Aw/esJIw9p/CG4t2kdI6lQXfv3fqU3hmZbNecT0hw55R
	8gNmLOdbV+4Kkf4nAfg4fTWPOE4CuuoU2wqiHPTxS2g3bTvtBsFWYle+Xh+oknPC
	xL09gWMxwPTJ3jzyxclbO1YJAr60mFLflYTIJsFDKLN9GjFycf2zSZeLzIcW0aHK
	RNdxa5FGr3cHupXZ83lsuugz+SBEz3qYk5vlErHuO8Z1OReQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acjvjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:21:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e987ec84afso33659755ad.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793704900; x=1794309700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSwLV1CBcuXDV7sv0OALbaamU2BuWrR2qGPK92B099k=;
        b=PnXW6+U0Cm8yWp9a39792Ai2IMyIiN23LmPSbsEQxOe7YRyQ3MIUck+KHh/9syB8jz
         1E7bhFc0g9CDCuiVd+y0ka9T2hTFJC9GOKLgGzaRlgLfvJo+qv7ch2zWqz57LOCFs4RK
         r9UMIb78MZBR3trW6rMJ1X4CDqvDQ+lJPC47Y5Rwri7Hok6Vl9KTHnU9YujavfrR0zyN
         8v31X3fMxNQGyYLroQC3GqPR1Idz4pM/l9VCHsOqM7JAwFBYshZFttEq/rO4Vd1MTTua
         rBCnbFY5pT6FxYnjeSPQb7RyuVtKP7LmtkPiN8J/rsanQh/dXdVEQEN75e64BWJ1E4cx
         xgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704900; x=1794309700;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSwLV1CBcuXDV7sv0OALbaamU2BuWrR2qGPK92B099k=;
        b=YJL3ekeTInw6A5ZLU4Y0s7LEqCIpmcJAPbBptG7KO7Ii9pRm68paWXwq4ub7Zmo/3G
         q9ffsiHL6fwcjSwHIVxVgImfzvzhhY7cqyw9MBlWUVFRAMWIp/OpPbKIk7K9HoEBoU1m
         igxpVLD4Da2zd2CeiiJ4XaHZZTnWTu9hOppYjLxc3uaMkaFKJP+5tGP4njiY9gfk2bqR
         wIaEQt4IWnUAc4NtSDlyhYiKrs6iQOCBBEuh53c0BVIHLcO8xxOxy96eZkn+BF/D7LlK
         HLNOaLoBz+qinXA4PUA+iAhWcNup9E1IeYDMOSoMW4agj88V9WrHMlxAAHpM2btGeIFb
         Dqjw==
X-Forwarded-Encrypted: i=1; AKwUvBzfEBItP5SGVmKXjR/gqbO8odEBgyQrtNEYRF2GEkGa+o+mqj8AP5KI5s2ENmVyFwf705mUIXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z89b4yfyEkws4tLpvCFq5UilZXxBCluclYYquSHrgymk4uWvMrR
	2yPLIwAJPIit+6nThKHf1DqdHxZngQ/A/ci7RKcFGlF++VksdFH+MDiiCb9Z3ieaELPS25Y498d
	s6WDK5ptwdXG9SAd0Y7QQba1toiKgbE0dr5giDUMpOVF+OFwhwZkr/D78rOE=
X-Gm-Gg: AYBFou2M6W3Rd8kI2AaCFW5aALAtdXsQRf+/Q1iZ1nmisCQXBsQzZ/b2jUiD027UWVa
	HEQ6FPKhqFGUg5ceJDV0vTHwv4O0ALlqkjV0lW88Ny8Y3tc1U2bNOfbGDn9UUMtGs5/ysJ4Fw60
	7Ub9iucjgB60DpU/G6CB94zyjFlY3ZIOfp8rUMhwAt1Ip+yFS/aFa3SUXt/H3XPOnr58N5rjh2o
	fmlb5i2tmWhpEsr8UtWSGlGxIqh/g2yzNX27n0wSq63tktzMDBofrQPkWCiSP3IiCDaeXKFruYV
	4Oxw5sVMZofl1U0InT8Vv+WU3v9g/Zv+1QsK4IkoWmbDQ9Zpy+mPKnM0GnH/fV8uzLkQfBHKP7H
	fQNKC2XVz/o0tZkfVNqE7kBdfXRNRP6NS79WwxamHr40Mu1H0O+zK8ONQI7tezc/iq4Sri2b9SK
	trATNx/KKLdlvdnT8O2tKNp5DqYWaa
X-Received: by 2002:a17:90b:224f:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3ae897c93d2mr10975159a91.23.1793704900264;
        Tue, 03 Nov 2026 03:21:40 -0800 (PST)
X-Received: by 2002:a17:90b:224f:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3ae897c93d2mr10975145a91.23.1793704899707;
        Tue, 03 Nov 2026 03:21:39 -0800 (PST)
Received: from QCOM-utBXLfHQRa.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm4135296a91.13.2026.11.03.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:21:39 -0800 (PST)
From: Guo Chen <guo.chen@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, xin.liu@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com
Subject: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency ranking
Date: Tue,  3 Nov 2026 19:21:28 +0800
Message-ID: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
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
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261029-em-rank-boost-separately-a7e7c7d78058
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9c3c5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EJyEkKy6ZwYBekfyMqcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX7snJJ4u4NNf3
 4FxvT3u4DuuP7PDgmFPZ32ye0qRSuNWr6AVcPfprVbXm8ivEbvIFxPVRgdFPJ+8Arym7la6dPzD
 WobCcHUObSuJ80Pz4OEteO7RCkCdsfoaDjT9xNMXYBSlViA4V6G+qGF0TTbXi0GFJWjZVIZq0Z3
 PZBmsG0vlY5x7cYbUsLgHFbXS1vFAVzf2zWNzacrCaQSIGxdHkIf0rBWTp564qxHo4Z0uFvrjgU
 TJC2fMt3k43lT0I+uS7W7J6fBG3IOE787rhy3uHdYjKdRwqYXiW96RTYZaf6YyorXkigLuI0mGY
 pBVCbaiMu3kgpcA11AcUmwaErBmfOf2dWFlgOowG5IyjQ+BrxvkjVPrHsgKZ5tDL6jLs9uj6gBz
 t0+ki/mMMPVnXMWl0cn1x+8yuW3uROWromfNvOy1ubAkX/rcgSwqh/6Y5z85qbXn1ZhIE6NPmQP
 eaTvb/jTFJU+Tknutjw==
X-Proofpoint-GUID: uo6MUZuMHBhYU0mOw8FKavgU87VTufHV
X-Proofpoint-ORIG-GUID: uo6MUZuMHBhYU0mOw8FKavgU87VTufHV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX3GmqrkAho06+
 b13Rf1ZcKNSxcxJB7Ya1PPAxcYQMnySpSo/rh6jOYD5OzhV9AeFhQr07gV69sCe1aX5ZxuudkOW
 boyK1SWXVwuVMU7MWoseh54dFg141hY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045

em_compute_costs() ranks all the frequencies of the table, boost ones
included. A non-boost frequency can be marked inefficient only because
a faster boost frequency has a lower or equal cost, e.g.

  3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)

With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
skipped by governors rounding down to efficient frequencies (e.g.
ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
the best selectable frequency. Several frequencies can be affected.

Exclude the boost frequencies from the ranking in em_compute_costs() and
keep them all efficient, using the highest non-boost frequency of the
CPUFreq table, returned by the new helper
cpufreq_table_max_nonboost_freq(), as the boundary.

Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
---
Changes in v2:
- Drop prev_boost and keep all boost states efficient by resetting
  prev_cost for them, as suggested by Lukasz. Boost states are no
  longer ranked against each other.
- Retitle the patch to match the new behaviour (was "Rank boost and
  non-boost frequencies separately") and reword the commit message.

Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com/
---
 include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
 kernel/power/energy_model.c | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..c93316141a11 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 	return -EINVAL;
 }
 
+static inline unsigned int
+cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int max = 0;
+
+	if (!policy->freq_table)
+		return 0;
+
+	/* The table may be unsorted, scan all of it for the highest one. */
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos->frequency > max)
+			max = pos->frequency;
+	}
+
+	return max;
+}
+
 static inline int parse_perf_domain(int cpu, const char *list_name,
 				    const char *cell_name,
 				    struct of_phandle_args *args)
@@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 	return -EINVAL;
 }
 
+static inline unsigned int
+cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
 static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
 						     const char *cell_name, struct cpumask *cpumask,
 						     struct of_phandle_args *pargs)
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d19a65461ae8..5b1d095fd376 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -255,15 +255,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    unsigned long flags)
 {
 	unsigned long prev_cost = ULONG_MAX;
+	struct cpufreq_policy *policy;
+	unsigned int max_nonboost = 0;
 	int i, ret;
 
 	/* This is needed only for CPUs and EAS skip other devices */
 	if (!_is_cpu_device(dev))
 		return 0;
 
+	policy = cpufreq_cpu_get(dev->id);
+	if (policy) {
+		max_nonboost = cpufreq_table_max_nonboost_freq(policy);
+		cpufreq_cpu_put(policy);
+	}
+
 	/* Compute the cost of each performance state. */
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
+		bool boost = max_nonboost && table[i].frequency > max_nonboost;
 
 		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);
@@ -284,6 +293,13 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			table[i].flags = EM_PERF_STATE_INEFFICIENT;
 			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
 				table[i].frequency);
+		} else if (boost) {
+			/*
+			 * Keep all boost states efficient. Resetting prev_cost
+			 * also keeps the highest non-boost state efficient,
+			 * then rank the rest on their own.
+			 */
+			prev_cost = ULONG_MAX;
 		} else {
 			prev_cost = table[i].cost;
 		}

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261029-em-rank-boost-separately-a7e7c7d78058

Best regards,
--  
Guo Chen <guo.chen@oss.qualcomm.com>
