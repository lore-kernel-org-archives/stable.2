Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC4281525
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036533; cv=none; b=p8tmANXK6c9hGYTPU8lO1RHPLDFyAx8sAwY1FiBSRcFKKQe1gy/k2dSuVVsVCIN3nZftvqwXtI6heH2XJgv6KbxM9S9j8q4DfrYzMJLfnHe8kJXUXhmYqgydll0JrVEgfypSyCyYdm7hYByNqt31diJHiscmHntZ3md4KaN4i4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036533; c=relaxed/simple;
	bh=dtWdOxwNWwXH7pw0zgQYfBj0nw9Rt475E7W4gPVnOIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgBnQMRtWUHKsZKJED0K7suLKM4xDQijuz3FvEkaD+JTrxFls7bDTmJf82Rxr0OAxvgFxXEj8J2+0TGVsAPM2xzjKkabB20ZUuSZJutlue0EJz4H/sQAx7hNRoo9f+Jlx0ArRwWvH+VpEtLzFpv7HTHN042oazTQn+psw8MSelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd4jdKFv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd4jdKFv"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dedb44ed1fso22537496d6.1
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782036531; x=1782641331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai/vQMf9K304uLaJT6I2I2q88PcbGz+JfSMbI420XYw=;
        b=Sd4jdKFvOh0+5nWQiYuFkcM1Vc++CqfAtYl/rz5SytYXG/uFGtW5TeO0aKMjhbH2fF
         fCbhr+zQjZ7EooDMGQWE6YiQMX9hMl5nmU/MgPdElwkJVLIp0g5e0KNZ5nBqfSgLw7hG
         2ei9Rtv9ZiE3Zl+4JnezkTi0G7UG4YbVySFg1S1O+1Uqpt4fkqSd4hDgyFdh0OmRCD86
         1XF+IRKQxXWkkPFHM1uiPsQSNOETA14E9VkhALgTk/5rIhS2Jukc71MvUoi+klJKIX5a
         i7Neds8cTo1skFAQAnZrpLpLltgszjQEpdBTyo7NBkI1sH5E+W1Tn3fVRUOqNdmGQOHO
         gxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782036531; x=1782641331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai/vQMf9K304uLaJT6I2I2q88PcbGz+JfSMbI420XYw=;
        b=OUUsbyR5CMH2lv9FUt8MiuB5kQ5TJ9gsGXNd/3FclAOkVSHKg8Eiad0zzKfMIFmqUy
         EVfpD4CJp574dKYr8GZ25QWe29SEYwD9bS9bQeyP+RYXs6t3CVaQJlBbJkzDBPJMopYA
         9HJ6NEBxdUjDbRp0f26aIYt9R7IGwEBd2sIW2BxFNF8tw58tF0v8QUc2cuHnQlDSFZR9
         /NNskf5lh2d7MzxhCEykVTxyJ9AlJXn2qmwwGMbBmLn3QvBycrql/tP3bHlMEy344op3
         0V17lAnlKq/7BJWPcR/rQXsln6t7fpQi9IK3/id9H8Al4IBCvV7xVkqFQjW0eVBOlAMF
         1ayg==
X-Forwarded-Encrypted: i=1; AFNElJ/+W+fvqj9aRN1/pHTh4T8WCV1GipiGk7w6U1EuYmRS/ypi8+7X1bWdRJVZPGVFwUjXDIvJVY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcRYkcb6EmGGfV1YCALLkgk3c2RY1TzpI3cMRIRxL4KtWeE/W
	oJPfiJDx3wDWSh4tvGTlDVh5K6FxYbpS15BNUg4MaCQ41KCopLUJGabz
