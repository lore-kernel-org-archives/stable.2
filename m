Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046158;
	b=Quw0esqFKoQcjKRv94P7cE6OoVIEjz4yYyz6YSnhTnx0c2FnQoZe4qelFuqLfryqc15B
	 uxjEW/ETL1betSk32hC88klxC2rHH/4qIeSdA4kX4IxqtxEwHc6Bp4z9wmIiwH5tBawd/
	 UVzIaHSMe4+9HwwqD35hALiz46MV+yEB0MxngtBxbDaYUs/nnk+gaw15g+6nVV75m9tuI
	 XV/axGGQCT08RfMcepDX6TP0MN0yEQR9vcq8pVU5zH87YvVvw8TV/QYAYkMWNvX6pM9rK
	 1YPYSCPh0s6/JKwkVVuTBO54LSaVGwLRycAgbZg3Uytc7n+s4RpDv1Jc3EWUYfetWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v0Pb/63HkOAYrJfyCaiSzZBboeMN1MY1V49MALIPsp0=;
	b=mQ4Ab8Q21zS9lK/KAYuK8hszV8RwvNPscI6OZQw11RIjnFFLLeZfM5cQIk4W8Q0QECIf
	 3l0naZoy/XG+3HwvLuPB0av7aEUF5+HUWBZ5W0PVDeXMtJKiC5zwBBWr78pvEjFNsreiO
	 Ae0ITiyFW70D0642n0yLZUW6zjE8cl5zgR4a+nhh49CzZ392V9ybMWY4mi27KSg5LZnLj
	 TAWvE05ld0Twa69g8ezKz0Wv05WDAUAZIEF/XnDnNT72vZcPrDa2Ywv/9Qm0ZJarLFkGP
	 4wRmD/JyZPnLqbbDCjj3GZyGO0LlyVq2RNjAffhOCcvof/6eyJXxmAyLmq4hMbsRT1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3W4RJPM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89835606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3W4RJPM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CE71F0089F;
	Sat,  7 Nov 2026 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046158;
	bh=v0Pb/63HkOAYrJfyCaiSzZBboeMN1MY1V49MALIPsp0=;
	h=From:To:Cc:Subject:Date;
	b=P3W4RJPMxkBaj8EFYyYsPawtC6y1QJWC02abvVG4yovbrSs6XWZG9pvBzeMU748jP
	 wjBffwP+p94zlYs9JBvmB2v4MGjrIWCoZyP2psx6YNjwBeDqa7LLksiyvcQzg7pOk2
	 EoRA6gLIdi5Bcc7Ew3BeOcsmCBCM6OoHU3c0dpS3aXgANPwoBuDVwZtfPYsX4pd/Jd
	 AkooR5TmDmR0y4tdEg/Hqqok3bXv7mTJHB9ZxvMkFfq2YGHHDIcz+BeKSSuFJ+AT8Y
	 ItsS8OmYqvU4sfVQ2PvmnrJiQWbVsoSca4BMug9u30abhIoRUuVdPzw7gb0iVMwFrA
	 K8druPRfxFUzg==
From: Sasha Levin <sashal@kernel.org>
To: lucid_duck@justthetip.ca,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: take rcu_read_lock in the USB/SDIO tx completion path" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:16 -0500
Message-ID: <20261107050916-failed-6.18-a7871a7ae5a8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a7871a7ae5a8625f0ba0a89454ac734c383dd538
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050916-failed-6.18-a7871a7ae5a8@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a7871a7ae5a8625f0ba0a89454ac734c383dd538 Mon Sep 17 00:00:00 2001
From: Devin Wittmayer <lucid_duck@justthetip.ca>
Date: Sat, 3 Oct 2026 16:30:56 -0700
Subject: [PATCH] wifi: mt76: take rcu_read_lock in the USB/SDIO tx completion
 path

The USB and SDIO completion path reads a station pointer that RCU
protects, without holding the read lock. Lockdep catches it on the
first association:

  mt76.h:1305 suspicious rcu_dereference_check() usage!
  no locks held by mt76-usb-status/1254.
   mt7925_usb_sdio_tx_complete_skb+0x119/0x130 [mt7925_common]
   mt76_queue_tx_complete+0x27/0x60 [mt76]
   mt76u_status_worker+0xed/0x1e0 [mt76_usb]

  mt7925/mac.c:856 suspicious rcu_dereference_check() usage!
   mt7925_tx_check_aggr.part.0+0xc2/0xe0 [mt7925_common]
   mt7925_usb_sdio_tx_complete_skb+0xa0/0x130 [mt7925_common]

mt7921 does the same, and warns once instead of twice because its
aggregation check reads the default link directly. The DMA path makes
the same reads but completes from softirq, so it stays quiet.

Take the read lock around the lookup and the check.

Tested on 7.2-rc5 with lockdep, fresh module load per arm, 4000
packets each and no change to the link:

                             splats before   after
    MT7925  Netgear A9000          2           0
    MT7921  Alfa                   1           0
    mt7921e same kernel            0           0

Fixes: dc66a129adf1 ("wifi: mt76: add a wrapper for wcid access with validation")
Fixes: c22769de2509 ("wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20261003233056.94497-1-lucid_duck@justthetip.ca
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e69978184f68c..ad1352ddf1fcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -831,11 +831,14 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+
+	rcu_read_lock();
 	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 		mt76_connac2_tx_check_aggr(sta, txwi);
+	rcu_read_unlock();
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 101f571b027f1..45bc797274262 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1687,11 +1687,14 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+
+	rcu_read_lock();
 	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 		mt7925_tx_check_aggr(sta, e->skb, wcid);
+	rcu_read_unlock();
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-- 
2.53.0




