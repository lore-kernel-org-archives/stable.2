Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC63D75BF
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606694; cv=none; b=HfPkEjI1Ab5YSsVC1qk4UK1FDGJRWuQ2npX0yvsWSOrw/nQ2FyzYAHbsVLk+E5lmV5NKy5So44lh4I+7TRYn5RGiLU0+tppZvt//T4g34sDh7LvPNNEiMyQBcpAUHw7yeRew5JSoVgEBFtO0PtiFdZvKYOpOiEVmVTssPs1SDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606694; c=relaxed/simple;
	bh=BYiitEcXHhRh6eR+a46Lb8G8JNceCCN8CajnI0gLC0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faz8raMaKKjVBZVONeT08IE7lsMwLbVbT7HM4jhsOsaEkRCQtxaAPeA/Ycqszy559beD9MXGuqgcFTllNQ/XcFBJvGeV1VcIZ5gi4XyUO//uYs8/vjegZWYiyH2s/6cSI5EtD3dgDaChGBPBXnd+rMkVS2OlQ8FN0upvevRI/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SODLkC8E; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SODLkC8E"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-beb7f26ed62so514648366b.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781606691; x=1782211491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBInyREsNJJq2tfrHgYP7popCDV3FF08GB9ZJkZM/f8=;
        b=SODLkC8ExCxdSeOM4CHON0mknsnQhBl3MYJxfH7jkyyns9ovC3gvqqm/B3dEHY0Fb1
         DUx2MbGPpKz8LH3GRoA8JwfZpVF6cDyvTcVvJnhh4PsUmCNG2J6U5+PegpOXPL8C4vI5
         wDb1Q7aTUztwq3hF5TK/TXuup3wjTsRjvdo5F8hiSG17IuHC/OH0kWzee9Uuk3JJl1XD
         SleN5VW4n0ckIuRiT6E766i9F3O549JFS6GJzNjzBK3mGq544Q2gJVWu2xxeSJ7GGOlw
         DWADagJ6EMH62idj3qmNSUu3qoNkS+4NomczkS5mcHIdInICirMsBTH0aAckWTc0ak+B
         idkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781606691; x=1782211491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBInyREsNJJq2tfrHgYP7popCDV3FF08GB9ZJkZM/f8=;
        b=gMBtrY0GgG7F4c0vuB7cVvXjtRMhg3Ry7LEJsyTzL7W1jlIwyDGBfodr4cLYPRweP1
         D71aK6YuD+LPny2Oh4EgwvLACK5bArRiEsdkDYV5kmbYYYa7MwQNuiteBuIKpzAwK7gX
         QaQhqkZS2/nWGRWdu6m+76a0i/e8qtk2ITsFQ6SGtQNpFrmk97kh2uN+mhkcYyV+I/XD
         zGnO7mH0NbQ/EYc0z+I+ErZntGHtPoMuZ1DbZRP9bSGeeygphAKOGA84OxAztDYI8l2l
         LkKoH0LjBt2LGROxLdkcqnfSaw0oSx3mcuaiDZhn4IhjH+4xB5S7QHdzIWWgQkK1F/Dw
         ddBA==
X-Gm-Message-State: AOJu0YwXWoZT85cKPEpm22yTrukRoMI1v8QqMVUtDv80ngew4GUVAT1P
	QgGeP/cgy/7b/uiN9nOnapJ7HzANtlApTN+7p4GJ12nlC29Ttxy2Ar98BqLWDPQiDg/VvQ==
X-Gm-Gg: Acq92OHQt3I4SL5OucTAeW2gpRH4fRe8VZu0QKCECR37IEJQvOqsIOJvIx4X0adSM9s
	nMYC+4K0SMInPZzKTtaEK2RUbVOaxbP7XQqPaYMcP8z1IYHav0CC6K3aj2aQiQlq9NCSiYtqOxo
	EYj7/ObW9c/mFkcxCs+aFKdHv+C5kLCxHFchWnqRzZFgULoq6j611bmEjrvSbP8raCrsFyEA7KH
	OYdoUI5wQhHPXQBlRHmitbuVMIbwJ9ka0dmEr1ONJG0qGOXn43fEvB4UH3MGsD/r6z5/xFP4qqY
	sP0jJBcj3FVYMaCrkuYgQSlFJPxRQk7YI7x25wVww9Oq9CkHTTB2Qofg8g0oM+PL0gS8q2R8XqS
	IduNpUpyRTkK2la4k9qRKds+ujoK3Lsdr7EiRFGfRtrqiYBLam0PAIXpktEUb6LKWVM+Ky+XNM2
	cbhDiIwd5uJOf+a8q/OK+1vHiJqj3mBPg5foBrosu+SVoJCRDeDKnXDTunYiKBqjvp0BQQ
X-Received: by 2002:ac2:59cf:0:b0:5aa:6c2f:2a20 with SMTP id 2adb3069b0e04-5ad427a8bf2mr621532e87.30.1781600513392;
        Tue, 16 Jun 2026 02:01:53 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1715d4sm3301048e87.34.2026.06.16.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:01:52 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	lvc-project@linuxtesting.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] tap: free page on error paths in tap_get_user_xdp()
Date: Tue, 16 Jun 2026 12:02:01 +0300
Message-ID: <20260616090202.693916-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2 upstream.

tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
and returns -ENOMEM when build_skb() fails. Both paths jump to the err
label without freeing the page that vhost_net_build_xdp() allocated for
the frame. tap_sendmsg() discards the per-buffer return value and always
returns 0, so vhost_tx_batch() takes the success path and never frees
the page; each rejected frame in a batch leaks one page-frag chunk.

Free the page on both error paths, before the skb is built. This is the
tap counterpart of the same leak in tun_xdp_one().

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260521163230.1478627-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2026-46320
 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 6fd3b14273b3..b51ce7af1b20 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
-- 
2.47.3
