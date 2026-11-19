Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098937;
	b=SmkbUXbPD+luoh886XvWjbw8hsQh6A387Qi+IPRZQYWMw+aGMmXuI5yhk+WtKnYvoN00
	 GJ6gxGdGYlcAydhCQxdTNI+f6HbNYbGfO4xwhurjbOnN4Mmek3M52GnffXfns2fYZOStB
	 r3QMrp2Fa/PTyUaQ7Lsf5bd4WwV7TNiM8wzVA5hs5O85MLwzM/L4RNCxtcO3FhnzhCI8C
	 h8/KwFqpcoIJhlOPsAVmzssPW7v2mKb2KkSw8afEq/Hfp1KLGbxxwzkW5GlnL4G8S8UsX
	 bgGWnv2FpRCRdrN75jqqYyL4i2QmZlSIIiQeJsKapkk6kcnBSL2P754aH2cRekVsg/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fwc9Vs0eCwtckZGOJ96a7MsJ3RS29UxqFWSheZDmdJQ=;
	b=MTyZykzGrt21iwdjMeb2FbP9M1V/GtcdK5UQyiLtC6K3Awz1ND2Z1zPqCKHD7S6Lsf7r
	 csO5IATL/43NPTsX9eh4UVOvQIZvybl39BOFzlw/DIJ9DTpmILwn3oJzqYfPXWffZXpfI
	 +X0PSTFpjsnAdkXQlk7PrSi125JNPC5LkJiXtVjS7qSSznD2Sg5A/caWrjgpRlzTcIAV0
	 sBVdqoCWmTthrlG+atJh12KahOBDnuT8SOwCFenujYzHrnbf4inzK+xqlUJl7thragmUw
	 6If9wRGOBptmWnd6vI162B3spsIL7/ABYVWBQAs9cRj3JhlvNUjGHjFpsm7RP0ok/qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=NhOZekIj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF2606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1FF2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=NhOZekIj
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4096505a12.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795098935; cv=none;
        d=google.com; s=arc-20260327;
        b=Dkjf2r94i3AXbsm4pBaWh9al2de48fgaViOIaX7IwbOGO1jCsuwV9AvUpZx9FNeAx2
         HUm+E4gVbAXbXxxxfxU0D6ZIqpcqGkaJzPw9zIPue0AuaOyLvpdc47l0Q7ieekhv2xfv
         ipkADNxyFbIGOpViMpwNXw3Qa0pE9oYrEn/YWWZxnPNAyHlT2TSD0VdS1TylEL/we6Xy
         0S/oY3MwBDBnvHCvb+KdBk0RwMrHCe70ixayZkfaJpcVwPwbuc+rKkxlO3trZTClUGOt
         r2IEl7+UT2rdch3PwgAnMPJ/J+nZxniqb3V/l4XlsEgHrO/DYu13OTXf+u8YHLPIR42r
         8u/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fwc9Vs0eCwtckZGOJ96a7MsJ3RS29UxqFWSheZDmdJQ=;
        fh=5hZWZSR/1CGgJcjH9Z4BPbZ2ngyev7KW+ZEWfCAoSA8=;
        b=Ugoc0RgEoyUV5e62wIuLYsMVR3vvBaMy/hHzQifDfDJgSSzTl6ZrRz4pRvf8zOQ7mt
         O5fUWbRZOz4716spasB70j8zGmKNEJhiNTOHlAdLgCyKwlomWWlQT3vsUip4ewf4/70M
         n8pY6V4Sz85GW7rUeM8AQvVNy9Yp8LFt13E4+YytPU3Hr+j2NoasMWnMomc5fTYGQoFh
         NHjVulaPVUMnTE7Z06aB79BJAn4BIW1KBIHmn/JW9nbu5Hn9auwWbq0W6eMRqnRdfD6i
         2Xc87JH2V4VwkihoTKifrXT15AV81r3UUrty+pxaH09zfBy5o6VMSIu6fAQaBnrDTPoD
         GDjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1795098935; x=1795703735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwc9Vs0eCwtckZGOJ96a7MsJ3RS29UxqFWSheZDmdJQ=;
        b=NhOZekIjKl+gZPOJkVw1+HzMbctt5GPFnFQMSIHry8p29Xw5DKPG2gE/PmTV7ECZrH
         /oXFDRFf/BW+XNp33vjHJo9ZshhlcZAq+fVT1pn5tWXzptpfVkqALva3cBnpL0JcQn8u
         n+CW1+z448/pzfdgYk6qjSbSLzZsGNUAnAs+wZbUZg8t7zVhKjjTFyBsB2oODMGLvFxq
         EQ9ir4URj/VNwkx8yAMbiddJPiXEIqgU94LSVZBqxSJZKMbz7kEIzZPnnF5E4mxQ6mGa
         TTqAXnW09x1CIO3BIKsguu2CTx2p1NJzioujg0nAc4Bqp4tk17RkD0iwxmmUUHd2OHSB
         /GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098935; x=1795703735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwc9Vs0eCwtckZGOJ96a7MsJ3RS29UxqFWSheZDmdJQ=;
        b=1n50UzP3PpBOhOzYtTsRUi8n+zfpnPT2oprVa1tpJfJFgnwVWeDuaiAVCwAXKDaBkN
         hJTm8o+lEcGd+3yPi1kWPs/J+vOGsP7egGj2K26oE5amBD9YGNbdwwBam+63h75gPlLk
         +RI0A3h4Wt5BoFUIhKRq3SnpUfj9J8jK3P0u4o+8axEhQC+Y/6bDEP6434w9C4DAowo8
         A31ooPkopnX3ONoa9nlFMy980kgHLz7EpFLNfQQcacLp8MgFh6tlNvO+O3KcOKhdAMYE
         UbgzeroUO3FW//D6PbCgtVlClk9YGtZmNNba8r+JAACI86MqNKWlIw+AvCcd/uJlOCwS
         nB9w==
