Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327588;
	b=sr/tUZX4DMuNegvxlLrK6qCx1aK5r/w8lOflHbm6cW0hvZ8BFaTMrWs62J+3oy7VeW+K
	 IqZLoRt5SBIAU+eJAD6DleJY6pgh5+I9ZNSfMrDwIYI4v7yQjWBI4WglN6Nfxn+Pcs50F
	 s7RIFR8hDtFJchp7sLQLYlHJFxq1JuitD9yMtdng47U0rCVDxlnJboNPg+1dpSbH9M3Hd
	 Y4xu4xrsYp9GHzGV+mFX2+E213EV/OBTHxx+srsjC/iQ9ouWy5BYNVGpmtEiK8E0LBYrI
	 gIsWy8TKFdimrtlkLcU88w4zjaQ/a1woOrEUeLLLAvhk0ma4Km/THJiTZnQHZCKlZ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
	b=orOViOT9dU/wNINf19LGY7AhAdXudGK5QZazb/FRCwLcaGFonpmnwcjCbMMvTuH9Thbo
	 6LkHu2DzZKhqAZEsw61xk7L/Dq97FTBXfWfy5njdC5OQ61Szeo5hcQWvvVoFYt55VKglA
	 6NoG0YNFhcl1l58ENO14lnF1vQKMppd7RxrsjoyZdnga0DpoxzBNFJXCqXBW92XXEGwPB
	 4FsD8pERm9S1MNmMpmmQ/ofmmFM9ft/odFPeekdndzTSeWnCYHqWUAnSZKebTCxOu12uK
	 tK1jrchltk9UTGGHwhXV7lzue/GJmlBxTVJP7qyaK75+kt09iuE2EhArP3iS1fcw9YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyXdKLmK;
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7157606A324
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7157606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyXdKLmK
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd1da63bff6so2622a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327587; x=1793932387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=QyXdKLmKaR0WHK0cJTyFaUEpfibyyQ5fW3kfeppI+vJOMhX/FDqjeS5UvEkcfOh/Uo
         1Wshvu8W9MHdPi+8huvuLQyvCeClepU067PEo9L6qJSpL3CLideAGORYNP+htWkiex35
         cuuJAzAs60zHbt9J/E0/3obXUk5lF8JFwiBzv/wsVpJ1WGdxrVyuTWIJjTIDNVs2eKAo
         x8+ehuhDeYWrDvVihQjj1onRG9tt+RHuw9H+aoVnYhPozwBhthzYcwLwFNEn889tbE78
         qia9oIKxu6TAi7PmpnL4ocyoXPtmVJtBOpTsYLyaFb6R2iZyosdbH9WnJkpghCJWGGoc
         Mc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327587; x=1793932387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=SoTSlg7DrLIw1s9T+V/7zhhfNTcFmOKMSPdw2eJLQnEqi9tmpBQMoZKwk1ro1mKhHZ
         X8vxeV5FmqeqUaLq8cHkoVxON9B9LVXCB9XoXgtY+n+GVuDsX60NIYKOihzcIMLgPuHe
         iBFsYWoepER16C8csMTaywu8ixbTcToqPMtCWpMDHMqhYlcLJiJpaSrbm8kYGJiJTDGZ
         3eBC31ETPUK9R/6pUwYlaS+Gq8Lw9hj/PvMmLJWzXc8JLJuoWWc9zHsKuWpLCW8tJN2c
         7tl2sRRlbkPQk0oTycXnnS5F23JzrKA6NhdbE5thbvyqhcRax0zQClSTaP8DhbOdVwOC
         oVTg==
X-Forwarded-Encrypted: i=1; AKwUvBz3THnxeZQIhXLjm2lZD2mRrR7ePbw9bLJPeiRHIuwOkPZHk62Y1JBd+X8RUAAnr94WS7FAdvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/qkbJ3tZhO7pa6+/F+uCiJvNF5wtRjlBBUuBeB150S/4Nz6i3
	CbRM4xZls3+Mc58uJUccI9Wa4DwPHgIUTu81xaOhH9NcoVtnc1dN9jHu
X-Gm-Gg: AYBFou1g4f1Jpnvi7BYV9GpyXmEaSjRnlSw7KjNGnVsbbT/nUGz5H/zgJPQui7fBzGz
	Uae5DIBM3B9a3JwXLqEyu7T1ZB9AFvV3Al3cMqA3i4yXeKc61dRiiI1iAVrNQtoPtXpuwme+Fxl
	OrDmYNTUVKKMAomJSO7gzzJd4x70Kx0due9ge3pIcy7QSo3WbKXpOTyhbcbWMR+iV0WiQOrzluO
	qq6CgqkC2TGqa//MXhj9c83yWgumBpUJex+VeODUJCLvt1jSkJLkcMVy74acIHfbNoBaIIcHdDQ
	NYk68QTi5eKqQ/hja3leNIk9W1lbasmuoBJbpyzKFO6z+P2wBbLNUHe9B5Gu3kj3DNxGgPqGq+W
	/YZ8zqjy4OUJqmzfwGdbWiyV4DQRKOHt8XO84gmvA85N71JE1rsQwgILyILmaIjAK3GaRkOFG4P
	Qlvp5fz8k05f2WSJv/8Z3ucoYk5kDs2qiqo/jHe543uR7pekITbYvauDzEEEVmSzcRphN2OTFCo
	3FTDJioqAhxuEk/8fHsIKQUnqoTPXimJSsCrQESjmMd7b8MRz+SJjenDrHlw1K+2tOGcNYvu4Mw
	ZstXpU5veqRqM1MeiWslZGkmxyXUmQXjlf0CTYGd6fKthelJI+iKceY=
X-Received: by 2002:a05:6a00:a256:b0:882:2195:5a73 with SMTP id d2e1a72fcca58-8a9bfde0494mr516804b3a.29.1793327587137;
        Thu, 29 Oct 2026 19:33:07 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.33.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:33:06 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 10:32:47 +0800
Message-Id: <20261030023248.78802-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261030023248.78802-1-testwrzwrz@gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..aa6b010192ad 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xp_mb_desc(&desc)) {
 			xs->skb = skb;
 			continue;
+		} else {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
-- 
2.39.5 (Apple Git-154)

