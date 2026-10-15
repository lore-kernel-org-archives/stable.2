Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A93E9584
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039964; cv=none; b=K6reWjXSp9wC43v3M22ECv8NkamfD8UjJqdvxjydtOQWPOJzeAH/eW0BqU9lalMRGSHO+yeK5S0QqXx8Thz2X7LVtl9c8z5dMR8WZpZjUs/Iwb/uwseUFNIGlsSAK6ic5YuZi7/ul99t0TwuN4Vz+taOpRBEKtt/kBXWJmm8IFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039964; c=relaxed/simple;
	bh=rYJvJvnkgZtKchfVvlvx9ACL3kl2ex3CJVfJAmwIQMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GthsTOZr1bdmDT8x1qKP30qTiMUtO24DqBIWJ8DXGAONLuRUDv3eBrRC1t4IAxvHI8IuLZuh7jhNQUBkPGcnTSUycbZMXsvGTET1otSkDf2e/m2Zuy1x1CY3Ry6FWhaq6WEpnWNlxNepy7yHHd45EPAzeUpBcpKFZLT9zYlvLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Px0ZeuYX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Px0ZeuYX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so26003125ad.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792039963; x=1792644763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1CW4E17PsqOiHZDTp/GHdRDHH51grlO5+TKs27nZFQ=;
        b=Px0ZeuYXmH/JvRJMh907f6JqeolLx31GjA4u/2OtO7OcDMGiXIaaHLISZgDjRICpyX
         77FxkEPoHgKMGqKe76ArLqsxBsiEv+4YmpDYblS4rFpysIGFWGZaZ20UVIa+E9GLxrEq
         mT2/On0Am0kfDknsmA3OUNZzwqDqTzZ67Bbdn/FauSt+J/B0Ht63VkOSOdgFMYZqNMP7
         nDnwHhVF66ZM4bJFPR95q1+jygZZ/2n/cU/ws23Krp8V8fCRviFye35BnT6YeglNqcwD
         sSiTTxabyw9XXFX260p7pxM8WQHc9FIjuLLbOS5JjTumxkQ/AgGcpsKYNKXNcQrZE37R
         ZrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039963; x=1792644763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1CW4E17PsqOiHZDTp/GHdRDHH51grlO5+TKs27nZFQ=;
        b=NjPTb7TZVdaUFln70xSPesgm55BEQptZ4lo+kQoAkSzCaIWDJb/o5Jt1KktiC58vTV
         dMcLewX5O63LdSebmlmoky3fRjA4ae8sU5lxrSQTEgdHWZdE4TpUpgRkPGwJ5KRUU0cE
         fB6bMEYkBqcZxWxzv1ydgKXTfb18rBdi78YoL4gHSUylL9MTdSxrUrxlJBOyw0tz72Fb
         E3h5hd3S9hU1EEXzcceDqycBt5q1Eqo0pjNK4AdGibSabKHFA/U4MQ6TiL2NlpRZM/qL
         vGQUApSbnwwsOSW1jClmwGmhVQbkIXfGJabCYXu8oAr8Ralc4ACNykTkTjFEp4ojF+ez
         Bnjg==
X-Forwarded-Encrypted: i=1; AKwUvByFEcmVQHZI9rk83UMqLxzSwNLyCNpdX0Js1u+NiioEAaQVxG34aekFkAXSCzQI1hnrFtm6doM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcfuBx/loscO14gOCeApmdpoI5pk2HPZ+n6RahL9qtbNebcLbO
	02uiYuD3bz22KO3ZUFspd95GNKZ3DIhdnnoHrPb4692uAlFaLfTX9UP5CBahUvH7ZIU=
X-Gm-Gg: AYBFou1+Iao6X4OsinKv5DnaGUcCRGZlCKFmzGGJZpmcaCUQ8CFTbz205Yi9tQcQKhJ
	OLQqlk1qmu9EcBvTP6CDsamDhOOQB1Qy077cuO+W/EJvYdjr+2LXtZX5zgBRcczbF5o9daEH0rd
	Rn/z6CqlO1YxaK6gQfrdfJMfthlaJDHXmaQS+KhqA0Ow5fu4nAY9QFHZ/auY5zOuoVmeIeoQNJn
	gQKRwwAnSjS6jJfhflCkAs9T/9LnTKdM7RkpZCxiSMe38k8tVY6O2cJcyFHYez8e/tTpOnnR4+P
	p1ZnS2CzhhK1YH+LxQlc7KKT/iPnORRiWOPMsExtPUPY9HbkpFr1soDR1UrxXYleSTtvR7yS2Pz
	ORIVKLr5lnB34OPvH2L8RSlPtQDQEhWzIYBxjdnwJp12iMJwTqft+ghiqmfbxMrelKwla25R3Qf
	qyGXqkzae6Hxq8ekO/2Iij3vo/rh1oMC/OKpp2iX2HOX5OQ28AOHJQytpO/erV2KpdzlnK10aQm
	K7r8w==
