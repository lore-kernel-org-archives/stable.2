Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925910;
	b=jixFBBxtInzMFUuznulkzGQeEDJhPmNbb9o32f5bIyo6/QBT9W2lhoKneTIQhQ8m5iSF
	 o5rV3E0OTBKUJlUuDDbg9PxXq53V6G4E5s9o9Cwg6wESVRb8qrD4VndI1AYBUBvOiMDZx
	 KM1Ne+N3CYZK5IsHamYeM1L1ZVeiQAApKv3o7/fm3Z1t3Wx/y5zIsZ2QH6mJ1KGDyxcX0
	 n9omjipGJhZuAYGQaNeyX+b1Qenli4mQEDhTP5DTNcL95I7+zeLL2ThOOjc8PBN3wRbJ+
	 WWB9OInt+drseR9emURP733DI5kntmPjhzwXVG8HFW9dy95eg1MwcSW2NSud2fYp8Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
	b=ZtVNSiOMxT7iIATA+N8cntQvnR5rfMdAP1hQpyBUgKbHulypdl6J/t87edk+KAgNecLu
	 BqUbEEHqlVr7BQ/RUTWDZ+A30qsTRZ8fYDoPbXTWarlQbsXzW17w8q9kHywcqii6B1srX
	 09zbh9uI8cEzslADfT/2hhsK/JJ1MaWJMpbOeviL8JJBbRLSJaY/bpoMHxMwHR3yKahR+
	 lNSzlmniSmQ6AGdeQQBBMVevr969pYiWzF/sudzDJGbj4QQTNfYc4+OzbdP3KKhxqhNT3
	 Fwo0aAMdjvEps/mB+YzJP9Ol6nRYkWohNI4uF2AOR2rIH2QFBkPAe5/z6wNpZVVkoew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtKGVGn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B266606A332
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B266606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtKGVGn0
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50715c2757so624499166b.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925909; cv=none;
        d=google.com; s=arc-20260327;
        b=IpdIvIpaEQ5sJZq5F2LAL5pRH3nHyB1IFIWDkqXJOEldMX4wfZdVCKVceHmMqLvPtG
         sLJt1KK2DQRtTcptdFnYIYSnZJOhhZmVW0kje2tc4K/44ucx/67/63DTKpLSBp1dbxYh
         2pnqoDfJ57cMZd5HM1RS1CtIWKohpok3rsZFZvbnyNGDY6CLE/toPaNgk11HicS1hVVh
         4YJDDIb/gLtRDxRb3lBwecOsvMybUpdkwY7hnEfqQgBOm7cuyr+Js0MtGtcVDgwSH1zq
         7QqvdQZ8zL4ly0yish3Kpy4gBq1EcDw+ieJMi0R0koRxWF2soh5CRaprXLWLhHOa5uMF
         glmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
        fh=btu/Lsl0CpMjE8Tb98e502E8mpJYhnuKjMaqKZCLrZs=;
        b=ZzHE2riKZFqZ2xI0XnMlm9eeIBtkI/5wdVFFL8GztXtwEkaYz23uMyn6d0MpMU2n63
         Rb+xdACndrYDnZ9+ZaG+6LbA1VSvJVtGpry0XJoNyFOQfyvfzbQr+tSJOfvq5RilpuLX
         F9ha8OyA9XCSMCQ0dhzSmxgfRcNqIS7UuK2NFCsUAOrJEnUG5J2Jed8rtYLRHbGqALe7
         9gcr8tO1K019Kmhft3PdXqpGHd5XJZPRb/nLgmg5PfzqLqUlT40zNvu/zzVM8ad2LhSf
         NWpioRDyVDK3aHxcVuniCC2fggc1Prds8bkh4SFZFgmuO03/czJHde35L80lD3oCMDcx
         1QPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925909; x=1795530709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
        b=wtKGVGn0xuIg9f8ztH4vispZRzPrxenA19/h1TAjvBuP+4Fvd0WIB2CcOZkuGudL4d
         xJnId+eqSALHeE3/PkEg8uVqqyd/tDX+Rr6RjCJFiJQ0ZihepHK14fGjEyRnp1Bvnf/O
         UwdgI8ifrlGm6EIA4NcgTSX7GZg5H/tSmlInPjG8WAPqy5PdauGM2qUrjTnr2LnFLCzj
         a94as4JAHrR1uf+TAp3KypwkaLHmK/oeHEncKbjRxf6usPeFL3l9vdD63fSOIJTVzEt1
         xb9IPXG7EwjHpE/cfjzmkoTUVNFaEgi+eSC6PJer7I22OucBiZvkaMoO/FWaAbtcpSqT
         UHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925909; x=1795530709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
        b=HrSDsKvqlnWpzhR4539sRDml8O7IsVgJ778hs+QiujN/ZYlcUIq9d4BoWRcTX3ihBg
         qbU60Jg/KZGZvG4IcLO03oXDupfHuHHBTP7536bXYkT6JioUAJOHee9YR50L06KfZy4A
         XOEJ24yznSMOQyR61sowaVGsmkv8I3KygNm3qQdfNQap4OEWzbDQt20gqMveUNdak5cN
         B0Vf43VjzkVcqiRzsnvOlW0HmxswxokWwSFYTjSoxv5pbr052tzuCkNiFk8reusbFE21
         /LEjJXg+Kz5QD0P+p2Y9P0vTXIVFhGTwTftkYtpQpY+TujJ9ps5BZW2sZStPELrGTC43
         kJ5Q==
