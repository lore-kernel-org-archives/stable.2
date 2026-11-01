Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793503217;
	b=4nCSMT+Agq83Gu6g6Efl33y0mb6bY2cwLuKutzDecT4gYyolBX0CRomeYYHISq/VQeqB
	 FoUxIsyEMHuhvCt2tYmpbWgVqIyVT2tTBU1YUyIdttRhexoZcOtQINd/zV1gSErQgv4gL
	 0BZYjtjXGeSyci46hvfT9eEs/sYX77moeGXnc07ehu7uN6rD5a8SqV1WEaqOm/a6lHs+t
	 oxDGVjKI1lgg6nt8Le1JaGVqWd7D0XoEtidm32LyusQNdB6V+Gk/dNCR7P7xm+2Gkj7HM
	 qq8in4+6UzAQNv86ciw0p5kmLehFucrxN+sCWtTljIysp6v4rBC4sGLk5wqX65kFs/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ROyck2tv4dX+E4QrQzUDo16ieFP08+/ueNOZlrK/9dI=;
	b=Uj5o7UCFK48RDUDJt/YYQ7J7cgx0N3aoZwhwI/oZ3fvMQ3y4TOaVLyJpQpAH7SmD1/zn
	 nHZRJ1kv6npILAt8/gxsvvEwPuttb/I2r7UMxtR2TTDpxIPpCV/i/nD5bPMg/Xg+AB6uj
	 CyNm7YGGJuLh81F0NmZl4ESpcRzuje9HTGZNVL9R3TgOYCO32f2a3uPH4wKglkEadwkUc
	 zDfWuFgnD2ipcmsuOgKqIRdT2osavVorL2u0TuOPwLvSQR9CKmUpCFQtCJNiePL9Iga2L
	 lZ0OutDPqa8ZQjqZp/XJRB1CZ7g4r+cG7aGrXLyWOWz73FmzFpVJTklCTjTfZmu46ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oa3G1JPl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C091606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 03:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C091606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oa3G1JPl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso1751089e87.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793503214; cv=none;
        d=google.com; s=arc-20260327;
        b=Rbkw5DSRyTXwdGPsJLxkn/yD48RgdSERFzf7/GR4Ct9e0Bwj5Ztwh6QsH8obq+ZUJp
         qL3HUagvei57DvMjQGrwxvCaWiJuJxEF/gEWVuje3uO7v08L+tdTGNUttOECGtI5MDR4
         CHdg2Thwf9YjGC1nKLN30KMMNT4t3sgwYgDh1cbjtXNpPSHb1nKFtVsZlgktGs6LvDuG
         GG1CEB3GKjaIgAaUKvMs6IeMArgo8Y7PVFOMaZzDWnvuuSdD7V3qm6mp1ERpulW1xQ0g
         uT53KwbeYchcj+1L9VuuIbn/bCaEdXJMsPeVVhtC1rF53Ku724CwaofeuJcm39PWeJh9
         NpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ROyck2tv4dX+E4QrQzUDo16ieFP08+/ueNOZlrK/9dI=;
        fh=BJhNkfCqgi4PXMt4JyWCwOYqmscpQgjttvjSBfPAlNc=;
        b=U5eZHSNUdpggmLMa8qbwviIb4X14pU2GCN5P+Mqd0CxUIaXdT7JY8TKzL/aSbuJPvh
         sxo/u+Yxe1rL5KjnWC9niNshPZ9IZcpCtRdARNDtqoP2kpfXizfkjX+6ya4MYiXCOxxp
         bf11rPBS93rdIAITEX8+DSGUyHt9WflIowuN7/I9cPrW9zEgo7iNmVwZsJDoaXZrcsBj
         el3DUmTOZpVZS3LSlXEmOEyxSPyjJMIYoPqxCnNypHCEsEcm+xj7Z7YODup7170XIDg4
         sbzlKroZpLKb3iKT3xFO0WpyhNYYOp/qFNINZLIWUBNBDhebngiR4mEzhrTu66+jooJo
         dCqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793503214; x=1794108014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROyck2tv4dX+E4QrQzUDo16ieFP08+/ueNOZlrK/9dI=;
        b=oa3G1JPlsawQocPoqkdwzQShpAXI+/vYQ/Y1aSrO8C933VrvmwyzRpgrrWN0Slivth
         0Iso4VwLUZlTiEo5a6ZAzX5z2y/3/wFiLcoXjXk3i7kxh8YvKoveMaeZpFxvgR0amKJ7
         fWdxu8guTa2WizMzJuOqnSfIpJdsUZu6SmtVNYnpzEbn4U5tq8P3DrZRo8DpgaFSFW4J
         0cmntTFk53h5tApdkstueJcBKtmVEDD1wo8rMXC2riEYYGfU8iNW4T90A6WadYlXRz2o
         UwDfdjHywNAB+HH6KoSuiDQsn9nIi2g/Tx8tifmVEe/FXnojqZ4AE+MjAktGMjR7g4Mn
         LlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793503214; x=1794108014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROyck2tv4dX+E4QrQzUDo16ieFP08+/ueNOZlrK/9dI=;
        b=MVlsGVgEPO6ljvPLLxFugaeBs0QJNRTfnidkG3OVvIBvkPM9IKZt3ECcSxr3s4exXv
         0padYxXo7zR7KlOVnFsHgCUxVPG07etFdNFgL/GCdinLLwe1ZGMo+Wj+PcjEBktu1Y2B
         qqr/Pz7FCO9BZbrMyesE7lKgddWfBLVza1Rw+/jIxG/LjiGubSWHA1ZxLKDELpg6rYRc
         XK/PWxTjwA3FDKbK4XC0GVkECKJsWOTT981WQft+cP6TNhElT15tlttznQdD5misd/C9
         t0LtXJsAFm/k5PBa0NTAfLCv39A1i9H7yRel7CbhM7qyDTcyhLZ/HN+JXKBBV/m6rlPT
         2KDQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+1xrTJjGbx+pScmFFaWakd892mKuvO0cb4HI9YK4P/3I/C75E0Sne6ZqExNu2qBPfi7s/DSo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN3NLbtu5zv0SaciwCXELOK6GYa14zvHo2FoTdaEa1fLEZ3Ti2
	WD5E7nTye+VBvW+d84apz+oyLIhjc9GSrTTSBSc2aNFw8wqJKRowM07iBS0/2dr8nVTpfVddOzY
	DzDqBtc/sUEptljesIcTBK3BsiNmyh8uH2NMWDLXR
