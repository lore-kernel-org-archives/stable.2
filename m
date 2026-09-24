Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F240D588
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273095; cv=none; b=TSwS2nozXN1ZcM99QPOYTjNlFfWdVv4Ft5XyEN6/adO6CJr4AAeEuhLfgbSNtB7ELBXqDkOK0KDX7K6JuZp0TAn9oTB3YhJfgZkbTT97ma8Rr6AEV9nwmfxvl4jTtc9UO2b6lQHQWc4/JnPQPuYdKpvK0Q2l/htoXNCrPrAIuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273095; c=relaxed/simple;
	bh=V77RPtZFtgYhI1UfNQzZAvMqjtvS4w+LcC8CrLIR0sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR4GT8VCO0lyqLT4KTJUDZv5YDXlQJVs7/sZ+syyVqnHjD+8aG8YVuPhJtMjFf1FjLOHfQvpQQ2hFRsXtzpJ420np9rjt14s3Ib0j0t0828N0o4dYofaupcjsNbMgIY2wMH/IAM4mdurNjtTOOrDKQNecL9D0qt4C1q+0Jcgbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=d22wpN6E; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="d22wpN6E"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so1581046d6.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790273092; x=1790877892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=42VHkp5dpCRPRsMvdyzUDhaTo8Fj21buvKgDZpbIrEs=;
        b=d22wpN6EHDG7oCSnkViOqYMyZuLtdXiK3epnNt6y+zqf0sT/YyBxgOMwzeqS8twmRF
         d5/9T+tPckNtriAEAGNi1O21i3KswSttRJGtIyoS/ypD5Pbu5JaXp/ehux5qJ9cW0AbT
         IhloNxFZexzN/xzfoVXaP8uCNvZtLFFrkqgDndHZaXIGzvvoLWbr57uHuwgJyJRx10if
         YHfGyNTiECvvs6VpT2mScjkDTF8uvhhW13J9LaR2rKECtsi9W3FCf1YA7f0MMqwA+/oo
         6MWV1tQmW2EmUbvWyidwBaON1+EiWKIhgHwoCkBtP3DdrstkgpEiVREwecpDo1rpV7VR
         jKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790273092; x=1790877892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42VHkp5dpCRPRsMvdyzUDhaTo8Fj21buvKgDZpbIrEs=;
        b=CM1IqRwZK5dI21j+q758Z3TmS8yDJ/EBaGhys+4RkF+0Xv9FtccM/2WfDKK9bODPbZ
         4aSKvJ4tskZq4ao/8ZFwQBPyvXrYxyNCeQo0jeELSuabvQRLGSZjDHv0jWATq5v0zcYx
         ryyu2vjdu/vf49GvDqzYh+VnDoKebk4xqStW71NKWLv4249gUodNZhsu0GxuXnzHnXWE
         7TUkFIrfLVkFMnFWecMPtDQ9k6mjl77V2O2PNilYbUMCwv9BTVgw5E0CKE0M9Hq7PH7h
         2wgX7/B99vEFhl7T+BSIe9jb1sk/m5dfpHQ9/9c84JIi8YolJkMPcZRS5pjtTTsflOJi
         0K/A==
X-Forwarded-Encrypted: i=1; AKwUvBxQYtpTiHbhV3lvywixDU94ldxZEoPgQrn4x8ytRau0Gthpr5fnBXBcptQRCPf7aV5zSOA/zdw=@vger.kernel.org
X-Gm-Message-State: AFuF++n45COpqM34tsAzOR78zr5XS+5Mbk6zGdsBGoTx1JxGPapcj5GF
	rA3uCSRo9O9hfUThDZg5CGuDOE64Y5WBj3yIOOE/rGTkRWlT7KI27F3lLeB182I/Ew==
