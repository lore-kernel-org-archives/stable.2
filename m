Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D435674E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908233; cv=none; b=dXSnx6q/AaoJxU4Y8/9ckW3dB9gYz+lOeC+BIORvFkvkcg1Jt3kqKNjZ5WDzVWObAekZcJOQJdxJ+Se47WIjZaENyEYPhRxr/EUA+8tzk/eceHU5JI/XDwnNBbJ4Q2TLrVfFZurxRJfjXNjZmWQB/kjLCaS2ccFlKSY0zgCyp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908233; c=relaxed/simple;
	bh=e2f4jv+vddGdp/+tAV76YfONq6iQs8Ulaik9rath9Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRwPr2YVIFPmcbB1i6mrwro8JS5z5+e97a31rhEJ+X/SKNZlUOFgNp+bYnPrQYrgYERreUrKCVcHsfZyt48pXsIeRrIJ0j+pPpLvH30YidyqczlyTq/VeZXxqE3etShRsPBYShNomvAXMXxEaAEvsvIUj9K4eHF+sRfPAVWd7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDbuOerJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWYjXYdK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDbuOerJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWYjXYdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785908230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlGRErAW413VLAmfzqbAojxRMBz/ChRXiAFusGe8Ptk=;
	b=RDbuOerJvtYF7ysgxkE5MUUU8lP2lb+mwqIwSYSnfvMveJ0M2ztMZexA5vRrqBEXP4XGQK
	Vy/de/+cufDNzcNlyBGdgJd3AzHxEpIg+/VLgjZXXgVybbNCl0BQysm3JK2jf/88rs64E8
	0tSIeuGILIIfsOK+wPECH4ohBuMO8qo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-xqGwCXynPvqNo0Yy_bMWWQ-1; Wed, 05 Aug 2026 01:37:07 -0400
X-MC-Unique: xqGwCXynPvqNo0Yy_bMWWQ-1
X-Mimecast-MFC-AGG-ID: xqGwCXynPvqNo0Yy_bMWWQ_1785908226
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so288924f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785908226; x=1786513026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mlGRErAW413VLAmfzqbAojxRMBz/ChRXiAFusGe8Ptk=;
        b=LWYjXYdKwibcw1AEuuPcjuRDqgD+rwh7IWaNRTzM1mvZdVIfP64AyxkdxaVjgWITBr
         24EwcLSZjw1QSOmmJ2O4PKSy3z7sboSYxuXO4gcueBmQX+fTJt1WakYUl/5gQqYZ8l0P
         ZDRMtWE966j+VIsgryOuhUDPRdxqhK7VIRPGTrJI1trkqhDp7ctB+cRvAFJTZNm5lmfC
         CqKOx3Oo2fgpPaSASG31o7tFTh5byN7fGkrPz6PG+616PUk1BZ/zrnBFpELrfM8dc1Wt
         yuhNr/T1xtvrl9o2bbHAV+pngw2WeRWGwndrSIQQziTqOi+abACw4TmLGtkfn9xmVUe/
         2RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908226; x=1786513026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlGRErAW413VLAmfzqbAojxRMBz/ChRXiAFusGe8Ptk=;
        b=RGHcYzRCxXh3MH4RtOYaVyGV90FkLvmd6QSkpLdz+LEGi8BvCNLxGflzsY+3be2NOU
         dakEI7k4y53ajxzp3RZABCCiRgeqVt0av9uNw13VsufQHLpIRFYwWIoYvP12b9LhviWm
         j8vg3jrLNgBZGf3rKLqI43rsawioTQsxjRmz2X3J86eKSADCR6nGporOgDtHsVm6peEi
         PslFODqgLlG1lvWYHeLWbyNrKm4gx6wu/dHgK27l8WYIh9WzQGZA+RQpiNgOT1Go7Ljc
         0AM+s3STtxVAkHXI2qFTlPkEmf9t75lFR6e/2vrNIucWOYIczT0RXozC9ykaJVGUhjZ0
         NK8g==
