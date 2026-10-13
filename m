Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C6516166
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906442; cv=none; b=tmkC1U5J1mjVF1EO7dnJhH+TXbnv7F2MR8S5I/Mbd69axyBTsBWsSHhASb/4rt2U/JUq1BrZ6C273wzJjKfrEi9uQNRBzsOKx3TJsW4xmcvGvEdv7Y/kJ2Kej0rSjMrL14PPId+emK3eySn/85ImZ79UuMDG6DFRrsEnPnKYm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906442; c=relaxed/simple;
	bh=nqpdu9CR59AC2tddVN45hFHH0IJa5teU9ruMmfaeU+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmLGhHkfwtm49pqOKRvUBg5HPWzweYDvSWJu0yVZ27mvsmrl0n7loGsttebB/eFAcyq0q6RMmuneBNCa/+smUjMyondJKepK8IrTCzx0O/ccOePiXjpgfaKfuhE+1i3CRcIQZAJM7EobItoNjBOPwA6JTMfZw5x3f8ylEoU3dC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CM5yLK14; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CM5yLK14"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8fe8e343fso9243535ad.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791906441; x=1792511241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XfdqMX/IxO6QSDu5r1ASHaftLBVU1+YpLM2EfGo/COM=;
        b=CM5yLK146p6HclsKHvKM9bKAhBqPZPzEA7o6NeLR4HLwEWtwQJQOiQTsDgNaeDcAgN
         MXmteXLPA+IiFFp0zGPUTtgFWs3RK4ZgpTrIqB3uqnE6s/J7Bma52S6klmT00iYbQBKy
         2gxXtEnHudg4gWZmWB3Zb/o8xIB3DF27cWKE9/jtknNGrD+Hrv/1qXas+mPm3f1rxczA
         h0R0ZfK8TyBHAmu36D/sUMgGBokOhthTz1IR4bjLLAQEEGFkR4f6Lq77WsbLX80wQzg4
         kJfCwQbbYdBfQLXgFiAtwXML9NwuB3N6zoIxgU0YqFiI88vPKNR5ajqHCaP3gEyxFZoe
         I+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906441; x=1792511241;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfdqMX/IxO6QSDu5r1ASHaftLBVU1+YpLM2EfGo/COM=;
        b=KgSqCVhysfoytBNQs0u34q//e1UyUkWAUlHIRN0CMDPbNWgwSuoq67Ax9bQcWGiDJr
         e47TW7RryC8CWkePp1G0JYe77Bf0jXE/X4cqCDm+K2qxRmKxUbeNcFEuOuoQwQHxsHLR
         vZBZXALHQDEIyGDjIpXPJ6jG0EbXzUliqaDXtNxVkQM6W8+9SXD8llrbNKnURBd71YYr
         pGBGXf38mAyuSl3bNMFSg9O3IwnHchMlh4qWK2pRYRZJ4/8+1lnbNn1WWj67RaxFYArs
         CFmGPzr30cKJyOmw8CQsxoZoxk+WTozAVSNNqO7dEfGwOjFyVJKHYeoYaw/mOIhuZ/Qt
         8Qxg==
X-Forwarded-Encrypted: i=1; AKwUvBy37cFOPuv40W2vN19N2i4lY38bUVBRNWWGqdq0jE3K0EgDI/mavEE4Wd7fJ0y0Ta9cKWo24G4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzGXe+G+nOLtBiPrHXdtvIPP4a7nd7nj7Z054zglK+buLJY2Ev
	al2hJbjbUiY6Ind2+LiDTjL9qNumPcUhqYRzHGFXwoC42FS8gSwboWe8RIqBPZEoAuxbyqteL+f
	svvHp
X-Gm-Gg: AYBFou27felZxHGNrKmzH8IiSM5zsXoe6dJPYgguuVCBVyNMUwP/6adtvhYaJ24eC3k
	82CwEjegNS9Oe86DO/dHh99fVnNcf90/0ueHTBI1yGEYCT3OfF8fNLaFvLUPHDPx4KCGPvwKKnW
	FqvBGKtgqyxeKASIEvQcAIRY5YN+YQgPN096eAsaN+aeIohkZDWAHTXc2g5vIYo83JIMvzKsRrK
	zxjTTb2Ab7BTa3f8C6Xc+6I3LFanwJ9BMIt0SXAS9zuHBNmykRqmzqkHYCurn2LAstF4lhmGWtJ
	uIELuhc0/c6DIgM9Peu3h2bnpaFqUyOoRIIc1nyYz8et6p4WRamXJF1pajBzh1QrR8B7TtMulQJ
	oMNIC9vt658gJ3ZbMNMKBY/jMUd2lgABJtn9Fvh/lyIrApcyF+/8zUAfcw5RVDy6cQtMZrGSiOV
	79+I/P0JBlh/fjlzW2an83838lLwcNlAlOkrn1l4x2PTGNwr40rJHDhPPUBCqIRwsa86K7ujZW8
	ypUNS6fYiOyRA==
X-Received: by 2002:a17:903:37c8:b0:2e6:c39:b25b with SMTP id d9443c01a7336-2e90cb5290bmr23619435ad.14.1791906440730;
        Tue, 13 Oct 2026 08:47:20 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:adc4:c3cd:7c5f:3991])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0124csm58828005ad.5.2026.10.13.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:47:20 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:47:18 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: virtio: Synchronize virtqueue teardown
 with rproc_vq_interrupt()
Message-ID: <as5Shj4EKjk2H2AU@p14s>
References: <20260926041943.1124650-1-oss.patchbox@gmail.com>
 <askjD1DxFvrV5ND3@p14s>
 <CAGG=RgA04aBS1QkTWoW-yjMZ0MxB0x3bTM47_MZr-yK04DPDVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgA04aBS1QkTWoW-yjMZ0MxB0x3bTM47_MZr-yK04DPDVg@mail.gmail.com>

On Fri, Oct 09, 2026 at 05:23:42PM -0400, Yuho Choi wrote:
> On Fri, 9 Oct 2026 at 13:23, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > > -     list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> > > +     list_for_each_entry(vq, &vdev->vqs, list) {
> >
> > How is list_for_each_entry_safe() no longer needed?
> 
> The first loop only clears the pointers with RCU_INIT_POINTER(). It does not
> modify the list, so the 'safe' variant is not needed there.
> synchronize_srcu() is
> then called once, after that loop, to wait for in-flight readers. The
> actual removal
> still happens in the second loop, which keeps list_for_each_entry_safe().

I agree with your assessment.  I will merge this patch patch when 7.4-rc1 comes
out.

Thanks,
Mathieu
