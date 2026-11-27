Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762971;
	b=lRZYT3dZhEWqr9AyibNbuNV8mQrrO7nJRj1ls1T/J8ybnDrDMeIUDago5up21GkYFhr0
	 PHQiwSM3sVuQbfVp/F0ytxbkGUUvZ5KI1VvHFUeZRdtCq0UJOYe6v8Coiw53tOgfyDFf6
	 YK/ju+r4kDGQFT0Kvt/hMtbyAbmbDn/jqM4cWrX+rQr0YSGJQtfe379351hR2gtMsInv1
	 7WIu6K3zwPUF3Us4RNJ5B51ylsNMXjCn9MdL5yrnSNKfFJ1smBBFVKRGBtYq8TiFlcrgN
	 qDLU62ek+/rCn3pOd74pUKhDc1pCRFwi+6f5fyyXf9aaG+c9cBR7h3rzYrgID392CYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=9lMQbv9vZ6o0yPgmmE160t97gqyu9qqgu6wavaxOeNk=;
	b=AMFRoYkg3/HycUqAuZTOa6zrbdq6zlS5Z+94OOMt4NalxGIj0wLs1t9sYheuoyprfQ+q
	 xv+61lA4keiiVVq2opkxLaEJZpQpbNtKAo1Rm+jm/Rqs35GxWOh+EjBKnjHt98nQ5UoIN
	 AWlNhxNTffE2v2IYSXhdHTn4kcYcT01Zu28k2JQA4+t4m/mVXwRVkMM8CWk3VhFKHoPNu
	 llSRso5fYwu8xMHP06d8x66gWCXNds7a8RHgMwxP5TWXHcHjlaZBl3p2g09Ny2YAA+Pjx
	 P9bQl5AiXc+gAFXcl8xjdWCygTxeDw/EvBT+9++7FefkslV9cLL+wdlLJE255osDNlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=iN5KlY9c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD9606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6BD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=iN5KlY9c
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67da564d9f2so10139673d50.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795762970; cv=none;
        d=google.com; s=arc-20260327;
        b=DwcIR6+5KtkB15+jgKsqbIUoyCOXXHN87NZuQlwyWBsVjVQHXpxjmhfTmAmD6x9x8I
         4We6Ngjl4rbJCPcuU/OOpK5s7VsgGCbXsWiPxwWsshKodfxzUQ2UI0X+O/AFpr7XfPmv
         7YCdFFgPvz+xAHOwCqC082+cG4Ois29M9oHoJTn2/oPg3C1DKUco6jr9FcUvDKTcKXMe
         4EHcgILsMjTFLWJkibi2883y0huGzwIpvJXPcoOItQaoAh3xL3zqGQ5IuADSRsqADD7q
         04qpKfIMDLnp4cSjOv+LMhaEkYt6qjZqziBLhecksMlFdew76DzyzL1gwQwR/KTFpXfO
         MTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=9lMQbv9vZ6o0yPgmmE160t97gqyu9qqgu6wavaxOeNk=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=hnh3PFBG0RYpILBajfI7tcx0FFLBoQpoUFTj/31wAckph1GfNjC3PXIEtIuTK2h0TT
         /1LbFXzC4rIs7881VnWr0+iYEG48M9Q+ZN0ERLj5p0Uoagj2Xd8jtLRh60sZ5kRTRmGJ
         svTChwnwBJfb9RPLWttqLElqQay/yl/CH6DcE4aiy0Sj5DM7LOE90t/FE3mCaXfYAXW5
         HC3NaWpzwNsQ6Df4l+dzyUBKgnX5uSCX/y+VP8OZtD1ExbGZ9/h+O4Q9qjZZDitLBuSh
         8TI1Yg6PNWwI2Ib4UzJca4E7mp1421X8C+FzNH6osRaWNL6lsZoJteL55GfNqeHWnDtu
         SDzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795762970; x=1796367770; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9lMQbv9vZ6o0yPgmmE160t97gqyu9qqgu6wavaxOeNk=;
        b=iN5KlY9cs5Zuo+ZlaG68SvObLbY/uV+5TFwZ+yJwvPgWgbJ+r4w5dGw3Vk/0ODQemv
         WkOQhjYhuqkTRsnuZvbm3Tenkd5orCkj8EgvcH8/R0O/Xm9naa/vR7rVTigeXo54xG5i
         nOeHi6sGSrQG1C5oHMvhcuC4d5E2K/nq1mufI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762970; x=1796367770;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9lMQbv9vZ6o0yPgmmE160t97gqyu9qqgu6wavaxOeNk=;
        b=tlPW0NIpCbUbTRPCSqoe3NIwynXCIgQnqbuDRcGMKjAL7gy1JE649jjBmpblSSvFLJ
         7JNwa4ACxZkhk4H4U1JQ+i8c2qi5R5JLVDjGP1rLEIArt8C7tems/2aGcfQjiIMcYCfC
         MDoy4/mkKZ+AAoEaGZ6/ivvNyMtEpmaIygVufOmmnlPK/qkMUvWEVh1fgoDwBtL0iAkj
         6qOHbKQm0W+YedQYRJW2+hAKKCF+gPkc2mK+eJieIsJBM9jh9VF7j6tIyntRSx4TsmDE
         LDUepk1wtsFeox79E4E0JwXWgYhC8UK7VaSMAyWeXRuQPExOLlQMMB1pIfIWH3zVvoQk
         /PaQ==
