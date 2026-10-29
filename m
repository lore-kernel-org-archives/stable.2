Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283049;
	b=iA2xpzT2E0i8fKNN97N0xI9Qe4uqNFQ6Wc5LPEtUMCpRNNW7rki32BIIkckCaIH77r/L
	 uiIQV0G9RM8KI8BhvTLe7Z1s2txYGy2jD8l0v5j+2zGHWhE6wJPbfmiYdnHbv6qF7anFR
	 RS0boys5es+44jl6FYGXcpll3AbFc9jl9/Mo/WGt7quYWywyPS9VKOaIxPXNBcCBJUFXj
	 TBLXr0K+DR1Wr/QupOvg150Lpgksi2OA0wqYQXDEI8dkREYCbrxfwpssCSNSzdccIZ4Xx
	 8UCBRryHtm3a5B1JUjR1p35+Eix2ZBjL0prgT2M67c0wXWAKnnKXfo7+rzoO5R7hf5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T6jBwgB0mzd2kWy+BfoLDGgcNGK1100O7enXCOOxA3k=;
	b=lciZx3YJkg2TX6s0kJR0k/CHUxcRzjUR0fbOZl8iX70s10x6TMgGLkW9pv7esj/1rW5R
	 xZOEh9jHBqvm/LBrf4aRtK3wtNeyQNWUVfhYZ6CttZmILdvaf3LKxodUH8/mXvHgTlSPt
	 Z1FkUC/o6X2EFoi173ZDaBTQhL0JQh2tIgjGcQvsTBCedXADRKS4WFurnZnAh9MVIBMk0
	 JT6ckdAsLH+ocNqtEW+UVdtisHIjmJ2i0Kly/98eFwGMhQ38FRRp/72D21kCLC5QCOT8t
	 ehkAQyZMmOjCWqJmp1YsG2JpSmj/s+PeQEmyDM4AJnfB0dbzKgrmKLwPxFs3GmuY4/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofbH3Y62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376F606A31A;
	Thu, 29 Oct 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofbH3Y62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C076E1F01825;
	Thu, 29 Oct 2026 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283048;
	bh=T6jBwgB0mzd2kWy+BfoLDGgcNGK1100O7enXCOOxA3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofbH3Y62HqYpuqTQ/c4/VW+V2KrlrU26ac96H/imGeTXuJfi45MHa8Gn0m/qlcJxq
	 RZ6Md1fc3/YT2PjPoYLfD35mVwuRy+lkSAWBKG1zXteuYW3UuM3kqLcelqnGzuA5pv
	 sG4eYTJDftBSbgHNjpym1EU92+c4R0z8laWYPHWgnkcWG2B89L5RKZ/vXDTEf5sVR/
	 DSX687NvGSA3+Hk/hj5wkVCMv3iazPeJXjGGW4Z6WV6paQtY5zx4VC4K/gJtqVrRLI
	 x4RuXoIvR+N9dgtWWq+zWE9r/mqI4/Dl4WguTRko6rl3FPhuAKPqD+/BEgfszS9+4+
	 8lIosbATeLo7A==
From: SJ Park <sj@kernel.org>
To: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	error27@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets test
Date: Thu, 29 Oct 2026 07:10:40 -0700
Message-ID: <20261029141040.148392-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Xiaolei,

On Thu, 29 Oct 2026 15:56:09 +0800 Xiaolei Wang <xiaoleiwangxiaolei@gmail.com> wrote:

> From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
> 
> damon_sysfs_test_add_targets() creates its monitoring context with
> damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
> DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
> context, and damon_sysfs_add_targets() therefore calls
> damon_set_target_pid() for each target it adds.  That function grabs a
> reference to the target's struct pid via find_get_pid().
> 
> The test then tears the context down with damon_destroy_ctx(), which
> releases such a reference from ctx->ops.cleanup_target().  For the vaddr
> operations set that callback is damon_va_cleanup_target(), and it is the
> only place where the reference is put.  The test never selects an
> operations set, though, so cleanup_target is NULL and both references --
> one for each of the two damon_sysfs_add_targets() calls -- are leaked on
> every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
> enabled reports the leaked struct pid objects as unreferenced.
> 
> Fix this by selecting the vaddr operations set for the context before
> adding the targets, mirroring what the sysfs interface does.
> damon_select_ops() fails if the vaddr operations set is not registered,
> in which case the test cannot exercise the pid handling and skips
> itself.

Makes sense.  Thank you for finding and fixing this.

> 
> Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")

The impact is leak.  I think we should add Cc: stable@.

Cc: <stable@vger.kernel.org> # 6.7.x

> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

Other than Cc: stable@,

Reviewed-by: SJ Park <sj@kernel.org>

Assuming you agree to Cc stable@, I applied this patch to damon/next [1] tree
after adding the Cc.  I will repost it next Monday, as an mm.git merge request.
So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
