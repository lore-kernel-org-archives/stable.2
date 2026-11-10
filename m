Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273311;
	b=J9S2NEqs4vlEbNnTcOrRtwdVJ8ZoxORVuUmQQ1Qx/HqLZCxbi+uCcT1vWta+9mrZbsHb
	 DytCu+n/A/ASklRbXqcu561ahPVLshIMLEHu+FPQa/TBa5u/9PyWdPIO6gD6itbJOnYry
	 k0WLJVOuH6SqOvJ3Bswl1OTh0JRD3n3jqjhLSVz24iq/L99gULEFi5FSZlnr3scF4SLpm
	 /t5pvs5iGMiLH0KvvJiDAeKsUfrbfhm63EuYFgPET95wL8kZVPm78Wu3kgM8H7LGM68BJ
	 XWsHT2xr+hNjRTS2RdULNmRqMyxmiagrdZ9FiYE5DqAtjoN644Wp3MGJPmOvHvd8n2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OnC42V1GQmDmGzQZiSDWjMqFOdZeCJ6pe/0XwaNW+wk=;
	b=1y+Q6uHlsYN6F4JfCATPgjgLZw1oRbVytQz/hw81TRefIkFDEbTSV7zAxFJ8LlFNxQYM
	 1VnhY9/u8KLAG1Pg8m9HciuLpd5b6Z+ocQ/BagyIg9v3UMgXKHVHfRxIzYWf19NdGsytk
	 SV5tpnyDVix+gsVE7yWfCXqXG3+/Gd5Nq5CJub9dSxD29Cm5Oi3TJCL1Q9iym88NLJIdK
	 i+amPX0n4sRUAdfnlv50W4j3B03yJeAw761dlXN7dFMDQ74JsfJPA/03xS256UKLMM+af
	 AMY0KMJwPiWnp6INi2vinCjEyqNTQRccjnOVk7GBo4bASBZS20DGh4qhgmUZNKUMmBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BahLI/kT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BahLI/kT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFF41F0089F;
	Tue, 10 Nov 2026 01:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273311;
	bh=OnC42V1GQmDmGzQZiSDWjMqFOdZeCJ6pe/0XwaNW+wk=;
	h=From:To:Cc:Subject:Date;
	b=BahLI/kT99Va3dMwlYjYrb8YETIT8yHCYHR7fFt9g71b5FfVaksMfjNgOkj9uqPwJ
	 aRwVup3wwUFQN6FgmcvvuXNn9WjnK7b8VmPmdKvSlf0/9mqxKxbrnI6EghBAbFDUeV
	 nDsz4I/4HbNVfe1joFkDIwTcCeEotWyDWNU6sT94BcGm0zscOXrENfTw2POzjWYAsZ
	 H/B6BNvmNsOJQCT/FpU3N1hyv8cgs4yt2nfRzKXNlpmM9vNVjZDIR3Cl9UAWa926HK
	 uMHg06V9fvjMkJN+wj+aYOCcEKdXihvDXx1WyLhevr0sl4YqU5VZSwPRjg5ODYBk1p
	 5jHz7e1Fh4jew==
From: Sasha Levin <sashal@kernel.org>
To: nicoyip.dev@gmail.com,
	sven@narfation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] batman-adv: Close OGM aggregation before transmission" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:09 -0500
Message-ID: <20261109201509-failed-6.1-f91f64a91682@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f91f64a91682c07e6c5f059804e709656364e8a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201509-failed-6.1-f91f64a91682@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f91f64a91682c07e6c5f059804e709656364e8a6 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 18:16:24 +0800
Subject: [PATCH] batman-adv: Close OGM aggregation before transmission

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
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
[ sven: drop assisted tag, document new meaning of num_packets ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 5 +++++
 net/batman-adv/types.h      | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

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
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c19caa84e6920..b3e6dbb360dae 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2047,7 +2047,13 @@ struct batadv_forw_packet {
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
 	DECLARE_BITMAP(direct_link_flags, BATADV_MAX_AGGREGATION_PACKETS);
 
-	/** @num_packets: counter for aggregated OGMv1 packets */
+	/**
+	 * @num_packets: counter for aggregated OGMv1 packets. Set to
+	 *  BATADV_MAX_AGGREGATION_PACKETS (independent of the real number of
+	 *  aggregated packets) by the send worker to prevent further
+	 *  aggregation while the packet is emitted. It must therefore not be
+	 *  used to iterate over the aggregated packets
+	 */
 	u8 num_packets;
 
 	/** @delayed_work: work queue callback item for packet sending */
-- 
2.53.0




