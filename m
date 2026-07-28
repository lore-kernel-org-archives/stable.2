Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525F3B14A9;
	Tue, 28 Jul 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238734; cv=none; b=IbvTEKbnR6NsxfKbZ3tk0QN3QrOt86fCUkx+RWOsY1KZ8WRL6ogmS1ZCw2WVEUBI3foJ4+J6nTVw8ui+5pacS3OVMqsDgDGf9QqpedRiA3w28IUZR+nlg0zoeiPtYdrR/xeUrgzhRhKxIAfVmZi8/jdJScm4TUTfYbsXGShkLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238734; c=relaxed/simple;
	bh=d2rBLQ8bgOFKB4h/ghggbtlsmqc82p3cLmh/qaETZzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOSEX1+t28Vaidzrq3BQdo7GoRsJKjMsunu3Hva7wDJhFDVJCxZtsFjpHriNplCGS8enNPsqQrBU+jk2DIIV0iWmeYepRmWPVe17MlppO4oCGZRKutQA21aSGd0T7YkYzW/eXAAy8K4tSLjYT1CfUjiZcxClPCOP4430SQ7LADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0WElU6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0WElU6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6718A1F000E9;
	Tue, 28 Jul 2026 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238732;
	bh=rxqSSWpOxIo5wSUKbdlDJNm2sy8/klrtF80y0xwG840=;
	h=From:To:Cc:Subject:Date;
	b=K0WElU6YX1XABpdtLh8CcAD4UoGmt5t8N+O+8mpueaoUU14eeG1Mwc4UPrLFOitKZ
	 bAp6isbsFiXPXt6i23kcyVh3iZNPi531taWiMa3TquOUJZgA6pPqeS3aT+/f9dfjhA
	 DKoLgKESweq23RIm4HGrTPv0v2R1XDlu8jukCdJYLYqp28yRsPzX8FVJbQsyUT2pLj
	 hDbkBA/QmRlddKvTRcyODu4sSNlZaCCi2vWiRQUvq1qyMUhvQOOyQX0EXhdFNzerrJ
	 h75OkIDpR04lAT9g2kUT7piVhahZ162+f59KJNSNgmj47gfKuE2s9PbnOdl1se2tKC
	 KVRTSIu6NopQg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration
Date: Tue, 28 Jul 2026 13:38:42 +0200
Message-ID: <20260728113841.727256-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=cassel@kernel.org; h=from:subject; bh=d2rBLQ8bgOFKB4h/ghggbtlsmqc82p3cLmh/qaETZzg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIyphyaFuBsdmz2A9ZVjY/PaGyTWfoq6IPJ50+h0ivUd 8za8nNXQEcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAm8qaA4X/iwz3SfKZdT5p/ z2b6vLtv2drunek7Tt00Tk9ijDk1v/YdI8N3n55YiVfzXuRbdrgoOwTE/Xb5u21HzR8lg65fji+ +OzEBAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The inner loop of ata_scsi_lpm_supported() user the wrong variable when
iterating.

It should obviously use the link that we are currently iterating over,
rather than always using the host link.

ata_scsi_lpm_supported() is used to control if a user should be allowed
to change lpm policy (from the default) via sysfs.

Thus, this bug could potentially disallow users to change the LPM policy
for certain SATA devices via sysfs.

Cc: stable@vger.kernel.org
Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-ide/20260728112200.B99F21F000E9@smtp.kernel.org/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2ee54d60ea4b..5138b4e500e5 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -913,7 +913,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
 		return false;
 
 	ata_for_each_link(link, ap, EDGE) {
-		ata_for_each_dev(dev, &ap->link, ENABLED) {
+		ata_for_each_dev(dev, link, ENABLED) {
 			if (dev->quirks & ATA_QUIRK_NOLPM)
 				return false;
 		}
-- 
2.55.0

