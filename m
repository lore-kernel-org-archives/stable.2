Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795159414;
	b=5Ao1DywynJWSL20/R/U98rrbjP6SiuUIJ1ON0PSlKT3ZRJG0yc4MaMqW+TE/DGvI8GXS
	 FROOdrUF+Y5vgb5fMuSb5OLr8RT3D/eRjKpAXdT9BITa5W2PUcsEdEk+7MnO6HTc+45Z9
	 bAK3F/uTiKrYA9sjfNstAMqgKZNOGQjYYz3vw/krPQ8M0hyyRxBsYd1Cu84utcR2i2ldt
	 wXIg5oCKP9thqdtii/4bcuEWkyIG009OIGtWPGTZ9c0vm48yz/wtOPqHnC+9LiHkOpqPI
	 DFiRt6ckMwjmsmaceckKGAQleapoJ3IThqnzsTjEEuaYXPdNDrL8tCqdUYxLD+PdiPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NOjguDHiGpliPje8lgUyj591MMGA2gJ6nq9lkIN3/BM=;
	b=BQZMmhsuyNjGonWNyY0jWqgYF5etRRQowI2NYkBDHiRaYy2/+xD3HNNUGTl1ckwdMQL/
	 YkvLZQG7roqNLPbFYURUl0gJqId8QXN9VAhhCJfSECV31Fol6D3VTaMbXgYCsibyZysod
	 UArvpMPFVYtkkBoZNqFSgc4y7+elf3V6R1ZC1r4YLXcpSaUnk5NazlQ7ozrU+OPCPmITH
	 ZdOnVNk4YEtuS4IgG8lcu3k5WM3FZrQk4y4jLAqUTWyCo0+bGREz3BP7mb9ZrZyXnDK1G
	 Q+y2g8At95cehWMWoHjC6CSsewZefNjnhRV76T6Y23bx1tk36Njk790c/e1ouzZAqbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0Z2a3k4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA1606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDA1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0Z2a3k4
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-498f5fa5103so271265f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795159413; cv=none;
        d=google.com; s=arc-20260327;
        b=Mh1S2ag90Iwo1lgrFb7dotUubry0ovbrGVNpjz4Bk/3UAB9DSZuYdh93O3wubXdZ7I
         JWccCJI9GBKRRqtruxBBslHgKSAv5uc+sHdP2cscD4rC5HvEaYlSkhiHB2r886rpb/5u
         Y5RS8xEzeBe4JeX4klX83IfzW3iC7iuevktI14ClLXhEOhh3K3K7tAnLlpdfJJgRiaMF
         EMuJrTYjyInvojZvfsr3qQNhvgeP/JMz3Qvwd7Bz9ovDLpI+FOi/8xfbBIZuB8L39eF8
         rUyFKHM+ZjJe5gAmqakeI/Lv9qpjl6eF3bVt8t8Pdb7PDriP6IMfmGEJrVblJG3iPJld
         XvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NOjguDHiGpliPje8lgUyj591MMGA2gJ6nq9lkIN3/BM=;
        fh=vScu0+ZcB4qXhvr6qBiLk5gpFhX/J5hw+Myfw9qUBN4=;
        b=eCVAtjACpZMsMSUQrJkEeWBeTu1VXHJBZqzHzHxv3+OHfubOd4fy8gaUHLyURkHSkC
         WQ44V6IsP04sAnt9VlQ7xdxb9iyOGOKSW92lchcB0BxfbHkSrtu1IRTsPal7MUXHxqvq
         0yI5zfklT0KZ3gEc9+sEhbhU6ZkRbPyx9bKwCc9L62WN2oTg5PGeSnlVxXbiNA+/otgR
         DSCnHcJhRUaItcWeHjmae94/fTaGxmR2q2vbY00VzujLDIx7terh+kdTzxdFUNhLDTP8
         j8vGhgSeDFI1u+knapNQ0CZFt5LB7OuN6fqR7mBIMEmilstBAeoCgdbId+DVFeTEu4D3
         9M1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795159413; x=1795764213; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOjguDHiGpliPje8lgUyj591MMGA2gJ6nq9lkIN3/BM=;
        b=C0Z2a3k4h9LGR5OCECjXLMezJNKkzAAyjBN6mS26BgF0GZamujoIU8xhVlsorWEPCF
         jDMeCNrmbUxmZLDFW1Emi9PI0jP/y90t4PwrXqwrwvq8Td4n0mK/dMxTOmSvZqhpUSzZ
         CMan7JvHXLPvAlGubdfhqt6RvN31/Fgt+nUseWYQ76RbvUb7Njf7MirILJ7gNjLAHeZ+
         OzxSy+wrY+yzTH3Bpu4HzrW/2tYB36XJKJnfqcmZRAhLWwyWnzowWTcFE4sLrOLYfWv7
         N+GtzES1pHOypKwF0NL4s4YNPrJr60exo2MceoFl5jzZ+wX9Dv+fzDJXW9zft/2rqoQT
         88Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795159413; x=1795764213;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NOjguDHiGpliPje8lgUyj591MMGA2gJ6nq9lkIN3/BM=;
        b=UYHGJwxfpQF/8hKQ2XYRw8rhWdC0UIw6aMlOf5nqnggty51GrFFgYjHbugcHT5zmsU
         aZopiEhLVdRHFtk6tDlpMUDukVC025uJVZV4aLewFJH69rfbpHRmK3KOYNYZWjAv2qRF
         1ZtEgYUUM0ifoKztcuqCoom9prKFpdHBaByB45P+Qn0UoHnB78gvCCkQivCN6Omgjnrf
         2jvtLbATSQ+z/0eSI3Rp7wmXwly9/O77UMxbNmVf3y6r15HIY5IQ4j/zpBa74oANuToO
         CdmhIhH69c1NmIA3H2LM6Ug9FN4GBJ5ac5XeK98mhJZOJ6JZOGUXGT5MI848RdgQDA8L
         l5iQ==
