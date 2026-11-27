Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745599;
	b=X1xTkL9P4+ihHMQmrW1TROJiy2bvOVdbImQFhU/Lz9iH1c0vtd1mLnkZcH3D9MCOhNRf
	 GHGJ6BUu47knwYwtBjIy8Q2CAcVYiQxFtDDcFxzi1m2hKz7kfSSbGUKUwW0O5sKA75QXO
	 1TRo0uFDu4QJA3QVwLKDoymfB3dA1YX7Ob3ProWLmxTjCBblJGdb2FzINVWEX7e3jTqmo
	 KjSk+AA0xuc6MhckC+qTuslSKRD+6ox3E9MOOpF9AC4G85Rc2ljNGx7FpBxk+Okx8MpJR
	 j/M3+3QtrJH/SQ/0Cw0JxNbrmAecEqhx2g4BvOEIzSYc/YJtCybfYYycIQ05Y7hmYTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745599;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wU8cZ8sbVXV6PQ367vq32gJ/yQ/1Tf8RXR1g3yzyRXY=;
	b=CwSbhCDVDfb8EgcyyGULmTgCSFgN5Vm/i4+I4fZkwmbClnwcxxXZ39QzDFv2TrcxvmeC
	 LIC4h7DS7feuSprX+3QkIkjwiBJcP7R0HRD9EeuBmBl1GoVGUZxEda6E0WXotFeBIzpsi
	 feW+gbXoMuYvEASAWOTSbb0LNLPWCsz05gQ/Yzbz+xIVoWA2qNaoS6dRqDZGogo3VDHW+
	 H1z6VwcGj7P3TkEqBD5IfvUeHCvm9B7POXTxg+2Hi2QA7fVkr6ZInX/V4MzaHYIKB7RuB
	 6sU3+4v8K/rCDIO70wTLtpV4xgJJO2s7RrekhmuDh000nplWQDeFHz9XX2M03cms+KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij4JUjgh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51C606A323;
	Fri, 27 Nov 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij4JUjgh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795745598;
	b=LTiuFpXGPI7GrYRnrXGP81U51uD7TOiX7FnQ/ddxnC+Cw/cgsZsUuUP5LAY4DA51ax/L
	 XzlO5dg5gDJ5nH6rR9O2nBHZ+d2tyh76M1BeMrD0JJhMmKbMRG1jT1htQ2zwLW/AsXrmx
	 fpxyo0qdb1xl8YVJo3R28pm/YVK//dA7x75Plb+2xRyMw7ALt7EE6w2DWcV31/N+ZW5dj
	 Cf6OwSu1c32auW8gFsW23hwBwe2Frw+GjduFMCZJFvYDaOitVdYwyhdlorkNNQNjSEfeA
	 qbmTCgmu+9ENXssPs8McsMhkuuYWeKt+q1fTIIozkdEPRi0NN1ihSZ3fb1UUdpwceaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795745598;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wU8cZ8sbVXV6PQ367vq32gJ/yQ/1Tf8RXR1g3yzyRXY=;
	b=q5chXfNqlEtUJusjrK2BtcPw1kCpIniefRQHRF03oseJn6lgCeXM4LFYdjLmU1HW1QJT
	 wBD9zddOyiOtDhAWQPmzHB/2NyLy0tRXrOrlnSetjgVflob6MyarfwWUQiEAwFYFexZ9c
	 Gt3ijZY5jtHHb21Qp0iIHIgT/lBB99xx7UgD/hCejO98FlpO1vT+MLcLLMfcm/g2Qzan7
	 cbzhzm8exWYAqdaDcxeZhvAgeDG9bRl5ou6mePjRuuuqs2ei9kCe5P7DsN57sN9volz/K
	 SiuzxsfVg9QzQXy1uYiXqlFPpuxBEDOv2tB7ZgrskrxYTDIDfkI9tVZJ3/QTOM31bNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4BD151F008A0;
	Fri, 27 Nov 2026 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795745598;
	bh=wU8cZ8sbVXV6PQ367vq32gJ/yQ/1Tf8RXR1g3yzyRXY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Ij4JUjghsEmelrrFAp7pFHJGjEc03V/mzK02msQTeIO3p4VFnePFZcfy2Qoug+RdO
	 iHTbvcDHRPlWr0diPQhdPUbGDEkE9TYYbsYUG4QYmxfrRsz2iTzGwrEkpM7LU9p/IR
	 KAotZP6z/Y2UNn8/ksXhXVRNYqIBc1UieWWBzXcmlDVDXtQKlnG+8uOxLSihPU8IgA
	 xvCxNYTK5UI49W14Y9TwJEQ/PZYZYrvxoh4MeEESRv+XmNrA6463pmOAoV3Dtuq1ui
	 vS4nI7WZTQAmcT4twg4bjZITwAD+HTwr0cZKqGHo2eUJ2f1/EFr99NCaSjRt789OO+
	 +h95qPJQwlE9A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6B424B4F8;
	Fri, 27 Nov 2026 02:13:07 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 02:10:12 +0000
