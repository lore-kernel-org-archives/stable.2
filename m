Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0E1B6D08
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331853; cv=pass; b=D7jTOe9+KJl1AGbnC/G+L+S1CfHtVh6+iRzdrElHouFTxsxleI/TQGczsx5KkfGyVUdyIeupf+h4seGIs4KZ69iAaqrbhvXgd8XneR0SnHELtmjvPDxt+M3FlvyfZd+ZIoEGSIEY/wtK0bVn6NfJheu7PRk2ns19QN5dJQI3TrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331853; c=relaxed/simple;
	bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht1raN6cZucdks43jUqPGu+t26UE5WOiu33s4JG3bX1Hny/fQ7g57acX5GST78eSvqkLU13Gc2KlTfSvrVdoU5ruvnLp2vQJISN8igym5VRMMJIPt7eD1+F2ZSpggJbmZSKN4ihmuUeExfEsHaWyHOBegYplIvCQfluuY+8Dkx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5H5xcDU; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5H5xcDU"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a9cb66f7b4so1966919a12.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789331850; cv=none;
        d=google.com; s=arc-20260327;
        b=ZgpPqXO6pbY2mHqBe3mGOO0hGX7LFdT+VlAeSWjy/+5ctZPawBE3JMZ5hWDsJk4Pbb
         33ySvwj4VpOGbOMHSeIlg9zfTJHR5QinXi0tBHpNSGq2hjitSDxhKIyZzSclz0x75ULd
         9SufrBqls7GD8+gPyP5eQPrTaI7F1RtQx3zp7A3mWl33uX7jlYmdRIl0yc7z1pkVcBBg
         uMYzA4QScCOC+7K/AAT3fHmkK53U/cH2RlHNGtHNVCpo5EqLRZthlYsaxG8IjZFmKTqD
         IBFMcE5e1TJSB2Kau7XC/poKMKdJpdFaybaR8c/dM5aCYWaf4PKO26LAn65jXcQIkJPg
         tc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
        fh=jZZfHSEQqMhBNBzz7cW+XnmuEKCvi4FyctePgFyM7xg=;
        b=hH7NEwDOikBMWguLyLZsjpbIUAE6W8k7t8UF5U9sxuD6XBnirbTR+Z9AS1Bc0x+TMV
         HJzydAmWwiVqKSruDDjfNmmPsbzNR6bYZzRAOi57YRiRr9T1Rv7CAxfiCibJ+Si8/YYI
         MnQrZSefj2kUv58ZKuI9uEr+PWa0SZVWKIRrwCDm/zeT1QOhFBQmp0RjAuGPBHxVfqK+
         Vzxx85tKyHuhjh37a/60F+/ncbApopj6g+ck2FhkRU7Nbhlf2Jmqvn4G+QEJbH6GrPC2
         X5qJTgr3BW7jzh923QgAZDYzUAwz4hXSykK8xcCW2o8OuG2SO5+MFEKn3K9Wt6Bifs26
         TQjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331850; x=1789936650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
        b=m5H5xcDUrwwVasUqj64QJsjFN3s1Arc/cnnAzxNf7//rS/LqvRgSAW/AAR/ntc8/yH
         cnnjRhLtnEMeBmvwd9lPjpboFw2wVTMOEIQzYX7Ed9dbcnZvCrW44ax9hoKsxgBg5DUw
         zf5o2CSJ3qJXx2qVniaXW7w1mY87bJynfMFpPzRyR1VJoKLrIHmja0NyNsEYfVeJZTjR
         uZmNBRj+u9vjjn8njjPyMwsKtFugi5jN5Gzg7tpEdgFzsDEU3Zt3qB9MU7mM3psRCiqX
         uqVPRT74pXYRY78O/SG94h6wuuQgH+PEkmdjEXufjLXANE874AuP8siuTIYjA2h0Uyyi
         89Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331850; x=1789936650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
        b=A1uRo9G9yX8MSoFvooKZDUYNMMWvsBI3KkT3KKqu05lZRXUeO3FofYvtY78xDWrSFB
         LoFXBb5IyS5swdWEUbflPNUWS8DhG6sCiUAPJgyQzFam/emckhWBciP931a9UkdjuhRm
         DxSPtyDMzfexQ6kyP7hoEd3q3U587MCYhrC5JvKvfO7D+blDtYIjPOmfVI0lJcgCna6B
         uK60b0O4XT5FMsL5sgWH9zFdYHPWLXXSnGSS0cufZ+5lGz34E+YByltx5scec3pvrBSf
         ukBAmg+PQZHNUTB0IsC6kz1e8eMs5gHB5NVCzRbrSFmRGXlRbPuV7FrEqMaro26CuFhn
         qWxQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0wU606oq4u9dc4f3BVGVb5GxkTWALCASAradOsxCSVUuCbDnuvWdUpQ/1CwY99xb3PrW4eZE=@vger.kernel.org