X-Forwarded-Encrypted: i=1; AL+hErHq2NP/FUE/+pJXLhHAmirj9c47fJJvOIjnJ3F0D0pkABwP8uLH5pvz5gPhzwiuxIjw0/JLAdY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tKkedmYNm9rTsftgDstbQ7+Ir4n+FOhlhuW91Z19QWKnASXdV
	c5SscR7PqyM++Gz7C1bMfjmFbyy9bOGcSGeJFtoidOt7DYJ8B6GOYpSciI59vt94fXjzxjStJtm
	ge7Dv9KbhzdTrNHtNGNO74/7GIq/Fv2dqquO00h6gaw==
X-Gm-Gg: AYBFou0fn8gcxlH5x/Ekf/D+faxE9k1KPby9Y6SXAnaoQonNbZ9I4sV4VyHtxF+PWfm
	AMPRRaeXLkqnkec6uyNGmnXf4tXi3AKH2l+MikZAZePp9KdV1R2bPO9Q2rusPdz/pg5Qx1HUt+m
	ImWX1lBo0rfuiu3yyviR/e5QSuVcLCdQJ9g5vB9uhMV+QFHVi/T4P4iYIf+Jyl+lgQaFcRxeEnI
	J6h1/80sYC0dGehUTR2nIIGycehpqk8Isb9CLD820iFBBsO9tRDCuKlW7x/dzT1Pq/q50fU0pJR
	TQQYO2SScqy09SAhYqx4VVqMIDI5HwlkyXxLYfangFC+HhS7E7tvWTurzeDahp/c+1s0/3RmiKk
	VGAp+Cuvjj2n6Co3cyWMtOcDPEkREwqST8c3qD3aBv2R8FaTcAbl+mluuSzHqSN41E0aexCfqSF
	BlHYLG2TtqmNH57Jm5DGnYailAo/MI1eYLj8FSVYKwzUyvXGfttRe5ri6IPUJNgMHyWsYcCLJKE
	BdjvOvVD+657VjVo6DEhLEc
X-Received: by 2002:a05:6402:321f:b0:6ba:12e2:4701 with SMTP id
 4fb4d7f45d1cf-6ba12e24bb7mr1989016a12.14.1795098935183; Thu, 19 Nov 2026
 06:35:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ddd08640709b149408b616c3eec8fee847af757e.1793455791.git.liguangshuo@mail.sdu.edu.cn>
 <20261109111652.GD8635@unreal> <APEA3wD5LFuJxkDei2Ikqqq4.3.1794229006784.Hmail.202321181@mail.sdu.edu.cn>
 <20261112190948.GV8635@unreal> <AJcAXwCpLMe4Pb1NjRYKDqpi.3.1795092059235.Hmail.202321181@mail.sdu.edu.cn>
