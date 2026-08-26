Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2BE352034;
	Wed, 26 Aug 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761115; cv=none; b=G9oASGBHgO3TS/CwZgP3Qd0OY5QiOQHoffua8YrtHirmLnIJ/Wrx+vtELoAnaWJjxeQTkcu1oUCNn/Vgql9KyKpSBvQ+HoABr3m1Xm/EtLtPPznMDMEwAqlKwFJtpVB9IuUZe6UArV7sRTYMmEO2sLA87yvYQHWm2+qWOc+CSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761115; c=relaxed/simple;
	bh=/KVGzZ6bCLrBPb8pvmrm7J/N+QzEWznI/LjnFx/3QBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icut5tiY9YtQn4nmdoBnint4vmZlyD47KtL5JSCswZMiP5BuoUksfl8251ENnh/+AmnUxA2eLSmN933EGyziXmaSe0Ct85tUPhc3R0L3hHweu28zhocKyzeDo4RYsPUwNyzp0N13qkehmQq8iflRYKV2tguyeAnF8x1dgjnzRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liCtOcA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liCtOcA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C448C1F00A3A;
	Wed, 26 Aug 2026 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787761113;
	bh=/KVGzZ6bCLrBPb8pvmrm7J/N+QzEWznI/LjnFx/3QBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liCtOcA7GvslOr4ZLCnpb/gbXm10r40SAE/IlDbpIizwyH71smht55fHnWjKYhN8e
	 DVErh52p2FPnyNEh/p3RHjzKaykWRfWcfHF9YB7/z//SG6LtNiETuirVB3kIv3hIJG
	 zvhn7k/ZRxCKpBy98geSWMsDDitu+68LhCFmrVGZBl8VTeFzBVFZWv5+qq0Qdm3FJR
	 qqk5XMCDng15tEmU6xIwR3xKLhrEET/nizgl5g/q+NWZSjP0D4A9zYMtvqJQDVLn/f
	 ZrnWnLzPmL/qqvrIfBYid4aQWbW+9M+DmPKOYQxRArALupgUkmG9x1W0OvQKd0IdZL
	 gAjKjRWz8nZgg==
Date: Wed, 26 Aug 2026 17:18:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Hagen Paul Pfeifer <hagen@jauu.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
Message-ID: <ao8RZlK6mBa-oNGh@gremlin>
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
 <17e9f7d6-d095-44ee-9997-8dc10646f3f8@kernel.org>
 <ao13TmFVVpsv0zO4@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao13TmFVVpsv0zO4@gremlin>

On Tue, Aug 25, 2026 at 12:18:20PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Can we split off the selftest changes? This stable patch is already pretty big.
>
> Yeah I can do! I seem to recall people wanting tests backported too hence
> the change.
>
> >
> > I'd assume the changes to the selftests are not required just to get if fixed,
> > because the changes should not be breaking existing user space (and cosnequently
> > existing selftests).
>
> Yup confirmed locally that the changes don't break the tests.

Correction - somehow I was working with an incorrect version of the test
file or kernel locally, but the tests do fail with this patch, that's
because it only seems to be asserting the mlock_future_ok() check which the
patch removes.

I think the easiest resolution is just to remove the test for the purposes
of the backports and reintroduce the improved test as a separate patch,
will do this.

--
Cheers, Lorenzo
