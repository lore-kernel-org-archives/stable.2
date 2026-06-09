Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB6275AE4;
	Tue,  9 Jun 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016569; cv=none; b=f50w0AD7WNRE1yTTtl5Nz6xzELfXuEUKxhJaPUZBgVY2dElKsRGCwB/+nUOsqWOb9sG2qQ1JSHYpJe9ZTCBuz7zcR1Fe15QCTjOvADZEuvrLtfzLHh0ECIg3Cyt4qKsdfORSuwLj7TMmegj1kdQMjpmovVs8ThEj4Wf6e6sesjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016569; c=relaxed/simple;
	bh=weRw5MX9+brHYT8Z5Ag+Xcyt7ecrQprt1rxxaMxTQ7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0qPQwMw/C4IKfHyXUUTsyU825Wo8O9+qkWzclcKtGcqIkH1ErqwgLsPPYGZ+86ohaG5gqHrTSLd9/pkI5sCG4ujLK+tZk5uQG37WjVY1ZpZcvgtKAPAYrY1/6XKqBjdQqsGSk2GEKBTwrAIt2uk95VAo+kQ0DJmDIiAzWc6GdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erX6JcxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erX6JcxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230CF1F00893;
	Tue,  9 Jun 2026 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016567;
	bh=taRgX81yJwI75jVPUy3ya0pHHgm8A4dha5HwvheVriA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=erX6JcxZmIcrZHCAP2aqWFKZfJeXTO2GXWNjtqNyT3fI4ae3SFvQ+uj/xwBiSLWEm
	 0XXbMJrQmYdX2XXxmSAZpAmKAEM+hczHm8PLuZDYQipS3uh0sqgKTiLcuenNPV0SDG
	 KoV4yZGT6yb+sW6dwdzWh/pApVzsqvkOzR3F2y9BFXjzRlybBVrxzm0Rc7r3XAk0ff
	 7zQQ+tnPRKcvBgnyR62eqIFoUkJ0Hm8PcpBg43sJJTjkbRaYSz3JTs5Ogo4L425H8d
	 eIg0dyf4aJAnl/h4HfnEGY9yXmrV9v0i1NM47T3Hctkq1qF5cpJAEwFpCDlfhH2XBE
	 n9XUCvNAnVceg==
From: SeongJae Park <sj@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	wangzhigang17@huawei.com,
	liqiqi23@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] samples/damon/mtier: fail early if address range parameters are invalid
Date: Tue,  9 Jun 2026 07:49:17 -0700
Message-ID: <20260609144918.69429-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609064653.1829-1-yuzenghui@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Jun 2026 14:46:52 +0800 Zenghui Yu <yuzenghui@huawei.com> wrote:

> The comment on top of `struct damon_region` clearly says that
> 
>     For any use case, @ar should be non-zero positive size.
> 
> which is now verified in damon_verify_new_region() if the kernel is built
> with DAMON_DEBUG_SANITY.
> 
> The WARN_ONCE() can be triggered if the mtier sample module is enabled
> before node{0,1}_{start,end}_addr have been properly initialized, which is
> obviously not good.
> 
>  ------------[ cut here ]------------
>  start 0 >= end 0
>  WARNING: mm/damon/core.c:217 at damon_new_region+0xf4/0x118, CPU#59: bash/341468
>  Call trace:
>   damon_new_region+0xf4/0x118 (P)
>   damon_set_regions+0xfc/0x3c0
>   damon_sample_mtier_build_ctx+0xe8/0x3a8
>   damon_sample_mtier_start+0x1c/0x90
>   damon_sample_mtier_enable_store+0x98/0xb0
>   param_attr_store+0xb4/0x128
>   module_attr_store+0x2c/0x50
>   sysfs_kf_write+0x58/0x90
>   kernfs_fop_write_iter+0x16c/0x238
>   vfs_write+0x2c0/0x370
>   ksys_write+0x74/0x118
>   __arm64_sys_write+0x24/0x38
>   invoke_syscall+0xa8/0x118
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x54/0x370
>   el0t_64_sync_handler+0xa0/0xe8
>   el0t_64_sync+0x1ac/0x1b0
>  ---[ end trace 0000000000000000 ]---
> 
> Note that the same issue can happen if detect_node_addresses is true, and
> node 0 or 1 is memoryless. Fix it together by checking the validity of
> parameters right before damon_new_region() and fail early if they're
> invalid.

Thank you for this patch, Zenghui!

> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

I think this deserves Fixes: and Cc: stable, like below.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x

Other than that, looks good to me.

Reviewed-by: SeongJae Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent,
because it is causing only DAMON internal weird behavior and one time warning
on debug kernels.

Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request adding this to mm.git after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really urgent or
I'm missing something.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
