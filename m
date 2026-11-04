Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802087;
	b=3HGTBoIGcnr8aC5JCagzJa3Bh7tGkYQ6fVXo64+54Z/2PNUI40HTz9tGWJdfauipnQWU
	 EVjShGuSnmL78fuboO/PHxqfbiUv18G1+yNLrCy7dOL8/XTY78dnDSyuannLZc2Iu4s0k
	 2tei4yoCuRZWjPytwfJq/2T0Bd5unJcKoRjvfG8Q8Fs1uOQwSaHuZvKJZkB0VQ6B7Vdfa
	 Fx8ldCeqQeB0mwlNSULyrnu4eV859zbrFN9AgHxcUjgf6fW/jvb2/2o9uxZqV2PsnAWbM
	 kHC0KIv1TFoYFcN6vCJXEcRTziN2Dz9PzUyEkOsKoteH8rE5Smr1SybLDz2AbPc93Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802087;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nntUYuLHphz3veNM7bho9ahTaBqgzATtHRgHiFjNan4=;
	b=rRW0iYVNqH8BNVM0rpfgJlLTZ7hurFUa0j7qbz5xGF5JadSdqg4kE/GoyP4JUNt/sWGU
	 czKDXoDW1rjk5CLrVuK9NsZlmKYf+aeT8f2UKkndJR8GqCnZfwIeaJSfH7LFT4Ulki0Hu
	 FdSBaZ0+ORDGU11bZenxw98drjU9ayBwvM7HESC5HbfcsX5deny8A8Si3Y7uQifosW7fp
	 2pKwDTvnmOuVeHiEEGH8Fk37W83g84gseHuUUHgwh5Mnj2EHziY2DK0heCl2xCO/zRkTK
	 waOZGW4L/wOMfGjF0ycTePHOYYo3EHTWk9Y8FakNohAzB5VkfZfvrCUJ/S1GJ1FPtvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a+ldW6UV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB9606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a+ldW6UV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE601F000C1;
	Wed,  4 Nov 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802087;
	bh=nntUYuLHphz3veNM7bho9ahTaBqgzATtHRgHiFjNan4=;
	h=Subject:To:Cc:From:Date;
	b=a+ldW6UV6Pj9QDKYO1NYh7IVELo/ydP5R6zkaha/JSoTsuvEdZJQ9Xa155bNqVcat
	 S0TmewVAuhYH11aXber2B/NDAs6IbYtvghSh7h4iEdBKtKlo/WcysMcKdwqyYpJKQc
	 Z9ndPytPN4TaDlnDstmfrTA2KY9k/IAHgtMvwFA8=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the" failed to apply to 6.12-stable tree
To: enderaoelyther@gmail.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:21:25 +0100
Message-ID: <2026110425-drowsily-humbly-15e5@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 022f5f8b7a0580da50fcbc34da853d03d4321fe2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110425-drowsily-humbly-15e5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

