Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661116;
	b=RwAdjyW2+2ZIED7Sslkg5rFs9Lwq+b55HTmHFcUyX4n1SMzaMDNt1y+zwEkzD8eAkNHi
	 yOdX5QKoniW9zEqk0xXlyWn3zWVwQIKDE7ZOOdW7LYAMPKcdpaZG87hPFQvixcF7RyiUS
	 +SUVMf+ffaKeoylrfboMH85F5ffHqoznAdr02GqUUp9vWSzITVEcfAB452vX1zAFy9A4u
	 L5TeB3f6plhrphAnMkkl5MsbOECNVqqysM9w6o9yuuReAWqI164iDFVS6wKqQMC20z3xl
	 Paw3xH3nHDc1GGU5/aq/Itggr8QaBdRgx5xSDm9IIs/pO5L66t/7FufbyBCfP2dck4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Qy0LDxWtU3WiFF4Cpmua/6KfacVExA5tS3ogGXwY7VI=;
	b=pcTLLtQwYQbokKZnEY9FBtAqkzJ8vnl5UassmgpTGZab7Djc2O9UnALrFfTwp6sOSkf4
	 sMbJ3S4umaKypbVd21nTM6BB71g7ihW0MStgJ+16VeIQnXSQ1BApJCR3DMtKXNRwP5VIB
	 pJUh08TcwRycQYLuh6X+AcYa3UiGwZLOnsQORymGTQ7AcPHQ4FWW0eUTTpIXdbHuS/T4x
	 6cAsCYbl+G6s6E9xe5/So3xso2qQ7p8K41d6yW1FXTUoX5sL9WV0SWmXQj4EX2jzfg1HS
	 WMuitjUluLv3xmYUmr9meKt0FqTlHJa/3YCcitq/FkqilwR0RMOQqV3NWTVVNJ1LqYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Uz7PizGr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A26606A333
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A26606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Uz7PizGr
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67da3d03263so6785735d50.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661115; cv=none;
        d=google.com; s=arc-20260327;
        b=XQK0djXWVX8fguhtaFib/n4LqTJ8Wdngjq+O2QChzvz2/RDTzScvyAQ2loO2oyV/V3
         flIFgaJyJ77DZnsBrqbMY8Iu6Ja7kKFLrzOiP1+iR2tCt+gcqHjkYIUdUFzVmhLQvs/P
         WbMO9YqWWHESWsCEWQjMQ0wrhzDnRjbtbkj989ZnQRjN6v4T+4NCnFcwXZmoO0gaTNAw
         fUBscNrYqywbTXiRkjaVHMtFQWO4JPK47iN2DhTWhZh/2QFur2rZWAcNBbi3tgMoltzq
         pWrNF1cnPXPkvD/DD+lG5Y23rhcONH0uCKRBzPFg88ZeYYQvyMUII5nAJ7Zdu8MPZ1uL
         /IpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Qy0LDxWtU3WiFF4Cpmua/6KfacVExA5tS3ogGXwY7VI=;
        fh=EChBzbLoYYIHUg6MNT2HesXilPFIDKYim1Gp5xiFOHQ=;
        b=bvduQlvroiFxIwJXg1ZWVOf+p8K4oBirKgMkLffNAiA0/WEfCFofyAPCHGP8/Jmf8P
         KA8XsUXM47ffuZNyrzUFcHZTrqIYCedNKcNZdMT6ozEqKgeKpXi0BjT7u1Nb+ax8WcXh
         Ijo6Xov5x4f3xDykMzlwk5JVzmjHOFsmYnLDvEZ+jmXBYRbjgQx7jrCVLOfc+UZZE9mj
         fHYRS4Bsn52/CBicAgKxpO6JB0a7M1VmuE48c+IT540rY2p9mKUvMHFRhyZSZuds//Ko
         WPwojGaklDo11nZ1J7Eqf6vc1NB9jlzWN1Gh6X7kBhbM9NMhivD/aHjfI3dgWdwf18Vf
         f1wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661115; x=1796265915; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qy0LDxWtU3WiFF4Cpmua/6KfacVExA5tS3ogGXwY7VI=;
        b=Uz7PizGrPPUeLp1h+R+wrNBbwpySLPvVXG1ZD9uifhwGMwE9UrwNwARIbAbJtaFLK8
         Tbs1SpxiAeZaQQK0Qv0BUUfkHQlw7moNmybMAQIXN0pHCwis4PIUuqKRO6rkxv1MZYEz
         Mp0ReY4tWE1xNd6VW1qWhyvDlhPjtyyfHoWvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661115; x=1796265915;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qy0LDxWtU3WiFF4Cpmua/6KfacVExA5tS3ogGXwY7VI=;
        b=rTAPW+MzzotGrsuBgHznJ061lr2c3VI8RHm9uC1cH34/GIFQHa0E8S0zPGYkW2XU9p
         dziNUZFIYK7HgyOJWapMPewjv6CIRg+LufwGFZZxdUl17XRfk59ewWq7IZNG1Vu/dYCg
         Orr7V2G63yaMYf9WBQLgOjojHTEmc+Wafdslj56GyGI2dWqXir12TDfhX5Nf6k7yYqmC
         SMuq/ObffyAb780bM/6TA26E/wWBSxHMWdf7Gx8QD7sNFvbaoBn6EDM+Oexk1Q3wqV88
         q4EcmlreH1L8xWaDl4LRe1k7Tt6E20+ovvzjEVkb+DRDdA5DcATOyj90W6DRQPzKr3NY
         x46Q==
X-Gm-Message-State: APuU4Z/XGGjGdA5zzNRxZAhIv5RhvaTpx0hy50tR5zXJAAyU9NFWi43m
	wCV4t6pAeW6c0C09I+YsUiq9fl3kWHL+WG0eZR7EyuvvaiGKXitn9gslR3qs6lMK4Uc+JJ2DFF+
	L5fu7Rhed0QT3zbJ/Ymd7yFZArD0V94UxA45pnEZqnDkHGLTJsXfIpE8=
X-Gm-Gg: AZFdTZfj01xXwEnrVFDKX77VLzw9ND833mEvGCZEKBVx0N9sZ5Srqou4yo8R23rWz+o
	8fL5N83rk/0+qVRFwd95lM+pGwM2xXe0choqmtGOLsQ42FNzS8gIfbJRVipIQQP5IG79OtR3sma
	lAcH1vMbCFv6nINf70ss49PvqTD2YaSQJm6x5P8RgSbMzcjl9QPpcQxjhZBrb7nXtpM/zkCpVTL
	hrNJIBSnvqoYNGkwXCCH4kdZKERj5g8deue/8N1+jEBgcuyFON8p2QONJrMy6CFmFzW5lRtH144
	yf+yVbvuI/I5J/1EpacVW0q8N44MGql8YMdoow6WYt7JNcVHdfgsHeUURkVGtIuNjkDARgi291t
	hDdRusIsUo3SHW6nl+pLtkoUY8w71T+BtJ8BXCl5OR5KRWngYgjfPbD6QIVos6xxD7vb+QIhnU8
	EEgXgvsZ+nMvSls78N70V+XEP+4Y4vUvF1PvLjRiP0xguOsFRper6kYfd1CxSwoJYbiqjY5EmMZ
	j1i+OCRthORULGy79XdueO4vwDc4jX8fYo3
X-Received: by 2002:a05:690e:bca:b0:67d:bdcc:4264 with SMTP id
 956f58d0204a3-67df44c180dmr6240267d50.147.1795661115337; Wed, 25 Nov 2026
 18:45:15 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:14 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:14 -0600
X-Gm-Features: Aa3M54qTPLQ5kn2kbiAX2CcqbSNatDCxsIG9F8dIgEARuqCsHbX4tztvVfGoQSo
Message-ID: <CAFaZ9eob6Kg4WDo_m203vhom-XtsNN1kFUKgyUs3DcCTev5msQ@mail.gmail.com>
Subject: [PATCH 5.10.y] net: mvpp2: refill RX buffers before XDP or skb use
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Til Kaiser <mail@tk154.de>

commit 5e8e2a9624df72fca7c736b2966b2cbf6c9c3ff6 upstream.

The RX error path returns the current descriptor buffer to the hardware
BM pool. That is only valid while the driver still owns the buffer.

mvpp2_rx_refill() can fail after the current buffer has been handed to
XDP or attached to an skb. In those cases mvpp2_run_xdp() may have
recycled, redirected, or queued the page for XDP_TX, and an skb free also
retires the data buffer. Returning such a buffer to BM lets hardware DMA
into memory that is no longer owned by the RX ring.

