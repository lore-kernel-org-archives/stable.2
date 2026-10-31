Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793465620;
	b=paMrYJKRIlbpQMwREjPmS3lYk6hPW+H86QbXcg3zh/dhNqklizGgf7p27dlkk7VclGvW
	 WQtKpUYF5cSggYwTUGK/h5hriodtBMsg3+QDO1flfHwIEoWpcOO56YH56bjInBZ1iwiFw
	 p+UElDveSHv6ne27P/0ZPZrDqOkQ7fhG3DdKY4QuzzBuV2tCrfzBaZdpYv0WHRjmTU3dH
	 9R0hPXrCmfmY6U8+gIMheJoudBNRh9e7rNlaUSiYxDMCfQxunP3bpCtLh36MPz/kD7mAV
	 nelKdFXqhDhidkCIrp0MYpJz9/KEqlio4pP3dSOjsGi+eqEeczJcHI0wr2O+3LMeWIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
	b=zhrxRpUcCBjM+tzuKJviazS0YO/QLISVvfg8mHV5ZCeTCBSAFY1MonQPJtg2fxOrh6Tk
	 DzEFdWXKTBRm/4WgZrwSgS87OLYADaZ5JZxXLhW47L3kdnQkGAU2uB6ncAvFcCzKAL0wx
	 Le8sctekwgXBNs5qNs6icvnW5NsaBK0+PobnFet7KSTFyD9im/ucTEs9rAqsDotaYy9lx
	 x6oqgh3nxpchbtg8hnt5B6zG+eAXKwdeRqGfJgP6Np6w+f/O2Uxqt33Sh7LcmR4ObieFf
	 7nf/JtSrwImbOb3COTK3SL0zos4sQDhRwlW7sVdfGg1i5euA4uxSWElFe7yudNsMACA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIJmwbIm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55DA606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 16:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C55DA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIJmwbIm
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d885929so1376943f8f.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 09:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793465618; cv=none;
        d=google.com; s=arc-20260327;
        b=ViwCHe52vBA57UvXxs/a5wNwWdV03NV7Thbrp8tZg38ODeyfroHd3EyVkgcLEb+kDU
         xWNKlnymJ8uQTEWyvLcR8LMAjuPVv2X2Wz0rEPjUOO2fQ6jEFyIYB017/20Hsux8RIEj
         uRNTp4wakVvQOfMfPNafsS5Bhq9KNzYuj/jxWEeXz8pRhqYbEdMzDPz453AdffNjapeR
         Dvr3FMZVBBCbl75EyKgnjwOb4X9jtrybNByBrSiijnGdyULfL4mLDzIXrjQebUBl1oyO
         G6F1UL6mDt/a2sQBq8eV/KEyKYbFXsDWIULcOHCxulnDI0UB2a+ecSa0J9JqhgTwlr9x
         p2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
        fh=az0BdT/3GrcFmczUAprlET3MwzsyMA/MFWkcOsIuYh4=;
        b=G5rDDf7oV/UmJroJfqdecmSdC6YLHtQtTPxleRzBXab83pQSIxj4A6SDWtgnW4tZdC
         vXJ0/sBjmil98DoStH501ZlBmpZjqr/72KVMpaLXEUJicJRJ2Sl+1csG0koKRMIOwnbk
         5Z3msXxwK35wiwd1av8u+zNkexctiMWqp3KaDyruOBFva4/a+X5ackZYBd2KWhJrT47z
         7sPtjbWGf3+lKNHDNXlPE55s9cJ4lDWhu2LBlXVuLPWyJt9NG7Pv+XE5HqNMJw+bZllt
         Gg6oU8lTmk6r3CaoN9n4x0VM4NH5aV7hclMAsCoabs5iSMnV+P9czq1kL3WZ79gYT1Rs
         xiAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793465618; x=1794070418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
        b=VIJmwbImdJ7tqPqF6jrRbq3HMY7IraITPWOtqhX+0oXp/XoJP9J2TSonmnHtG44AM8
         2IN1uQmbFb57TEnwpHEmFrmv2LIAOtnGRizEq2aZoFwuv6/cA9UCHUipa54nKutYILpX
         4LXJ9p/vaWVqDsgWFEs/NSVZ5LrINsYr3kOOazfDQfDRfBzDts6Sg2N1CvgNGESKtGCt
         8/FIIGLaQYmqUfBaGq5IXK0MovYOvd2nuxLOCOoUO+H64Jev1iaFtzcujOuLR/OARuaR
         2WZZ1GW66gOuUTHlwmffb9jrzLyGqGJDnApMOp1tlF7P8cMCoJGAjdNsi/9rCUHtnCgm
         Gh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465618; x=1794070418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZfBsiDhjWHzNYGhYvrb8s+dYe9Lk15I4OuANiSiCO4=;
        b=xCsTI+4sE5pTxMoL1H4kSnA7U6KpOjto/4rA6d4lBVx0atXY5BwYY/uk37jPeqernE
         I01zgDrKkTjUAPnCq9FUluYFkJJ7DGXEGSCPXmskieCnJmJmC8hd8Ic053j4U1BTqpWw
         qq3TGX1m0Mvp2GaLf8nKJJU4dqGIV4rZ9VR8pjDxjUrmBAHG+GmVvOo1rdpHCwY8j5gQ
         Wq1WNOVfiaqm2lkt451bQ9RAGukMkk4YmAP1Ap20NfPiYrPOHsII42JKVNUFC/ArZnxU
         yfr3cvwgCB9XwE1Y4pRnfKE0HYyB5ryehjKGF8P2Zx7xmcFBto7tuyeSLqh4NmPs7fMC
         c0Aw==
