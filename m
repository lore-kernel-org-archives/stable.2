Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7254357CF8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971671; cv=none; b=pnsTYk2vKHEO4R5Asfrkzucwbs2V3jwd8NKZTfr5RXO1/+IOx9O1XqH4p4KE1+yHHmuRGB4sUsDUNyu5t5SgtD0GOUoZcjjMAgbkI+EPkma+YhormlXA4n/gZoUleU6BV/hvSlvM/h9p++we0oUDalywym3FyPEtzuoVktz1Ju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971671; c=relaxed/simple;
	bh=Z380FDqsxBLRnjMA6hntXYmI+33qpOSqSr+3iFUF4c4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bkl6gpKPBu95Xdm3FLT4CVV/5QtRhCmZ7/nWFlHN3iy6VbRt5+u+IzRaCyg2edqaU0ID9HfVE/3Hf1tdOen0q5F0C58h9ScGXEmyT2fUMmT3b1uoXKc/AuavNcZTgoWXJiNZOD7iMgX4bsyQRqkgO6ZXKAO7rm0PBdJyMjwf6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K43GFH2y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K43GFH2y"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab97c86bdso27765ad.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783971669; x=1784576469; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLh7SflYriIICq2322YWz4Oz4v42mpNRc7r49x5w7jo=;
        b=K43GFH2yL+r/OsUVMv27QZYXyl2G9SUmmydd+wUcOzHdHc9x0wk5t/LiRIwqaG2sps
         /aO4aA9/7dq537hGDOEvOCPw/QTu0M3EJACXQioqM83r1QIy6ZkpzvItOdMfLLBNxRj8
         GyKDl0gRwI5WL6S9Le3f76ujp9lcizDWNspFfXxURJCtT9Bc3S9ngaafwfjbZ27SWIY+
         vskqCJGrb7zXwBqyxlTO4/wgI9h/qXTg5Vm0YO3iDov1pzHlskgfdNbRm7+SZk6e1Qiv
         L5zLctQkAfLwxn1xFsZp1UWuLFhuJppkGADsy8+FZUwToI9FQBnWFgR0r+9IKmMjeWbW
         CIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971669; x=1784576469;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLh7SflYriIICq2322YWz4Oz4v42mpNRc7r49x5w7jo=;
        b=kG5mTYDnWWKUhSFw3NTEEgDLUFn51D5XdCOn0QC1nN9a03JYbZAeYh4mkmXOQJgzH0
         RaTeau7C74fHE6bwt1llwKt8jgEdWlG8G5EgunEBGOszHCeJNcGmWpzqxIBtUJR+DdL+
         +C+Ke00LjVXJcRqVUOLjlwhGEAIAKlgrOHEe6U24Md3hiKWSdkE42x0awwzZqzV+BJuJ
         0kR4qpkwxbJW99VOL2u0V4eKNXUoCiPdqoRYk0lXNwNKngEMvxtoF5jgROGzVC2qHX+M
         1TJuQnf0xEtdYVoRX+rcwZwSUGRugXH2Wn9RIzwFCGIxHAOm7AXAhJi4gUxOZQIbHIP8
         /iJA==
X-Forwarded-Encrypted: i=1; AHgh+Rqwjf20BTijaYYMwc0rxef6hAiRGifq0VbYr2pU03DnoSGWBGlRm5vJosK/qEK76+jZ+TP/M5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAkaA0jlAD6K/7OK3WVE78gFhr/c/Mo0kVqHJK7TjrtBhiFZK
	FBCmSXErMNrDVIpZfbDLHn/TiA/QpF6Cd/KpQ9iFyGpVt5EogGQ8QOc/h+TqQqaDQg==
