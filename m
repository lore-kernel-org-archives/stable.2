Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802091;
	b=2ZT3ksksHMpovSioxVZ3BVnqPDoz+tCZjrYdb8c+X/OoJrOkMrfidT5+xwXEzYqrIBrv
	 088SOtMp/4m1hJ45hVy4cJ/nMNyRr2ThrTYQrtAjE0LYh+k9uyrptBcQEx8FqYEaU16nS
	 C8Pw5fEFISqiZjDhr5sErxSQPwMHPCv4eTiUkgHCTTBXeffiB1DDduDqB1BtiwUN+3DhS
	 g4rZvMshO80DXRpNlmCIiA1T1a0VTO/98eoIsZrI0piI6oirgGEk0qLZcJcytdDS5aeXB
	 6Xv8wOBi1WEI2MJhY2ewn8cFxLwT2aBDoia8Dx82DTFqZaOqxVc9+L4N6ToZMkzUY2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802091;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L+cd+dCSY0OpGvoqFfEHL29/LvoUj8DIlUGPlH1eOCI=;
	b=ODrUV0hmirBd0qiIUxB6kKLkurAdH+rsyLzDdtwdxrjinNZ8Fcg8P8JO2UB12O8QOx8K
	 fSCq84ACy3MwnTOamCsfd8hZ8nSfxNTgtC6kCxcsJXgCvVFhzzBvCfeErLz9TJvW1kmSp
	 cV8d+r5cEkmTnwRzQvMG1TXGWMWK7umDyFE2m1Zl2F+bIJoGYuccHpj7vqL98fmull1Ct
	 p0ikNyPuua1DJyVREisVpH1TGUBS4F79Dxvonqwhll82DvFu6pyPxbZXdIim0B/jkj4R5
	 f+1LPIbhfrotldzzTelFhkH+7CVQX6fWoFWM6tUSgxMcEwARHcKlVGqQG5HTPmMhCfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dU8ke4cx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027E606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dU8ke4cx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2B61F0093A;
	Wed,  4 Nov 2026 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802091;
	bh=L+cd+dCSY0OpGvoqFfEHL29/LvoUj8DIlUGPlH1eOCI=;
	h=Subject:To:Cc:From:Date;
	b=dU8ke4cxNN7XPKniBH7R5q/fREU90CZgFngDpKCBkQUkwqaDcIqXfVOnSC+wxWOVI
	 l2WaZfVYxA7PX0yEjpeOtJEfetH91aW0j9LU5x/1l6Iq6sH0JmdMsmFtmB8qsZqH4L
	 11hK1/jjX2sTi22hj0vaLPDQIazDMFKMsEZJpTLo=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the" failed to apply to 6.6-stable tree
To: enderaoelyther@gmail.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:21:30 +0100
Message-ID: <2026110430-vagueness-punctuate-be5b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 022f5f8b7a0580da50fcbc34da853d03d4321fe2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110430-vagueness-punctuate-be5b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 022f5f8b7a0580da50fcbc34da853d03d4321fe2 Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Tue, 25 Aug 2026 19:26:20 +0800
Subject: [PATCH] wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the
 agreement

mt7996_mac_add_twt_setup() links a new flow into dev->twt_list before
asking the MCU to add the agreement, but exits without unlinking the flow
if the request fails. The flow-ID and table masks are only committed
after MCU success, so the still-linked flow is invisible to the
mask-gated teardown paths.

If the station retries the setup, the same slot is cleared and its
embedded list node reinitialized while it is still linked, corrupting
dev->twt_list. If the station disassociates instead, teardown skips the
flow and station storage can be freed while the node remains linked. A
later scheduling or debugfs twt_stats walk can then dereference the
freed flow, resulting in a use-after-free.

Unlink the flow when the MCU rejects the agreement. This restores the
list to its pre-request state while leaving the unchanged mask and
agreement accounting untouched.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260729173632.14387-3-enderaoelyther@gmail.com/
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20260825112620.97568-1-enderaoelyther@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 898cd9b8ff96..a8c4f629109b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -3288,8 +3288,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
 	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
-				       MCU_TWT_AGRT_ADD))
+				       MCU_TWT_AGRT_ADD)) {
+		list_del(&flow->list);
 		goto unlock;
+	}
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);

