Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB8363C63
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481329; cv=none; b=QOtxsenRVcb6pyfRK4D2C/1zZYqM/KXRF+PxdcG4Jt1KS/qj8Oaq8ITWvSKwJpqczObXHR2oYIIva488a0eKsKnQ8zpn7NHRCcm6CRuXfN2wSUvXxv3Zl2f6FSHU6yzR1r/05XDEpG17Ib++bOzstF3rLPKWoq/laIIlW1VRQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481329; c=relaxed/simple;
	bh=4v6n+xqh5GZs4GinReU0YRNIA+IVQq/XiGYlNXPEvfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qcHxrkp5Ly08zPqrzoQaNZdBrbC7xuXh0Ynpt+ZrdGZ4/PXGhs0LqAQNZyecsiJe46zMVhmWlxzKmD5VS259Fn2LOFLP4k0oqk4TMlBBId1VVLOUEHi6x0bnhkV2h8tl1N7wT5DqNJdrFT90JEbVrkOZ1gOkHqz5qidCOnsce5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X+DtQoUk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X+DtQoUk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DD492C5CD49;
	Tue, 15 Sep 2026 14:09:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5384F602B0;
	Tue, 15 Sep 2026 14:08:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6880E11C7B007;
	Tue, 15 Sep 2026 16:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789481319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1v8WmV1lzmVvxTEijsOq/fqJH2jWLGKp2l9KoEWhH+I=;
	b=X+DtQoUk58tgwjATpWdhlg3I/XDyP5aatscFgJHmFwtLrjBeAZKIOosjzmuv3VLncgoEWy
	5wULR1RU4884i6EDzcJIJDOmzddzTcgnPcS+v/gFVVo9kzXXpCRHijfFNVnVfrdmtyUmeI
	9rgtimCcIYes3PqVMSUbsCCIvV2EpOsGSZUY9z2+WHHiR2y9KTYy4CS0Cx5Wvjwhlg0CvG
	uo2VsHzFlOjTP0PrbxEG0vXXYP+I84KtsGvEXHJlMui2ivgPd41ou89JyvSLYYlHhf6Up/
	r3J/7AzSmA2jCSeaf1TaK0Q21HneUgAQOP5Yd6ZsgDs1fa7DbtOnOZqCqKhpNw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 15 Sep 2026 16:08:32 +0200
Subject: [PATCH 5.15.y] macvlan: inherit needed_headroom and
 needed_tailroom from lowerdev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cve-2026-74743-5-15-v1-1-bacf32f2651c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4W8s0sosG70VwyHUhZdD2haIRrCv
 1v0OJPMrEgaTRPOxYqoiyV7TBncoUC4+emqZENm1FV9rE6OKSxKO5C00jbElJ2wNF78GAbfI5f
 PqKO9f9cLuHRcftD9fZr7u4bXvsS2fQG2hSJHfwAAAA==
X-Change-ID: 20260915-cve-2026-74743-5-15-7573a7afcdab
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Tangxin Xie <xietangxin@h-partners.com>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789481314; l=2806;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=JSAEZ6HJlTAJcObiAa6N//lRVUWeIEAORotoJeReHSA=;
 b=bgRDsGyWNa8uQsb9c25jnb8S9g7H/sFC2cv1x/lIl+I6LpRuO+Ud4RLJ99J/IE/jKIoB7QrBI
 HMWLPpiae2OD5uxA5PWo8pYFZK5su+4dkV47cKgmLKI93NXdqbVNfp/
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
index 86a531ffe9fc..c8c1761908c1 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -913,6 +913,8 @@ static int macvlan_init(struct net_device *dev)
 	dev->gso_max_size	= lowerdev->gso_max_size;
 	dev->gso_max_segs	= lowerdev->gso_max_segs;
 	dev->hard_header_len	= lowerdev->hard_header_len;
+	dev->needed_headroom	= lowerdev->needed_headroom;
+	dev->needed_tailroom	= lowerdev->needed_tailroom;
 	macvlan_set_lockdep_class(dev);
 
 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
@@ -1769,6 +1771,8 @@ static int macvlan_device_event(struct notifier_block *unused,
 		list_for_each_entry(vlan, &port->vlans, list) {
 			vlan->dev->gso_max_size = dev->gso_max_size;
 			vlan->dev->gso_max_segs = dev->gso_max_segs;
+			vlan->dev->needed_headroom = dev->needed_headroom;
+			vlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(vlan->dev);
 		}
 		break;

---
base-commit: 0248c33e835ecbec3a591f93fdaae53f7b90a4d6
change-id: 20260915-cve-2026-74743-5-15-7573a7afcdab

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

