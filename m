Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC723BCED
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746446; cv=none; b=c7pHj0df+R9e0HpupLRx7mifCGPlObaFy/Q0ec9ZAI05ARVZJWs2PxH5gmADX+xHnhjOVy4OUJEh5C3FflQhmY9F15gFG69RMzw4WRqdwULzE3E37q5A4ta/S3EJtsfZmOu6vWOvCiwOxTADhBXDY2Z/7isVC8N1rdZYWdzRJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746446; c=relaxed/simple;
	bh=Ij08AF/uUNQD0SjuYvWUHV6gWDNDc1VQNaoScfXxwmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RViONOZCARqtbON8TxXzmIlmap3eV+tbeSCddOzhQIM8HJ/MgTsyUiQzoD8NkDJFJfIXQbgFc77cttNSyI7IEvVLodPTO027//XS9Buffi1NFEM1IBijD2+rVfr8FtFqqCQ84wUhzP/0cyRoJDhJW3fOElImxXndj6tBuTri++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=CTUAWBSY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breiti.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b="CTUAWBSY"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so792759a12.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1787746442; x=1788351242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e31qJYeAbxR584eu4jjxUYEy/aZxuhgj5H27N/W3IXI=;
        b=CTUAWBSYUO7GJavjId7HEQ/H9lLHfGbqS20HOFNSmHpmHNT4jQtOl0rEzE9yqHpqPF
         ikejV/8B/n2dC/ZD0+6re9c3/8LiTCOZAzaWYahMylIoxRnOvNPIB3nWEFklLC4pE15/
         Qck542K0HmNAnG52SeThuvWr2BHedyQBVct58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787746442; x=1788351242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e31qJYeAbxR584eu4jjxUYEy/aZxuhgj5H27N/W3IXI=;
        b=blAIn8+y1VTz5Yt1JnVoCzJlkS8bty5BAClH5Gm7Rm1ey4WamQIyFa5oEn8DfLBlFe
         VXfyjczBCS0N0H4BE7+p0h++AA4lww6wEjqLQjA0pjsy7TgNE3Zm/okZXmIzCdhxU+DQ
         32K1ElAu/nrv90VDhbmZ/68mfB2UUETUTxdzBc3dMAKafS9mTLrHY5/GGIAMpbDnGG54
         UjcuJUzvcxLS4muSeWHsyMe0l3REF++Kjo4E2Hk6Fen7asBL/jI6sVPnJJ1NqFyhCbrJ
         L2d+7pAbVCdaUYE4jdV99KWsICR5a3k/ECXH0dN2oBIr86x1EcFX7eE/P2BYdjKx3xbr
         v6yA==
X-Forwarded-Encrypted: i=1; AHgh+Rre00b9ULPDBORJlaoEPylqNnGKm0P7sCVIeYO/PA4m3dnXhbhlGLxfoRYvHM03pUBTuYZhAT4=@vger.kernel.org
X-Gm-Message-State: AFuF++kINycfySafz5YOGG1Gk/gVq970pkQARcmn6x9rKnKLZCWtSJZ+
	17auZZJz3RC5qF5s0l8KCdjcYmkI8/uw8vPBt8/bdY6X0X14Z4E2Bx2Dj1KuMJEd0A==
X-Gm-Gg: AR+sD10xA4lbZQYPtyjtM8zBLWYqzGm7xS6oySYxk1PXNH51VzVPfJf+aTYjzluCl1K
	gh2cXJTznllQLq39OaYfXlWAU/YZ/JPdgVbHqIIr5SzahEiJ5BLWqfCBaaNHDUAQoo9as2TOhrL
	pGwT5CjUp/y2oVEusPLYfk4Ut8s3pz2QjjW9Y8X0+O4o4MpFjdSj5GraFJNEcYPUUecOpPOohkK
	n9NepLmWGUHPsLlW1Qz+eJr+Ho7lZMkHgtZo04586aMC+aRi0yMxfuT3Skb8AQuGM/lnRrdSaxN
	V4Xs2VNfpO1IQYszRqVJ5ZnDsdZQA/5KQKKQ64zSgOZWKqKPbSCp4BPYi3fenD2B/g4twHTqHT/
	7KjGCMuEl+ewQocDDt4RMDIURmuA2DIb4DzTX3nWHY+JogAfulSV2S6sRdk2Ofqv86PhjaKtKLI
	uBnbFIwgUDsn6RJIUACU5DUX0x6V/uQ6aG980OR2Fx7enOeojmEbMQw3raUFiA2lsfY23c/3RoL
	dj1
X-Received: by 2002:a17:907:998d:b0:c1a:5d49:f99d with SMTP id a640c23a62f3a-c250baffb5bmr889064566b.7.1787746441892;
        Wed, 26 Aug 2026 05:14:01 -0700 (PDT)
Received: from framework ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25185b4d97sm319801666b.34.2026.08.26.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:14:00 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: srini@kernel.org
Cc: alexander.sverdlin@siemens.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Markus Breitenberger <bre@keba.com>,
	stable@vger.kernel.org
Subject: [PATCH] eeprom: at25: fix read_poll_timeout argument order
Date: Wed, 26 Aug 2026 14:13:34 +0200
Message-ID: <20260826121334.122881-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Breitenberger <bre@keba.com>

Commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API") passes
the arguments to read_poll_timeout() in the wrong order. It supplies false
as sleep_us, USEC_PER_MSEC as timeout_us, and USEC_PER_MSEC * EE_TIMEOUT
as sleep_before_read.

Consequently, at25_wait_ready() busy-polls with a timeout of only 1 ms
instead of sleeping between polls and timing out after 25 ms. EEPROMs which
keep the write-in-progress bit set for longer than 1 ms are reported as
timed out, although the page may still be programmed after the driver
returns. A multi-page write is then aborted after the first page, leaving a
partial write.

This was reproduced with a 25LC080: a 32-byte write spanning two 16-byte
pages returned -ETIMEDOUT after programming only the first page.

Pass the polling interval, timeout, and sleep_before_read argument in their
proper positions.

Fixes: 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
 drivers/nvmem/at25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/at25.c b/drivers/nvmem/at25.c
index bc2cfb75d9bb4..9e71c6a859471 100644
--- a/drivers/nvmem/at25.c
+++ b/drivers/nvmem/at25.c
@@ -224,8 +224,8 @@ static int at25_wait_ready(struct at25_data *at25)
 					   SPI_MEM_OP_DATA_IN(1, bounce, 1));
 
 	read_poll_timeout(spi_mem_exec_op, status,
-			  status || !(bounce[0] & AT25_SR_nRDY), false,
-			  USEC_PER_MSEC, USEC_PER_MSEC * EE_TIMEOUT,
+			  status || !(bounce[0] & AT25_SR_nRDY),
+			  USEC_PER_MSEC, USEC_PER_MSEC * EE_TIMEOUT, false,
 			  at25->spimem, &op);
 	if (status < 0)
 		return status;
-- 
2.47.3

