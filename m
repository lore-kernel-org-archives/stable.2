Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3F51FCBD
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651740; cv=none; b=I12RdCjGbWhjnKNojF6o9phhnQiRIkQQdI9JnCP8ag8jRjk+bK+QfIjnat+8YBkgf6Z6mWcvCDWmdl+SbS+dD1M/mtaAuQdWhJD56/HC3PEscsqoMVuDMBCRg/O1LCn7DK7rxm7AlKCHjceLwccY0RkeUMvZn1h8tCsl1HRR2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651740; c=relaxed/simple;
	bh=NAsObRyll4WV6QYy9rKgLDobFjajI231zXddko/aXE8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pKAHJ6tK/dOsMxPLrPilxK1Y3neDb2CY1O4GCgfDj5faQM7hSrzj+3fCccwRJJmpwZGnZyGjSVquEMowm5TE6u5zYKz51TKHrGZ/mFGBGkbQolsnc/hkAXRvS9ww7sgTHmWLBhjlo6liU/8y9htv2VLCh48A3T30wNcGZ885Gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIzwt6Da; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIzwt6Da"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e56a1fe83so724849d50.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789651737; x=1790256537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sAeZPfLxO8gIQtw5sZuH3fSTsOPDUndxs0gC4xI6QHw=;
        b=AIzwt6DaGWdkrsP+WPfMtXn+lcvGLyBCfA/tMUdWSveQy62wAGF6NDg11ujcOhHKbM
         b0+EKsHVGdCOKHc7SMrNPPqgmoAoqYHLnPtCHfhCXByPYW61VX5aMEGiUVBsz/dtAuUK
         uwyjUQ6tr9GD/B/UHylM6JlocVwx+D/YhHjg2gIS6yHMn8ZI0EgiuEgBqY+Z9F0OaJke
         S3yvGj+kIoKTlriPwv2XCRIEvHOvxUtIDqHvEahHBPTfQ/uI7egMScd43UDJVjQYizjv
         9ZtuRvuVNTwAXIhT9xDYHKuUJC1ZRqTnksVChrldtyX58Vll8NYnlzqvMifWQvT4Kp8i
         DWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651737; x=1790256537;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAeZPfLxO8gIQtw5sZuH3fSTsOPDUndxs0gC4xI6QHw=;
        b=veZhNLeHiTriSJZ/azXzjPKVkdIXsld4RyeNl8Iw9Flax6hOdICX9R9K9bXpJPj4V+
         Ih1ceuzFBBQOB+3k9iS3JQxzTY0hjHAXxgkQKxa1eaKIJCeoiRj3RIhDC5dlRjUhXqb+
         /fgiLwPvlz8V8aM8FxyRAq3gTdLhPRd8Xn12oFN8bR5HehV36c8qB/GpFTGq5LxZkIis
         gnmbNwhoMKE4V3bmLgtu9Oq6WEajhdnGRHHlJA1vENpanVF5pDaV3B/FmQGOpFUAflLt
         2piXAh8jpvPm+f7YZxDZxf6g9LisQXX8TZBq28N1I9mQ9C7bY45To1qV9/iiKgfT+gJB
         1ETA==
X-Forwarded-Encrypted: i=1; AKwUvBzFYFEvS9VlC51xL1EloX3Klq1at98fWdc1kX6pePBhz9mKccRoEec6jyF+jXQd2CRkpxTSkkw=@vger.kernel.org
X-Gm-Message-State: AFuF++nPOOTb46mt1X1148ld6Ll8kdKhP34EdR25B2dD7yHRBrEdEagV
	7lCwffhUv9fTfnAtn5zLGm2Mv/A3YAIer96SXS/1BVkASnsAq2IckWci
