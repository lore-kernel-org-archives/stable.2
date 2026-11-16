Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866601;
	b=xwDn8afjRVQOWlT3cCxzA6yyXpPO1N5DVAMIejlaoMgVmq/KQ9p/aRE7I9BBwThEP76I
	 +IuNpRj1Wlqz45fxxmCE5/o4xpe09PUDyM2VeymjgXaashoSXNC361az4c+SEIblL4n5H
	 8KycRcjhTZOjCHIeEml+FxvjJVVYOZkwHLYBbdahVPtz33WApWQ7JemYTppLXvCUCX8E2
	 QjitN1P/fGx1JvKXUZgCUc/ebw9wOzeoeK+3qQ03GMn4XreZlBSGhJaZlf6AZOZ3m212+
	 su7uVal0Cezi6/BVY3lB99D1+KRU5h5NWROUi8wQ03LNv3fwEcFVSeAbK3RQQji0cUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=NBD/5iw4xT3/0a74hPu534D88yzVhd7jhnkrzXOn+no=;
	b=E+wrql/uwq0cNmUZvLAj1+tqHpEJaznTtL3z1mh+ZCMfOHEDMzRzWUv8aYAfiLKn/rGU
	 C0tbO64vvJ4gdw1xYZHVoYU/2NDdy757OuctEbJXBgTikwXrj8w+5QWiwg8Ep7cHUP5M2
	 zKvgZ4mONUQi3GpGucxKtG1ppU2CZulP2Ym7JmJMGLqpcw2NDgBJ0fWC949BVjYupHc0R
	 RjRQin1WeJqCyArsAx4R85n3gqCX7Cr/IKya4A6Q/ceLlOD7vDZ97wd5qX2Qh63eMiq8m
	 /R3JEnRdEmtq2zq1w458FP8kOQxREGKlbLh1revSQhW+GtPUzQv5/gbXaQli4cix6BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="aROjm/Hh";
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1E606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aROjm/Hh
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b4bc5b8de5so2464097b3.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794866600; x=1795471400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBD/5iw4xT3/0a74hPu534D88yzVhd7jhnkrzXOn+no=;
        b=aROjm/HhVSdxa77z/apfieQCL3AURQPrWQdpvysWpeC6eN25wvW9UnYcZAsNhpJZ+V
         2F4jIvRZs9it19TTztgDsg3vC6TmaDKd2wWtZ4q/ZOInLrQ3e/Ig1tUYJOm9Yl4Cobbu
         wgmmIvUneTC0Lad6bFV1x3f0kuutudaRVpAKZAKHEO7s0llYYx+0uiJmQviZwNwCeXki
         VZTEVQJGHrEf0EX5fLWGVtKGQv2+VK8vihxXXDfzrYkK0kFodEuMA2KBBgryysc+wXoD
         vX3RE9xvTIuaSkxEpwxgp6XvMGZ3zoG4g10q4hcx8EBNaq1HyxOQ8VnyJdAr5tnu4cQT
         fMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866600; x=1795471400;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NBD/5iw4xT3/0a74hPu534D88yzVhd7jhnkrzXOn+no=;
        b=xd12RPu4bIeCkPF5x9sdLKd7FXs4a1MUKS+iK6DnEpxeIHk/pwVawb6FcSHerThyNq
         SWIFye4xprs1r9JRW9aLbMUh/Mde/TJsRmfMgvPkE6KN6X2nUvHkuY3Zy3zf2QUfItdo
         R2wjkl83ibUR6CN7v55CqhFcbCcmEvEHDhRARyIckSXV/6G50eFpYKoTNyEMiuDfBMNl
         nH1DjM0FLdV4X3AKj1Mmvuqwpav4/SiO/8MKg6V8Y8oomvtnO60FCx2b4cw08ikB0/HO
         yTeqVmB2MdxL22OVTeZ9o6FNILrFHJV0jkEhAn1hStqVir2uoFd2IcnKBbLV5+VxQ8SW
         mWyw==