X-Forwarded-Encrypted: i=1; AL+hErG7FCNPenwVCV4Ptr0r5E+maUsjuN5BC72t74kOOf+XsbFfFphmt7n7JhL/8n0zzXvtzadf13I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cLotzlheskQar0sVAWwr75LitOGE7iBfGUGkdXJRBf4EJ/8A1
	2XtnXB8ruTcX9FrOeNpItpdi8vJpX9qEv/gDu6tz9SedOH692P44DSbO/SsxO++jl0fqSjNvklg
	RQg7A81xsxY+hu6NBVZsDnTOAQpYXbp4=
X-Gm-Gg: AYBFou2KLISK9id5j9J2R1xfny3SvEfxgg+yGPhWEU6wP5mV6NMj6EhBf+BwvbBZeb4
	HnZzHsu0Nx5tlb4sMlCcQLEKOczXAc0If5Mnj4aUTzZ7/y6jNPEiRqU7RFpM1+G/6APVVmDoicm
	Hwbw3UmbsUjTAldBCZRWMnOsg+Nas8WKJ9dxpOFEf7/SYtSwnankKTm1pLGQGGn4ve0aAYJUEEv
	VlSGk1g29gwdoXX3jkLm2GzvlUf4J7e2IXVF0XJeT7xfzkcoYLJNWDz8xA2MJmL6gkGgb1pK8XA
	4dnidCrYNBKePZDUJvaXaWxdSfh8BvY1EejSQJS6DBzmsvQXW630C6YGfHF4ye0w0KwVhw/fm9/
	tiw/pH5lIgilcvOvHFSYxHGOdnuqXRHgzQsOms5Tm1VtlyOQ8jRu/hVpIaNuu67yohISfZlpk0e
	MpYebiHYL5F2iH27Q=
X-Received: by 2002:a05:6402:1f49:b0:6b1:cd52:5798 with SMTP id
 4fb4d7f45d1cf-6b7c0d2476dmr11277202a12.42.1794925908479; Tue, 17 Nov 2026
 06:31:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-3-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-3-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Nov 2026 15:31:36 +0100
X-Gm-Features: AclHuK-1tfZhKwrVCdjfTj54iWvStsZEppahje6OeA9duQdnuQ1FrAmDZgLv9Zg
Message-ID: <CAOQ4uxiTpRO9ZOFpKRHjGakB03X=8HWEhpMxj_xcMp5yc4tMUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] inotify: copy full qstr length for event names
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:52=E2=80=AFPM Junyoung Jang <graypanda.inzag@gmai=
l.com> wrote:
>
> inotify_handle_inode_event() allocates the variable-length event via
> kmalloc(), reserving name->len + 1 bytes for event->name, and stores
> name->len in event->name_len. strscpy() stops at an embedded NUL in
> name->name, leaving the trailing name bytes uninitialized.
> copy_event_to_user() copies event->name_len bytes from that buffer to
> userspace, leaking uninitialized kernel slab memory. The terminator
> and alignment padding are zeroed separately in userspace.
>
> Use memcpy() to copy the full qstr length and write the terminator
> separately, as __d_alloc() and d_path() handle length-bearing names.
>
> Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"=
)
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Changes in v2:
> - Use memcpy() as suggested by Amir Goldstein and terminate at name->len.
> - Copy only the valid qstr bytes to avoid a one-byte read past name->name=
.
>
>  fs/notify/inotify/inotify_fsnotify.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 6e3af6452dcc..ecbfc9b4e99c 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -120,8 +120,10 @@ int inotify_handle_inode_event(struct fsnotify_mark =
*inode_mark, u32 mask,
>         event->wd =3D wd;
>         event->sync_cookie =3D cookie;
>         event->name_len =3D len;
> -       if (len)
> -               strscpy(event->name, name->name, event->name_len + 1);
> +       if (len) {
> +               memcpy(event->name, name->name, len);
> +               event->name[len] =3D '\0';
> +       }
>
>         ret =3D fsnotify_add_event(group, fsn_event, inotify_merge);
>         if (ret) {
