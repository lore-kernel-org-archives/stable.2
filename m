Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223C3B530A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733943; cv=none; b=HmqDntjDRypFPJzQt0s43TAuRmFVbloJJlT7Zm8PqF/kaQGaqooUiSoCkliSMKHWnXvM9ap4U85h6ZssJZEcf6CzWCGoDAuyO/+tDJRXnKkvxggIc1vN5IE2gD0UxT8FQae3N6VWy195iPNtBBkUx7UcSWpSSJAf+4L8VC55+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733943; c=relaxed/simple;
	bh=vXDgjawSY+x/jaFIMNIoJolaSacdUExIzHrcW9gSicQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gwjq+zCjqX7Wq/ioBzlIJkMG9FsDg8tOwdhOMNJprQ4h+j00A/V1wxUr5GwAWSTwue94a8JLr+jTTN0dhDAEoj9DMIY+QPBygY/4Nnz5cLrEbqePZ+JIjLkrasi8ufacxV1h67gDvWogRh68kBZw0Ehcko2KwDAmPZQKPspowng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B63peQqV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=USa1fN7t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B63peQqV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USa1fN7t"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RcUX3794504
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2/kVY45kFFvmt4/OmFH3Sfmb2hAQIhCwou1
	/OEh8Zyo=; b=B63peQqVOKA2eGEINh8+3hjQIscOzshtXKATM60vvo7L3RrqtMI
	iA0NgXUy43PjA+0LBMCjsXPX5MqY5wjt9tBTptD9OPRIOZlEc4R6AuV4DuivQ0/g
	43WYhf58/OYd5YnotHVTXChGgJACW25XgWLAklVcR0VaETzd7JIt0TbeAgwsfPQf
	SxhAhoPG2+WmYyGYNKDHMI0uwHcuyX/q+srSJG6fHmg2q1bYHLwYGrRaxXr1Uahh
	jm80rJDN+BLFBG5NUy9QvYM+VQNk4giJUkCjLI7eS1OMwNcC5aci7qRAb1k+ms+X
	qQ0p1cZUhpnAo4am43+wPUGaXZlZoYccjcA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx8w1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:45:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d30035dso4907921cf.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787733940; x=1788338740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/kVY45kFFvmt4/OmFH3Sfmb2hAQIhCwou1/OEh8Zyo=;
        b=USa1fN7tMzGw4GUy8JafgPwFcycPUllaDkWidfVujyK0AlEqs8zxYaTjOLiCaMZh9e
         m/N/VwErBTs3VcZJnmI8+mhwtPnRj7AaWng6XIdy2Ya9wsXvPWHrPztmsX1qTSoFc5H7
         KXNffDgc2PKAUHp+QbtU7KjxE710hr+zkxQHjKzZVZkG1+JLA+ZTgd9Df45sQPAdrH7O
         N39x/ZBI82By7GOte8Ismzb1QvzwSlAJp3+JH2Humf6DBJ1SpJZmeOWYg9lWjR1RLwpe
         u0dfXAcvQjXdC5X07ldUPUxF8bmHKbodMxo4m68Z4MFsu7GHU7E2tEg86cF+qfTywaZL
         9gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733940; x=1788338740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/kVY45kFFvmt4/OmFH3Sfmb2hAQIhCwou1/OEh8Zyo=;
        b=cBLc++fxH04KXpaJCF3nCRfGaDije0wD+h7BC0sY1o2sgh1kkYKFkmr/FzuKk2NnuN
         mfCzwXpUPU+ZZlemHrv8rHZdcBmZ+ef9yQtzp18AlKHQBCUInr3Ugn1t0kl6q4gsMqWx
         tOkuVgkWXunwxHJowJrySdEbUpNlgS11ObCZRJ9Mr34MkC+WDHzHbxQ5/kwUMYUNm96R
         pse+IMtNHFTcOAbNR8VWguo0rCKF3BtX5gBCA5QUzfwgE1SUKp1ib5n+/aXP9XLWdY47
         QgDMl47fK5cxuIuJSFZmOi7E1tCdws+1Y5MXh49Hvm2dWdoFeig6zsXfEZKuT78PxLML
         CeVw==
X-Forwarded-Encrypted: i=1; AHgh+RqBAVgMwNmI2lnnMz/Q5C+rHnyFPB5RKN2JyMF0R32lLdbA+qwZl9zlFFwL2n+iIqiK3Oq4oUw=@vger.kernel.org
X-Gm-Message-State: AFuF++nPthlRrey1pf2crXuFqVEXDkaCE9rvItsMgdeu7RAV7w9p6kmc
	hXe0N+zd5d5Dl/xV8PlBEgEH/OE+PCOIIvbnz1PchbMzeiBoNW+7xxYdRD6JutTKduWX/debo1k
	tgUN0YVRsMQe7a2rs1JCqtG3n0Z1hJ8elq4x1Vkksi9ufkBwZIZJQL5TD+4g=
X-Gm-Gg: AR+sD11StCg0Q+i1aPJw/1FsS1mM5mGCrorBzxQAo0v4CnjulkPWQ8xD37n0kpoh3H+
	/O1B9iSkrJm+zJypWmqImaAKpkHuKEBD3av9Dmj5xgvsqDfm1eONGyrbOOjXNvgNWsq4h0V6Ira
	8KhO1rCCm2V8+L/RWdE+Coll5nEU/lbpuJYbxwTRKAKwxhUjWKOH8+D0zAzQR7No4I0028el1G+
	eW+mSs75sXSOm2wNrS4S4OYjBxRxh4pUAG2v4RAYrod1OH/YaMV3i/t3TwOzVfc+LdNNl5QsG4I
	23Fd01S8xcYdfymXOyyWC3E97r7hKimk5LMi6/FXd/yG8akkWDYvLXOnHJYC1zVohl9bmf1DN0i
	LiG8t2GOuJsHhSdtbncQ=
