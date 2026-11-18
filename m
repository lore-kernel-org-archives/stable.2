Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009103;
	b=lC/jUsATik0z73n5QJcadeiPPtPMI55XdzmF5yXgDJNt6B0BcWjgGJszNnd7yWgdIdtR
	 QRNhrC+vv+BxNx8Wf2nmC+GAeF+85Gnd2krtq3Z84FZ4xGbIN3HH3a1FQyYMR3QHJr81W
	 1Lql0b1R69VtySBDV3JeFD58ep8A6VNvVIXtsoToosRqlRVypjwI5uEi697CZLrqRR2YO
	 QU7U1i5/PCOcFyV2W09EbSJQqtn46eIoeD52i7zB+d5eixuipbi48243C+DWOP2Pv1YPE
	 QBZoksDdZtTqjhMwbTWcu42JbHmjmtq42A9NpYrxl1a7Vz9ta8L08KTXAMLBIO6IJNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
	b=V1kTpMKPtA2xhwlOI68/AoctAkvgJBQ43DgPrOz9soxztn+N8PuT7W/qfd1lVFD9+6lf
	 EXSUdjJ0GGMxuLIBsZVoWv/Y7DTssBYlg+eoeaypVhj+6ry7rAnCZkRC3Z9bn2gfZZxvT
	 D23moJkeD36ngJDHfkgHY0y8y4Z8nuYYsMZiT/cbN4loJOdKHAqU7Ue6EegOFcHCXN8hf
	 ns2erLdbp6eymg8WYcOi6OpqbtUUGayx6thS5sf6CQe5TjkU/5IVd7+oca2GibOK3uKRQ
	 zE/AY0+vBo/8EfDH4qqUj5rGisbHJqQaYKrjXNk4cJy32gF+iRt3CqRXQItqtrJcn/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Pe34tTsI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92E606A333
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E92E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Pe34tTsI
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5495d549924so10500161cf.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795009101; cv=none;
        d=google.com; s=arc-20260327;
        b=goCV3XoovdJ3TZPlP/TwBBDoJO50zgrnGVTosLBvqaO0qdNUb/QghdI8JORxqsg5lz
         tkuEnMuAa7PM8SJKj6TZrs30lGIijj3z6/M7I3rAbD6Q0VOOPZEBa8dcb2E6maqZDIiy
         QTA4gCabWqhKSdcPHMN8354FMtaREse1EHCN8ouFe18LBzTaMEoEN3WyscFEfcMf8kUm
         F7lSliQhJNsr6NnW0DT/8qrlpKgUrpQ8V4o+N/3d1eglUvBzoGphYoR5yA1em2lJIpHA
         2kt3roZQY9fly4vsKB9egUxcdh2bCZ3AGC6BF2aVLlZbnOhB1z6y7BX+ElAD29FNdsp8
         OlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
        fh=TlFLx8wWzRLBe1pVfQ0zkpyaVFX1vG/zZ1rtE9qbxaA=;
        b=gfZZIhRKNzjDVpVjk4kktV/NNpUo3XJPio+Prs7UW+uMQD06x/vpqU4u9o+IgGVAWz
         zmSRCOGC1/VC3EAi15/YXEDsa49cjF5ug+CrDZqzTq23m2X78LVN7YFbVYw4dj5a2ibZ
         6idfMiZQXEdV+UGb7O98Tr88Yy0TmiFhm23nh11nDaDoVu/qzM7LK6MJ50XOllDQ6nQN
         jEfuL2Ury0GeNXMeK3oWh+2aIyZeQCEOX0LXZ0UBqnv73UL7P+WEtLBVYj33e00PaYBm
         IC+y9ek/cQZi4RqjDHPy/Kb8M1+Z+u2XkOsVQM9oAoOG4HcbMKCtGpMKHBhRGbzO5o31
         pQhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795009101; x=1795613901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
        b=Pe34tTsIgFeEeOlE8BDyVJuTMubDV7IkG0gfFDkXSbD/+AwMJkcrj2xltdA98E10Jt
         WN8LQd0JEg98Z/33ga26tURmtWsAi7rYQ9NM9Ch20U1RmHdV/OD+mO+UwpY5EnnjM+HE
         8NzXR1OZ4amekDKtfzXQMjpyw8un5pJRKJMmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009101; x=1795613901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
        b=khjTMghml5avzqzQj0UuajvRSiHcSv5+EeBslU/mWFpLrrVNjp3NHD0xG+WFtzzSIz
         c8QwaSXjRnAdJwTg+FYQjowAlbGXhwVg/U2LGyaJ/iatV0sTawSEBXtWbnFm++V1hxE5
         4hVdMm7wvhtttnSCf1DNp7pg04O+BfHXAzH2emavVD51oWMgfMQYc0PYhzJc5S2+d9wa
         f6BOGmyiWBvIZh98CmExZ+2oUppNnA9H6dsZ88s6BAUzHcG2/0x4CytmIELxCHyyS/NB
         qN3fKTpOjzZn7rtzEFaujSIuJNLNxoHD374STaSJJ+r4TK5K53+WceZMwWC+lZEFm/P3
         /4XA==