X-Gm-Message-State: APuU4Z9VcHrvNZXTxMgY2shvkddm7E4SEldz3y8j/G0/AE0BGkCaiRpH
	CAMiOYYbyisJ14NTegMLE745KkrI3D2YbRfBErCVFsLAB6DY9zkkv1VFYqdGMfM5+VAmBFghbQ+
	hOYQNPB1GUkpe/jKrygo76OdkxuFC2Hah2JPUi57h7PxasbITYgeXIxx6Yw==
X-Gm-Gg: AZFdTZceUMb82s9vgBIxMbsWxFCj4/ctKVzA345BnOvfkN2Qicb28AY6n7QFk27SYcq
	/C26tbUX8L1Cu4vrRxVQXoHEGUCM1fazPNFjvz50pUUucxH7Se6yvN53kDBqU+sJzQk6NFNR2PR
	3GVLJJtP+EWV3kAFoEcKlVWyPnEItx83A5Z6rx866pucSh024fK5FXqr7jFJIbW7r0m7nsqtnF7
	WRV6mDkm1SQQees6fTJ+bkrK4z6dNkzFfrQfIfsjp+/fm1DdtK10dorVBUn9J5CeLF8JAyyzVhH
	yfgAgAChxw+yWQhXVZCYBs4oNDmEonUBevSlYgRiRddM7pN3txjxw6VADb3sIhu0GNhQ0ChHN6m
	OlXgwHfsSGjROpiZOUxfLnGRoBd0bwNrFMYwSLyVh5dNDvAzYmogEAWoOxjISsAjq7936n3WeM5
	SnIwuzPg+Pl+8cATSr/+R4WpU1tYBgU/JOsgjY1kvtI9Bwn8OcZLfWJGLCaQiqMp9/WpAVeH4Ww
	ASC4KJTXd4/WphPx16+tJSn12EwF6pfOnwe
X-Received: by 2002:a05:690e:b8e:b0:67c:c65:89b5 with SMTP id
 956f58d0204a3-67df448402fmr9168200d50.86.1795762969804; Thu, 26 Nov 2026
 23:02:49 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 01:02:49 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2026112609-strep-tactless-e22d@gregkh>
References: <CAFaZ9eqzNSgQejze-paRJ720iMQpNA=0HCXB6YOgfK+c7YBfRw@mail.gmail.com>
 <2026112609-strep-tactless-e22d@gregkh>
From: Dickson Wu <dickson.wu@certik.com>
Date: Fri, 27 Nov 2026 01:02:49 -0600
X-Gm-Features: Aa3M54r9GAiFKEwiYEEXTlSXPvusTeV3qBtgESHyrATDjgFuJezznklT27FG0mU
Message-ID: <CAFaZ9eo3CRnD_56=Pni1BReT-S2PiJHMAOAOLd6M-9=w_BVj9g@mail.gmail.com>
Subject: Re: Request: security fixes for 6.1.y, 6.6.y and 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 02:25:22PM +0000, Greg KH wrote:
> Please provide tested and signed-off-by patches for these.

