Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C311A6836
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790480017; cv=none; b=N0nZN6sU6rAiFHUp3gda6XU0GDTdAEbCQnYiMHCDUYiqbrFnE8GuFC+Ib3nutnad9CvzkiVuHTt28JDeX6L1qSviqV86ElTVZnGdvSu63oagmRJft8Q9CGokOwSbRaXBMo9K9MojumYHuhx6pj77dA3Y5r0hXCUFl/WYqHwD5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790480017; c=relaxed/simple;
	bh=e/EAw6/IQ7mM/L+HlUNAqUw/O+rqmMNCqI/jXY+8juE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De4P1h/ZPDdqguXnTJ3xgmC5E9ldpcgQmNn2VlaMxtRO2RGrvu8xcelEpl9YRatOtHpze2VPB0pbPn/8EhpZgOK8gfakF4F5BcWwNEmXKnLFmnmjp2wKWFvSdATFkKRWspn2c1ehi7RfuCiQgTEFvQRi+qpP/2ex8QiGpUp+lkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXb4UoYg; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXb4UoYg"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-343990e8ee2so732278eec.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 20:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790480015; x=1791084815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdYuYpwE4cvE2mw1XKxLJsRdT/oc4T7/0BTKkcilQOk=;
        b=HXb4UoYgTzv65eR/Mh/UwUIXQNLl/Jp2uDksCkS7xyxDKfMuJl/rzPZ0sNUYUl/GrR
         x52j6OfZ7CHs+BLGFNatzEKH4vA2tX1E6l4aLkQ28svOBiaV+JZBd9E5xvaTU98bf8VC
         DhLu26/NrGQfCOkjV+l0IHZpjO1msx7VPkaR+2ahK4g9yDVAPKGESq5MW1pZMTxqj5Gf
         p5Kp13xApWn6yRslHtPS8JTMvviiTqr4LJfGtk4LuKhsA7lvbPd3ViqMemxm/JDGF4T3
         8lvdoiqAdinEloc16BgNs3N7TsuXqLXjzE0rbCYkCkpfr7kZvQlxk80fHATZ4cCaQ+2U
         CJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790480015; x=1791084815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdYuYpwE4cvE2mw1XKxLJsRdT/oc4T7/0BTKkcilQOk=;
        b=t/STneVYrs2W5dftWLHGt60tUnW9s4j0Ns0s1bgeTNdUAIEB81YVTtRT+6DQHgWvmM
         vV7lshCgGP5RGpb/snwc0iNEGNaXKZdw6ovVrC0DHK1cJ+z9Gh/pLEJg2txZHqnsEknV
         69GjXsSgaX6fbHj5lNDpd5eCGX/w05JgyjETVbH/fCnGL+ddGdiQZvbygf7QKs60YKmN
         m6je4nznogO9r86uKh2+OezNrY1HOkkCM/bja6OJ1LoxNjoeHFxmGXZbm0YEGOIQ397+
         DlL36yOup8GU5uao453NaOIvHhlxaJ8ukpNBRzOU347pchevA6U0zAp1F6tyMEkYCmDK
         HSoA==
X-Forwarded-Encrypted: i=1; AKwUvBwViGyCDFNZiAAuBCj/0IDRukNVVJKQAAsfalfw2VVqimzYwduZz8qs6YNtOPjyq7746fSWV9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfKyJ4NZpRWIjKT6DuosQ4AtlzF1Z9maoaTEUd7fpQghn6yygZ
	6/fN4djYzeoL5MvWTit8tx3NrSAiKHftfgurgJsuuMJuTEqTldIs1naq
X-Gm-Gg: AYBFou0NzpA3Dxgdqr4WAtmhTuccflz7W95KqoAXhPtrCsMstiVCWISatnCypawbi/W
	9tKxtE9cdg87/FpPnrD2y2xmsMhNa3p7RAQchyC9F6aD7AtR8Ao47Jr3oZnwE/tYV8cSFuZcPoK
	xF05Sk3GCf5X61M3GA9NuDsMEnjri19NI5/4gbtzXDlhz3VOdIM7KGuVsw36IZIwgakvni/ly2d
	3A/59HBSz1MTsodY2OX7VzGvbgTCyo5R6UYd5Z12MolQrxmly6pvvIrsOHufndJlMnOS8RI+Zeb
	n+UpDgs9XOSSOiHZ7ypL9BnNZsHHDIHWstUoVy7spMeVb6w3MEta9LhyNOwijyaFAxG9l9Z+RJZ
	hKTOOFO8g7Hyk+Dooix2dRcdn0HfbkQ8uMHruA055VzDN6cYVcspnTtciLZPxk9AqPr7Lih+cR1
	8705lHAQQVVlaI/2aQwdSD21RAECLcw99aNKAz9iwbqjU66Pzph68PXSKwtrJetWcsofwo799CM
	bgO0kWJP/az2Zwb7UmjJQa8Wxvms73n8zpxxyWY0gBml5euAOCmU75OouJcMbk=
