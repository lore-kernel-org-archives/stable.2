Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262A38944E
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377247; cv=pass; b=uZicucPoHaGdTrXQdnjI4fGsTtwN9En2xo3I/6dcJLiRLPZ0FBSICrEB5Qb1vp5MFSHAQcYWP6I9bc/63BBN8GTqnhzQUpVhJPvGU7t9CA5+Q7POGjLNsW8YFpFz+M3t1iKaosIXIilea8MFgPPbB4ICV7/LhcNkLgSZ9VGdgFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377247; c=relaxed/simple;
	bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrPXXG/tu4m3NWSij6GprKt8LfzdcxWyKZEOmYI/OC/eK0CeY0Wuvd89U8UBvMNZxOj2/Mk/JQ3ur56d/6+vedAu0M//B8Sox9r+MFKwU9FG/cqC7vkyC221M58WGHxeKC7OpP2U1GxvlAf22tOqQxQSW3rQxC8Df7hL+h9JGBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAtnHNhz; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAtnHNhz"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66826484b67so3498011d50.1
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 05:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377245; cv=none;
        d=google.com; s=arc-20260327;
        b=HcPuw4OAgwNNnVxYrTkRpt/VRbt6PXNB5kIcX1ZrRbskfZvLvtNCIW1w8AmC+bbTq2
         t3LW4tlSLdxp89yhfpkLH4+jU+df5Y8/5kfBKfI1hj7+EAatHFOafpHoVOlWiJDYFCQw
         8Aj4fhACY2lOj2tzkr9YMGHyoSxwShUcOC+RuYtqAM3+KmKw6plWKcc+kkfAgwHb4cSl
         EjuFQGLKLUb4GqaNVKC8IORz2MDClaNJZP6dBdXuXVsHKtkf5V4PBl8YK4DeqUPUSkrb
         rKEaALWiwqrksmuj/zPwk4mZGdNMVY0CTwj3B4FAq8RV4yDVkH2LsF+vN3wqpPu+mlEc
         Hz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
        fh=cYbxue90MuJ2G178XDNvUldFw/0HGnyQ/a5zmoFeeI8=;
        b=Vp+M8Tcr8X156SdynAC9BxmF+SYZWeO91lJX1JSYQYlqFhYDmwNMz/pa98+D2DwvaW
         8e1GOKPnsQ7YrZW50IZLLpbGEeQRQjqNkBjvAeD0WTDQJ0WaJ+a/HhAAuy8LFcgN9Oj4
         X4KSLzzmt+NKiJSZerUwa1QTNSVxdrea0cdjrubZKZ8u/2hZUzgwD5AONQMFCWsF4pV4
         KO+ycLts9U76SFajYNJZMBSDAkKALApUzsrBDI13sFeEDydMAepUf/6TYpyGpR3IaLXl
         TEk/GlMT/o6M3V9bePwGhcMsnShLPb3QO0P7wpw5sJoVdUvH1V6VgelEvZ22fs7U83iV
         cdtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377245; x=1784982045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
        b=MAtnHNhzccMGUs4uTjV2XwV6Fkv3fAdVqmQ+HmQ0dECLMuMLnEFFV4Uvq9i+q6gJTC
         Hu9ic5enCL9dRLYbCtEmTJ+tCHQF3L6HU52di/MC3gjQjhVFUo5kNxvh+wRgrgyH7mQg
         sN6UGjK/3/IlCCLnU14g8mLMzuwVb5aiow4lcPA6S+fiJfe5nD47X8AAIFJDPFv+3RhI
         Na8BzJuncEXX3aUsEivRS+Tngo02o6mV4HR8c0UwOsv/UvGJ1BYkdI8R6AxVtJWxWxJC
         nksNYqqHLf41BmvN9y5LHUmLQod60o+fBuYyPBH6iFa3RNxLPkR/z9qcdco+5UqT6YPg
         eYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377245; x=1784982045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/ZIRJmEU2s5wwtOYFS1NtVVw0zy1c0TjDsa0ZWWs2A=;
        b=NwYVqOmHKh05+bgQq20cfV8ixmdrptMyTij9NJak1Kf9UNk8H3XyuccYC0zoiqHksc
         BocaLd73Zyu3zUMlDEN+TeLbZbckQgHTrYPlzH5jeTf8TZk5M1ynraEtZSBFsfqXENT0
         CmLoo5ItYjrAkokwAovhESeolmWNEJ33Ww1nXqWQJSR32ysRTl6B5GEQRFiMGxzePGnl
         9GB8kXAjT/HMi8uZaWgIIAqoVIM61IfMNuG0OrsOEtEnqmSfQe5H1VEsvr9K99ZVd4rd
         6Df+T71a9knIUQ66Co3CcUXHxxNtAO4kxylHLm2DuuePa5Y3RKFV8jTTXTtb7zmKJGGn
         gSsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrS4YNskr64WA2PWq76bTRTylpFZXrsCLWSW2teH0NXiBeH4VHoIFP2zdhArgTyXMXqNlXNdmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXW1x2OdubcCME1AWrv2MURjNMaU4vGwxX0QbKz63TVimIUhl
	xKzSSmr0yHCwcvka3zWAmitTCTydQcEQE3VMCAFu+oWPLu7C2trTs37cD+C6xHyiUaI73H06qFy
	zLXe0qUVcIiMvccQ2XV4zlaXlJLFc61Q=
