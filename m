Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526692;
	b=ByiyC2ALZiMvN/1prepXHkbvsVPnNtgdCm/w7oj1uQoGVmc5EKhau3/pTaKWqTChnmX4
	 rI7no2FzUnbGE5FNM/mJhHZ//t2+ivIurotfCdZxNarSHFzPY3kuimyLsYtZXzEAnVj/w
	 oUB3VB5+5N0izcAztPIa6HJ1aOEsb8c5RhoFCHq1aTND7BT+jbIXPjlzqjb9gNf1pr3xU
	 HuwyEDlR8MFkxbMlmM9nAZ2fxpcGl+K/TjcCF83ufMu9tYSqJdb6cCnlrFFBhFPms/Dde
	 nKoSY/dzCEM66obp8Dp5NIAHDrwzA/ImsP6O1MXha7bhOs0FEVv2X6blTElm+zNhQzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bhk1XAMEGUqw4Gd56fR/vruXqPANPGJWP7xiupKdveQ=;
	b=xOWAWmfpO21AEK/DCgaQCf0Q8Ui6LnSXiB5IS0piEmy2xdoAZO9muwjQaqTkYjMVF6MO
	 kVfzjnGurMKBCsX7PgHI5l9qg4gaPxUnBCYRac0aW9qJf2KvVCSThWHTlzCMq+Cqd/0p3
	 l4xWZnJcU1XP6SxAjw1MVDg5xBrL480+HRYxPAka17rU0WLT+r89en0tRCmRGoLFnPQ7y
	 fYij+LRgx0Zbo7hBEEInvCgVjCuzyRZs3HjAC291QcZgCZA44cvr3cYTK+wGVaJeBRdsj
	 eeKmf1JkBVsF6J6pljEpKcvOM0alLMriOBse+vBWmXT3YPsO6Yd1oFxg4Ut+/qK0zog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vK0u1+VN;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C01606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C01606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vK0u1+VN
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc147d86bebso179877a12.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794526691; x=1795131491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bhk1XAMEGUqw4Gd56fR/vruXqPANPGJWP7xiupKdveQ=;
        b=vK0u1+VN/0l4pNQBjE8ZPDsnNrjcxLH2bm12363ihajUoMYdiVbz5JV8e4plpywnPJ
         qhXTZvhj8ER5QdFPPJyU07Y2i83EtcP1tGluT9/Iq+JR+/PYU0f0E1Tljc4kpeZLJEnk
         +dI1xD5aQV2297aEwF80OuK2AjvZPibqv25YrrCcA5UTdQccSfWdUkqVZL8dWEvGG9y5
         smAN4xy163VCm7kcpageDvnDg0QjOrtQ7zOn7iLH52PlXXh3I77P4lOVWiMjcnFuDUTM
         gmZSnD3MkOZXEcp2Rx21GGxd1gHipejs4/+sKfUUK9pu02/lmCS3ro6ZQ8vKzGc9wgo7
         hg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794526691; x=1795131491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhk1XAMEGUqw4Gd56fR/vruXqPANPGJWP7xiupKdveQ=;
        b=zO+RM5k23YT3EN/meFQ/33gWHbXedINlhrxjbB4fjB1OY0OcY5/mF1VLY3U3W+DTmE
         F5swcpUnxnerib9JrddYntXvzXoYZQc/JkniePi18S4Sy7NKZvmkQzGwfU0HquOZTlXA
         M0fV9GkVaSZx0yjsUN3q8MHdYsVadB5RVDmWbFpVJPPEeTr85bt3yvb1C9UKvqAwB7zp
         w/Nhm5CmdzdQFX3nMts2yxLNZCW/kpuCXzgRuAliKREsHprx12fHFflRYrS2CI4U6fy2
         fdc6dnZytoQgiGjILO2yi+p4KzWagzuC68VXWi6ONDJR3VYPm6u1zTPYEvs+iCacxvZ0
         rifQ==
X-Forwarded-Encrypted: i=1; AL+hErExayx3tZlsxBK8Se9voc1dw+uGmjW5+BJoeSnN/UZTEBPetZwcsRpgQMZLRg/cLNFryF255S0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m8+f+JfOE5eUHr4jLLXLyVvNiIrqQmMvoxtA7GpFjQ0nON95O
	pFA0gJ6TT5TtnPlQ4mdkFvcWvTgwFx1nmC2tION85lFe8wsS6DYt+iWS
X-Gm-Gg: AYBFou1FXQBDwTB7fSwyRHLZGEaj74DQ8k1EVEvSvP2A0Q7r5XB2f1QIyqUyXkZCj5w
	kD8LmJNHwrlh5yWymbzVPQTXjXrx9DTvltau/8k+7sVKafn9sm9cTVYD6CtWrd7uOh3vSRKDkp1
	HpzdTuA1zOzMIYmvlPSpaOaubpi29S4/6UjeEPgTxXp+WniCpExJmIgyQn/FWR5vz70p1orwwOP
	pTF+1h2oqRHei/jPknbkHdpLz5xNwBPgnm+gdX1VCnIAsefC1kc6swsdZPXHhsV/h1+cJtB6UvV
	WcsIfRZeSmusV+yHFx5U+NpigFMiIK6R+R6sNfCDwWl3j/uQmBo809/MnFapKkVi13LuM36Jc2Z
	/+YOkf29mZDOj5T47QfQDCGuUGmaoRusrukHypDB76rknI3ocX+cJx82UjJuQ/wswoPW2KLs8D3
	KjwB5EJrfWbWOYmilNs4YoADNIuth1i3I3HzquBXNQJspXiHkA/lG1irrZcU2orkpPCz/mUk7OV
	jdN0fh0u9g0QN7v5/qztYa2p5P637xFqIZUupp5k5o5HCIxtadTvogIPss/b6eWIxKOZJNl2b6N
	5HqrzgF7Oolfq76Q4Y/vMsa9uwlmQvCxukmO1xI4XX6/unyAXxjXr64dtZo3nHYElm1PL3BZSHq
	Qr6j+b6pMOp5rA55zLfRLzjzz3blYdyrNtKgbf67p/oCMWc72rwMIOfjIiV2O19IWMObaS+RKvs
	8h6nnTngML0XXP4fZ8baVfjk3IxwBXTptvzbH4+AJe
