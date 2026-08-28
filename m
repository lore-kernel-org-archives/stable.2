Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A803CD8CC
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903583; cv=pass; b=JzDSRVSB5hdQZexSQOjsf4auH+rCqxWm26Qta8aoJnj9ALTZQnmNY/7X4DIpyo9qPgCYuYI/KFTqhMqPpPpjT5gPnuUVA7n39niL5DCjCAP4mv8GJ6NurOtUWGnTtB+l5PwzMmlR4QSrv6hPiShapL/93tdUCkYnlQeGvrRsX4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903583; c=relaxed/simple;
	bh=TNafH1k/IbhOZ+c1ihZUoSaIWJuTHLQx1WBK/0hi05w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddWW9I3b4zGHUvYQcjJumlNwMB7rnxD+RdAl3BQgh1QDjIh14svT5VakD1R5UWslqnouDhKg0GX12DeJZYtKk3UOPGY5am9PGrRn+Gxpys2ZBxcMjYRuioBY80btqtZm8zwDbUAS8WWHFe3uJhc6liwV1xfPiip0+plqZTSgaw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=tWnSTDcu; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="tWnSTDcu"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a2e9851ed7so5302121fa.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 00:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787903580; cv=none;
        d=google.com; s=arc-20260327;
        b=G47/GgKXYuonjvlbzN2y+xDkbm3XAW0VSqsF4Q9uGPwYn85bw1OqEWEvzWca+xmg/h
         kiIv5mOFCyLJ4CiBYJok0QySjCqExbJrvIIm5kp4rUS6JWO10QDAopayWPMwsBY98qJH
         suyyh/Ie6iY8sMOjv+ZDmYNuEXm9AA0xeVYdDwaHosg6atUx2tZMX12ZfLokgNUNR/6J
         7Kw3G37VwQTbONIxogl9S32lJzVCuhgM4i1HViffILYQSzlloXbfK9zstzltgAIdb5T0
         HnL+bsVPYuTxrryThkAiqDVB06BHRELnBhPNfEgBOb5Y0q/6iXoEmWSP/l5fa4i5NIK6
         22Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmYleCXYZYXRkt4vuaUJjHHMfAWiaxlT7cmkptdUeOY=;
        fh=fu3y2HYBDPiWWQio89pnanRSufzhorESgEO7TZkNbH8=;
        b=BLzD6Rk6zg61WTHA7w6az+OJQ7bHdrd3lu6ql57v2b0Q3iQtaUxe9O/+RmA0G2NpV9
         h0bJiUDfFaUHP3UmDw3tWcF4zpaxICBWJf8l4KmrfWde1TCT//USpxTRmRG7ya5V6QZK
         5PwHqqbrMtB6DjhDzAjssgID6ZvCgtaLJ0qXj+95yA8qzoicmw3zRykZmeZXnGe5y0JH
         oOUM1qIOFwx2hEnh65SgoUNbw65YexlPb0XbJY5MjhjxJSEXiL3qToHOXeU+qorGpgGw
         zbXedlDV8u2phbpnNG3x3INPpC5MCPDehV6RsaFeLDpHb7pZQm2aynrfuNqMS5WECcGS
         NvSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787903580; x=1788508380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmYleCXYZYXRkt4vuaUJjHHMfAWiaxlT7cmkptdUeOY=;
        b=tWnSTDcu0GYyc/e7/d0A8y7abDGzZs9N+RbdkkoOaQLFmpdmEjOxitrgNF8A/WNezC
         oLxucOmUo5SleW6WaOlYhtmtXO0Sj8isLirx55mp9tR+XD6ruQL0HYimhLtvXRSzMBqf
         OXVbxir/48YTXMgen6r3nMuMOGvI3U8VZ96ZxAUn4ViaVBCUucJG4OZFHZmIVrltGDTP
         jaQRukr4qeNJsPNg8u1Hs5dQtQDKSZncHvmK+BvMNqp5jhjw7giMhIdf+sSLA5a3KFcR
         3xeiIwe0cZB0dRlXfuibspYPMC7StEP/T8vdmY9RbDLSqYFyCvr985FcVGzlXmMdgleq
         SsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903580; x=1788508380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmYleCXYZYXRkt4vuaUJjHHMfAWiaxlT7cmkptdUeOY=;
        b=YgfF+Y24IFUAnn9z6tioHN7Qj/uiCgHhdpze9RfeA7zGhh91Tcwj+Dj7SdtiPe4Zuf
         9I6rrmHu9A4U1gPZn4jThcmzdw/tdYkGqYJKZXrWmgNBWS2a5GDIGUhcj8QOwCqgBRly
         bterXDnqM9SzhC2d2urw/iqijGH0NedUqL785URnxB2n0R2F7H457E7avcrVruccZ7+y
         puCBLvsuhjvt6DJnaN+zvkXHvjqb00IW+kjRmWAyKrJcMttxavDIMnx/sJnYLesRPM+s
         Q+ehFH2QbKiuK0ZYBKukS/DtaIM4cc+JXdFajnSeqt9/nel3iEueQumMwVIlQ1tEk0IV
         7V/A==