X-Gm-Gg: AfdE7clw1EC1dNHywRWEvIyyNvgLO4W9rqipFStQQOuHMHPvzU793IFK1ZhXJmOR8UV
	UssO7xcHo1d8l6JlEPbvC7FJqidRycnFkQrSMhEnfcxrf6jdydFBxTGvZvCaBPz0K+LysQOpOas
	5Ezai7c5/neaE1QPgQoVxEwBgPzB9VIOR1sRKFNZ66QfaHLGMj3cM8cCeUNb7Op9qAnIWqFMtUf
	416Y2CGS9uFrCXWCyqswdVm/JCCxqpHIYwSYBX6cyGgSC0a2E194EPlYDysIeauyoy1IYKf
X-Received: by 2002:a53:d24a:0:b0:668:ba3:fbe7 with SMTP id
 956f58d0204a3-6683bd99f2cmr1268824d50.93.1784377244920; Sat, 18 Jul 2026
 05:20:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:42 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:42 -0500
In-Reply-To: <87jyr8jgr8.fsf@bootlin.com>
References: <20260627235805.17310-1-alhouseenyousef@gmail.com>
 <877bncnx25.fsf@bootlin.com> <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
 <87jyr8jgr8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 07:20:42 -0500
X-Gm-Features: AUfX_mz62dEF0Vq5bXVUAbEJ8S4AYECuR0xq5pd1LEcB8_UKBr09Lg_v4EYwfJ0
Message-ID: <CAMuQ4bWObh9FVFifH91UMcdugn6YD79T1wAqeJ2owBnzsMdnCA@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed. I'll use rcu_access_pointer() in v2; it expresses the final
pointer fetch more directly once unregister has quiesced the updaters.

Thanks,
Yousef

On Mon, 06 Jul 2026 17:10:35 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello Yousef,
>
> On 03/07/2026 at 04:19:42 -07, Yousef Alhouseen <alhouseenyousef@gmail.co=
m> wrote:
>
> > Hello Miquel,
> >
> > After ieee802154_unregister_hw() returns, the driver callbacks that
> > can replace phy->pib have been quiesced, and hwsim_del() has exclusive
> > ownership of the final teardown. The pointer is no longer being
> > fetched inside an RCU read-side critical section, so rcu_dereference()
> > is not appropriate there.
>
> That's right.
>
> > rcu_dereference_protected(phy->pib, 1) expresses that there can no
> > longer be a concurrent updater at that point; the protection condition
> > is the completed unregister rather than a locally held lock. The value
> > is only fetched so the final object can be passed to kfree_rcu().
>
> While I believe this is indeed true, it actually feels slightly overkill
> since there is no updater anymore and, as far as I understand, the only
> thing that we need here is to get the pointer value for freeing, right?
>
> > rcu_access_pointer() would also be sufficient for that limited use if
> > you prefer it, and I can use that spelling in a v2.
>
> If you don't mind, I feel like rcu_access_pointer() is exactly what we
> need here. It is also more understandable, even though I agree in
> practice there are no differences in this case.
>
> Thanks,
> Miqu=C3=A8l
