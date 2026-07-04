Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9F33F5A8
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783164967; cv=pass; b=LKmfcI/OYad/m16ZK7bSn/Zr9CV16qaCYS7mbb6xMUDWJ1LTt8YEdt9gA+9zsYJv3bG8rCaboFbuVRiJNHkeqNPzQzLFUMUhYXTYiFLD8qAZA9aFfhRHM0eyrBaHMt27DevGoe+8Kdpoh0lzZQELQw20e8gUbWYp+bejwJhLeoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783164967; c=relaxed/simple;
	bh=rY591y6LN3cQ4h4L2/+rf8c/HRQBY1pWbtbQ++fadR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+6aZKUg1XYhgEjfurCTIhWSp36algGf8lGFDb7j+M/JiZ3O5bYnDcVNomCvGGwy4CEsIQ39GQ+3mqhOrEdqYaLbVuAgBd5ODEO69BLX7Ar5eSfid+vbbFvbV02m93RQsRW8P6drSu46pthen+ydypV4OVoChCKaN3lIg/7URH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGFIUxfl; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGFIUxfl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so360475a91.3
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 04:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783164966; cv=none;
        d=google.com; s=arc-20260327;
        b=Lq6O+pgHKAJn5eIFPzA3hBnxeTHzrVWl4JsyK6HiltwucaunA5FRGkjrivF3QAEypU
         jc0uKoUru4zNfZyeoGfx5MUBAeB9yos0c2bNHvZe5NJ1joKt1zehFQgj8sXRLdbs10Sd
         pVtqwxOqnBYBfKlpxXfAts6liOwh4gft8TXq/scu3fIBfHnKPJMVShuRa7UYSEXILv2M
         /Ogg/BEJ/C7h5zS9mA74VtzOs52IArqCTgjtKbikgx+i7/BTu1YZRnq1l9mJ7Xsx7FJt
         ahh9O85PGoifu3FpWfkuwqOxDrKzkscXJd5hBd/SjDspNiW3rdq98ZyLBIT31zOUvEfp
         yd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MoO9TmSNA1KXO5Z6hnx0FT1akZ4fwPRdrddAT7qIL+w=;
        fh=dljNS2ooK6fYvh9vxurHKUMg+Tx+AOHz+/1AkKhkEKc=;
        b=saY/MYBAxrijUAw54xoe7uHOYuoaL1wK1iA9KIaa9cypt4xSjUvuBI3myrBsBAbaIX
         TVA6YzexEren0LPsI+6o9uA7kIkUTwPJ2eyLhSVppnyZYwEQ8ye0SAG/FvPs6Jb6QxAo
         KGzyWsc3TIGzIU8KF7GQT/IhGPSO/tZkWqt/um4+QMSbIzDHBxy4FoDdpS4q76VMIoDa
         8EXWOr3qlJl/c3CHTo6cyAn6ONZipvIYlU72Mnteg8BWiMu27I6yiPxF6B/eBB9mKcs7
         9Ii6NveOiqF4z6llMPe8iAStPUO4k6FgWOE7dT+umDLDQgQIAbn/7l3aelebb52MlxFc
         MfyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783164966; x=1783769766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoO9TmSNA1KXO5Z6hnx0FT1akZ4fwPRdrddAT7qIL+w=;
        b=pGFIUxflqFAOEKnsbevDDyQN81L0b4pMZJJEFm7qjMwQAVQDMH2soXBSgvEFrHKrAE
         yJqhpdmJ4E6p74GXYB9XO0hallFVMewZnRa5vfw5XSJMM8XuPMDgaeiAUUuNn89zfdyx
         pbXwI/UvdSMNvPUNDoNe+gpWkdwwLum5DM7bQ9dR47Vo2nUWiuEgHbtCRIRugyq/QHWL
         F+/j701+ru944ACu1L5+6zjCfcRZPR/IOs84nn0KE6MnGBPMB4U4mSN5YDUFHa3j/877
         NQwKWbHg5FYMoQsRYD6LuWn+y9ndKAp9IquoZG5AxpcXGGQrZeb2Psh/GHHQoLSPf/yJ
         mnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783164966; x=1783769766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MoO9TmSNA1KXO5Z6hnx0FT1akZ4fwPRdrddAT7qIL+w=;
        b=PVor6j4pE5mp9Gjr0VKwH1qybsrOFY4cJhfS9F0sVApMDnNVht1TN/zB0C1c+dza5g
         hAsFAzC7r7feqZ42Zoy1v9sfX8Fk1zrvtu+jHJZm9LQlqhb3mZ//XpFkAybMF+/auGrF
         BLzgQ2Q4qkdtzNue5C7O9hLzRbAO6HZ0wGirqcPcCfbNkpPgKOZMu6HL70qJ6tiBLUm9
         WKw9TtNQHiLsbj/i1Qqi25OUdQ9nr28kqf27VuLaJUXYqmDGj/ctYZtXYjRfDXslPLO5
         GWz+LqXoK26V/WIWUHxUlFL6YKvw1GBujVIZWP/GjkvSmgwxE8ry0w5O7tebrS5aNrdd
         uO8Q==
