Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8E44E021
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270399; cv=none; b=PTv8psL55hYddFmylNnFXnBipVcQ7WhKOl9TWThprN6aIp8zUywQNm+Jm9AsJdno+aMYoKwZnpvYF7DB/VoskvIY99OaQKM1lG3JXnHM+8m5OLdAC/8xUAMVWYMRoGmEJlk9YWqYuK5gadbMRyO2qqxOtjfzufJbp000KymPCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270399; c=relaxed/simple;
	bh=x0a54baFvgLulZaK7hwdAOkZGqHmXWGaHDXjs3jWf44=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=e2Hft5aQBVzpbrwGVzMKphxQJqzp7jVz9vwFDsh0zqAxi9waWzRMj8R9F0sZNvcxxb2iWb5w3VX7FSARtd4kpwhs2qAmIsvXcw0NunIUTITy52rXEAqBbOt2Xy4aZxtCHkU0u3kSbgduLCHAxhOOVb+vkIFwaLPmks2dRExRt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtDhR/P7; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtDhR/P7"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6611669cd16so220824d50.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785270396; x=1785875196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iGTsEgOoPUXtDGewDAlSCqR7NqhQ+Bb2E2P3Bhi1P1Y=;
        b=BtDhR/P7l3oCT2vlFy/ocrz5YEr+XzBNuQiKOA4PhPUUPeDUyJDvGWDppnxjqNk3VM
         HWT6nPrAYhA30UzCrgGluA/G+La/ST3uh0IisrngTbcewVlTfVHXUOocaEuuGYf0Auy0
         LufO5puQLLkUrF9kiY4iMRgTcbXoghWAkHPNwdlYPNhem9HEUHrAh+hr3r4072x/n3Wp
         a0e0e2jHLdsNIf5+E/nYrnQjTa44arwQmL81OJyfLi2jAcWG5gjgPuSTujGD1Qc/ELj2
         b7gRhagg8B0789G8QqfOAUo1fBSMdAuOZCqA3+n7ntayw45mBati7z+wtBKRdE9R6vqo
         uDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270396; x=1785875196;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGTsEgOoPUXtDGewDAlSCqR7NqhQ+Bb2E2P3Bhi1P1Y=;
        b=ddlAh+9ypLSH61ZOH6Jvz100swnXdQrhsfxaIFtcuvH7HRJNFNNXX9RQ/5qgKvOtuw
         7WRzj+dEYyCQDAff1SPQN+R6zYIralxWBNs/UvqXDaHYzOqFs7469jZT3v7Ayjprbct4
         wdzgFi+JLsAyNBSJwieRpHpuwvSwpAeArwZ7hCckPXMC7G9VxdSgKTzMf7qAfpMfsWfz
         gO/ETmu+hLZ7wNsas/debRP3bS+fZO1DuzXcdkmw5kK3o2V1pqQBlGCUo0X6eIWHNUh4
         BKpL358koDWPRAtcghr6+pvO64osF24v41eOtclpMMDWVidwztcGnowVwRH+9a5SB8Fe
         X0FQ==
X-Forwarded-Encrypted: i=1; AHgh+RqH5DJGNUmK23hDT4hvaf9LK7Fk1r4/BRWIC+p55FTKjRap+2yzxFBt4of07I2a7MUYppU97VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmQlzU0HJb/PGp9f0QJx3FllyCa18nWN97jPkWs1gRvkY1Ys/
	zhHBA0nZ+1qSn5TTqI9Fu7nmUNpvk6M83/Sq/OdKK/zhPMhjBhy9dKCL