X-Forwarded-Encrypted: i=1; AKwUvBxJAYTuiH++kekUXn4aMZu10WePNy1h1Bimsix51UABJjwiUwy94tXSCrLI/Edo/k//giK8dZQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI22wo7psTyrs9naMRZOAsd2wS4g1ieSfVK0weAPNYzEVntue+C
	Lj8u7Tr+tU6fn65wyHyTjk/w/AfRRQPXlzFoJ9SAb4UO+E2d3mxd54ye/2SPGq3y8UOKdHmWdOa
	ooMEo+9hfWf8Z5+QdbOHB8fo9/xu0iFBm6g==
X-Gm-Gg: AYBFou37ml5ZlHWNgHAcYVG3wKf13z6VFNIUbsi7P+qUeRIMk6tRjGhRiZU5yLHp6kx
	/smrn3GWC2/OHmR5aSeHSLlO3qGGCP3jprZyEX1MdPThAEit2vGiOxmY9VR3Px3AdrVNSiNOP4d
	KyJojnikWR7u4DNgJ9FXFTBoSzzpwBvsuUy8sW4q8yL+g4YNkeekbOKA5fK0TZXFsExbhxcl2S9
	Z9aWQUInAqXu+CKrp9pDhIAz+H0VjmMf3vS3hyo5CKUeGlflNyk0V5hAYv6ziuPilZ9+vTz0Bc8
	RY0EIQv8NMB+37TgdnS/hFyPtNw2Fo1MuFC1ncIALAznEWqNpMVa6Zh7ML8UhoO/pgiBIEWsePC
	M7pP4Y/eZZacxwlHsHRLMZubaMkjzJ86ZT0iyVRqPF10AqiKYSkiUkOC+hNQbLvUtyhkBpZbHld
	csqAGhv06g+BafuwhbkGbA8EMpHen8jlUEH54vTauw3x1uqq8gk+9hxQ==
X-Received: by 2002:a05:6000:26c8:b0:48d:f14a:9183 with SMTP id
 ffacd0b85a97d-48e6e303b1dmr12982373f8f.15.1793465617789; Sat, 31 Oct 2026
 09:53:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028170239.28606-1-tactii@gmail.com> <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
In-Reply-To: <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 31 Oct 2026 09:53:01 -0700
X-Gm-Features: AclHuK9MF4xp-jNiLvDP__4wEuJYr4Vy9lxz0MfHVWn33kHTzL4Vfxqnin2Erm4
Message-ID: <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 12:00=E2=80=AFPM Matt Vollrath <tactii@gmail.com> w=
rote:
>
> On 10/29/26 12:47, Alexander H Duyck wrote:
> > On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> >> When an skb arrives at the driver and the header length exceeds the u8
> >> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
> >> are sent to the card. If TSO is enabled, some header lengths will caus=
e
> >> the card to hang.
> >>
> >> This was reproduced on an I218-V with an unprivileged Python script.
> >
> > Can you elaborate on what the script did to trigger this? I am
> > wondering if it can even get there with a valid frame supported by the
> > interface since most of these e1000e parts don't support tunnels and
> > such.
>
> I will send you the script OOB. To be clear, this is a security fix,
> not a correctness fix for rarely used paths. The rules say I have to
> post the fix publicly because an LLM found it in a
> function-by-function scan.

