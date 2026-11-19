Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125512;
	b=gy1IW31ZxkButJfqhNJ3HeE7nJyMwnHScoytUp/N6S+3PFVEPHJdcp0JbCQfcgqfF6SA
	 U0l6P03a9Wr6T3pz069/y0B5AkJk1pFGg+9kokm+itmXpCyITcNRq81dS2HQegAOjqwAm
	 vDqneETcRKWY2YJ4H851vWtNywxWL0t7uJLfYeymnHiBdQnv7gRpxHofjRn2jzwXfWAe4
	 KybfemRzB8bPhorOcgYoPALbQqYtyilt4Z1cT+ARmOhTDfxYXX9VFeSoBBlk8ijZTq2aF
	 qF0NOcDT1AtSVQJm7o6Mb4m2n0SI+kfbZkpJd+zk9TT+8t6U+gbeUEeUc/wEzWFYVQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c8SDR2t2zxVahCHAneVGOMZ3puioc9QoYqLU0d97Nqk=;
	b=vH+4L9xkMbSAw+bSLhbI3oF9Y8qzUgTF/Wabcvf2H0UczDiAkCXIdjlAbjtWKcJrxYKv
	 ih04dUnrB1JJmesLVq/Y+wtJVYBI60zSA/xgJ2km2v4pgN303Tgi6uUT4O2yMcOinp0D+
	 x1JEWZz78Vj5gE8FqPPNcejriLCRnIONnIPusds2Jca3oCn4j0oeBt2CcJ78ntsynJ/mf
	 oWt/c2ObbDB3PHKVM/LQXbCmgnFLdfhGLz14C+gBgZCM5bkJfZa1XQzvSBeNRdFXT11ol
	 WPg7fbiLMZD1xHR1g6x9zplpH0KEwFE3q9N3/mylEbWv2HQLivXT/98JDTsiDDhnRSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLqObKIh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A8606A324;
	Thu, 19 Nov 2026 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLqObKIh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96361F000C0;
	Thu, 19 Nov 2026 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795125512;
	bh=c8SDR2t2zxVahCHAneVGOMZ3puioc9QoYqLU0d97Nqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lLqObKIhNNygk4h2p82iI261CxTr2k2iY7ayjr3+8jnZqelIIDtb7ImBiKsbVC81i
	 kJpTPr1JSVDZe+BADiKqaGTMPrdC10YlCHIaF33ijt2YWvD2JMIQ2iq7jfWdsgT2nJ
	 8yCSPWI78Use2UT0j8ekj0uwBhV/HNveSEX09INgg6WGWzOZowNAGJfhG5YADJ3Puz
	 XTW2cnC7o5eON1rbY4EYT4e7cWOODWW9XO2wohGTA94oSKizYwDqMfbcv/DxPAWam6
	 ctMoZdwNn/OPz+IMjwcWQxVRpMS2j7B/1JRpQB/iXO6Wc4qss5NthvifjfKYuUf20s
	 axP8cloY269SA==
Date: Thu, 19 Nov 2026 21:58:20 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 00/13] mm: batch of (urgentish?) fixes in oomk,
 cachestat, dev-migrate, percpu
Message-ID: <av9wrAMy8tzYPyOh@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <90a961f5-e488-46de-8872-0e1540eaad4c@kernel.org>
 <av3dRm-Gkx9kcYWj@gremlin>
 <c3098f88-cb7c-4e9e-84e2-1d22023a795b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3098f88-cb7c-4e9e-84e2-1d22023a795b@kernel.org>

On Wed, Nov 18, 2026 at 08:47:49PM +0100, David Hildenbrand (Arm) wrote:
> On 11/18/26 18:21, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Nov 18, 2026 at 04:35:32PM +0100, David Hildenbrand (Arm) wrote:
> >> On 11/13/26 22:45, Lorenzo Stoakes (ARM) wrote:
> >>> A bunch of fixes for oomk, cachestat, device migration and the per-CPU
> >>> allocator.
> >>>
> >>> These patches were originally AI-generated, tamed into upstreamable state.
> >>>
> >>> Some are more reworked than others. Those which needed a significant
> >>> rethink are submitted as mine and marked as Reported-by the relevant
> >>> original author, others are smaller edits which are annotated as such in
> >>> the usual fashion.
> >>>
> >>> Please check for correctness, sanity, and whether the cc: stable is
> >>> warranted (I have not included it for 3 where it seemed unwarranted.)
> >>>
> >>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >>> ---
> >>
> >> Lorenzo, I would pick up the migrate_device patches now.
> >>
> >> Which one should be fast-tracked upstream and which can wait for the next cycle?
> >>
> >> Use-after-free, shadow stack and out-of-bounds write ... look rather bad.
> >
> > I think given Gregory was able to repro nearly all of them, I'd say most. They
> > are mostly small. So patches 4-9 I think should be.
>
> Just to clarify: The later we are in the cycle the less non-hotfixes Linus wants
> to see. AFAIU, really urgent stuff is the exception.
>
> So the question is less "can this be reproduced" but rather "is is that bad that
> we want to fix it asap".

Yeah I guess I'm kinda saying it's hard to differentiate between them :) or
maybe I just want the migrate-device horrors to stop :'(

Given the ones I reworked fully were more involved maybe those are higher
priority than the rest, as a litmus test?

>
> >
> > Actually the shadow stack one (10) is unrepro'd and super borderine and requires
> > a broken driver and etc. etc. so I'd say that one is less important.
>
> Ack.
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
