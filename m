Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855F4A68BC
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883442; cv=pass; b=CIQysNHtIFVtsgwQJz/KAYNtP56Uw7Bd4+0moh0Ht09i03vIwH+WFWwLvzGxcflpuTAgZcPnrVnPW7tV6GhkHmR6GgcmnDtc3oVqyD6HWgZ+qWty+YIMe3C5a1VYSIHBfBWD+d31SC+ALBWElBPkXKTEroweuVZBhaeal5qLd/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883442; c=relaxed/simple;
	bh=ptnsyPxUt/cOX3q3KqSdQ2MO2NStPoJf6fRFmBAC6xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkkKVzVwgH6oFfkgXVvZRDH6gQO9Tjj8uQBkR/+0up7aTpQoTVKx7ZgTT6Z4ZgQ4xb2AWUnCpOG9YP3vsL0XEXPBGWwFSXXWzW9dH/EDHfJOLt89/U8VZhtk+OkHEc1xYce/Ca6UM2MTBGi0Kj5R2hRWQMM6hTts/rJK6y3NNUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN/czutE; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN/czutE"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso1884832a12.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 12:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790883438; cv=none;
        d=google.com; s=arc-20260327;
        b=opW6mWUXcAhK8La9V1cZcEKWYmjMmw7nVUz8/jnXowovoZxmamQX1FAshF/hNvtjHu
         fP/2aiNXPZUfFfFcBYOvdehUbbNsryybxMaerlcKNWOxKMaA/w9Ql3wijTgwWelqy2b8
         rZZ0oKUUAbUH281ioIBYlMJd/qCjKtEbmrFVEalUfqPhj+fOfv/4pI3AWQSvnqrfYMpP
         ce1fwk4z9dlo8Zo9WgqDN56jUgyQjkdU02VJVlY04bCJXRpqxIgQuk37dz5ZqQf55eff
         AU7GqPydM5/WXNEUf88dCiBdpghgLl2KIU9cbnpgWXubSZQRccQOhtMkxtkxscZ+aZ4T
         RIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZGfsv2fyA8/iLkosK7wQlUAa3cwLnNMKOsuW5K4GSk=;
        fh=BgkelpfrVu9Efk03koRhjlR33ByxyRAc5lyo25YZr+U=;
        b=KPuT3lkgYLjx43P/6GJ3cfz+WLwpC1gR9+GOaJk94t0kVsSyVDFhloMucyxU/r1P0f
         aUF5cs6baqETrZL91VSwQOd6I+5+9x4OVcEOkeoCVNj5cOxxjJWWUhD8Z2K5aYaQn1rp
         BRih6ilMuSX7hAg8cvIKt41/Gv/EOx260poeVhdJ/gi9DJTpirESiV/WoeTG1WyHFPyw
         rcS5tIsNOLMt/D9Bdtbdg8FKfky6IdNU+6KJV6ck6KzJwAciG3ZMaYjjvoq71e1CZzde
         GNydmTD3Hcttv11KvvMSvFCy3feFshXpZ/iuognC+1XvgoQN5xzB56aolh7phkMvW613
         zUSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790883438; x=1791488238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GZGfsv2fyA8/iLkosK7wQlUAa3cwLnNMKOsuW5K4GSk=;
        b=SN/czutEnJ4xCabuTXrEzlXlby4+HSNTMKK6uoiHQCaUTvCv9igElz4eNqT1GaWDJi
         X5h86eKxF/pGDx//KWszXGh4yTaw1F+2j4HGkrjbLvmae4rou7RvT4evgWh5VqHKgSkJ
         t7JjlTNw9RbnRrGF85pqKx4OCrAB28JDQWC2BIXvlMOJRGuAbSxNRzPxdTD0HXLrvKB0
         cixnsfsd7lpioQCSM8OX4rQrgJX4ejV0Xea6WoXyD+dayOqSaK7ftNjpNbeDTDKq3DtJ
         /xL23rKP4khnxL3o6MARvkes3KcsTX4GOW0Wpe6KGbL4XmzanciHwVroSiiETgdtj28A
         9PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883438; x=1791488238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZGfsv2fyA8/iLkosK7wQlUAa3cwLnNMKOsuW5K4GSk=;
        b=qyf26unJk7NjTPleok/K06eGtN1X+DcO4oWv+zpMLFVk70NV+0tNn92Dx4/XRbomXE
         IVCQDan3Wlxa1U71EVf/zI2/0SeY/G1ytOQtHTR7Kme/S3MEtPftOeIOu01Hf9+sQ2CR
         zfH/1T1MM+JI9BrqY4ZPfdhZnW7It+F4yI8JEv2zN2NBgRgcl2vHQ4bZ6hUHMWn0rDXS
         nryRb+baLX/AQZ2nnbJXPoo7CMaWU1207wckc8YDC9cdrl1U8dt/iIRhgEplFnQd9pt3
         3TdnlBScRADzB2VaZOw4xZdXjYcEPAmoP5pVRMEt4zAMRNzpetZsuMl1V+2hisLb/ZbM
         5o3w==