X-Gm-Message-State: AOJu0Yxu31bQeBK+kDd+qhKvk92XzlkVaE5592tqYk86VmHkv/49FsFR
	okO6NtTkOWXHTW/6F9Q8P5dYtEz4eWeqf4Lpw7YqL7OzqJhDv32yYFUwR98rriF1jmEMg+/6YWS
	hTj1DPaUDcARqNXTHh4FMiobO+e5bRjU=
X-Gm-Gg: AfdE7cmH31olgyGmgbxdMrOkCkZR9E+s78jkVBGMJZysW4Ibogh4lPSCnoXXRyU/uk+
	GPlpviPSFPsAoQjAROi8qvCc6nya40qzHFs14+iHzLtV9C+Fq8UxNwJLC6/WQC5+wiYx5Yc3dxH
	3dxy/Y08r2D69tvBMjTRfaBT0dfZk5rZgMhKPZFo3+2couq18Gs98EyfLLnv6afWLKprvU3Y7Oh
	x1y63QL3Wa4uoP8JPUiDd5wA+6Yle+CXPpp8vFpyxahKLcYbRiR9C7AupW+o1AtX7PISQrpaQ==
X-Received: by 2002:a17:90b:4d88:b0:37f:d9dc:557 with SMTP id
 98e67ed59e1d1-3829d70cc3bmr2960626a91.16.1783164965524; Sat, 04 Jul 2026
 04:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <20260528194657.359703301@linuxfoundation.org>
 <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
 <2026062933-storeroom-amusement-0b66@gregkh> <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh> <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
 <2026070406-squander-geography-213a@gregkh> <CAFQ-Uc8CDnGUH3xhjaVBd+Dr=+b7Lfu1SUrGGh2gQ17WW+gqxQ@mail.gmail.com>
 <2026070421-overflow-voyage-73b8@gregkh>
In-Reply-To: <2026070421-overflow-voyage-73b8@gregkh>
From: maher azz <maherazz04@gmail.com>
Date: Sat, 4 Jul 2026 12:35:53 +0100
X-Gm-Features: AVVi8CecrYlLo7QVlDLZCm7Fw8LHog-pVbamjikeEXELRSjLIlFzv8YtHUdmvRM
Message-ID: <CAFQ-Uc9zmukVV3GcpneMJ5hrK4mB17FBSPyBh1_yjff5JC-r1g@mail.gmail.com>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99m using gmail directly. I=E2=80=99m requesting a CVE to refer to =
it directly
as i'm going to disclose the poc on my accounts so people know about
it and patch

On Sat, Jul 4, 2026 at 12:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 04, 2026 at 12:20:27PM +0100, maher azz wrote:
> > I sent it like half an hour ago the same way I'm sending you this
> > email, I sent it in plain text mode with the subject "CVE request for
> > a patched Linux kernel LPE vulnerability.",I really don't know what is
> > the issue..
>
> Please look in your email server logs for what is going wrong, as I
> don't see it here at all.
>
> > Anyway, can you please take a look, since a CVE should've been issued
> > a long time ago, Ubuntu 24.04 latest kernel with latest patch is still
> > vulnerable and many morea
>
> That's up to that vendor, not us, to fix it there.  Why not talk to
> them and what does a CVE have to do with that?
>
> thanks,
>
> greg k-h
