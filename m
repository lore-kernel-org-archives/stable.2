Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B43AF657;
	Tue, 15 Sep 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482450; cv=none; b=kOztOwFVlDG2nCVF3UButritoRQbj+3QMiMsp4qJxTvKwf5r7OOIWLSKwv8+Fd834qlwRWnWyp3sBfd6rU7Jf0TM2gmulU/xMt+bVISra7+rtkAOfTcm3mFkDIn3iEiJ1JzfWCzpwaRPjKEmSnnslSuFln+lYIHQlmlP7XbosIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482450; c=relaxed/simple;
	bh=WM00Wy2p0EbS1nPKWZz5VOFKBICv3IZa8bLp0tHtWhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O0Lh8jmPoCQQcfk/mdRL6OylKmfRZbRaGlNwN4yMkS8QRV0Rkcn1DfTAl3unwub7qQm5k/EyGzov+b7Bkio5ufNQn1XCCbwG4pWylpWprXqa10pYIoZPuMd6hrQdnm4Om8zwa6N7fR2uok1wukdt7K5+jzmlQIng5lSHQVmkCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tGNsNpI8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tGNsNpI8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 873721A081F;
	Tue, 15 Sep 2026 14:27:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 52C33602B0;
	Tue, 15 Sep 2026 14:27:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92B2011C7B00F;
	Tue, 15 Sep 2026 16:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789482440; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fpYiE3MCziPLVm6eillPix1fONvq0kj6Q1nctc06kJc=;
	b=tGNsNpI84la7s8hk2HZ3+i5IaMB/kBb1xPXkFwiWu5emET+xyZAuePthvdRCkUdJzD3JjC
	c2FRvFofyiWU/JOMYnoh2BaKUD9zpcYc2CKw9G/dwfZetUQEwFDpSmyfCE3WU/BYX4WFS6
	esaGPTKQs+rjrHXh89qpE+4RGCV4kl3orXajoS41VFQaykb8GZJC+CNlxG+R7w0lx45WmI
	xdlxMnoJF/yI3h9YKsg56nQ9+75raRy+HAKVYyDCCS5t9rV5AwOoHI5QUZuKJbOLXgOB+q
	oaRXKEh3wHVsoObnOVjXAki7PIPRk4NsJsRWHk/Y/y0qwajUT4T571KTwICqww==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 15 Sep 2026 16:27:02 +0200
Subject: [PATCH 5.10.y] macvlan: inherit needed_headroom and
 needed_tailroom from lowerdev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cve-2026-74743-5-10-v1-1-4496e177660d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJS1uLvArxUOqi6wFNqwRDe
 HeLHr9J5l+ROQlndNWKxLNkeUwF+lAh3sJ0ZZJLMRrVHNVJO4oz0w7y1ltDjrSi4DkMprVjaA3
 K85l4lOVX7eFqreoPzv89v4c7x9eexLZ9AcgOpwl/AAAA
X-Change-ID: 20260915-cve-2026-74743-5-10-a7eab384fa83
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Tangxin Xie <xietangxin@h-partners.com>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789482434; l=2806;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=SQu1DIEUUaPlPywRPYBn0pzzNUXz+/4U5NSSTZXDy70=;
 b=1l2CxuxdliDZjta7gmGrj61Jamga5nbbfIhWwpwlNWyxWieTvsl/PHy1Ik+oAsS7tmLtTkPwO
 6a9dsXsljKZCWDMKi91V1jtafbhMXPc1OInT+vFtx46Q28UL8qOvvHy
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cef51860becd9700217c81732ca1eb1ea6ed6fe1 ]

macvlan devices inherit hard_header_len from lowerdev during macvlan_init(),
but leave needed_headroom and needed_tailroom set to 0.

When the underlying lowerdev requires extra headroom or tailroom for
headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or veth with rx
headroom), upper layers calculating packet headroom and tailroom fail to
reserve sufficient space.

This can result in reallocation overhead, skb headroom underflows, or KASAN
slab-use-after-free crashes when dev_hard_header() / macvlan_hard_header()
prepends header data or when lower devices append tailroom.

Fix this by:
1. Inheriting needed_headroom and needed_tailroom from lowerdev in macvlan_init().
2. Propagating needed_headroom and needed_tailroom updates to attached macvlans
   in macvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.

Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#m16adf0ff972cbfd8066c3a8e656e75eaeb12d021
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Link: https://patch.msgid.link/20260806141938.287660-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 drivers/net/macvlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 95ae47a7a69d..f6ad599252d3 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -910,6 +910,8 @@ static int macvlan_init(struct net_device *dev)
 	dev->gso_max_size	= lowerdev->gso_max_size;
 	dev->gso_max_segs	= lowerdev->gso_max_segs;
 	dev->hard_header_len	= lowerdev->hard_header_len;
+	dev->needed_headroom	= lowerdev->needed_headroom;
+	dev->needed_tailroom	= lowerdev->needed_tailroom;
 	macvlan_set_lockdep_class(dev);
 
 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
@@ -1731,6 +1733,8 @@ static int macvlan_device_event(struct notifier_block *unused,
 		list_for_each_entry(vlan, &port->vlans, list) {
 			vlan->dev->gso_max_size = dev->gso_max_size;
 			vlan->dev->gso_max_segs = dev->gso_max_segs;
+			vlan->dev->needed_headroom = dev->needed_headroom;
+			vlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(vlan->dev);
 		}
 		break;

---
base-commit: 1797d8bf8d0c2e74defad605d14e3553d43a3caf
change-id: 20260915-cve-2026-74743-5-10-a7eab384fa83

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