X-Forwarded-Encrypted: i=1; AHgh+RrpSFawb5ZCu72zcmig1rjnuhAuhDARck+tHyYJzE9y9Ms+j9LjxsIlntM/e5cOvB67Fv6Cjp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLh+kl7YKy2I6/duo1DxvirmajW3iGgx1hnMsRA3tgDwl0MW3
	3Av2CvNeOCFb1P+/c7RA+QXsQfOS5BrgVZOPliUskfxfspLesuXhvlSu1GqQJnUje+yHogzb9F+
	5A0ppZs5Z1ozjBBVIusSfFtTZENzD4UKJtqm4xaVIsmPq67OyA8QoTpV7cQ==
X-Gm-Gg: AR+sD118RALOSMLJdtXPNYHgz6ExQ0I+/HjUshlfuQiGI7gAbbdTI9wE6jRPhIDI2w7
	YAJJNCGKbfUC+EiH3B/KvYucD00d+PLgX3uKyBO2BM5FuYAA0tKdljKMu14F9yIIocI0FHUn5l6
	XM+2oXqBL276OQHs5mCtrwLkM3+BHSURB02sq2kqM18v6R94J5QludWij4KBISkOjaW1Coa7iR/
	tmJSttVd14ibnnnEZ8kWal2TDZqyosuDzS6j8ryNH7pmYccgnVQZSUu2co+L6cu8C443gmHWa9I
	7v44VQgGg3SfuLM81M6mwMD8Z+rZx/PhEDvMrJcdWzi10jRMCQuWarA4CllrpwJ0Oorp9LyRhAR
	cjCTWqB4dGEWkTB0tfdB8rQ==
X-Received: by 2002:a5d:5e08:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-47fec4e419emr6719582f8f.4.1785908225903;
        Tue, 04 Aug 2026 22:37:05 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:47f:8488:50f0 with SMTP id ffacd0b85a97d-47fec4e419emr6719507f8f.4.1785908225411;
        Tue, 04 Aug 2026 22:37:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232e40sm6878560f8f.19.2026.08.04.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:37:04 -0700 (PDT)
Date: Wed, 5 Aug 2026 01:37:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Message-ID: <20260805013203-mutt-send-email-mst@kernel.org>
References: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805032934.1606700-1-xiongweimin@kylinos.cn>

On Wed, Aug 05, 2026 at 11:29:34AM +0800, Xiong Weimin wrote:
> vp_request_msix_vectors() bumps desc->pre_vectors in place to reserve
> the virtio config vector. vp_find_vqs() may call it more than once while
> retrying MSI-X with different per-vq policies, so the caller's
> irq_affinity keeps accumulating and later attempts get the wrong
> affinity layout.
> 
> Copy the descriptor to a stack local, adjust pre_vectors there, and
> pass that to pci_alloc_irq_vectors_affinity().
> 
> Fixes: ba74b6f7fcc0 ("virtio_pci: fix cpu affinity support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/virtio/virtio_pci_common.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 164f480b1..9e75fd03e 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	const char *name = dev_name(&vp_dev->vdev.dev);
> +	struct irq_affinity tmp_aff, *aff = NULL;


"tmp" in what sense? if we can come up with a sensible name, just
"affinity" will do.


>  	unsigned int flags = PCI_IRQ_MSIX;
>  	unsigned int i, v;
>  	int err = -ENOMEM;
> @@ -146,16 +147,19 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  					GFP_KERNEL))
>  			goto error;
>  
> -	if (!per_vq_vectors)
> -		desc = NULL;
> -
> -	if (desc) {
> +	if (per_vq_vectors && desc) {
> +		/*
> +		 * Do not mutate the caller's irq_affinity across MSI-X
> +		 * fallback retries in vp_find_vqs().
> +		 */


We do not need a comment arguing with previous version of the code.

> +		tmp_aff = *desc;
> +		tmp_aff.pre_vectors++; /* virtio config vector */
> +		aff = &tmp_aff;


just assign to desc, instead?

>  		flags |= PCI_IRQ_AFFINITY;
> -		desc->pre_vectors++; /* virtio config vector */
>  	}
>  
>  	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
> -					     nvectors, flags, desc);
> +					     nvectors, flags, aff);
>  	if (err < 0)
>  		goto error;
>  	vp_dev->msix_enabled = 1;
> -- 
> 2.43.0

