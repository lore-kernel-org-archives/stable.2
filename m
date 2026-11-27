Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748948;
	b=4geGchXIqyl/vosktIK36gee67cJEdUKr1/iPzCdnKqLAn9DxZgHVYvcc5P2gbdNNhdr
	 c1CcVo7hU3S3gl5ouFNgAKQhoVuQtZZMIXkcj7fggORe3AKdpTHjwPReqH5JndAsUMxpB
	 CfohYUikJlH5VuCIZwW3l5LHh6WYQGTHPn3zAsHTgaG7AjEe5oAandspVPGU3BlP62vQk
	 KGnv/TfaoiDKTUDtTlEaRo4c+pJEEghhUNFbYBlrjMNCBWip1Rp5FBUbu6QnNOTyK9Fie
	 aAdDPScAmyo9hyilWL1EqhOv5oL0dZ2EXjJTiZCAgNCmuOAiDIm/rOMItVEnuNT6K/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748948;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=T6qnIZ7knEuhMvn/FGLmk9K4xZfB2NGqdkhivjTYbDY=;
	b=Px2MeUwDaNEX9kT/4oBitAcR73zvPYUrjoKk4g+uClrpXkKgaz/Pz4PwVIig1jtMpbN4
	 qy45eraN/XKViYtDibO52aNRcV1GshICUDufRW17D4XRGcvYxwNOA8NkzTHXAHxV78Zfu
	 qa2eKyUvTCQhKqgCc6pOIe+GksVD6XiXHmNeRnIWJnglzG9QCtwF9Hib9yEk1TPukH7An
	 R9L13rn3wdaQELPg8tahsWAuGC1ZO8al9l5+EIZvf/N3nXdS6taqxhrkVfRSGhTSLtmVm
	 JSA0BQzOE43OfDyMwbGTXVILzyR7pEPhJm+SH3Ao6l4+OiP4tzi3f7kn4H6dLCA6JnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s0BSqbI+;
	arc=none smtp.remote-ip=95.215.58.120
Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B2606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81B2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s0BSqbI+
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mCX+dAX2Y234AOj5HIr3xihBIeZcfHva9jzek9gcGfU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795748945; v=1; x=1796353745;
 b=s0BSqbI+eAbIQqC7WMFoNdn47RylD755qd0VR+036T8m52Ar8tR63oEecIsgItGiKgs2C/vv
 UkxVguf2TdE07mwDwTK1ddkUxop3ynfH9Gb/V2tdjk05xa9Bd1RrZ/x+RCM8U8pKjJNsqNwstsa
 72nOPI+k3ushVLwMUPQOzHrQ=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id cfccce07b52ac0bc;
	Fri, 27 Nov 2026 03:09:04 +0000
X-Mizu-Trace-ID: cfccce07b52ac0bc
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 27 Nov 2026 11:08:54 +0800
Subject: [PATCH net] bonding: check slave xdp_features in bond_xdp_xmit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-bond_xdp_xmit-v1-1-c2a7b622b95d@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQqDMBAFryLvuwETsGKvUoqY7Gq30ChJlIB49
 6b6OQMzOyIH4YhHtSPwJlFmX0DfKrj34CdWQoVhanPX2rTKzp76TEufv5JUQyM3tutI1w6lWQK
 Pks/fE54TXpeMq/2wS/8TjuMHzHcuNnYAAAA=
X-Change-ID: 20261127-bond_xdp_xmit-5dfe5b99d10c
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jussi Maki <joamaki@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, stable@vger.kernel.org, 
 Hangbin Liu <hangbin.liu@linux.dev>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

bond_xdp_xmit() may select a slave that bond_enslave() made visible
before bond_xdp_set_features() republished the bond's xdp_features.
Frames enqueued in that window pass __xdp_enqueue()'s bond-level
checks, and the bulk-queue flush later calls bond_xdp_xmit() without
rechecking anything. The selected slave may be unable to transmit
XDP frames:

  - NETDEV_XDP_ACT_NDO_XMIT appears only once the driver's XDP TX
    queues are up.
  - a linear-only slave receives multi-buffer frames enqueued while
    the bond still advertised NETDEV_XDP_ACT_NDO_XMIT_SG.
  - with no bond->xdp_prog, bond_enslave() skips the capability
    check: a slave without XDP joins while the bond still
    advertises NETDEV_XDP_ACT_NDO_XMIT (built from the other
    slaves; __xdp_enqueue() never looks at dev->xdp_prog) and
    bond_xdp_set_features() drops the flag only afterwards.

Apply the __xdp_enqueue() contract to the selected slave at xmit
time: require NETDEV_XDP_ACT_NDO_XMIT and, for fragmented frames,
NETDEV_XDP_ACT_NDO_XMIT_SG, failing with -ENXIO otherwise (the
caller frees the frames).

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Cc: stable@vger.kernel.org # b9d460c92455 ("bpf: devmap: check XDP features in __xdp_enqueue routine")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
The issue was identified when sashiko review other patches.
The issue is theoretical and only happen in a race window, I didn't
reproduce it.

For Sashiko,
Please ignore the error out issues during bond_enslave. They will
be addressed in other patches.
---
 drivers/net/bonding/bond_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 042d7c75548f..6ceefb0bfc20 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5664,6 +5664,7 @@ static int bond_xdp_xmit(struct net_device *bond_dev,
 		struct xdp_frame *frame = frames[nxmit];
 		struct xdp_frame *frames1[] = {frame};
 		struct net_device *slave_dev;
+		xdp_features_t feats;
 		struct xdp_buff xdp;
 
 		xdp_convert_frame_to_buff(frame, &xdp);
@@ -5674,6 +5675,18 @@ static int bond_xdp_xmit(struct net_device *bond_dev,
 			break;
 		}
 
+		/* The slave can be selected before bond_xdp_set_features()
+		 * republishes the bond's xdp_features, so apply the
+		 * __xdp_enqueue() contract to the slave itself.
+		 */
+		feats = READ_ONCE(slave_dev->xdp_features);
+		if (unlikely(!(feats & NETDEV_XDP_ACT_NDO_XMIT) ||
+			     (!(feats & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
+			      xdp_frame_has_frags(frame)))) {
+			err = -ENXIO;
+			break;
+		}
+
 		err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);
 		if (err < 1)
 			break;

---
base-commit: e1055cbfd6eb578417f3ce983cf44462e8465267
change-id: 20261127-bond_xdp_xmit-5dfe5b99d10c

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

