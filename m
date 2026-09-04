Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B0381B0E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497368; cv=none; b=gIm0Yx2Ffe0uDlIuUmv39Kn/arJ2nKqrHn9xBYvkHG50Y3GwkMcc436W2MK8hBdKzOwx9UxllrrB6+609pybjcVJUQs6lQWHq2zvJ6CfnX8DdIzmG3V+1bMB1u+pzW+9mhXP91Vi1TPCcWUwoZz2eRu78JMqQ6xyoDzYr76D0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497368; c=relaxed/simple;
	bh=rDI0G8swHPkucGF+LtiAfLVpBZ+UGHXJ/rpyLuOV0Fc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bKXeCHtQNGHLhP8M14RfA/6qxeJH5/knuoQ7jzegAjGJGeKf0HlTCQ8QRVI3XIRiNYICLaLI7cBJsAqNd2vYxE3IGwWZnMgg+UTVyk/jrKl6frN6BqKNXLwespZf120Z8QQ6rupnClUQYp1FYmjmWrXGXKeBazfaqbmZubEXClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcVrQGSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcVrQGSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39091F00A3D;
	Fri,  4 Sep 2026 04:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497367;
	bh=N0j5u7Uts46B0lOY5qvImPiqA5VEcyVFmT+rteGBDV8=;
	h=Subject:To:Cc:From:Date;
	b=UcVrQGSRAWDUKTlAokUFBiS7RUEqk7d7ywanU84BjKVwi2h9BFerS4h1IZ+CVxPFy
	 3fGwIzy9sFATVxoWXuAgdu7inQREfOShaBxc0qIsNpYCSS1IX6NTv1DIdZ3W4I6D96
	 dL0E+ZIc46Q+svXlwkQ5UJvWTwzPzawsxVRbI1c4=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: bound the device EEPROM address before" failed to apply to 6.18-stable tree
To: hexlabsecurity@proton.me,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:49:14 +0200
Message-ID: <2026090414-routine-poster-2605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 13b3c29a782033ce4a230be9e5618032813dbcd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090414-routine-poster-2605@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13b3c29a782033ce4a230be9e5618032813dbcd4 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 25 Jun 2026 07:10:27 -0500
Subject: [PATCH] wifi: mt76: mt7996: bound the device EEPROM address before
 the EFUSE copy

mt7996_mcu_get_eeprom() derives the destination of the EFUSE/EXT block
copy from the address reported by the MCU response (event->addr, a
device-controlled __le32) and clamps only the copy length, never the
destination offset into dev->mt76.eeprom.data. A malicious or
malfunctioning device can report an arbitrary address and drive an
out-of-bounds write of up to MT7996_EXT_EEPROM_BLOCK_SIZE bytes past
eeprom.data.

Reject a response whose address would place the copy outside eeprom.data
before deriving the destination pointer. Devices that echo the requested
in-bounds offset are unaffected.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260625-b4-disp-16f99062-v1-2-aee52ecf61b9@proton.me
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2e83f4b79c87..a1bae5db8500 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4352,11 +4352,18 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_l
 	event = (struct mt7996_mcu_eeprom_access_event *)skb->data;
 	if (event->valid) {
 		u32 ret_len = le32_to_cpu(event->eeprom.ext_eeprom.data_len);
+		u32 block = mode == EEPROM_MODE_EXT ? MT7996_EXT_EEPROM_BLOCK_SIZE :
+						      MT7996_EEPROM_BLOCK_SIZE;
 
 		addr = le32_to_cpu(event->addr);
 
-		if (!buf)
+		if (!buf) {
+			if (addr > dev->mt76.eeprom.size - block) {
+				dev_kfree_skb(skb);
+				return -EINVAL;
+			}
 			buf = (u8 *)dev->mt76.eeprom.data + addr;
+		}
 
 		switch (mode) {
 		case EEPROM_MODE_EFUSE:

