Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723317;
	b=zF1Yi31ZbdCFfp92s2RESjBQPcC3cHQ7vPnoRzmEFyT0tXniC/RNYXMX9m/Lvod5shMn
	 WG8x4jpc/jprGwTweA60KC41t9fptQbgvt6RG69K5aFPan/dLgY21N4qSP1hK6E99tHjA
	 n1JXwaf9bHhxCoLsAhrFfyMAZQptsBlJLtjSd/DDVDgw5jK7V9uJBpx2LhC8u3qyI4E9i
	 p04FRpiDHbkcNWRMgv15NUbBsjhxCdoHZ6aI/gskt2KqjtJ2Czrl0lQrGuNn83sMHvvYW
	 lX9pZyLd8tix+t/qHhUJHX/ut/ovuD5eY5OpgNhTOMRUwh8dmPJ1Afb+x1LpDSDMy1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
	b=Ew+T5Ol0sKwk4AZiGsrlMtREf0ke02962PscZEYbJS96R9Mmht15amVAUz60GgTtEKPm
	 Z2/hMwNlg+qtUAK1lNUc3tBQ65vpYHR9hBb2we5EiBE12SGOpcDShKjMZ6oT2OwdHyWeR
	 iTRkZVEyHdJPffne/d5LEy8Wj3O1LoXNkB2V6Kn2FA+b9hEmM3DP590nM7dRKBRoiCqwz
	 IMOGl22CI9ayPykWjUL3p0KKQmfoiLNv6jMK+m/PZzBYMJq2Bd7oFskfqmrDaE+Cwrm4a
	 KnkrUSTHhKoX4H9BwwCcRO0jjHtJUAsMDSVsvlJ+LNWm69O/U/NX3ngE5Ntbxrz1ZeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqpwUQxF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CD606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92CD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqpwUQxF
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48fbe12cfdcso43701f8f.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723315; cv=none;
        d=google.com; s=arc-20260327;
        b=SbaHDofH+gxFiqNr7ut9jxFHMPfATq8hPJ6WiJrYuz9XgdBEBHqwjZuhl/sdxfxXs9
         YSPb2KavhTkDFsX+R93eL2nxgQNDttJxvw8KwcqMDU0i6QlVupqA6uGgvUQblLdLjxpQ
         VYmG4umh0n1EjcUYMAu8rUNbgiLfHVPjCMMHqXnW/krxt6JkX+B+HW4cBCqo3gzc9qHF
         v5Jt6jrW06TzwLtx+Fq5quvdP44xASlzvOsLbtwum2+tONcgXfFONEvjIstSAgaSbwII
         ujdDhdUS8ex1R6VJ2K1wwcmtuFEFVO3vULx6lHHJ9ALcUvs6mObc44WF4WDaWafztM2F
         DneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
        fh=I6AmKV7Jgx4Oxd2pbTUdWH/1HF1IyH/bMx8cOXn6T0Q=;
        b=m89mvdcxKgsSe2HjsKsn1XzdT53NX+brIrePJW/05BHItBAy9LVrBAxc6Hh4rlBzq4
         JRGWgpZMFb5ivE23CXJRnbAw8v1aMhJN4UNchcOy7xRY0CHO2dkAtB22dF84o2MgSQ+H
         s6MjSKJJ/LrVGcCMy5pJnx35PcK9ju7eYNtPoVc9MtI7yuZtGeQ0cOdTwBzbjeYRb6NR
         LbFeVWLq2TPwhks01uIFM5Oenzh4R1MFqrooSkPGUEsYp8HzK79XX1Uz8R3dnfBLTKaa
         H1+48GgdDc4kUzlRqHTgonXHmz7HPpaetb1URzpzv4XYDtWbIBoHZZ5h+lAau5ak2sWi
         3kpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793723315; x=1794328115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
        b=LqpwUQxFHDyhjKx+++qQ03EB7zP6QXkk5NIIeDdLl+2BNMqteUQ/BWFxI9lcztDTm0
         /Lo1jxw0teouU0/A04ww78TjzqMPuQM2FQ1htRceS/qD4hsmfrZ8XCPwLBNyaDpLc3B2
         UldbClo8y18tzgFBFsSRVURm2/MVnMErmIm+qfXVrJ/7HlDqaoEuR1UrRlRL6cVtvV3E
         95ZwKPQoCtgNGI9IFP7pefJvUAQ1zbHFAMojdSFCvm6rVP73xQ0BvyJ4NPjG7iqvkERH
         yYv75Yy2K5QLvumlMv8i4M0QBCPhQZ8EbzSAk/zz7gzwYTEnyqobj5+tb7vK4k1onxtm
         zRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723315; x=1794328115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
        b=eKjrI5WHj+Bw8bduJUXTLy1u2kXwMynpmwnnXOlLlWZvWjQEyBSMqKuh+r/CpJfWI7
         U+aijqigIh86i/MNwJV/qUqp4luz4yf+uvF/b77LLJ6QMbCHT4LCNBFVl2anqAwdug5m
         QdmMJDXwzwLqEhz3KyC6aFgWoY4eHpM3ZWBY1taX780yuIeLxBxupadyW/CE+JdKp5P5
         R/Q2y/FmGUHwDYA98t0WXyshr9Z6E1acCuOvY95ufkDNKcJ6rd6MJxTQ9tX+F7YH7S31
         cGuQGNKvDJP3FoDuJWbD1G+8B5UqlH2A/VfKdZaN7R55aKqg5KIy75G2hiCDCTysxLzD
         hQtw==
X-Forwarded-Encrypted: i=1; AKwUvBzoSPW0sox+u3pclVQP2c9IopAmTKRAKnsITqaZFdSNjr9MbSMSzO8YfZNS1y8MGmQ/pxX1tYc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b0S1CIejfr3uS3ZV5dMSIv4URDLB5R1VkFUMVfVhjSC+wo7KD
	+oEAMjrorf0tA0VyByAal3tjKkahAeMD8d0ADBCMivRCBlc3AqUAN88NlWRjcbjEWXmhAeIPVM2
	B1Yh50Xl/aigG40/HUqFbi0ME2c7KMUM=
X-Gm-Gg: AYBFou2/1hPuPwfIoWILrPjHLWbdP1oF/j/+CKxXyTLyaEk9N5oXMT6SraJnyAiZu5L
	jJK4clfTY0IzBpHlZOcWbpefLOA2XiTG/70BQJ6XbDNpVIu9+vIuCfsOV9kylSQ2P/wWL9Dkx04
	ymueo+BnH4ktfsdLZyTAglveJH7LuVAMmRJFZvOtUVc9UeQ+fbaJjuHo2VxBUS6Q8RedRc10eM+
	BjLF2qtEOQL1H6xRqCIJ6RDzefeFB8PgXch4RCo9TTZ++lrlX0hclICe8DoAiE98Jc9vJFA7UZ9
	ixLu9AtinP+nEeDuSJKLl95rbLObOMBFjJ1pIF56x1i5x+/aD5dsCAyMUMRWeOUIx4Bbk45xPdT
	cqwhqzAZx/5nj4tn5yxhm0XD1Md4zmZB2kQRbA76TM87zOpjAPSDhGLkn7J+dyts/G1lJ2W0OXI
	J+K7XFxMgXNQIb/sI9nCWDEK9HW5Y6rXcerTistliVL/7SOgcy4q+zeg==
X-Received: by 2002:a05:6000:2404:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-48e6e2c1e2amr29659218f8f.8.1793723314831; Tue, 03 Nov 2026
 08:28:34 -0800 (PST)
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
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com> <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
 <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
In-Reply-To: <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 3 Nov 2026 08:27:58 -0800
X-Gm-Features: AclHuK-P7m9VOIbcOGQMmiHqx-bxMRQC6xGVDdY-66Tx-Pag-hb_2xV8nBD-_BU
Message-ID: <CAKgT0UfTMsJok7ZOBukzrVKvTC9qV38jdfWH6yKDEPJSEsB3CQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:32=E2=80=AFPM Matt Vollrath <tactii@gmail.com> wro=
te:
>
> On 10/31/26 12:53, Alexander Duyck wrote:
> > On Fri, Oct 30, 2026 at 12:00=E2=80=AFPM Matt Vollrath <tactii@gmail.co=
m> wrote:
> >>
> >> On 10/29/26 12:47, Alexander H Duyck wrote:
> >>> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> >>>> When an skb arrives at the driver and the header length exceeds the =
u8
> >>>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped value=
s
> >>>> are sent to the card. If TSO is enabled, some header lengths will ca=
use
> >>>> the card to hang.
> >>>>
> >>>> This was reproduced on an I218-V with an unprivileged Python script.
> >>>
> >>> Can you elaborate on what the script did to trigger this? I am
> >>> wondering if it can even get there with a valid frame supported by th=
e
> >>> interface since most of these e1000e parts don't support tunnels and
> >>> such.
> >>
> >> I will send you the script OOB. To be clear, this is a security fix,
> >> not a correctness fix for rarely used paths. The rules say I have to
> >> post the fix publicly because an LLM found it in a
> >> function-by-function scan.
> >
> > I got the script, will try to take a look at it over this weekend.
> >
> >>> Also did it have separate cases for the CSUM vs the GSO? I would
> >>> suspect this is more a CSUM issue than a GSO issue.
> >>
> >> I have only reproduced hardware hang when TSO is enabled on the nic.
> >> Otherwise it likely just mangles the packet, but I have not confirmed
> >> that.
> >>
> >>>> Fix it by disabling GSO and checksum offload when the header length =
(and
> >>>> checksum offset) would exceed the field widths. Compensate for a
> >>>> software-inserted VLAN tag.
> >>>>
> >>>> Because of a quirk in the ordering of ndo_features_check, the skb's
> >>>> transport_header field may be stale. If the skb carries
> >>>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, ther=
e's
> >>>> no reliable interface, so don't offload it.
> >>>>
> >>>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (curren=
tly for ICH9 devices only)")
> >>>
> >>> I am pretty sure this Fixes tag is bogus. This is the introduction of
> >>> the e1000e driver which was in 2007. The ndo_features_check didn't
> >>> exist until 2014 sometime after that if I am not mistaken.
> >>
> >> My understanding is the Fixes tag should point at the commit where the
> >> bug was introduced. A comment on the Cc: stable tag indicates how far
> >> back the fix can backport. I didn't bother because this patch should
> >> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.
> >
> > I get that, but at the same time the fixes tag is pointing at the
> > driver when what more likely happened is that the stack evolved past
> > what the driver can handle as evidenced by the fact that the fix would
> > never be able to backport that far as the function it was adding was
> > introduced sometime after the additional stack complexity was added.
>
> The Fixes tag seems correct to me. To confirm it I reproduced the hanging
> hdr_len values against 2.6.24 on top of Fedora 8. It was more or less the
> same script, just with different headers. I can't confirm that it hangs
> the limited set of hardware supported in the first driver commit. Maybe
> Intel could test it in their lab.
>
> It's worth finding new core complexities causing problems in drivers, but
> in this case the mechanism predates the driver. It really has been a
> security bug for 19 years. The switch was enabling TSO6 when e1000e was
> spawned from e1000.
>
> The fix not being able to backport all the way to the Fixes tag was a
> choice. It has nothing to do with the bug not being a bug that far back.
> I'm not spending time supporting Linux 2.6 or any pre-LTS kernel, nor is
> anybody at Intel or kernel.org, as far as I know.
>
> The attack surface and details of exploit have changed over time, but
> that's not a story that a single Fixes tag can tell. It's the story of
> IPv6 headers.

The thing is this has had cycles where you could do it and where you
couldn't. My thought is that it would have made more sense to tag:
Fixes: f2701b185e05 ("e1000e: Enable TSO for stacked VLAN")

Basically there were a number of efforts to fix this in the 20-teens
as all the extra headers for tunnels is when this started to really
become an issue. In addition the driver ended up being moved at some
point between so this likely went from being fixed to being broken
again in a few cycles over the years.

