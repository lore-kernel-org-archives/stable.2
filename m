Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866548;
	b=mNq8V+6IEoh1sNLfC7mk9OchzPdTgZ1kClIPNe0MqZ1/ElOClUi5BcZ4PJuHJ/iRgAPc
	 JkLth+yt2ulxM9I1ebn0GnJwlnf7wD6IlAdt4gqlkOcVAUOFSRfEA6Zo8HQ8fx7s9G9Iv
	 HDQn+Vm0an5FlX785YKksDayGYV60x5kRxbC2hViO+1jXt51fyoMF7l15hrOJNxdttDJs
	 T6OGCIgzCq4dixYd6q97qVW8ar7cpmJz8xK1cvdNTh9bkjl+2bEFokgAn+7pQzvUW4N3s
	 yf/oqkIn+Udss4fitfoKyWVcXGxjVewtb6vyruhMsjThYVTMjeYPKLbn83siBeLuLpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ETqs6DxejkpVOQvRklLap6bIJv44iisLss+lfdx7Ch4=;
	b=aqkJSAkCoUF1PbRtS+q3uhrtV7CkrI8w8KU/jPra3Y9vFQXsFTRVEr76/w8gfvFMZsC+
	 CUbA+8yfmN2bGcfKmtyCmu86QnBnZCT5CoOKc2wpko3VSjviGsvm0uYceBZdsus0+Gtoy
	 ZYyUdoAThaphyw4x5mBuAi1t+2/9aVgex91LjbH2PZfPa4DCz1VoWZUkuQkHVadE4fMQy
	 bKeTPQcip8gYpSnBpM18QsODa7K0qmilc1U9vQz0KhIDvCnP/OCg+xHvnFZbH7YF3DUbH
	 Z6mAAwlIGuv/mwPZGcc6vWO2jwe+skaYgl3hKB6vFmVD6J1WusE30eejBRKXDJ5wVtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="mB9pzhB/";
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87D606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C87D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mB9pzhB/
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b3402105b9so30209977b3.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794866546; x=1795471346; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETqs6DxejkpVOQvRklLap6bIJv44iisLss+lfdx7Ch4=;
        b=mB9pzhB/eqsMPqeEVznb5ZVjXcdNhHe3ywHvDDY0YdhZTRWDXjmwxN1mHrRkDCSjzQ
         8zP1CBxobWnkgNMr0KwbQjJ3L4JNUCBsmQLHAhm0InVpVQJ45rQ7uJ4uHwXNoozg2Ow9
         lQFf+e4mXXsgPeSB9Xe3LAx8bEP3PWPqB+hMKDGIiST1RfUz7dca9G2zCIGu21xD3l9p
         ewY1/8PxdXRfGy+nYZ/DwqMAxnLM9Soc4VlSJMoOA11zDZyRwXW6vLPtcUprXZJ+6DV/
         RPKX3zAAoz0f1KeLqQZ7Abgndu4hyLMX54LhmT3z4QB8RjxDDjWkHuR/hX36lVtJFTYC
         oj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866546; x=1795471346;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ETqs6DxejkpVOQvRklLap6bIJv44iisLss+lfdx7Ch4=;
        b=ClSFoRkLZ3t1I+Qky5+uvIFPKiQcz3sFesLMRnArMeAAUyEkX6M+Iaqq6mK2NalKDI
         Zc3Mb9V4m/Bmh7OUXX+JVTMvjMslVpDafLnxkSYMXS1Jg01+gnyGfgIwIzqZnI8hEQsd
         fOFIvkB9a2DWjGfLDI5nsaTWdPfDDtRKcZv6wGn5wWQnKD+nEmYG3vcBeI1eZHt0+lZ6
         VO6bDbOd6g7LtQezjQaw5ae78GRyd0WzkQVetdLY2LV3OmYb3gPS+cfJy47Z9EPATv5a
         zIJi1GLXEuMkbPqEAqIuMuBL/jCUgpN8T6C4AQbx+JnrAXRvDa4pH4UCgYHytnwFoTew
         OJlQ==
X-Forwarded-Encrypted: i=1; AL+hErFDR62EPFFIBseBqVGUN1fCckTPZnj3y8MCfqHWlQBowRpU1xw7Dvwmu1osXUu5oKfuZMr9C5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z913Sbji/bXP5e0rzc+bh8vIq+P2gqnd8WnRLObdPHW5e97zznY
	TuP7L7+h6nh1Ll1YLxRBL39pwhGrjQa+7J8b1LxZdd80lrB/45ySXvSVB5s6VO/JoPE=
