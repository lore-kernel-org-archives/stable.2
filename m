Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208538;
	b=tx8RTvtY32+98Pq9hp+2gTl3bnuoFe3w3OICOTufMiAf5Kin/1UpjRuxDVkiJprsKjyt
	 yrcuGPeY2pWjlGrcitXlWUSeiQSn1XdrIyjUGwsUJBeenHC1VDP/qaO8Q4hIxXpE8NMwN
	 gPZ4tubDNPgwKkGK03jHorPvjp04fr61gTIN9mNMkbHM+HDOtRBOdyJ+5sKzPw2UcdwjR
	 yrcn6VzbQXUbzYl3YCJ3zwuwa2JGWp2bGdUW7Rl7KVJXQR03YK1wm2McJdwFW+ClSnMvp
	 t2C3oeilXHVMckz9pOjrFx/c7F1a35VvHbSn0wa94ug4AMFFf4P2nLpyC+JJ/+sygTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IHDmqb3emIFmJ8fO9uRNFSu9XBh3Om7oI46gLrUcn6I=;
	b=pQiVurqKBRT1BC/b1ESeVaj8iVd6HQTqqXhm1pFvuqlvX5FVwOzJqWxmHJnZMeDgg1Ld
	 jW82tKfWk/eND02T5i1rikpq4K2Kdi0rkscuGuDISapODUYvoBFhEkRlYR99LNCJ5cdvS
	 kjyTbXppll+BFasZ0PMFQBN0waD5VY0GADb4N/TTYGbp/kX7O0VPlcKhfcWofhsFWrUEh
	 JTq78rRWsOaO38IdqiNsj9huj+A9ZQIABcX7+KsmyzUq/cWOQZGc3C2Vpmmv8iFhNdb43
	 IUKovMIdfCU83zW4ohESqbFKywIDwnD6Q8iJjSkwNm1N88DXk+P2tO1+fd5vwImDTLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w11j6Mdb;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6468606A332
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 07:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6468606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w11j6Mdb
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so354564c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208537; x=1794813337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IHDmqb3emIFmJ8fO9uRNFSu9XBh3Om7oI46gLrUcn6I=;
        b=w11j6MdbsB4L+lfEhx9/QuPWJwJnoR1/635ejpDfK+LKom66v1X4DvzF2uzylOTZ3/
         Q9Dj95WkZTzj1PFghbcdCfk34yVFx93MMJxz6Fh9PQU2AnN3QRpI90c1HeaM2Cv6sZdy
         xBne9KiUAxZ9zou72Cnq5p5hXQgOrGnWF+hOz+swqgKABD2dQlZjeqQwhEaAFPH2TQH+
         lOiMp873AaypR3uky3pBLXoqP5rSu24uKD+dfdobZrN5JZcu5R5G5cAKOY6v8MJcA7uf
         JrcxMfecrYw4AhM5KcvnGA72DtPG75dQ+8Yk2j/IYMe5Sjmbvxv0MbDYcQJ6+wEX7rON
         4prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208537; x=1794813337;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IHDmqb3emIFmJ8fO9uRNFSu9XBh3Om7oI46gLrUcn6I=;
        b=0SrY5Pf/74/CW/TiBG3HSgp3OQtYntMINh+AXBCz9KlSmsrfNxqKs5xVPKgbmINUHj
         j3adZP9tySrIbvCg/lj4ttjNkOYHNvIuJUTV9+D33opt/o3ajsoU+whQ/1453Sz2ZktL
         GtQieosbtccj2pH3cnhdmnc1yqWSXfReq+oFos2Cas2scIZ0K8lsNV1ZF3RNs1IuZ3qh
         Ij5OcnLhvgN+8H0CwHp879HtArff7MWQTHY/EEC0cciPrzPgrtsyKhJCQ199W22IV1MJ
         Ou/klRYjusExqOqVH0ToNHUYkTLQmlPUIg4BSA0EWhLve8oSXYARA0r3ASyvcux/Dtn1
         MLMw==
X-Forwarded-Encrypted: i=1; AL+hErFKUAlo+vsLSJkfNFmPI9RcFHtOM75zzgHPtOfRKlqmrKU2zMBydgNFdy8z6qTbFmv3rMEl3TY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SpGUDtyjv5EZ8ke6PKjLrbCKu0P5fWHvtHVJvns8sju3zuZ78
	Z1Rp1Syr27sSuBKtuardIm9YlphDqLN636FUXTESSI+ntgKzHr1mzlBK
X-Gm-Gg: AYBFou2+XkkSUJuNOwrK9g/8RjmxQOOtNkFN8SnYcvlLHhmd9YDPTwikc44ayk2PAYo
	W7AEFiRsV4JFABeLmwn8wFknG1zhdt0z3t+1PHWFx0LmExiecX0OlSwVDE1NHvSdti2E+eiZTVU
	zbKDj5JoXmwPD301uJhRiv01Y/vJ2BmqGP7L4TbiEYm0E6Lo3VdmpjdVvDhcWJw4PDpkyCPJJLk
	mFwdKBT2IvIS94R1v2KBAwBsVw3VOSB1kY/XUCRyjc9F6R2qRlCKgqgdaHJOezkWL4qcYL7b51b
	r/n9D3k3d86aGdA8Bl7NNpNpXMQU3/ABfHExZSBEJzxmkNpY9tYkRdw8BcCuuNtz/iUgdalj2+s
	7X2gsJW3/Ha/Xg4kBobwKFEWhaWa6NROfmOYwSTP8LojXb60VY7PcHCghnFwLsHiwadNxWcCx7V
	s2WD4bfgMLxdcAFK8AdZRfylkvKzHiAMeS6IHQjQLMZsnYi73DYlPM8vAawRb6BtPWVpl4qz5fZ
	nEdtOe6LVbshwZHib7J4HbiQ7S/YBEV8gxyluMBiSlbl7ms+iPzH4UhqKo5cSxTP+TGWRY46bdQ
	/714g1myBHpebtAERikMK3UcejYMWGONDqQfzhdsFa6zdUVLdvcaHVYNEC1yi2GCt5aA
X-Received: by 2002:a05:7022:3c03:b0:147:a685:9125 with SMTP id a92af1059eb24-1b39fe30253mr4642534c88.2.1794208536573;
        Sun, 08 Nov 2026 23:15:36 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm14607158c88.1.2026.11.08.23.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:15:35 -0800 (PST)
Date: Sun, 8 Nov 2026 23:15:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: Hans de Goede <hansg@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
	fangxy@xiaopeng.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - reject a bak_ref length that cannot hold
 the checksum
Message-ID: <avFzEGl-xQxGqN9p@google.com>
References: <20261106075129.3106093-1-liuc63@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106075129.3106093-1-liuc63@xiaopeng.com>

On Fri, Nov 06, 2026 at 03:51:29PM +0800, Liu Chao wrote:
> driver_num and sensor_num are taken from the touchscreen config.  A
> config with driver_num 1 and sensor_num 0 yields a bak_ref length of
> 0, for which devm_kzalloc() returns ZERO_SIZE_PTR.  That pointer
> passes the !ts->bak_ref check and the subsequent
> ts->bak_ref[ts->bak_ref_len - 1] = 1 writes before the allocation.
> 
> Reject a length that leaves no room for the trailing checksum before
> allocating, and skip saving a bak_ref that was never allocated.
> Without the second check a rejected length leaves bak_ref NULL while
> bak_ref_len still holds the bogus value, and goodix_save_bak_ref()
> then writes through the same index on suspend.
> 
> Fixes: 09182ed20c04 ("Input: goodix - add support for controllers without flash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
