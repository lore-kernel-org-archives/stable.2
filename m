Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA237F735
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243459; cv=none; b=kqLDBZ6/luRJSLE4oTcwalpg/uUBIhVi+8hPA1HfvPdLS41UVKA/TMjzLR/zulO4NWkscmsseDO3D4/hbvW/q6iAcOz+YEMOZydefH1AzFSghF075SJlI9AdSUA4W2X+V34Q8QOq4cPiA7EuO8xnhH7/FGLRnPGrbeJqqK5zY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243459; c=relaxed/simple;
	bh=C7gbci83GD+t9Huu16iGSHml008dP62awDJLoswA3s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYZ5d/+CGOx09aIRmtoXLg+rxw+ze5rqpbXpfcYLT18ak4JuWJmlzwxtaayrFbiPf7o2ijc+Y+IMxqp99jUugA+79Y4vvC5iz2rr0NKgOLO4rmWUo1R0LVoXzFydvxTs4RF+QFGZXH8XGCWGgW4hJnFS6UnLQTXdgFVb8J7ADoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AC0xIYIe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AC0xIYIe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so24819075e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791243457; x=1791848257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/tHJXYEmrDPsmKmiT0kZDlKzYZtfAGjKXPf1jJKMEU=;
        b=AC0xIYIegX1QOd8KmwEYpn06C3gOaZy2zHbvC3Igtv88yUqzu/Fb2LFWdMOpibqjbi
         9UdCY/yll2hX5jjJhlp1l6Lws2MBzCoyeamxO2z+wd5rGBW4OGk6co15bgIMqZq8ouqL
         wjXQ5qaQi0I2dWjhircE2LGVZShnm0JePz3i43ylz0OI0EiqevJ1JUbJv06O6ZcuibAw
         HKtw2R8iQjTmW4UNYbwuRoL6f3ehUuiZf8dpN2F+25zG6f+ePH4F8g6hg2dl9AbejIH2
         sOZBqOnDr4T4WLSgpKBMyBoBc8obH6hnNlZYkXTb2KNswOpYLgnjDjWBfoXgXBRaUSqg
         l84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791243457; x=1791848257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/tHJXYEmrDPsmKmiT0kZDlKzYZtfAGjKXPf1jJKMEU=;
        b=dBg5AGjrVkFByhw0zcP0UPdwc4cwO+E+SsMXSQ29t0gBjPHwh+SJoaHZ5Mq/qDH/No
         +TbX209YN9w8D/al+kEDzpEap5N69Cwwm24KcNUGuZukHHk6JMgqT7lcz4F7t+LGdbDF
         UY0spMVtzMFp78ckSMmJv2pq2jh/Xil1EbiLAehd9XcPCLFtRBHdjPgOXJm4nzlYs0un
         yHQqPJeAWpp0vUtdhK4g0S7UBX3rM6sRN+DBbXaS1/YrLGcdLd66PZAADt8URYh0j0v2
         XlJgS63vFxNj29DHlPnxW5CMeiCXY7smAw5+SEuZv96JIGmPhoOfybKdy6OMR5DeXpef
         xVUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxI/QnctjkO8iTG5mdZzKMa4rkLbeHqN+PM6SZP33QuOKaV6IKuiqERfac6WF48P+vSAmJ2Qx0=@vger.kernel.org
X-Gm-Message-State: AFuF++l8icXkiHN0ppTOASFW5/0C/jVcNx+IFPi9r70gPtI7ggYR5Dee
	gWqjtOjSnOWQMPpHewXjGxT3R8W/dl97anbrUpg10Tgmy/PllfvcdlZm+G4J3DTFV0Q=
