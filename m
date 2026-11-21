Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225569;
	b=xVdc/jGVLkCHb7ouAvOFnAzn9rLewoaP/R5Y+h/x7onIGYtjFfV3Dn0ZXbsc0SG2uq4P
	 K9ljlAiMzgfc6aptpcukp2Dr1PUTLH4NAMyytBywqKhxgtJfn3sAn6EpdoJF/GblfcxXt
	 Ruv7RoLts1/dOgYvfTx4OKoB1GXJCHylfItjsN3JdOsxKR/06nr0HGr1uw5E/RvL0tozp
	 cwEsUSVHftMxYOdeVrNBd9UIXng/TohLd16LYbQ+Ia5oq82S1vUzQCQVvaJVqIWyNjb9U
	 aqGcMMR76IopIoWg8uEjjRzVdOoOck4CIEdtCJmUnr88b+8WoORbBJHAMwit18zC1qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225569;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=pXIcTl4aGxKY1y3Sv/7qakiKJPc0ii9R0dmFyBolSnA=;
	b=OxSNymPY9gqBOjlp5N1PgrH9BLndw96zO+cpBKfgWI2py7rM63jwK3mZ47+1YodhZsI8
	 nKEcPoUBjmdb1NqcxrwWr1qO+qVgWei/24asVPResgI4ndtD6cCFI6AHDcU4OhZG782Nx
	 ioBPAmXXp9loX5Lfc7fI38lFvI6ZReoYnG0TqI3bQiylQ8bSP4+vJYtnvcF6hED3uCurI
	 4xc8SYIViLbLd+Ogsg1087h30OVyAS3OKbtdFlWD3Yq3+5HVrdAA8PqbSyeg0oHIBywC/
	 DRm6IprQnt15BkxMoU8Yf/9S5zrpkzi4iFYDsRz/qTSKofzXCJsDbV8Mdr9LocIXVRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSincsPm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22747606A6AD
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSincsPm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499F61F000D1
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225568;
	bh=pXIcTl4aGxKY1y3Sv/7qakiKJPc0ii9R0dmFyBolSnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aSincsPms+qTVHlLXexSWGgDMf5MnjPq1famBGJqUuqRCvMCWeJq47JdrRPyTNzUE
	 ZoZ+kg+pRL3MGIJz4CI78PxnON7Yq2NfsXEv4w/6IVANtmLsrJ604v0wncaYudeFYo
	 6hhpo3Vd9Gfi+RcEORjoEzAnuIAUKjojh+lqNLV78Dh9qg7u/vGC6qC+XwJpuR+zGf
	 Nt0fdUV0vXTzgtx08MylCfiqSnfdki/71USUDLSm9sdWcsZlpxGpIaQ7CGfrQ6sltS
	 YysKxbLyuKqwOu1tIQ0bw4rTIfWlDIjJxBxRGeLwzEIGDtZZiVAWMgLAHAbB62ts96
	 xU0/VkuvcMaHA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4cdc606b47so275159466b.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:46:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErExzu/1IXN53nkpcBn3oRECQKmh8gJ61yA8hk3ImspN2L6VHGY+n3toL8kL6/rL08DgNPfMp9o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UjUBcMmLXCig/C030lHgKmt/XD0JEHT+SeGZbh1ZB1xITmDPu
	OJ/1hnl+y8X0xX6igXJjSXl4sjRuLFCoE0pEXaRLwZkqCTIMe5lHg8RL77D77vA/vktjJlQ4VEb
	AjS+157lV+aJWLWODs4+0I0Uxir1L+Cw=
X-Received: by 2002:a17:907:6ea9:b0:c46:645f:cee2 with SMTP id
 a640c23a62f3a-c513a3ab024mr492513266b.4.1795225566975; Fri, 20 Nov 2026
 17:46:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <VE1P190MB0877D026E2C3905F0324B46F85782@VE1P190MB0877.EURP190.PROD.OUTLOOK.COM>
 <ee94181c-784f-4f9b-8697-cca5abec6b07@163.com> <CAKYAXd8VV8hjeEqRLJ-HBDA3Dzw9bX45e6dWpie4soeZ8TBvDQ@mail.gmail.com>
 <2a3b2050-76c0-44d2-a5a4-236003247f74@163.com>
In-Reply-To: <2a3b2050-76c0-44d2-a5a4-236003247f74@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 21 Nov 2026 10:45:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9XO4X-A+rNsvuehhi-1gaBwvz0C+=omqFnVT_Zsm9-kg@mail.gmail.com>
X-Gm-Features: Aa3M54o5N-SYmHy7MpzLD1unR02bORgYmyLXpo_wA_f7P54pXZcJIo0YYREgCws
Message-ID: <CAKYAXd9XO4X-A+rNsvuehhi-1gaBwvz0C+=omqFnVT_Zsm9-kg@mail.gmail.com>
Subject: Re: [REGRESSION][NTFS] Linux 7.3.4 mounts 64K-cluster NTFS read-only
 after $MFTMirr record 24 mismatch
To: liubaolin <liubaolin12138@163.com>
Cc: "d3nchk@outlook.com" <d3nchk@outlook.com>, "ntfs@lists.linux.dev" <ntfs@lists.linux.dev>, 
	"hyc.lee@gmail.com" <hyc.lee@gmail.com>, "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Hi Namjae and Hyunchul,
>     Thanks for taking a look. I sent the fix last night:
>     [PATCH v1] ntfs: limit MFT mirror comparisons to system records
>
> https://lore.kernel.org/all/20261120155021.1618964-1-liubaolin12138@163.com/
>
>     I'd appreciate your review when you have a chance.
Checked it. Thanks!