X-Gm-Gg: AYBFou0PuN0fzrCumWWXO3mndUGKMoeu1NAR5xcIG0dzzO7Og9JxvM4AFjfc178pcCe
	UbseioAsXM15oi6g7qMjx9PDdkIG1inKA0xVJqu2ffJ+VeWBxn3oMwqStidMmPt0VBGAFQjMvWW
	lreLD44b77W5eWptU2hfexYYdkUC9EgGTNd8I4Iqz941IcQSFkc3Z93z2+NDaY+O0mg24RV48XL
	+7VOuUKyvzxOkXSyBD8G284HpOGVj0uSYhi1BTYChJAsRg+ITb9uJqkbCKu/ry5YVs9gfmYrcp4
	I8ETWOLjP3JhCsDVFvk3sz5vHRZVQzEGH8OoO6c1OSOEw3bDspOlaoUWwHDrgLzRbWFXQg5SgxV
	y4JwVVZLwMg/sjWZJqdhlzK7NT0vnRnkNSkAHk9FqCLOL6cjxtp93v5cHjdHm05FNz8l0tS/6ii
	yHCwlLrQVCs4wuh68McMV6C9qURnjls1LZhtm3fCzZJWs34UoOh6T+cKQRAH3daCtdDTDmivpIq
	g2Uq7CVSyNBdrDyHXXz9QWBDmrRa4P2mQ==
X-Received: by 2002:a05:6214:4a05:b0:914:2e80:fa99 with SMTP id 6a1803df08f44-9142f9001a8mr128566d6.33.1790273092391;
        Thu, 24 Sep 2026 11:04:52 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e21967fsm21744616d6.13.2026.09.24.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:04:52 -0700 (PDT)
From: hengyul@cs.unc.edu
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: mkp@kernel.org,
	ipylypiv@google.com,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands
Date: Thu, 24 Sep 2026 14:04:14 -0400
Message-ID: <20260924180414.2102946-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

Since commit 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands
on time out"), atapi_qc_complete() sets SAM_STAT_CHECK_CONDITION for a
failed command only if cmd->result is zero, so that the DID_TIME_OUT or
DID_REQUEUE host byte of a terminated command is preserved.

However, cmd->result can also be non-zero for a regular failed ATAPI
command completed through libata EH: ata_eh_analyze_tf() calls
ata_eh_decide_disposition(), that is, scsi_check_sense(), on the sense
data obtained with REQUEST SENSE, and scsi_check_sense() sets the SCSI
midlayer internal byte of the result for some sense codes, e.g.
SCSIML_STAT_TGT_FAILURE for ILLEGAL REQUEST with ASC 0x20 (INVALID
COMMAND OPERATION CODE) or 0x24 (INVALID FIELD IN CDB), or
SCSIML_STAT_MED_ERROR for MEDIUM ERROR with ASC 0x11 (UNRECOVERED READ
ERROR). For such commands, atapi_qc_complete() keeps the result as is and
the command completes with a GOOD status byte, even though it failed and
valid sense data is available.

As a result, passthrough users see these failed ATAPI commands as
successful. For example, with the emulated IDE CD-ROM drive of QEMU and
no medium loaded, a PLAY AUDIO MSF command issued with SG_IO completes
with status 0x00 (and no DRIVER_SENSE) instead of 0x02 (CHECK CONDITION)
with sense key ILLEGAL REQUEST, ASC/ASCQ 0x20/0x00, and the CDROM ioctls
CDROMPLAYTRKIND, CDROMSUBCHNL, CDROMPAUSE, CDROMRESUME, CDROMPLAYMSF and
CDROM_GET_MCN return 0 instead of -ENOMEDIUM or -EOPNOTSUPP.

Fix this by preserving the result only if its host byte is set, and by
otherwise completing the command with SAM_STAT_CHECK_CONDITION, as was
done before that commit.

Fixes: 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands on time out")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 drivers/ata/libata-scsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8f9aa97a519d..dc5978019eae 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3059,7 +3059,14 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL && qc->dev->sdev)
 			qc->dev->sdev->locked = 0;
 
-		if (cmd->result)
+		/*
+		 * Only preserve the result of a command that was terminated
+		 * with a host byte set, e.g. DID_TIME_OUT. A failed command
+		 * may also have the SCSI midlayer internal byte set by
+		 * scsi_check_sense(), which must not prevent reporting the
+		 * CHECK CONDITION status.
+		 */
+		if (get_host_byte(cmd) != DID_OK)
 			ata_scsi_qc_done(qc, false, 0);
 		else
 			ata_scsi_qc_done(qc, true, SAM_STAT_CHECK_CONDITION);
-- 
2.53.0

