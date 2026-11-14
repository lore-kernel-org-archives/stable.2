Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678669;
	b=X7Sh7kEpR5078BvbceMIju/Y57LV+A2FsoZxAcNZdGfQ4ZW96AcdgodOVMS5SgBRmv4K
	 c0TtFWu/ACW5E+j/8e8BlK44rs4GplutxWWUp21g1UkCtd0Wy68Ftyn6jRJKR9lhazM0C
	 cmbSosZnopGRCqQy+emiyuphmW1OaWnSYEB0jZPTegz+u7FNJ8mN1PhOGTIs8Xpig06xW
	 phvyIBf2Xm0yA44Id07ZboS1H54GJNQWdst6KSTRSaxgjUfwvgGRN91C0ylWQlxpHcOwq
	 608+QIK/GvfU1KL6t2UujMWjzcciq918uTElBeouE2OU3J9zFzD2DdO0rMUnAIp0gEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678669;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=31CSDRSd9baKd2bGsu5D8xrY334D4K/9sxfZ6xr0ASE=;
	b=XvsveA6g/E13VltnKEfGvLPTUdn0xArqUHkk7yfF+dTL051QqmAlxM8p7BLaWk2ttcpC
	 s1xrGISfOkAfwwNUrLUXuGe2Y3uCl9JGybNs031T1VPBJxzyje+5Rpselji/R3V0OLL7T
	 GZxz1eodpKgekl+k/Yns3bTBHLVsShFDJDySSSi9wsSv1zWunsqmD7FBoHkSqoEsjGLtM
	 9A9/+aMKyj9Kfry9U2G0GfmkwVOBZu43tGzPau7f2IqHt5cCLA49F2ZVXUQ6j4m2Y2wid
	 IB8sdi8qBpRJxqCg4VBf3g1AKH2bP19XKA8NISodOwBDeU+fiAPlDT+4KOXMCePaiGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2PmmhXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E361606A323;
	Sat, 14 Nov 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2PmmhXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C41F000C4;
	Sat, 14 Nov 2026 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678668;
	bh=31CSDRSd9baKd2bGsu5D8xrY334D4K/9sxfZ6xr0ASE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2PmmhXtLZqgFobKfTDiwgEfdPGeKoNV3+kRwSM+k0mMbWoeKq+G3ubuPoOjWR8Jo
	 IHC+qZpEUbJrqpZroF9IfOY1kPquXjJ6GTLoDB3uTz3jWA6/dV5DuPMAJ13f+QdFhz
	 MnFPPbXZNTj1ZN6C6bnEU9A8hMyHrfSKGP0oEyX/rSkTqjIw0srx9mrLhvDeaJBmjc
	 gbDCGxJmVqee/dgUJg7jz1rSFNarqyLL4U/WOlAzUJVpdor3XqSjshZs/5H3SDkIsT
	 wvQotMzDJxv6piPJjdT8fGu0WQ3a3qz4xplA/QaNB6Nk22d+q0/8RjxCZIKzJyh7bT
	 NBnsWycSJ5dsw==
Date: Sat, 14 Nov 2026 17:51:02 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: akpm@linux-foundation.org, david@kernel.org, linux-mm@kvack.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_move() with
 huge page arrays
Message-ID: <avifKRgR0Q4WPUNR@gremlin>
References: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
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
In-Reply-To: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>

On Sun, Nov 08, 2026 at 02:28:31PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> mm/migrate: fix softlockup in do_pages_move() with huge page arrays
>
> do_pages_move() walks the array one page at a time.  An entry naming the
> node its page is already on is never queued, so the loop runs without a
> voluntary preemption point on a non-preemptible kernel; the existing
> cond_resched() calls in the migration code are only reached after a
> folio has been queued.  nr_pages comes straight from the syscall.
>
> A 6.6.60 x86_64 kernel with CONFIG_PREEMPT_NONE=y and CONFIG_NUMA=y
> reproduces this under QEMU TCG: 50 million entries pointing at a page
> already on the target node keep the CPU in do_pages_move() for 42.9 s and
> trip the softlockup watchdog; with this patch the same call completes in
> 44.3 s without a softlockup.
>
> Add cond_resched() so that long calls yield periodically.
> do_pages_stat() had the same problem; it was fixed by 8e934ab44389.  In
> current mainline only alpha, hexagon and classic m68k can select
> PREEMPT_NONE and they cannot enable CONFIG_NUMA, so this mainly targets
> pre-v7.0 stable kernels.
>
> Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

NAK.

This person('s script) sent 300 mails in under four weeks spanning: ata,
scsi, target, ufs, nvme/nvmet, ubifs, ublk, zloop, dm, md, mmc, virtio-blk,
mfd, gpio, pwm, spi, PCI, ASoC, ACPI, net, vfs mount, block partitions, and
now mm.

Those patches that I've looked at have actually both been wrong and both
useless.

And absolutely not to this person/script doing backports, thanks.

> ---
> Changes in v2:
>   - describe the reproduction and the code path, as requested by David
>     Hildenbrand; no code change
>   - correct the do_pages_stat() reference (fixed by 8e934ab44389)
> Link: https://lore.kernel.org/all/20261107213856462Jx8pIdgdtLvPLfOFTwV4X@zte.com.cn/
>
>  mm/migrate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 875079464930..3122ecb85270 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2372,6 +2372,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		const void __user *p;
>  		int node;
>
> +		cond_resched();
> +
>  		err = -EFAULT;
>  		if (in_compat_syscall()) {
>  			compat_uptr_t cp;
>

--
Cheers, Lorenzo
