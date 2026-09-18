Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9E3F482C;
	Fri, 18 Sep 2026 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706610; cv=none; b=gx9y9rjQf5j5xuPl/wcFajThY7aQ8W5OBvsdTyh3Q6pdFqJkqu/NuoxlhfsYH2gu8m+nG7klqmpTIoZxMsDb2p0NITIu72uppbNsww4ZtrFgzEx5pQ3rFxnYT4xhffr8i60eetmMuQW+WPV7BTx0YyfHdGum07tRZOjvQlB0eW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706610; c=relaxed/simple;
	bh=ctT6/vFqCvmzUB4BzaDOakENPF2YtZmtVFw/C+EeL7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JzXzjhVrmY/icN8BDymhBnltxSRXyRjtpG0h4Zsv6dy222LN8X3NcqjWJ9KGTP6yVyJ0lGFsKSv5iFJNTngXvHWPQYBSATcysY1hOvithz6IygjFVjNxuJ/n0ht6kHKX/1B1SjUTZkN7lpMBWSbnfwX9WBm2uKSiXXdjY8fG+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bD2OasoY; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bD2OasoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789706561;
	bh=scvXxlF6NEZhARvuoJyXBq5j+D19qfu3CYC0s+82v5k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bD2OasoYiW5SZZIfoMhbSE0aa9nr+RdKWOy4wpjMbCyq1jepx6R6BRA1O81LJlhk1
	 4iTTGXhWveTGtd6pWBAC63ci/ydHuRU8ecdsWasUfr1wg6rM1XX2a4EV+WN+2ryMWL
	 sTYVwsSuEjBEEPXgpTSzgB7e6sr2nMsd1uRCxQ3M=
X-QQ-mid: esmtpsz21t1789706542ta9530e46
X-QQ-Originating-IP: 6Rkv2n1RlcwXAJ9DANlh8itmzSa3wvLc8R3FeYeuZBU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 12:42:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10535435220871461170
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: kprateek.nayak@amd.com,
	ray.huang@amd.com
Cc: scardracs@disroot.org,
	superm1@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org,
	LFRon <ronforever@outlook.com>
Subject: [PATCH] cpufreq/amd-pstate: Do not fail init when auto_sel cannot be written
Date: Fri, 18 Sep 2026 12:42:15 +0800
Message-Id: <20260918044215.41400-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MPAlP4yRn0xgLBU+73ErcF0cH+m0lKAYqQ8KYm7LsmpgD8duNzS4cYM0
	meYu9SXtEBFqJMsLII1XI3BKrpg39zkwQ4hmiWZoiEgfdU7vcxHFT/hXiVS/Wnbz1Oi5RWQ
	y+fuRLLSTZJ0Y1AuwaJWFpv8LChScTkiRhWiKRkM3k8ikGcVBXBN88RvPNN6QMcrtZqwFKT
	hsWf3E+3CtTD2onNP91IDJkzNq8s3xvGiKqCUNgVSaFK+/OSX3gyGLPMlBCe3y3olhpT/yj
	191EsT4n6kKlVIfIotcMvzogFCpo4SDvJxqnXmuq4a0xWf3mz2SQKy+TcLA4JKzUoBRt+/m
	u1x5/QGLKgRJMVl+quaBNdI3Aqm9GlNFGbybO+e2e4ZZ1vwlbTgu2/iGzwvMDt7lf7S1AYi
	5VgacT4jPU7yC1WSYi0Uzi44dspwUwYFBxfKVYd9oZfPAY9a/Jrg4n1wAxmkx7xis7yOZG5
	i4Sy+4oDaahQbpdXkNx7tNjTUSsiOKVn5Y6CSDP5oE7xSyGx+0lW6zMhE3hFH3lOhkg5SXC
	7DO2pTGlCkt7PjcwhVKolrGVY3dC1WSCbot1CA9jywkUlGRTiDVywF7vBkUPsovVabvTwPV
	aA/N8uA7i87YqgaPISnCdIG1XamGHfDRgaqZ2mgyhoY7NfmjS5e+VXgIfFU8OrOqc/bZ857
	MDq+iamRjoY1q/eASpBGF6MU22s5RojahuSbA9zwxHS7+C+7iqqsz/bCAEcnqRLsuqxHATK
	ft/jV588VxKHRZu6p8VDSxeVRIAfEjVuPHw63OSZt9mxB/sUS2nF8x4PVCnYoxP91gInTVE
	rnVnglRIdpIThT/SfhdFbXfFu7LGQAUOKrV0+KSre+rry+V4xDt8sj3GUbKwpW5KQwapG+P
	dCj2dsYXMrvrYlpeBF92kpu4IOlQm7FvjOks+Q9FglMywNU3X64JnLg1ij6ZAqty9Y/A9sJ
	uM8Vz3qNvgyVtNJNLGXsVkn5XPV9nUP52VgMMGpo2EgO2/PetjyT6tGuuejBfBk8EOvRyZm
	ZoAO4H8vUhPa2qcQgLRHPE0k6nhV35MDWNIonN2GRAbmMPy6wx
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
mode on shared memory systems"), shmem_init_perf() programs
AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.

On platforms implementing CPPC v2 and below, _CPC reports Autonomous
Selection Enable as a plain integer rather than as a register descriptor.
Such a field is a read-only capability flag: cppc_get_reg_val() reads it
back successfully (the firmware reports it as enabled), while
cppc_set_reg_val() rejects the write with -EOPNOTSUPP because the entry is
not an ACPI_TYPE_BUFFER.

shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
fails, cpufreq_register_driver() ends up with an empty policy list and
returns -ENODEV, and amd-pstate refuses to load at all:

  amd_pstate: failed to set auto_sel, ret: -95
  amd_pstate: Failed to initialize CPU 0: -95
  ...
  amd_pstate: failed to register with return -19

Failing to write auto_sel is not fatal: the register is either already
enabled, as reported by the cppc_get_auto_sel() call right above, or not
writable at all, and active mode worked in both cases before the offending
commit.  Downgrade the failure to a warning and let initialization
continue, matching how the cppc_get_auto_sel() failure is handled.

Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
Cc: stable@vger.kernel.org
Tested-by: LFRon <ronforever@outlook.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 80d99ba1902c9..3657c5cccd4d8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -538,5 +538,5 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		pr_warn("failed to set auto_sel, ret: %d\n", ret);
 
-	return ret;
+	return 0;
 }
