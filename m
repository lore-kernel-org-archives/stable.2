Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A730395AFB;
	Fri, 25 Sep 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346509; cv=none; b=RDds19P0lLGnpWbWel8v7Wtk/gSzlKi4pXTK4y9VxXdTGXHzUGSChiQ0OrCE/7+lCWcD9qsph1UHaeh6UPZRBJzHfPD4PS4zjumkIWgEpCGSup56mxhmylqO+7xTisvrBDfyleJIMzPVXODeUJVA60iW5JTewoJbwMnLRBcqutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346509; c=relaxed/simple;
	bh=CRZuqGr10cJAsTOWqM27qfJGoBw3MW3h0E/Z6zUfFxs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GqLGAhOIj+fAnRiAvIQKhSPAmw+M06L+PA7DK5VoJ3dVLXUSSNNKqW9xbHrpND4izMZ6JGV7O8TZFxiTjrHubN6ZqgGF1qfVQllOH7meSJxveIu+vMyDiMxuuYbJKJzM9Pi1pbKKi2/aFDbvX4wXvILVIYvkADBr9xJzUqgu4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V07CjrEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V07CjrEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEA31F000FF;
	Fri, 25 Sep 2026 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346507;
	bh=6LSNpmMhH3IgC836Hc/le3/h3yCpQ5DOv9o6ecFpYpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V07CjrEIi0kH2G/IiBGBqsqP4+5dt4n2L9qyf3zOrBgzbEpaGcG0/TfKdsMnqeDfo
	 9mingLgE7CLnNkwhBeO9EKUjyXoHcha2hCMx+kV+qm7WTrf3slioXbD6bZeOlVaaIY
	 KXwduaMqUI2zOBKJBDHPAnuNE0EY+l5Au4n4Jogygt7mTOVtvnKJJEoNlhZ/duCn2u
	 OT9TSIA1eqsP5NAKMNlxcuYcWtWMgYdAedVvt15mBG9TIFf5a0JAp+AuhJ2KAffBXk
	 ypeTGO+cg44O4c0uzLo3owf7+6qUIPTBorgf025HjJ3FIQUdii0xbBg5KLWxBGCdLM
	 ETAkGPEQfDfKA==
Date: Fri, 25 Sep 2026 23:28:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Allen
 Pais <allen.lkml@gmail.com>, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] sparc64: kprobes: fix relbranch_fixup() for BPr,
 FBfcc and FBPfcc
Message-Id: <20260925232822.094082fd46fb3b02d9cfff10@kernel.org>
In-Reply-To: <20260923144909.414968-2-danishkhateeb03@gmail.com>
References: <20260923144909.414968-1-danishkhateeb03@gmail.com>
	<20260923144909.414968-2-danishkhateeb03@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 09:49:07 -0500
Danish Khateeb <danishkhateeb03@gmail.com> wrote:

> A kprobe single-steps a copy of the probed instruction in
> p->ainsn.insn[]. When the copy is a taken PC-relative branch, its target
> is relative to the copy, and relbranch_fixup() moves it back to the
> probed code. It only recognizes call, BPcc and Bicc, though. For a taken
> BPr (brz, brnz, ...), FBfcc or FBPfcc it keeps the target as is, and the
> kernel continues at the copy's address plus the branch displacement.
> 
> GCC often starts a function with a BPr on an argument. For example,
> __se_sys_getcpu() begins with "brz,pn %o0". With a kprobe on it
> ("p:kprobes/kgetcpu __se_sys_getcpu" in kprobe_events), the first
> getcpu(NULL, NULL, NULL) crashes the kernel in QEMU sun4u:
> 
>   init(1): Kernel illegal instruction [#1]
>   TSTATE: 0000004411001603 TPC: fffff800048d63c0 TNPC: fffff8000492631c
>   Kernel panic - not syncing: Fatal exception
> 
> Add the missing branch formats. BPr is matched with bit 28 clear. The
> CBcond instructions of newer CPUs share its op2 value, but they have no
> delay slot, so a taken one never reaches the single-step breakpoint and
> this function.
> 

Sounds reasonable. From kprobes maintainer point of view:

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thanks,

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>  arch/sparc/kernel/kprobes.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
> index 191bbaca9921..9a26c57c8d33 100644
> --- a/arch/sparc/kernel/kprobes.c
> +++ b/arch/sparc/kernel/kprobes.c
> @@ -207,12 +207,15 @@ static unsigned long __kprobes relbranch_fixup(u32 insn, struct kprobe *p,
>  	if (regs->tnpc == regs->tpc + 0x4UL)
>  		return real_pc + 0x8UL;
>  
> -	/* The three cases are call, branch w/prediction,
> -	 * and traditional branch.
> +	/* The cases are call and the branches with a PC-relative
> +	 * displacement.
>  	 */
> -	if ((insn & 0xc0000000) == 0x40000000 ||
> -	    (insn & 0xc1c00000) == 0x00400000 ||
> -	    (insn & 0xc1c00000) == 0x00800000) {
> +	if ((insn & 0xc0000000) == 0x40000000 ||	/* call */
> +	    (insn & 0xc1c00000) == 0x00400000 ||	/* BPcc */
> +	    (insn & 0xc1c00000) == 0x00800000 ||	/* Bicc */
> +	    (insn & 0xd1c00000) == 0x00c00000 ||	/* BPr */
> +	    (insn & 0xc1c00000) == 0x01400000 ||	/* FBPfcc */
> +	    (insn & 0xc1c00000) == 0x01800000) {	/* FBfcc */
>  		unsigned long ainsn_addr;
>  
>  		ainsn_addr = (unsigned long) &p->ainsn.insn[0];
> -- 
> 2.55.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