I got the script, will try to take a look at it over this weekend.

> > Also did it have separate cases for the CSUM vs the GSO? I would
> > suspect this is more a CSUM issue than a GSO issue.
>
> I have only reproduced hardware hang when TSO is enabled on the nic.
> Otherwise it likely just mangles the packet, but I have not confirmed
> that.
>
> >> Fix it by disabling GSO and checksum offload when the header length (a=
nd
> >> checksum offset) would exceed the field widths. Compensate for a
> >> software-inserted VLAN tag.
> >>
> >> Because of a quirk in the ordering of ndo_features_check, the skb's
> >> transport_header field may be stale. If the skb carries
> >> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there'=
s
> >> no reliable interface, so don't offload it.
> >>
> >> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currentl=
y for ICH9 devices only)")
> >
> > I am pretty sure this Fixes tag is bogus. This is the introduction of
> > the e1000e driver which was in 2007. The ndo_features_check didn't
> > exist until 2014 sometime after that if I am not mistaken.
>
> My understanding is the Fixes tag should point at the commit where the
> bug was introduced. A comment on the Cc: stable tag indicates how far
> back the fix can backport. I didn't bother because this patch should
> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.

I get that, but at the same time the fixes tag is pointing at the
driver when what more likely happened is that the stack evolved past
what the driver can handle as evidenced by the fact that the fix would
never be able to backport that far as the function it was adding was
introduced sometime after the additional stack complexity was added.

> > Much of the complexity that enabled frames to build up massive headers
> > wasn't until much later when the network tunnels and OVS started being
> > added.
>
> The repro script should work back to 4.10.

Okay. However, that still only goes back as far as 2017 if I am not
mistaken. The diff you are blaming is from 2007. I suspect we should
be looking at blaming whatever introduced the ability to push the
headers this far as the driver itself isn't likely the root cause for
the issue, but instead a header change was.

> >> Cc: stable@vger.kernel.org
> >> Assisted-by: LLM
> >> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> >> ---
> >>   drivers/net/ethernet/intel/e1000e/netdev.c | 34 ++++++++++++++++++++=
+-
> >>   1 file changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/=
ethernet/intel/e1000e/netdev.c
> >> index 6f85dab5c55c5..370776657d100 100644
> >> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device=
 *netdev,
> >>      return 1;
> >>   }
> >>
> >> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> >> +                                          struct net_device *netdev,
> >> +                                          netdev_features_t features)
> >> +{
> >> +    /* Do not offload packets whose header lengths exceed the u8 fiel=
ds
> >> +     * in the descriptor.
> >> +     */
> >> +    unsigned int hdr_len =3D 0;
> >> +
> >> +    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >> +            const struct tcphdr *th =3D (const void *)skb_checksum_st=
art(skb);
> >> +
> >> +            hdr_len =3D skb_checksum_start_offset(skb);
> >> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> >> +                    hdr_len +=3D __tcp_hdrlen(th);
> >> +            else
> >> +                    hdr_len +=3D skb->csum_offset;
> >> +    } else if (skb_is_gso(skb)) {
> >> +            /* Work around untrustworthy header offsets in this case.=
 */
> >> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK)=
;
> >> +    }
> >
> > Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> > the frame must not be TCP/UDP GSO since for those normally the checksum
> > and offsets should be populated. Have you identified cases where we are
> > seeing TCP/UDP GSO w/o the checksum being set up?
>
> It looks like this particular case is never reached by normal traffic.
> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
> hostile or niche setup.
>
> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields are
> used for csum instead, or left zeroed.
>
> The transport_header field is unreliable when a packet is being routed,
> so you would need to parse the packet from the top to find where the
> transport header ends.
>
> Rather than walk all the headers for hdr_len, it seemed prudent to just
> categorically deny offload for these exceptional cases. I could be
> convinced otherwise.

The point I was trying to get at is that the stack shouldn't be
allowing those sort of frames through in the first place. Basically if
checksum partial isn't set the stack should be rejecting the frame for
UDP/TCP GSO, not the drivers.

> >  From what I can tell it looks like the only valid cases for it not to
> > be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
> > FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> > anyway.
>
> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e

This is part of the problem. It pushed through the ability for
CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
reverted back to using CHECKSUM_PARTIAL. That is what is partially
what is allowing the non-partial checksum through for GSO frames.

I will probably look at submitting a diff for this next week to look
at limiting this as there are a number of drivers that already expect
all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
start processing the frames.
