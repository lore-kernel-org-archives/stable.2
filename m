Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D61366562;
	Fri,  2 Oct 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944146; cv=none; b=R7kv3WPM7lEg8eJwTssyh5zUboBqt7fKi1rgRlQOtOaUUoAWAruZJ/qoZEUmbqVatb4RKsqP9Bxkw9Ay0RQnYSOi/Vhm3cMa5otZXetryQFw+haibEnn4bNpCNS2wCDEAZAzp7ZgBWsXYu/0vX5Ievm7SOxYFjtOIn+lBeLLW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944146; c=relaxed/simple;
	bh=ciRbaJTfwAJ3dOyS9/3Y9bAYt1vcab+c0z1GDcG2YtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=flI3Jd3Cd11fpPSoMJY6mopqcUqByFnYalfuZMqqbjv0n4iqo+HHg1h/4Rn7RA5ewd7Dd2y29hSqHO+Y0KkJZN2qk7i4Ol1Ask70UCzCMXixVkpQ+YmWjS+nguHpw/kQC4OL9+gNFbb0j+FSK/gpr7EA461buhMkvkvejqTsqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMRhZpoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMRhZpoq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DA91C2BCF4;
	Fri,  2 Oct 2026 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790944146;
	bh=ciRbaJTfwAJ3dOyS9/3Y9bAYt1vcab+c0z1GDcG2YtE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XMRhZpoqS3ZpVV5qHWKNBnEa1Cjack7NXR5+zEF9AQHjufF3Nzje0Xwd/5jeZ1QN+
	 AtTgHKJ1t4m0U2nTVgSx51eE764s4ZsvBJP+PvKKbnI7jqhED04K7K1tZO+r9tKEYf
	 3SL+cNmMrkKD9AHk5BAID2xK4o9DRErD/vcVv4jtZ7kyIRbzZ9ROEMTXYEaqclgdWK
	 vI2vcM0eI5UTroefA5kZXsLNyEouhBiBeBmlPpojuOeu8WH80y8z3pb3TdIpK9bmz3
	 QFC2F56fzJlTmfXO5fgdvVxaJ151VHqzf1Cw7K/m7ZvW14HKnDWS6DT0xaKJpwS2yj
	 CmV2atk51jvsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF3CA5FDD;
	Fri,  2 Oct 2026 12:29:06 +0000 (UTC)
From: Fredrik Nyberg via B4 Relay <devnull+fredrik.nyberg.volvocars.com@kernel.org>
Date: Fri, 02 Oct 2026 14:28:57 +0200
Subject: [PATCH net] net: usb: ax88179_178a: fix rx frame length for
 non-last packets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>
X-B4-Tracking: v=1; b=H4sIAIijv2oC/yWMQQqDMBQFryJv3Q9JEE16ldKFid/2i6Ql0RIQ7
 97ULmdgZkfmJJxxbXYk/kiWV6ygLw3Cc4gPJhkrwyjTaaUMDcVa3TtKhRaOZH1oXavYWd+hRu/
 Ek5RzeEPkFfe/zJufOay/FY7jC2PISDp3AAAA
X-Change-ID: 20261002-ax88179-rx-len-8bc4940e98b6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 Jose Alonso <joalonsof@gmail.com>, stable@vger.kernel.org, 
 Fredrik Nyberg <fredrik.nyberg@volvocars.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790944143; l=4935;
 i=fredrik.nyberg@volvocars.com; s=20261002; h=from:subject:message-id;
 bh=IRKcnIrPbqh8pcvFDSL7Xq7XQH9sQAAtncyR8eGC+EY=;
 b=yeLr4ykB1Bo2Pi9/VFxQzGmWnJCsZ/hSK5WU7sEibPp11igOTBJiDZswizNHZuEvBq8DCclLF
 D1dlfW5tiGbAp7XFUnT9rqx5nXF2ZYITnLYJmTBIxhvhCx3vFPtbkN0
X-Developer-Key: i=fredrik.nyberg@volvocars.com; a=ed25519;
 pk=qID6RVpkd1ixl+9o9DvizyEtYlu5k5KPZfGbD6OqhwI=
X-Endpoint-Received: by B4 Relay for fredrik.nyberg@volvocars.com/20261002
 with auth_id=1100
X-Original-From: Fredrik Nyberg <fredrik.nyberg@volvocars.com>
Reply-To: fredrik.nyberg@volvocars.com

From: Fredrik Nyberg <fredrik.nyberg@volvocars.com>

