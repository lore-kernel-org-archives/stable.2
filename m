Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EA4AA1F4
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366346; cv=none; b=oUXYGBvU7qhiXxxHB8oWkrs1j6OnJfLh82WwBPmHMu6T48gEwnXE/ipDMeHQuD3iG39V+Qdsan3q2OciBmkduDoOsk2lsihQVGvqOrJGqU3HbUFbIdcsmVjaRQjeWguyRQAA+pyjVKuUHZc0n8McOxEUYiXbS3oBL7uyYVDKRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366346; c=relaxed/simple;
	bh=1Z3GQKCMUt7wjBc4m3btWBP05mXDrGpjwi2G7bpVaVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6jsBEck9ZftjfUAZPdrg0gmooFpGN6K/1z9hyFJXzuGAmI6qiPaEY49pzkI9ToVMg9yH/uRBHAZfKJwzGF8YuICJepHTwERCpH/Yx5Wjd7zj7DyL5VTqBFIbX962soZ3dgRKGp8nWqSgNg2XqxYMOhLu1aj/1k8tZVN1Hgq9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5MK+5fz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5MK+5fz"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6aso58375ad.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788366344; x=1788971144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCqwcYRPzd1U+BFCtrZTS26QV4hmjeNAm4yYU+A/ltI=;
        b=f5MK+5fzD4cxhzGiwGEi1yAIBrFptiyDhjX14SPsnWJbUhXMUQMN355An0hubpNfNJ
         2eFf55gqnfM/7OV3/j7nQYkiXwlW2zwyzqdMCh/TtegGRWuhN10zNXMtUpNgO0Uo2aKb
         xwup75I5v7CMnx06xE8vdKQjWtGw9KRPxhXixFGu6G1pNJ3uU6Ev1N/TeVZuHl43brGV
         eD9Bs+YPIrEx6AA+nCGPq4gXHvvFR4T3bjqPXlE2KYw4FUM9Jldi1alOy+8BgpJ61oLY
         OWxcUCvMgoJLLIXxdOKars3G3zMC9yypmQSgD2ZRpPaEe6sdQdAxFmZF9bFOt/wThuXa
         w+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366344; x=1788971144;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCqwcYRPzd1U+BFCtrZTS26QV4hmjeNAm4yYU+A/ltI=;
        b=lU6s+BRDifijI9gIGnMUyKXRXYAeRlSut8UUGN+uKjQ+bWlgOE3mpG/TOD2oVDx7/6
         zm9Z5KweNd1WMZHfzcgvByyHBVQsJEFWsVr5U/rVg8+Ykez7UKloRYjUyut9NAME/Dzt
         wXAZH4kLm1hlJPaFf8cqMHfhVxn0e+ff1YwnnRqm/6aBr61KkmbVxNhI8ROwZNeDnl88
         PpdnFMXtMmLLRa0yN0DdZjdPfL2tU9ZzaO8wehRcCwVfKox5QKI/7ANOKjIeqm8CxR56
         SqPv+LiLTvFyHGGyv7R9fJVQkyAYyIbIALIC9H39CqR6dy4Dz76CF4DVW/e5HF1J2TWz
         PTOA==
X-Forwarded-Encrypted: i=1; AKwUvBzF51MuO50GyO2081kW1H0pb46sPVAd99vbkVZsAiqJNcYtIVv16bd0IZmEfVRfg34+/WMjQVQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lySuSFUQcxfQn+UAopFOAzZOFwkHUGpEnEbDFzkUQRsRL7tC/a
	YMrIwHNfJRw20/aWxr0JzXXB5ilOA2E7+ujRtYnDISQBMWkZKs5unZ/KjfE/Q8jcxA==
X-Gm-Gg: AYBFou2YGgknDan0yuUp1tfSy/8ilxu4QoQCNPGxyu8Kfz/A4xHJEz66jt7fBUFzSH7
	guML6pPUmhV3k1a6PUItkbqvlrckDmayRsjSGcbZd2F/w7SuzS2gM1z9Xm9wGxFFJaGHVk5mrkp
	V+xqhbmNfro84NeZ9a9uqZMAAuXUWqct9j0Csb71D/TnKKFrmPvFat9Rz1TGzytmr8efBsRmCG0
	UjjxGGtXyZGhux8b11pN6OgI4egC9jEdBnAX+Dl/cAQVTFvtxRjVkce28B3PkQOO/+HfMFP+K4u
	ySO5rnBbWztSLY9sk1y1TURhcBecO/ieJatgvY8CjttIVUHVUr9LR0CYWbA7h2gYMzt6nrWoUFa
	MvGRbNNXXIBLy3DcbKuAJnw1OYb6VkB8GsP7CC02BYhPmo+rwPGMhJaSXLkJfRUzCiXFyCOsHPQ
	iiRjgnsM0olpPc4TeVs/f06r5wqJIToqBitmV5LqN1JLE3AIpEKGe9cAEfG+x+HSZSUVBUV4ZFS
	7dXBKhX8Ey6HA7EeGjExQeMTxKwA7wRpjCvhYF7YRsgMwlRFg8q5NttnccfGYEQ3wBfhS01TpgF
	LJBveqg=
X-Received: by 2002:a17:903:3850:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2daf6818323mr2846895ad.0.1788366343483;
        Wed, 02 Sep 2026 09:25:43 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd3ad8easm15768155ad.36.2026.09.02.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:25:42 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:25:39 +0000
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
Message-ID: <aphOAx2CINlw3m6Y@google.com>
References: <20260901205250.1638304-1-cmllamas@google.com>
 <20260901205250.1638304-6-cmllamas@google.com>
 <apgbjOsfn4oFMmAC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apgbjOsfn4oFMmAC@google.com>

On Wed, Sep 02, 2026 at 12:50:20PM +0000, Alice Ryhl wrote:
> On Tue, Sep 01, 2026 at 08:52:45PM +0000, Carlos Llamas wrote:
> > Certain operations like a failed mremap() might trigger vm_ops->close()
> > on temporary mappings. To avoid tearing-down the main binder mapping on
> > these, let's verify that the VMA matches the expected starting address.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas@google.com?part=1
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 185128577829..3d359490436e 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -6018,6 +6018,9 @@ static void binder_vma_close(struct vm_area_struct *vma)
> >  {
> >  	struct binder_proc *proc = vma->vm_private_data;
> >  
> > +	if (vma->vm_start != proc->alloc.vm_start)
> > +		return;
> 
> So .. this does work in the case of mremap, but how about instead doing
> this?
> 
> static int binder_mremap(struct vm_area_struct *vma)
> {
> 	vma->vm_private_data = NULL;
> 	return -EINVAL;
> }
> 
> and then check for NULL in binder_vma_close() instead? I think that
> logic would be a bit easier to understand.

Yeah, I agree that is easier to read. However, not all exit paths that
close a copied vma actually call op->mremap(). We would miss those and
accidentally brick binder.

Maybe I should add a comment to the check, so that is easier to read?

	/* 
	 * Ignore temporary vma copies from aborted operations (e.g.
	 * mremap). Only tear-down the original VMA with the expected
	 * starting address.
	 */
	 if (vma->vm_start != proc->alloc.vm_start)
	 	return;

Would that work?

--
Carlos Llamas

