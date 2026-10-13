Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE84DD3B4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889789; cv=pass; b=sG3zdNUmjgXlACHJxt6194CjoT1KN8ZTA8e3v7ilmABNbyfjwCios0oeOZNwoRj9S/SAdg2b4uUL2KCFyiBcvoNZAKY4Hnkj7TKb6svzS3EbbmSmN68UKv1sG4uvPNUg+Z0OgdJ3YWPi63BwywTzK4yI640SWAZEayQ1KRCv3YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889789; c=relaxed/simple;
	bh=UcZVzRhoeIQP/WKE5W4aqOHyJbP2LuAlVU78KsWakoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqRjLl82fi8BBi1ZpLBzMrVMf+DTSk2uRw2U/LsGxohNnNFIX058rk1gHUVGEWSWbPFKyU7qdWCsJrv2/n6GY9VXCkqbTy54pi1E5+pFnRZuO/LiPdoTcAC8mZ2nLEiIaT3ZRmizzl2y9bkSlMPPMUVvgRlSjNN8iMgDmTq1Hkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFxLqOIQ; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFxLqOIQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c347be93d54so27402266b.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 04:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791889786; cv=none;
        d=google.com; s=arc-20260327;
        b=BQwEXUz1erXv0LmATz8ZYL8zR38nW4e1h1xYNkAcYY1bNYVRMuU/J1eSfGKA0W4RLS
         o/dpzVPykNYnJeQGhF+TS+DeM9XdSLbPE2HiYP1/iLc3ZcSk+h6OL2cgAmRfdBtNY/M9
         pbDZfx+jEMASZvdIaBJoDKQpaLwr979dapUiwJwf944jgiKVRsSPwKCPrlRfJvbvfJ/W
         Ow2BKDz/aPaKjlTrQUvxGCWzKfYfBmJi/9OtbXhQkinmWADg2uyfMExn4of8nuFuyQEN
         OOidV0xFZFJM5vz1HiJHWACCwEqUGMq0L5/9h3b2Y8EtLsKv5Z9JlgjG24MFsZ4byzQl
         sjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUYEAbMlagK2BL2xVw0lZM8FgHGPeijkSqSYtKkyQKU=;
        fh=Sr2kt5qBXAGjhyIvpx3cDs/ONRUm8d+izJCn8Yhzt9w=;
        b=fqgu8k67pj8lvHp8lv8Z7KDHV2G6wLIBkimOoehqPPbCb06NLEI46BcD+vng2hIBgd
         E4bKlTI0/cKCuKJezO7VOyjuJkjU90aXNXtNlEK+vwKzZVSTyNWdV00RwzRkCL85iaN7
         MKsfPLt+E9PYRFWKV4TLbkNZ5UeU58LoBn3FUK70YzcuAbkhdj10DVO4dAvXECpDi+o4
         9e06k25lcOliooy8XH/WCEA4YV8Lhnu3ma976TB0U8stQ5G2QXYR5hUwghYx/gGk5lvO
         cPWeiEE9T8mzE0wEqr38kdo2Op3sYe8HIrn+gDhDUHbC7InA6xFJ8KXaRmtbRjTT4oUi
         D2Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791889786; x=1792494586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qUYEAbMlagK2BL2xVw0lZM8FgHGPeijkSqSYtKkyQKU=;
        b=YFxLqOIQyKcsHKYZ7D6hmlPpzOvsMCiLeHRRZBnCZqcxW1mGEBWT1FTFIyb7gm6DWw
         o1DgDtPzrOTTXOP0Rkp2eKOdbrAFZ6eh5pBd7fKblMm8B19g0uZDAYMnQNoHxe/rLcwI
         OUSfQVlFzEbhbBb0i6T3XuWlNYW1LdgHUX38CMOaMu7gkZu5VdY7rHBJn7ESOZUPXoxA
         zeHFSIhrX8WiGqFGq9HJT408hZ6+c5YoDsJu9prpzHymywBbx3o5okMKEtlQ3oB/obIO
         /W+zUZoontGefPsIceMlYcO4qonuzB3V6qOoYQiBv4fzUqIUQio3CcHEsO9aPa8eupFK
         rPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889786; x=1792494586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUYEAbMlagK2BL2xVw0lZM8FgHGPeijkSqSYtKkyQKU=;
        b=RRMhD+TdTKooaS2jBDT8h15zFLt+VB3ByfZDlIFhc1URNw5XfnJqhtBMQYvmyBKw+e
         BUwqQuZdS0kPM4M+ME+p6Jz+W+RzpbLlTZLUhaEdddmp5mqJ61sl4hbzgJWDrTtcoZXx
         KU6BilOASNILQTHVwhgdRId2JCOAqS0JvDSpB6ovnUpH7VZe1ODxCznlQyU6i4qAvGxk
         A7U9aoAnnR+iTQtai7eAxxeFHOyWCndxZHW2ra4VpGu73oSq5lDuwBhYP5xy7HkR+hS2
         nG0znpCDdmuiwnVcfib0po0ncbYvXcPxjjrE3DVZIypfJ5W/rwxgEi6C4+w5eCTjpv0b
         HG5w==
