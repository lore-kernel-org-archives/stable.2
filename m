Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452D3ACEF8
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878877; cv=none; b=UJDIqftylXOGKiXXdXhjn09BkMCJDJcXW5brS2Za5BONH8iTD1IjObe+IT9tWKKm5+ANkp83RAgq8M1cMy4XcB6iHIAOM+cjZ/z5VwzLqZDX70yE+QwgpuCIk9vClzH2EhcbPzhl7zVye/cwQJw7FQg9JXFWRK48o9OCtAuKQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878877; c=relaxed/simple;
	bh=v7KytCFHT9shhvp5Rc09FYDEUjds27ni+ytJOXNzO/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzR7172bMqSr6CGAXw/E48y+29Yps5dDi9KlVv67pEBRPl6l4TaQzelalkxF1gaRaZe6a6xKNQNd0NP6kO0FuopCridsewW+1lASJIyYGtgmXpZYFgn9n6DSKwN736svNaQCcGbSOdgpq7YWJn+7GJWPJEDLmm4SQceknfGV/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBChoWxq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBChoWxq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so69276a91.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784878876; x=1785483676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/zWtQhEGENWbHFCLZBJq7PVW34eGxTfKARUkU/qJyY=;
        b=tBChoWxqbSzMk4R8/+zuEuGcBa5sf6jg1HuoBAZESk60iAo43npXsh05MdWoDkWdCM
         U5UBwcp7yPVdF7hdtf7kkBLX44u2XgNqe1D9FnMeldvKTN63/pQTrZdpgs4I8eeyPE1L
         rW4imZJgtS7Ea+hcsu6YUBVRe33i+6ErEtQeG85tfFaktA22MLxkM/uiDHakYOYn5HrA
         vMr+g4Clo7porYLxsPHEzuNYp/jMmh7vG++iWNbP6VLD4Of6Axy8re1BytB/z8/tOnTT
         2jN/MypPowVqN11lurkWBNCx/FLGJpBbvEUJFFEDrkY6fg1I3ZcZuCG/rZKANa27WSui
         tBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784878876; x=1785483676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2/zWtQhEGENWbHFCLZBJq7PVW34eGxTfKARUkU/qJyY=;
        b=OO8jyPgmEjw6SrnSFRtXghpJns+fmiLXD3foSlQxl8ZKJjYhjvE73dj53uNoagRw76
         0QdbPzrzBL1OAJ+coEo62dVtU4gDKnms/Dj1Xcs6BG0xJ0db/HHN/clyLUib+92tJe9P
         Q+w6jeiBZ1a8QRfffJQYojFllInEU79IROnWo64vMvl43bSSgkvvJLWsOBwKTs1txVqr
         BQvzMklgwvK+Iw+dfb+d3pDIsfpdG4i8SdmKXi0PVbePlS5jNilk2K37wrSfF9deDfIj
         NmDkrgpu9Qd1ZxMecKTO9LGqdlsRYHe/L9Cg4By1+Wi5bCEH79oBh3OgInJpaPvS1ZYb
         miIg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3pS1M3ncvGuxza9ttA+G9snEgzQ41om5lvHy217+xUprfE9hVQ0jq9KZuSiL5OT3uq74F9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qHgmPL9Zg8F3f7T/og6v7evDuxLZRv+8QqDCm8L6XNrXwBRl
	lEOWuwoDAU/P4y4xuudoswP3N6DMxIgeQ6ljOkCWsrV7tniFTdkDm4Vt
X-Gm-Gg: AR+sD10yHHkxl5wVcdSQ5o1xz8HpcpxZI+T/vP7fMTFZwFs/ShtEzV4aF42b5WLFw4m
	oqAz3dTF1vEmOga3pLpISrk1Pzk6U7kjXL8WIfxyyaPrGXWNjMEDOmteHTEfvB5eYnE9I7fZfl/
	sXpO9NoSMq++/kL2iKCpMY9FUtcw2iZ2kco1K2I2jICraykbZKKDCHf8V1NMhSm5v1+VjemGwxf
	WhUQowBBlOpvH1fSy5t8U4BFitcFWx5t7LP8CBg0ze0i8/YxPZQbFh4Sdim9+94vfQPt5eq6WuQ
	GUAK6bWx6W2mFiP/UXoxwVyO5c0KsglrBMCq1q7CKmt0v+GI+DqSLMWYIczaufAJkektDejbBjb
	xxMLQPJqigV+iXkgletLQ8x4yc7V26Kzmt0BLm6a4Rmfbf4ivXrSIVd+XgO0ExZW0eKms
X-Received: by 2002:a05:6a20:da12:b0:3c3:6544:5eb2 with SMTP id adf61e73a8af0-3c44b245fb7mr7317352637.55.1784878875550;
        Fri, 24 Jul 2026 00:41:15 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm29788271eec.27.2026.07.24.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:41:15 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libata-eh: Increase STANDBY IMMEDIATE timeout
Date: Fri, 24 Jul 2026 03:39:42 -0400
Message-ID: <20260724073942.1751381-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a previous change (see Fixes) which reduced the standby timeout
from 30 to 5 seconds. Increase it to 15 seconds.

I was troubleshooting an error spotted during system suspend:

    [ 1217.152867] ata1.00: Entering standby power mode
    [ 1222.322948] ata1.00: qc timeout after 5000 msecs (cmd 0xe0)
    [ 1222.324010] ata1.00: STANDBY IMMEDIATE failed (err_mask=0x4)

This drive is a Samsung 870 EVO SSD in good SMART standing, and I wasn't
aware of any reason it should be taking so long to standby. The issue is
intermittent, but I observed it sometimes taking 7 seconds to manually
standby. I assume this was interruption of background maintenance after
a power outage.

As a desktop user, I would prefer to wait the extra 2 seconds at suspend
to let the drive finish its business rather than drop the rails from
under it.

The change from 30 to 5 seconds was implicit when switching suspend
from START STOP UNIT to an internal command with no timeout table entry.
No reason was stated for the change.

Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/ata/libata-eh.c | 8 ++++++++
 include/linux/libata.h  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 05df7ea6954a..46947ed0c657 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -106,6 +106,12 @@ static const unsigned int ata_eh_flush_timeouts[] = {
 	UINT_MAX,
 };
 
+static const unsigned int ata_eh_standby_timeouts[] = {
+	15000,	/* Some drives may be slow to standby */
+	/* but don't hold up a suspend too long waiting for them */
+	UINT_MAX,
+};
+
 static const unsigned int ata_eh_other_timeouts[] = {
 	 5000,	/* same rationale as identify timeout */
 	10000,	/* ditto */
@@ -147,6 +153,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 	  .timeouts = ata_eh_other_timeouts, },
 	{ .commands = CMDS(ATA_CMD_FLUSH, ATA_CMD_FLUSH_EXT),
 	  .timeouts = ata_eh_flush_timeouts },
+	{ .commands = CMDS(ATA_CMD_STANDBYNOW1),
+	  .timeouts = ata_eh_standby_timeouts },
 	{ .commands = CMDS(ATA_CMD_VERIFY),
 	  .timeouts = ata_eh_reset_timeouts },
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 96e626d6a7ca..6c0d385b2cde 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -425,7 +425,7 @@ enum {
 	/* This should match the actual table size of
 	 * ata_eh_cmd_timeout_table in libata-eh.c.
 	 */
-	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 9,
 
 	/* User visible DMA mask for DMA control. DO NOT renumber. */
 	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */

base-commit: 4d99a91574c420decab56cc880fad0dc15b8a7a3
-- 
2.43.0