X-Gm-Gg: AYBFou0w/iC7BM0tdLHJHoCX7wKGT+NVP+gun2HY/gKo+mEFlBqeo8K3r4kf1VwB5SO
	UCquuL9LJ8v5610CKL0Lgv2Jk8rocQmL4r36Hq6TlAzx8pMkuHOrzh3p7WxyCXZbJ2ah6v/u8tC
	sRlsO9mNtHMOS2N5SpN6iWBDTa4djJRu1WQ2133RloCEZxh3RfFA1Hnt20xEJjYhmMXezpKy6CV
	PyQC6wCmWWv1iyXd7zSJP0Kj00fuUCcTPbx5BP8bVD2Sql1+kvmaSNmObOxJm6X3K0uTiBRI9kC
	NlxQFtuyKrAf0qQfIqqrIADzkXSmyJyzHvr2ciuwJvUOZpzlH+FOq8JqhUgKk+BqJ73TWYkesfp
	OdDt0ACn9sWMuhSjm4qMkLfRFY3LlxaK0DEjWGljCVSmwqIjjXDMfUJ3JpiU5J0oV4GWLCKudsL
	W3fPsi3cnZFop4Ff6lNBF782svQb4WK3pHabXnnPnnz4DSso4XDXSWbMNJYDmHfdVCMmA15xcuR
	tL7GxWhfGzcRdqB2lgth3I=
X-Received: by 2002:a05:600c:3b01:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a1680ed179mr129727315e9.22.1791243456729;
        Mon, 05 Oct 2026 16:37:36 -0700 (PDT)
Received: from [100.64.0.1] ([147.161.130.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db0929sm24701835e9.12.2026.10.05.16.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 16:37:36 -0700 (PDT)
Message-ID: <a25d01cd-e21d-4e51-9d24-6cc41589c041@sifive.com>
Date: Tue, 6 Oct 2026 01:37:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: futex: untag the user pointer before the atomic
 access
To: Ziyi Guo <guoziyi114@gmail.com>, palmer@dabbelt.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: thecharlesjenkins@gmail.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261001184355.2395068-1-guoziyi114@gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20261001184355.2395068-1-guoziyi114@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-10-01 8:43 PM, Ziyi Guo wrote:
> access_ok() checks untagged_addr(uaddr), but arch_futex_atomic_op_inuser()
> and futex_atomic_cmpxchg_inatomic() hand the raw uaddr to the inline asm
> amoswap/amoadd/.../lr.w+sc.w through the "+m" (*uaddr) operand.  When the
> tagged address ABI is enabled (CONFIG_RISCV_ISA_SUPM, prctl
> PR_SET_TAGGED_ADDR_CTRL with PMLEN != 0), those two addresses differ: a
> user pointer whose top PMLEN bits hold a tag passes access_ok() after
> untagging, but the atomic is then performed on the still-tagged raw
> address.
> 
> Supervisor-mode data accesses are not subject to the U-mode pointer
> masking (that is governed by menvcfg.PMM, which the kernel does not set),
> so hardware does not strip the tag for the kernel's own access.  With
> Sv57 and PMLEN=16 the tag bits overlap the canonical-address bits, so a
> tagged pointer can name a canonical kernel virtual address (e.g. in the
> linear map) whose untagged form is a valid user address.  An unprivileged

Thankfully, the combination Sv57 + PMLEN=16 is unlikely to be in use because the
address bit overlap tends to create performance problems.

> process can thus make FUTEX_WAKE_OP perform an atomic read-modify-write on
> an arbitrary kernel address, with the matching FUTEX_OP_CMP_* result
> serving as a read oracle.
> 
> get_user()/put_user()/raw_copy_{to,from}_user() already untag the pointer
> after the access_ok() check; do the same in the futex helpers so the
> atomic operates on the address that was actually validated.

> Fixes: 2e1743085887 ("riscv: Add support for the tagged address ABI")
> Signed-off-by: Ziyi Guo <guoziyi114@gmail.com>
> ---
>  arch/riscv/include/asm/futex.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
> index 90c86b115e00..8d80e580eec5 100644
> --- a/arch/riscv/include/asm/futex.h
> +++ b/arch/riscv/include/asm/futex.h
> @@ -40,6 +40,7 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
>  
>  	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
> +	uaddr = untagged_addr(uaddr);   /* FIX: operate on the checked address */
>  
>  	switch (op) {
>  	case FUTEX_OP_SET:
> @@ -82,6 +83,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  
>  	if (!access_ok(uaddr, sizeof(u32)))
>  		return -EFAULT;
> +	uaddr = untagged_addr(uaddr);   /* FIX: operate on the checked address */

The comments are not necessary. The reason for the change is in the commit log.
With them removed:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

>  
>  	__enable_user_access();
>  	__asm__ __volatile__ (

