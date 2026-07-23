Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBA4DB569
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815705; cv=none; b=bruSHX7p6o1jv33jsFkgBne48YZ7bQMBtlBTJcb93hijmRmJqpwgBwQU6Y+vr0Gex5BntxJTUVtDCmQmL9j2p8XOAkmTWZOU/cQy0X2IK+L1sO9gnyN121v61hct6iA34yckrb9FWV1fP0jO/RMRt6X5ESVfhpvxuh4ytDzJVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815705; c=relaxed/simple;
	bh=Qm7I3MrgptB9N82eE6rSVqC8Xy8PeWEcsYX1BX5gMbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dedR0NJTn+klxotGU6SlDvklVR+Hj+XaipKCZr9NMV8zwVRlu+ad9ABr65O4DdYOHcvhJ/6f/f8c5B3ZPsxxqTBW8QvHfks+uQWZ7PmvjL/M+NKbdrNOFiRpV3awT1MPU190DdmjXI4xCj8uihIuK9MpisqUAzrYzkB/Tlt+rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=KD65oJcq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="KD65oJcq"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f032b47e3cso5344356d6.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784815701; x=1785420501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Llb6QhT2IRvGCMWqpRY6F93Ek3l1oCqWy7Lwtb+z6mY=;
        b=KD65oJcqACqffo7DAHYbKBnwIP4yRPp631bC08EEDFean+7L/dx0nudXy51iv+ZVKH
         ebz1ZU5Bq59l45W5RQkmLWjri484HFqtoe8rUR3QwkmBGheLULEwpsPDkV/9tip919P1
         /ryS/YKEIbyEgQEnpvZlGmIYbMmlmtxfdWj5BvrJ71rQ2Ji5xfHkdmokx1oxFbb8A8fA
         znhR9WrRvIla/5UIo1JNar1oEe7lD4jGwcgR90bHArIZVurvFZjoe/BJg5Xc9nkGE8Gg
         wzTuKRzKV0lAx2WmRkcAPcO+JR80ELJCcq66POVBwayr4fW4U81ZkF5CiheEl0IFDQYs
         +/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815701; x=1785420501;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Llb6QhT2IRvGCMWqpRY6F93Ek3l1oCqWy7Lwtb+z6mY=;
        b=ruZdmd6RRwIjyiThYWCg8JoA41skdqo4uxjA4o9qGFbqmN6QylOb4ZqscJnUXcZ/xL
         CSB+kezc34dPHXkSUB3zoN664VgUvsCd6f1hsD6naBMjkjUXncnxpo6Cm2cw6bnX/01t
         hdGHP/nuCwchYp6rr3oivbFW5UqGOKdEaBsN15p5HmyfOzuazIoenQp6m/eDOxSXcyAU
         ml+asyop9bIUgq3AUsHyzMlsiiA+GadG/25GrlQRVEJwBCUzhvVWDZoUReDUbS7PARei
         1hoU6LJu+bWYf5izg+gG4Vo4pUkRIewee29XF4/IEiErEJHAW0xYmYk0KDL8QehpFmgm
         0jRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqWKnMTKhaIk56VMBZPRAl6p4N8af+XFNxBApj/mDMIRbfVlUopHMAt05/36ilHFxBeBIEjjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWc/XRWwg52nXnZxqW2tyfUb9BxYqCDpOzOof0N7K3EYGKSFp2
	cOHwmxp1nQcuTIY2R2thLPAVB4nlVrnEgXBuChU+cTgXsFm+m8pzEXQ/Wdex9cxcW80=
X-Gm-Gg: AR+sD11dRYScYyC4RImSsMaVf6VInRJsJHp4C4rTLtUcHt0iY7UwWNKQ+GZ2f6hTraW
	g/5kxKiO6fylOtej38TTpfX43p+oZ9FHwAFCfAc+t9nm4Fqqpt4Mszm1Y6ae6dXB+8ArNQp18J6
	rbB7pk33j2ft7O9hvSCAz57MRZ/zAfFb/SVhf56KBUPVdKgRnjf+XuKD7OSOYNi7m+1/6W0IA4s
	0VjrvZ3cI/n8r/8VKVqQsM3Dl07wNlGUt9C8+otFglmhXPCjiCvpArHov4PtzZ7Anmw5h3WKDqG
	Mns3UatzPwaGKCHNuwVRwla98rrlB3kOb6yHcHsxD1h7WynIa/SH5+8OVdLzqz3a3qemtDaU8il
	dOLUu4eoZyWU9oCVaFz9Qausy/N6X5++OiXrYBsRGXG4n+OdImz6W2s1qyRRb7dcuByeT98LaHf
	goETxjbGKVDVg=
X-Received: by 2002:a05:6214:411e:b0:8f1:1bf9:5119 with SMTP id 6a1803df08f44-907ca5700d1mr36458076d6.8.1784815700473;
        Thu, 23 Jul 2026 07:08:20 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27ce6sm45312476d6.45.2026.07.23.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:08:19 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:08:15 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-ID: <amIgT-l7PExKVJlW@cmpxchg.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
 <20260722162207.31a2c491ffaf36d1e8948c14@linux-foundation.org>
 <67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>

On Thu, Jul 23, 2026 at 12:22:58PM +0200, Vlastimil Babka (SUSE) wrote:
> + Greg and Sasha
> 
> On 7/23/26 01:22, Andrew Morton wrote:
> > On Wed, 22 Jul 2026 10:56:47 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> >> 
> >> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > This cc:stable fix doesn't apply to current mainline because the
> > preceding non-cc:stable patches get in the way.
> > 
> > This means that the -stable maintainers will have to ask you to redo
> > the fix to make it backportable.  And you'll then be preparing a patch
> > which hasn't had standalone testing in mainline.  All very cumbersome.
> 
> Or they backport the whole series, even if only 4/4 has a Fixes: tag.
> 
> > So is it practical to make the fix come first, as a cc:stable hotfix so
> > we can upstream the other patches in the next merge window?
> 
> I think it can't come first, it's simply a complex fix that can't be done in
> a single patch that would be reviewable. 3/4 is certainly a strict
> dependency. I'm not sure if 2/4 as well. Perhaps 2/4 does deserve a Fixes:
> tag and Cc: stable on its own, as it also fixes a defrag_mode deficiency.

Yes. Only 1/4 could be argued away.

2/4 actually came after 4/4 during development. Without it, compaction
cannot make sufficient forward progress on the promoted non-movable
requests. So it is a hard functional requirement.

Whether it deserves an independent Fixes: depends on how many
GFP_KERNEL pageblock_order requests we have :-) I'm guessing not many.

> > (An alternative would be to put cc:stable on all four patches.  That's
> > a bit abusive but we do it rarely).
> 
> I don't think it's necessary, the stable team are quite capable of figuring
> out the deps and backporting them with a Stable-dep-off: tag. IIRC the
> "fake" tagging is discouraged? Maybe they can clarify.

Yes, I *think* it should work with tagging just 4/4.

It won't apply cleanly or build without 3/4. So I'd assume if that
dependency is lost, the automated backport will bounce and I can send
a backport series by hand.