X-Received: by 2002:ac8:6107:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-52e422f3887mr49750221cf.19.1787733940495;
        Wed, 26 Aug 2026 01:45:40 -0700 (PDT)
X-Received: by 2002:ac8:6107:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-52e422f3887mr49749741cf.19.1787733940055;
        Wed, 26 Aug 2026 01:45:40 -0700 (PDT)
Received: from uffe-tuxpro14.. ([2a02:1406:25a:ca5e:abe3:6901:a5de:f02d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef996sm459088866b.62.2026.08.26.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:45:39 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH] cpuidle: psci: Fix support for probe deferral by dropping the faux device
Date: Wed, 26 Aug 2026 10:45:32 +0200
Message-ID: <20260826084533.38960-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8ea7b5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=mNtU--nUWWSV7jGK8nsA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: yk5N6Gur2LZDH6LsMM0qa2rKDlhXVepf
X-Proofpoint-ORIG-GUID: yk5N6Gur2LZDH6LsMM0qa2rKDlhXVepf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3MSBTYWx0ZWRfXy7NUySpmnFT2
 Ss/kVWVgIW+06da63C/SiqEkFgPBcXreLDzY0Q7x0dfbaS817D1FYlBC2HYabkrxd32Nx+/yApg
 sTM+w9BjC9ZXVNCZi6rNSUYRUuGPGmcfQ0Sr1gD/s2zK8FtyolO3JMvagnLRvBUO8EFFOVdgKrW
 lY8ASahKTk8JoMkPGYQXCg6fdJg37CJevsRtYPesEsHbFc0f6I4pfvpOZJUEgF2d6r/7tJfQ5Ys
 ZgBLSjH+bfKVUl/CqypC6kMr7cYU+SpBZSh/1SdbNGZXQMlVzpDtIW/8oa9bbD++n9QIDZZ4wMP
 iR5rm+Kja2qeKMlm6iqxcCvccu6zv0BzkSl9PyWtzx1NuEvQqUkIyTBaSaA9Ok6ROrvaFWPSrIU
 bEleUxUg/Ei8SooafuWJ7NKpO0InBS34k7NqGMkzvz0yokO/HX9W8vN9+OWFSy33/LultES0Eqx
 z6uIgJ8hPeGuCJW3ORg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3MSBTYWx0ZWRfX5SAr3Q4T5tBx
 oKEI3j/aSkKBk+j6YC0c4LQlzwtVMRuf1XKgcCh1X4nVFNMI1RuJGpvIt3c3J439T6pIDnwhJ/Z
 stuEMSfrKzIYaaQ9Riozl5IK+LvlqII=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260071

From: Ulf Hansson <ulfh@kernel.org>

At the conversion to the faux driver/device we broke the support for probe
deferral. In hindsight, the move to the faux device seems questionable, as
it simply makes the code more complicated and for no good reason.

To fix the support for the probe deferral let's therefore restore the old
code and drop the faux device.

Fixes: af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
Fixes: 5836ebeb4a2b ("cpuidle: psci: Avoid initializing faux device if no DT idle states are present")
Fixes: 39cdf87a97fd ("cpuidle: psci: Fix uninitialized variable in dt_idle_state_present()")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 drivers/cpuidle/cpuidle-psci.c | 42 +++++++++++++---------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index dcf20ea5ef5e..b250d0dde760 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/device/faux.h>
+#include <linux/platform_device.h>
 #include <linux/psci.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -428,14 +428,14 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
  * to register cpuidle driver then rollback to cancel all CPUs
  * registration.
  */
-static int psci_cpuidle_probe(struct faux_device *fdev)
+static int psci_cpuidle_probe(struct platform_device *pdev)
 {
 	int cpu, ret;
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
 
 	for_each_present_cpu(cpu) {
-		ret = psci_idle_init_cpu(&fdev->dev, cpu);
+		ret = psci_idle_init_cpu(&pdev->dev, cpu);
 		if (ret)
 			goto out_fail;
 	}
@@ -455,36 +455,26 @@ static int psci_cpuidle_probe(struct faux_device *fdev)
 	return ret;
 }
 
-static struct faux_device_ops psci_cpuidle_ops = {
+static struct platform_driver psci_cpuidle_driver = {
 	.probe = psci_cpuidle_probe,
+	.driver = {
+		.name = "psci-cpuidle",
+	},
 };
 
-static bool __init dt_idle_state_present(void)
-{
-	struct device_node *cpu_node __free(device_node) =
-			of_cpu_device_node_get(cpumask_first(cpu_possible_mask));
-	if (!cpu_node)
-		return false;
-
-	struct device_node *state_node __free(device_node) =
-			of_get_cpu_state_node(cpu_node, 0);
-	if (!state_node)
-		return false;
-
-	return !!of_match_node(psci_idle_state_match, state_node);
-}
-
 static int __init psci_idle_init(void)
 {
-	struct faux_device *fdev;
+	struct platform_device *pdev;
+	int ret;
 
-	if (!dt_idle_state_present())
-		return 0;
+	ret = platform_driver_register(&psci_cpuidle_driver);
+	if (ret)
+		return ret;
 
-	fdev = faux_device_create("psci-cpuidle", NULL, &psci_cpuidle_ops);
-	if (!fdev) {
-		pr_err("Failed to create psci-cpuidle device\n");
-		return -ENODEV;
+	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&psci_cpuidle_driver);
+		return PTR_ERR(pdev);
 	}
 
 	return 0;
-- 
2.43.0

