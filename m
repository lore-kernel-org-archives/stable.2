Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637405;
	b=sm3b8bjYbkVijtHSF1MPlET7xX6BMtNCAfwrtxSjdW0+T0a5i9mlwuwPdQ/ookqCGlZt
	 YhHnNSQqclwRU7zY3TF0RFXI58+JduzeN58wRS2v9FGIfwQoVRnW8i9mFDjoMbOUYSu+1
	 2bSmVkCFen8ShvD5T4TAxyJr5jyvoW9vcDZMJjbhtiuIWAXu4svEUmYAXvo7jbe03fckT
	 yR2rN6DCImO+pTlGjBNI82xpAVRDHg2HueOHf/paEjtj3NdrI8rIKDuTCCUeICZ5oGfZX
	 YBU8lIJVySN2jB+S3D22mafSZG2dx2/66mYsWNmv680RHeucFeIJci9DC5TzBPKOG4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637405;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
	b=Oqrpa+63Ps2BK7XQ2fZZS6JM+dZCQR/GxGlNsjRYVrpeFGnVOZ1fwDr+cJaXelMNHIq8
	 fXIazoC/uHfd6TO5F4ZCQJ7yY55UuoEo16mwWHSgh8wZ7LtFwajIS6RfbCU1SKMg58R2B
	 ey19kXa65koh/EcJTSrlUH3PPa7iebv/rrl2tcaNmds766cgTX2+zFJpnHAAzyKhJPnCG
	 EKH4sXn1SLGLkHKgc7mJUQR8cGBRRUNQi7sNJ/u/d4dG5CSxgdQbECWEHq+8y+VsApExy
	 7h7Cxjr/mfTmgYmEdTGeZ2t3oRysRpWDgiIhBx/LFO0RqE6IoqAB5qNuKw/bE8Q3fdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BZ4LLZyL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SkhXKQa5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28660A18B0
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF28660A18B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BZ4LLZyL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SkhXKQa5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793637403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
	b=BZ4LLZyL03mW+ZxZpmHsSI+nC0pthdPcU1SeFZZw1D8Gk6Z/uhOfBZ7lhLLmsvgC9yfGGe
	3QZQlW084dRtWbl/Id6Xe9Hh3f8GaYxDcnUgby5jM2GfQ6cUU2c2Hl0WLWeDS4V0WMJOBa
	GRJVPxst6s8Ob65sZC+eJa0ucDF8OqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-R3SgYwddPjqq13mUP4lH1w-1; Mon, 02 Nov 2026 11:36:42 -0500
X-MC-Unique: R3SgYwddPjqq13mUP4lH1w-1
X-Mimecast-MFC-AGG-ID: R3SgYwddPjqq13mUP4lH1w_1793637401
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so26392945e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793637400; x=1794242200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
        b=SkhXKQa5SrVShAKn/Xv6hGHLDu5z49IRxN9UH+UEyxQDYzhPyHv+4yqd+i1QKjR9CI
         dXypMZVR6J39XWCA7XNQYnhCY9IkOfLnxhAQeP9/sG/HWj75x7hxJnEsvSy6PZXWNeqF
         Mgd8/V5lEwLNyzq6hARzda7nYnOTrQJicA2IXSpfY1qB7z8rKX8uNoq3XxdnJuF3D8I1
         jI0O/Nx764My0/vVN2G6+gaUk1zIg4zLbYYh854rtfMNfY2NFmQ0SffjxbpfDB5SOWcD
         9O8NNwVpFA1Zaqp9nNGmsIkNEnpgVflMwS2pGFmoCdHyQKGdpHLThGzP08htEZ3gN8wk
         leew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637400; x=1794242200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
        b=tH3brqOS9uxZ05pST5+GGvCrl1vBBMcJy9Jz5E51ZaTcMxj+csd8yYx56hJLxkPCkp
         q9wWXH9hZasFApD3Bm0KgRtXQ6zVntfmaJ+6lgawOhc5IIxDOdUpvgE0+Bpimfr2Rlct
         9Wl8bqmnbPi1AmYbnNPAzDCLWcn3BUeuPFOTOGHBrwLVBcc2qSlDtqRsD+ZVDZhAMLgr
         XKU76DLKde/zbAjNxt6acg0583m6QpJFQfIlLx1dS/7E4768ixI4X/ef+7HRY0GxEYfW
         lJLFAb5eyLIJreoTomRTyi1Uz/vVW5hqTdvIgL/gYYgfbklE+UKCgVL5ZdKZMmQQkURW
         nx5A==