X-Gm-Gg: AZFdTZf90g6eg3CjdDGzopKL/XsLeJRZludVuUM2mOfle41xt88P1HSHQTpcvKNtqLw
	EAKG3ZFHpvhJMsD154yOFhmlcov9iekLs/qQjOXwU0Q90q+6DhH363ioCpW94Jkjn3tPJd07/Hj
	yXco3b5ep7XyDVbvWu4pl6HpJWZE5H8ZUXnT5Xe28O3S5Vmq0XLv/qas3DdzPDbehOEMLATyVq0
	cPI7UQaRrJRKkIi5Z1Xz1z+LElh61rz1pEFM8gSXYxGvzBbaGyY/PtXL8ylkwnQJRju0UISxQPW
	K4Y3FHFk/stuBA+B4YxCjcsogBMHMt+4NKACRSQRk/N3C82yjG+B8piTsXqNpM8Ke0SZ/lRvS/A
	YoONVWqeNMkaHh7ITIIg2XT0mFs3E8RTmgvv4RqeN7IX6NoaNeuBLs809K7xEDPsMOrelsCaKNk
	AeNADlJQ+sq4Xf9ttUnEHAcZ6vJK8SV8XNDQwKPhNp7yR8w0eYoSGmWe9Ud9GyZe3QtiVl4wAGl
	tbSQX+pmFkCu7vpEUcd+9d+4AojUoooRh/YgC0odtTLVBPs4WgF2GSWrNsuNlwVNBNj43vSn63G
	PAJLjky3Q/HWvVTChmqwVShiI+cJ51ABsn4gIWU4TIBxbbT5ez2RyPmDRYlwHF/w6Ib7CsoWjUR
	BVliW5CwqS91J6wJY9wN4epaoPrCp189QvgZExMzmIJBzX2KTwc0+WlRg+8ugmnm1CUWgYDhRcX
	JoDwf8PjIioTTfJJvJgM4=
X-Received: by 2002:a05:690c:f8a:b0:8b4:ddd4:d554 with SMTP id 00721157ae682-8b4ddf35f29mr14513937b3.65.1794866546428;
        Mon, 16 Nov 2026 14:02:26 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:48ee:a3ac:5a4b:3831? ([2600:1700:6476:1430:48ee:a3ac:5a4b:3831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec2a5b9bsm9654327b3.34.2026.11.16.14.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:02:25 -0800 (PST)
Message-ID: <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfsplus: bound btree keys by the tree's max_key_len
 in hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 14:02:24 -0800
In-Reply-To: <20261114043522.48764-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-13 at 20:35 -0800, ozgun kultekin wrote:
> hfs_bnode_read_key() reads the key length of leaf records (and of all
> records of variable-key and attributes trees) from disk and only
> checks
> it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> always one of the two key buffers hfs_find_init() allocates, each
> tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> key
> writes up to 516 attacker-controlled bytes into kmalloc-32. The error
> path has the same problem: it clears 518 bytes of the 24-byte buffer.
>=20
> hfs_brec_insert() reaches this with an unvalidated key: when the tree
> root is 0 it reads the key of record 0 of the leaf it inserts into,
> and
> after a split it reads the first key of the new node. A read-write
> mount
> that extends the catalog (creating the private data directory), or an
> append to a file whose extents spill into the extents tree, is
> enough;
> no other file operation is needed.
>=20
> The 518-byte bound was added by commit bb5e07cb9277 ("hfs/hfsplus:
> fix
> slab-out-of-bounds in hfs_bnode_read_key"); it covers the catalog and
> attributes buffers but not the extents buffer. Bound the key length
> by
> the tree's own maximum, which btree.c already validates per tree, and
> only clear the bytes the buffer actually has.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> hfs_bnode_read_key")
> Reported-by: Guikun Yang <yangguikun19@qq.com>
> Closes:
> https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@=
qq.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> ---
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 3a1a1fa..f414020 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -84,8 +84,13 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 2;
> =C2=A0
> -	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfsplus_btree_key));
> +	/*
> +	 * The key buffers come from hfs_find_init() and hold
> +	 * tree->max_key_len + 2 bytes each, which is far less than
> +	 * sizeof(hfsplus_btree_key) for the extents tree.
> +	 */
> +	if (key_len > tree->max_key_len + 2 || key_len < 1) {
> +		memset(key, 0, tree->max_key_len + 2);
> =C2=A0		pr_err("hfsplus: Invalid key length: %u\n",
> key_len);
> =C2=A0		return;
> =C2=A0	}
> --
> 2.47.0

I don't quite follow to the fix. What issue are you trying to fix?
Could you please explain it more clearly?

Thanks,
Slava.
