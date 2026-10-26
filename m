Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021825;
	b=YLUHvZM0JUGvK6uVMLPN7jB1d55joC342Q8SDknNy+R6IJjkY7JhjV/0XhxIlkp2YBXf
	 VAwJF7UgaX63RoYKixe95hmXsInwwEFEXsc3hwNwWFATOZOZz3GQv59TCbzOK+YQPsgax
	 f22h+Aop+KCNGkPkGZGzuLDJNNfSAcJTtJOKf/WfgjNYN5BMKgBK1VcddqQ81wUUSMUSo
	 9c/7T0QpYjTgO96K0SZF9CJ3Bdfh9MpfOUBvD62PQackEqCguV/in7hJjtGjCtgebS34R
	 r/XkyQ2x390zl3m95ShXPyMewCNOjw6I09NRoAbBM3I1R4On3Qyvhe93IUvx0lx2wfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021825;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yabj1QHzxuPl05POwsxt8pGUgDVyDjWk14HZZE69wyE=;
	b=NQZf0KixwspQw7mXcFeu9GrT+EdCWq9lsXLTzQwVnlDguixcUomS/46TpgxHa6MploHH
	 YcryGs+UHh8UF2yfeJGu4nK9MWzPj0wwtcRWLGwqkmQaSQlCQGmNf62D2uo7IMjBjFA3+
	 MwF/Td/998svzlQvC5rS4hZMsqF+ctPY9BdiVM+C3JmN222PVETvzPpF2cgd6NhhLHNoZ
	 mxCyZTG3W6Rqwy36AwyzU2y4ndjyqVhQfk85q/Mnofn9Uk/tN/HqPhWs+GBM93Rc95WNX
	 kC2BTbZruVGuV3dQklOX6oF1B+dgBU9HoDGdhe+TV09r9lZeUXQg12mNOIIOj0w+DaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1JDXHfK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C870606A322;
	Mon, 26 Oct 2026 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1JDXHfK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8512D1F01825;
	Mon, 26 Oct 2026 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021825;
	bh=yabj1QHzxuPl05POwsxt8pGUgDVyDjWk14HZZE69wyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X1JDXHfKBCQHRpmIOeJKdV2OiXBauhmvwQ6KRaKHeIOWf/dJWYPAU2RzbumxF+Eam
	 XkHep8YA4WkK7dur8FFn4TOh6ZDR2OHNLhLADSTb01Er11rdhgsj0R1lTFO4s0XIIT
	 U9strcR4euCGy9aJpzdM+uJmsyF0TsIt/f1A8pe9Ofc8JIplQyJNgRxTRJa14XeAh6
	 3tr1Udq2aFTwD/lDFS+2mK4h9A2mWEeZRfEU7gNIG9YDdz/21LBGy6RiXJwaKGhLUA
	 TfW1pQKHd+kHTvVXu25rE9utOsVaHuQqxieHc1Vxqf1nv3jIRPTIAirVTiQigY5s83
	 r/JOz9OuviUKA==
Date: Mon, 26 Oct 2026 13:37:00 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Message-ID: <at9XPebgW02oF5er@gremlin>
References: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
 <44a9f234-aeed-4986-8660-608b8a23ecdc@redhat.com>
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
In-Reply-To: <44a9f234-aeed-4986-8660-608b8a23ecdc@redhat.com>

On Fri, Oct 23, 2026 at 02:11:39PM -0400, Luiz Capitulino wrote:
> > Reported-by: Luiz Capitulino <luizcap@redhat.com>
> > Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> > Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> > Confirmed that this fixes the repro and passes mm selftests and the VMA
> > userland tests.
>
> Thanks a lot for the ultra fast fix and for the attention you gave to
> this issue.

No worries! In VMA, we aim to please ;)

>
> I tested it the same you did and (of course) it worked. I'll work on

Great glad to hear!

> testing it on the environment that reproduced the issue originally, but
> this may take a bit. I'll report back if there's anything unexpected.

Thanks, appreciated! If it's all OK be good to get a Tested-by also.

>
> Another detail is that I see that you CC'ed stable (which is of course
> correct, since this reproduces since v6.1) but I guess this fix won't
> apply since the VMA code has been changing a lot.

Yeah, I'll deal with that when the backports happen :>))

--
Cheers, Lorenzo
