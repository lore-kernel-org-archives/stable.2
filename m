Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10C3F660F;
	Mon, 28 Sep 2026 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574816; cv=none; b=Wl+1EPmCAwx+YvN9Wlsda2vQ6jRYluhNHwjds8Y0W7l+Z1oI9Ot9+gJibRQIUmoHfGIV7nsyy5XwvsDYQOHc1Epp17CmAoFjwY0kiMzvV37One4MvlYYQPQtQb31iKx4WTyCMArLvrnLPHE4ftvPo6K5FMZwJVpbAfi2ibe4m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574816; c=relaxed/simple;
	bh=Sa9ANnMdrvjoHVJJnXkBAd7fZ4XiB5zqaVOy/6+ZTQ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZLti3oiN/p4l9jiWKcASpagHkZegkXriAtOgyOY21kPRiC1bGMxyn3W+dEfUZJ83iaenGjTAsEWPOp+fCr5eumz38cLAO3lrwnObe9lCaM/3mpKHabwRWZ7Sti6ePNBCGZ7yPGIUE5SvaHKUu4ihjw9AAGor60FWqCliU+Zh8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcytknhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcytknhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2911F000FF;
	Mon, 28 Sep 2026 05:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574815;
	bh=8OzKWCHXZOOd1DMsxhT+yj+4zopcmCme2x/Ty8HYXns=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FcytknhhN4Cy27FqochWi4A7hgRvRB3DMBQv/DpUfSX0Y/RnYIm79IGQcH3uqQsYL
	 RV0sr8phCQY9nrs2veBd3D4sTYbta7LCnUlVx0BRUBSTKsiPS94sVArZD9pHtdD52W
	 XkYSt8DZ2gDGsKP/3OB2kTdLBprvThktHSoxmvvPuU02KecKikB1WlbP8XsWMPOu+Q
	 HP+a/ZvJAhtWj5zJqVq/EDHY0U4b5mwySQYpT68UZFTcc8nuYPY4Ea9JStD3WUymBR
	 /pc26CXy2y3n439l/LrXoHarQ2FfJkjICVZJICMpwtwefUEAxLwZ++NJQSZSWrP7pT
	 kyiHAJ3gMX6+g==
Content-Type: multipart/mixed; boundary="===============5440859186137990361=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d7912c1271257cbaf2a35a1ca599dd71407ff370742ad47851cd1b136f27c03@mail.kernel.org>
In-Reply-To: <552225fc257381fb83d282b3040c6ad363246465.1789982239.git.skb99@linux.ibm.com>
References: <552225fc257381fb83d282b3040c6ad363246465.1789982239.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v14 5/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 05:53:34 +0000 (UTC)

--===============5440859186137990361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8ca36a933c7a..c2717f0d9cdd 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>  	 * 1. Update the address in the long branch stub:
>  	 * If new_addr is out of range, we will have to use the long branch stub, so patch new_addr
>  	 * here. Otherwise, revert to dummy_tramp, but only if we had patched old_addr here.
> +	 *
> +	 * dummy_tramp_addr moved to bottom of long branch stub.
>  	 */

This isn't a bug, but the comment "dummy_tramp_addr moved to bottom of
long branch stub" describes how the layout changed rather than what it
is now. Once merged, readers have nothing "before" to compare against.

The updated diagram above bpf_arch_text_poke() already shows the
.long <branch_addr>/<dummy_tramp> at the end of the long branch stub.

Could the "moved to bottom" note go into the changelog, with the comment
instead saying that dummy_tramp_addr is the last SZL bytes of the JITed
image (so it lives at bpf_func_end - SZL)?

>  	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
>  	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
> -		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
> +		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */
>  				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
>  				  (unsigned long)new_addr : (unsigned long)dummy_tramp);

The trailing comment "/* SZL: dummy_tramp_addr offset */" could also be
clearer. SZL is the size of the field, and the field sits SZL bytes
before the end of the image. The combination of the expression
bpf_func_end - SZL and the updated diagram already communicate this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36381917401
--===============5440859186137990361==--