X-Forwarded-Encrypted: i=1; AL+hErG/a/IlWJOo/XzT3Si8CmVD/xIELTE3/ZrLWKrFQTv9TZc3BY762b5RcYWP8x0eX2AYKPRcFgM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DC4pXxAb3E6/79QcfLcLpXaj32QGGN1ztvat9N3FqXoKtL5nT
	MQEs3nBSSxzBVDbOftTULro/gx7/F0qQybj5vLw2QP5Uhp9XeqaCr/t7qbjqY4xGG3T4HQ+4o/J
	1/jVL0jwfPgd9xPuWuVpiXSoa4sUH0IWBHyjgzmLThQ==
X-Gm-Gg: AYBFou2ZlWKm2twyRGCYfp3OGs3rP1HvsNUyqOZilPffxUOieZKlbYO0kZepstzp+YQ
	vDTJ2cVMgNvHC16LYNTym3D0MPuoH2weE3OKbCStOeEtMsAKIXdf/AogpWRQiHL1Xr1dXMIUOFk
	KULzCLNLZ/whtTUy80WWa4RZPv5N6XZwwqE4Tl7L1g+j35NfFdlW8hmRW0BJJ4Mmu5XbVWV7rat
	VUcMh9p4d0kMrxsmko897NhIiI3UBNQt/J5vSISeC4IK4GgccT9NUKXRL+Edk2MFXuXlijd8dgO
	Wp60/q1kAB01kzOilVnOSODzdc5D5QRUb4e/KkWulKhn7zrG0UKYx8lHHd6aS09zXoarC2C/NzY
	eKixa2chf/ND1mGHFYABFzXtiawMJXmAU4PxKT+0/wY9AXJe2IWG5cwIgNbwxNe8dMFxbxKq4/W
	Y1llL5UKY1D9A=
X-Received: by 2002:a05:622a:558e:b0:55c:f47a:8c96 with SMTP id
 d75a77b69052e-55d5a340368mr39697851cf.3.1795009101249; Wed, 18 Nov 2026
 05:38:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-2-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-2-graypanda.inzag@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Nov 2026 14:38:09 +0100
X-Gm-Features: AclHuK95w6kthqK2rcV5FGmp6byHyDgOGBtGbNMoFRdYyxphnOM3Now-gzk5ZLo
Message-ID: <CAJfpegvfKhZYuMQ914GUPNvdPi-nZBYE9qfwHVg6m+8ABuhqCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fuse: skip dcache instantiation for readdirplus
 names with embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matt Bobrowski <matt@bobrowski.net>, Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 14:52, Junyoung Jang <graypanda.inzag@gmail.com> wrote:

> Some FUSE servers include a terminating NUL in namelen.  Follow
> nfs_prime_dcache() in commit 78d04af4995a1 ("NFS: nfs_prime_dcache must
> validate the filename") by skipping dcache instantiation without
> failing getdents().  Return -EIO from fuse_direntplus_link() so
> parse_dirplusfile() sends FUSE_FORGET for the unused lookup reference
> and continues readdir.

Applied, thanks.

Miklos
