Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793318696;
	b=GJyKUtqWaDIGcOybm23wmMOJYBXUiX5KR3gL9d+WT7IsSdDSnA+NwzxeoTnoJgRGKisp
	 VteeVeQlRY5tcCi5fG+gzfbEjfMsb7dRjVBy41L6PA/Q63rfc51oYFIXcSWXNdAFTWum4
	 wou+9EwZ29YgvU4xchT08jKnry0iUXAYQX+MQnLFGvT+2Vbi5xN5eYg7bM9TAzkipAyfm
	 tf9Qpt3jcauOv3zZu0uUbmXJ63vL/YsTiBwXI/A7cyYJpgTfJnEVKwq8r9S0fwHdct9RR
	 p+Wu4wCerT3sJQaDwL0hXflh1VdKSqy/No3M0lRmfc849ZKWnZA23VGVnpHg6NRXM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318696;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6HBJvZV2dPTZRQu5LKyPil8pJlXI/lZDJKNMF2wLkEc=;
	b=qouxpumt12wJXNZOQI5WW3K9YgiRLxPo66gQa2/CHktOBy7y5CZFbN6JIe/SvCuVlog5
	 KiEOvTXoj9hxpTIJyHhJBo6l0fH/KVnXEQOFOjJ3qvBrnBzqldQSZ/TRftvG+MpnbIKFi
	 hy+lQOfn36Iaj3iWam2CGgNoHhBpF1vsq2JGFk9RVal17KHrEiDDJ4tGbtOxf4KKTMQWs
	 Eypx/CApLg77XJnqsme9vpLudXS8KLCnmbAnN7P+C6UcYnogNR6PXnLpEcqvyumVrWX5i
	 2owkA12B+PvcgzsEJ0XkV4v+eEShMSewSqWup3eU3zZD3he2YrKy/L5qtU9Lr1Gq7sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HVK/tpV0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA08606A31A;
	Fri, 30 Oct 2026 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVK/tpV0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302B1F0093A;
	Fri, 30 Oct 2026 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318696;
	bh=6HBJvZV2dPTZRQu5LKyPil8pJlXI/lZDJKNMF2wLkEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVK/tpV0ZKdvtF02lea0g0LqWP+h1081rOGwZG2eGA484KV66l9vfQt+KhQDtVqOQ
	 hlmEVtrokSTyRQW3iTgbfzrNeaRRzGcll9GRoDDt1wRBcZMX1ZDhYLKVYoKH0gJKGs
	 RfkYieSRU9NV9n03/2EQf478Fb1mrQWjWjlbau3RSxjxm3E/8C9+9Q1xyC347IqFH6
	 OStkSpvmB7Er5L0uSt27Tv5RA2yqde5I1arQBkGLGriiTfWjEqDVkAUM3aJl/yFlZU
	 gDQLs5xaiAcnUvqmvc26UZd3QqAI4zeTvJZRw/8Zr9/+s4ix2YON6cK8481/ZsgDkk
	 ZChh0runNeBlg==
From: SJ Park <sj@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
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
Date: Thu, 29 Oct 2026 17:04:48 -0700
Message-ID: <20261030000449.154316-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <auNjrR4FyTf4WbgI@stanley.mountain>
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

On Thu, 29 Oct 2026 18:18:05 +0300 Dan Carpenter <error27@gmail.com> wrote:

> On Thu, Oct 29, 2026 at 07:10:40AM -0700, SJ Park wrote:
> > Hello Xiaolei,
> > 
> > On Thu, 29 Oct 2026 15:56:09 +0800 Xiaolei Wang <xiaoleiwangxiaolei@gmail.com> wrote:
> > 
> > > From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
> > > 
> > > damon_sysfs_test_add_targets() creates its monitoring context with
> > > damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
> > > DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
> > > context, and damon_sysfs_add_targets() therefore calls
> > > damon_set_target_pid() for each target it adds.  That function grabs a
> > > reference to the target's struct pid via find_get_pid().
> > > 
> > > The test then tears the context down with damon_destroy_ctx(), which
> > > releases such a reference from ctx->ops.cleanup_target().  For the vaddr
> > > operations set that callback is damon_va_cleanup_target(), and it is the
> > > only place where the reference is put.  The test never selects an
> > > operations set, though, so cleanup_target is NULL and both references --
> > > one for each of the two damon_sysfs_add_targets() calls -- are leaked on
> > > every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
> > > enabled reports the leaked struct pid objects as unreferenced.
> > > 
> > > Fix this by selecting the vaddr operations set for the context before
> > > adding the targets, mirroring what the sysfs interface does.
> > > damon_select_ops() fails if the vaddr operations set is not registered,
> > > in which case the test cannot exercise the pid handling and skips
> > > itself.
> > 
> > Makes sense.  Thank you for finding and fixing this.
> > 
> > > 
> > > Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
> > 
> > The impact is leak.  I think we should add Cc: stable@.
> 
> I wouldn't bother Cc stable for unit tests.  It's not something
> which affects production or real life at all.

Thank you for your input, Dan!

I have no strong opinion.  But we got CVEs [1] for this class of unit test code
in the past.  I'd like to keep it consistent to the past for now.

[1] https://lore.kernel.org/2024102930-CVE-2024-50068-2e3c@gregkh/


Thanks,
SJ

[...]
