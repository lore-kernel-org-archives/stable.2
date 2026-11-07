Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089421;
	b=E3iepakC8v1gNeE4TPZemq5dTygD2F6Pj+nW6oYJFkp/VFXDnPHcW8TK8MEwQaBFvqZ7
	 MPtobKYIAfqDsO5JRoqPyubct9eHNC18B56fRzDdOGfoSeDnkwc1RR1wqql56wy5e2aIt
	 UgdPWdJF9fRLX+LAa8VyusJwUQ8jKVyyBJj5u2LhKfOsdj8LZezOM9ZC79IYZzrrVG+gU
	 5IqymluJ0GqYXbJSpdtfRbPS/hLR+AFLrGVSWJBcUDg+PR+OyZkDvdWHIM/FA7xnaZLub
	 8ILz6QvCmX6212Nu9qO7Do63aKfdJUpnTMfGyIbx+4VNJ3ovEm7aJU+Ho31J/XigCCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
	b=npZ/PULHVW3flXz08v6KX38YPQ+rAmfH/b1m5mobtuNxQqNS18dOPGbSLa3CnkNw2+/Y
	 cFfu0VLTlAr6n9UIj3yBwfXbRKmCM6QRQoaBNrK2Yq3zv8oy/BJGH79/bp6DHaMMmUNv4
	 ogxF+Ren7nIy1hayQvtzWCDbLaPWbeLu/VozAXAIlqxduJXiJPpydnzU1wKIpvNORjhOe
	 RHl2Pun7JMTZckunl3OWkvO6zmu/uEl6h0KmkTpM8GrcQqV2TgDxrm5lJiB7kwlUDnPZy
	 RiBM9dnAOZr0kJWb77hzxs9O7ap5r6lzTJBbaafq9ltMStGvugaRxQygTENoIFBF8EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u5AXsq3N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53538606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53538606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u5AXsq3N
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so37287b3a.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794089419; cv=none;
        d=google.com; s=arc-20260327;
        b=gdgXDYH//6h7ARGrFohC6f3+8AyiVBiP8r1Ir2vlTJe94eyItZHDoo4rM2sGG2KOW3
         uAqIQV72H3t3NrQFJUWeB59ld6MSbvgAsslYDpElnxy0Snp4MTbbyM9Ui5VkPUGfCbRt
         WZd1z2A5x8sb3Og0q/gk5rdf0ZTd3fQkQtekR66Tl3tBa2iFkXD12Vw8pmnqbBCC0aBa
         K42NsWHaJb+oZp/bX5AEEeDjGmcSf7ppEqpigk+AJsNRqviaVC+0YzGqCp0UCEXGLlOF
         qyoZBgYyXFgHKEnhJ1XcxdUZ/9v2g5Az6cinZ+Mk8wIIe3qfml7DIMXU9OZpLutqjcFE
         1mEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
        fh=FpwjcUCAMSW+Qmj+pnEM10XIIuzCOAGKSo7bPk7oSQg=;
        b=CeFfBLlwbljUdmsi7lj/TSXxgGpERfFhYKflP8LfLFADZNBY8fzPIlqXpJZNEtE/lC
         AhLDUazovBOTeY6WtoiNT0nGoaYppBO66OcosDCYrHMjKQt8C/YvnYjk74iZKnuqyM0f
         2eUQSk6cgA798CGR3aYNpNPJOMDHwxN487thqCaCGeC9q9s65yQimH38r+plh+vJTCWp
         em1kcuHHbGF1/1FOTqWKEdLcj7Z6JMZog3IAIsiQajsZiiVG7aWXOXaZUiceQkBLglgI
         szcwnKdekD69Gn+1hawKeBn5n9hnn09RNPVq0t09KXqNgs0vE0+ax3I8GuWptoXaniID
         F4Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794089419; x=1794694219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
        b=u5AXsq3NwdaS8etlRMSWzvtK031aUlmRv8pu0dgMT5+Efh1ollzsp7TFeWBRW6rnjW
         X3O2Su0QEkod2N7QdFOHaSBMdUFNHZuh/1lX4unJH/HS9yhyvPmcTGO5eEw6odQfkA1N
         nV1iJKAogoCsvLYjZWahRNTAZyEljoXXsFvQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089419; x=1794694219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5TJnUxDLYcJHQslxurYixsZ2B8878TTxkxqO4cll/SY=;
        b=ArhGNqisI0qMQ1gyInMamCf5bVoZ+tMNDcdvntnKt4Twwj0ag5Hyg8ZFpFXk0Rwvtc
         2C3IKwoW1ZXw09U5wH0fntm31Clqi4Gz2aoh08sr6eqnFtjw2nplvWCRteJiWrgAbwbQ
         kFf1XnAjIH/TG3PIUxrSiwUtbWKzZ0qWIcogiUlssrwT0Y7d7D4V0spXB34tIKxnuaRM
         WJi6+pvvv8BO8hzP/mIU0waO0Jko2azysqCLBtQjDEDAsu7npJRZDis974b5xhhqKWa0
         /1JpsaKUaRsGKZX4/qG2cuNEL7abKr2XjXiwo7WglkfgenXEVcTTkBppw4S25DAYdt0A
         PdQA==