> >>> Much of the complexity that enabled frames to build up massive header=
s
> >>> wasn't until much later when the network tunnels and OVS started bein=
g
> >>> added.
> >>
> >> The repro script should work back to 4.10.
> >
> > Okay. However, that still only goes back as far as 2017 if I am not
> > mistaken. The diff you are blaming is from 2007. I suspect we should
> > be looking at blaming whatever introduced the ability to push the
> > headers this far as the driver itself isn't likely the root cause for
> > the issue, but instead a header change was.
> >
> >>>> Cc: stable@vger.kernel.org
> >>>> Assisted-by: LLM
> >>>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> >>>> ---
> >>>>    drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++=
++++-
> >>>>    1 file changed, 33 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/ne=
t/ethernet/intel/e1000e/netdev.c
> >>>> index 6f85dab5c55c5..370776657d100 100644
> >>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >>>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_devi=
ce *netdev,
> >>>>       return 1;
> >>>>    }
> >>>>
> >>>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> >>>> +                                          struct net_device *netdev=
,
> >>>> +                                          netdev_features_t feature=
s)
> >>>> +{
> >>>> +    /* Do not offload packets whose header lengths exceed the u8 fi=
elds
> >>>> +     * in the descriptor.
> >>>> +     */
> >>>> +    unsigned int hdr_len =3D 0;
> >>>> +
> >>>> +    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >>>> +            const struct tcphdr *th =3D (const void *)skb_checksum_=
start(skb);
> >>>> +
> >>>> +            hdr_len =3D skb_checksum_start_offset(skb);
> >>>> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> >>>> +                    hdr_len +=3D __tcp_hdrlen(th);
> >>>> +            else
> >>>> +                    hdr_len +=3D skb->csum_offset;
> >>>> +    } else if (skb_is_gso(skb)) {
> >>>> +            /* Work around untrustworthy header offsets in this cas=
e. */
> >>>> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MAS=
K);
> >>>> +    }
> >>>
> >>> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> >>> the frame must not be TCP/UDP GSO since for those normally the checks=
um
> >>> and offsets should be populated. Have you identified cases where we a=
re
> >>> seeing TCP/UDP GSO w/o the checksum being set up?
> >>
> >> It looks like this particular case is never reached by normal traffic.
> >> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
> >> hostile or niche setup.
> >>
> >> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields ar=
e
> >> used for csum instead, or left zeroed.
> >>
> >> The transport_header field is unreliable when a packet is being routed=
,
> >> so you would need to parse the packet from the top to find where the
> >> transport header ends.
> >>
> >> Rather than walk all the headers for hdr_len, it seemed prudent to jus=
t
> >> categorically deny offload for these exceptional cases. I could be
> >> convinced otherwise.
> >
> > The point I was trying to get at is that the stack shouldn't be
> > allowing those sort of frames through in the first place. Basically if
> > checksum partial isn't set the stack should be rejecting the frame for
> > UDP/TCP GSO, not the drivers.
>
> I agree that this patch demonstrates how obtuse it is for an
> ndo_features_check to reliably measure header length, which is something
> that several drivers need to do in the hook. The issues being worked
> around should be fixed in core.
>
> GSO without NEEDS_CSUM is the biggest offender, no driver is checking for
> that in their implementation of ndo_features_check.

The point is that it shouldn't need to. It looks like this is
something that was broken over time to first enable FCoE and then
GSO_FRAGLIST. The way it used to work is the code required
CHECSUM_PARTIAL only.

> Using a potentially stale transport header is next in line. Several
> drivers are getting this wrong. I'm working on a fix, a simple reorder.
>
> >>>   From what I can tell it looks like the only valid cases for it not =
to
> >>> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame a=
re
> >>> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> >>> anyway.
> >>
> >> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e
> >
> > This is part of the problem. It pushed through the ability for
> > CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
> > reverted back to using CHECKSUM_PARTIAL. That is what is partially
> > what is allowing the non-partial checksum through for GSO frames.
> >
> > I will probably look at submitting a diff for this next week to look
> > at limiting this as there are a number of drivers that already expect
> > all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
> > start processing the frames.
>
> That would be great.

The one thing that it should change about your patch is that you won't
need to do the clearing of CHECKSUM_PARTIAL. Basically if that isn't
set you can assume there will be no offload requested as GSO will not
allow it through unless GSO_FRAGLIST

I will try to push my patch out sometime today and try to remember to
CC you on it.
