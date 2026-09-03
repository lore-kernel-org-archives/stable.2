Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7535C514757
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473582; cv=none; b=hGJ3BzloaQETc4mPZmavrJob4DNJz+jmECDrbc5yOURFGehmYewvJIzI13/4AwctA7G1rtQu+mWY6FdrjE8EKw3q489qlyP3FEIHDAdlsks1rr2SJQgqYeL3QqR1SSFE/IxGX9Azo1DW/yBHgJM/Om1fn9SPoZ+rFWoljEohtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473582; c=relaxed/simple;
	bh=mCXl7hYmx+ndy9uHkKMY6/NSTPgobj/jX5zj7F6t2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0KxpkgZWC16iCXY+Ib3izdsJirl/30T4wNVW5H5Nz2o3DfgI/8NOLV3YFZdhDgOcy/YRkp2B3CBj/Xy9d+bI0a2i8xzIke+OhJYIcDgIBwJVd5oqq171T9Z8EYWGlXZZGk6kZ3MU/d5wAN0pOmsmqtGm7fIv+hukoc6MbXy6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRB5Z/m+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRB5Z/m+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6aso18825ad.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788473581; x=1789078381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2BhoMTsCGjfbPMb6MMxew+QnW15SLqCs6w2K4dK+HP0=;
        b=fRB5Z/m+UHGT1Gqf8zg9vnWdUDUi34WRUe7RKs4+2s/TCfzjnQbaTf1VPPGMeS4EHX
         b1jvNkXK1P1qSc0S3QPywO8cmSxKdwL4oO+KesIxVupX3DV31obHd5/R2DKI4VkR0zzq
         eymzS4GAaVHqgk+ewHMlvVBm0o5PfDS+t6VVhbnP8w7wwVJVuYpTDhWF0WeAoLtczNVJ
         pmIPWVSIeZ6DQSG7sss2Jndi+UauNMwCG1tEm/jXGo26Zr/E+yvROCgx593E114viuqo
         ztHxibHjFhZF85+k4SQ2Y0E+1c6zL0KxfU3qHEvXGIRIXFT7YQQZUR9MknDdWxABEBw3
         h5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788473581; x=1789078381;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BhoMTsCGjfbPMb6MMxew+QnW15SLqCs6w2K4dK+HP0=;
        b=p+CIORABqar2M4tUEeLLQBhAMPkztYxkF8vE/ivJ8EpR5xEHCN2KIafhIEe3zdT0XF
         ZdY656ddPaBe/uU6j3t5sAg2cwiFvwirf+lyHwQ9Du6m8ipdg3w/VZPCVOUqd4CZTWQr
         qkpv4KDTeR/ZZKfpk0SKzsPSy7I9lmj/OPFiYJCc3//anm7xhhcTeTn7z6ZOJ81hkTOH
         p8eutThPSlLEJRAl9MYIZWFIYh0zaMASLAVVIkpOc1o22z4+kRXD3ZLF1NmSXBS8ivGL
         qolL9d7Sy05DylXiyBlsJmU948Ob95XaNgvcU6NnJeE12LxSBIjgRdivXG7HtP35IfGm
         Iabg==
X-Forwarded-Encrypted: i=1; AKwUvBz6PBw0gW3AUZnZ5fiSV/zen+3ATwYD9n4ap56Fja8A1S94Kno3R0S9mOIB6UA1PWdoNKQ1rXw=@vger.kernel.org
X-Gm-Message-State: AFuF++m6MVcHzQLuY5S+lIl/YYxgL3UDXdsZbY5QOJp+Lty882PE/LKj
	qrM3GUmuoYkveSpKH1M7755Apn14Mxggf7UH5TCCcQXIPreRMY+gbd/CRToyb4orVTbt3gw4cjU
	A8i/W0g==
