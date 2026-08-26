Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950F356772;
	Wed, 26 Aug 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731080; cv=none; b=Ov+Pj1FmF9J8NjxE0b0izzw+ru7FDD/+rzQ3l2vzj+zXEvvpwonftXWRBmI/IQiL7VRdigTg5DH6q/sGb0oOxli2fB2eP0deAzt/vnJqNXfobLo3eTdXzuPyEHar4kVJoGPi3pwjde06zxKi9Ir6jIxD4poK0nVeULj3fXA4LYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731080; c=relaxed/simple;
	bh=V7FiM7QenTRWsgqaGWzg3RYAyNKlEcw03OJlNm5IuwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxP4l3vjzXp7ScCNhF4bSflZWtXFkZQbIRJ+z3sN9qSoI5IPkZpuWZgdFvtoq/RPvV1CyJXAr99d2E2IINMkQGspIT6z13rwY1PBUr6l8jGBEfXdSVcgJFLq3QQHut/lxf1NIb+Bm4gtvWpqjTusq5+XnGI0nPK+jAWri3jP2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4XP55Rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4XP55Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E561C1F00A3A;
	Wed, 26 Aug 2026 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731079;
	bh=hmpj9TgfHr39DOeJCr3cPmBxSCLXnUOZroFpMszuCEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i4XP55Rr+Zq1oMAbamvhLn2jYWDSAxn48TNZaZEz5P3ZKmIE1IX7khswMhbPdSWE+
	 uhI8Lv6erPUMa+ScYtxq0ZO4sXD9PNTlGvcI6S47IlegKuJymUVmtxe7c9Hn8YD9wR
	 Gg8zF+BV8xqN77G8FsZAiWg26oBPAZMlrEughbpdYMmjwbipEp0G94Z9HbSASuiyE3
	 4OjEZc4s1zcx/aHozv6IR/Us1jec+P35irhJA7po2XoY65iUm/nchU+0Dxtx8V4wEl
	 Jktjq1UDtKjFJQxG10lml1FZscJMDI9z/PjfVNiJcoQg7Io0TL+QuNMsy2ImoTOXtq
	 KP71dWh/Adj2Q==
Date: Wed, 26 Aug 2026 08:57:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Hagen Paul Pfeifer <hagen@jauu.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
Message-ID: <ao6b7b9AIUPWRTkJ@gremlin>
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
 <20260826013948.1325213-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826013948.1325213-1-4ncienth@gmail.com>

On Wed, Aug 26, 2026 at 10:39:48AM +0900, Daehyeon Ko wrote:
> Hi Lorenzo,
>
> I tested the exact v2 from this Message-ID on its stated base with an x86_64
> KASAN kernel. The supplied memfd_secret selftest passed 6/6 in three boots,
> and my accounting-boundary suite also passed in three boots. I saw no
> patch-attributable KASAN report, warning, Oops, or panic.
>
> A v1/v2 differential also confirms that v2 fixes the CAP_IPC_LOCK creator
> delegation issue Mike identified:
>
>   v1: CAP_DELEGATION creator_cap_ipc_lock=1 receiver_uid=2001 receiver_pages=2
>   v2: CAP_DELEGATION creator_cap_ipc_lock=1 receiver_uid=2001 receiver_pages=1
>
> I have one policy question before adding Tested-by. With a one-page soft and
> hard RLIMIT_MEMLOCK, a non-root task whose only effective and permitted
> capability was CAP_IPC_LOCK produced this on v2:
>
>   CAP_ONLY uid=2002 cap_ipc_lock=1 mlock_two_pages=1 faulted_pages=1 raise_hard_rc=-1 raise_hard_errno=1
>
> Thus ordinary mlock() of two pages succeeded, while only one secretmem page
> could be faulted. Raising the hard limit failed with EPERM because that
> requires CAP_SYS_RESOURCE. Is this divergence from ordinary mlock() the
> intended consequence of removing the CAP_IPC_LOCK exemption for secretmem?

I'm not quite sure what you're getting at here, as stated in the patch
CAP_IPC_LOCK does not bypass this limit for secretmem because the scope of
the folios is greater than the process so a process-level capability isn't
suited to bypass it.

Also a typical use case of secretmem is privileged process establishes,
then passes fd to less-privileged user. So it's relatively unique in this
respect and therefore it is not enforced.

The idea is that those with CAP_IPC_LOCK could raise the limits as needed
should they wish to bypass.

>
> I saw the planned selftest split and cleanup in the follow-up discussion. I
> will retest the revised patch before adding Tested-by.

Thanks!

>
> Thanks,
> Daehyeon

--
Cheers, Lorenzo
