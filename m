Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA558435A84
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311225; cv=none; b=NTnSJvChd1ACfhzj/MzHD/jiM+nYqmmS4OHjHCSHUhYAsge78D+O/WBBZveqdt6c02tYkHA0ZmQ3Uz0IHQmZqahrehHKVyq0LpRGHpkTi3bLUGhQ3laANKNEsdAC6uDk349P7MnJGRZifJRl5BKFN/VH3nMN/1EE5r1eOxR2CPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311225; c=relaxed/simple;
	bh=9kavyCdJQhbZRgOh2msN4/g5t3JYc3aUaW+NIQkmgmA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qqRkeZbgHA3K1/4BsmmuToqpJTaQKqNH0KtP9OCv/HX9jYaChCx0OcIh64sEAv33ZZOKwKMuoiOVX53008v4prYeDuCGTQutMHPHzqlixAPTerI4VLhFDDO44csMYc0bGzQNeIh2Zv8y3LzBC4MjSg+EQRadTt8ciU6yQTSDn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7RoTaWo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7RoTaWo"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80c5cb9a888so8290847b3.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311216; x=1785916016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bto1bhcFQyQcgLQ0r2ywHcv9bZxh1rejer77lEyjVdg=;
        b=H7RoTaWoCjPnU2QnAIS29fx0HsT/fSQO3fdMXoy4Q/WluC+awQEoAp34aWXxuT/8ae
         Ntf4BLSXcx6yKz2g5r4hKtLzR9AM/HtPmcUPnoiRhlwF3XHneh5OBz37GT1XTc2Nsb2M
         01Br5AHkPcKyLh6UJmLCgqEV+5a5Rn5+2eQhkkXoi8T14B6d0qp1+9COL7zzDb8Prs7v
         Zi33qUKvW2Gn6IdD+7MgQ6UzAz2R9d6ICTaTlrdsQsbQSpwDJ3vbDo11VOy35WIsOkhb
         PISlcD5UY2H7BXr3ClalIPlV5cEJ8gOuMl6PQcRN0jagHZQJ4UZfTKjzW4Mjq2dvxwAM
         Q6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311216; x=1785916016;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bto1bhcFQyQcgLQ0r2ywHcv9bZxh1rejer77lEyjVdg=;
        b=QYlTCPSyYteIu5eD2CVT4hWTqVtRluJ2lZCqvXx2AbCpR+a8OtFsm3OzayOcP7iTDv
         EgfMncb8V03udHAxhkOdQRoSph0D2f0rVogaY3xzdJHb9oA3MwyHSMstalUWEET9gu63
         YwtYPEL8WsSqFDiknbKvLxeECwImtZQkYDQ+IF9tpkNYgEp1kALB5QPFvMonZH5/EKmh
         YzYRdWD6bPWObmfFiIXJ+b/ysdjy9vNT3BF9gtUJtHmZwvFfpWdpcQ7gYJqLckPB5S29
         +DWv/1QD2vGYmB4jgQ/B6nf5gqExLpAvs5NSQMN38MgFWinOLY5VLoou6VusvoTLKnUy
         LuzA==
X-Forwarded-Encrypted: i=1; AHgh+RqUdKSEt6dXdj6KzPylCy4FUmEEUepppX+Hg9A6da0icBOG0ouJL0IwRMGJkGy3fij7CDuX/Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeL2RmALWX4qKwoheWgQt7ScGxsIgLVYhcupb3Vd5mtSFB7Ofj
	27SeMHyEw2MPd3DNAOf/Kh95MQLelg5AkUUsKVHcjm5r0mpniVOzjIH/
X-Gm-Gg: AR+sD133gAoP8avRbPBNFvbZNJExL+EFw/UIAkvpqJyvY2y0w/Mt4Fmcgcx9IuCyqkh
	LcYEELfIPZGiJPMf5ORW4p4KiZVo3wcPWx47AbZHuhkfTv5Sg/KT4mgSuDhvn9T42bJ2GBs2t34
	wftD0Wo+XPGVV2zIsdishaJ6S83CUPu96rHl9cHg7fDh5dyUtP38usSdmo2lQ5Qa7MyDNJSPkcJ
	KQxAgHVWthHhC4hFPYvdzfbYE4XH0qUFpNYMMYC1T9k4DsOsQx0ZeFxwbx4yiTruShlvbD2L2Jf
	sFuFeMrRLiwpQYMyMmZ5Kij9Os7hQgKmM0Ql30wp0zCSfakSP0KYmykfJzvr1I5JMPlPms+Ebxh
	nmY7YEFGRNRV6R1EeBl4bz76o7+2ab7rx0+UJhFaKMEWjIYvirEAnGAQjCOFRvpIxS+5kstaixO
	BMh/awMynDpKiyniuKj4FPLPPFYoRUFpDcErvWXeYZnawUaxBHnkOG6Qd/I3dw+pBWVhXjJa20c
	z7V0szw6uypOFw44aN/DLdxW/LnYfX03pPu
X-Received: by 2002:a05:690c:304:b0:81e:89b2:8caa with SMTP id 00721157ae682-81f9925966emr29619837b3.29.1785311216072;
        Wed, 29 Jul 2026 00:46:56 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa27985cbsm13921187b3.16.2026.07.29.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:46:55 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:46:54 -0400
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
Message-ID: <willemdebruijn.kernel.36b6c7169b6c6@gmail.com>
In-Reply-To: <20260729030122.21462-3-q.h.hack.winter@gmail.com>
References: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
 <20260729030122.21462-3-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v4 2/2] packet: use consistent hard_header_len in
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
> Snapshot hard_header_len once before processing ring frames and use it
> for the frame limit, headroom allocation, copy length, and skb
> construction. Pass the snapshot to tpacket_fill_skb(). Reset copylen for
> each frame so a previous frame cannot retain a larger construction
> length.
> 
> The separate SOCK_DGRAM consistency problem between hard_header_len and
> header_ops->create is not addressed here.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
>  net/packet/af_packet.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 88674a6e868c..8ee0a80fdcea 100644
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
> @@ -2822,8 +2824,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			goto tpacket_error;
>  
>  		status = TP_STATUS_SEND_REQUEST;
> -		hlen = LL_RESERVED_SPACE(dev);
> +		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
>  		tlen = dev->needed_tailroom;
> +		copylen = 0;

Why is this introduced?

>  		if (vnet_hdr_sz) {
>  			data += vnet_hdr_sz;
>  			tp_len -= vnet_hdr_sz;
