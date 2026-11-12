Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476047;
	b=iilLnysAe8nlIqBMgWERz/vlv4UDZ/FPmipb5rRv7lt5rINTuThc8E7YgaS6WvdVbZkt
	 ff18VljT3hIPZHrzh1ZFrneav5OYBGoP7fiHLIZ9ckB/mAig2wA11if4ta/w27/8nV75b
	 gUwPSzPcwWrSI7H4xAf1C9JxoAhbicc2hUHTXe/GtnJpvSLiTIXUlNJobbghsHVvI8LSC
	 72ksF3dyHKyasDKmYqRNLHOogozEt6srKhM7HdXvTBrRCOO5ck8H/6INQ0FoSUrx8MSHd
	 l1c9Zv5yBe11pNj3aww8oaHZRmtu8uVZYknV/kB6vh9RLOf3h0gKnqwx9qYTMRdVxRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476047;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=CLnZ0cwukqhgHJ8n6lrGEhqYdC5mGdUToKZu9KanNQk=;
	b=QYEACmSXCRQCKhMGGerohQha78eAaLC8IpO6VZLgqR7amtrHaOFJf2gw7OvhzSrtqjbH
	 BAKcqGaslafjvtrvjlPNwmuCybDrwvXNXLN2li2zAtZONKnnDh1K6uOfU4s2dnYIxWyII
	 S+Y6v9FO/TQmyQoUu/b6ZBiaNLSBHDCNeZG23WxVFLLQv/Lxc2ZMtJyV3g8UUFN5SqvtY
	 Cx30vrNoGNQCAo5bE5/4zWN0VHmL+Q5+lS9goBfF7pjhvWtStvJBYXk8VKaQKoD2IaAmj
	 494U6BV8v7HsJybd7WLeGExPrrxbKbbNTkmKNHH5SQnEynBv4IPYmI7JEjKGyMnmVbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gu2udGNv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iyNfQpgo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B556606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B556606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gu2udGNv;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iyNfQpgo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794476046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLnZ0cwukqhgHJ8n6lrGEhqYdC5mGdUToKZu9KanNQk=;
	b=gu2udGNvt55DPcx7Q0PY7z/Tad93qfxzFK+15zgCF5G4kM/7fFtJ2BA+6OKWWgenJ2012n
	AySSwVrwS6tEF231atSFpSWqkwHhoP5TDYnxCuTSyu8bHMl0+GIYr2MnzenBxHg/X8D3At
	PwHjRDcbHl0QyFTUk+mtGdMmZqCDJts=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-vdqmB51iMwmPdQxYL6OsIA-1; Thu, 12 Nov 2026 04:34:02 -0500
X-MC-Unique: vdqmB51iMwmPdQxYL6OsIA-1
X-Mimecast-MFC-AGG-ID: vdqmB51iMwmPdQxYL6OsIA_1794476042
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so3861991e0c.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:34:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794476042; cv=none;
        d=google.com; s=arc-20260327;
        b=lU5it+hiWp7W6gDZtWWa098/X0gcyU3Tz6HpJdzcl5RCogeS/hpvsgTzZSAotUJkik
         sMV5FpRO7OKrLWAozSoWZWp36N4hCTyV1usG9psDf6K3cVS7AVt4xaSiptEE5yeT39ow
         Laj2AtLj+Tdq98i8uuLQj1NTvS4qQ0QRzG4zFTNHkhG0P+4e+AjGQ6DWxisf3Cu946jS
         XWjOg8f/oRZM4s0PhvLM4tA8ZByQSOYv7mlh8AdhfPX1Q24ToYmsvOK4ml5IqrVFZ2CF
         9Vw+EQ4skkDfltjES789VKD4GnuOzKuwYt0II/GqqhmVH99P5oBLRDVPixGILBAuWLzu
         9xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLnZ0cwukqhgHJ8n6lrGEhqYdC5mGdUToKZu9KanNQk=;
        fh=vyOf58iNXPfhQoXd4HNHHGDew2e9GdqFMPHt9jLOacY=;
        b=excCDE4QwxaJn6iJkJUoHcUt90xJu+m3Uo28YvdjjINdweEblqmqmUAQX+0B2uPlk6
         pAnf2BVy/DX0MWKgDYi9r70miGCrTksTcrROSQ1/4dGI7Vc0KUWRZ/LOEdMyhziGNWBD
         sQPSc5CK0Og9PpEwHuroYa4h4iuoWk5CozsvS42vWM1vK993eYFL+I0pgkPnWEkOtqmb
         SJKxM4zIblRRYsy5gZpA3GRWIdFoEpJi5xUWLZvrXYt1PiajWqQxAdog/HULiy0uFVxp
         vE+Wu4lD0yjM3QNHC4+YpwlCJr3fr4haSUgC8qEt4GqRy2spwpgG09rfTus4bS3XItnH
         GHzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794476042; x=1795080842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLnZ0cwukqhgHJ8n6lrGEhqYdC5mGdUToKZu9KanNQk=;
        b=iyNfQpgoCSZj/bit0splVvb+Nqg5hOXU80rT+In7V/4zEQEpL52xxeFVay0IcKqz/Q
         OtoVIwdmfUkiU7U+x0Wg47jE7jASmLUZJvuc+RhlGAMwLxQgiR7wrWl4FU3u1nTO0dh4
         SxMD1Au+Re1Eoh3N9f9Z2sqxdZeflAyXgrp1mXywJzWjAWELzO44cqp1nMo8rSx/GRtE
         sSPuxn8OQQRSl0HK/9D08lbE5eHHuo5lkT905J8YqOAoXejnilBv5xWtNztxHUok3ido
         4CUT//1wYsUeDQIpsTY7w1buWcLVFuvLhnT7J9aK9xagHZT/K5pPNIjQPsZdqciEh3Nt
         JxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476042; x=1795080842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLnZ0cwukqhgHJ8n6lrGEhqYdC5mGdUToKZu9KanNQk=;
        b=gJVddqpP73Ftv/V2byc/uJyeX+YPT5u0MZxJ0HZXsHgkxYCHnzQCjfgVXUK8PEStVW
         dz80G/znGVf20BDAtXPlOCVgLY6je5zO7nRWX/CK+N4t454C6MC7BntdCJARjnNANOyi
         OiRp/XVyyqhjVoXrTXnX4AR4bYMvIwZyyE5h96zf0e3mp9vXVXxHlhysyVW9HhSZL8bu
         TLEN1s6vRimqqXxCRp+9QM3NnJNpiiYzC471P7jgl6HfO9EOJQJyBUmHM34rW7Dtgae0
         dfP56IxUU/G+FSECSIOlkG7y13rq066Q7nYwjvZxp/2sg1C2bsM2F7DYtv3sdWBpNHfW
         5KqA==
