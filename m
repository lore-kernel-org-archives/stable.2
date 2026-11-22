Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374133;
	b=dqEoJkQeW9bsQkc1BiQdYrjVrqskmMstZrYdfZ29nqtungIUi72cq3WXYLTm+oKcURsv
	 z8R2Mywv8tyXCK/yJBfZWDrw2d5kQIi88zsafHc034kOsENmcz2xmIgadNXIoMffWuJ09
	 sWV4KTi8Cayp2IEGh8Z53NMOYV/m+a85zx4s+JJ2hZvgjlDwaJSVbBPdN2vvdAzI0zsU6
	 nwS4Z9fTqOhjJ906Pkny+Nr2ASZVcUnJVMjt9CwvsdIsiK4rzCdy6USeOI57qSPWHnKf8
	 BQM51E7VXj810PZw4YdXH2cJx0+CEx6NL2BD0j00MWNd0YkvSBhO9rLCdupSUp95QXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374133;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5ImuqM4hh2EY1+d9bvgkuqa7XuiqLC0obTG9QEkhIqg=;
	b=JoRx8kffa0y6+bEjnYAKd4BzuwbjWBHOVRB1GnMC7pyy79o8WY9h7BkcUYl2873haZmc
	 Iy3uBZiqlwzgdPdPGUGb8klarkUOxU0vFzk/5xqyHX/7A+bka5ZlFWwDNNGnxv2ClnP8/
	 VtbG6PrQFNQmR2yxbTgSP4oRM8zYW8bxb8ieWWD7AC9qQxz0GhU8Nk+gKX8kj3xAPfbSF
	 E/g2AUN8VW23MBqa/kcYNK+D7+ojpFg0sC/LqwOQa1+4O9XMihdktRjYSQTlh7LfLXif7
	 BLRB6dHQNeJGX60KKSd7XHuSj9Wt8hhZiN4Ii31K2sOirDXZeaTQd8l7OmEIKC3jQJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ncrdZuej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50611606A320;
	Sun, 22 Nov 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ncrdZuej
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4003B1F000D1;
	Sun, 22 Nov 2026 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795374132;
	bh=5ImuqM4hh2EY1+d9bvgkuqa7XuiqLC0obTG9QEkhIqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ncrdZuejHtg4X4kIHE9XamnHb/F9dg1FnvcNpLGpxT4OXyDbYPVGYqxH+AzMOoMSF
	 t4fgSU/fMqIRiZmzAJMU7IyzQx/NfehM+bVGPUcZb0mRxOH4Is2fs+W43blTXtPUVN
	 1fp+bkcHtQ+aHz6nKls6VApLiBCF/ltHvHIChdgA=
Date: Sun, 22 Nov 2026 11:02:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Nico Pache (Red Hat)" <nico.pache@linux.dev>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Tianyi Chen
 <hi@tychen.cc>, stable@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: honor VM_SELFTEST_ITEMS from the
 environment
Message-Id: <20261122110211.81cf2fbbfc9048264aba50c5@linux-foundation.org>
In-Reply-To: <20261122-vm_selftests_items_fix-v1-1-9edef5e7975d@linux.dev>
References: <20261122-vm_selftests_items_fix-v1-1-9edef5e7975d@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Nov 2026 11:50:36 -0700 "Nico Pache (Red Hat)" <nico.pache@linux.dev> wrote:

> The unconditional default assignment overwrites VM_SELFTEST_ITEMS from
> the environment. This regresses environments that use the variable to
> select test groups: without -t, all default test categories run instead
> of the requested groups. The -t option continues to override it.

Oh.  Is "setenv VM_SELFTEST_ITEMS" really a thing?

afaict the official way of doing this is to use -t.  Continuing to
support "setenv VM_SELFTEST_ITEMS" is perpetuating bad behavior.  How
about teaching "environments" to use the official selection method?
