Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217146;
	b=xGKdOlPwG7hyh5L6/QvI81AFjxavuE0uc3VIrersbhHn5wJOI6EwwDeNQEHf0Z2405eV
	 7C+RhA4RtThfMVpfCG9kAVwUujzO1dIRVWITFRMXKUdmk6LBQ8T+SjseyruxdYSKtSWQ5
	 jHhRa+M6h0mHELIgksFeGKBI4N/igD5zR11qJO0njXcCc5UA+CpiB2H/0Dvp8fLfDd1SA
	 NWDzRiXRNFwXpGSOgo0kNz0+kH+skcqd3O2qF1XuBB8n+FaE38JBM3B5ZScgR/86iFFaE
	 7drd0tPOL5FAA0fVXU+GK4tFyjKwEOUmuyaDGB2N1dO2tfN9t2uqblrz4lxZaGsCxVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
	b=H0mqbNsTk/fvlXWygxHacMtHK9QjVMf5rRqlZv7cpHQGIkyhvlgmbniUJWzO1yleySVT
	 Um2pMmkpQBTDzVX4EZfHJiQ+ypzZ4LF4P5MEac8MFb/JjwreFXb9DxteSzpoX7gPm6umW
	 qunoQ8sR+ci1rqlnupE9w2ldwsE2r+ONYDDCqDyOAzuKJpj19xruc325ss2JGSIyfd0aA
	 9caltnf4xYWDx2ATgwOR/RIOP6IAiAhZrrTeeywpWSUYY0afvn3IUm5aIYQcPsc7Q5VZI
	 nHpiaGOTbrbpdI0swl59I7BnhB9MVsUgr2U0PoshoBPjqNjwwzRmJGUcBI0KZxuCjvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ez/Z55b0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C0606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez/Z55b0
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so439931fac.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217145; cv=none;
        d=google.com; s=arc-20260327;
        b=MFSJORLH4CbvUXoBroilpL46Xjn5ujkWM7eNbCXdi5ARXoVwsOGauGzym1MM7/ew0G
         FMrLy7+uwF4Sk3pofGTKm0pi5dsPpF0mwJHXGHkb/VjpOCgwL6vILQ/Eg0vYSsDm6dqx
         1prHze6x81AUfpDZtHSAAQW13wOrDU7mFVNImMC+HEsNkFpS3zTQJC/vkf/EKHeyk54h
         vjVRx4CYuQD+Kjfwd/gZlSNVCCC/w0iqS++vlx5Xy0Ma8Cdv5/phZ7+NAA5OFdMePHLB
         1vR4+0lqPxO9bN6tr6UNaslevTcgERL3UzJf+2WJRi5nlX2hXl2l2+/ixbNO4WGwoFs4
         vanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        fh=I8/bwP247P4lylG5WuERP6gEKr9R6Kxox0Fva+Qxg4I=;
        b=WhLAhWECMxyp/plYDL4oDdnGUYQLrFqMr9aw9Q1jrEsLBfD93uqPV19nq1qI6cy7jK
         /TpFUKy8gbrqNeG/tpG38A5IG/fYATNTIW6LgkKtuwgZTcckD7Pz9p9tYP2Cp4HqmnYh
         5iroXD7HgJ1PvE56c8eAa+gcCXzefEr1zgJdYET0ekSFIg/oGU+f1qttYWLrL+5/A4oR
         SDDhO1JxLBCd0i0TU1lGFfcP2jPsEHB6SFmsxo8LyFBH2MwKiH1MlYTnoULM2feD/4pV
         k3M1Pvhh7BW+kbzGbGfT5FPsVJDG9S72HAHbZ3OyexiltQW+MH5NnoscLAPrEPta1Ylo
         yW8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217145; x=1794821945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        b=Ez/Z55b0uswFCCrOov466Vti5izMG1v2RfIprz1liD212lvlAPN/9oxAdWhDg8/HNo
         hRWSJkAfaoWCJV9ylz1pMAI4Im1eai8Bz2J7SNqnmNttW4mOzZXW/RNk5dwQcwPU18q2
         75/965pmobYanJrT/00PyCd01etzF7VJNN5PdoYALtWwGKJ7yf4bGFy01E6aOM4G9vJX
         PWCB2pPCGQ5kmudjm2rrRMbIBGZ3X/Q+hh0qoTWNhHgH3sg2OKQ1J9mkXdeR0soyUnUT
         oK4d4EoG2w6Fti24nb/9i+6XfjKQSiMsQJZ2EKY2yg41a89atwJ6KA/NBWy/R6jeI/mN
         9zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217145; x=1794821945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        b=iLfnAZf+L837Hl0Vg1HGZNLtZVHLHm6A9XX8JVetaCoS1pWKs05PP4fcKtWko51Hqn
         C/HbEt9avoyZ4YQbx5C6GNlJd545pgL8Las6IzcPdFJ7bvX9JSPCfcb2j/0y95FN01wy
         NAXuaS/KFMHg6YGBoAhpLahGmxOl3g4aFsuCzNqahCFamVydQpvjgvY7KD+s2nil4D5E
         MaUu4a87kHUl2v2IEGF7I0T9/t46lv1A0g5lBqVU1iNxmSMYLc1m95RS+D6G3I0Gzxgv
         Qc5S5QckZdSIbRLyGefKqxfVADqGDUEG3PUn1Za4XqkU5EJc8asuI/F4/TDNWzrZ6aJ+
         1C0w==
