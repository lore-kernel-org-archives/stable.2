Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74743803A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698444; cv=none; b=fnURYyLtwQTX1PsmxOpNwYpVQ4V1qEtyxLZdHY9t2tXjf2pAcQBVgcX8uT67cNEQI5kH3kA+nnTYVxq+EKWqKi/z5Lyum5bw546fJvGy2joWiAmSoMphzIgQtVHR7P9DLRHNT9GTyVbJo7dtT3N2iy+6oy33V78N50aYAv9pNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698444; c=relaxed/simple;
	bh=ePCbnM94woPFBEAhYEbp+ydZtO5vCzsjSDw668DqpUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1P9u68WPdwSuMzE0KN6S2fVUKBDd9R2Y+W/tLQRA4OtgrAnYtLyWIyQeepCyOQqUUYbyfp2iB4VcKzgSzq7xL5krei/CMAaDIdzohE4EldQryFlNg5Ahy/lO2Vji6/iTvacWPp3x+r3NR5W/9VdjYgTs+ihDCyRHPYtLH3LOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8yN4/jV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8yN4/jV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8487eb67173so925350b3a.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783698440; x=1784303240; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2o8RM3DU4+oABpSO+Km7GLJNJZxTuit0tDVpvpEDVU=;
        b=b8yN4/jV8HG3QOyiLb4aQsENJTNwsWLPk7u0juNOzGwIYAutypT65rXKcTqcoJuBkv
         zKt822gTLXc7Gp9eJLyd3zndeff7GtEBpGmnIIPqKhd1gXBY2rxsjYNn8uE76ANnDX6R
         XuE4BDIgUWON8onqZ5XLvD2qP67XytbixbTHYvMKDLBTw4lgNVYO4Of+Th4qSnp8ggIW
         Xt2S2gtUcGOyYULOQDv/iiOj6A0lTCYNuj+FtPPN7ueylOt6HDJBGT2mCdA3wImNLKBF
         GYaBmGqTuho7xzWYcBjKzWjfKmV5L4ByWdjqmITSxu8yX31U7Nxd5P5M7x0knroEnDLm
         wY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783698440; x=1784303240;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2o8RM3DU4+oABpSO+Km7GLJNJZxTuit0tDVpvpEDVU=;
        b=fUkfnmxAXNBkhBwxEPA9eWs42Or+ex+5mo0fv1pDLgyKr3Rq2QEM0BmFlNz0cfrfgi
         TpBcuMWIF8uSZkB1PxGeLvv8H9HOI9ZaX/cPMQQIefza/uFloWHMNfBLgPalRT5foaFd
         zoFjAz6cvDKkArcLkFgb5tNHKdK6GF2OmDDiQ8rDO6boqjtPUkRg+DJEGON+uapGd7ij
         QCK92qT89VCpO120izjYBLQAM2UuLzTXG9Sg8HrB3QR3RXkCi06o7VmTijdHcssJQ+o6
         cwNaiXRWtQOpTWGJhh9kFoTn9te8yl1227e2ghuCPlEDyA/imIzS+4F85F6b0Ls7XF8j
         9PBg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2iJuc+ZV8tn7UI6I1fzP6gksSrYVcPRZb5RbESdhbmpIpnoSxlieT7k6mqHv55hyBRo61UTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQWgc0JAn3GhnRh3ob+Z81GqBshGbl80UsOcHNdv8yuFTW8Cb
	7W9m6hNGsEeE/Q+ET7xjV2f/LQGB5lQwJpMwawcqZZ/nypiKGvozFXYJfpPSLbf/N3XxJNbQebv
	sEdqSNQ==
X-Received: from pfnn21.prod.google.com ([2002:a05:6a00:2b95:b0:848:3d5d:8106])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9067:0:b0:846:1b9:cb63
 with SMTP id d2e1a72fcca58-8484356de46mr12723650b3a.62.1783698440079; Fri, 10
 Jul 2026 08:47:20 -0700 (PDT)
Date: Fri, 10 Jul 2026 08:47:19 -0700
In-Reply-To: <62ccb0f7-a619-41b8-944e-11ae2d0ce70c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com> <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com> <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
 <ak-uER-RndpksnhR@lucifer> <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
 <ak_A6Yc5mBXCrtXr@lucifer> <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
 <alDtzM28CgZJn6FF@lucifer> <62ccb0f7-a619-41b8-944e-11ae2d0ce70c@kernel.org>
Message-ID: <alEUBzV1cevuPYeD@google.com>
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, 
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 10, 2026, David Hildenbrand (Arm) wrote:
> On 7/10/26 15:05, Lorenzo Stoakes wrote:
> > On Fri, Jul 10, 2026 at 02:57:55PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/9/26 17:44, Lorenzo Stoakes wrote:
> >>>
> >>> OK as long as that's made clear in the patch, commit message, comments etc. :)
> >>>
> >>>
> >>> Ack yeah I assumed it was a quick proof of concept and just overlooked it :P
> >>>
> >>>
> >>> Thanks!
> >>>
> >>>
> >>> hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
> >>> without - any checks that exist for that btw should be extended to this noew
> >>> flag).
> >>>
> >>> Also don't we want to encode the legacy aspect here?
> >>>
> >>> Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)
> >>
> >> I'm confused about the _READONLY, well. and the FOLL_PIN_NO_GUP_WRITE.
> >>
> >> We want to longterm write-pin.
> >>
> >> @Pankaj, how come you would call this "FOLL_PIN_NO_GUP_WRITE" -- why "no GUP
> >> write" ?
> >>
> >> I agree that someting like FOLL_LONGTERM_LEGACY_* is the right thing to do, but
> >> I don't see where this is "no write" or "readonly" ?
> > 
> > I based it on Gupta saying 'without kernel GUP writes, and therefore not
> > impacting dirty tracking'
> > 
> > I mean I think we definitely need some clarification here yes :)
> > 
> > Not really got the bandwidth to dig deep into GUP again :P
> 
> I think the KVM gueest *will* write to these pages.

Yes, the guest will write these pages, but through KVM's normal mechanism for
mapping memory into guests.  The host will NOT write this memory via the GUP
pins though.  KVM needs to pin the pages because the memory is (well, technically
may be) encrypted (by the CPU) with a key that is only used/accessible when the
guest is active, and the encryption is salted with the system physical address of
the page.  E.g. attempting to migrate the page would corrupt guest memory due to
copying ciphertext that would decrypt different at the new PA.

> By disallowing writable LONGTERM pins on FSes we broke one existing use case
> that was relying on that to work.
