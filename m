Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE91D7E5C
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771037; cv=none; b=IG3KKaz10qdkhwQamNUi7GdsHa9/ZZVbV+2fD4+0TLX0j0AoBYpWZSL9MKKcbvc84Wh/2s8rAeKfjknI+6i0Dq9TRNXDq1wcer7yQ7lBGQJ7Aoaw6n/WdlzOvdRiKwlldBMNLvrM1sGwvFDFngS+EM4dvAhzKDYSCfI7f96uxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771037; c=relaxed/simple;
	bh=q6Cs/MV/mIziz9NQyHGTt4SbOcbsOUPsUOZ3RA+w0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHYB7DHMeiP+R7xb0fyv1UB2aGimQrbXn47tuic3u3QO6AnVZT87NxUgQHHk9pys0VzlASMsMp7iBd0jOkuK7HH2mtH7FBdAH5IoinmsTEIl13JMBHjb9nA27sHKOtnhfblN3z79TVNW2Ig4a0qfSktcYkSS771jaKCZepspPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lwXaWxMa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lwXaWxMa"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D5133F1C0
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788771022;
	bh=vKM5X+Hk9mhEFBsgtCJBAn5bIuqmg8eKF/gMDNiK1CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=lwXaWxMa3bne8mPup61hjvWmU/QE5RxkhoboKTBFr0uHyc9SEHQ7tRqziaCM4Y7JO
	 9oBvEeeLE7E71S4LCwjDE1rh9/KgbgEo8gl+sUN+3xE3ihDPHwuBkVB/k5w/DVvwLO
	 0KQWWBT1dhJi/o3ROKwTLA5PcDDtaISQAOCKwS4HIcTeRmjt1l9nmRkVFMQmNxwd9Y
	 prFbmjYzPAbXXkxQFN3fun63G3SKaRc9uCPaz+NpS6J485uqwvKulzJm2FJxGjCDLn
	 qJt5ygeepFxuGJoRsAQExHD1DlB5v0RQ9ALKh3rbpcnL26zj+HNQtjW8Y/3KCzbTBw
	 dk/4/4/Iw/M0KDqTx1hGhh4f4hI+YfEzJkokAnTfL7e9fQtvZTSzsm4+tly0HW5RcS
	 jys83bFGkCAf40LQ1Q2UYz0IDD/+INCph5NwmqX09rooh+RSw8ppAWIdOOkX+QEEXg
	 eLmQ6NNDCo8ygsi5Zg21VWTcKIREVxj8UyGcZhIkEBVVlC0Deafy/+TYAIfipX4n2D
	 BVNsBdmQQOc8slYuKDNjInfCi6GtADAu+EQI48evoGtQ3viwRokEGuaYcIisM+yFG3
	 Y7BB07GE+v4ILvs72gtPwuVw84rwYT4WeWCwwEgeJ2kCEsrPR/iXYsFkdGPhanl+8W
	 5WQNIW5+iDdtOPgiOYWb1RT0=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d52734fc41so61052265ad.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 01:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788771020; x=1789375820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKM5X+Hk9mhEFBsgtCJBAn5bIuqmg8eKF/gMDNiK1CQ=;
        b=IAJ4F8FSM2/Myq5UvQ1/G597cp8+SpJ2d/DFb+ew2bkK29ppR2EWUks1TP4fSopK6/
         FCeLIRV6wKio3p4iPGdglHG6WXT3NEYm1VgYhMtPjW9aCWthBygbsnSXzSQi7locQjke
         zslG5s9JCaJ/az9hn9UVT0satvUpTBWLtQLwDLhSxHotl2YiJ+Sbcbs8O8Z9P2AfjGfC
         x3yaf78oBB05Fs7wzg0VqOf6uMIOMftVMKtT0G5AZZfONaNJRXBUnovCUZ96Rm3NaaBl
         MO7BQfTtH+/Ik0IGVVjCLr0T9Su2ZzuIHmVeE3oCkX9sHxcNnpkvyJMBs+6WvI+NU/KX
         e0wQ==
X-Forwarded-Encrypted: i=1; AKwUvBywnqBQDkWaGgZCfiwBKz4tZADZ9rnCm4+NUfp/DafepjiachIvT4VABYhgFy+ldIum5+bKbo4=@vger.kernel.org
X-Gm-Message-State: AFuF++k7m31WUVhRn7KxqbYiiZ3fpylN+z+f+UWYQbxXmNhNgTXYthyQ
	5ljplLPgqVUFp4hIgwN5t0bbkuvoBr2bYD3BZuO8mOqr4R4+09TGqFoIWw9OxP04/5tF2/fc+jR
	gu3aJIHQtmB324jgvmTT7n1aB96400vk297KUghbA3ca+pYFN4ROZ8Qe2KXEHxlM1Fo2EXaTr1N
	J2d7MDh0HgfK8akg==
X-Gm-Gg: AYBFou1taHlcWfF7xFWWrex0hGB52hl4sCVZd6FgqNBjMXv+5ZkFwjtgSJ2px0ya5Z9
	g7pw4ls4dSAFmUFccElk7vAJ1Kk08X+7x02PehUoaPcxJQgNMxVItROTqShBV1DLfPpRCrjO54E
	BSwrNi1+Pmu1xPLOK0/Q+SbYeEwOYibdAUtAPFHvhzzrSsKydGE6hPjYg5NnpoCW17rNRCHSc3J
	sRBs40qhQ3XMzoMukp/G9GsJ4DAbfi0CVvBdddriZGvZMUFgofg1u29zcQgVHgKtLDFCC5vFNw2
	/xma3Rsr/r203in1IBbdQvp+fbF8i0PxlWXkyeYbjEhamNlIO/FYVOHc5yr4PqOBATHlkaRNNOB
	X33ua6nkjZ/XvAgkJCwUHxsvWcUwVBiy6