X-Forwarded-Encrypted: i=1; AKwUvBw2T/AZ936aWDEeRD4DWnXthyGHDXuBZLQj8s0xweMz0BSI5on/H0psH/wCpq2HDLHYGQ8LTcg=@vger.kernel.org
X-Gm-Message-State: AFuF++mKmDAzl2EPFipx2NsD6vazcO25WxS0Arta3MAJ9fLWCYm3PGVT
	cHtM2qXss5e6Um3ee19SeM5iOExS8hqcaXcD7FO4ThOE1gaBgcX6t9qFxIVLKhod6Q2yQdYUnDP
	WxkBoavdoiXTkEvwEWHqbcRxYI6oStJI=
X-Gm-Gg: AYBFou2+/Z38kU0i4plb4TbLPCLVMEvo8+kvGzq/PfDQ3nLq8xiqOvBEM8WqY6UE1Ro
	agZDIRWGPRGGZ40zW0wnf91Fm7Yk5TiwiHZwp3quK17k+MjAkwowKBRi+B00W/JqqaZvdazUoN7
	V30Kxb+pBPkwpEI4SpY4MHShFdMC1iX314Kf0D9LiKSImNn6swpvfvSwxDEpM9FPloUuF6QmZbf
	vRdUTWpkyspn7vKbgQ+tCjKYB8oFCVNDKrnhFRoe2DHMvqLEOSLkS4pKKzTyEvIDqse/O7Cr24L
	nZxFjBh6mwNv0ObLStJjzNAK5BgFJmknoDPza0rXScElLiFN+jJELEkN
X-Received: by 2002:a05:6a21:e105:b0:3de:48ab:3b90 with SMTP id
 adf61e73a8af0-3e0bd247258mr230906637.26.1790883437836; Thu, 01 Oct 2026
 12:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001184529.502048-1-hoopyfrood42@gmail.com> <3c8de083-510c-302a-c053-2208a71ce688@candelatech.com>
In-Reply-To: <3c8de083-510c-302a-c053-2208a71ce688@candelatech.com>
From: Chris <hoopyfrood42@gmail.com>
Date: Thu, 1 Oct 2026 15:37:04 -0400
X-Gm-Features: AclHuK84ndP67yVDMOEWv_Z58TGHOlXFAAcbV6UI3AW6HMncQc5VrzzmEusBshw
Message-ID: <CAHaeJsSeqsE=cKheQ-4-O=OSt2wO-4Ryo3nxTkbvjYZUY=Or7A@mail.gmail.com>
Subject: Re: [PATCH wireless] wifi: mt76: connac3: check headroom before
 pushing EHT radiotap TLVs
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	deren.wu@mediatek.com, mingyen.hsieh@mediatek.com, lucid_duck@justthetip.ca, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:53=E2=80=AFPM Ben Greear <greearb@candelatech.com>=
 wrote:
>
> On 10/1/26 11:45, Chris Kelly wrote:
> > mt76_connac3_mac_decode_eht_radiotap() pushes the EHT and U-SIG radiota=
p
> > TLVs, 64 bytes, in front of the frame without checking that the skb has
> > room for them. It may not: the rx skb is built over the buffer with
> > nothing reserved -- mt76u_build_rx_skb() with MT_DRV_RX_DMA_HDR on USB,
> > mt76_dma_rx_process() with a zero buf_offset on PCIe -- so the only
> > headroom is the RX descriptor that mt7925_mac_fill_rx() pulls. A
> > descriptor carrying the P-RXV (group 3) but no C-RXV (group 5) leaves 4=
8
> > bytes: the EHT TLV takes all of them and the U-SIG push runs past
> > skb->head.
>
> Can you also increase the headroom when monitor mode is active so that it
> can report the data?
>
> Thanks,
> Ben
>
> >
> > Seen once on an MT7925 USB adapter in monitor mode, hopping channels:
> >
> >    skbuff: skb_under_panic: text:ffffffffc16f4a3c len:164 put:16 head:f=
fff8d4132ca3000 data:ffff8d4132ca2ff0 tail:0x94 end:0xec0 dev:<NULL>
> >    kernel BUG at net/core/skbuff.c:214!
> >    RIP: 0010:skb_panic+0x59/0x5b
> >    Call Trace:
> >     skb_push.cold+0x14/0x14
> >     mt76_connac3_mac_radiotap_push_tlv+0x1c/0x80 [mt76_connac_lib]
> >     mt76_connac3_mac_decode_eht_radiotap+0x7a/0x1d0 [mt76_connac_lib]
> >     mt7925_queue_rx_skb+0x686/0xde0 [mt7925_common]
> >     mt76u_process_rx_entry+0x2eb/0x330 [mt76_usb]
> >     mt76u_rx_worker+0xeb/0x2b0 [mt76_usb]
> >
> > Leave the EHT fields out of the radiotap header when there is no room
> > for them; the frame is still delivered with the rest.
> >
> > Fixes: 97d7ab9f51ec ("wifi: mt76: mt7925: add EHT radiotap support in m=
onitor mode")
> > Cc: stable@vger.kernel.org
> > Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Chris Kelly <hoopyfrood42@gmail.com>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c | 11 ++++++++++=
+
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/dr=
ivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > index 651fcd4..0ed8ee7 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > @@ -210,6 +210,17 @@ void mt76_connac3_mac_decode_eht_radiotap(struct s=
k_buff *skb, __le32 *rxv,
> >                     "Should push tlv at the top of mac hdr"))
> >               return;
> >
> > +     /* The TLVs are pushed in front of the frame, into its headroom. =
The
> > +      * skb is built over the rx buffer with nothing reserved, on USB =
and
> > +      * PCIe alike, so that headroom is only the RX descriptor just pu=
lled:
> > +      * 48 bytes with the P-RXV and no C-RXV, less than the 64 the EHT=
 and
> > +      * U-SIG TLVs take, and skb_push() past skb->head is a kernel BUG=
.
> > +      * Leave the EHT fields out then.
> > +      */
> > +     if (skb_headroom(skb) < 2 * sizeof(struct ieee80211_radiotap_tlv)=
 +
> > +                             sizeof(*eht) + sizeof(u32) + sizeof(*usig=
))
> > +             return;
> > +
> >       eht =3D mt76_connac3_mac_radiotap_push_tlv(skb, IEEE80211_RADIOTA=
P_EHT,
> >                                                sizeof(*eht) + sizeof(u3=
2));
> >       usig =3D mt76_connac3_mac_radiotap_push_tlv(skb, IEEE80211_RADIOT=
AP_EHT_USIG,
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>


Hi Ben,

Thanks for looking at it.

When the guard fires, the descriptor is the short one: P-RXV but no
C-RXV. Most of what this function reports comes from the C-RXV -- LTF
size and LDPC extra symbol (rxv[4]), PE disambiguity and UL/DL (rxv[5]),
STA-ID (rxv[8]), BSS color and TXOP (rxv[9]), spatial reuse (rxv[13]) --
so with more headroom those fields would be filled from whatever follows
the P-RXV, which is the frame itself. Devin confirmed that reading. What
the short descriptor does carry is MCS, NSS, GI, bandwidth, coding and
beamforming.

So I'd keep this patch as the minimal crash fix for stable, and follow
up for wireless-next with a change that, when the C-RXV is absent,
reports just the P-RXV fields, making room with skb_cow_head() after
copying the rxv words (expanding the head frees the descriptor rxv
points into). The caller knows whether group 5 was present, so
mt76_connac3_mac_decode_eht_radiotap() would need to be told, which
touches mt7996 as well.

Would that cover what you're after, or would you rather see headroom
reserved for all rx buffers while a monitor interface is up? Devin saw
2.6 million EHT frames with the long descriptor (at least 176 bytes of
headroom) and none with the short one; we've hit it once in about 2.5
days of scanning.

Thanks,
Chris