Refill the BM pool before handing the current buffer to XDP or to the
skb. If the allocation fails there, drop the packet and return the
still-owned current buffer to BM, preserving the pool depth. Once the
refill succeeds, later local drops retire/free the current buffer instead
of returning it to BM.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Fixes: d6526926de73 ("net: mvpp2: fix memory leak in mvpp2_rx")
Signed-off-by: Til Kaiser <mail@tk154.de>
Link: https://patch.msgid.link/20260607134943.21996-4-mail@tk154.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ adapted to 5.10: page_pool_release_page() in place of skb_mark_for_recycle() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
5.15.y and newer already have this. 5.10 has no skb_mark_for_recycle();
mvpp2_rx() there hands the page over with page_pool_release_page()
instead, so that call moves up to right after build_skb() succeeds,
where the 5.15.y backport has skb_mark_for_recycle(). Everything else
matches 5.15.y.

It goes with f3c6aa078927 ("net: mvpp2: limit XDP frame size to the RX
buffer") that I sent for 5.10.y earlier. The two don't depend on each
other.

Tested on v5.10.275:
- x86_64 allmodconfig (CONFIG_MVPP2=m) W=1 build of mvpp2_main.o, base
  vs patched, no new warnings
- x86_64 defconfig with CONFIG_MVPP2=y builds and boots under QEMU/KVM
- I don't have mvpp2 hardware, so the RX refill path itself is untested
  here.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 3e60d40b3f6f..5915a8cdeddd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3613,6 +3613,12 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,
 		else
 			frag_size = bm_pool->frag_size;

+		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
+		if (err) {
+			netdev_err(port->dev, "failed to refill BM pools\n");
+			goto err_drop_frame;
+		}
+
 		if (xdp_prog) {
 			xdp.data_hard_start = data;
 			xdp.data = data + MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
@@ -3630,12 +3636,6 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,

 			if (ret) {
 				xdp_ret |= ret;
-				err = mvpp2_rx_refill(port, bm_pool, pp, pool);
-				if (err) {
-					netdev_err(port->dev, "failed to refill BM pools\n");
-					goto err_drop_frame;
-				}
-
 				ps.rx_packets++;
 				ps.rx_bytes += rx_bytes;
 				continue;
@@ -3645,8 +3645,21 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,
 		skb = build_skb(data, frag_size);
 		if (!skb) {
 			netdev_warn(port->dev, "skb build failed\n");
-			goto err_drop_frame;
+			if (pp) {
+				page_pool_put_page(pp, virt_to_head_page(data),
+						   rx_bytes + MVPP2_MH_SIZE,
+						   true);
+			} else {
+				dma_unmap_single_attrs(dev->dev.parent, dma_addr,
+						       bm_pool->buf_size,
+						       DMA_FROM_DEVICE,
+						       DMA_ATTR_SKIP_CPU_SYNC);
+				mvpp2_frag_free(bm_pool, pp, data);
+			}
+			goto err_drop_frame_retired;
 		}
+		if (pp)
+			page_pool_release_page(pp, virt_to_page(data));

 		/* If we have RX hardware timestamping enabled, grab the
 		 * timestamp from the queue and convert.
@@ -3657,16 +3670,7 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,
 					 skb_hwtstamps(skb));
 		}

-		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
-		if (err) {
-			netdev_err(port->dev, "failed to refill BM pools\n");
-			dev_kfree_skb_any(skb);
-			goto err_drop_frame;
-		}
-
-		if (pp)
-			page_pool_release_page(pp, virt_to_page(data));
-		else
+		if (!pp)
 			dma_unmap_single_attrs(dev->dev.parent, dma_addr,
 					       bm_pool->buf_size, DMA_FROM_DEVICE,
 					       DMA_ATTR_SKIP_CPU_SYNC);
@@ -3683,13 +3687,14 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,
 		continue;

 err_drop_frame:
-		dev->stats.rx_errors++;
-		mvpp2_rx_error(port, rx_desc);
 		/* Return the buffer to the pool */
 		if (rx_status & MVPP2_RXD_BUF_HDR)
 			mvpp2_buff_hdr_pool_put(port, rx_desc, pool, rx_status);
 		else
 			mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
+err_drop_frame_retired:
+		dev->stats.rx_errors++;
+		mvpp2_rx_error(port, rx_desc);
 	}

 	rcu_read_unlock();
