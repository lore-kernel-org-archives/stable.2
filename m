Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540075;
	b=5ruhhM1yiNJSIpGlR3O6BynLMKL++v/vFuQexTRcShl+bxRjAxitMpOMlsgWTe6yfj7E
	 rrRoMB0JuvUOoDWTugQp6nN0IoeKTA/hJR1yLhKU4cLAnEHSr/ctUx56M6YLstYfiA6jy
	 gqRvWH1zXcwVF4LFum0rE4HsTHF0dNhisxU0aInw7odnnHwaFw5l8GCjWYDyzeUpGnvt+
	 KBxyMRCsUtpwWLadzXbAG4+6o6kwF4hfA8pXfXChB9zEHqwTMGlhuZ0PNvrcFRCugFL+n
	 InFMXOVjQ32crYV3rBASgjji3IDIRO/iBuw3+y24XGGp04vPVpWGykdN8ofG1LX6mHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540075;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QpSTrZuVUHcb2w4MGUeOUgD2wK8k3hqYw7Z93YAWBFc=;
	b=wVtk3xG11lw+5Xw5b0x7atix5ZZJl/lcXPWPxyCFlBti/bRznPXiYlcHvgw8tOQ5oy5e
	 qOhrlfCFhMPMvPppgthdQ8OuzwnOSTbFbTWIZbFJaq34BXyKjxm90Zvf7kGqhZUEXskKZ
	 XRS1/1pOsz+OXb2olwkkhygsanJUhPQVZaqrKjK/BE93Q75qG4c4bzdRhR+WbV2OiQNOn
	 XIEjQLZn1THyAcqNL5Ov4qLP97+D3mZ+BFGW4ws7OxQscQETRQWKOJp2Q/YVAhaCbx+/2
	 ucpkya2iR7O2hmLr6aMR0U6y6sm4SmMkIGXeoFbbdhntQ3ax7474U/7bYlB7I7g68OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YuN9rnn6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DB606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YuN9rnn6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D631F000D1;
	Tue, 24 Nov 2026 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795540074;
	bh=QpSTrZuVUHcb2w4MGUeOUgD2wK8k3hqYw7Z93YAWBFc=;
	h=Subject:To:Cc:From:Date;
	b=YuN9rnn6aN3lSjgYM9LMzYFD8w18S7q6yHEpM38OuXgO0GA6vp77aL3+cBz9PNf4o
	 64Y7JJkSNOfOmNPlEWe+Xudi3QqMo8xNhJj6g5dTXWGZ9m5oMWhXYNXtLD6Y+bMCxM
	 7rPITBC/dY7D9Nqebf0f8zluJ3OdvmbyYldsnL6U=
Subject: FAILED: patch "[PATCH] net: mana: report RX checksum offload for IPv6" failed to apply to 5.10-stable tree
To: hamzamahfooz@linux.microsoft.com,haiyangz@microsoft.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 18:08:15 +0100
Message-ID: <2026112415-battery-lubricate-18f6@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bbcd02741c4cfbf9e1c59b1906f21ef772bd15eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112415-battery-lubricate-18f6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbcd02741c4cfbf9e1c59b1906f21ef772bd15eb Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Date: Mon, 9 Nov 2026 09:28:56 -0500
Subject: [PATCH] net: mana: report RX checksum offload for IPv6

The hardware validates TCP and UDP checksums for both IPv4 and IPv6 and
reports the result in rx_tcp_csum_succeed and rx_udp_csum_succeed.
However, mana_rx_skb() also requires rx_iphdr_csum_succeed before it
sets CHECKSUM_UNNECESSARY. That bit is only set for IPv4 (since IPv6
has no header checksum), so IPv6 TCP and UDP traffic is always
checksummed again in software.

So, only look at the L4 result. For IPv4 this makes no material
difference since CHECKSUM_UNNECESSARY only covers the L4 checksum, and
ip_rcv_core() always verifies the IPv4 header checksum in software.

Between two Azure Standard_E16s_v6 VMs (VF enabled), IPv6 TCP and UDP
packets (including VXLAN over IPv6), now arrive with
CHECKSUM_UNNECESSARY instead of CHECKSUM_NONE, so GRO no longer
checksums them in software. Calls to __skb_gro_checksum_complete() on
the receiver during an 8 second iperf3 run:

                               before    after
  TCP/IPv4, 12.2 Gbps              23       28
  TCP/IPv6, 12.1 Gbps         8728419       25
  UDP/IPv6, 1.5 Gbps          1071380       20
  TCP/VXLAN/IPv6, 10.9 Gbps   7934373       18

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Link: https://patch.msgid.link/20261109142856.779955-1-hamzamahfooz@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 38249e092090..fd9f09abbbdf 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2179,10 +2179,9 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	skb_checksum_none_assert(skb);
 	skb_record_rx_queue(skb, rxq_idx);
 
-	if ((ndev->features & NETIF_F_RXCSUM) && cqe->rx_iphdr_csum_succeed) {
-		if (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed)
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-	}
+	if ((ndev->features & NETIF_F_RXCSUM) &&
+	    (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	if (cqe->rx_hashtype != 0 && (ndev->features & NETIF_F_RXHASH)) {
 		if (cqe->rx_hashtype & MANA_HASH_L4)