X-Gm-Gg: AfdE7cmc3X1ozxTUzYE6+6XfdO0EiOhoMbafY82INVpbO3g3PgeaOVEd0IXkWWzdBAA
	H3UMJ5v26XYrtCi6udDgE5x04t7Z+qmx3Qroj2yV+fk8qgxE/fsH1pxT4MiRVmZn93iOcKxt1ti
	c/7osgrsKj4YhYtcwe19nHEKY6Wq+8B5yOkPSxjrdgQKqSj6B7fPzP7V7Oy/kMPthfiETkFeXrp
	B+FaijdP9xPm321ZgLKlVgRpYJUY1ljazVGM4u0u4oORVSvWBNO1Waq8BqedD2/H3UQRiqp2vrH
	9h3t5jHFK32oQd1hM2SwVLK5xi5P/wtu+EJbCQtWtNGHgAQUOA2qrgRCNXKU987jI8ShsELc6eR
	Aec1QT61i1vGK/q2l9qJhNBIWyVVExdJuwloXrKbf3etKjbhoGibNl0hbl4JqlesukvDNVcrZz7
	JYkFiuHyXReophKpJGh4gSeKB6OgAjt06t91PLzOA=
X-Received: by 2002:a05:620a:6cc1:b0:920:56af:ceee with SMTP id af79cd13be357-9208ef628d6mr1675860985a.17.1782036530765;
        Sun, 21 Jun 2026 03:08:50 -0700 (PDT)
Received: from claudeLX-01.hammies.cc ([165.173.24.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921db359a7csm545405085a.38.2026.06.21.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 03:08:49 -0700 (PDT)
From: Alvin Lim <alvinwylim@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alvin Lim <alvinwylim@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Date: Sun, 21 Jun 2026 18:08:44 +0800
Message-ID: <20260621100844.1224301-1-alvinwylim@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
can be handed DMA addresses above 4 GB - it silently corrupts data in
transit. Reads return different, wrong data on each access. SMART is clean,
there are no SATA link resets and no MCE is raised, so the corruption is
invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
or, on Ceph, mass scrub errors across multiple independent filesystems at
once - i.e. host-level, not filesystem-level.

This is the same failure mode already quirked for other controllers that
falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
The ASM1166 currently maps to plain board_ahci with no DMA limit.

Limit the ASM1166 to 32-bit DMA. 32-bit is the guaranteed-correct lower
bound; the only cost is extra SWIOTLB bounce-buffering on transfers above
4 GB, negligible for storage. A future change can widen it to the
controller's true addressable width if characterised. Until this lands the
only workarounds are disabling the IOMMU (amd_iommu=off / intel_iommu=off)
or using an HBA.

Reproduced on an AOOSTAR WTR MAX (AMD Ryzen 7 PRO 8845HS) whose six SATA
bays all hang off one ASM1166: with the IOMMU on, six concurrent
'dd ... | md5sum' of the same large file return six different sums; with
amd_iommu=off they are identical, and a full Ceph deep-scrub of a 5.4 TiB
/ 1.43M-object pool re-reads end-to-end with zero scrub errors.

Add a board_ahci_32bit_dma board type (mirroring board_ahci_43bit_dma)
and point the ASM1166 entry at it.

Fixes: 3bf614106094 ("ata: ahci: add identifiers for ASM2116 series adapters")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Alvin Lim <alvinwylim@gmail.com>
---
 drivers/ata/ahci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 58f512f8952a..895956c2ca15 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -48,6 +48,7 @@ enum {
 enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
+	board_ahci_32bit_dma,
 	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_no_debounce_delay,
@@ -132,6 +133,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_32bit_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_32BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_43bit_dma] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
 		.flags		= AHCI_FLAG_COMMON,
@@ -1559,7 +1567,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	}, {
 		/* ASM1166 */
 		PCI_VDEVICE(ASMEDIA, 0x1166),
-		.driver_data = board_ahci,
+		.driver_data = board_ahci_32bit_dma,
 	}, {
 		/*
 		 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is

base-commit: 322008f87f917e2217eeac386a9410945092eb2e
-- 
2.47.3