X-Received: by 2002:a17:90a:d60e:b0:3ad:677f:567f with SMTP id 98e67ed59e1d1-3b1b0d7622bmr327595a91.40.1794526690626;
        Thu, 12 Nov 2026 15:38:10 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3d279d8sm102411a91.2.2026.11.12.15.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:38:10 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] tpm: tpm_crb_ffa: Only register driver when ACPI TPM2 uses FF-A
Date: Thu, 12 Nov 2026 23:38:07 +0000
Message-ID: <20261112233807.70664-1-sidchintamaneni@gmail.com>
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

Prior to commit 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed
when tpm_crb_ffa is built-in"), built-in tpm_crb_ffa only registered
tpm_crb_ffa_driver from tpm_crb_ffa_init() after crb_acpi_probe()
confirmed start_method == ACPI_TPM2_CRB_WITH_ARM_FFA. After that
commit, tpm_crb_ffa unconditionally registers on the FF-A bus at
device_initcall time (and when loaded as a module) without checking
the platform's ACPI TPM2 table.

A platform's firmware may expose a TPM CRB over FF-A Secure Partition
for UEFI boot services while advertising a non-FF-A start method to
the OS in the ACPI TPM2 table. When the ACPI TPM2 table designates a
non-FF-A start method, Linux has no consumer for tpm_crb_ffa and
should not probe the FF-A TPM service.

On Microsoft Cobalt 200 systems, the ACPI TPM2 table does not use
ACPI_TPM2_CRB_WITH_ARM_FFA, yet ffa_init() discovers the FF-A TPM
partition and tpm_crb_ffa_probe() unconditionally sends
CRB_FFA_GET_INTERFACE_VERSION via FFA_MSG_SEND_DIRECT_REQ2/REQ SMC.
That request wedges the calling CPU in Secure World (with Non-Secure
interrupts and GICv3 pseudo-NMIs masked), hanging boot with an RCU CPU
stall:

  [    5.507519] ARM FF-A: Driver version 1.2
  [    5.507519] ARM FF-A: Firmware version 1.2 found
  [    5.507551] ARM FF-A: Notification setup failed -61, not enabled
  [    7.150580] Freeing initrd memory: 293640K
  [   65.515248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  [   65.521346] rcu:     10-...0: (3 GPs behind) idle=dd9c/1/0x4000000000000000 softirq=37/37 fqs=5262
  [   65.530031] rcu:              hardirqs   softirqs   csw/system
  [   65.535589] rcu:      number:        0          0            0
  [   65.541146] rcu:     cputime:        0          0            0   ==> 30028(ms)
  [   65.548102] rcu:     (detected by 66, t=15010 jiffies, g=-951, q=1384 ncpus=132)
  [   65.555228] Sending NMI from CPU 66 to CPUs 10:
  [   75.560686] After 10 seconds, these CPUS still haven't responded to the NMI: 10

Check the ACPI TPM2 table in tpm_crb_ffa_driver_init() and return
-ENODEV before calling ffa_register() unless the table is present and
specifies ACPI_TPM2_CRB_WITH_ARM_FFA, matching the check_acpi_tpm2()
pattern in tpm_tis.c. This ensures Linux only issues FF-A TPM requests
when ACPI advertises the FF-A start method (for both built-in and
modular builds), while preserving normal FF-A bus probing on platforms
that use CRB over FF-A.

Fixes: 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in")
Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 025c4d4b17ca..8219a8d01344 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "CRB_FFA: " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm_ffa.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
@@ -395,7 +396,41 @@ static struct ffa_driver tpm_crb_ffa_driver = {
 	.id_table = tpm_crb_ffa_device_id,
 };
 
-module_ffa_driver(tpm_crb_ffa_driver);
+static bool __init tpm_crb_ffa_has_acpi_tpm2(void)
+{
+	struct acpi_table_tpm2 *buf;
+	acpi_status status;
+	bool match;
+
+	if (acpi_disabled)
+		return false;
+
+	status = acpi_get_table(ACPI_SIG_TPM2, 1,
+				(struct acpi_table_header **)&buf);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	match = buf->header.length >= sizeof(*buf) &&
+		buf->start_method == ACPI_TPM2_CRB_WITH_ARM_FFA;
+	acpi_put_table((struct acpi_table_header *)buf);
+
+	return match;
+}
+
+static int __init tpm_crb_ffa_driver_init(void)
+{
+	if (!tpm_crb_ffa_has_acpi_tpm2())
+		return -ENODEV;
+
+	return ffa_register(&tpm_crb_ffa_driver);
+}
+module_init(tpm_crb_ffa_driver_init);
+
+static void __exit tpm_crb_ffa_driver_exit(void)
+{
+	ffa_unregister(&tpm_crb_ffa_driver);
+}
+module_exit(tpm_crb_ffa_driver_exit);
 
 MODULE_AUTHOR("Arm");
 MODULE_DESCRIPTION("TPM CRB FFA driver");
-- 
2.45.4

