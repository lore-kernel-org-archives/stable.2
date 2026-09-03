Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6728C5B1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422271; cv=none; b=rIzBRjTc81f++7goIOIP7FI1XLXQ5MXK06mnb+VUWlg0BOkN6gbMtopftdlqqjYTteVOKpmwVp57WZRtQK0wZaJjvws1ybwkUSPWouPW6TRliP0Bxo8YhHhWGA7JnvfUrztdDKLnPxatrwrgnRDZDUI4dGoZT9dNUM/cMdRRGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422271; c=relaxed/simple;
	bh=L/r7m7kDv0omebnD1y3qb2AQBcATiYqlgqTB+1Do+6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jDZ+wRAugoT8TkrqGmmm0q4Qf9xJmEENNpxNfSWL0LiDgN5NZJsOUuK0F8J9J70iHmVmb9ohHQCGaxa605dEDx3vyPsGo5xqy5c34jKHjt/LJVARH69NRrJ/iYtxF339iP5EUFEqqtlnTJIXsj+/a3vKUZA3Qd75vwRZwo0qFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3SQ4yOk; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3SQ4yOk"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso1384735f8f.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788422268; x=1789027068; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vR1Q5C1h3ZhnEFmXm0MTEkgQW02wtj80tGssKs7CjOM=;
        b=Z3SQ4yOkkmXjtWozFUVfzGIYasJxwYZvD5s2E7jaJaJuxGMCZ6GyyyChyz8PKJ9oCJ
         rWRYPCJdnVitIyT4MuBFZCw5hwI36LBthrxrs27ateKZLinSQQ4RN467ZWT6QJw0RAYT
         Je1y015IlExYTJC7v2KK6xPt0SS6gj7KKpTfQ8mx8CWZ9PtQ3pxqdjF/rNU0fHxxVDIx
         wpuk+PusRDJGLBzdPo2TvWiwkdlpBx+PkNN0RqaFpdqz0Ayraen1VYCqBBBBP0lBWk8x
         6lJjoXiJzrqtMi6AkeVIfabPgAVicmLXi1vDcGcVMNPSSyehcwv89L+HsjZf/PVC3ADZ
         LfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422268; x=1789027068;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vR1Q5C1h3ZhnEFmXm0MTEkgQW02wtj80tGssKs7CjOM=;
        b=pkz9jVx6/PbHQ0xQ0cY+LKl+sNvr4XG6M1Xd0RcWLuwOr8D7GyOioguwpk/cWh4YNV
         JIgfUNQ7G2p/i7aUODLFQnobOj289KyWXNaaovTDZhL/tPpflvLkkaXDM2Y7Fvt7gUSk
         NVLMd1Bt2EFTpJjiQjek1tMgcc8MKJ9pBuGrNCai0UonlThBRAKPThQK/f8+hUNadmxI
         l1/XMIXtU3cRwJDz3rq1HycT6pGVuLvGx7go/1xzeneLN6wmAyr6o5OWr5cDcLAxYN6m
         xvM8TkuXJDlHrOCEmkvzjrUhY4Y1ZUaEKNLXMVcNgD99CceTXNKkhkGYlJVg1a5GBg9R
         hSiA==
X-Forwarded-Encrypted: i=1; AKwUvBzm4/ovOh6bLDCvbcftSoud3xFxUYf4dgsKjtcWqYtlirMYP36DMtKSLwBGLh7C7MnjZLsQqGg=@vger.kernel.org
X-Gm-Message-State: AFuF++m3QT2HdZV/loFmtbbNkZuXJsrKpjajzHrhHoWmOYBRvutcRVVV
	UGR2Zxvvt2DvmM6iMeSpijTL1HInr3C02lxzqfQJIF3FPR+yzm4UhHt0h/B95ZMF4/q9ifH6JZP
	UT9eGOUIp7/mOtDWOXw==
X-Received: from wmnl19.prod.google.com ([2002:a05:600c:16d3:b0:49c:d53d:56b2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6209:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49ce582039fmr193039575e9.7.1788422268362;
 Thu, 03 Sep 2026 00:57:48 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:57:47 +0000
In-Reply-To: <aphOAx2CINlw3m6Y@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901205250.1638304-1-cmllamas@google.com> <20260901205250.1638304-6-cmllamas@google.com>
 <apgbjOsfn4oFMmAC@google.com> <aphOAx2CINlw3m6Y@google.com>
Message-ID: <apkoe-g5Cj9U8Kqt@google.com>
Subject: Re: [PATCH v4 5/7] binder: check vma->vm_start in binder_vma_close()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 02, 2026 at 04:25:39PM +0000, Carlos Llamas wrote:
> On Wed, Sep 02, 2026 at 12:50:20PM +0000, Alice Ryhl wrote:
> > On Tue, Sep 01, 2026 at 08:52:45PM +0000, Carlos Llamas wrote:
> > > Certain operations like a failed mremap() might trigger vm_ops->close()
> > > on temporary mappings. To avoid tearing-down the main binder mapping on
> > > these, let's verify that the VMA matches the expected starting address.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas@google.com?part=1
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > >  drivers/android/binder.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 185128577829..3d359490436e 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -6018,6 +6018,9 @@ static void binder_vma_close(struct vm_area_struct *vma)
> > >  {
> > >  	struct binder_proc *proc = vma->vm_private_data;
> > >  
> > > +	if (vma->vm_start != proc->alloc.vm_start)
> > > +		return;
> > 
> > So .. this does work in the case of mremap, but how about instead doing
> > this?
> > 
> > static int binder_mremap(struct vm_area_struct *vma)
> > {
> > 	vma->vm_private_data = NULL;
> > 	return -EINVAL;
> > }
> > 
> > and then check for NULL in binder_vma_close() instead? I think that
> > logic would be a bit easier to understand.
> 
> Yeah, I agree that is easier to read. However, not all exit paths that
> close a copied vma actually call op->mremap(). We would miss those and
> accidentally brick binder.

What about setting it to NULL in op->open(), then?

Alice

> Maybe I should add a comment to the check, so that is easier to read?
> 
> 	/* 
> 	 * Ignore temporary vma copies from aborted operations (e.g.
> 	 * mremap). Only tear-down the original VMA with the expected
> 	 * starting address.
> 	 */
> 	 if (vma->vm_start != proc->alloc.vm_start)
> 	 	return;
> 
> Would that work?


