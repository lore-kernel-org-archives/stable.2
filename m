Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AE1DFFD;
	Fri, 18 Sep 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715392; cv=none; b=FEsrJKgaVcH8UZ+vuUiP4LcIs6zxFbr2cbHSwnIVnXmr275NqqnX+F9EUIf2D15GEhoJJkWZdG08A5GBky9X2CfGqtyEyvMxb7tmvRTnB0kD6GwRl73BqKZMXk0GH9Z65YlN2wI68sqTbG5NuvBaRrr0KzxL5/9svu9LE4xR7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715392; c=relaxed/simple;
	bh=UZs2Rsco60WjYn3xcHhrRfZBIWacFhQyas2Wala4R9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6XfuICerMDq5/fTV1BnYJgAkAKfVqYK5JIRl6KqRorRR8HbQk8/qHsFzcjYx4XGBfNK+zavITzD82w1IWeG3tn/l06gRe4K0vE02kELwlILCvESj4KDkQZsJCUJ0+ooOWUvEPi5Omsbelvdtt1tqsadPObeVLqO5DvDnM3ZyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aUhuh6Ih; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aUhuh6Ih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789715318;
	bh=VoNPLwrfLGwJ1Joc3IIGCRT3MwFrlW7kjCI7cxYzVRc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aUhuh6IhMvP5WuO+FeFw74jCd8/BaoyKo0+vxlE6uOpag84Hfp0pYd4z9VITk8PIZ
	 kBeueXQjHAcLZcDsL2Kjw0KFFzxu0hved58/huPhhQDOOq/rhvmltbnLCZ1A0kTa9W
	 2I5OMcDakLTqWDNLBw4ZDyDGlG8O0UJ6Y8ctIhjM=
X-QQ-mid: esmtpgz10t1789715298t3f12930d
X-QQ-Originating-IP: F51MbfdSWsMFopoCOaRZlwUeG/ke3KRdncZEcs0zje0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 15:08:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6459385882852576826
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: kprateek.nayak@amd.com
Cc: guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	ray.huang@amd.com,
	ronforever@outlook.com,
	scardracs@disroot.org,
	stable@vger.kernel.org,
	superm1@kernel.org
Subject: [PATCH v2] cpufreq/amd-pstate: Skip auto_sel write when it already matches the mode
Date: Fri, 18 Sep 2026 15:08:14 +0800
Message-Id: <20260918070814.59582-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <748cb8d6-174c-4cad-98bc-ebb985e2eced@amd.com>
References: <748cb8d6-174c-4cad-98bc-ebb985e2eced@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MZgXmQBAUNskm3j0cVVKLfuWtexoC6bEyCjnJKvRPjysaMXnH/vXTzqK
	ny8Iauf1PXp3vG1TBIB7oyKO5Nz6+kpa4VyWSzzUNy7btwWTiLdfc7c2jwzkocvxirsQtFA
	FVhlf4sO3tVX4uBCA72kG0Tik9iC1c98QO2NbhlZtGAPCQTgYQiTu/yhXsRXbVjuexMSCt/
	kbiif0jjyEgPa/fwrIk3KfjqWUmFDAkL2h1VI9KmP34frVUpWJ5uqQwr4Y8k23f7cBOr1uF
	foS3PsMG5hCZdXIsD+HB0X+ln2gFLyAFKY/TIJxyh9Dov9GdH0GvRtLbS+UlN1lYUPtyc10
	wb4mPV6ejJ/WKtkU4SWFA+XrggPTLiXgM6igyOUNcVkvVMQupXfGpbkNRNAK2iEhdugjZFJ
	27p61Eh7mksbhMl4CmTQzpg2OySAtsM/9wUaxwSg8FkL791LFZnAEu9VrEFFf4TlmEo3UBt
	y71ef2D+39KeFA3/FKnphlZut4Xf9teQcZXiOiSlvBx6yYv9D4qcMhUwHUWj/f0vZgyUboE
	icisWdhgFzxEtGyu/no44Xga77ZnEtOWUDjsCZ/1LLDzMscwM2NUre1OAr/7lmZVOtd5IOe
	39zx1shnQLvatQatAHT2ocJsh7ZFpvywk8eZZ2QKvNsLMyAWjvQvb2eBInsJVIZeNqGpqFS
	2kv8Jfl18lQ0H3AIw5qR6G0ORVDHMP63+53QLBDslfjr38pW+pYnh9YR1Q05jtc+WUJBY3f
	JmaOMyKY3RB83hbQ6+3N1G0xiDu9o9PFA/j87AGEDY9xSaOiiVZMJr7s6FniMYGiN/ITk7i
	9tK2Z2rzxaxrk3LoVVCNRVole+XGyqdHULYCO9bptPZ0ve7YzVDHWCwHDhVQORSHR8LbNoB
	zIDCf1WWVscHjkk7PQXRssOHs68ksK/UyN1ooLNvj5Kz6GjTOdAin8HuIyzyaNKVhfrofJs
	5/ygg+XThcVlfrjMD6s/xzi9OlonowAgJsiefv/QnNC6AazooNIo3cMkjZcOWVOCwibaBST
	ZTxCNRqKfVc4xxRmc3kMyQh1geuPG7yZ6nYGDeI21KCogVK1ZVl4x2HX51FdLXqn0jL4i+n
	rFTvJojPXzP
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
mode on shared memory systems"), shmem_init_perf() programs
AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.

Platforms that exclusively support autonomous selection report this field
as an Integer of 1, as required by the ACPI specification, instead of as a
register descriptor.  cppc_get_reg_val() reads such a field back
successfully, but cppc_set_reg_val() rejects the write with -EOPNOTSUPP
because the entry is not an ACPI_TYPE_BUFFER.

shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
fails, cpufreq_register_driver() ends up with an empty policy list and
returns -ENODEV, and amd-pstate refuses to load at all:

  amd_pstate: failed to set auto_sel, ret: -95
  amd_pstate: Failed to initialize CPU 0: -95
  ...
  amd_pstate: failed to register with return -19

Skip the write when the register already holds the value the requested mode
needs.  Active and guided mode are fixed on these platforms, which report
auto_sel as 1, while passive mode still fails to load on a platform that
cannot disable autonomous selection, exactly as it did before the
offending commit.

Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
Cc: stable@vger.kernel.org
Tested-by: LFRon <ronforever@outlook.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
Accecpt and tested the K Prateek Nayak reviews.
v1 link:
https://lore.kernel.org/stable/20260918054808.48999-1-guanwentao@uniontech.com/#R
---
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3a6b4b224a66d..91ec44f9fbb96 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -535,6 +535,9 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 		return 0;
 	}
 
+	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
+		return 0;
+
 	ret = cppc_set_auto_sel(cpudata->cpu,
 			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
 
-- 
2.30.2