X-Gm-Message-State: APuU4Z9WmquXxA1MbY17t6OVe3OGraGthLOEE1BLp/duxhVRh5UKNgiz
	7M1Y5wKNmwQ+utLRq4E9IHedgOA8wk1DEnSlEQMo+Q6D/BmHf0PcVuk1mjJt3OhbOJO79l5RXGj
	fLwCPCcC4NuTFtMHNn8f+aoG2H0PLSHkeXWnhP+eF67C4AW0/6o04AYx/xnBpQW6w3v6pkk00Z9
	cGMGnOUwFLx3rJVZtAhU4Zllq6lR1Tq+0V
X-Gm-Gg: AYBFou1mVgwd0VNkgbGG06lfwRagjfUMZU2VALGzt+FgH9MkiFM3vhuuTAjcG3GyKAh
	dHuHq84dnxkd45SQurDzjoSecLJfJWQ2Leik2lB7gzVBMCRFOTMbrK6r/nUnIvnYVpfYk4NKqDH
	TPD7mtAib8/cDIwJt1bX2qfQpbQch4G2PtWAw//hwW3BYjXwSalLVUdbsu
X-Received: by 2002:a05:6122:892:b0:5c9:a60b:e5a2 with SMTP id 71dfb90a1353d-5ee1c433607mr2615887e0c.13.1794476042186;
        Thu, 12 Nov 2026 01:34:02 -0800 (PST)
X-Received: by 2002:a05:6122:892:b0:5c9:a60b:e5a2 with SMTP id
 71dfb90a1353d-5ee1c433607mr2615878e0c.13.1794476041653; Thu, 12 Nov 2026
 01:34:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109201138-failed-6.6-1f1f8e8c5176@kernel.org> <20261112023938.1396308-1-sashal@kernel.org>
In-Reply-To: <20261112023938.1396308-1-sashal@kernel.org>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 12 Nov 2026 10:33:50 +0100
X-Gm-Features: AclHuK8j-y7z8n8VnK_CyReOY25ZU86Nt7rVGMyrSgCAlrnQIosaXrvLZjqyjFI
Message-ID: <CAFqZXNtKr5dkGTHu96et7hvWHvXKMTn921mMcfB6CMxcsyGxPw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y 1/2] cipso: make cipso_v4_skbuff_delattr() fully
 remove the CIPSO options
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 3:45=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Ondrej Mosnacek <omosnace@redhat.com>
>
> [ Upstream commit 89aa3619d141d6cfb6040a561aebb6d99d3e2285 ]
>
> As the comment in this function says, the code currently just clears the
> CIPSO part with IPOPT_NOP, rather than removing it completely and
> trimming the packet. The other cipso_v4_*_delattr() functions, however,
> do the proper removal and also calipso_skbuff_delattr() makes an effort
> to remove the CALIPSO options instead of replacing them with padding.
>
> Some routers treat IPv4 packets with anything (even NOPs) in the option
> header as a special case and take them through a slower processing path.
> Consequently, hardening guides such as STIG recommend to configure such
> routers to drop packets with non-empty IP option headers [1][2]. Thus,
> users might expect NetLabel to produce packets with minimal padding (or
> at least with no padding when no actual options are present).
>
> Implement the proper option removal to address this and to be closer to
> what the peer functions do.
>
> [1] https://www.stigviewer.com/stig/juniper_router_rtr/2019-09-27/finding=
/V-90937
> [2] https://www.stigviewer.com/stig/cisco_ios_xe_router_rtr/2021-03-26/fi=
nding/V-217001
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Stable-dep-of: 1f1f8e8c5176 ("cipso: fix optlen corruption in cipso_v4_de=
lopt()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/ipv4/cipso_ipv4.c | 79 +++++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 25 deletions(-)
>

Friendly NACK (for the other stable branches as well), for the
following reasons:
1. There is another commit fixing this one (6d25ffca055a ("cipso:
adjust cached option offsets when removing CIPSO")) that isn't
included in these series.
2. This is not your fault, but it seems that the Fixes: metadata in
1f1f8e8c5176 ("cipso: fix optlen corruption in cipso_v4_delopt()") is
incorrect - the bug it fixes was actually introduced by this commit
(89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove the
CIPSO options")). It can't affect the code before that commit, because
back then the length of the options didn't change.

So I think it's best to just keep 89aa3619d141 (and all the follow-up
fixes) out of stable branches unless someone requests it specifically.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