X-Forwarded-Encrypted: i=1; AL+hErGQ9CEgB2YW6jFtCDqyHqteyjiaOSWg0lbqjptSEHpWTt/X5f/aF5XD4vpr530KkUG/93eBM/E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+05oldbtSjeatnFWSt3Sjj8XhHTBq7z1pELgOzq9vUCcxwKK5u
	+bPt0v9d0qgMnI62w7sJr7BhKHCs3yM+DtqYxBr0HDzlK9k2A5JduOuxRhqKE/7oNCs29sz5VEb
	akv4cvxZZgP33pb1EMRmPzRCcxGJuhA1NJm09yYsB
X-Gm-Gg: AYBFou3T76BWYYf9pZnaf67zTD5pngNOlDBGJBZgDkQCSzR3NyTXhSt6Pex6EcMNK/+
	exXLuwuxr36TifURnQ0LnMB3F1KwV9GP4xrIz5ZlIKBvuNtFywpXMTEo9y1u8NtCnZoqgUoxL3S
	cYk0P7kpic8MQug26kwvsE1IpurAP0DKMwWqwh610zN8a+nSHBBY8sn/jRz3t0iLSN/DJ/t6TKE
	4253wsokkrDZBLKboRnbl6chduNfSYtto0LD8z21vvntvI2mPnRDrbALzExndI0mGn/H9ECcM7U
	0muzCvAhQPw8drdWo7MrL1XpZtkGHjDKB/CDpNgbTKt6DfmTYQ9JIcRqeN9gJc7a6T7j8XZJhsU
	CdovHlGz9WvOvzmCNByC1qceB2/9nHDejdAuQTnNOjNez74qgmiKJhOL3Fqm4ppb6d289SA4Pu4
	llO5BikEm/32QSZuk=
X-Received: by 2002:a05:6a00:1743:b0:8b1:1410:ac5a with SMTP id
 d2e1a72fcca58-8b66dd622d7mr41092b3a.13.1794089419503; Sat, 07 Nov 2026
 14:10:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v3.r0.20261103064310-2@mojatatu.com> <179406301809.994134.18083601714109684155@kernel.org>
In-Reply-To: <179406301809.994134.18083601714109684155@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Nov 2026 17:10:07 -0500
X-Gm-Features: AclHuK_nLFadmgyd0vGCf2IOAjc_uk74qO3Y20nY60ED-Tk07CwICMgFvdp-7CI
Message-ID: <CAM0EoMkwapj0TzbhWPic_JYP8o7L0Hkdppx78PtAq1KoH1Go1w@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] net/sched: act_ife: require a full Ethernet
 header on egress
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:50=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit is titled "require a full Ethernet header on
>   egress".

Yeah, that is a bit of an overclaim  - but i will not be resending
just for this. If there are code changes needed in the next patches i
will resend.

> - [Low] The commit message says "A short egress skb is now dropped
>   instead of being encoded." The patch actually drops every egress skb=E2=
=80=A6

Same here. No resend coming.