Will do, thanks. The 6.6.y ones are out now as tested backports with my
Signed-off-by:

6.6.y nfsd, c88c150a467f:
https://lore.kernel.org/stable/20261127-so5-nfsd-66-v1-1-2ae77e2e4983@certik.com/
6.6.y verisilicon, e8d97c270cb4:
https://lore.kernel.org/stable/20261127-so5-hantro-66-v1-1-aba19fe8802e@certik.com/
6.6.y rds, 167e54c703cc:
https://lore.kernel.org/stable/20261127-so5-rds-66-v1-1-1abb4e9ce92b@certik.com/

I rechecked each against v6.6.163 (SHA reference, patch-id, subject,
and later reverts in mainline), and none of them is in yet.

The rest I'm not sending for now:

- Bluetooth 7a6d793e9ca8 + de4e88ec58c4 for 6.1.y: dropped. 6.1.y
  doesn't have the devcoredump writer, and the remaining private-data
  write is on the RTL8852C path, which the 6.1 H5 UART matches can't
  reach. So the pair doesn't fix anything reachable there.
- NFSv4 0460253913e5 for 6.1.y: on hold. 6.6.y doesn't have it either,
  so it should go there first.
- IPv6 87cd6b717e40 for 6.1.y, 6.6.y and 6.12.y: on hold until it's
  out in a 6.18.y release.

Best,
Dickson

On Thu, 26 Nov 2026 15:25:22 +0100, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 25, 2026 at 12:14:19PM -0800, Dickson Wu wrote:
> > Hi Greg and Sasha,
> >
> > Could you please queue these upstream commits for the trees below? They're
> > security fixes, plus two prerequisites, that newer branches already have.
> > Each applies cleanly to the current branch tip.
> >
> > 6.1.y:
> > - 7a6d793e9ca8 ("Bluetooth: hci_h5: Add ability to allocate memory for
> > private data")
> > - de4e88ec58c4 ("Bluetooth: btrtl: fix out of bounds memory access")
> >   CVE-2024-26890. The first is the prerequisite: on 6.1 the H5 device is
> >   registered with no private area, and btrtl_initialize() writes struct
> >   btrealtek_data through that private pointer. 6.6.y took the same pair.
> > - 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly triggering state
> > recovery")
> >   6.1.y already has 7813adb38c88 ("nfs: use nfsi->rwsem to protect
> >   traversal of the file lock list"), and the upstream message of that fix
> >   says it relies on this commit draining the session slots before reclaim.
> > - 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
> >   CVE-2026-98570.
> >
> > 6.6.y:
> > - c88c150a467f ("nfsd: fix possible badness in FREE_STATEID")
> >   CVE-2024-50043.
> > - e8d97c270cb4 ("media: verisilicon: Fix kernel panic due to
> > __initconst misuse")
> >   CVE-2026-31573.
> > - 167e54c703cc ("rds: tcp: unregister sysctl before tearing down listen socket")
> >   CVE-2026-68290.
> > - 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
> >   CVE-2026-98570.
> >
> > 6.12.y:
> > - 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
> >   CVE-2026-98570.
> >
> > 87cd6b717e40 is already in queue-6.18. 5.15.y and 5.10.y also have the
> > rpl_iptunnel commit it fixes and it applies there, but I only tested 6.1,
> > 6.6 and 6.12.
> >
> > Testing, on v6.1.193, v6.6.163 and v6.12.119: cherry-picked onto the
> > branch tip, W=1 build of the touched objects before and after with no new
> > warnings, and x86_64 defconfig with the relevant options enabled, built and
> > booted under QEMU/KVM. I didn't run targeted runtime tests for these paths.
> >
> > The list and the test runs were prepared with AI coding tools (OpenAI Codex
> > agents, with review by Claude).
> >
> > Best,
> > Dickson
> >
>
> Please provide tested and signed-off-by patches for these.
>
> thanks,
>
> greg k-h
