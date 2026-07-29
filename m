Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A843D0C18;
	Wed, 29 Jul 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353516; cv=none; b=GUFoWOo3D5c2ewjDqHl2IsMpcBOIWAEiNuKvpjlomOQXCw6CwbG++reJSDs0tSc/oAsOR4kUrZUhWOcSJi6ppsBoGw9nFm48DQLpq4h2bVjfEDCjX/Hy4zcWGo8mfSWJjKLIvhBKRXzb/iu4rKb2pCgz4HBDB6J6PB3fcJn9a6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353516; c=relaxed/simple;
	bh=CK45O5vBUPLRWXtYFXSam57y3rTq1A/o958S+78XYSM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rdrUq6FyjWPAQ9ZwXjhg0qz/B/8hFMEJ1SiPDN1XGOB8HZAhkIs/FrCzgGMtLAvZufh+/k4FqBsfeV/tYKZBxcl1wWv1qRk5C/s+SBiK0DFVZ+3Olod/6fTTT2Th7NnrCU2jyFznAwfGefQ1nIAcmNtf6E5VrFrZJszJPpEzda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BatAszgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BatAszgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576151F000E9;
	Wed, 29 Jul 2026 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353510;
	bh=KRg2cJitlohLdvtZRNP1kQ5PcKE3jaMDfptdu/E84dU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=BatAszgHFRvKI4T+XBd69pDfxldCOMhFxi5Me3LbZKEflqsbTkwH2PxZDT8rpGi3c
	 WshppbCjn9Id7m080JM7vQA01JZzYEU8m3SQ8+zpwy39hTgs8rpIThw/nHZqQvkeOW
	 aDFToGlbunDpP8ADvNWeNFfhlIXBMrIOk3QD5Vy6GmtHrdLwR7eejnBd0UW8N7FZoX
	 k4327s87rzgMvsqaV0NYHw26YDlHmB0hIy9/zwBCXDy6TGwtO4gGlvNx8Alxx5+old
	 okHu+gbfc4Yh1o8RBat3iLYkur59MNmiOAooLlrA9X4ditDelg2SyNguzn2pqKfzcU
	 D59hFbY+Z1Rvg==
Date: Wed, 29 Jul 2026 13:31:48 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Nam Cao <namcao@linutronix.de>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Andrew Jones <andrew.jones@oss.qualcomm.com>, 
    Jingwei Wang <wangjingwei@iscas.ac.cn>, 
    Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: unaligned: stop using kthread for
 check_vector_unaligned_access()
In-Reply-To: <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
Message-ID: <dd5ff254-fc7c-ddd2-751a-50e6971b10af@kernel.org>
References: <cover.1781666867.git.namcao@linutronix.de> <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Wed, 17 Jun 2026, Nam Cao wrote:

> A kthread is used to run check_vector_unaligned_access() to optimize boot
> time, allowing the kernel to continue booting without waiting for the
> unaligned vector speed probe to finish.
> 
> However, this asynchronous approach introduces several complications.
> First, the kthread may not complete before a user reads vDSO data,
> resulting in incorrect values. This was previously addressed by
> commit 5d15d2ad36b0 ("riscv: hwprobe: Fix stale vDSO data for
> late-initialized keys at boot"), which added complex synchronization
> between the kthread and vDSO reads.
> 
> Second, it was discovered that the kthread may not finish before
> vec_check_unaligned_access_speed_all_cpus() (marked with __init) is freed,
> triggering a page fault.
> 
> These issues raise the question of whether the kthread is worth the added
> complexity. A past boot time regression report was actually unrelated to
> synchronous probing; it was caused by the probe running serially. Since
> switching to a parallel probe, no further complaints have been made.
> Furthermore, the unaligned scalar access speed probe takes the same amount
> of time, runs synchronously, and has caused no issues.
> 
> Testing shows no noticeable boot time slowdown when running the vector
> probe synchronously (0.464474s with kthread vs. 0.457991s without).
> 
> Remove the kthread usage and run the probe synchronously. This simplifies
> the boot flow and allows for the revert of commit 5d15d2ad36b0 ("riscv:
> hwprobe: Fix stale vDSO data for late-initialized keys at boot")
>
> Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> Closes: https://lore.kernel.org/linux-riscv/20260612-vec_unaligned_drop_init-v1-1-df969210ae34@oss.tenstorrent.com/
> Fixes: a00e022be531 ("riscv: Annotate unaligned access init functions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Thanks, will queue this for v7.3, but I think the Fixes: tag should point 
to e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe"), 
since the problems that you mention are due to the use of kthreads.  
So I'll plan to update this accordingly when it's queued.


- Paul
