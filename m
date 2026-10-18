Received: from mail-out-3.itc.rwth-aachen.de (mail-out-3.itc.rwth-aachen.de [134.130.5.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97574CF49B;
	Sun, 18 Oct 2026 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.130.5.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322549; cv=none; b=kyh5hF/t12q05BxsUMZzrR/cBTvPXyw5lKCPpFAhD/I6x76wDSKAkw0R109Qb2i89/6H3R6/+YREUEF7J2u7HNjdtWBs/BqklbVM0xQB0I7x2E0Hjarhp7cNQXUgvQsb9ZZAscmLotqGNQo4gkbTzj4DVEznDOl3SYQXo2heQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322549; c=relaxed/simple;
	bh=/jvxOavyqf6JKvXUc8LNrLvhLT4JhLjHd5uL73Mm1AY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YhIiF9omm8CX5q5uqfS4iUw7qEb7yB1mV7CdPqfHlF7BOeVlIlh1DYD+7VicAke8dBRXbKt0ejrHL2T1Bqo5Qq3dDhutWw4PsZASyBPXsr2k6hkZ5f9Q7WRFQIf7ggowtmj5+2ST6wkApTB2lbQwjz+R7NmngjFlO4B1sHLUBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rwth-aachen.de; spf=pass smtp.mailfrom=rwth-aachen.de; dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b=aaUvPHOp; arc=none smtp.client-ip=134.130.5.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rwth-aachen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rwth-aachen.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b="aaUvPHOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
  s=20240516-RWTH; t=1792322544; x=1823858544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iKxZGMdkB05646i9vrZdqtUXJWd7gA2lSMwIXWflxxg=;
  b=aaUvPHOp1DsQVCvkBYZF19xuDxwJ0N9L0jGFALsf/0MgjODXcwH4CJ9w
   JBwuwSa23xhtpPPHiqjtZoAYcd8GlhJdgaXZoNk2psS2m1up5LsyICRKx
   YRbca9qU4DO9zKmzEJe7Xw6RW1tgN56OfuwefawQbAoOLaqOwJVwHWPPk
   GBNGeNjXOc/hwMeCJNLoY6mdG5tZt2oO8pzQe6j0Y0HmXN4A8yE+L5+O9
   KuFpXztPNNukOP7iBANW34n9I5dH2lifb+X84R6Xz/J4H2TcKip8dcMK5
   f9lqztf+8FICPdDhYo6WHlhBWNoBgG52PzDIw8uenESUKdfEacj/ADg18
   Q==;
X-CSE-ConnectionGUID: DwHOB9DNReClCySJDLVIHw==
X-CSE-MsgGUID: osTYjOwwRseRDxS5/NcLcg==
X-IPAS-Result: =?us-ascii?q?A2ASAgCDqtRq/5wagoZaHgEBCxIMggULgleCYZdgnQmBf?=
 =?us-ascii?q?g8BAQEBAQEBAQEIAVEEAQGFBY4XKDQJDgECBAMCAwEBAQEBAQEBAQEBAQoBA?=
 =?us-ascii?q?QYBAQEBAQEGBYEhhglTkEALATkNgT0OBYMCgnXAYTOBAYUL2T2BaAELCQEKA?=
 =?us-ascii?q?YE4hXKCbQGFA3aFMoFVRIEVgnMHb4UQhXgEgy6XN0iBAngsAVUTDQoLBwWBa?=
 =?us-ascii?q?AM1EioVbjIdgSM+Fy9YGwYFgR2BIIIWIxk2eoEJXoErKWABEBeBCYIHAoJUg?=
 =?us-ascii?q?gACAUlBDgdFUwklQxJHJiIIEgkBExowC4EbODwJKAQ9FwxzDB0FcggCDQkHT?=
 =?us-ascii?q?RgNSBEsNxUZQm4HkioegmWBDoJdLQiSfoMsr200B4I5gWiBYAYMgwGcaU2EB?=
 =?us-ascii?q?JNdkw0BmQiCWaIBhD4CBAIEBQIYgWiCFTMaJIM2UxcCD+BGdz0BAQcCBw4DC?=
 =?us-ascii?q?4FokX4BAQ?=
IronPort-Data: A9a23:l++H16lzgUhzuaMueIRJx1/o5gxUJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNXW3VOv+CNDT1etp/OYWyo00O7ZfVmNAwHgdl/H9kEltH+JHPbTi7wuYcHAvPdJGZHBI/h
 yk6QoOdRCzhZiaE/n9BCpC48z8hk/nOGeqkYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWQrWo4ow/jb8k025K2i4GpwUmEWPJingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahw7id/
 O5wWamYEm/FCIWRwrhHA0kAe81JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwp6KTkmy
 BAWFNwCRjycp8WckZ6dcORHgu8yF+vHGL0+mm41mFk1Dd5+KXzCa7/V+d9VzHIv34VHW+zBe
 8pcYDYpYBmojx9nYwxLTstlxKHy2D+mLmMwRFG9/MLb50DMxQht3aKrL9ffd8aiX9pJngORr
 2nG8mK/Dhxy2Nm3kmfcqCvz17Wf9c/9cIUJKIy60eF1ukae/EADM0BRc1Cfqvbs3yZSXPoac
 ST44BEGqak06VzuVd7gWRGQvnGJpFgfVsBWHul87xuCooLbywzFQHYZJhZadNUssMIeWzMnz
 BmKksnvCDgpt6eaIVqF+62ZvRuqNDIYPSkJd0csUQoa6tjLu5wog1TESdMLOK2ykNTxFC/Yy
 jSWqCk4mqVVitQEv42//Fbak3evq4LPQwod+AraRCSm4xl/aYrjYJangWU39t5aM5qZQ0nEo
 yFBko6E8/wOSJiB0iCAKAkQIIyUCz++GGW0qTZS81MJrlxBJ1bLkVhs3QxD
IronPort-HdrOrdr: A9a23:vE1Rb6mr4AVUWSPMtMNXi3EBpd/pDfIp3DAbv31ZSRFFG/Fxl6
 iV8MjzsiWE6gr5OUtQ/OxoV5PvfZqxz/RICOoqTNSftWvd2VdARbsKheDfKlXbaknDH4Vmup
 uIHZISNDWmZmIK6/oSmDPZLz92+qjhzJyV
X-Talos-CUID: 9a23:5jK6H2EmptN0HuZgqmJL624zMJEJVEfQ53P7MnSaJUJXaZ2KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Aao0O7A1fBWktDvzcDtFr0J98KjUj5L+SOUIqjoo?=
 =?us-ascii?q?8oMS+GTxLZnC7hxC8Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,165,1787004000"; 
   d="scan'208";a="351217928"
Received: from rwthex-w1-a.rwth-ad.de ([134.130.26.156])
  by mail-in-3.itc.rwth-aachen.de with ESMTP; 18 Oct 2026 13:21:13 +0200
Received: from spucky.fritz.box (2003:d1:2f12:ef00:cbcb:ad65:990:c533) by
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sun, 18 Oct 2026 13:21:12 +0200
From: Walter Weber <walter.weber@rwth-aachen.de>
To: <linux-sound@vger.kernel.org>
CC: "Geoffrey D . Bennett" <g@b4.vu>, Walter Weber
	<walter.weber@rwth-aachen.de>, <stable@vger.kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasiliy Kovalev
	<kovalev@altlinux.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: usb-audio: Fix Scarlett 8i6 Gen 1 router source numbering
Date: Sun, 18 Oct 2026 13:20:09 +0200
Message-ID: <20261018112012.41807-1-walter.weber@rwth-aachen.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156)

The router source numbering in s8i6_info is identical to the 6i6 entry
and was never verified on hardware (it is marked "untested..."). On a
Scarlett 8i6 1st Gen everything after the analog inputs is off by two:

  - "SPDIF 1/2" select values 16/17, which carry no signal;
  - "Mix A/B" select values 18/19, which are the actual S/PDIF inputs;
  - "Mix C-F" select the actual Mix A-D, and Mix E/F cannot be
    selected at all;
  - the matrix inputs cannot be fed from S/PDIF.

The real numbering was measured on the device by routing known signals
(PCM test tones, mixes with distinct gains, an S/PDIF out-to-in
loopback) and checking which source value arrives in the capture
stream:

  PCM 1-12      0-11
  Analog 1-4   12-15
  (no signal)  16-17
  S/PDIF 1-2   18-19
  Mix A-F      20-25

Correct the offsets and enum lengths accordingly, and update the
(currently unused) matrix_mux_init table to match. Values 16/17
remain as placeholders (shown as "Analog 5/6") since the enum maps
items to source values linearly.

The 6i6 entry uses the same layout and is also marked untested. It is
left unchanged since I have no 6i6 to verify it.

Tested on a Scarlett 8i6 1st Gen (bcdDevice 2.60) with v7.2.11.

Fixes: 76b188c4b370 ("ALSA: usb-audio: Scarlett mixer interface for 6i6, 18i6, 18i8 and 18i20")
Cc: stable@vger.kernel.org
Signed-off-by: Walter Weber <walter.weber@rwth-aachen.de>
---
 sound/usb/mixer_scarlett.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 6808730ef..ac0fb2e88 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -999,7 +999,11 @@ static const struct scarlett_device_info s6i6_info = {
 	}
 };
 