X-Forwarded-Encrypted: i=1; AKwUvByS/fQxcs9hTp1Wa1xuwQWuFN0L2yQXTBhKdaPD29o5bqD1pPRSMKH+p7qbGotHtXM6Ehj/JnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUhbuvisngQa0SsGUruk+FMByTlopEKV5bJpNWVxA7PjuHMm8n
	PfjL6g8tT5epdDIpFCteHCw5Sp/Xvk4gUA1OW5lsyYwFLbF5o8x3p2h9KJsC1mhjSH+yPdlIjk8
	/NpTBrRYUND/Uf5Hr94PbjM3R+J9i6j0=
X-Gm-Gg: AYBFou3NCNIJnWz0sKK1knW5sRgtzXUlu3JhapEnPMx3p1yjB9CxfCInDvWhbMQsgQ+
	KKJy8UkBJietUgSkMY7gOWrKp49aGY0TJ+liEZIslqXVnhHBjcGVmfj8u1rO+DbF+HMBfoAQqgO
	/YdS4ExYVQrb+hR2g5HOgdPfCvwnyZA71w2V/ITU5GSXexHUojfQYO0OBxHNsEschTsX3SsdFXz
	SeU/VrjkCs4jIJXIvX9XMaX8BXsa4392d1qqB3yyUeh/tchoP58TupJBRgQicBEx5f1Z7oonqM4
	ZnmAcI8WEcPPs2ieB8uk2fxD3xQy50OEI3aCC/5zI4ZI+RZE8ToYHA80m5Hu016FH5JB9Ybb6vb
	/YRPR/yyt
X-Received: by 2002:a17:907:7fab:b0:c29:5637:ed76 with SMTP id
 a640c23a62f3a-c31a9d117ebmr1341139566b.2.1791889785658; Tue, 13 Oct 2026
 04:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904165544.1362052-1-nicoyip.dev@gmail.com> <20260906153354.GB323313@shredder>
In-Reply-To: <20260906153354.GB323313@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 13 Oct 2026 19:09:33 +0800
X-Gm-Features: AclHuK9729ycb5UEiVzzWrhYB1-2Fn5qggRfxnH7xBdvI19vdn6NyzLlKfU2-Is
Message-ID: <CAAo+4rW_P18KuihU+1DDyRrs8W-6TX52n=vBAWm=2uyfAK=V0Q@mail.gmail.com>
Subject: Re: [PATCH net v4] ip_tunnel: reserve FOU/GUE headroom before encapsulation
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xin Long <lucien.xin@gmail.com>, William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ido,

