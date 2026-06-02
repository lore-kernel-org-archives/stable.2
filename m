Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9C3624C9
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369361; cv=pass; b=p2o+HIx+os4UqJ5m2kqXlA4qGDPJoSc1MG5/rogUUxx2WES79H10J/t006r52T4DcQd5q2sxpb6WpkUnC7RoxH2CUAIYRjwta7ihE3WYLn7pxy2BI+2VeBPthexwP/qA+vemakd41Eob6lmh3bc5iBsAfd1mIJ23j8Gek8LRtt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369361; c=relaxed/simple;
	bh=RnIW3qmnHLBRpyMDOu1mpA+jBoMl6x3qPFLQbmUMVl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KohQDHqRk3zGp0Dt+IXxThjvX3euzK9SzhZ2uZsiCI5hfKljGLMNQ0ypBjVKs+vytR01mlqQPBNskE3qrKJkUbwCNqQHutYykHsktFGZuUccIXf5C2jrZL1Wn8c9C/p4+dMG0cPmTOjP2LjKxrTp38eJSg/zl6XmPadx8VZo5Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WG4k5pad; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WG4k5pad"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf30d530bdso34411735ad.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 20:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780369358; cv=none;
        d=google.com; s=arc-20240605;
        b=d42US6ac6Fo9d8y7gwztAi6p8tDEq76ONo3uVEvbYhbE4jTGhK48R8hQKK4mfVVRJj
         nah8xUy4sW86UATjyNoObopE1bjHE9hx0uF5Kc5A3l7RFvsKtqs9E65v5X/DXKPrCNSh
         m45T2sF37m69RDjsdaQKaSeH9eFUHMDFKBBQK90JmQY3Sy/4taVSCHh60NYgP1qBa1Io
         SKQ34WvtnjVPUdLKzZ2XK9/sufTN2x+UIQTfOm7VNClVPDKSF9lariw06ilPNOOvmJvL
         wRguVkt0P9whptATDqD/1uVevCEXjNsCOSrAvEc75TqVxBwIR7h5C1xPrqMUJ/EbrzeG
         0new==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        fh=qsNcQn25p22ejcQjNs7Bl43QMqCePQCFxryEK2pwNAc=;
        b=ZFe51FtpABWHofuQJ+8aUu/Ahkgd1NwykNKjLihiUqMkpUT2YG4fRbXHGct9Yc+/Lk
         YQi5Nn1uvb+eK7CcAMaMh1gb0gNXoZuHUQqD/5ktzvIOgDOCFamjKf4JUagXTdTgKq57
         P/eHjOt3uvVigNUL7ZNND+BmyAUT3c/GpNxRnE0abwEiy6InNG1UuhA97cKt55g2x7j9
         Q1mJB2x0hUgDIzV8aUEvAKqp/02eDs8wscnnIcjL4+b+JWrtuF/UgutYfNT14SwsNYk7
         SmrJVc2zqnenNWrz4thHpL19/8zF2JUWQxRG8owJVDcgtBBL/xD6PljrrEUuSdncPKZL
         TSBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780369358; x=1780974158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        b=WG4k5pad/j+z0EGjhJfou99wweYu862hQYxAv7rIAeGZ2w9AZUA3jEXNrngRPw7BHG
         LJhJsPx+i1DHiyE45BMqRDSTGNdua/UipOnwbzfGmOhj5Vf7Ny64/mCVWRWtMcUPrzf0
         vCy/1mP6bE0SPTk61TC2V4CeKaEBMn/WOAu39hhfaQIrZK5YyDI2f5mgI5mwypxL2rY3
         rErMT2KqhzBQwzXwI7dlL3qf2+CvFr0LqLo0lcBCVr3Yo8l2u2cgbv5EA/mHALNoy8iy
         9MVD5iE5EAitiGDXPo6vuR2u5WrpxUOiCY+8l/4/lgRkOSkDDO30aKXHxu8lqisz4+Ny
         LzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369358; x=1780974158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        b=dnJIYEVP80Wqw6K4RdM3dFzwWUfYUgjYE4wwnSZhV15H5dz7wO8j6+xNiOpLCQG1Qr
         jSTcUL7kXbsMgXcpVR3Pbm6WgumZyeUI9J65gpq1q43Z/+qFM+RYSGAQnAVUdjU97sZY
         ZCVsCEPXrWeRZiHPQ/S0BlL3obS7Xpx36rrK6tCP12QLOHS/zPhWytdGPDXGhyQWC6xt
         1WwccPdXI5Kgfp2wvR0DI20R3va199lcdOLs/D7hU6K6eDj/tMtCCVO8YH09HCgSw1zy
         sxF2vPDKYOjGJJ8ht4yAxZqAeQiVIyqXL8Oexu+iVlqaTHDJ5nqE7v8nLCLdXTm8crb6
         iemA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q3xW/ihKR9tpV8sl7j/zDaoYon/6c1MikoBa7BrAP3kxVkHsc72F/+dgDTT73Zwz8oS3uxxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSOsyQ7khVHmbMagJ0nYeY3JcfU/YGcCO8mUJqe0jUPcECFTd
	VuAzuP62huW7AjWwW2zzHeDRz30344MRMN/4IhihahiTL4haih/CykTWf9wIaORN1rstLXL4OCw
	bnbM/F9nbQ+SZxrViGnNHvc8oYjC/nYlwu0EuAOe2
