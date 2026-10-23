Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747810;
	b=FdbKYL/vr4HQ3uhf82OpGaa8AZ7tuLLzJSKNTtGZ4QGMEvUGrSZMXPvWu7XdzGCTHZkm
	 RO8j6A2rAudtzump5RZeJHrnl0yo4GVcLRY78y/WVvuaxiosOS2+sU4VpzGTr88iQPGyy
	 N/c0nd620Egi6boylEW0MsoASTe1AZh7TBaqeES7IGymUs3KZxfb0ijLRpC8Krk+KT8vZ
	 BgoBid4Ylhs6PnJ1KItDOEaUTOHMwfP6NyrsCr+MmTVoeM+e8Vn7XsEC8pXWcndKtJ/sA
	 Ec5TRIEiJH2h7c5JhzK5DKILLVyDIFUrsQeUwUFwYZ0embZynSqp8Ml0xeUMKenvdJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747810;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=SAN9x3ekDFh3dDV1s/JTsWUi3o0RzXXkeiuG0T7yyWQ=;
	b=MLfNjOzHjRLmhudsuhSxXbcE0bs4s8GWHm2H9UAePskboL0jy2z/LCtC2JHTrYjA9Nf1
	 cSAQVxVzYnBnELuHPQVGao3vmcUzY3yzR/DodLzfyvGxKpAH2NzkCcq5e07g4GnW0NlNx
	 8IjHlmbAUQNyM/+9IOBDvXWbfHdp43XKoj3B+3AV9zqmRgItSUCDOaeYchGlNQEz1YN9+
	 Bgl9/bfk4CYXdDbvnJ0cE5aERbRERftrwMFiyfDbn/KscSjIrEIhInb5aNPSEiyuxjVCD
	 mg8aLT51n61ubLIubDBBH2cebXKJVWdJoj9ZkVQsGLOLalsluX0HIlSuCzA5GefNSkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=WzA1Mrbn;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C2606A325;
	Fri, 23 Oct 2026 09:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329C2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=WzA1Mrbn
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: Chris Snook <chris.snook@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: atl1c: drop oversized RX frames instead of panicking
Date: Fri, 23 Oct 2026 11:30:00 +0200
Message-ID: <20261023093000.73535-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
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
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 82A81DC2-D8CA-4B74-884B-87864EDA0078.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Fri, 23 Oct 2026 11:30:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1792747800;
 bh=SAN9x3ekDFh3dDV1s/JTsWUi3o0RzXXkeiuG0T7yyWQ=;
 b=WzA1Mrbnk6w57cxp4x57C2b7HExNTzm6NxZkOeVjl+v5mcitOClFYas7OD1mWqIDu8FbH1gj4
 8iBEVIloRvAdQprS/1AmUK4N1P2iJWlEmz/4ExWEv4j/ldiOo5Lt31Y1qs9C7e1GBuJo06HQdum
 MG7wG9LkbaVrVgC96D85CFGYdwccCQN2cof1VX/rM0A/fI1lfbEu4aK/j69Zkznftayps+MRZ43
 eGxUl3N+vOzataGHVlI+iSSCd6W2Pzb93jNHheIFuWnYaKSGpdq7rWSX76a2TxaZWQLcWv161r8
 3+3MnCFbNmxJN9kTZ0xTU9QDzlZjdOghhVDRt3Eu91YQ==

atl1c sizes its receive buffers from the netdev MTU plus a fixed set of
L2 overheads, which comes to 1522 bytes at the default MTU.  A link
partner that sends a longer frame - in practice a MikroTik
CCR2004-1G-2XS-PCIe, whose RouterOS side defaults to l2mtu 1600 while
the host stays at MTU 1500 - makes the length reported by the RX return
descriptor exceed skb_tailroom(), and skb_put() then trips
skb_over_panic and takes the host down.

Validate the descriptor length against skb_tailroom() before calling
skb_put() and drop, counting it in rx_length_errors/rx_dropped, any
frame that does not fit.  Such a frame cannot be delivered with the
current MTU anyway - the buffers were sized for it - but losing the
frame is preferable to losing the host.

Tested on a MikroTik CCR2004-1G-2XS-PCIe (4x AR8151) in a Proxmox VE
host, with atl1c built from a DKMS tree carrying this change: the
l2mtu-1600 traffic that panics the stock driver is dropped and counted
with the patch applied, and received normally once the host MTU is
raised to match.

This complements 36c2009d90f2 ("net: atl1c: fix soft lockup on
out-of-range tpd_cons read"), which fixed the TX side of the same
"host dies while the card resets" problem.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
Notes for reviewers (not part of the commit message):

This is my first kernel patch, so process nitpicks are as welcome as
technical ones.

Scope: this is the minimal version of the change - only the descriptor
bounds check.  My local patch also touched atl1c_set_rxbufsize() and
atl1c_change_mtu(); both are independent of the panic and I can send
them separately if there is interest (raising the host MTU to 1600 is
what actually lets such frames through, and the driver handles that
today without changes).

Reproduction data, kernel logs and the DKMS package used for testing:
https://github.com/rimpianto/mikrotik.CCR2004-1G-2XS-PCIe
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index e58f1d2..11de643 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1934,6 +1934,24 @@ rrs_checked:
 			break;
 		}
 		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
+
+		/* A peer with a larger L2 MTU than ours can hand us a frame
+		 * that does not fit the buffer allocated for this MTU.  The
+		 * driver used to skb_put() it anyway, which trips
+		 * skb_over_panic and takes the host down; drop it instead.
+		 */
+		if (unlikely(length < ETH_HLEN + ETH_FCS_LEN) ||
+		    unlikely(length - ETH_FCS_LEN > skb_tailroom(skb))) {
+			netdev->stats.rx_length_errors++;
+			netdev->stats.rx_dropped++;
+			if (netif_msg_rx_err(adapter))
+				dev_warn_ratelimited(&pdev->dev,
+						     "bad rx frame: len %u tailroom %d\n",
+						     length, skb_tailroom(skb));
+			dev_kfree_skb(skb);
+			continue;
+		}
+
 		skb_put(skb, length - ETH_FCS_LEN);
 		skb->protocol = eth_type_trans(skb, netdev);
 		atl1c_rx_checksum(adapter, skb, rrs);
-- 
2.54.0 (Apple Git-157)

