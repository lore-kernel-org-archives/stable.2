Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA83346ACE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497385; cv=none; b=XQ6GfyZlhkIAK9dM46fd9HtRk9n2tZn8dtHaL4QTexmIkuxm+7dXodXN8xwjr0OysrIlZwX6e2BqgzOHAlaaPwLP/QG5QKDkIjze4eFKM1vBp/OMp9c2f0uXLxwUmkYtpSXdubwHSpJHEQy7VThl4ttJ3nO8+dElmZOf1PGAxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497385; c=relaxed/simple;
	bh=PUUgb1Nntgj2iskvQWUWgi4UeeWnZKZ8hxiMgUmDJAM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XGnnNDrALoB5Gb3gk0j3V0YEmeIm1vDX4xW2BfBoSAvN7bM4DwygSEOCtuHEOWekqrg1PRSwpBy77yUo36rUQdoGV3xUZX9wazLC2IbuYw1wBcZmv22Bd7sCTPspsKm4jkeqOovyEq9PI8L7p6kQyEFn13irVmqbbqVjY/YFitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZRVbX0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZRVbX0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F71F00A3D;
	Fri,  4 Sep 2026 04:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497383;
	bh=s+6s0Ra0XJrsodYYhpUahmJHAf2+namB9RQUllxJ/r4=;
	h=Subject:To:Cc:From:Date;
	b=KZRVbX0uP2Z9yup/u8lLShVjS4uBrtpKm4RW/54rBLPx53rk5h+EX+Up/hTRU45s5
	 zNjHHXU86OYQmvOrZZsffBGlhhWHP0ONZ+TW4etIZmB69A/7Xmi9sUXfDHkNFfASqc
	 tPSQW8lulr9JSnZJWkAuIHNU68dmxAHJ0Sf0nwVg=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: validate default EEPROM firmware size" failed to apply to 6.6-stable tree
To: acharyalaxman8848@gmail.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:49:32 +0200
Message-ID: <2026090432-semester-ambiguity-70b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 653c6e289b13cc6942f3e8f8e3c568e70fa42d1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090432-semester-ambiguity-70b2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 653c6e289b13cc6942f3e8f8e3c568e70fa42d1f Mon Sep 17 00:00:00 2001
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Mon, 13 Jul 2026 17:39:12 +0545
Subject: [PATCH] wifi: mt76: mt7996: validate default EEPROM firmware size

The default EEPROM firmware is parsed and copied as a full EEPROM
without checking its length. A truncated file can make the driver
read beyond the firmware buffer during variant validation or the
fallback copy.

Reject files shorter than MT7996_EEPROM_SIZE before parsing or
copying the firmware.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Link: https://patch.msgid.link/20260713115412.67095-1-acharyalaxman8848@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index ac05f7d75d63..ec33521db564 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -150,6 +150,12 @@ mt7996_eeprom_check_or_use_default(struct mt7996_dev *dev, bool use_default)
 		goto out;
 	}
 
+	if (fw->size < MT7996_EEPROM_SIZE) {
+		dev_err(dev->mt76.dev, "Invalid default bin size\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!use_default && mt7996_eeprom_variant_valid(dev, fw->data))
 		goto out;
 

