Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C02D9EFB
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961161; cv=none; b=f5aLLkXn4uF7QQBiKf9abzu/7Fx+YIhPvTTjOxYscmU/QTsUN75PrC4K36Q8OJcNP9u47ne0GTyO13DxvOSMs+uMjVuA8eX9fnBP6KGP3ZWQlXLbYtcAueC/G/JKytkPjh4dUBCLR3cPSCQRHoNu4W1Vkdu9Krr4CbJBbjzjZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961161; c=relaxed/simple;
	bh=g+A9hiqbjdRm1wxc94/jFX4bCS9hLPFOLeL9XnppuiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofvV7rAFEXuB6A64lo7RCVicoZmmpJj4X3SQlwlfL6KxvX1eZBziM6Awlm1+O2i+BVwaUrzBAPflq+GkmK/xHK4RhA4RFc52/MPttZxDk9l2ZVQSvUqc4MFuedcI5wjG5eofcBjj/ne4frVX7s6wMw5WBEe2Hef2ZVqzCOWs7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6nx24SI; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6nx24SI"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1855010a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961158; x=1790565958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahFIIwQaTlAjng+rA2gaDe9OuP97cH36xpLgGOlzKso=;
        b=U6nx24SIR7GarxQ2uXF/iDnqcW4ELWEfjlA0qUwrtqp91LHwJjMpxELtWhv+h8uvtx
         U7pMM3l36kDlJo4My18hwSdZ/+Wgku3or0ZRrSFtdRo9hWuybN+aaZC0n164Wo5yKE0n
         WF9TDtvGHNb37Lo3/hSLa4Pbw83FonqsExxZ0I3E8d98ANGS9+rJisLy/wWp42Tt6Kfa
         NvW2rUVd6MsThAHvba5d4Z8ZYJeAi+MS01CAFFuzIStLL33y91cMWb6hvYuBK71KJyVD
         ycQGs/sT/U+cxtAzHOBNFg9TElXx/dxSO1+ctNNiFEJKpilGjF5CMHA1FqMx8+3luyez
         dHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961158; x=1790565958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ahFIIwQaTlAjng+rA2gaDe9OuP97cH36xpLgGOlzKso=;
        b=voJuNGOU5ImHbjeWsksd6TYUxd13WbUG8g2f5hXsQaKLTAvVwJYsSaJX2pFkJOa8fI
         1mxSUr9Qu8q7zHsEDgBnxZbHAyG+caAmK66RRRJlY7ayxOiRBi0EIJ2DRp0NPgC3Q25g
         ygc+w4R0+UCjUiAAMn/qQnLOPwgRfRj0+RFk0wGQ6oIA0OJRxOzbaCGw0qntSv93ohUk
         QThR5Lq6Vz9s8KGLCSP+qWgWcakO9Cl/X4mzR4sJX+kvA1Rrbe4nEi0KCvEK1kmEMJrX
         YUcolzCFnUY6QC+b3G970pZz9He81pCmrSc+uMz9+uNJQLUfSa+uB3Wb3skqCiGVhO0s
         JLaA==
X-Forwarded-Encrypted: i=1; AKwUvBwKXa5Bo4HdJt8jfBn6HFECBXJm9l/d35f9LRqE8bUVuGOAbcrO7eoXxd/sSushrVCv9Oo21L0=@vger.kernel.org
X-Gm-Message-State: AFuF++nWK3qacasWPASdZU/U/N8JhYvj4MsypjKMjVoeI0RSVRxpb2Gg
	MSJcZKyOhFz+RhxeT2rIGpqMxDIBbF4UblbYYMDFGl+hlyjpfUP/bPFQ+rDsix7G