Commit 4ce62d5b2f7a ("net: usb: ax88179_178a: stop lying about
skb->truesize") replaced skb_clone() with a copy into a new skb for
every packet of a bulk-in transfer except the last one. The copy skips
the 2-byte IP alignment pseudo header but still copies pkt_len bytes,
and pkt_len includes that header. Each of these frames is therefore
delivered with two extra trailing bytes: the 0xeeee pseudo header of
the next slot when the frame ends on an 8-byte boundary, or slot
padding otherwise. The last packet is still trimmed to pkt_len - 2.

IPv4 and IPv6 trim the extra bytes, so most traffic is unaffected.
Anything that relies on the frame length is not. MACsec takes the ICV
from the last 16 bytes and drops every such frame as InPktsNotValid. In
our setup that was 0.2-1.2% of received MACsec frames, depending on how
many frames shared a transfer, including service discovery multicast.

Allocate and copy pkt_len - 2 bytes, like the last-packet path.

Fixes: 4ce62d5b2f7a ("net: usb: ax88179_178a: stop lying about skb->truesize")
Cc: stable@vger.kernel.org
Signed-off-by: Fredrik Nyberg <fredrik.nyberg@volvocars.com>
---
Found on Ubuntu 6.8.0-138-generic, whose ax88179_178a.ko carries this
change (it imports __netdev_alloc_skb and skb_put, not skb_clone), with
an ASIX AX88179 (0b95:1790, bcdDevice 1.00) on a USB 3.0 port and a
1000 Mb/s link. The code is unchanged in current mainline.

Bulk TCP from an embedded board (Linux 4.14, stmmac) into the AX88179,
captured with tcpdump on the sender's Ethernet interface and on the
receiver, and matched frame by frame:

  path            frames  +2 bytes  other differences  InPktsNotValid
  802.1Q 16 MB/s    5812      2665                  0               -
  MACsec  5 MB/s    6208        15                  0            +14*
  MACsec  5 MB/s    6112        32                  0            +31*

  * counter window slightly shorter than the capture

- No frame was lost or changed apart from the two extra bytes. RX
  checksum offload on or off made no difference.
- In the 802.1Q run every frame ended on an 8-byte slot boundary. Of the
  frames that were not the last in their transfer, 2662 of 2664 had the
  extra bytes, always ee ee; of the last frames, 3 of 3148 did. Transfer
  membership was inferred from receive timestamps, so a few frames are
  misclassified.
- A usbmon capture of 1393 bulk-in transfers showed that the device
  reported the correct length (pkt_len = frame length + 2) for all 2458
  IP frames and that every slot started with ee ee. For the 1061 aligned
  packets that were not last, copying pkt_len bytes from data + 2 takes
  exactly the next slot's ee ee, so the bytes are added by rx_fixup, not
  by the device.

To reproduce without MACsec: turn GRO off, receive a bulk TCP stream on
the adapter while running tcpdump, and count frames of 64 bytes or more
that are longer than their headers plus the IP total length. On an
affected kernel many of them end in ee ee. I can send the small script
I used.

Tested with this change applied to the 6.8.0-138 driver, built as a
module, back to back with the stock module on the same setup (8 MB per
path, matched frame by frame against the sender capture):

  driver   path    RX csum  frames  +2 bytes  InPktsNotValid  retrans
  stock    802.1Q  on         5792      2835               -        -
  stock    MACsec  on         6141        25             +23      +21
  patched  802.1Q  on         5818         0               -        -
  patched  MACsec  on         6299         0              +0       +0
  patched  802.1Q  off        5820         0               -        -
  patched  MACsec  off        6255         0              +0       +0

With the patch every received frame was identical to the sent one.
ax88179_rx_fixup() is the same in 6.8.0-138 and in net, and the patch
builds on net with W=1 without warnings.
---
 drivers/net/usb/ax88179_178a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 81d8412ce8..cba1dc95d3 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1457,11 +1457,11 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			return 1;
 		}
 
-		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len - 2);
 		if (!ax_skb)
 			return 0;
-		skb_put(ax_skb, pkt_len);
-		memcpy(ax_skb->data, skb->data + 2, pkt_len);
+		skb_put(ax_skb, pkt_len - 2);
+		memcpy(ax_skb->data, skb->data + 2, pkt_len - 2);
 
 		ax88179_rx_checksum(ax_skb, pkt_hdr);
 		usbnet_skb_return(dev, ax_skb);

---
base-commit: 71a77ab76e74131a101f4d2d2afb0dcbf81b4e3c
change-id: 20261002-ax88179-rx-len-8bc4940e98b6

Best regards,
--  
Fredrik Nyberg <fredrik.nyberg@volvocars.com>


