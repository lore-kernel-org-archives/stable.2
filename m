Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7224325706
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818971; cv=none; b=LMtKFYTihS+fdBxfimCGNJSfksOitTNTs/QCIqBeJBq6ZLK3jSR5QWcaIlSkNW6zeVNXTfK6EpM/gBtdYncsN+UVzm7txckJp6J8LXaokpn4oA8BS3bPrnDEqly+9QMHpevUnZ115ATLvhBKrbHxH0Wdm+1fJjQoAijsc022mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818971; c=relaxed/simple;
	bh=0vL8OtmpIyLy51Fv9riLDUryAsugbB3gKKFEHjgNdjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdekuVQ9LH3tHMvRA29u1t6wHukm93Qz5yh8Z9RKoRhI9BrPc/vuC+QXzI0wDLzwkVnWLoYLv8A5Ys/HMLopEGeNhufDYK6K+4T07TnOfCgAa01z0MpdtOxXRP76JraQL3TFi6B+Zf/n+lrB7bnZFS4XDZjM1RlCSKJFJlB3fBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RGzzoStW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGzzoStW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec450b950dso201819066b.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781818968; x=1782423768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5p66b7ErYnujJAGTcgTXIBPkgQepiYPJRliMjdpdxZU=;
        b=RGzzoStWu2dmRsTrIk5xaZ9/7EduSff/1L8EoR8RN9feJsXUUxaEYqGjo5X3ycTS6J
         dH8A5aZijs0QzLJFCpBifbLMNZu0uP0eWK/bwOe76SlaT3DX4rwLvKi7kgpYcFVos/pH
         tBXRWxnTiTziAb0d+N1YL+Khiko7E3v1YfBv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781818968; x=1782423768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p66b7ErYnujJAGTcgTXIBPkgQepiYPJRliMjdpdxZU=;
        b=jRVkK8DmgQXQu+hvf2qxA95KK/123+SJ/fmcg8Lvn5ITbbDvwyvAwZ6MZg9LhJA+/l
         mawm/FAOBSZrtknjcQmGJQUiTghp5Al0iFDBqFRD4la2792QbSMT+LDEfOVSivk0KBfV
         KKPXcpc1o5CXeSzmYLSQzW0H4YIaVi1W+nFZ8UAiuOjqPyrbLD2nXWb4dD3jTIOS3EL9
         0uMdmyz4p1ViUyghevfMwWa6T1uzgiKanfhJTgnXeF6sOMnGgk/s4rCr54xMOmhVgq5W
         4ftQPSBG9E7+0jZPly2NruTnJ5iySOh5c/W9gmhIS7cMmMyhDGDEjNpWkCqOekaOM3Y/
         dS1A==
X-Forwarded-Encrypted: i=1; AFNElJ/yUQzR/oYY50gCsfsbWka6M8UX19eNFT4e4PPvF2ayJMcn4559WUUSB8HbSKMcMij3+bg0C/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9rHoUMlDGZR/QX4zsDGHepgzle+IqJsolwc2YAdHrreCVnK/
	5h4R7iZZZJYre8bEb/T9a1Uo45gGGq3EMVz0ctsV9W3GdoN0Qhdp2VwToF8uTTPeewHbejJis0n
	lkSmA4To=
X-Gm-Gg: AfdE7ckXvACGDzhUN5sg3agEMbI5Bzmpw0pyd9o1Cmd2Y+Pgy73Bo78wCaLdyekcBg3
	IZYwTGWLOPocH5JeO4nJnVDzOsIL2Jr9gvGOevBlDpFcnQ4ykIfCqY3jOiNhWKZ+uRxW3uQnf/g
	ZA9MF0VEfUZuK+TQ/y3fI5wZgtSqHz7llFBdCgDJbGv2jRcFVWQt9cCMytG6kCFwkgiILJ9O7Je
	pR+m8gtkb6fnYr3byiyvvxNrMDELdV41wUHky9Eat5FWwagQS/GSLje6MV+iTBPUBAUV98uXcqd
	i9/jC1YVtAiAIcj4pYrGPNTxyC9bSVGKwegjDBtR/D9GPGyGWIz/W0GFz6LHlNC7NH4Cr+wHyfo
	++wSx8A8S79Z6+PKROqz/01z3v4rF5ebmM5XWb3KfzypCqYdKmAK9cVwTAWVlhIZz54Rn3xic60
	prWeoAZ1W/aJRr7ydnRak8qT4sISy1X2k/TeTjsBTXviIPpZanTpU2FS7G6BBL