X-Forwarded-Encrypted: i=1; AL+hErGfHTkhv2vXMzGC8W7n8MEKdszlMsxOUbItzNWJ9WSQBRfX4eapXHQvqhurXsL6JfXaTwE4jmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8offu4KRKRjI1r6FoAqP98jUSEIeNGqj21DYKIaH6MCB4X26/R
	l+dWaYr/oWIFk0AVT81TBM7jCPsohd5/K79yxFXGe4uwnnvGdSfY2d72kv8N4P1mhvFGZXlXvvu
	qagPxs7JB+UvRqb0zMvugU1vh5WASic0=
X-Gm-Gg: AYBFou2FzGxt7OnsGtGh7obnkZRQG8aH7IxbHGbVNJxMXpEPAgBNouUJ5DYk68kKCMW
	ozjznlGz5O/gLJ3aNNpkcUn2TpzJ/+fVbKiUKHwRv56bG2ZH9jjZ109et1hpThHUvn1vC3pwNAc
	D9t6iTpMouvZjRZFUFn61BpDEl77lyP1Pj8hsk53uzsM8ZnSg3ty7YzuNdI+0Bhz2AWcQmg1fTd
	JBo5Bes6FHHsIv4KjuV873G4ug7dOr15VbbOPjZtmeXj0j/L5upRdSJmHq47Xx8rWlJd5MdSU+J
	jLP4zZsKvkJEwYvVZd8kL6DOj+pkmZdJFUBG7D1ZLJ2p67CNqSJjzZ8TvPVj/yFgP6ihhncI66a
	nPnavoVTZRERk+6qh55vJwnytgBVGLI/2OrOjZQ7wzf//8YkJeqBJgJ+YM/mWuIMq4SQ1nAIQds
	FcdaGXostF+us94A==
X-Received: by 2002:a05:6871:b09:b0:499:c554:b635 with SMTP id
 586e51a60fabf-4adec9a0521mr1832827fac.28.1794217144641; Mon, 09 Nov 2026
 01:39:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
 <20261106114551.212675-2-amaan.cheval@gmail.com> <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
In-Reply-To: <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Mon, 9 Nov 2026 15:08:53 +0530
X-Gm-Features: AclHuK8ZY94zA-0byUQ__DrC9NeVtoJKfHv6SKapSVwO8ABChRUHJeGPjboSxYY
Message-ID: <CAG+wEg3VCFnPMkkXVLBNgSNra2YBSZAM-Q--AEQvA597z7X5MA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 8:43=E2=80=AFAM Joshua Washington <joshwash@google.c=
om> wrote:
>
> On Fri, Nov 6, 2026 at 3:46=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.c=
om> wrote:
> >
> > Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> > RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> > verify_xdp_configuration(), which until then refused every format but
> > GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
> > advertises no XDP features there and gve_xdp_xmit() rejects it, but the
> > core only checks that ndo_bpf exists, so a native XDP program, and an
> > AF_XDP socket on top of it, can still be attached on DQO-QPL.
> >
> > The DQO-QPL RX path was never written for that. Its page accounting
> > assumes the driver keeps a reference of its own across every handoff:
> > gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> > recycles it with gve_reuse_buffer(), so a redirect target that releases
> > the buffer synchronously, such as an AF_XDP socket in copy mode, can
> > drop the page's last reference when pagecnt_bias runs out. The page is
> > then freed while it is still DMA-mapped and registered in the QPL, and
> > the driver posts it back to the device.
> >
> > Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
> > matching the features the driver advertises. A zero-copy XSK pool bind
> > is already refused by the core for the same reason, and a copy-mode
> > bind never reaches the driver and is harmless without a program.
> >
> > Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ R=
DA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba633..4e9e692a0ed0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >         struct gve_priv *priv =3D netdev_priv(dev);
> >         u16 max_xdp_mtu;
> >
> > +       if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {
>
> Thanks for implementing this!
>
> Minor suggestion: Can we check based on dev->xdp_features
> (NETDEV_XDP_ACT_BASIC) instead?

Thank you, yes, I'll respin.

>
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "XDP is not supported in DQO QPL que=
ue format.");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (dev->features & NETIF_F_GRO_HW) {
> >                 NL_SET_ERR_MSG_MOD(extack,
> >                                    "XDP is not supported when HW-GRO is=
 on.");
> > --
> > 2.47.3
> >
