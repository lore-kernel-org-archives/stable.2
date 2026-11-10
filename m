Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323546;
	b=VShpwRzB1LEAQ0vHcj2iLKrKDpq51x/L7oSRohzst/Z138eeaHaZemFV120n0S/QNoCv
	 +Nw6FdVbW3DYNzCwQeRTg7Cah5w0mOPQ2qEeD0LLS8+egMRwCP2lunnzPilMaii4l5Ynp
	 GSfVP1wx0b/XoN+Y+bGC+ybEGgTwkw3FXofyptneX7oM2ryNIF6xBOJZLxwQ7Q1mtEBzR
	 PvdqPnTJMJeiQIpRcVctO4sR+3uc9cGI1Hdg2SpP60t/G5snjzCq+p43fgxmO5CC6IF/o
	 5q4CB988bAfcaBmb00WVzEIB+FfFa/+UZPTkK7sZrD2Ba+ZE+bUF8lFn3UXKa0FtFOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L+qyt7YSc2T11mMX2QcSs4lj4iTxTKE0LWLE7OaOn6s=;
	b=KB6QbnlkiA1NNfJVwai6YU+6dH8APt6fNvwTbsAbVLGCBCyFbZ7yVKFVDn0t73xOOiLB
	 s8b6x4oqZKvD0KXagXRFv021iu2zrgrajZRVfw+PuBhzfpIkxgMHjYQGqZpiWIZYoAsvz
	 uU2M/CUYPZA3DFEQqTUdmnCQB6Gk1eb5FPZN0RZ5LP8E9iYX4UtoEM7JQoahrKNyZ2aj9
	 sEpYdUoJIpWRijTyWu2iyL/lA01yGHDYWIcj3nHcdBez4fb+/QTourNzOBZXfNXkP4GnL
	 cK+NCKD9Or0oeFeBKOo0nuPm7gd2TFM/zgbmCYVIRmXTFl+ntSRIFKOHzBgAZn1XB5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD+8qzkm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA60A260B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD+8qzkm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051CF1F008A1;
	Tue, 10 Nov 2026 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323545;
	bh=L+qyt7YSc2T11mMX2QcSs4lj4iTxTKE0LWLE7OaOn6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FD+8qzkm9T57GOGhc7rJSZorjtX5pIWf2gl+reaRC5FLVPLd9NcRoklZdYZDplm+T
	 7RhJSeq+J5oIxm8KRKWlbmBsFSxTXPMpHBxNDWNv/kJPDlVomeumgp5pYf/Grj3yp1
	 Z9cTLCnb3FuYjjFV1e19yzQ8/2gPDIxVcwqIWyzq2w9N/F0mKsdTZORiylf09Dy8Wm
	 hFbAP19k1A1PlvfpkLJIquV1RG8xK6DSH8zUpPb0mPg52blwl0CHvbmibueWDABbDG
	 g592RCMBe2sZtEpJN7FjDlvy+2U7ECHzqbljNBtl9Eybhibgg7U37anUH9V7jFg0Sj
	 3UGsOUKm0b7tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] ata: libata-eh: Rename and make ata_set_mode() static
Date: Tue, 10 Nov 2026 10:12:19 -0500
Message-ID: <20261110150946.1943054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051701-failed-6.12-96fdeb7e3fd8@kernel.org>
References: <20261107051701-failed-6.12-96fdeb7e3fd8@kernel.org>
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

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 6ba4d05c1425fe220d95395b4485443ce895bb95 ]

The function ata_set_mode() is defined and used only in libata-eh.c.
Make this function static and rename it ata_eh_set_mode() to make it
clear where its definition is.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Link: https://lore.kernel.org/r/20250703103622.291272-4-dlemoal@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Stable-dep-of: 96fdeb7e3fd8 ("ata: sata_inic162x: remove dangerous broken driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 9 +++++----
 drivers/ata/libata.h    | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 32ec1cfd648e3..1cf737f17d0a3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3248,12 +3248,12 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 }
 
 /**
- *	ata_set_mode - Program timings and issue SET FEATURES - XFER
+ *	ata_eh_set_mode - Program timings and issue SET FEATURES - XFER
  *	@link: link on which timings will be programmed
  *	@r_failed_dev: out parameter for failed device
  *
  *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
- *	ata_set_mode() fails, pointer to the failing device is
+ *	ata_eh_set_mode() fails, pointer to the failing device is
  *	returned in @r_failed_dev.
  *
  *	LOCKING:
@@ -3262,7 +3262,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
+static int ata_eh_set_mode(struct ata_link *link,
+			   struct ata_device **r_failed_dev)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
@@ -3900,7 +3901,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 		/* configure transfer mode if necessary */
 		if (ehc->i.flags & ATA_EHI_SETMODE) {
-			rc = ata_set_mode(link, &dev);
+			rc = ata_eh_set_mode(link, &dev);
 			if (rc)
 				goto rest_fail;
 			ehc->i.flags &= ~ATA_EHI_SETMODE;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 4b3e246227e68..898d5b368d82f 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -199,7 +199,6 @@ extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
-extern int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset,
-- 
2.53.0