X-Received: by 2002:a17:903:32c2:b0:2e8:30dd:523d with SMTP id d9443c01a7336-2e8429a739emr170899815ad.13.1792039962771;
        Wed, 14 Oct 2026 21:52:42 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e962a4dfbbsm1615915ad.58.2026.10.14.21.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:52:42 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v9 9/9] scsi: mvumi: bound the firmware handshake retry loop
Date: Thu, 15 Oct 2026 13:52:13 +0900
Message-ID: <20261015045213.3975845-10-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
References: <20261015045213.3975845-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_check_handshake() drives the handshake by calling
mvumi_handshake_event() until mhba->fw_state reaches FW_STATE_STARTED,
with nothing bounding how many times that can happen:

	do {
		if (mvumi_handshake_event(mhba)) {
			...
			return -1;
		}
	} while (mhba->fw_state != FW_STATE_STARTED);

Each call advances the state machine by one step and has its own
FW_MAX_DELAY timeout, but that timeout is sampled on entry to
mvumi_handshake_event(), so it only bounds one step.  A firmware that
keeps asserting DRBL_HANDSHAKE_ISR, or that reports the same handshake
state every round, is answered every round and the loop does not end.

The firmware does not have to be hostile to keep the loop going.  The
page walk advances hs_header->page_code, which lives in the coherent DMA
handshake page, so a controller that writes that field back can keep the
walk at the same page.  The restart that mvumi_handshake() takes when the
firmware reports a status other than HS_STATUS_OK also returns to
HS_S_START without ending the loop.

Count the steps and give up after MVUMI_HS_MAX_STEPS.  A handshake that
completes needs four fixed steps plus one per page the firmware asks for
in the u8 total_pages, so 259 at most, and a restart adds two; 1024
leaves room for both and still terminates.

This does not change what the driver writes to the firmware.  In
particular, the HS_S_ABORT that mvumi_handshake() stores into its local
hs_fun before returning -1 is still never written to the doorbell, so the
FW_STATE_STARTING restart continues to work as before.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 9 ++++++++-
 drivers/scsi/mvumi.h | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 994c04902fa12..a2759dbeedf75 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1334,7 +1334,7 @@ static unsigned char mvumi_handshake_event(struct mvumi_hba *mhba)
 
 static unsigned char mvumi_check_handshake(struct mvumi_hba *mhba)
 {
-	unsigned int tmp;
+	unsigned int tmp, steps;
 	unsigned long before;
 
 	before = jiffies;
@@ -1355,6 +1355,7 @@ static unsigned char mvumi_check_handshake(struct mvumi_hba *mhba)
 
 	mhba->fw_state = FW_STATE_STARTING;
 	dev_dbg(&mhba->pdev->dev, "start firmware handshake...\n");
+	steps = 0;
 	do {
 		if (mvumi_handshake_event(mhba)) {
 			dev_err(&mhba->pdev->dev,
@@ -1362,6 +1363,12 @@ static unsigned char mvumi_check_handshake(struct mvumi_hba *mhba)
 						mhba->fw_state);
 			return -1;
 		}
+		if (++steps > MVUMI_HS_MAX_STEPS) {
+			dev_err(&mhba->pdev->dev,
+				"handshake did not finish in %u steps, state 0x%x.\n",
+				MVUMI_HS_MAX_STEPS, mhba->fw_state);
+			return -1;
+		}
 	} while (mhba->fw_state != FW_STATE_STARTED);
 
 	dev_dbg(&mhba->pdev->dev, "firmware handshake done\n");
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index d998c65c26472..9597e87a08167 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -399,6 +399,15 @@ struct mvumi_hs_header {
 #define HS_PAGE_CL_INFO		0x4
 #define HS_PAGE_TOTAL		0x5
 
+/*
+ * Each mvumi_handshake() call advances the state machine by one step: four
+ * fixed steps, plus one per page the firmware asks for in the u8 total_pages,
+ * plus a restart if it ever reports a status other than HS_STATUS_OK.  This
+ * caps how many steps the driver will take before giving up, so that a
+ * firmware that keeps the handshake going cannot keep it going forever.
+ */
+#define MVUMI_HS_MAX_STEPS	1024
+
 #define HSP_SIZE(i)	sizeof(struct mvumi_hs_page##i)
 
 #define HSP_MAX_SIZE ({					\
-- 
2.43.0