X-Received: by 2002:a17:907:d02:b0:bec:2ad0:cba5 with SMTP id a640c23a62f3a-c097cfb117emr39253666b.29.1781818968160;
        Thu, 18 Jun 2026 14:42:48 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0a844f53dcsm7898966b.8.2026.06.18.14.42.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 14:42:47 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec450b950dso201816266b.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:42:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8KZXvp2SGKPDHcX3bQlut8K6HSrmZDdcJBuexpVkaHUPHhXUG8RM+E1tfDVwQGCwG4T3z8MaQ=@vger.kernel.org
X-Received: by 2002:a17:907:96a6:b0:bd4:8b66:c374 with SMTP id
 a640c23a62f3a-c097af88bffmr48299266b.9.1781818967276; Thu, 18 Jun 2026
 14:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618183442.BBCD71F000E9@smtp.kernel.org> <CAHk-=wiQ_10MRYYW+aRfLP4Ah9gDrShOvLESXtz+Q32-9M9Y9w@mail.gmail.com>
 <9bbaa053-ea06-4b36-98ba-dc487a28964e@kernel.org>
In-Reply-To: <9bbaa053-ea06-4b36-98ba-dc487a28964e@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 18 Jun 2026 14:42:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWhvmy5xUcTMCJZats2cUJ5iGU4o5Kdt+OvRepu+MUeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfUDD-8OyBQi60IPQ8Cw_tmpKz1_FAb_-Rqt7HFrCB8V1vZaaUbe2FX8yM
Message-ID: <CAHk-=wjWhvmy5xUcTMCJZats2cUJ5iGU4o5Kdt+OvRepu+MUeQ@mail.gmail.com>
Subject: Re: + userfaultfd-prevent-registration-of-special-vmas.patch added to
 mm-hotfixes-unstable branch
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, 
	vladimirelitokarev@gmail.com, viro@zeniv.linux.org.uk, stable@vger.kernel.org, 
	peterx@redhat.com, oleg@redhat.com, jack@suse.cz, brauner@kernel.org, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jun 2026 at 14:07, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Maybe we should rename and possibly split that up, like
>
>         VM_NO_MLOCK
>         VM_NO_VMA_MERGE

That sounds saner, indeed.

> And then have some generic "there are really special things mapped in here"
>
>         VM_HAS_SPECIAL_MAPPINGS

I think maybe we should stop using "bitmasks of VM_xyz bits" and start
moving to a "helper inlines for vma testing".

That way we could make hugetlb not set DONTEXPAND at all, if we
instead just introduce a

   static inline bool vma_can_merge(const struct vm_area_struct *vma)
   {
        if (vma->vm_flags & VM_SPECIAL)
                return false;
        if (vma_is_hugetlb(vma))
                return false;
        return true;
    }

Ok, so that vma_is_hugetlb() thing doesn'ty exist - but we do have a
VMA_HUGETLB_BIT to implement it. I wrote it that way mainly in an
effort to make it all make sense logically.

And maybe we could get rid of VM_SPECIAL entirely at some point usign
these kinds of helpers - by making "vma_can_merge()" and others that
currently use VM_SPECIAL use the *actual* real bits explicitly and
simply making each rule have simple and logical tests.

And the reason we should pass in the vma - not just vm_flags - is that
often things like "is the vma anonymous" is part of the decision of
what can be done.

I think this would make the code both more flexible _and_ more
understandable if we had these kinds of helpers for different
situations rather than have VM_SPECIAL kinds of flag combinations.

But I'm just throwing this out as an idea. Maybe there are better ways
to deal with this. The current code does seem rather annoying.

                Linus
