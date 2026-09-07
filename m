Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F737475D
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771671; cv=none; b=saRxLxPCFfAoFqtmJg0yy+PGWvwt+I6dR8G5KWORlHL4GyyCy12fpvPdPOSbnvYgrUSXt+riVZM7ImapOtQyuUc8r8ctXkPEKIWSTIoqAL4yvnP3oyXtAdZ5JrzmmZGD2UKzmHlXWmuhFJ58fYoUOiInowImD+yYdHkmMbUTNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771671; c=relaxed/simple;
	bh=q6Cs/MV/mIziz9NQyHGTt4SbOcbsOUPsUOZ3RA+w0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm8j5YfDJN4iFw6U2L+Sr2n0781vNDvOxVfDrfFUPplWF3JrQOLRxMtpJw0mEcx/YJfOMm0z+IVoBijbJjzzvPgO1gAVOububkfhQISMckJqxGGzTbKmcyLPrDuCPwvSgi0PPPlU5uZPT7nM9KFZOnBM+jzjtTE7aV6Iwkt/zG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=PWPWY9ta; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="PWPWY9ta"
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 619B93F0E9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788771660;
	bh=vKM5X+Hk9mhEFBsgtCJBAn5bIuqmg8eKF/gMDNiK1CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=PWPWY9ta9O6tJkIHgmSGmiXw/Gb0FnGoz0x1QPxBvtYd5NV40uYrw5gA3P7s1Q88/
	 yH8qYssBDG9Ld12S72A/9i2zGDbcbvmXeTsMB1PPwg16ea4DFXTZSVh8dV/JYHcEHs
	 kl7nsb3Bik3ya+EH6g//nOOFgAisb3Qqt7n0otWHrVyDeexfuyD7lnZC8nRivde0FI
	 yo4RKSewcn4x8YOb/i5CoeEmFnrJCmd5Gxv6CX82VkDXpjx8/lQybaIH9jLP8KzzT6
	 xufkQsb+VpZ8VkA9qjU71Nl13+HX1o/fqJRR4vxCeIoCSfBdkBe/ZshIVUQQOVXtDg
	 QpewKuOEiiAW3htqF0yHqg3etOAMsbgi/K5lwi2yzvsy89mU08QWNj+qLYIsGsBda1
	 ykxIpWYrO1hzZm6lMz3bSGHup/ai5vuEZqY7i6p4+bc2biOOxwV1Uo4EBFInjY754N
	 VcCrx1PaiUYzwto/Pt7rHPXyj0G4gAeraYJ7tYk0pTPrSx5kD1DJDruFUoAmCJ8F32
	 YkTXkev5rJjW02GNsSbqSMpzomJ/oWcRi5Qi5ksPM38ghtr4/lVzC34jlAh27fq3/o
	 ds1RHAwcqd/2ilmH/W1947hWecbpxFtCWDPInWc6S0zqvpeBU77Dy5F2Yb7wOVRnLW
	 fCGhUqTpS0ZFVKvV75Hhc0dQ=
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c670254c88so3060486e0c.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788771659; x=1789376459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKM5X+Hk9mhEFBsgtCJBAn5bIuqmg8eKF/gMDNiK1CQ=;
        b=qcC8l4Pln9Cyg9UQSsWr9/nLvbcy600lgXKB+Infp+YLypfNA5q0M+aHHX684GUmot
         u+XFxMNqLc7nqWJPqnF2jICKUQnvwAFS0oSkVJAAEIHHYfO7p7lRPe8rYXnpweuly3W4
         yAdusD2yDw0bEZCRxkZ+zufkiG9wJEpHqPAin1qk6WqKKZ0bBAE/KDrsWsXja6MHBAbu
         AxWt6Lka9EFcxC9oEKa2BSHS209XJmCpacTbDCuPmkWM04oi2a0NX+mXBcauC9bUvgwz
         qKMpowS7k1qhpe9a97BWehWwZazdnQOOXhqRE/ERCKEZbT6Brfarx3SJMJXlkHZwg0bs
         /k7A==
X-Forwarded-Encrypted: i=1; AKwUvBxfiUilc/0XEW32mEd1asog5c5+wGdzihO/NSCPUajSlMNDEoVRussXVvz4zF8uR2l66hRszLA=@vger.kernel.org
X-Gm-Message-State: AFuF++khOuA83gO/93gLgjw/nz5O092R8M4raYDIhiJbHu3CvbWeEQKw
	IsEXMmjclv/JQWX6qYC1q/syttsn4xyT+NbwHkG49cmTORzZuZLwb58Ej0u7RDGFs7zM6mlCPGB
	NoPR2MFX9+ukute8b2RybWLffZoAhzgZWQNYfcYMOlKYQJdfcauBEpSXc4sJ4je2jpRGKDcSogu
	m4z1k1ilFarOsC8w==
X-Gm-Gg: AYBFou3+X8m0v392rS4cGNHDNz6x7VA6LcP5UbstjVIMGDGUwdwY/GjeNgMYZUn0HKg
	98ij1CfGMi9zC7l0ptw4JfUwYgEURMxgfM3UViJXE3Z+zAcewN12LREt3RF4Zh58+jQhIOfy1CA
	UmV368+8IG7tsiTylS/Tp1oxScZ88CvRg4X64tLqlfeS6YioEt12tKmqQywJffJgZDaOmb1I+ty
	geFO2jjfgHnj8K9GWbAxE3CgFEN+UGf+YxIwqGMUa16z4yT8kA46tLUApu9rpT0LsYjkNnmfCLp
	Mn0mi1mGoZmIpoB/O2U/2W88xl8a0fAXbHyjK6mm6fJ6fTZqTgjCcx8GRgnKymuZOJh9uF0wWFM
	LxpeyUG+Q5cHlchUht7W9dFSrpEVJrMuC
X-Received: by 2002:a05:6122:c9d:b0:5c7:9445:f468 with SMTP id 71dfb90a1353d-5c7ed7eb340mr10317652e0c.6.1788771659103;
        Mon, 07 Sep 2026 02:00:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39b26273a40mr33927352a91.21.1788771250703;
        Mon, 07 Sep 2026 01:54:10 -0700 (PDT)
Received: from alexshi-x1.lan (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b51eb40e6sm9710304a91.16.2026.09.07.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:54:10 -0700 (PDT)
From: Alex Shi <alex.shi@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: Thomas Lamprecht <t.lamprecht@proxmox.com>,
	stable@vger.kernel.org,
	Lukasz Magiera <me@magik.net>,
	Mira Limbeck <m.limbeck@proxmox.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [SRU][R][PATCH 1/1] scsi: megaraid_sas: Limit NVMe request size to the PRP chain frame
Date: Mon,  7 Sep 2026 16:53:55 +0800
Message-ID: <20260907085355.861433-2-alex.shi@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907085355.861433-1-alex.shi@canonical.com>
References: <20260907085355.861433-1-alex.shi@canonical.com>
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