On Sun, Sep 6, 2026 at 11:34=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sat, Sep 05, 2026 at 12:55:44AM +0800, Chengfeng Ye wrote:
> > ip_tunnel_encap() expects its callers to reserve headroom based on
> > ip_encap_hlen(). ip_tunnel_xmit() currently pushes FOU and GUE headers
> > before it grows the skb headroom.
> >
> > That becomes visible when ipgre_changelink() publishes UDP
> > encapsulation before it updates the device headroom. The transmit path
> > does not serialize with RTNL, so it can interleave as follows:
> >
> >   CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
> >   install GUE encapsulation
> >                                   reserve the old needed_headroom
> >   publish larger GRE flags
> >   update tunnel->tun_hlen
> >                                   push the larger GRE header
> >                                   push the GUE and UDP headers
> >   update dev->needed_headroom
> >
> > With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
> > GUE/UDP headers into an skb with only 32 bytes of actual headroom. The
> > final UDP push writes four bytes before skb->head.
> >
> > With the update window widened, the kernel reported:
> >
> >   skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
> >   kernel BUG at net/core/skbuff.c:214!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   Call Trace:
> >    skb_push
> >    fou_build_udp
> >    gue_build_header
> >    ip_tunnel_xmit
> >    __gre_xmit
> >    ipgre_xmit
> >
> > Snapshot tunnel->encap, route and perform PMTU handling first, then
> > reserve the final headroom before ip_tunnel_encap() builds the UDP
> > tunnel headers. Because encapsulation is now delayed, pass the
> > snapshotted encap length into tnl_update_pmtu() so the inner packet
> > size stays skb->len + encap_hlen - tunnel_hlen.
> >
> > ip_md_tunnel_xmit() is left unchanged. It takes FOU/GUE parameters
> > from the skb metadata dst, not from the device configuration, so it
> > is not exposed to this race. tnl_update_pmtu() still runs after
> > encapsulation there, so that path passes 0 for the extra length.
> >
> > The IPv6 analogue of this headroom reservation is still work in
> > progress.
>
> Please wait for the IPv6 part to be accepted (some changes are needed
> there and here as well) and then mention its sha1 in the commit message:
> https://lore.kernel.org/netdev/2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1=
788262122.git.petalzu987@gmail.com/

It seems that patch has not yet been accepted yet. Has there been an
updated series that I should follow?

Should I continue waiting for that work, or would it make sense to
prepare the IPv4 headroom fix separately while addressing your other
comments?

I also noticed a newer overlapping IPv4 patch:
https://lore.kernel.org/r/20261010223601.1193655-1-theodorlarionov@gmail.co=
m/

Best regards,
Chengfeng


>
> >
> > Link: https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2e=
d84d21.1786088695.git.petalzu987@gmail.com/
> > Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via =
netlink")
>
> Looks like a more suitable Fixes tag:
>
> Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp e=
ncapsulation")
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v4:
> > - Not restructure ip_md_tunnel_xmit(); only pass 0 into the new
> >   tnl_update_pmtu() argument.
> > - Snapshot tunnel->encap with data_race() and reuse the copy for both
> >   ip_encap_hlen() and ip_tunnel_encap().
> > - Fix tnl_update_pmtu() inner packet size after delaying the encap
> >   push: pkt_size =3D skb->len + encap_hlen - tunnel_hlen.
> > - Keep reverse xmas tree for the new locals.
> > - Note that the IPv6 FOU/GUE headroom fix is still WIP.
> >
> > Changes in v3:
> > - Move the headroom reservation into ip_tunnel_xmit() instead of
> >   growing the skb inside the FOU/GUE builders.
> > - Use ip_encap_hlen() to reserve the final caller-side headroom before
> >   ip_tunnel_encap().
> > - Drop the IPv4 raw-pointer refreshes that were only needed when
> >   skb_cow_head() could run inside the encapsulation builders.
> >
> > Link: https://lore.kernel.org/netdev/20260824111944.187200-1-nicoyip.de=
v@gmail.com/ [v3]
> > Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.d=
ev@gmail.com/ [v2]
> > Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.d=
ev@gmail.com/ [v1]
> > ---
> >  net/ipv4/ip_tunnel.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
>
> ipip6_tunnel_xmit() also calls ip_tunnel_encap() and seems to have the
> same problem as ip6_tnl_xmit().
