Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AA34E744
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497344; cv=none; b=hY87awJatVmMCpSHsAgcK0c0SWDl5fcxYYnjVzLVlIbvGH243MSxE6KQDf/3alLzc6dF1mOqZcKfQPWegxzylDU59t1zjlqoIXmqGqDvLxs8FSHI7BoZigwRjDrj8w1pz6xH8z9WDDxkrsCbLlosvVpZZAxdYdxxHt+mk+J7RT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497344; c=relaxed/simple;
	bh=5NoZtRvFCaVUYPHAfCthtpQB937PppOKZsc3Q8McnVo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ebAKG0arbvR9rNJpUYxy9iOzJjaPUVV8gEpFCSTrDetm73pyczkOXdVe5tdOQghcQPU+l/r1NeOwzONmXqXxmZVV/xO+Vight8KpfRaxf1MYsHfjivLD6gzqJVY64Vt78o8ggGaTNJQHpR1Ol4uhbpzAx7I8CdbY2T6cEs6tE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDMBQXR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDMBQXR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9DD1F00A3D;
	Fri,  4 Sep 2026 04:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497342;
	bh=ZecWd3ndIy+4zMAmk4szenTnRniG6HdeQl37Lz1w77g=;
	h=Subject:To:Cc:From:Date;
	b=xDMBQXR1FycGKnlDsF5P2y1mq55EX5HCZ5f3lZa/r/KN5nxBRu+pyqxDP1w+kvWRp
	 RvJsh0a1yCcMmu5//dIjc6VTXFzMi0Hj9LEHuKiLQgPRFHyblgVEQTq45f0GQKDg8s
	 8K3bpzRz5xJej4qtN3o7ik/2th/K/NUo1yytnHJU=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7915: bound the device EEPROM address before" failed to apply to 6.12-stable tree
To: hexlabsecurity@proton.me,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:48:57 +0200
Message-ID: <2026090457-perpetual-gallstone-572d@gregkh>
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
git cherry-pick -x 44b5adfe49499f53002737f5fe81d608c08122fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090457-perpetual-gallstone-572d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

