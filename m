Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972704;
	b=LbBgsApxuUdNQa89w13Z8LEGv6OB3gGbQy7uVuxXLWSGXcj9ebZp30f7QIFEGTPfpPCh
	 1fbTidZthflV6Nj6DM9R6vimyloMRmlyF/VaA7RoJwlfK/6cS2G9JWmlafT0iPocQHFXW
	 NJmXvArD2aiDlwu1J3Eqwn2d/XfWke8fVX8hFIbPS7SYvPG+Zl8XeNTOI8au9dKXz/EQv
	 NSh2qiiXSY/gfYDoQJlu2/cy4iZzCkKaVxPD1wIWoVMVKKIo/F+yhABS5O+Zj7fJDV7be
	 Xk6n121Je8y3IWPA79oXp9dojxAlAG2Oz+oqrX797x4yADYYaA2xXAqZk7SPOweU66g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972704;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RDAl4DPrVyeM/Qmsde852AME5qEbxVQSkAby9TkRa0w=;
	b=S2a0wqGlWcF93AxbnCR6LsOX0zAEuSRWsH/P4y6YbtWq/uHqnCNnKWsaeIobaFWh+HaL
	 vY681fCw1uwmmXWeAQbvHR2vlw3aAlvgLYGiP0baSZ9GgoIhINi6+5kPkvJz84wVfV94y
	 Pk0m6pwmWcQz5Af8Q5XjPLyYdJIHUhSqEN94lLoi+VEMQlcGFsN+RLq1zwWJqXKtSB+QG
	 npUeUGM+L1pAGQacYWeLzPQ9dhiLWjFOYXYUruvjQJ7fTnHQQhSQONNqJRECL9Zl3MKzw
	 vMvEHgIjQbrZ28So/Wcfs897OxlNbUlgMISQ3Hf1UneBUruAvSAYgN9q9e6UcjJAJXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0kz2tDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589E606A31C;
	Wed, 18 Nov 2026 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0kz2tDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6174F1F000C4;
	Wed, 18 Nov 2026 03:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794972703;
	bh=RDAl4DPrVyeM/Qmsde852AME5qEbxVQSkAby9TkRa0w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=X0kz2tDgyNVd8qpPzEPDzUiKbnTnniyWC5wBnmEw5nWH9AQ5LLqr/Re/S6CfzrOya
	 L7O41EXLOG0BLbqV8iwbGxN5rQ+zqKi/xy+isV31eQerlSu/2ktAfi1X+dcc8SYNG5
	 1+d+h0UFXrHtLesFyJSSBvjGfzN04UHlMn/3Fc/nT4AA8AL+8u9ncDmUjOFwDFMA1a
	 X1POksg59iZRLM1zQJBmDo7FgsL8yjjkg3EMNja9w4s6zzm1UGGvAyIZCP/OrQ/kli
	 iY+u2QLxtHDe8YcI9Q5NDb+Ow5sZPP4h+7PKdJzZ1g4RxVlQskkYXIQvp8jmO73t5J
	 aBim1FYiJAlug==
Message-ID: <8f11cfb9-7178-426d-b328-a024e57cb8c5@kernel.org>
Date: Wed, 18 Nov 2026 11:31:40 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH v2] block: fix PF_BLOCK_TS/current->plug ordering in
 blk_finish_plug()
To: zi-hao.huang@mediatek.com, Jens Axboe <axboe@kernel.dk>
References: <20261118-blk-plug-fix-v2-1-4acbeec5d512@mediatek.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261118-blk-plug-fix-v2-1-4acbeec5d512@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 10:31, Zi-Hao Huang via B4 Relay wrote:
> From: Zi-Hao Huang <zi-hao.huang@mediatek.com>
> 
> blk_plug_invalidate_ts() runs on context switch and assumes that
> PF_BLOCK_TS set implies current->plug != NULL. blk_finish_plug() breaks
> this: it clears PF_BLOCK_TS in __blk_flush_plug() and then sets
> current->plug = NULL, with plain accesses.
> 
> clang inlines __blk_flush_plug() and emits the store to current->plug
> before the store that clears the flag (arm64, Android common kernel):
> 
>   ldr  w8, [x20, #0x44]     // w8 = current->flags
>   str  xzr, [x20, #0xaa8]   // current->plug = NULL
>   and  w8, w8, #0xdfffffff  // w8 &= ~PF_BLOCK_TS  <- preempted here
>   str  w8, [x20, #0x44]     // current->flags = w8
> 
> If an interrupt hits there and preempts the task, the task is later
> scheduled back in with PF_BLOCK_TS set and no plug, and
> blk_plug_invalidate_ts() writes to NULL + 0x20 (plug->cur_ktime):
> 
>   Unable to handle kernel NULL pointer dereference at 0000000000000020
>   pc : __schedule+0x108c
>    preempt_schedule_irq+0x48/0xa8
>    el1_interrupt+0x48/0x8c
>    blk_finish_plug+0x6c/0x18c
>    ext4_do_writepages+0xd3c/0xef8
> 
> The window is only a few instructions wide, so this is rare. It was hit
> at cycle 127 of a warm reboot stress test.
> 
> Add a compiler barrier so the flag is cleared before the plug is
> dropped. A compiler barrier is enough because the race is with
> preemption of the same task on the same CPU. With the barrier, the same
> build stores current->flags before current->plug.
> 
> Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after task switch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>
Oh, I didn't notice your v1 before sending mine, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