X-Gm-Gg: AR+sD11eBeCcQ68ofu2nI8Eq7rTSnlGOS4taU0xI6f78zjTtPqsof7b3KFwyvrdXlNM
	qRlbdskN+6lfs1Gg5fhlDaS+0a6iN+gdda4lFZHp5Zg9wY8q4I2ArfwnSvnBq4+6e0nBSw3JQW3
	21/iD7hb2ZMDDD7fvs+MJwZN/ZjJWzGKx4pOYIF21ttSq2lTzJgjgJmV5xM9fjJ3k7GsTx2Ep+1
	9zSJf2HGeDWloAJJtnTTEOm/VMoJYc4IwKDY7AAzcVcwzQ8AvlCoVEx1c0psKaJcqLwovAq1BAW
	73Hi9FGms6w16he1QmRCIqWW8LUmBJT+jDt6ug8WvnvFKvu6UKI/bTAotGv3yIwu0BIbybB7pES
	umpx5t5mhgmKRsZtny12SXXHIsAFlrj3wXo+bpOervh1wn96jKMEldx97CvEHOgzY3c7+FT3aGL
	z8e9+fIsu8ehWz/4zOk/JIaHJrvu+122rpMb/oTf4TbUcfb/6Y7vkxrG/TDOvw+prAotdDX3D9d
	Z1GQX73mMKFGlD3WA9IMft1hZYoEL0vPacD
X-Received: by 2002:a05:690e:4385:b0:666:541f:6355 with SMTP id 956f58d0204a3-669056d089fmr1273483d50.35.1785270396587;
        Tue, 28 Jul 2026 13:26:36 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6691218c6fbsm455233d50.3.2026.07.28.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:26:35 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:26:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.1dc5730b40d9b@gmail.com>
In-Reply-To: <20260728031345.49562-3-q.h.hack.winter@gmail.com>
References: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
 <20260728031345.49562-1-q.h.hack.winter@gmail.com>
 <20260728031345.49562-3-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v3 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> tpacket_snd() reads dev->hard_header_len independently for skb
> allocation and header construction in tpacket_fill_skb(). Concurrent
> netdevice reconfiguration can therefore make the reserved headroom
> smaller than the amount later pushed, or make copylen - hard_header_len
> negative.
> 
> Snapshot hard_header_len once for each frame after any wait and use it
> for headroom allocation, copy length, and skb construction. Pass the
> snapshot to tpacket_fill_skb(). Reset copylen for each frame so a
> previous frame cannot retain a larger construction length.
> 
> The separate SOCK_DGRAM consistency problem between hard_header_len and
> header_ops->create is not addressed here.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
>  net/packet/af_packet.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 88674a6e868c..0ef9795e1d12 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2574,6 +2574,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
>  static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  		void *frame, struct net_device *dev, void *data, int tp_len,
>  		__be16 proto, unsigned char *addr, int hlen, int copylen,
> +		int hard_header_len,
>  		const struct sockcm_cookie *sockc)
>  {
>  	union tpacket_uhdr ph;
> @@ -2605,8 +2606,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  	} else if (copylen) {
>  		int hdrlen = min_t(int, copylen, tp_len);
>  
> -		skb_push(skb, dev->hard_header_len);
> -		skb_put(skb, copylen - dev->hard_header_len);
> +		skb_push(skb, hard_header_len);
> +		skb_put(skb, copylen - hard_header_len);
>  		err = skb_store_bits(skb, 0, data, hdrlen);
>  		if (unlikely(err))
>  			return err;
> @@ -2737,7 +2738,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  	void *data;
>  	int len_sum = 0;
>  	int status = TP_STATUS_AVAILABLE;
> -	int hlen, tlen, copylen = 0;
> +	int hard_header_len, hlen, tlen, copylen = 0;
>  	long timeo;
>  
>  	mutex_lock(&po->pg_vec_lock);
> @@ -2784,8 +2785,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			goto out_put;
>  	}
>  
> +	hard_header_len = READ_ONCE(dev->hard_header_len);
>  	if (po->sk.sk_socket->type == SOCK_RAW)
> -		reserve = dev->hard_header_len;
> +		reserve = hard_header_len;
>  	size_max = po->tx_ring.frame_size
>  		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
>  
> @@ -2822,8 +2824,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			goto tpacket_error;
>  
>  		status = TP_STATUS_SEND_REQUEST;
> -		hlen = LL_RESERVED_SPACE(dev);
> +		hard_header_len = READ_ONCE(dev->hard_header_len);

Can this now become inconsistent with the reserve read above, which is
not reread per frame?

> +		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
>  		tlen = dev->needed_tailroom;
> +		copylen = 0;
>  		if (vnet_hdr_sz) {
>  			data += vnet_hdr_sz;
>  			tp_len -= vnet_hdr_sz;
