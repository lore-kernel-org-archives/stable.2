Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AEE3A16AC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497374; cv=none; b=j+9dRrI+pkFjqvYBvs49khg5FP9/77ClmLdHzHMtzUKWE1gHtK9h1P5MOtlBth4DkaeQE98SdcZd3p1YJHW7GftJ2D8HrUuhJuF0rMYoVwf3It7USNxYHNjEBl9GSxKinWzV3TSgh5tEZAwozgDmZbGYCj0NbqrIv7IifZ/mz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497374; c=relaxed/simple;
	bh=h1w2MyhDFC10skh/sAuZxdzmstcQ94RqtYtmtO5jUZA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OVuZAuMzJb/WAi9uo0fCO+fX+rMN3r0cmpqYj8x2MNl9CbMnNsqFeBLGow+MSr6bx/VYur6cqXuXW7nafiLl/HT8JBFBcFqddHXQN1YSa6SmgJ9v/oIqsHdKpG3c7ZevvJccDcFwGUAn6aydsSnGr5taEk6B1gjgsIo6hmleKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyE1ZAid; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyE1ZAid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649A41F00A3D;
	Fri,  4 Sep 2026 04:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497372;
	bh=4epd7ld/BB1bukaNGtsqiOCTG8OWJ98HTBv62KZW0bE=;
	h=Subject:To:Cc:From:Date;
	b=JyE1ZAidG2637tzDY8q3Bs4s64bRMCTYSDJIUFMZlCivlxDM4mOLPXmgnwmazEc0r
	 YbRM72jmellkREckhIymj9qvMsgcgyd/43GfJnO5z/INgOgX0cyb6n84vsWiJkMex6
	 oCxDkZ3yPdK5+uQEvTXTktrkJ4ILk2399VTmdZVo=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: bound the device EEPROM address before" failed to apply to 6.12-stable tree
To: hexlabsecurity@proton.me,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:49:15 +0200
Message-ID: <2026090415-udder-trio-ccee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 13b3c29a782033ce4a230be9e5618032813dbcd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090415-udder-trio-ccee@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

