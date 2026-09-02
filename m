Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A527080D;
	Wed,  2 Sep 2026 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316769; cv=none; b=VC67eglL3M0LWuFaJC2sabxjF97dEIkt6vjoVng3TQuCkRqSllj8EBhxx+TltFgy61harOPIMVPY3qVEalyt4L7r2NY5zy2+VXBoLUVqwpkWth6zo7w6nfdbji3eRkXUxdt4iRgDi2iycJuiOikezXlHRG7P7YUPPdBKBtc/tIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316769; c=relaxed/simple;
	bh=HwFCME1bbyW9DPGNwi42XHeJ8cKmMj7Mymvu2fAXztA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmFK/BXIUZ5Qw2MbCxOu5EcNSWwXD4nS2CRUKqN4mT1G5mVu/r28doqDZqXPjM1salmxvUZ2n04Sz2awLF3znZ+cgcpqLlBVKkDhlyfpvrd/Oq4UOio9StIShVW10lZlY59X5c70TA5l/hCEKkaeetyVkFf8tPhRHnVkJbB0Qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=Q/vWKjlW; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="Q/vWKjlW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1788316718;
	bh=HgDg80tnyywBo64CnNxFufQ3b217DthmKnoye0wSXsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Q/vWKjlWyZ/+KFJ3Uh1dhnPucSe4bFcSupR6UoQ5zWOM2/zvANhFStCi8bksmmT9U
	 Z3KLxhGahQd+gn49ouwEF3k2iq8eZoW0dzZ7tO1uGUsaOiRG5YhVIKXO22ilPARb04
	 VP3d/aYJJ4XU9IU7Vql8rzZrtYiNelFkUxm1PWi0=
X-QQ-mid: zesmtpip3t1788316711tab458a83
X-QQ-Originating-IP: svliSfrIKtSXLTHN7VTB1VcWbIBFuc1Kt1E2PKiS/Pc=
Received: from [127.0.0.1] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 02 Sep 2026 10:38:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17053342436727511011
Message-ID: <5CD1D03C87727CAF+89c500c9-7087-4e63-b1d8-fded3c73ee49@smail.nju.edu.cn>
Date: Wed, 2 Sep 2026 10:38:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in bind job cleanup
To: lyude@redhat.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MD5XEDocxEOLJs3Cmx3L5NxwLFgnmstUws3xluGcAliII/sizzTACps2
	qL+bYjd4iNTf9GO8NocRwAY7ZFyzC9pttQN2RbQCh5t8jJ2zs+ZPNTijeQY/FDxUTtIQwAg
	5tsribeDs3XJRBbEo1fU3M1nTLK6iPE09uFjBNFbaJrlVOHBarUmlMsFw8XkN13LJFpdMec
	iHnIKhmNESWLWRGD7mZC0zlXX85svnb4KNuIjTmRK4kSv9u85FR827SjJOQCtDXiJ09oMLo
	lg1EvMb+gqa7GomT3Ky2kwUoiETMyCXMNkLloQ2TmgweuWFFYEdCxxjsd/gw4/E1twYwhDV
	84tupUdu8b7z10vm6ME06RnlC1TMFbb7L6kMf0mfrvGZqzyUuwrUqPUjLadrb/ZRcHAwwpt
	gt6EE8s+2YKWCpP34n5/hkAScFfrtD+PHSRgWPeGm1a3U15I8sV/OaDiKa01SKdSDSgGjQo
	JjUV/LYbJTHr5Y6RWwS4Ma8R92gglaBzYO1WqtLLBfMK8gCcGswr40sXyjJrt/vUfDkHuXm
	0s6TicDZ7dX8icR2VHwLuJlHcGO0TOWfFVngkitzWJBF8jwL3Jl94tgvfEBm3JJDZY0MGsx
	BXdMM7al4uzjyzfWdQy8B8J2U0NbJGOBg9QnKqPR1VepA5CYUD+Wj+k+z8htX2tWaKf9RRh
	kScXc6EcHLmuJ8NmAwQAnihifon3MlB0Hr9nq19iolKyjftWcHZ7Q/l2soEwSO9LbVEr1Ij
	LYHRBzMobVUx/O1GTqLS5yOgchtxzkbeq1B2fJAczfha4dMkpxlQB70HG5Sa9wtq6y4RD+n
	lSine0iBrGVMfFriklx5huyUkBeDls75ysWPO80BHYxeilLWpd3+c1Y+kfyjSuorTiJ73sv
	nqmkiEcCEmCauPNe31UN/BHvIfAQ5HwfX8JxZfZCR8YdXmaNI/A0xWHTSdiaCojm3x6R9ZQ
	AY/Zpxo3vONnSgf41TbD3uzlsJwZlX85bVqmkmWa3feaj8eLp+a6MrlHeV+yzwMsygzkcoO
	rIuwvggYiPjhrynNBalXxMHZRjuNRt1jR09ZH/Lh3QAu3m+AhFVcgQ5EXWMKYPCu2Xh0CZ+
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On 2026/9/1 14:32, Peiyang He wrote:
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..aad14316cbef 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1318,6 +1318,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
>  			op->reg = nouveau_uvma_region_find(uvmm, op->va.addr,
>  							   op->va.range);
>  			if (!op->reg || op->reg->dirty) {
> +				op->reg = NULL;
>  				ret = -ENOENT;
>  				goto unwind_continue;
>  			}
> @@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
>  								op->va.range);
>  			if (IS_ERR(op->ops)) {
>  				ret = PTR_ERR(op->ops);
> +				op->reg = NULL;
>  				goto unwind_continue;
>  			}
>  
> 
> base-commit: 786262be6048deab760f68c8acc2c85607165894

This patch is identical to Zhenhao's[1], so please ignore this patch.
Sorry for the disturbance.

[1]: https://lore.kernel.org/all/20260811-nouveau-uvmm-vmbind-fixes-v2-2-aaee4b395d04@gmail.com/