X-Forwarded-Encrypted: i=1; AHgh+RqbFiGDS8VnpP3v1zFYws4EtIP2n0d1yMPz1EmbumHQ0Fec/ZHtorkgMx73GCcft8h5aQj8aok=@vger.kernel.org
X-Gm-Message-State: AFuF++n2C/mo6j7QDrHFUZMtp9fS3ZiFwPvxVCb3aZl4P+WXSI6uJo36
	7nMEj/okTLtsPSGWFC35TpzCNWHn96+YpBIxDB5BXEND9DcQQeI58upwu+LqJqbQhshDJ3hMGA+
	ZB76QPpJkSINt6TLh1GaW01A+CtnvwwANzWzs0A5ztcI=
X-Gm-Gg: AR+sD10PIQWZBkJmQSdn94asp8TVqYwpgMSB+ljlO/CCzlUAtjxc5VwRV3j/TyJqZg6
	Lc1G8uTfK+6YoNQvIUH0wZsfy6Ht+0vV2Ri8+Imtzq+SD26zrgNU6hr6KCKAi+r9rBIbga4iwi8
	jnlBsVT35lvq1F95AkMiGDeolhjVWSb9HB/+rjDQNBHh+PP66w37hMVHTkS7DqDU3sbPKJgNAWu
	iWkUJD1fmRU/Q9l/O1fQsewjUx4Fu4KvSd/OIKZh/5Xa1q+3nxQF9xNnQKVpPDYrRyxKhQ9mJqv
	hVy210nBftumjqp9T18hW1e+ThF98VNzdYfwb7g6jPsofAa8hvXZPDIt5zwfLliOFeK/TdZ5wto
	d41NZGADWCSGUXoFKueQe
X-Received: by 2002:a05:651c:3056:b0:3a3:a3:3560 with SMTP id
 38308e7fff4ca-3a301b1b926mr7137971fa.6.1787903579652; Fri, 28 Aug 2026
 00:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787854085.git.zihanx@nebusec.ai> <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
 <CANn89i+1xLiL=nZOwoSH+OwX1+8io_Cd2_5b4s-_NcN+kBh+8A@mail.gmail.com>
In-Reply-To: <CANn89i+1xLiL=nZOwoSH+OwX1+8io_Cd2_5b4s-_NcN+kBh+8A@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 28 Aug 2026 15:52:45 +0800
X-Gm-Features: AcwNN1Wlw2xmG9VSQqhlLFZOqVW920HInRT6-kbppYVXYZCPm1-sEjFLBIVBm2Q
Message-ID: <CAANe3eSydRy9qiDQhQMPO1nEni_Ekz4aUjnhYh-o2gwEn=9Y8w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipmr: restore a limit for unresolved cache entries
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Aug 28, 2026 at 8:52=E2=80=AFAM Zihan Xi <zihanx@nebusec.ai> wrot=
e:
> >
> > Unresolved multicast cache entries retain up to four received skbs whil=
e
> > waiting for userspace to install an MFC route.  The cache entry count w=
as
> > tracked but no longer bounded, so a stream of distinct source and group
> > pairs could retain packet memory until the system ran out of memory.
> >
> > Restore the unresolved-entry limit for both IPv4 and IPv6 multicast
> > routing.  Reject new cache entries once the limit is reached while keep=
ing
> > existing entries available for normal route resolution.
> >
> > Fixes: 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len li=
mit")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  include/linux/mroute_base.h | 3 +++
> >  net/ipv4/ipmr.c             | 6 ++++++
> >  net/ipv6/ip6mr.c            | 5 +++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> > index 4d55827e9705..af9247bb3f4d 100644
> > --- a/include/linux/mroute_base.h
> > +++ b/include/linux/mroute_base.h
> > @@ -224,6 +224,9 @@ struct mr_table_ops {
> >         void *cmparg_any;
> >  };
> >
> > +/* Bound unresolved MFC entries and their queued skbs. */
> > +#define MFC_UNRES_QUEUE_LEN_MAX        10
>
> Wasn't this very very very small limit a reported problem in the past?
>
> Nothing will prevent an OOM to happen, even if you set the limit to 1
>
> If panic_on_oom is set, it seems to me that this is working as intended.
>
> If we want to silence the OOM, just change ipmr_cache_alloc_unres()
> to add a __GFP_NOWARN?

Hi Eric,

You are right. I missed the rationale for 0079ad8e8dc3 and the
earlier report that the fixed limit caused problems on busy networks.

The reproducer was run with vm.panic_on_oom=3D2. It therefore only shows
the expected result of forcing a panic on generic memory exhaustion; it
does not justify reintroducing a per-table limit.

Please disregard this series. I will not post a v2.

Thanks,
Zihan