X-Forwarded-Encrypted: i=1; AL+hErFpAIQeBP527Y+kOcMkKYO7huRvFd9/9R89RsPOfMRwY7RlUR8bXxuQpELlrvDTpYHHrkW/r2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v1Fp6/RCP6DYW0Ggl9QwC1pi2c3jZ6ciH9S+aRF0TToKasaXv
	B9in1OhjGsmp/w65WrrqqiCoFoGnQlkZYxch50PPVFh0YbfSOqkVNcF4B/JgFvO4snhZ1B/lX77
	3nXh7aWhmjNSuxvunfWC5A6Bj6uG61Ss=
X-Gm-Gg: AZFdTZeWPZ410AtlGbNWtK7NWe/fl2eWs+A9iCHz1MS89N3W+hT6TdapMHcZwXQpV5z
	43C7f+NUekvtK5xRJM5FN/Sa9gjMsHR7GlbSyISbFqvRv0q99iH8MW4ac2WP6G4Qw25OJ60Ffc3
	OSuNZDILWXZvCj6yTH6ij7awFl/zJ0vsOo6qRvquaodN1ysWxw3Cbx/2pZSfA5crO64iuRO1v3K
	XaYuVcDp3p79rxnVVuuoUux2Qt3Zl/Xg+hCXrh7GNJw3zuQwO6aTzbYoV2HUDJ7srBFM3Ufe9Q9
	LD9wiYsejvAInV3x4Qks9+SyXoPglgwoJmmWvE6l8e0wIKo9Kj4beQrcC61SeUK96Bw8kFcqFfO
	t6uaGMWlC+/twACck37OmVONg+jKfNHG7DZTXOCi+n7k6hyTnWsN3Ht0BVg==
X-Received: by 2002:a5d:5888:0:b0:490:a481:7ac8 with SMTP id
 ffacd0b85a97d-4abb532ea79mr3553673f8f.29.1795159412630; Thu, 19 Nov 2026
 23:23:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119124928.1398520-1-maoyixie.tju@gmail.com> <av8osemFMD6C2EdK@lore-qca>
In-Reply-To: <av8osemFMD6C2EdK@lore-qca>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 20 Nov 2026 15:23:21 +0800
X-Gm-Features: Aa3M54qvLIAoTLXhSwpuxxRmvv68nNUsPxUUak29GDrjI45vtYhuyOcNNPOYrRw
Message-ID: <CAHPEe=FFgzM3L9aiBNczg2AQ4JiG-p+eFKLemjrOMzekuBmHpg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: sdio: check the RX packet length in mt76s_rx_run_queue()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Thu, Nov 19, 2026 at 05:49:53PM +0100, Lorenzo Bianconi wrote:
> I do not think this patch is correct since we actually consume just len -
> MT_SKB_HEAD_LEN bytes at most, right? I guess we should add something similar
> to the patch below, what do you think?

Thanks for looking at this.

The fragment is len - MT_SKB_HEAD_LEN bytes, yes. But
mt76s_build_rx_skb() first copies up to MT_SKB_HEAD_LEN bytes from buf
into the skb head, so a frame still needs all len bytes between buf and
end.

> +     if (data_len > len && data_len - len > buf_len)
> +             return NULL;

The caller passes buf_len = round_up(data_len + 4, 4), so this check
never triggers. With it applied, my harness still reports the same
reads past the buffer.

Also, rx_check() runs before mt76s_build_rx_skb(). For a TXS frame,
mt7921_rx_check() and mt7615_rx_check() walk the records up to
rxd + len / 4, which a check in mt76s_build_rx_skb() cannot cover.

So I think we should keep the check before rx_check(), as in this
patch. Frames that fit are not affected, and the loop already ends at
a frame that does not fit.

Thanks,
Maoyi