X-Forwarded-Encrypted: i=1; AKwUvBxguGek5ljnZ7+bm2CVrAjE6gAvJCtweneX1uCNG2OqxXxDb59LCsl3X6yOY1Q14QOLZThIDGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjSMAhHut0m+ZtVLk1G/IdrqSA/jZnp5+ZqGXUQFQkWXWdc5Gy
	DkYjiGiN4AfZ+nZSczzptLjNqJ0ngBmFZVHopbPch3aboZs3FSjB1uYLjzS8xKN0QJFQ9gCPJa8
	VVqUzOktwmdk+wAVICeypeejrOJkDdqfEksCbYBRT4lUeCYFtDhphHuXDIQ==
X-Gm-Gg: AYBFou1Tc+jbnHSeHOjw0b5JBcg7IqnpvTjwwxR5Nyn4N5DyXmo6AZz66BEgkE5p30V
	Idt/pspa3bQssth932weMZdbFCuB7xB2HQPMt9dHg6PtAGtSO0MPjSUgjvekXnnpwskZSvNKqRx
	cn6sgcS6UMu4h5OR0Jj3ow5RYdXuuG+ScGfg9e9LAbzyGaD/RjIiYMoSFLm6xNeUcKNtoUPN7iJ
	95gHTc1hkKpPCL8Z9bbF/V6tkRDbrU/sFLPFp9PB4oDqGggwUTPx9CWwBt0bLuV3h47xLD1WmP/
	F5Yx+Wj7BdGebZTUAexAGku3wBSBo5q8wrf9EqBlBSXx1ZX4lKmz/I4kF/hGnAg4k9lef5oy4eJ
	8yxtVR39rdoF7w7wixyVGxK3Yt2g/1Ca5ypznjh6G2Q==
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b0b9ff2129mr79309995e9.15.1793637400524;
        Mon, 02 Nov 2026 08:36:40 -0800 (PST)
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b0b9ff2129mr79309335e9.15.1793637399951;
        Mon, 02 Nov 2026 08:36:39 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm455824455e9.3.2026.11.02.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:36:39 -0800 (PST)
Date: Mon, 2 Nov 2026 11:36:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if destroying
 the QP fails
Message-ID: <20261102113629-mutt-send-email-mst@kernel.org>
References: <20261016035851.771496-1-oss.patchbox@gmail.com>
 <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
 <CAGG=RgB2NYmjugQrVOiKyfPF=_aU47CY_JXGmCLQ-kOe4Cxp0A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgB2NYmjugQrVOiKyfPF=_aU47CY_JXGmCLQ-kOe4Cxp0A@mail.gmail.com>

On Sun, Oct 18, 2026 at 10:56:31PM -0400, Yuho Choi wrote:
> On Fri, 16 Oct 2026 at 12:01, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > This commit message is long and hard to read. Could you make it
> > shorter and more readable please?
> >
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Cc: stable@vger.kernel.org
> > Nothing against the change. But it does not deserve a fixes tag.
> >
> > > +             /* The QP still owns its buffers */
> > >               mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
> > While here, could you improve the error message please?
> > mlx5_vdpa_warn(..., "destroy %s qp 0x%x failed %s\n", vqp->fw ? "fw" : "sw");
> 
> Thanks for the review, Dragos. I'll send a v2 with a shorter commit
> message, the improved warning, and without the Fixes and stable tags.

didn't get a v2

