Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA73DDDCD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515363; cv=none; b=ARjVTB2L6VdjkXZOB/etPh+VBH1gzDwxXZMlRDwPORsg4V0t6p+Ilc+261lAQuthEsmv9eY7rEbTrv8d/rhN5+ts81EyrqpHrpNjk2/L/0eKyN2FQA+JWjnZTDKpZxZW05xyzZf41znyPVhDKa9D5LvttS+J/hKVgdAPWQCkHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515363; c=relaxed/simple;
	bh=qwOrA9Mnggk2KEvsaY2C0xYJG/NKATBTng/ahFDLjXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JkRpp54uF+bsMwxA4w9iS4GGpYqD8gtjAq/6eSBPyQR3E6YXuTdLlremUdkvhEoSKsj+SMCwbCrdiePeWrZErdRCXoYh9/+A6RY1Sqh5v/7j7jFWQS6by3TnGMZni+LN1o74RUuUp3VavBNwSOtcc9Fu8JhLwCXRJiA3ImFdZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5aPS2Ea; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5aPS2Ea"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso6015845e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788515360; x=1789120160; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tD9YUdJxEY0AYwxtY9VhW4RfuJzXRZj3kSymY7ndAy4=;
        b=j5aPS2EaC3L/vhT89qQk70ZtBtK4MN6y6ARnr0TY7AVkFkhOVX9kmcGioxhM7EHLpk
         d2acoy0PVEcGMLuBws5P40ZGkt55/A5ifdFFFAUrfZ5nEjZHD26JxZVuNKksdsKCrXjl
         yblKLPPjEnGfL7nG4fP2NxLlqK7v4raA7l9b7PrQUXVP1/bSEyE+7htsG70ShqUWmHlo
         mqCoCNx3URxEGG0KzEoRKSlU+AgeIBTAfaBnPLPPYyRCZp8ilpd4U0+IngeG4RIRy/8t
         ayBkygI+nwVRbHcdGXVaDhfbTJ3FusCWHfzcmgBtVJsoYPkPl4gCUQQNyT40sCa/rVbr
         siIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515360; x=1789120160;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tD9YUdJxEY0AYwxtY9VhW4RfuJzXRZj3kSymY7ndAy4=;
        b=Rred2EqVHIvYDiuFNx4QrN32X11izWbwDSXdsmPeubMTreeBk2XLgVCo/irEuinGCQ
         47VzuoKcXpi6rH40lGeuH1U2X9lnOJuMM2nBw3ogwn5Oma7JWsmA9LIctwalhadufgOx
         BksFXDHRhzLFT9GJPdIwWacqy1E4387DRXC12U0otvyb2VyJ87hXiVewVRrED6Sdrcwi
         kOvjuYlEqFnzfXfqZUGedke6a7Pg5PgvMvZizGPEIvYZeA9C2jZqBSLZ22Vd76xq6lPb
         mv6cck2b3b81Vc3afexyAa1VAGi+k0famRWJFZXGOK83WxkqPeIDeRhxEq5hwPEJ2jyc
         FyaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRagNMaqAzunfRu0CZ0js+OOFtwzkmQmCMbqS2JGonKJR1VSQpHJG2F6fbB5nxSp2mcpJLIgc=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ5tbQ/Jrb49G+mNrYn0pREQ6lfe8Pe35ao8UT8JUPjrewja33
	nlBdjL7/pPTi4S53Vvy0cFoq4DM3FMiXw7Uh5A0zfcpUhbP9q/2QrxAwgtnI5w+dmQxNA2dXT2G
	C+Quyofm1UZ6Exmd4zQ==