X-Gm-Gg: Acq92OFG++r6XZPk5ZCDXUdEKPjBId4C/Nmf+1da/y81q/GrwAbxR0mmkg+spqA3QXg
	9BfZFGo8LmgZs2p66HZtn9U2LcCh6rKC5zSNEgvpWdiG23qp6HSpmuhS7GwujYdrja9k37bh5Gu
	gT5n0N0TbO1wjGi/jmTRRnJGQVbZN/cRlViDYUw4tDtlfITkZAy+LCVowXxC/LqymMFqAlzReu3
	dxqfyn/qjAXgSztRWZyV3Gapi6owJNU5OOK5bbgUymBjiGmvbYaKZK0sdIJHUAKD4zeEJbseKGA
	VSvpM4ZaYarCJu4yhw==
X-Received: by 2002:a17:902:e784:b0:2c0:3400:5c42 with SMTP id
 d9443c01a7336-2c034005d88mr148499485ad.26.1780369358143; Mon, 01 Jun 2026
 20:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524041442.2432071-1-tpluszz77@gmail.com> <20260524041442.2432071-4-tpluszz77@gmail.com>
In-Reply-To: <20260524041442.2432071-4-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:02:25 -0400
X-Gm-Features: AVHnY4IKOEuFCYPopcTHkisDnIftyduVHmrJM7aEiXWe4ijxf-NYQbyG_FOKLzs
Message-ID: <CAHC9VhRM81w3-38sx103CFuow=+Jg4SNvJGWekNcow4s1yOAdA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] netlabel: validate CALIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, fw@strlen.de, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 12:15=E2=80=AFAM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
> header via calipso_optptr() and hands the bare pointer to
> calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
> calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
> calipso + 10 for cat_len bytes via netlbl_bitmap_walk().
>
> ipv6_hop_calipso() validates these bytes only at parse time inside
> ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write reachable
> from an unprivileged user namespace can rewrite both bytes between
> parse and the SELinux peer-label consume path
> (selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
> netlbl_skbuff_getattr).  The self-consistency check
> (cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
> mutating both bytes consistently, allowing a ~232-byte
> slab-out-of-bounds read from calipso + 10 whose set bits become MLS
> categories driving the access decision.
>
> netlbl_skbuff_getattr() has the skb; gate the consume on the option
> fitting within skb_tail_pointer().  The IPv6 option layout is
> type(1) + length(1) + length bytes of data, so requiring
> ptr + 2 + ptr[1] <=3D skb_tail covers the option and its embedded
> bitmap.  When the bounds check fails the packet has been mutated
> after parse, so return -EINVAL rather than fall through to the
> unlabeled path.
>
> Runtime confirmation (SELinux compat path with selinux=3D1 enforcing=3D0
> and a CALIPSO DOI added via netlabelctl): Udp6InDatagrams increments
> to 1 with the mutated cat_len, showing
> selinux_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
> calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
> option's true bound; with this patch the consume path returns
> -EINVAL at the bounds check and the counter stays 0.
>
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Thanks for the fix.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