X-Gm-Gg: AYBFou3kgDorFk8K8G1UyquaZwks8OusImueMXQZEu90RVN9TdiioBLzjwhpDwxnhCQ
	OGZPDAyD9p3Uxbm38xv11mUXRtNjxpyy2iRMPqrAX/XvbEnwe0DigmAiTbLhW6Ci5v8d2cp9Xhx
	k8Qbs+7CbKLftDYq/lqVtf19tP6SFw3psR0cuT/nVo/sywr7LTTnfhflPwgePfUeqnsTJUUppeb
	mvnpjPPBaUG+BSSmtq9Xkzf3mCjhO0qxagnjnOx3Mu+OYIPcQ18Uhl4gw4CR5RYdqUEfAMTQPft
	q7aufXyZ1PGIFGNRAnaFOMS6EJnyBwOJ5A7qGea45VJB6oIgoqD7hCEZTemvy2EDXlkz5R3kvqN
	KBcqJRDzgdefTjQ/Uc6cU0wgENXIdIrS9r1K9/uow/XhJ6OwSZ5fymBeVMeldoEur2ln9PanqDe
	QAgQ/cvQcyAHrWcjaSiqUFvRofZUrfmM3C1s9wq0sIe7bRvuSowfPg1TMHM6mBsI2JYAZdJhho+
	9l0bwUk1KqK9a44zYA0QvK9zhJeFcUqfJU6rm2OLhAWWKJuKlSvO4O3tOF/3gZ0AoAj4zoKXWAL
	Uyn27IVwzDI=
X-Received: by 2002:a17:90b:3bcb:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39e54eab3e6mr21858131a91.12.1789961158476;
        Sun, 20 Sep 2026 20:25:58 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5547a04dsm6298293a91.3.2026.09.20.20.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:25:58 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0
Date: Mon, 21 Sep 2026 03:25:55 +0000
Message-ID: <20260921032556.1160734-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
References: <20260919222625.3797581-1-benquike@gmail.com> <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ATA_12, ATA_16, or ATA_32 pass-through command with a
multi-sector PIO command opcode (ATA_CMD_READ_MULTI,
ATA_CMD_WRITE_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_WRITE_MULTI_EXT, or
ATA_CMD_WRITE_MULTI_FUA_EXT) is submitted via SG_IO on a device where
multiple-sector mode is not configured (dev->multi_count == 0),
ata_scsi_pass_thru() currently logs a warning and still dispatches the
taskfile. When the DRQ interrupt fires, ata_pio_sectors() triggers
WARN_ON_ONCE(qc->dev->multi_count == 0) and computes
nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size, 0) = 0, failing
to transfer any sectors:

  ata1.00: invalid multi_count 1 ignored
  WARNING: drivers/ata/libata-sff.c:666 at ata_pio_sectors+0x27d/0x300
  Call Trace:
   <IRQ>
   ata_sff_hsm_move+0x211/0x22e0
   __ata_sff_port_intr+0x1c8/0x520
   ata_bmdma_port_intr+0xa1/0x5b0
   ata_bmdma_interrupt+0x1f5/0x550

Per ACS-3 section 7.12.7.21, if IDENTIFY DEVICE word 59 bit 8 is cleared
to zero (multi_count == 0) and a READ MULTIPLE or WRITE MULTIPLE command
is received without a preceding successful SET MULTIPLE MODE command, the
device returns command aborted (ABRT). Per the SAT specification, an ABRT
error translates to the ABORTED COMMAND sense key with NO ADDITIONAL SENSE
INFORMATION (0x00, 0x00).

Fail multi-sector taskfile commands in ata_scsi_pass_thru() with
ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0) when
dev->multi_count == 0.

Tested in QEMU against Linux 7.3.0-rc3 (-device ide-cf, where
dev->multi_count is 0) by issuing ATA_CMD_SET_MULTI (nsect=1) followed
by an SG_IO ATA_16 ATA_CMD_READ_MULTI command: on the unfixed kernel
this triggers WARNING: drivers/ata/libata-sff.c:666 in
ata_pio_sectors(), whereas on the fixed kernel it immediately completes
with sense key ABORTED_COMMAND (0x0b, 0x00, 0x00) and 0 warnings.

Fixes: 1dce589c38c3 ("libata passthru: support PIO multi commands")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Report sense key ABORTED_COMMAND (0x00, 0x00) via ata_scsi_set_sense()
  per ACS-3 and SAT specifications instead of ILLEGAL_REQUEST /
  invalid_fld, as pointed out by Damien Le Moal.
- Update the commit description to accurately describe the
  ata_pio_sectors() WARN_ON_ONCE(qc->dev->multi_count == 0) and 0-sector
  transfer path and fix the Fixes: tag to 1dce589c38c3.

 drivers/ata/libata-scsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b3666519b648..29fd6d8d97ce 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3507,6 +3507,11 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	if (is_multi_taskfile(tf)) {
 		unsigned int multi_count = 1 << (cdb[1] >> 5);
 
+		if (!dev->multi_count) {
+			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0);
+			return 1;
+		}
+
 		/* compare the passed through multi_count
 		 * with the cached multi_count of libata
 		 */
-- 
2.49.0