X-Gm-Gg: AfdE7ckpAV3xMwFKFV3buWUzhNpI6wzYQXTJyxXVU1ABqfqPKriWVuxKOi4WioGdkzm
	h1zTy+UqU81sYrK5f+n8aruZLWMlum8vpKn8gIvMri81OCBHoHRtNGgp6F/2KP0qvh/omSa/tEd
	r8lklHzitujEKDqGmtmCSNu1mCktjD1KPla4WwLsGtOIEGDW0vYzJMAH+Qc/sRGATB6f7OJTnE4
	j8YuojLKA1HxbvzNy2w/riLAfGbqWt/Nf3EuhTE8Uk9ckYS62kDRzetek/sYmKmpXEKESrfZjkW
	grzsOkqx14C9f4RzZLZw6O/ZSneXm2IBCwgttpJ8UAw179sGdsKtQGO6uPTlQWnL/9PnWWLLkkH
	38oKxNo4R4nquuy9+bavy8X355C47V3qrwNgaqewVg9Qk6Q3fk9QJV0s5vzRQHZY+9QlnmUq7RJ
	/YTOq0HaBbTKRFjthu+bfrGocvB3eQH/UNRI5dYEjwvZbDPbscGyMxvfGWqtwm2Dy5ww5pzdz64
	fs4f3FPqEJ1pY0gHNtQxLiuBnRCioNFQHNrnTprjr8zFnRbVnwzkw==
X-Received: by 2002:a17:902:fd83:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2cee1ccc432mr2429565ad.24.1783971668691;
        Mon, 13 Jul 2026 12:41:08 -0700 (PDT)
Received: from [2a00:79e0:2eb4:9:4c33:68fb:770e:3e89] ([2a00:79e0:2eb4:9:4c33:68fb:770e:3e89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6c158bsm272977b3a.38.2026.07.13.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:41:07 -0700 (PDT)
Date: Mon, 13 Jul 2026 12:41:07 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Link Lin <linkl@google.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    "Michael S . Tsirkin" <mst@redhat.com>, 
    David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com, 
    duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
    Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, 
    ahwilkins@google.com, Greg Thelen <gthelen@google.com>, 
    Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
In-Reply-To: <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
Message-ID: <59e3dae7-a203-2e1d-3b65-875b7e0e122b@google.com>
References: <20260709224330.946683-1-linkl@google.com> <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org> <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Jul 2026, Link Lin wrote:

> > > Fix this by:
> > > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> > >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> > >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > > 2. Re-registering page reporting in virtballoon_restore() after the
> > >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > > 3. Unwinding virtqueue initialization via remove_common() in
> > >    virtballoon_restore() if page_reporting_register() fails.
> >
> > AI review thinks the patch didn't do the above:
> >         https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com
> 
> The AI reviewer might not have parsed the entirety of the fix I proposed.
> The patch submitted definitely includes the changes to virtballoon_restore()
> for steps 2 and 3 (re-registering page reporting and unwinding init_vqs
> on failure). It seems the AI failed to parse the diff correctly. See:
> 
> +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +               ret = page_reporting_register(&vb->pr_dev_info);
> +               if (ret)
> +                       goto out_remove_vqs;
> +       }
> +
>         if (towards_target(vb))
>                 virtballoon_changed(vdev);
>         update_balloon_size(vb);
>         return 0;
> +
> +out_remove_vqs:
> +       remove_common(vb);
> +       return ret;
>  }
> 
> > It also might have found a couple of pre-existing bugs in there.
> 
> Indeed. Regarding the first pre-existing bug found by the AI (leaving the
> OOM notifier registered during suspend, leading to a UAF if memory pressure
> spikes during S4 hibernation):
> 
> I actually addressed this in the commit message:
> 
>   "(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
>   from an identical lifecycle flaw and are also vulnerable to UAFs during
>   S4 hibernation when memory pressure spikes. This patch focuses on Free
>   Page Reporting, which runs periodically, to ensure clean backports to
>   stable kernels)."
> 
> Regarding the second pre-existing bug the AI flagged (leaving uncancelled
> works on system_freezable_wq if virtballoon_restore fails on the cold path):
> the AI is correct that this asynchronous work cancellation failure exists.
> 
> Since these are separate, pre-existing lifecycle bugs, would you prefer I
> roll fixes for the OOM notifier, shrinker/free page hinting, and work
> cancellations into a v2 of this patch, or submit them as a separate patch
> series to keep the stable backports clean?
> 

I think it would be best to have separate patches for each fix; Andrew, 
please correct me if you'd prefer one patch to address everything.
