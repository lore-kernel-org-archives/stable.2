Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7335E926
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497358; cv=none; b=eEdE0pqmDl955C/BybEJvN18UPrA+N1yBXoM7WG80nv9TR8+6OQk4zsCbdntWj274EzrpeULbphPOTE9En8EjCHXrZtpL5EmYtrw3lmoczzzr0mSZTCOYHcqIDH3j4n4OnGsfZyTJGC5tJgbp9UYrot7GbhmVcUsfBkNY4p5V80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497358; c=relaxed/simple;
	bh=3AxQRs8W8xOqLo9JE0x50TKOMixhg3xPNkLNDPfFcYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XhaE/9GGGbHQwDiaicmr2xbH9tpTpzdBg65ggHhPJOrz33Fu1t7u86wm9qfuB86aEvPQvCQesJ0LyBcuEjBL/s92icI4SwZ91JYAad0NRzy4amXAODTkcIy+Xz7XWbzlL6J3c1NzGWCyXAnEOfR6BOGM2AE9JXx70JyodD9oVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xSkk1p4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xSkk1p4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED40D1F00A3D;
	Fri,  4 Sep 2026 04:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497356;
	bh=iEk2pm4W7CqjUmzzRnFvhe018XWyTXRtGhUl9w9ava4=;
	h=Subject:To:Cc:From:Date;
	b=xSkk1p4OTKfFlH+YIJEJ5Q5uw9s8LPtq7e/363DjOdtRhR2238V5DuAsUIiBJ51EK
	 NQo7LNKRB9UiTxY2H051XPQq1Cu9Vz1LA3AinicNaNoy+/z2yMBAYQcfKSwxRZIJb5
	 1ugmZ1a7wS8V0MqoxnYJZHFdGTKKzIlyWjiak5rk=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7915: bound the device EEPROM address before" failed to apply to 5.10-stable tree
To: hexlabsecurity@proton.me,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:48:58 +0200
Message-ID: <2026090458-lion-librarian-5f33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 44b5adfe49499f53002737f5fe81d608c08122fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090458-lion-librarian-5f33@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44b5adfe49499f53002737f5fe81d608c08122fc Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 25 Jun 2026 07:10:26 -0500
Subject: [PATCH] wifi: mt76: mt7915: bound the device EEPROM address before
 the EFUSE copy

mt7915_mcu_get_eeprom() copies a fixed EFUSE block into the driver's
dev->mt76.eeprom.data buffer at the offset reported by the MCU response
(res->addr, a device-controlled __le32) without checking it against the
buffer size. A malicious or malfunctioning device can report an arbitrary
address and drive a 16-byte out-of-bounds write past eeprom.data.

Reject a response whose address would place the copy outside eeprom.data
before deriving the destination pointer. Devices that echo the requested
in-bounds offset are unaffected.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260625-b4-disp-16f99062-v1-1-aee52ecf61b9@proton.me
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e8fe86f93309..bbb2fedacb25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2917,8 +2917,15 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset, u8 *read_buf)
 		return ret;
 
 	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	if (!buf)
-		buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	if (!buf) {
+		u32 addr = le32_to_cpu(res->addr);
+
+		if (addr > dev->mt76.eeprom.size - MT7915_EEPROM_BLOCK_SIZE) {
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
+		buf = dev->mt76.eeprom.data + addr;
+	}
 	memcpy(buf, res->data, MT7915_EEPROM_BLOCK_SIZE);
 
 	dev_kfree_skb(skb);

