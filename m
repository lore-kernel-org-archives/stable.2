Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24A38330C;
	Tue, 18 Aug 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036427; cv=none; b=f9HrC7PKTOVsjW45ABjliG06Q9IjNAJmoW32oV5zKCHEfsmXoeEl+/BaPFgrUMkH4+XvAe+f6nAuYGvXAF4aQtAjFYF1pdFGcTUx5K7Smf89ZF+0kpWxNegguM0XkxVVS/YzsJs0GvqpfPAvzwHqW3dWOhkIizmAMQkiNdMX2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036427; c=relaxed/simple;
	bh=PmuTN/s+h++ZoAzx5tvxii0VeJnfTuCHvUfgMoKlZGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+ZK2VxGujJU4grHoneZmdxg9KYrZt1KYDpT50an4NR8ru72LsvyaJZVrI3wS5PCTINTzS1CAStKylXhO5e3M4jbsCPn4cKaMPMe2dKsO0uces9DttGBrgqnnMUWfG81DxbvhMwMic8LQPVk/zHnCo4JBDmyznnn1iY8qvZurd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE4I8Vjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE4I8Vjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0FB1F000E9;
	Tue, 18 Aug 2026 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036426;
	bh=eLkCtMfElj3TBbhOnqAE7roUGQ5xLxxaMf/iSBaGdec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OE4I8Vjx95n8znDxHW+u9FRfXy8EgQy3a3KN7JbsZ2DwzPrM2YozWbad13thW4cU2
	 BMOgwcALvQQU7jmC/dcnWs3R/YgiONJji781fNCWIMjnQJD9C67DwIDetOVVeiV2IA
	 bgnbB77DlSlkDpuqn1KBk1gb37XhKMb/1C3lsuGkBOeXCDpSTV4hAI3cE11F/vC/Ua
	 o/y0NmcIo2JX8jLhixj+tl4Gxb5OUbA22RirFO28mWTzvZWamEg3mqvwihGjkjSUQ+
	 AuWkIgg006Axbqy/5PskV9T30X6ileS9fKAFl78eTSVbm3OOz7/BAJd+pCZWEF81k8
	 nRWr5HRJKQdfA==
Date: Tue, 18 Aug 2026 08:00:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Hagen Paul Pfeifer <hagen@jauu.net>, Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: properly account locked pages
Message-ID: <aoQBQWH1zWgC5f3A@lucifer>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
 <20260818052006.2387242-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818052006.2387242-1-4ncienth@gmail.com>

On Tue, Aug 18, 2026 at 02:20:06PM +0900, Daehyeon Ko wrote:
> Thanks for the patch.
>
> I tested this v1 on its stated base with an x86_64 KASAN kernel. The supplied
> selftest passed 6/6 in three boots. Additional fork/unmap and inherited-VMA
> mremap tests also passed.
>
> One question: the inode stores the creator's user_struct, but the fault path
> uses the current task's RLIMIT_MEMLOCK.
>
>   secretmem_init_inode_priv():
>     state->user = get_uid(current_user());
>   __secretmem_account_pages():
>     page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>
> With A limited to one page and B to four, A created the fd and passed it to B.
> B faulted four pages, after which A got SIGBUS faulting one page on a new fd:
>
>   CROSS_PRINCIPAL receiver_pages=4 creator_fresh_page=0
>
> This seems to charge A's locked_vm using B's limit. Is that intended?

Yup, it's a per-process limit even if the accounting spans multiple
processes.

It'd be incredibly involved to track each resource individually and this is
a trade-off.

In practice people aren't typically varying the limits like this and in any
case, the least surprising behaviour is to adhere to the current process's
limit.

And this is the same solution used everywhere else by io_uring, etc.

>
> Thanks,
> Daehyeon

--
Cheers, Lorenzo