X-Received: by 2002:a05:7301:fc11:b0:33e:904f:9832 with SMTP id 5a478bee46e88-3426febb10emr4832959eec.8.1790480015308;
        Sat, 26 Sep 2026 20:33:35 -0700 (PDT)
Received: from Raccoon ([2409:408d:3296:6184:5a54:7918:9f72:6043])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3416e4c2f50sm18559891eec.27.2026.09.26.20.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 20:33:34 -0700 (PDT)
From: Rohinthan P <rokinthanp03@gmail.com>
To: hverkuil@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+caaca441bae2799984d3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH fixes v3] media: vivid: check for NULL dev in vivid_probe() control setup
Date: Sun, 27 Sep 2026 09:03:06 +0530
Message-ID: <20260927033306.14125-1-rokinthanp03@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926084318.12161-1-rokinthanp03@gmail.com>
References: <20260926084318.12161-1-rokinthanp03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vivid_probe(), after creating instances, the driver iterates
through vivid_devs[0..n_devs-1] to populate HDMI and S-Video
'Connected To' controls. However, it dereferences dev->has_vid_out
without verifying that dev is non-NULL.

If an instance fails during creation, vivid_devs[i] remains NULL,
causing a general protection fault:

    Oops: general protection fault
    KASAN: probably user-memory-access in range
    [0x0000000000005f38-0x0000000000005f3f]
    RIP: 0010:vivid_probe+0x579/0x10d0

Add NULL pointer checks in both loops in vivid_probe() before accessing
vivid_devs[i].

Fixes: d7c969f37515 ("media: vivid: Add 'Is Connected To' menu controls")
Cc: stable@vger.kernel.org
Reported-by: syzbot+caaca441bae2799984d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=caaca441bae2799984d3
Signed-off-by: Rohinthan P <rokinthanp03@gmail.com>
---
Changes in v3:
- Add "fixes" branch prefix to subject and base-commit info targeting
  media-committers.git fixes branch to satisfy media-ci test-valid-ancestor check.
- Add Cc: stable@vger.kernel.org for media-patchstyle check.

Changes in v2:
- Remove .suppress_bind_attrs = true so driver bind/unbind via sysfs
  remains supported as required by the test-media test suite.
- Update author name to "Rohinthan P".

 drivers/media/test-drivers/vivid/vivid-core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 62cfb5f..1860ad6 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -2116,17 +2116,19 @@ static int vivid_probe(struct platform_device *pdev)
 	for (int i = 0; i < n_devs; i++) {
 		struct vivid_dev *dev = vivid_devs[i];
 
+		if (!dev)
+			continue;
 		if (!dev->has_vid_out)
 			continue;
 		for (int j = 0; j < dev->num_outputs && hdmi_count < MAX_MENU_ITEMS; ++j) {
 			if (dev->output_type[j] == HDMI) {
-				vivid_ctrl_hdmi_to_output_instance[hdmi_count] = vivid_devs[i];
+				vivid_ctrl_hdmi_to_output_instance[hdmi_count] = dev;
 				vivid_ctrl_hdmi_to_output_index[hdmi_count++] = j;
 			}
 		}
 		for (int j = 0; j < dev->num_outputs && svid_count < MAX_MENU_ITEMS; ++j) {
 			if (dev->output_type[j] == SVID) {
-				vivid_ctrl_svid_to_output_instance[svid_count] = vivid_devs[i];
+				vivid_ctrl_svid_to_output_instance[svid_count] = dev;
 				vivid_ctrl_svid_to_output_index[svid_count++] = j;
 			}
 		}
@@ -2134,13 +2136,17 @@ static int vivid_probe(struct platform_device *pdev)
 	hdmi_count = min(hdmi_count, MAX_MENU_ITEMS);
 	svid_count = min(svid_count, MAX_MENU_ITEMS);
 	for (int i = 0; i < n_devs; i++) {
-		for (int j = 0; j < vivid_devs[i]->num_hdmi_inputs; j++) {
-			struct v4l2_ctrl *c = vivid_devs[i]->ctrl_hdmi_to_output[j];
+		struct vivid_dev *dev = vivid_devs[i];
+
+		if (!dev)
+			continue;
+		for (int j = 0; j < dev->num_hdmi_inputs; j++) {
+			struct v4l2_ctrl *c = dev->ctrl_hdmi_to_output[j];
 
 			v4l2_ctrl_modify_range(c, c->minimum, hdmi_count - 1, 0, c->default_value);
 		}
-		for (int j = 0; j < vivid_devs[i]->num_svid_inputs; j++) {
-			struct v4l2_ctrl *c = vivid_devs[i]->ctrl_svid_to_output[j];
+		for (int j = 0; j < dev->num_svid_inputs; j++) {
+			struct v4l2_ctrl *c = dev->ctrl_svid_to_output[j];
 
 			v4l2_ctrl_modify_range(c, c->minimum, svid_count - 1, 0, c->default_value);
 		}
-- 
2.53.0

base-commit: 2579cbe68005f46fc7f8f95364f6b101b07b9d1c