Subject: [PATCH 5.15.y] ipvlan: inherit needed_headroom and needed_tailroom
 from phy_dev
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
Message-Id: <20261127-so4-ipvlan-515-v1-1-b8cbc7c7d37a@certik.com>
X-B4-Tracking: v=1; b=H4sIAIPmCGsC/1WNwQ6CMBBEf4Xs2UVaXUV/xXhoyyo1pCVdJBrCv
 9vqyeO8zLxZQDh5FjhXCySevfgYclCbClxvwp3RdzmDbvRBKX1EiXv04zyYgKQIdyey1DYtMRP
 k0Zj45l9f4QWoVlS/4frj8rQPdlOxlaY1wmiTCa4vSDh0U4wDFr79f4F1/QAd4xrXqQAAAA==
X-Change-ID: 20261127-so4-ipvlan-515-395b58085ee5
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Hangbin Liu <liuhangbin@kylinos.cn>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795745411; l=3601;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=GYY8CNKD4Vhjb/fIaxt5s/tjtVosIUaiFaM2oQ7VzIM=;
 b=tKTy0AN2eUJGg5vBTnjHo9d7J41zM8UTuKCppWpapAux50zL7AuTf2NqqYmepuRgw43zLAoub
 xkutM8LIvBlDA7iq0r7J9W8N2ruEfEVnMXgCmpOmTE2v2csNyCxfJrl
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Eric Dumazet <edumazet@google.com>

commit e16e960d55a40d36bd7c2494cc005e757dc9a1ef upstream.

ipvlan devices inherit hard_header_len from phy_dev during ipvlan_init(),
but leave needed_headroom and needed_tailroom set to 0.

When the underlying phy_dev (or stacked lower device) requires extra headroom
or tailroom for headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or
veth with rx headroom), upper layers calculating packet headroom and tailroom
fail to reserve sufficient space.

This can result in reallocation overhead, skb headroom underflows, or KASAN
slab-use-after-free crashes when dev_hard_header() / ipvlan_hard_header()
prepends header data or when lower devices append tailroom.

Fix this by:
1. Inheriting needed_headroom and needed_tailroom from phy_dev in ipvlan_init().
2. Propagating needed_headroom and needed_tailroom updates to attached ipvlans
   in ipvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Reported-by: syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a720a21.40259c87.584f4.04bb.GAE@google.com/T/#u
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#mcc6307f115e500df23ea2980d5669fe95f20b6b4
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Link: https://patch.msgid.link/20260806103857.115541-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted to 5.15.y: keep this branch's direct GSO limit assignments ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.1.y and newer already have this fix. 5.15.y sets gso_max_size and
gso_max_segs directly instead of calling netif_inherit_tso_max(), so
the two new assignments sit next to those lines; the added lines are
the same as upstream.

Tested on v5.15.226:
- x86_64 allmodconfig W=1 build of drivers/net/ipvlan/ipvlan_main.o,
  base vs patched, no new warnings
- booted the patched kernel under QEMU/KVM. I didn't run a test that
  stacks ipvlan on a device needing extra headroom.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/net/ipvlan/ipvlan_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index fe4399af8eea..ca97d1de6a9a 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -144,6 +144,8 @@ static int ipvlan_init(struct net_device *dev)
 	dev->gso_max_size = phy_dev->gso_max_size;
 	dev->gso_max_segs = phy_dev->gso_max_segs;
 	dev->hard_header_len = phy_dev->hard_header_len;
+	dev->needed_headroom = phy_dev->needed_headroom;
+	dev->needed_tailroom = phy_dev->needed_tailroom;
 
 	netdev_lockdep_set_classes(dev);
 
@@ -768,6 +770,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			ipvlan->dev->gso_max_size = dev->gso_max_size;
 			ipvlan->dev->gso_max_segs = dev->gso_max_segs;
+			ipvlan->dev->needed_headroom = dev->needed_headroom;
+			ipvlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(ipvlan->dev);
 		}
 		break;

---
base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
change-id: 20261127-so4-ipvlan-515-395b58085ee5

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


