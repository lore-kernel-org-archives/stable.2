Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064616;
	b=LUoHjZ2/WDUwhFY7aOxMvOv52bygOjc2KWPoVxJ812o2ii2JnBVSEH50QjuvTOa0sMaO
	 JRcg+jDuZ+RN/OBIJkvapw+4q5nsxc5B24Zy9Uup33BB5qlIwoeZMAWzYyOa+jVR3wsKh
	 2SDOeVG8sVmmgVh56F5j1QYx6SMeivfOtXjog/nYhhtDOieYTZYIqjwyUt68oGVRPYjGh
	 spLDE1jPxCzmi5FTqLmSBDMZZMZmnS/oDXkGILKzhuO7MlPCNn/PbMfCNOjcuRX5YvpGb
	 XO4XOqPB5wKW40MSxkXuDI2INsXloDg7UNPWYUdWHsuNR2ptAdQrELt98VzD3nOFIfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
	b=lut28f+F1MT0ffIloKQz1xyv2ee3wLEznp/1tc0n3Qqxs776//EXHO7z9O0/sD9Rb1Xq
	 SQAZm01YNXyYBSm+RA8hp5Gov+36LlU/NNjr+EkcCiBy2F79Gu35bS14TYGpAqRuxNP8E
	 YXGnw54971F6Na3e/w94Dm+4T1m0IVHUXkjP0EwhFz1ys8FZsoelvp/OmDn2RQMUJXTFM
	 wgJgRQgpqxtt9LSvEXM2EMYdxrHt/V0QJJ+PT7kjlNEZe9G0rgU64WpMJZlch9Em+5Lul
	 JWsATTDMvsJ90NoB0Py5oZ5oT2ckMhNzu7YWTRrW/EA88gR8vmfaRvZKXNT9T3I+UHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BjWgtbiW;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10C606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA10C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BjWgtbiW
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0dba37a7fso30320107b3.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793064615; x=1793669415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
        b=BjWgtbiWWB/ebZwzA+G3TwJ+ah3Cn1chN7V7vbSrNAoxuaBQCzMzK4pKssSlzwlqBP
         OzyTzTnkhBon25TZ4NqvUSE/LJQOhTgLP4b2MXFuKuYAKytiD0QsXwn0Cv6/NAJowIv9
         tXzc7dDmNGkJ8omZSflHpFjloSOm8u0An9xWGwr7blv/DrKG0Lni1Q/ai6H0XOBryu9+
         PAx6OFMPOyfUXANiNlc+wu06NSFpZikV8DFOKsxxxPYY2ZiXNBfBglNob6vqRsVYby1/
         GOeyr60uUY9tc1PkrHh/nhCa7CdV9dNaUIAw/5r/iufrolKmlymZQkMlc4UZRLesJqto
         1MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793064615; x=1793669415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
        b=WHPqMolUgVkFcAL87ySfAdWgbUpgP5IXpHDoZcw7ETotnXWjZokQmq+LebqUJulbpA
         QzzpKxEcykiOSpFO0IVOkuqsBd+Be4uoh8bNuGxLFLFNuZ9mY1VloKDz+cXM+nj/Vr78
         TVRK1dsBL18sjAgeCnlbV0h4oAbe2StWJb2ROEbbYENx4X/fe5BDudWkOn3kG/h3wKlg
         nIu6oOuT9Bn4zdVc7l403asr3xBb/c/SRcrCVwaKEMJuYj3+OaBdbnGtGpmayiPO2EEC
         e2uXbEaUwS12cHmxQXACa1PvY6n3I3SQMYDa7+orp/lpWzH0bNaMmVmvQEhBHMx+oohz
         O2RA==
X-Forwarded-Encrypted: i=1; AKwUvBwX9mfF/BMUeXzwKz7icOavnGI2XO6S2P6//4A/yrDRonkMgGW1ELh5d9YBeuLWto28HqUHbEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRIYxL44EtEVO5SeFacOv2xJcfeZ2CKY/gIqpmOv/BptSr7Pbs
	1o6qrHvYJLFtcqRnKBJHzP1G2eN5DP4a9QmCMzMawzXlicRtc5Rl89BN
X-Gm-Gg: AYBFou3001tAUDmsMyrzSnIsIFwYsUmQSRKXZ/nKppvMWTZnSUocpylwvmoM4opLFk5
	UsxD9fOKyvNrJJb+yn5AIUib9oMRF28Cqe80p15rC4ZqM0xebWMVSh/RXxmKTQ9gjtBmtZTAIBJ
	TYZ/kbu8rWy5jZzNXzXA5T1ssMImj4aBP0JfsM2w9JgwF8DsDNTz82FZqyLDsUD3ANcgvE+oy5D
	0CGhRcUCjt31/yh9ZcRb3OGu2TI0G23tS+rwwT+NyuZ/4c4lI26/jpGUFmd/ylRiuhUpqHhiDJK
	7+KGILjMm2dpt8pcTPzXl9wi3Z9dkTHfMg6SGBBOyliGiTo6wqzovp7uKPi61nVs9ChbOWcl0pK
	HCkZeLq51XZiEEEdVNyQZy5MTUGSSqvE3qIYVDvOwChX8Pi9eePKykeFVPGtEpw3+itnkmo1Edj
	m7NxJqP5UnJNA3kRw3Ry5aNJuiGnfhPnvBGN8obnjB2mh1mgQYBdhnTrOUNh0M0fF0gpGU5TWyi
	4AAa1XP+m0Ah4X4Rdt3bIw3ZdzznoAXz3jOdnBagu2FEyfNP6WSGiaR/0J3nFYyMi/DWX5ja0iz
	zA==
X-Received: by 2002:a05:690c:e085:b0:873:5bd1:98c9 with SMTP id 00721157ae682-8b166c7b83dmr53834777b3.59.1793064614580;
        Mon, 26 Oct 2026 18:30:14 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316:dbf6:fb98:d66b:7c65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e65948bsm4557977b3.45.2026.10.26.18.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:30:13 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andre Brait <andrebrait@gmail.com>,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net] e1000e: fix Tx descriptor field wrapping
Date: Mon, 26 Oct 2026 21:29:58 -0400
Message-ID: <20261027012958.52524-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When an skb arrives at the driver and the header length exceeds the u8
hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
are sent to the card and it hangs.

This was reproduced on an I218-V with an unprivileged Python script.

Fix it by disabling GSO and checksum offload when the header length (and
checksum offset) would exceed the field widths. Compensate for a
software-inserted VLAN tag.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..11714032793ef 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7355,6 +7355,27 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	unsigned int hdr_len = 0;
+
+	if (skb_is_gso_tcp(skb))
+		hdr_len = skb_tcp_all_headers(skb);
+	else if (skb->ip_summed == CHECKSUM_PARTIAL)
+		hdr_len = skb_checksum_start_offset(skb) + skb->csum_offset;
+
+	if (skb_vlan_tag_present(skb) &&
+	    !vlan_hw_offload_capable(features, skb->vlan_proto))
+		hdr_len += VLAN_HLEN;
+
+	if (hdr_len > U8_MAX)
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7374,7 +7395,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features	= e1000_set_features,
 	.ndo_fix_features	= e1000_fix_features,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= e1000_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

