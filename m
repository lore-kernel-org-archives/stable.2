Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E43D955F;
	Wed, 22 Jul 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710174; cv=none; b=ikmYGK0FMRXPI4moW0eq7oKno917jTprhQkJWsr+lBrTgBxxasZqpwn32zZurdIIgt42LZDifENIJbys4xH1c1MyJ4AR1z/kgrVCFf56b2k12lIyjGGiOgwNIQebVAC+7VwFC+mX/8ZxrK3iriKM4ohPhH9wSLh93wp4FZH/HbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710174; c=relaxed/simple;
	bh=0eJ51hMEsT4i3G2wfs25Efu3Dg4DjZJuEOzTbGfJxgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eiTTcYpc0NZSH6mcsAN2M+hbhjrzzO9nq8NSFpHrSKH6Z6gfY80QSyYoqtn3Ayv4aYrPkIKar0zKfhRo0N2CxQ+iNLHmKmB4y33fzVhQ8y1n1bWah26Oe3Ss5dlIfkEKzNQBFutUfSuUr5VagHdGoyZwbKc242PL/AGRT0z5Bh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1asIkeXV; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1asIkeXV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wP2YIMoJu7BNs5/6oLWSmAw++AAZluHFpCpirm2hGzQ=;
	b=1asIkeXVDKKfx8MmR/G4t9RG3MC6sJXRoxCLXoqrhDE47S3vQQv/TSAuNs41yLZm2qJAri384
	O1UkJa7Sq+NKsUdYeTRweydQ48biIaTTIoFHUbCQRJ1eC+4nuow7+vN+iK3NRjK8l2Hd7zqkmKh
	gtC8cGYjFY8Omn25ydT5DDk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h4nkD3StqzcZyH;
	Wed, 22 Jul 2026 16:39:48 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 35444202E6;
	Wed, 22 Jul 2026 16:49:17 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Jul
 2026 16:49:16 +0800
Message-ID: <cb2d9feb-bf4b-4625-a9c5-2f71381214b1@huawei.com>
Date: Wed, 22 Jul 2026 16:49:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y/6.12.y/6.18.y 1/2] bpf: Fix ld_{abs,ind} failure
 path analysis in subprogs
Content-Language: en-US
To: Philo Lu <lulie@linux.alibaba.com>, <stable@vger.kernel.org>
CC: <daniel@iogearbox.net>, <info@starlabs.sg>, <ast@kernel.org>,
	<john.fastabend@gmail.com>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <mykolal@fb.com>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<dust.li@linux.alibaba.com>
References: <20260722073908.72382-1-lulie@linux.alibaba.com>
 <20260722073908.72382-2-lulie@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722073908.72382-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/22 15:39, Philo Lu wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> commit ee861486e377edc55361c08dcbceab3f6b6577bd upstream.
> 
> Usage of ld_{abs,ind} instructions got extended into subprogs some time
> ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks."). These
> are only allowed in subprograms when the latter are BTF annotated and
> have scalar return types.
> 
> The code generator in bpf_gen_ld_abs() has an abnormal exit path (r0=0 +
> exit) from legacy cBPF times. While the enforcement is on scalar return
> types, the verifier must also simulate the path of abnormal exit if the
> packet data load via ld_{abs,ind} failed.
> 
> This is currently not the case. Fix it by having the verifier simulate
> both success and failure paths, and extend it in similar ways as we do
> for tail calls. The success path (r0=unknown, continue to next insn) is
> pushed onto stack for later validation and the r0=0 and return to the
> caller is done on the fall-through side.
> 
> Fixes: 09b28d76eac4 ("bpf: Add abnormal return checks.")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/r/20260408191242.526279-2-daniel@iogearbox.net
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> [ Dropped visit_abnormal_return_insn changes: depends on 7.0 symbols from
>   e40f5a6bf88a ("bpf: correct stack liveness for tail calls");
>   Hunk1: adapted IS_ERR/PTR_ERR to !branch/-EFAULT to match push_stack()
>   NULL-on-failure convention. ]

These versions does not introduce consumers corresponding to the output
of jump tables; therefore, the assignment of jump tables is not involved.

Reviewed-by: Pu Lehui <pulehui@huawei.com>

> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   kernel/bpf/verifier.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f638b2d3a42fb..3f74767e47484 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15119,6 +15119,23 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   	mark_reg_unknown(env, regs, BPF_REG_0);
>   	/* ld_abs load up to 32-bit skb data. */
>   	regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
> +	/*
> +	 * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
> +	 * which must be explored by the verifier when in a subprog.
> +	 */
> +	if (env->cur_state->curframe) {
> +		struct bpf_verifier_state *branch;
> +
> +		mark_reg_scratched(env, BPF_REG_0);
> +		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +		if (!branch)
> +			return -EFAULT;
> +		mark_reg_known_zero(env, regs, BPF_REG_0);
> +		err = prepare_func_exit(env, &env->insn_idx);
> +		if (err)
> +			return err;
> +		env->insn_idx--;
> +	}
>   	return 0;
>   }
> 
> --
> 2.47.3
> 
> 
