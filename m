Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.13.36.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231960;
	b=yvkEmcKNS3ocDefaIqIV46a2PuIvSEx583HCG74W7hFeIK42Nd7wmtvmJMEvuo/gHWWi
	 uUPIXsYIiURIW2s78jeURGsB8ffzz5oYejLqVFStWnHyHJa5//g7Xr+rjBcRV55jcNv1G
	 vgB1AKpbWPH2j1AGxQ1pDMElpmSKpJWgtukwhy6og/9DAqvkAFVfd+NS8rvGrNXb+E5yh
	 2J+NK+lsNmW6enwHfQQZ6klH8SIUcmUG/7wV6rvbzSIr9YlI/nI0EQmEkPgvTXiuc+yhp
	 11KsjSDq2ZcVyMSYV3HG4fAZck4ZtIW8MApTFWH8S8pML/GcWjmMEiELr95zaxYbtUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231960;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=clexaisj2vvqzqmivUmQF8+XLbqhORqIyALEMqQ0/Nc=;
	b=otGa7BCKSQPevrsizerIpeyvd8am9N82dkDszyQpiRyINLwcfGrEdszWjn6ljiEBMNVw
	 ekklTA2xev33+OETioDSwZgRjEF5BLetIpkSugn/EWiJ6F9wZDwyLJPKMs9mD3jvPhZcz
	 TqqmUtlkzZZoiQjAVKYo4BUZsmltBDp202swTkN/9J1uNn3ZFizYA8lE3alVQBxMrDQFC
	 Lhm9iA/fD2kzvsbmmm7yWJXjXj9KEiufQxzItRSN/G2w3PZUnsC3vhYMPWuloa5iouhbt
	 A1TYmsQH9toUFrKTproaBkytC3nVY0ateiSKHaTtgA4eh+V4dCzTJWgdg2pzOU2Mngg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tecbeast.gmbh;
	spf=pass smtp.mailfrom=tecbeast.gmbh;
	dkim=pass header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=rsa-sha256 header.s=mail header.b=OkuI8MJb;
	arc=none smtp.remote-ip=49.13.36.206
Received: from smtp.tecbeast.gmbh (smtp.tecbeast.gmbh [49.13.36.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2529606A32A;
	Mon,  9 Nov 2026 13:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2529606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tecbeast.gmbh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecbeast.gmbh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=rsa-sha256 header.s=mail header.b=OkuI8MJb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tecbeast.gmbh;
	s=mail; t=1794231951;
	bh=jTlDq/tXWc0qcdpmS8+/uDDYqTZFLnImDEPfWiFC57c=;
	h=From:To:Cc:Subject:Date;
	b=OkuI8MJb1B4cPpZPGiyiqNayrztuYJg2YN+qP9bw9uHnQRphKN+xpD5k56I96OUw+
	 Lc/SjlnBDJRTzPaYZyEAOPHyjBgWLCnnpwE9ldHdd0sb8u3r+F+jIOXf2LDPc52jIC
	 zS3RccSSqrWnz4BXjyGDiVtQb0YqKtWNjvUAfDgU=
Received: from threadbeast-workstation.tecbeast.tailnet (unknown [91.106.186.171])
	by smtp.tecbeast.gmbh (Postfix) with ESMTPSA id C4DB711F805;
	Mon, 09 Nov 2026 13:45:50 +0000 (UTC)
From: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libata-core: Add NO_NCQ_TRIM quirk for Samsung PM893 (MZ7L3)
Date: Mon,  9 Nov 2026 14:45:41 +0100
Message-ID: <20261109134541.3766394-1-tobias.kriebisch@tecbeast.gmbh>
X-Mailer: git-send-email 2.56.0
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

Samsung PM893 SATA SSDs (model prefix MZ7L3), the successor of the PM883
(MZ7LH), misbehave during trim on an AMD 600 Series chipset AHCI
controller (1022:43f6). The drives are three SAMSUNG MZ7L37T6HBLA-00A07
with firmware JXTC304Q, and the kernel reports "Features: Trust
NCQ-sndrcv" for them.

During a full-device trim, queued DSM TRIM commands are aborted:

  ata3.00: exception Emask 0x0 SAct 0x40e0740 SErr 0x0 action 0x0
  ata3.00: irq_stat 0x40000001
  ata3.00: failed command: SEND FPDMA QUEUED
  ata3.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
  ata3.00: status: { DRDY ERR }
  ata3.00: error: { ABRT }

In the same time windows, queued reads and writes time out and the link
is hard reset:

  ata2.00: exception Emask 0x0 SAct 0x4 SErr 0x0 action 0x6 frozen
  ata2.00: failed command: READ FPDMA QUEUED
  ata2.00: cmd 60/08:10:c0:82:f0/00:00:d4:02:00/40 tag 2 ncq dma 4096 in
  ata2.00: status: { DRDY }
  ata2: hard resetting link

Both kinds of errors occur on all three ports. In one case the system
hung and panicked shortly after the trim started.

Booting with libata.force=noncqtrim,nolpm makes the same full trim
complete without any ATA errors.

Add an entry for "SAMSUNG*MZ7L3*" with the same quirks as the existing
PM883 entry, which was added in commit ead089577e0f ("ata: libata-core:
Disable READ LOG DMA EXT for Samsung MZ7LH") for SEND FPDMA QUEUED
failures on AMD controllers.

Only ATA_QUIRK_NO_NCQ_TRIM and ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD (the
equivalent of noncqtrim and nolpm on this controller) were tested.
ATA_QUIRK_ZERO_AFTER_TRIM and ATA_QUIRK_NO_NCQ_ON_ATI mirror the PM883
entry. ATA_QUIRK_NO_NCQ_ON_ATI only applies to ATI (1002) controllers,
which were not available for testing.

Cc: stable@vger.kernel.org
Signed-off-by: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
---

Notes:
    The patch itself was only build-tested (defconfig,
    drivers/ata/libata-core.o on top of for-7.4-fixes) and has not been
    booted. The runtime test was the equivalent
    libata.force=noncqtrim,nolpm on 6.18.60.
    
    Stable: ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD was introduced by commit
    e6bae5034ef4 ("ata: libata-core: Extend Samsung LPM quirk to AMD
    controllers") in v7.3-rc5, which is not tagged for stable. Older trees
    need that commit or an adjusted backport. With only
    ATA_QUIRK_NO_LPM_ON_ATI, LPM would stay enabled on AMD controllers such
    as this one.
    
    I used an AI coding assistant to draft the changelog from my notes and
    kernel logs, and to run checkpatch and the build test. The hardware
    testing and log data are mine, and I reviewed the patch.

 drivers/ata/libata-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5ff45a5cbfe4..a679988d5cd3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4443,6 +4443,10 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI |
 						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
+	{ "SAMSUNG*MZ7L3*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
 	{ "FCCT*M500*",			NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM },
 

base-commit: a4845f077415ef32fe672c841e2fc58ae9e28273
-- 
2.56.0

