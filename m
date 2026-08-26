Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98C35E1CE
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750751; cv=none; b=B9XDlsfUryyy+a7K9BEVUkMYEbSRhZ646fMjpbSBmTqpuE+6jPw3vxQP6s1fSTHJ+0242o3sucSuoWHcodnRB7dW9Nj3OQyyggD7jSfVSpzPcxwXaOUHsHfE4YfGtuoaOyTOzaQvM0rx4oMKfz+flUWRsFmY32lzaToHvB9VJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750751; c=relaxed/simple;
	bh=h4xQc65uVBxWoHvKbCT+hslQVg/M00fNbbXhY6aDaHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyZqOM7bE57wwt7/uWBLuBzwpxopHh6ELB8ewsSxiWGmy/cZ+UpgmGze6tMm/dAZ82Lwr6S8lxqg5ePAPRKjAqJck0Rvm6u1WWY70Gc6wk7G+2nq8LyyMbOq57tliUoBr2yn3t9FKQL5TMJoJ7sJu/BO8tLQpYo3wfSynf5OmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6f3KjSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6f3KjSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AEF1F000E9;
	Wed, 26 Aug 2026 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787750749;
	bh=4QR5LHutIfqbYfaxbujJVmkdEDgA8171FqS0Fuc6nv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a6f3KjSZObUrz1qmQa3v5SjlZdr5QxmDVSIf6Gr6+971T4J8GDk1+wLyUXRDx0pv5
	 PSjcQuwBFivp1LLea9d5FkMojE/OBRIbT7f172pVkOgW718xlv9xIFmd/9K32gYSmS
	 kpIf2BPp6BScFwZA+j+DV8rkyxidX9wOb+rIAXSoVuEGzjdYD4YciFsjUI8THZ3/hl
	 Iw6nFf1RWReh+Pf9BcR6cxPl/3hkTXMvw83YGC+PmBFlQ2d+KTO757I1oYzRvzoXM1
	 e1CPpQU8UN0QOWg8Wxm1ZNx9x9b2SPlHPO/vPYypjTD3oSGkRU38PHehDjWH3UmiBu
	 djH1HlvVXqqXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Page <sam@bynar.io>,
	David Heidelberg <david@ixit.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
Date: Wed, 26 Aug 2026 09:25:47 -0400
Message-ID: <20260826132547.3118857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082417-repent-kilometer-e0ba@gregkh>
References: <2026082417-repent-kilometer-e0ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Page <sam@bynar.io>

[ Upstream commit 8cbe06c1e699c0a165dae5093a2550e65f914818 ]

nci_rf_discover_ntf_packet() and nci_rf_intf_activated_ntf_packet() each
parse a notification into an on-stack struct (nci_rf_discover_ntf /
nci_rf_intf_activated_ntf) that is not initialised. The RF
technology-specific parameters are only extracted when
rf_tech_specific_params_len is non-zero, so a notification that reports a
zero length leaves the rf_tech_specific_params union uninitialised - and
both handlers then pass it to nci_add_new_protocol(), which reads it:

 - discover:  nci_add_new_target() -> nci_add_new_protocol();
 - activated: nci_target_auto_activated() -> nci_add_new_protocol().

nci_add_new_protocol() uses nfca_poll->nfcid1_len as both a branch
condition and a memcpy() length and copies nfcid1/sens_res/sel_res into
ndev->targets, which is later exposed to user space via NFC_CMD_GET_TARGET.

  BUG: KMSAN: uninit-value in nci_add_new_protocol+0x624/0x6c0
   nci_add_new_protocol+0x624/0x6c0
   nci_ntf_packet+0x25b2/0x3c30
   nci_rx_work+0x318/0x5d0
   process_scheduled_works+0x84b/0x17a0
   worker_thread+0xc10/0x11b0
   kthread+0x376/0x500
  Local variable ntf.i created at:
   nci_ntf_packet+0xbc2/0x3c30

Zero-initialise both on-stack notifications so the union reads back as
zero when no technology-specific parameters are present.

Fixes: 019c4fbaa790 ("NFC: Add NCI multiple targets support")
Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Link: https://patch.msgid.link/20260626090301.2139500-1-sam@bynar.io
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/ntf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f8b20cddd5c96..a3d9cb70f3d2c 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -310,7 +310,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				       struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	__u8 *data = skb->data;
 	bool add_target = true;
 
@@ -511,7 +511,7 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					     struct sk_buff *skb)
 {
 	struct nci_conn_info    *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	__u8 *data = skb->data;
 	int err = NCI_STATUS_OK;
 
-- 
2.53.0