X-Received: by 2002:a17:903:26d0:b0:2db:5c0a:f18c with SMTP id d9443c01a7336-2db5c0b15fdmr48908685ad.6.1788771020535;
        Mon, 07 Sep 2026 01:50:20 -0700 (PDT)
X-Received: by 2002:a17:903:26d0:b0:2db:5c0a:f18c with SMTP id d9443c01a7336-2db5c0b15fdmr48908055ad.6.1788771020081;
        Mon, 07 Sep 2026 01:50:20 -0700 (PDT)
Received: from alexshi-x1.lan (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm42102935ad.63.2026.09.07.01.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:50:19 -0700 (PDT)
From: Alex Shi <alex.shi@canonical.com>
To: alex.shi@canonical.com
Cc: Thomas Lamprecht <t.lamprecht@proxmox.com>,
	stable@vger.kernel.org,
	Lukasz Magiera <me@magik.net>,
	Mira Limbeck <m.limbeck@proxmox.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [SRU][R][PATCH 1/1] scsi: megaraid_sas: Limit NVMe request size to the PRP chain frame
Date: Mon,  7 Sep 2026 16:50:10 +0800
Message-ID: <20260907085010.852366-2-alex.shi@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907085010.852366-1-alex.shi@canonical.com>
References: <20260907085010.852366-1-alex.shi@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Lamprecht <t.lamprecht@proxmox.com>

BugLink: https://bugs.launchpad.net/bugs/2148534

megasas_make_prp_nvme() builds a command's PRP list in cmd->sg_frame, a
DMA pool buffer of instance->max_chain_frame_sz bytes, spending one
entry per NVMe page of the transfer plus one per page of the buffer for
the chain pointer. The loop runs until the transfer is described and
never checks the buffer bound.

max_hw_sectors comes straight from the MDTS the firmware reports for the
drive. On drives with a large MDTS the only thing keeping the list
inside the buffer was the block layer default of 1280 KiB, which needs
320 entries, which fit into a 4 KiB frame as that holds 512. But since
commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") that
default is 4 MiB, and such a transfer needs 1025 entries, so the list
runs a full page past the end of the frame:

  sd 1:0:1:0: [sdb] tag#630 page boundary ptr_sgl: 0x00000000ba62d13f
  BUG: unable to handle page fault for address: ff663bcb81e7c000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  RIP: 0010:megasas_build_and_issue_cmd_fusion+0xeaa/0x1870 [megaraid_sas]

If the page after the frame happens to be mapped, the overrun does not
fault but silently corrupts the neighbouring pool entry, which is
another in-flight command's PRP list.

Cap max_hw_sectors at what the chain frame can describe, less one page
for transfers that do not start on a page boundary and so need one entry
more. This is the megaraid_sas counterpart of commit 04631f55afc5
("scsi: mpt3sas: Limit NVMe request size to 2 MiB"), but derives the
limit from max_chain_frame_sz rather than hardcoding it.

Cc: stable@vger.kernel.org
Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Reported-by: Lukasz Magiera <me@magik.net>
Closes: https://lore.kernel.org/all/GPhsSM0vkgyIrs0DIZ62qeUZX7X4RxwQXVKiuvMx-lHQVSPDxpztUyQOGS0xikqvJ-Z94hMV-dW_5KN_0CX2hsfV7kTf_t0MTf6vdAAaSEc=@magik.net/
Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
Closes: https://lore.kernel.org/all/d171cc76-bf25-48ce-b482-d344669dfc24@proxmox.com/
Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/all/yq17bmzd5jr.fsf@ca-mkp.ca.oracle.com/
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
Closes: https://lore.kernel.org/linux-scsi/20260827182106.535D61F000E9@smtp.kernel.org
Link: https://patch.msgid.link/20260827175743.734593-1-t.lamprecht@proxmox.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
(cherry picked from commit af8c27375733fb6a6df9fa484cda77cc3dd0cb80)
Signed-off-by: Alex Shi <alex.shi@canonical.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index ac71ea4898b2..436d4e0a15c4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -1973,12 +1973,23 @@ megasas_set_nvme_device_properties(struct scsi_device *sdev,
 {
 	struct megasas_instance *instance;
 	u32 mr_nvme_pg_size;
+	u64 max_prp_io;
 
 	instance = (struct megasas_instance *)sdev->host->hostdata;
 	mr_nvme_pg_size = max_t(u32, instance->nvme_page_size,
 				MR_DEFAULT_NVME_PAGE_SIZE);
 
-	lim->max_hw_sectors = max_io_size / 512;
+	/*
+	 * megasas_make_prp_nvme() builds the PRP list in cmd->sg_frame without
+	 * bounding it against that buffer, and spends one entry per page of
+	 * it on the chain pointer. Cap the transfer at what the buffer holds,
+	 * less one page for lists that start off a page boundary.
+	 */
+	max_prp_io = (u64)((instance->max_chain_frame_sz / sizeof(u64)) -
+			   (instance->max_chain_frame_sz / mr_nvme_pg_size) - 1) *
+		     mr_nvme_pg_size;
+
+	lim->max_hw_sectors = min_t(u64, max_io_size, max_prp_io) >> SECTOR_SHIFT;
 	lim->virt_boundary_mask = mr_nvme_pg_size - 1;
 }
 
-- 
2.53.0