-/*  untested...  */
+/*
+ * Router source numbering, measured on hardware: PCM 1-12 = 0-11,
+ * Analog 1-4 = 12-15, 16-17 carry no signal (shown as "Analog 5/6"),
+ * S/PDIF 1-2 = 18-19, Mix A-F = 20-25.
+ */
 static const struct scarlett_device_info s8i6_info = {
 	.matrix_in = 18,
 	.matrix_out = 6,
@@ -1009,15 +1013,15 @@ static const struct scarlett_device_info s8i6_info = {
 
 	.opt_master = {
 		.start = -1,
-		.len = 25,
-		.offsets = {0, 12, 16, 18, 18},
+		.len = 27,
+		.offsets = {0, 12, 18, 20, 20},
 		.names = NULL
 	},
 
 	.opt_matrix = {
 		.start = -1,
-		.len = 19,
-		.offsets = {0, 12, 16, 18, 18},
+		.len = 21,
+		.offsets = {0, 12, 18, 20, 20},
 		.names = NULL
 	},
 
@@ -1034,7 +1038,7 @@ static const struct scarlett_device_info s8i6_info = {
 
 	.matrix_mux_init = {
 		12, 13, 14, 15,                 /* Analog -> 1..4 */
-		16, 17,                          /* SPDIF -> 5,6 */
+		18, 19,                          /* SPDIF -> 5,6 */
 		0, 1, 2, 3, 4, 5, 6, 7,     /* PCM[1..12] -> 7..18 */
 		8, 9, 10, 11
 	}
-- 
2.56.0