X-Gm-Message-State: AFuF++l+m4qeTVN6kgJIrmWMQ2wjq6XKG6vos9XoWSHW1s6LlCk2kFPa
	A6wMG4kSXToVFxyy38C2jMNZjWhGvIwOp6E3iN0ghyW9GySBxijimKvzxIUhuRHBixh9Ujg9VLi
	vEg6t1TX+Iazsdc/cPfbr9Yzt1Qddlg==
X-Gm-Gg: AYBFou35pBQgxQuFoB8YXvHdiV23q4fvBUDv7vJSPly1+/5K8aV6RZuD1kT/ZiJRcsf
	mdRls+ZSH9JoTuLoXhDDIr5hkClglTTOkxCjsTTnL+OnE1xbdaZZ30zLaiotpHal3W+ofTJtJPt
	FJq9/beReRS2Q9RcJvOaSWgltWbIX+gbKF7FOCCmJcAU8Bt0Z3leIXlo+KNEzguXwOtWMnP1dFX
	Y/XglPmfxoDaWZ5WZnY9RrvkgReMoySBkUTObgPfMXk7RHl52xJAAp6Ccl/AZ1iQbKet3X0iuOu
	Qyr46erpkvKSf7oTPNDmyvsJgukuOTdNyAd9520QCg7vNxTB+oVUq987asRse9acvswp+EjFm88
	mcbFLjb5ygE/0AzhRkfKycJUw13qTL9+5JHBFNx7wMVGtTOxCy9Spf61SU2gMNCvrog==
X-Received: by 2002:a17:907:9288:b0:c29:583a:c291 with SMTP id
 a640c23a62f3a-c29665dc5e1mr700951366b.21.1789331849719; Sun, 13 Sep 2026
 13:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731161740.44955-1-mhun512@gmail.com> <20260910231400.31919-1-mhun512@gmail.com>
 <20260913143218.GJ48209@horms.kernel.org>
In-Reply-To: <20260913143218.GJ48209@horms.kernel.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 13 Sep 2026 16:37:17 -0400
X-Gm-Features: AcwNN1WyHHF9rKOVVRVH7Q63v4FKYTOEzfxobu1blNdd3woeEdHWTYWSY1gACZQ
Message-ID: <CAGEsz8EWyKiZAiEK+D1O2HA6Y_K3AAmebmG+O0UStvwXf0SQ_A@mail.gmail.com>
Subject: Re: [PATCH v2] net: 8390: pcnet_cs: release PCMCIA window on
 setup_shmem_window() error
To: Simon Horman <horms@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I'll drop the Fixes and stable Cc tags in v3.

2026=EB=85=84 9=EC=9B=94 13=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:32, =
Simon Horman <horms@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Sep 10, 2026 at 07:14:00PM -0400, Myeonghun Pak wrote:
> > setup_shmem_window() acquires a PCMCIA memory window using
> > pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
> > ioremap() fails, the function returns without releasing the requested
> > window.
> >
> > pcnet_config() treats shared-memory setup failure as non-fatal and fall=
s
> > back to setup_dma_config(). Probe can therefore continue while socket
> > window 3 and its reserved iomem range remain unnecessarily held for the
> > rest of the bound lifetime of the device. pcmcia_disable_device()
> > eventually releases the window during teardown.
> >
> > Route error paths after a successful request through a new release labe=
l
> > that calls pcmcia_release_window(). Fold the existing buffer-verificati=
on
> > cleanup into the same path, keeping iounmap() before the window release
> > when a mapping exists. Leave the request failure path unchanged.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
>
> As pointed out by the AI-Generated review of this patch at
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910231400.31919-=
1-mhun512%40gmail.com
> This patch seems to be more of a cleanup than a bug fix - as noted above =
in
> the patch description, the resources are eventually released anyway.
>
> So I wonder if the Fixes and CC to stable should be dropped.
>
> > Assisted-by: OpenAI:GPT-5.6
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Clarify that the window remains reserved only until device teardown.
> > - Make the DMA fallback and continued probe description conditional.
> > - Avoid claiming that every request failure leaves no resource held.
> > - Restore the surrounding indentation for the new goto statements.
> >
> > Link: https://lore.kernel.org/netdev/20260731161740.44955-1-mhun512@gma=
il.com/
>
> The process nit above notwithstanding, this patch looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
