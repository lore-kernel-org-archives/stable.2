Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8B358372
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259040; cv=pass; b=I2FRWrxeujS+UofiKMT5Pw2HjCvdZxNHqYx7tklnpB3DMF0UcymYaCD/aifb7ZFZ3A4itCvwoKlnVQxKAkV19ukfnzjyiFXylzm3C71EBNwwtQmgBqRG9Zciq8qgGbR7ixnqZmnuVeb68FprBR7oJbAd3toP01FccKRnvDniDlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259040; c=relaxed/simple;
	bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxtpMKjQmUe0OI3Hc8ZVSjlGXCM7SUH8pU9fLZ/HSIgGhPJYW2Uz5ABjdDK1ra6tUgEMJLdwLAnea0GwSFtPhIIe6n+ysIUmLLU0JRSqTNGMd1JL1zwd0/pHOFBzj5NwJ7OGFnZxK2WhemvGYG0mFaJs9ai+Cwb31Cs4xWUL4/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuZ5d/fB; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuZ5d/fB"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso592929a12.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 20:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791259036; cv=none;
        d=google.com; s=arc-20260327;
        b=lJI34BZlwkCCHCZnN2TKDAWb0cGtrtPjhp9PdRRi4BdVNnt2AXHFKby6AwxSwEo1wP
         GzQ4X4d3Ulxl6i3GNJbVJUL7EqK4HDbbnjrQ73rYahocmnWbG6CTsA0KEb2zbnE5Ifgz
         2eLhpe+x/BJej1dcSOYei3qNfNRZs7ZQhOluqD4KU9nlUuo+iLKHSszdkLADDFTjMukj
         0lLWyVsr/WMxFR3VtI273Y4QAVH64Fdyv+kkLi78hktCsbBNACe0EGCGpt0TDXEfYPKR
         6+ddZR5rSnv0pIT37PGRjArFdaFY16aduyhlJv/BkuOE2rPllg51IhzGd/+m77Pm20rm
         uIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
        fh=VSQLaDfx3OHPn1rZS3tLTruR0fXOdfUjqJHbogYkleY=;
        b=GNx8LRnPQ5kI22kC5j8CIfW5nuGc+RIIfiUmRWBeia+jYQ/eT/a1pFshmyMr/B0EfD
         VqRj6KV0FzdnYvbI8iEiEp2BwsHjtmrDrGS8tbFPc+eu6AikQfchfNAdRxuu0rWCxY6a
         oVaDexo9/VXusMYQ2OH6DRhSEQv8nRn3BVc+71+nzV1fTTaVYr5PxEwCRH2FPUCTTZWl
         i+iUK5rHbepRiMNlB3u5BfY+qmj/IWHoVsLWFTiCFc1n/yrKmr+2WOEs4eeob/XFIx7i
         5+Duh3KE3zHPcjbTxBsvZhwmwpCWLL/EqToyvBY8thg86E28mxdIoV0oMMsKfbHNwbHv
         SeJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791259036; x=1791863836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
        b=fuZ5d/fBYdVJWcmI6k/DPPngY255c4n9mWL97UrU2omDaP1i6tXuy6e1feARF9Kgiz
         mri5EiedH0ERmeU7PZZsa/KQXORrGHU5TAncgNhlFC0Coa3qdytBVFiJVrdU+bQr3apQ
         /KEbHk+K17Re5XiibuPK8NfxmJWnPxxNCh11mXLjrqXZFvWx38kzshF9rgsE0+BKmjcY
         drqEU2KA5GC2EZXNJD9q+wTN37hBP42GSRL6CNCnPdiF1aviIWfeU7bPNWGIovu8f0E2
         6LvDtZudLBH2PyHY+xzjgozHN9zxZnCknXBB3194nfq+bsfxrHRYe2GR+iYUJgv7mUY6
         oULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791259036; x=1791863836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
        b=qFUyu4PglRnctiCl57BK7o4hKSaL8AJ3Mip9T/4m3NSHdhVxaaTOY+1kARWcoMybva
         kNW09jYE3M9Ig9+94PFAaReWjdiih/73qTvBX9pO/vA91Sj+ZnWb5HgrnaTfy0kAXJeS
         HaQzljhtI/ftdvC5KYd+z23INxaw6tOBccKYTyLxhXYZ+oRNo+tipz+gqyUySz8C3mOm
         bmiEZ7BA1EOPt08gH5boT6RBrQsDttEPYHv3V1+qIYcK0ygZiJ1lAfzA+i8kMom7cRfU
         4k2ykl9QXEUVRAPs22V8JCuOjDMjySGAXSw5zrGYV15dKNSrsrCpjOGJEcxmr6m3CYiU
         fDLA==
X-Forwarded-Encrypted: i=1; AKwUvBztDeJKXvJT8/3hBoH2ywsgQEJWyzpy7A3uistuht+ruU73Kl1JnMqBUnf7CvMBMYMtgEdK0iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUUuW9q4MqBqopmrXrrZ+SJtG//0yQP8UbjhIuv1/C1EMxn9cB
	I97w3Axvd8F9RYZJe+sjuzhRFZNIiESzoCWBn2KFBeEEE5pYM4sP2Wv9yOuDb3eVO6QiX3QRLvZ
	gWHlo7ADq/PHBqLTCFVmmQ5hqhI2IJxk=
X-Gm-Gg: AYBFou2ZGePGpF1UzHr4KmP3ntS1auak8BZHdA4L/OE1i2PtBYarhgf0/sl++z+Thpk
	MfnN/DxpamRMqL8iogX2ALTZVHypkP1k4rk3fycIoF/JnvXGMpccah36uyIULW8OL2I/VIa0igT
	YVx2gEVH2PYu+3o+9AeZ5qUhMNjyq+BpQRCOvOWE8SE/TW3Jwbh9iVyWMopC6uo4UJTnrvwPQLC
	fRVw31h/7PLa7Ole6Tx4+LcDL0ndeetyWw7yi+wEww/Ch2ScuWnWZ3XG+MThQNf9bLiq2BU5Adj
	Tv4X6i6VwE+FNDXGiol2w9zMsujJQPY3pGLu3eCH+1A0+FU1pEGcWvlJ
X-Received: by 2002:a05:6402:2488:b0:6af:a270:b2a7 with SMTP id
 4fb4d7f45d1cf-6afe280985dmr147282a12.0.1791259035733; Mon, 05 Oct 2026
 20:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
 <arORyXjxvZUoEAIw@chamomile> <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
 <ar4db-oTyeSGTpCy@chamomile> <ar6DFv-zudWg6i1z@chamomile>
In-Reply-To: <ar6DFv-zudWg6i1z@chamomile>
From: Subham Pal <subhampal789@gmail.com>
Date: Tue, 6 Oct 2026 09:27:04 +0530
X-Gm-Features: AclHuK-4B_jprqNVXhLiushIvBfXup2XgaXBALX2ddQEQ01QkjBFDMAPA_kUpzg
Message-ID: <CAHeizqFAFRLf2bGdw-pTLh-ovWFR729Z47obV7m17TrcMb6SVw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, kaber@trash.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:28=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
> > We will need a reproducer here without requiring such hardware.
>
> This requirement is too strict, apologies, let's remove it.

Thank you for understanding and waiving that requirement.

Per your earlier note regarding the target tree, I will rebase this series
onto nf-next and post [PATCH nf-next v2 0/2] shortly.

Regards,
Subham Pal