cheers,
jamal
> --
>
> net/sched: act_ife: require a full Ethernet header on egress
>
> On egress, tcf_ife_is_eth_skb() now requires pskb_may_pull(skb, ETH_HLEN)
> to succeed. Without that check, ife_encode() could copy ETH_HLEN bytes fr=
om
> past the linear data of a short skb. The ingress mac_len check is unchang=
ed.
>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.=
32824-1-victor%40mojatatu.com
> Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojata=
tu.com
> Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.c=
om/
>
> > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > index 6b23a3965121e..5a527da005661 100644
> > --- a/net/sched/act_ife.c
> > +++ b/net/sched/act_ife.c
> > @@ -878,13 +878,16 @@ static int tcf_ife_encode(struct sk_buff *skb, co=
nst struct tc_action *a,
> >   * is an Ethernet header because the skb could've been redirected with=
 mirred
> >   * from a non-Ethernet device.
> >   */
> > -static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
> > +static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
> >  {
> >       if (skb->dev->type !=3D ARPHRD_ETHER &&
> >           skb->dev->type !=3D ARPHRD_LOOPBACK)
> >               return false;
> >
> > -     return !skb_at_tc_ingress(skb) || skb->mac_len =3D=3D ETH_HLEN;
> > +     if (skb_at_tc_ingress(skb))
> > +             return skb->mac_len =3D=3D ETH_HLEN;
> > +
> > +     return pskb_may_pull(skb, ETH_HLEN);
>
> [Severity: Medium]
> The subject says "require a full Ethernet header on egress". The commit
> message also says tcf_ife_is_eth_skb() "returns true even when the skb ha=
s
> no Ethernet header".
>
> Does the new egress branch check that the skb has an Ethernet header, or
> only that ETH_HLEN bytes are in the linear area?
>
> Take the reproducer setup from the commit message and send an IP packet o=
f
> 14 bytes or more instead of a short one:
>
> tun_get_user() (IFF_TUN)
>     skb_reset_network_header(skb);       /* mac_len is 0 */
> tcf_mirred_to_dev()
>     mac_len =3D at_ingress ? skb->mac_len : skb_network_offset(skb);
>     skb_push_rcsum(skb_to_send, mac_len); /* pushes 0 bytes */
> lo egress: tcf_ife_act()
>     tcf_ife_is_eth_skb()
>         pskb_may_pull(skb, ETH_HLEN)      /* succeeds */
>     tcf_ife_encode()->ife_encode()
>         iethh =3D (struct ethhdr *) skb->data;
>         __skb_push(skb, total_push);
>         memcpy(skb->data, iethh, ETH_HLEN);
>
> At this point skb->data still points at the IP header. The first 14 IP
> header bytes are copied as the inner "original" Ethernet header. They als=
o
> end up in the outer h_dest/h_source unless eth_dst/eth_src are configured=
.
>
> The over-read past the linear data is fixed, and these bytes are packet
> data the sender controls, not kernel memory. This behaviour for L3 skbs o=
f
> 14 bytes or more was already there after commit 5b483f7791b0. Still, a
> non-Ethernet frame can be encoded on egress as if it had an Ethernet
> header, which is what the subject and issue statement say this patch
> prevents.
>
> The comment above the function also still reads as a pure check:
>
>     IFE encapsulates the original Ethernet header and, on decode, expects
>     to find one, so it can only ever work on skbs that carry one.
>
> It does not say that the egress branch only checks linear length, or that
> the call can now pull and so modify the skb.
>
> Should the subject, issue statement and function comment say that egress
> only checks linear length? Or should the egress branch also check that th=
e
> L2 header really is Ethernet?
>
> [Severity: Low]
> The commit message says "A short egress skb is now dropped instead of
> being encoded." Is that the only behaviour change?
>
> tcf_ife_act() calls tcf_ife_is_eth_skb() before choosing between encode
> and decode. So a short egress skb is now dropped even when tcf_ife_encode=
()
> would never have encoded it.
>
> ife_get_sz() returns 0 when no metadata is present. One example is
> ife_check_meta_u32() with no skb->mark and no configured value. In that
> case tcf_ife_encode() returned before touching skb->data:
>
> net/sched/act_ife.c:tcf_ife_encode() {
>     ...
>         if (!metalen) {         /* no metadata to send */
>                 ...
>                 qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
>                 return action;
>         }
>     ...
> }
>
> These sub-ETH_HLEN frames used to pass with the configured action and wer=
e
> counted as overlimits. Now tcf_ife_act() drops them with TC_ACT_SHOT and
> counts them as drops.
>
> Could the commit message mention this change in behaviour and statistics?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
