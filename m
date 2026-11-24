Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564660;
	b=GhysFFkmoxHf1dlivpc1Xcs747wKJHVJjRt5BXZ/6/6kFt+2QYHH127O0IfZRd515/Dm
	 QvoN8pX1T+NgS7pimE4yptVSv5FhjYLGHI3fpDCi9aShb21+5JGc0qGYI3gHoty+2G1C7
	 VAktBnB0xax0vzl8KWVmp9p03Cpf3Xi+seWxCXRby5b1PMUNSMka9v2lY1eV6SAdWu3ff
	 kpGaChgKIcKNBTfum8N7u7OdmtjaPNCN8By04zk3KCn+R7ckoi4RfpUycfD9G6uL//L9P
	 AN0Kn4KRv4DMd4jbAhP2rKvKn853kkcW0dxTPkW1PNSNKDyvHQpNfVzskvl47ETP5nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564660;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=nLNAbdcbhe94cKt1uJgEZAT+B3+pg7rFP4RoRlJ/uUg=;
	b=WjrnZp+jdEnjp9tb4jhmyGfTYSFwWu5utE84KkNjQRtB0XtkH4HcpWqbrKz9tBlo3lqm
	 92Ce97EQFGmYTyG5sBfc/8fPJI8Bo6j42FDkDbUwDw4SK7LUtH64eTcqft62yEhSBpUgp
	 fpl512b2qnwln7SvD66kpSjj1lMbQAi/YQjypWNAHO9n+IiYuj5P1qXrufCnvAVgu4P2w
	 AAkgZKS47viAfpMYYTZzVcAkEvPCjk+R9s+w0I1RkpTco8UzDGEi9fXpr9Qclbx/UnE2p
	 ogBEgVuB5eFKIk9tNPDYNgLZoBtzSbII6VpVD4D7HI0HAexa5SumASmFzLsoUzxXHiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=COS+ILg0;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49F606A335;
	Tue, 24 Nov 2026 23:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A49F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=COS+ILg0
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jZ09Y387Dz9ttS;
	Wed, 25 Nov 2026 00:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLNAbdcbhe94cKt1uJgEZAT+B3+pg7rFP4RoRlJ/uUg=;
	b=COS+ILg0iXL4uTSMflkkkR1xtTGh0GPyXrtxx6BTex0cDfcqYEBblZEadkQUxEMSslMyYs
	ie/szoviBKG6/BTEhjyCQBLF29EzWIOQIW0nikKpxaJLJ4ZfVRrsV2T4u+dSTSjNQPJgUm
	zR3mVYm0MaxxilOIfNHwy7ovCG1jixeBUxnNfAc92E63CDW+uSnVGtCcrqya1qIjrC9JI8
	a1MMdjdfwcwT+j8hdczMB3PMkyZK6BiBd7w20KJTyDSSd+AisWxI3ymNArxJyZ04NvvRyE
	PXpB/I5fQK+FJeExM/zBiilQQiOlYcQ0J8WLcqZZSSY09SBRl5U9ArcBF1eQEg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 5/6] igb: resume the device before changing XDP or XSK settings
Date: Wed, 25 Nov 2026 00:57:20 +0100
Message-ID: <20261124235723.1135808-6-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ09Y387Dz9ttS

igb_xdp() can run while the device is runtime suspended or resuming,
and __igb_resume() rebuilds the queue counts and the rings without
RTNL. igb_xdp_setup() and igb_xsk_pool_setup() can then see a queue
count whose rings don't exist yet (NULL dereference), or a NAPI that
isn't enabled yet (napi_disable() never returns). Changing the XDP
program of a runtime suspended device also opened it twice.

Resume the device for the duration of igb_xdp(), as ethtool does. Like
the other resumes done with RTNL held, this can still deadlock with a
runtime suspend already in progress, which takes RTNL itself; closing
an AF_XDP socket or changing the XDP program is now one of them.

Tested with the 82576 emulated by QEMU by closing a zero-copy AF_XDP
socket and attaching an XDP program while the device is runtime
suspended; the latter no longer warns in __netif_napi_del_locked()
because of the double open. The races themselves weren't reproduced.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: new patch (Sashiko)

 drivers/net/ethernet/intel/igb/igb_main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index acd9a33..80ae03d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2942,16 +2942,28 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
+	int err;
+
+	/* The rings only exist while the device is resumed, and resuming
+	 * rebuilds them without RTNL
+	 */
+	pm_runtime_get_sync(&adapter->pdev->dev);
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return igb_xdp_setup(dev, xdp);
+		err = igb_xdp_setup(dev, xdp);
+		break;
 	case XDP_SETUP_XSK_POOL:
-		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
-					  xdp->xsk.queue_id);
+		err = igb_xsk_pool_setup(adapter, xdp->xsk.pool,
+					 xdp->xsk.queue_id);
+		break;
 	default:
-		return -EINVAL;
+		err = -EINVAL;
 	}
+
+	pm_runtime_put(&adapter->pdev->dev);
+
+	return err;
 }
 
 int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
-- 
2.56.1