X-Received: from wrqe18.prod.google.com ([2002:a5d:6d12:0:b0:484:3a05:4b1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:628b:b0:49c:fa21:e742 with SMTP id 5b1f17b1804b1-49cfa21e956mr24670005e9.24.1788515360004;
 Fri, 04 Sep 2026 02:49:20 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:49:15 +0000
In-Reply-To: <apnw5zOSnfoajNsX@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901205250.1638304-1-cmllamas@google.com> <20260901205250.1638304-6-cmllamas@google.com>
 <apgbjOsfn4oFMmAC@google.com> <aphOAx2CINlw3m6Y@google.com>
 <apkoe-g5Cj9U8Kqt@google.com> <apnw5zOSnfoajNsX@google.com>
Message-ID: <apqUGyD7-AOhBu5q@google.com>
Subject: Re: [PATCH v4 5/7] binder: check vma->vm_start in binder_vma_close()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Sep 03, 2026 at 10:12:55PM +0000, Carlos Llamas wrote:
> On Thu, Sep 03, 2026 at 07:57:47AM +0000, Alice Ryhl wrote:
> > On Wed, Sep 02, 2026 at 04:25:39PM +0000, Carlos Llamas wrote:
> > > On Wed, Sep 02, 2026 at 12:50:20PM +0000, Alice Ryhl wrote:
> > > > On Tue, Sep 01, 2026 at 08:52:45PM +0000, Carlos Llamas wrote:
> > > > > Certain operations like a failed mremap() might trigger vm_ops->close()
> > > > > on temporary mappings. To avoid tearing-down the main binder mapping on
> > > > > these, let's verify that the VMA matches the expected starting address.
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > > Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas@google.com?part=1
> > > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > > ---
> > > > >  drivers/android/binder.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index 185128577829..3d359490436e 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -6018,6 +6018,9 @@ static void binder_vma_close(struct vm_area_struct *vma)
> > > > >  {
> > > > >  	struct binder_proc *proc = vma->vm_private_data;
> > > > >  
> > > > > +	if (vma->vm_start != proc->alloc.vm_start)
> > > > > +		return;
> > > > 
> > > > So .. this does work in the case of mremap, but how about instead doing
> > > > this?
> > > > 
> > > > static int binder_mremap(struct vm_area_struct *vma)
> > > > {
> > > > 	vma->vm_private_data = NULL;
> > > > 	return -EINVAL;
> > > > }
> > > > 
> > > > and then check for NULL in binder_vma_close() instead? I think that
> > > > logic would be a bit easier to understand.
> > > 
> > > Yeah, I agree that is easier to read. However, not all exit paths that
> > > close a copied vma actually call op->mremap(). We would miss those and
> > > accidentally brick binder.
> > 
> > What about setting it to NULL in op->open(), then?
> 
> I suppose that would technically work because ->open() would only be
> called for subsequent operations after the initial ->mmap(). However,
> that might be more complex to understand without this "mm-specific"
> context no? A comment would again be needed to explain why we clear
> vma->vm_private_data for the common readers...
> 
> 	/*
> 	 * Subsequent ->open() calls after the initial ->mmap() are
> 	 * considered invalid ops and as such we mark ->vm_private_data
> 	 * invalid and avoid IPC tear-down upon its ->close().
> 	 */
> 	 vma->vm_private_data = NULL;
> 
> I don't hate this idea, but I don't see the easier-to-read argument
> either. I'll switch to this if you really think is better.
> 
> Ultimately, we are trying to find a way to identify the "original"
> mapping and avoid shutting down the IPC on invalid clones. Do you
> believe using vma->vm_start is not a reliable way? Or perhaps not
> straight-forward?

The reason I find vma->vm_start to be non-obvious is ... how do you know
that the second vma can't have the same value for vm_start?

Does mremap() work for splitting a vma into two? Then the first half of
the resulting two vmas will have the same vm_start. Or does it support
resizing it, which results in a new vma with the same vm_start? Or can
we create a vma of length zero at that address?

After some verification, I found that these do not apply because the vma
created by mremap() can't overlap with the old one. But it was not
obvious to me.

And in fact I do think we *can* create a new vma with the same vm_start
like this:

1. mremap() the original VMA to a second VMA at a different address
2. Close the original VMA
3. mremap() the second VMA to the original address, creating a third VMA
   at that location

and the third VMA would get past the vm_start check when you close it.

Or perhaps:

1. unmap the first half of the original vma
2. mremap() the remainder back to vm_start, which is no longer overlap

Now, in the current code that's actually harmless because we already set
mapped to false in this scenario ... will it be harmless in all future
versions of this code? Maybe not? Future authors may see the vm_start
check and conclude "after this check I know for sure this code runs only
once" and do something that's illegal if called twice.

Alice
