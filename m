Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836005;
	b=IJFFRU43rrCo0bBJiSjr40kDXR3648XE+RJxljPO6/nvxnEQ2+lnuQQ7uPbFQ0wneojQ
	 Y4T5Ot27G5NYXxiJJMHbvg2lMIjjeWfTCTrzmaVk9r2EoCzFnKu+meT6d2RvS8UICCMdA
	 WPlZTfuiJxoVkYRJlwxKX0t/nvFbVnf1CzljI55pJoqYt9cFpmpPpMNo6SL0qQz14LNDc
	 vi8cP7jhWZyQEnTDFvOrsaOBYOipJvO1GknRow0kTD9DZQxJ4gbmdMWJxN+ypybS17Pru
	 WyNawSDISltBLeheDgoRctIzrXJZnvh0V4PtIFqkbREAKC2e6pe9I43NaHQf8j7dSQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6e2BydUkhErauFs848R7eef9kvwIdSIObZdXSJmz2uA=;
	b=zcnXW5T8xahQm22V4AxM6iY7/qoKtjIIgCQUbbc863cHhQsu4u3hCqvZKyeGkv2j3Sv6
	 f7ZQC04afDrwtwUZqeFRgUjM+zWBueJvebIQOjjGuDdwm16jF8V+9A0wDDNNFplOMZO7E
	 exNM5vaTulbiAygbnV2fdWfvMwZUtvy4duu1j+OdpHJn5nv1vkFjiwDG4pwpR2ORgaTo3
	 5ugawDdaWQis3prU+M0RBEtrlVssgxG3MM4NMSvD8Fe4+zd/axvq2A0OnP4yMC7LJj1co
	 YIoPDbtByyRYAViaxdg1sfPiZGXolRgpuhmxfjYTwIQ5j1/NEGbKNSU44ltxGzI1EzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQ6RV0tz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E9606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQ6RV0tz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F41F0093A;
	Wed,  4 Nov 2026 23:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836005;
	bh=6e2BydUkhErauFs848R7eef9kvwIdSIObZdXSJmz2uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQ6RV0tzQoYvI0xGKBVN1RNV7PDEX2XdRzGOz1IiFVJb0ekeI8hG5vFMMQ5Vs4mKB
	 9F2TBG2SgT+ZlaAagfTsr/L3xsdi+nXqB0l3s2/Ytb92qi+ZjOSBJ7XKb5vwDcJy1p
	 IDDYJzah6wk7t0J2+xxWaiiSJv8OGEEf0gV+aRLNEOpXnhrb7hprM6Rxzi3svm6UpN
	 5M6CC8UKFvTGVgWM2iKuZvUA9RWAaov/IiCplLKid8vnhEIyS+FbAjwrEOSPoD8Zrm
	 kkpbJHOQPhsIlUpVKmAh/s66WTmkT/kA5TmVWDJopE+vTOZU4XASKF0K+oHBe6j/V8
	 FcvXCp24s+hkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement
Date: Wed,  4 Nov 2026 18:46:43 -0500
Message-ID: <20261104234540.934421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110425-drowsily-humbly-15e5@gregkh>
References: <2026110425-drowsily-humbly-15e5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit 022f5f8b7a0580da50fcbc34da853d03d4321fe2 ]

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
[ sashal: Changed the MCU helper argument from &msta->vif->deflink to msta->vif to match the existing interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 89d8a22e967c3..5b12f152b0acb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2654,8 +2654,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	}
 	flow->tsf = le64_to_cpu(twt_agrt->twt);
 
-	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD)) {
+		list_del(&flow->list);
 		goto unlock;
+	}
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);
-- 
2.53.0