In-Reply-To: <AJcAXwCpLMe4Pb1NjRYKDqpi.3.1795092059235.Hmail.202321181@mail.sdu.edu.cn>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Thu, 19 Nov 2026 15:35:23 +0100
X-Gm-Features: AclHuK-dPTcWt0IIuZ2rE6NHM7-T7hU0j5p8pba_SiQNJGR2-xv8Hf6i-TIdF0w
Message-ID: <CAJpMwyg1iPJUzMYRz-3rWjnRr=9n=rQrii7x-FMmFMS7Wn5OZA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] RDMA/rtrs: Fix potential use-after-free on client
 sysfs setup failure
To: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
	Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 1:41=E2=80=AFPM =E6=9D=8E=E5=B9=BF=E7=A1=95 <liguan=
gshuo@mail.sdu.edu.cn> wrote:
>
>
> Hi Leon,
>
> Thanks for the review.
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9ALeon Romanovsky <leon@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=A5=E6=9C=9F=EF=BC=9A2026-11-13 03:09:48
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E6=9D=8E=E5=B9=BF=E7=A1=95" <liguan=
gshuo@mail.sdu.edu.cn>
> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9AJason Gunthorpe <jgg@ziepe.ca>,stable=
@vger.kernel.org,"Md. Haris Iqbal" <haris.iqbal@ionos.com>,Jack Wang <jinpu=
.wang@ionos.com>,linux-rdma@vger.kernel.org,linux-kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: Re: [PATCH] RDMA/rtrs: Fix potential use-a=
fter-free on client sysfs setup failure>On Mon, Nov 09, 2026 at 08:56:46PM =
+0800, =E6=9D=8E=E5=B9=BF=E7=A1=95 wrote:
> >> Hi Leon,
> >>
> >> Thanks for reviewing.
> >>
> >> From: Leon Romanovsky <leon@kernel.org>
> >> Date: 2026-11-09 19:16:52
> >> To:  Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> >> Cc:  Jason Gunthorpe <jgg@ziepe.ca>,stable@vger.kernel.org,"Md. Haris =
Iqbal" <haris.iqbal@ionos.com>,Jack Wang <jinpu.wang@ionos.com>,linux-rdma@=
vger.kernel.org,linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] RDMA/rtrs: Fix potential use-after-free on client=
 sysfs setup failure>On Sat, Oct 31, 2026 at 10:14:46PM +0800, Guangshuo Li=
 wrote:
> >> >> rtrs_clt_create_path_files() drops the path reference on failure, b=
ut
> >> >> its callers still close connections and free the path. This can acc=
ess
> >> >> freed memory and free the path twice.
> >> >
> >> >Sorry, but how?
> >> >
> >> Consider an allocation failure while setting the name of the path
> >> kobject in rtrs_clt_create_path_files(). kobject_init_and_add() has
> >> already initialized the reference count to one when setting the name
> >> fails with -ENOMEM. The stats kobject has not been created yet, and
> >> adding the path to clt->paths_list did not take a kobject reference.
> >>
> >> The error branch then calls kobject_put(&clt_path->kobj). This drops
> >> the only reference. With CONFIG_DEBUG_KOBJECT_RELEASE=3Dn,
> >> rtrs_clt_path_release() runs synchronously and calls free_path(), whic=
h
> >> does kfree(clt_path).
> >>
> >> Back in rtrs_clt_open(), the first statement on that error path is:
> >>
> >>         list_del_rcu(&clt_path->s.entry);
> >>
> >> That accesses the list node embedded in the path that was just freed.
> >> This is the use-after-free I meant.
> >
> >The error handling appears to be incorrect. rtrs_clt_create_path_files()
> >should undo only the changes it made internally and error handling of
> >call to rtrs_clt_create_path_files() should undo what was done in
> >rtrs_clt_open().
> >
> >Thanks
> >
> >>
> >> Thanks,
> >> Guangshuo
> >
>
> My understanding is that rtrs_clt_create_path_files() should undo its
> own sysfs setup on failure. The caller still needs the path to unlink
> it and close the connections, so it should hold its reference until
> both are done.
>
> Is that the split you meant? If so, I'll send a v2 using it in both
> rtrs_clt_open() and rtrs_clt_create_path_from_sysfs().

Thank you Guangshuo for the patch and Leon for the review.
The bug is real. We verified it internally, and somewhere between this
patch and the first one Guangshuo sent in May, we solved this
internally but missed sending it upstream. It was a miss from us,
apologies for that.

We will send the version we have soon, alongside with other fixes.

>
> Thanks,
> Guangshuo



--=20

Regards
-Haris
