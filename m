Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221B384CE2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942198; cv=none; b=icZx48x06+8S0s40z1E/nIaeuUT3uLX8/YghhbSjPhc4+6fatvYWCd+CjaelC8o7Um+BgXs/ipkKcnVUaBsbnf/MOOTjmCY1mAuDfI8aO6gWlYc97PDRNWjWl3ZfTmzaK2SxqMYjLOmgM+Vio4bvYhkB9c3qfw0mzwcQ5T26KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942198; c=relaxed/simple;
	bh=PnRDEvEKGK8QCid9k+DD5dOVSBhMOu/gMo5Iabx3gfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJvNGgVrB4ejg6GuN7RV0LEyXltlaswM4tneBvywgWCEaDCyi9mdF6tR8xuZmDGmbow4zNnvQhnFmP1b2yU9tnkuP+LMdyQ0s7awdbS9XKrhocbt95pI29CoTMKLtfrLRLhCEYMy6xP/EjIu2d37pbdcjt0BfYfOBp37xr9ATuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HDS8B0pC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HDS8B0pC"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1360233a12.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785942194; x=1786546994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fweq2q9N+GbrkbN8984aDLyx40KVYsi1455vY8kKwdc=;
        b=HDS8B0pC2tKPOIb4dirbPm48iE3vPjvh/Ye2p73TL4MPKiJiD3inYLWWinxQ7YTWGT
         WsudJpuNhpFZNOR7ZVsHnlmr9rRZ9sGlG47QjiIJG6f4GFYx8LCviZE4KEiW9j4/qpQs
         FZ79tK8TCQ2Sv9QMEAHg4hcoGjYnB99zyhpQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942194; x=1786546994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fweq2q9N+GbrkbN8984aDLyx40KVYsi1455vY8kKwdc=;
        b=mfVTMOOVagd7aHU3VrR4LvzzHFdCsDPkhrhabTVFVcIUNdqPXsaIcc0F+PMV6dGkUG
         qA/QdOyU5VBOcM8Nu3nWWfzbFysE+flyQNsumWQV3RtTjbdVqR1CGvPvgUqQd41qyhnd
         uQ5Ly6PZJmtClXoWMSFqx1Lz6QMfWQwsEVJ4yQxVy1BAzzFL9oMOzI7BmJHoPnGhn33w
         cJcdtL+Tvae9a7mN503P6j4+vJjfDWjtarezIs5I7ycnVrt+/iQb12nYyV/HxlHUbhvF
         TsVq7OCu49a81bOdaKxUXMwExhJsSV0FyADljox/c9gv2L4Bnnmt9ISokNjcGtfofGBg
         ykRg==
X-Forwarded-Encrypted: i=1; AHgh+RoKpnaFbG617IypFullRX5iIgcPCfdL6oHhAQdXqChOTSem6jvwbOiwc6BLZvCNC6p/aP7kvS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62GeiUW11GX3Y71WMofCWyacbxzUqaskedWDLkjyU04hKDYm/
	12BH+8GQXJfCGtcQAAHP1rQyrh4jBLaZd6ygLR3ylctwh/hwzg516j7t1TPX4a6QVdrsB/DmiGI
	li8TIEWl2ow==
X-Gm-Gg: AR+sD10BP8CR3NazImaUT7C2cHY/cumeM7U8rvppiv0deQ6JS0XlmBLaXrEE+C0IbYX
	Sjo/KLuyhgKZhwT/2/xs6B9eVRnsK113cM79plX5FevPFohbBKdQJFOBC5UFUo46lUItOcNqaX0
	T0D0lKMC0kl5HcRdAnAdiZucgz1sNVO1NN3wr5VujsP93gHfD/T6rI6FblMbb8rLFxU4dd/SbJm
	8jjwe66v0EztNeM5l1J/fVrWEVmuQek1G405pSJCcF44A215/RLMpxFCkGCClPZbfH+S0rHwPAX
	7J3I9/zZztAxUmVfb2O0szPvJvUNdDCR1VyDcIdxTZ8gBTqGMC6xfUzK4dKYlRZ8u5Y1YOfRxvz
	mksCstLM8+sMS91yzVm4mrlgodqVL5rAf4AD1oK8fPCYBd0GfL0qg/azLiJTTH8TO29rtdWpZfa
	rlqGS+xus0r6ZNFfFYYBbHFDXfTS+JGZpOOjH42TLTcrkO3MDXTFt9/UPjjBF2G7+Uqlyy7RTmS
	8xK7jKOECB4Hi6h5it1O3pzBZed7i/H5F9b9Q==
X-Received: by 2002:a05:6402:2714:b0:69e:8ad:515f with SMTP id 4fb4d7f45d1cf-6a14f0c508emr3799160a12.6.1785942188899;
        Wed, 05 Aug 2026 08:03:08 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1462c5d4bsm2230441a12.30.2026.08.05.08.03.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 08:03:05 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e592da74so140973066b.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 08:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqn3IK3aRaLMGyDCT+QDfkaCRgE0NMMgLI7Bn8Xsea83quHzeGiqXdpm4YCkoaba69M0dvJPP4=@vger.kernel.org
X-Received: by 2002:a17:907:a648:b0:c16:72ba:d352 with SMTP id
 a640c23a62f3a-c2039f27638mr367831866b.31.1785942185481; Wed, 05 Aug 2026
 08:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804003708.49830-1-luto@kernel.org> <0adaae9e-7086-4213-811e-ba6e4181e145@kernel.org>
 <CAHk-=wiO8NDCyBYrDMpjh8zMKnzgD2XuPYo0nk4Hwgq44R_jKg@mail.gmail.com> <5130d601-84b4-49c5-a9f7-454d54a7412e@kernel.org>
In-Reply-To: <5130d601-84b4-49c5-a9f7-454d54a7412e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Aug 2026 08:02:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDfNV9BfW0r8c7PG+hBtDothP-9OROcanTLKDtujmBfA@mail.gmail.com>
X-Gm-Features: AUfX_mwvh3hDYxWJBrQyH8medqHq7XML4QZ1n7h1D8u6_NtrvueYHTrBQclTEqs
Message-ID: <CAHk-=wjDfNV9BfW0r8c7PG+hBtDothP-9OROcanTLKDtujmBfA@mail.gmail.com>
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, luto@kernel.org, linux-mm@kvack.org, 
	luto@amacapital.net, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Aug 2026 at 23:04, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Can we get that fix into 7.2?

Applied to my tree - everybody seems to agree it's obviously the correct fix.

           Linus