X-Forwarded-Encrypted: i=1; AL+hErGn9PeU9oppA5IMsXBR/JQMNiZ9Kqqwni7EVnQTO/zQ5ioiYyaRMvcArkvSKa36v/WBFw38rgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z80OBgeiJnWpNx1CWHH+2b6pPpfRxRo42HXrZHd9TAB+nPXov1Z
	YT1GyOszZZA5jtYSOG5ZMmcLl4w8h/BGuNTmzsbXD42IagE0sKCUAeJKGHTt5Iea9T4=
X-Gm-Gg: AZFdTZcYXOp69LcL7W2WLOstje4sw0exzcpQNmJD7nmQT3+z2SDQFn6aqvS/3w/x7D0
	8zhhA+cBv+Uae+qR2Ytya4D56951ORn/W1hGhUPq+4P4AlFrJRsqcRUkd5A9GJQAf76BqX95+SG
	FW5TvF2zJ8EshbPYBZhdnTmtJcETeLB2Vj9EmJ7ooh4U3wFrchyDouiavXKAZCWPOqPzeG0DJn6
	YbA0lOxJ/Sx4x55Q5t5v5Y6AfIf2F2tlvsB6426mwLMZkc+JVw0mcr7Bjh7egvB+zplJF6dd7TM
	USgOzc0zNLHf9jsGE4gTY7FuVKyHMrJIZbKBsKeDo9WV80rgJA8VId5ZhdtHQnxaZDKqzExwUrY
	3qKLyTurIpw3wJG36ZNeMjiuLT+QdACg91C9bNO6tfqWudZ2GgxtSSmwjjElf0cXFzSEn1paho5
	Hd20pDR/xV1KDNqq9ihbcrQoEJpQw6wUQHR9/YNdcPvjKsVpWz9MQPkollJHVGMhY2X+m5PQ3Lf
	liFzCCKqtIQeju7eJPzp6mcCxM2MNMFmdOD2N6EhBkp+RRlmERGpFnK9tznYO/1WYerHM9ecJgq
	D+YEbtPNOMIteiDGdJGsaLJQUTBUPEVNa2Rd2UmTS3mfXAdzZz5NtYdhmBHtEvtLuGzgKz3vt8u
	WXbowPR949f7+U8j/nDRmlHuZtuTyXbsYksHZy8v+zo9wIvpNE68dGhwPq0krn6GXs2/Pysz42m
	fVUfhBibpdNOXaLEhmESw=
X-Received: by 2002:a05:690c:4f08:b0:8b0:dfd0:5679 with SMTP id 00721157ae682-8b4ee288ae7mr3857707b3.31.1794866600644;
        Mon, 16 Nov 2026 14:03:20 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:48ee:a3ac:5a4b:3831? ([2600:1700:6476:1430:48ee:a3ac:5a4b:3831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4eb7f0530sm9981017b3.1.2026.11.16.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:03:20 -0800 (PST)
Message-ID: <8b572986326b875b0bacbbc88e44e2ef448191d3.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] hfs: bound btree keys by the tree's max_key_len in
 hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 14:03:19 -0800
In-Reply-To: <20261114043522.48764-2-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
	 <20261114043522.48764-2-ozgunkultekin@gmail.com>
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
> The classic HFS variant of the same bug: hfs_bnode_read_key() accepts
> an on-disk key length up to sizeof(hfs_btree_key), while the key
> buffers
> from hfs_find_init() hold tree->max_key_len + 2 bytes (18 bytes in
> total
> for the extents tree). Bound the length by the tree's maximum and
> clear
> only the buffer's own size on error.
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
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index fcb5b9c..f678eed 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -83,8 +83,9 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 1;
> =C2=A0
> -	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfs_btree_key));
> +	/* hfs_find_init() sizes each key buffer as tree-
> >max_key_len + 2 */
> +	if (key_len > tree->max_key_len + 1 || key_len < 1) {
> +		memset(key, 0, tree->max_key_len + 2);
> =C2=A0		pr_err("hfs: Invalid key length: %u\n", key_len);
> =C2=A0		return;
> =C2=A0	}
> --
> 2.47.0

Please, explain the issue more clearly.

Thanks,
Slava.
