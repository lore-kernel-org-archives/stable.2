Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004801;
	b=DD/piBH9Z0+GkcogVMxqTQcSoL1yjo6gj4e47YSi0wmIOf+fU8eIlLU+AhpKHpwnSL91
	 gik6jFzs/p4aKXcgKx/aEaEvr+RW9Auu31WGp7bVSdQyHtKNd+juC7oNnjYBbwuyG8Oog
	 uc3uFETdO4Bxtpk2Bk44zg+BmMEbFyrYV6MWQYfmFvwoZAmXgYU7cSejOxcpEs3+6oj7+
	 JCaBIFnL7YNebop5Dty2b+jb/A+O9Ywcth8Ix0cCWtqPHLrICFe5EYdNuM15tIabsTtpe
	 18jlZAlY7Fqz6xZfycQ+F4eyzJdVQ4203o2DumAWD7f7dZiLcpr+GB7KXYymXaCTTCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004801;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Evk3sUQ7uuIJybpzKewVPlKXeloIYVZQPgkkBsr6TKw=;
	b=1KSOc/d/YcOjgRPZNlZhZud6Fdq5RrRNwuAnnKKC78CApYFYPvl2AzLvzPI73HWuCyuW
	 keRP/s9x86qrSOjE+OCiE2MfxlcdxlMABhYwJBggYvPQ/rOiomvxamCGinDDRpxaU9EYw
	 MipQu6OTzql6iC4BuSPSwovg5EalUUZUM/Ss2+v2jV3wk3EX/7WPmLxc+SN9eKMZrz+ud
	 /xjB7/TrAmOPeLu9kK8A6PEoCBPUxnm16EgaHjVYLMbo/X7Y3iWDsgzsFSyEEHaukONzZ
	 UEEmYFSLJpigFCm9cf7t2spcQLNfWo3q4+/yS6OxCXPmzzgcot4oUdjQyhln6HhzhWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=OtAXISVz;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 96BF5606A31F;
	Mon, 26 Oct 2026 08:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BF5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=OtAXISVz
Received: from kero.packetmixer.de (p200300C5973CE5d80fc8dFE94a24022d.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 44C80FA0E4;
	Mon, 26 Oct 2026 09:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Evk3sUQ7uuIJybpzKewVPlKXeloIYVZQPgkkBsr6TKw=;
	b=OtAXISVzzPbMT2SniOfbSxTeRpfNBErpT3ifOkk/vWq90IzaqVJTDq9oOfM4GMWxwQa03F
	5QIIWhUJlwPtpAAyHpobMCEWRvfNMRzzS6E6K/FdNrgMIkUKE/CvID+LSfYLlRs/2yweOf
	0LDUZMX4rBAmFSwGb6iFS/HA+QsQGRyYrkX01tJhu+vAP0qNk9CKxjhXM5jyDkovNkJAcp
	BoIKzLwEgMjD9RxPO0ra9DK6kNuV5u11YI0Ab1zIhl3vkKAoqjJFOCcKbYBEZsjU8mYfXl
	OBxRvhRCFVwFbnGX7c9H8i592m4AjkQF9ILKh5C5NwV9N7Flm0a7I8uh8fY6wA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 02/10] batman-adv: Close OGM aggregation before transmission
Date: Mon, 26 Oct 2026 09:53:01 +0100
Message-ID: <20261026085309.1074911-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
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

From: Chengfeng Ye <nicoyip.dev@gmail.com>

The OGM send worker leaves its forwarding packet on forw_bat_list until
after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
but emission reads and clones the packet without that lock.

CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
list lock, finds the same packet and appends another OGM. The sender can
observe the new packet length before the corresponding direct-link flag
is set, or clone the skb while its length and payload are being updated.
This can transmit an OGM with incorrect flags or inconsistent data.

KCSAN reported:

  BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
  write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
  read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
  value changed: 0x00c0 -> 0x00d8

Mark the aggregate as full under forw_bat_list_lock before emission. This
waits for any ongoing append and prevents further aggregation. Emission
uses packet_len to walk the OGMs, so all queued packets are still sent.
Keep the packet on the list so interface purging can find the worker,
wait for it to finish and free the packet.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Cc: stable@vger.kernel.org # 4.10.x: 434becf57bdc ("batman-adv: Limit number of aggregated packets directly")
Cc: stable@vger.kernel.org # 4.10.x
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 158d2b8f04036..85e99506a53f5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1909,6 +1909,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	/* Mark aggregate as full before forcing emit. */
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BATADV_MAX_AGGREGATION_PACKETS;
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the
-- 
2.47.3