X-Gm-Gg: AYBFou13YZZ1hywJEhJqZS/GB8nVjrwCZSgYL9+P2s+MRRdv7baH8fuOaj2ra2MlR+l
	VpWD2wVAd75SgOxsqdSqcKQn+OOwS64fgqab6qvaK3OFiB9awXGQeAoT/MQOOltpVI5WXWnCMwB
	J37LZbmYz1dev+no/zf/sAdJP3FSXJKnAMlvoBEne7N3lr8JoKccX7zNdzyie8VOYq468RxdBAu
	j9eNsyCpHne0B0czB2e481CzdPfXRHym42V31eZ2nZPVP0hMVrWtD9U1xwjIvP4g8aLg9wl51z+
	WcIdsn0s6UYt/rpwmXRO+vbucQcJ9heHLn0ZuwtlM9jjnnlMT76u/+W0Pur+j0DYHZPJhh9b37G
	ZukT7KnfEcORoUAb1LTgMzQjLZ6qXfSwCDu3Fol28Wh+cMa0pxV9u3NVeZHUjkVUkHiZBb4dSVE
	upSjRNlsj/JLELahgpzjnnglUq7y9Fr7cUS9w0HJj6NAGSTWgJLSd60oh0bcoBPrvYSO5AZd6JT
	5mRwEW8gcz9iEQrpBFXD/EmxAGJJ2OiPv/W27yEmy2BvUyoA0wL548Sm9ZZTLGlqA80AAoLTqDg
	oMT6M78=
X-Received: by 2002:a17:902:c948:b0:2c0:defb:557e with SMTP id d9443c01a7336-2db16b4ff3amr517615ad.1.1788473579861;
        Thu, 03 Sep 2026 15:12:59 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm954256a91.9.2026.09.03.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:12:59 -0700 (PDT)
Date: Thu, 3 Sep 2026 22:12:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 5/7] binder: check vma->vm_start in binder_vma_close()
Message-ID: <apnw5zOSnfoajNsX@google.com>
References: <20260901205250.1638304-1-cmllamas@google.com>
 <20260901205250.1638304-6-cmllamas@google.com>
 <apgbjOsfn4oFMmAC@google.com>
 <aphOAx2CINlw3m6Y@google.com>
 <apkoe-g5Cj9U8Kqt@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkoe-g5Cj9U8Kqt@google.com>

On Thu, Sep 03, 2026 at 07:57:47AM +0000, Alice Ryhl wrote:
> On Wed, Sep 02, 2026 at 04:25:39PM +0000, Carlos Llamas wrote:
> > On Wed, Sep 02, 2026 at 12:50:20PM +0000, Alice Ryhl wrote:
> > > On Tue, Sep 01, 2026 at 08:52:45PM +0000, Carlos Llamas wrote:
> > > > Certain operations like a failed mremap() might trigger vm_ops->close()
> > > > on temporary mappings. To avoid tearing-down the main binder mapping on
> > > > these, let's verify that the VMA matches the expected starting address.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas@google.com?part=1
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > >  drivers/android/binder.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index 185128577829..3d359490436e 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -6018,6 +6018,9 @@ static void binder_vma_close(struct vm_area_struct *vma)
> > > >  {
> > > >  	struct binder_proc *proc = vma->vm_private_data;
> > > >  
> > > > +	if (vma->vm_start != proc->alloc.vm_start)
> > > > +		return;
> > > 
> > > So .. this does work in the case of mremap, but how about instead doing
> > > this?
> > > 
> > > static int binder_mremap(struct vm_area_struct *vma)
> > > {
> > > 	vma->vm_private_data = NULL;
> > > 	return -EINVAL;
> > > }
> > > 
> > > and then check for NULL in binder_vma_close() instead? I think that
> > > logic would be a bit easier to understand.
> > 
> > Yeah, I agree that is easier to read. However, not all exit paths that
> > close a copied vma actually call op->mremap(). We would miss those and
> > accidentally brick binder.
> 
> What about setting it to NULL in op->open(), then?

I suppose that would technically work because ->open() would only be
called for subsequent operations after the initial ->mmap(). However,
that might be more complex to understand without this "mm-specific"
context no? A comment would again be needed to explain why we clear
vma->vm_private_data for the common readers...

	/*
	 * Subsequent ->open() calls after the initial ->mmap() are
	 * considered invalid ops and as such we mark ->vm_private_data
	 * invalid and avoid IPC tear-down upon its ->close().
	 */
	 vma->vm_private_data = NULL;

I don't hate this idea, but I don't see the easier-to-read argument
either. I'll switch to this if you really think is better.

Ultimately, we are trying to find a way to identify the "original"
mapping and avoid shutting down the IPC on invalid clones. Do you
believe using vma->vm_start is not a reliable way? Or perhaps not
straight-forward?

--
Carlos Llamas
