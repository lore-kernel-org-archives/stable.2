Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478519;
	b=aoKSqNg9fy3L7tOz06P3vHlH4f7NOIKn0is1lIDaYcSWd9TyCOI1eks7S2rufu61oJjJ
	 TE2WqsPW1Kk0XnYlIb+KtiUEXPefrcVRAyCVIanLpmA9FDiPSl4XeXcMpaTmX7vTKSgnk
	 wJkyn6DSo28B4KE4k7+7IatIivUiSUm8JDB7fhhv8TKmZH5wL76U5sPRn6A2lZSDyvJPl
	 q6wFWh+XU+dUrdiOQWO65E8TAH+OKTe9VlbiXxoY9YPumEhCriwhaXE0us6CmBBGO6ESq
	 rHI6f6Mc9kDT8WFeXRDlUK6iWqV9H37biCPA6p94lvsRZ71tc2cvEfXS55DYEzrIkfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=/1Q/PUELyNwj2qbyBRmSt0cgWWpENEFwGaSV2JeSfBc=;
	b=Z+F4cbcGgJ8mKjw61ETOYFclsleQmr49Ddm56WEeNlMMpF6AnETAwyccdgk7ZRU/0ktl
	 i+D6VfOkhIy7ozbgiWZ34xlmqdbtRXUy3a/fnfDLOXIErOyAvIKGX/S3fqb+OYeJ0Dbsh
	 mwc1LJl9MgifyLDGCdcaDi0ijEHXaUBDtMMG6N5gjyhz6xp6glIXGlHw0dUb4+xeR+4cJ
	 /m9EF+R6N83gDG5TJwkIDOKzC9I/3U+K5UiwdhytDm3AzMdaUxwLsCnCcrm86TU/eCpcm
	 8DKSkrLufUNJyx4TAU6hvA+kyud/KZWcG7GNmPUtu9AMnj9E/zsClY3ZMHuf43ZD4oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o28cZZr9;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B693606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B693606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o28cZZr9
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so43006215e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478518; x=1795083318; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/1Q/PUELyNwj2qbyBRmSt0cgWWpENEFwGaSV2JeSfBc=;
        b=o28cZZr9g9jpgYFv2IkAdXN/FB30Ic2Om9QMaoI9ptc/Dkeq/fsb+ikjytptwp0jTM
         q7tA+X/K+O3Pk/FuYrVXthU4TrnP+3E5EnIejJqCn4boNKG0biOUA1GBrf8AzQRzIKH0
         xnKEjzYujKDlA1FV+NPcLYP2vrl1DKhmkwduP1Uc4aMXEHNihvTgDDQGppuRJ/4052qn
         GF6GrrWInW2v27loCh6kOUH4RlNMIHanQVUhdsRRlLvWW2afxHB5CbP39iByEX29auVe
         ex756m+6QLhIlcsHJjwFiCK1RJWKoo3OtKPZstJAJp43gXOtrqW5njw0txhEY1AupJGt
         V9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478518; x=1795083318;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1Q/PUELyNwj2qbyBRmSt0cgWWpENEFwGaSV2JeSfBc=;
        b=rWde7iACfyop9/tQ3Q+PtqCHWXIPEu4px+kaqgBjHGfyxBZhXOfUCptgBsUq2q5taz
         ksl9to6bWpDZhwdWbJHRNflfHcyV4TmnHiHSlbt9+07ztM2SequHka6sLWzhDHgCw06L
         5dNo7fPtlHnTyXOZCQDej9GZYtr2oQFVldLl0oeiUL2AwTsaFe6ndcxdxMD/asA8RwaG
         +VigbUEX450QAUB7ftY6P+OaY3Yrk0DCzxMOwriBcF8GJHNkggeQNyoGbb9MdnB/p3Lb
         I7obnA06vWZ/o8zZMuMdXqYPoknRt3WdCTksaTlFnGc0j2ppu6QEr0F9MiWXsXGuUGzQ
         TvhA==
X-Forwarded-Encrypted: i=1; AL+hErHXBxosmAm6O/7V9rs/045LQY2NHExO5gNoWZrxHXh8EUfSA+swozRXjDbPfHi+Mkinb+Gq2cg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lKGqTboWE4Y68Vm+LmGx3/mCnvXHacbgnWVbnYF5HXpdJYFzT
	3t0Y3v26FqvR2yz+scfcmu/tFTBA7bsUdVkH9H9MMeyI5iSxSXfnv9QY
X-Gm-Gg: AYBFou1JC15Ao5fZGFUR3d3lyrfzYlBc4oRLbYfcO+pMkQ3ajJNpCyudd5RW8L2mRMP
	1FgsOux+zFynS70bNFQ/g3b3/8web0OaM0thxXMmOr9cMRgYaDWHE7UV4xMiMJ1TI83hGMaVicu
	d0avE+ZiEoYLkvYAa8QyAuT6crBZM2rf0+v/OFd9qnSsF4DejGBFRP5A25aT2E5c1BwORAhcyCj
	DfJdwAkTGixPDxieMCubIr3dgYb4sxG9SEq5wb3rE/AFbMPcUVbJmgkLKctMyDJqm06uCIJ6hGl
	SIYNh1e4mR47gT0N1ie6o8eWlRpC3owhrJp0bRTslEWMv2JfzYKbvQfGLC/HVpRWyfSpXItEXdO
	x9eyi5QKthoDhbXXLQVpA44+pWnZ8TbDMMSUWg2dX4l0D6lMe6KXdde258G4QpprGYMkYBdEqIQ
	Upb9//CbCZ0eKMwesoX0yJ7dRZzxsAQYz+5C3DGHtud4IqTt3Hz6RTg1ZkRqIuWXz0GV9myLKyV
	HM5plE/UQnkWzcU50qnNUFqro6zXCg6oN3vi5+TRntThFiWosKczxRUHRkQYPFigq1Mnl0erKdr
	U5LniacT1NEtTd4bybRVAZr0GMD4y8g4lVnxCKINldDJmfNuGpo=
X-Received: by 2002:a05:600d:2:b0:4bb:52bd:a3c7 with SMTP id 5b1f17b1804b1-4bb52bda3e9mr9993475e9.6.1794478517767;
        Thu, 12 Nov 2026 02:15:17 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm66747305e9.10.2026.11.12.02.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:15:17 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec v2 4/7] xfrm: prevent AES-GCM nonce reuse after
 early GSO
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20261108142652.1330952-5-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:15:06 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A2301CE-C145-4CB2-81CA-4A2BACBA8430@gmail.com>
References: <20261108142652.1330952-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261108142652.1330952-5-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Sun, 8 Nov 2026 14:26:49 +0000, Jeremy Jean wrote:
> With software ESP offload, xfrm_output() attaches a secpath before
> calling xfrm_output_gso() for an encapsulated GSO packet, but
> skb_gso_segment() leaves the splitted skbs sharing the same secpath,
> including xo->seq.

I tested v1 of this patch and posted the results in the v1 thread:
=
https://lore.kernel.org/netdev/20260930144523.435271-6-Jeremy.Jean@oss.cyb=
er.gouv.fr/T/

In v2 only the commit message and the code comment changed, the code
is the same, so the results hold.

Tested-by: Usman Malik <usmanmalik@engineer.com>