X-Gm-Gg: AYBFou2NsGW5hsTqOcsdTnOWlmLztwbYpJaZ4bF2EtbCYjuTxHUoOY8VQnA7C/h4kmD
	6D4VCUFiDJ0ZesV8JH4/0y5rFs7WZUm9azc/xJPsz0+O6jPAw415Z5gwl9Bsnz1I0uGj/39GrhL
	Y0kRLfoAT5i2IVFuBBOsJ5uYcZvwRIZgEmbwH1dL0uihxyHHhDMIi9F1TopM3PDEiObanFqR+sS
	k2KQ2r86Q1ZFHvXatVgxrr1t0hqNL2JaimeBidoMHgdvB2HkzycK6j5YCWaUt/25qFtYj0qjU84
	DliEAxo807gaMJbG/vB9raCt3rkyoVup+4ST8mg5HaR341+BCYVBy2HMGSUiqx4ONOCTGSaPKeT
	WNONpgqtGQwvUS6JFhdsT0ieW5JGc46D3beQHKnJD6Boa0ZWqtzjntBg=
X-Received: by 2002:a05:6512:3b0e:b0:5bf:b5a1:390d with SMTP id
 2adb3069b0e04-5bfd9569843mr2136047e87.27.1793503214478; Sat, 31 Oct 2026
 20:20:14 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031203540.2282507-1-skhawaja@google.com> <20261031194058.d3bd25ed950e5340ab595f07@linux-foundation.org>
In-Reply-To: <20261031194058.d3bd25ed950e5340ab595f07@linux-foundation.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 31 Oct 2026 20:20:03 -0700
X-Gm-Features: AclHuK_zB1iHzMf0lJZAS88jOk23h0UPCqaNcjm28FlTC1Q3GtQOHifFuWxluKo
Message-ID: <CALCETrU76ThzLDbUfpoota5=xcoOS4aZrwgK2B3ELkYcFOjGJQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: check folio->mapping under folio lock in memfd_pin_folios()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 7:40=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 31 Oct 2026 20:35:40 +0000 Samiullah Khawaja <skhawaja@google.com=
> wrote:
>
> > memfd_pin_folios() pins folios from the page cache without taking the
> > folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
> > its refcount check while memfd_pin_folios() still pins the old folio,
> > and the caller ends up with a folio that is no longer part of the memfd=
.
> >
> > Lock the folio and recheck folio->mapping before pinning it, like other
> > page cache users do. If the folio was removed, retry the folio lookup
> > from the index that was removed.
>
> Can we please include a clear description of the userspace-visible
> runtime effects of the bug?

It's straight-up data corruption if you manage to trigger it, no?  If
you manage to race a memfd_pin_folios() against collapse,
memfd_pin_folios() will pin the wrong folio.

Fortunately, there are a whopping three callers in the whole tree.
You can hit it from udmabuf or iommufd or memfd LUO.

The former two will direct DMA to the wrong folio.  Fortunately it's
not UAF as the DMA will be directed to a folio that is still pinned,
but it's the wrong one.  DMA reads will read potentially stale data
and DMA writes will overwrite that stale data but not update the live
copy.  (The DMA will not be directed to some other application's
memory, just to a leftover copy of the calling application's memory.)

As far as I know, the effect with LUO would be for stale data to
reappear in the memfd after handover.  With the patchset that started
this whole discussion applied, I think it might result in misdirected
DMA to freed memory (I do not stand by that claim at all), but that
patchset is not applied.

>
> > Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning =
memfd folios")
> > Reported-by: Andy Lutomirski <luto@amacapital.net>
> > Closes: https://lore.kernel.org/all/CALCETrV5eqg6d9=3D+BQhCpRwBNe3aCQiu=
t8vxPBs8b7PToqjaHg@mail.gmail.com/
>
> Includes the words
>
> > The issue is live update doesn't preserve those background punched
> > folios and now we have created an UAF attack on the kernel across
> > kexec if you don't do something about it.
>
> Is that the extent of it, or are there other effects?

I *think* that the UAF can't actually happen in any upstream kernel.

--=20
Andy Lutomirski
AMA Capital Management, LLC