X-Gm-Gg: AYBFou0/W0HV42jX5HOs2iqhU71/HuqdYACHs5cNWVWI1nnZmmBQKyaOVk1wl3d6sIE
	/DvRNFr3RSKPsZPm/nWEpgeSV3JjUUG+8JYoh7gDz4kdcD6x3yszES0fBtspAdPAY+YBCnevpeA
	vCLaTsT6DNt4l05nlDn1oVFh9+omMKGB9K/XmeScwyGySR1kYcUhgRfDrLAxViF+8uPRTV0ffbc
	8iOu9uGX33jzfBhSobTyNbX3oz+g/beb7SUnBPEiB2G2vHfmuktnUpsEROh3NpDPVaigLU+xxDi
	ynUvg2KHufCcvizds+amSDmyzlFkI5vKPb33P8WHi/P/CG/QX6h3lDucLo78lbVM4107ShfA8C2
	srB6hjuB7ZlVS+hJUsjHRHLkQrhniwShc19r15vyrqgaPkgTTb/7alBIkKaIPeYaTKQ5w+eiJq4
	9FvbgYB9b6/h3mrdKMkGKbU1MOm56RMWsw+wkhNzmP+woWzP01k0z50vFnCTnvXXpLwhBx1zdta
	Nnnt8UF+xIhLcnvvnVjOBLt0UmVpaPijjiRmSSfvah3FEAVVQPq
X-Received: by 2002:a05:690e:11ce:b0:66f:c719:616a with SMTP id 956f58d0204a3-671631be447mr2244247d50.3.1789651737398;
        Thu, 17 Sep 2026 06:28:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f79a963sm2544539d50.20.2026.09.17.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:28:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:28:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>, 
 Katherine Leaver <kleaver@janestreet.com>, 
 Bjoern Doebel <doebel@amazon.de>, 
 stable@vger.kernel.org, 
 kylebot@openai.com
Message-ID: <willemdebruijn.kernel.217ba36e55cae@gmail.com>
In-Reply-To: <a0b83186-7399-4d79-8226-ff43611184d7@redhat.com>
References: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
 <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
 <a0b83186-7399-4d79-8226-ff43611184d7@redhat.com>
Subject: Re: [PATCH net 2/2] packet: use ubuf_info completion for TX_RING
 packets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 9/14/26 23:37, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > tpacket_snd sends skbs with frags pointing into its ring slots. Slots
> > are released when skb->destructor is called.
> > 
> > A call to skb_orphan calls skb->destructor before the skb is freed.
> > This can cause the slot to be reused while still linked into the skb.
> > 
> > Switch to standard zerocopy completion (ubuf_info) so the slot is only
> > released once all references to the payload are freed or copied.
> > Restore skb->destructor to standard sock_wfree.
> > 
> > To prevent userspace from aliasing in-flight state on shared ring
> > slots, allocate tpacket_uarg per packet, rather than per slot. This
> > adds a small allocation to the transmit path. Use standard kmalloc to
> > allow backporting to stable kernels.
> > 
> > The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
> > reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
> > the ring pages.
> > 
> > As a result a slot is released when its payload is copied, which can
> > be before transmission (e.g., in skb_orphan_frags_rx). Any slot
> > timestamp then reflects the time of copy, rather than of transmit
> > (or skb_orphan).
> > 
> > Revert the now unused previous skb_zcopy_.._nouarg infra.
> > 
> > Reported-by: Katherine Leaver <kleaver@janestreet.com>
> > Reported-by: Bjoern Doebel <doebel@amazon.de>
> > Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/
> > Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Willem de Bruijn <willemb@google.com>

> FTR both the 'high prio' sashiko finding here and the mid one on the 
> previous patch are IMHO worth addressing.

Absolutely, agreed.

I hadn't gotten around to responding to the bot yet, sorry. Was still
reviewing the options.

Simplest is to enable the deferred worker that Kyle also for page
backed rings.

As the commit says, I'd rather send something much simpler to stable,
but after exploring many paths did not found any with fewer risks or
obvious regressions.
 
> Also I'm wondering if the extra alloc/free is visible in perf figures?

It should not, compared to the skb alloc. But I don't have hard data
on that.

> Out of sheer ignorance, can't the ubuf be carved out of the ring?

It can, I actually had that first. But that has more risk. Userspace
can overwrite the ring header status to TP_STATUS_AVAILABLE,
possibly corrupting uarg->ubuf.refcnt. It might be fixable, by
incrementing refcnt rather than initializing to 1. But that is less
obvious(ly correct).

