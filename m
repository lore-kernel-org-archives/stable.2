Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32523D6695
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589113; cv=none; b=MQcMzQWOfO+dBEscgJiTb9jKxLsGwlzvAwVc6DN30gCW9i3qt82qJZz6O8MbSh9VblupjLFb2wFhX+9gbnMsztrVC/QMW8+NBKDzdBarHkFnSFSlzLehYTlXXNvZXo4PJCNZOVYC3+lTyrXcb3F19DwLHLX7KVQJCy9AXKEPacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589113; c=relaxed/simple;
	bh=7BG2QmmZRLh5N3+eiC64oaFFvrrLDzoLyfL/lriehHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0IV11KFO+3nHTMbjvIfYfnC//VJbqLfU+Q4lr/o0c40szUbDDMsSqRCY/SUvIvQrMTjwPgJgTavsMFLsgKwiFibkYfCEfJZW2/T+MgYBNKFHoAjfgCRujEH7vZY9VWj9HMwkiHaMvFroNanfy269CQHfd3fMuZrlGpNgZtICsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QxDfpumc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QxDfpumc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so28041325e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781589109; x=1782193909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn+WbxeK/3ieMZ9WvMfWf1pVnmuN4tJPxKr7sK9EIcY=;
        b=QxDfpumcliIkLkFyq2V538vW9GarjHCMoWbjN4HO8T6s/IiDNpncAa0mI5H4wdn/e0
         2wJQDN0duell/pBFWpiRxlH/rx95giBgzcgD2VZ7/Xx6pXrTa5qEJIhfuN/TWR4EbWU8
         pD1dM+RTYz9kjj8R6jAHI9PCvEmMvrnZy9qnsy6SNI8eMC83e4bZhq6PcZtpS4hRHmMW
         fuRAnjH3iBxl/p7geKLZs9qwBBPfgIWIxvSSuosapzeO18oKP41Gc9WUig5HXSYSz+En
         xdZ0j7pZdcayL5dGVLvPUfSL0b9imeKgdXiNL+RsMhqo6X1lko2slE4zbQt7HZ1564xR
         rBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589109; x=1782193909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn+WbxeK/3ieMZ9WvMfWf1pVnmuN4tJPxKr7sK9EIcY=;
        b=NQBF7hGUPEAjl4IHcGPViiGPt6YfwmxYFrDVLMOhlWbt8vQq3f7pcqV2weZmFMNJMd
         /h/adKSA+QqNQdKGwJvnviI/GfDpOJDpWrlXHv10YtdAps4tEG26aVDQzNzLf3jRdS8a
         5vmIzNYOtm+uHZ09W89pSbmE7ihW4LSHuPA6DnbAbFugXtY7U2doBv0sVgGkJNwjACc6
         43fXcF57V1aaJV+CnInLGNAoogis76x7mgvqRxWTd4o+AdNtBwhon8q9WrJO1gSzvxLJ
         gRYXM/449ZuZfPBd7Lz8L37pRbLvYCff8MXsWE96KoETZ1kwUeRWV6my+mtn2+DgMk08
         uDIg==
X-Forwarded-Encrypted: i=1; AFNElJ+GgRyZ++NO3lUYLBFUzJUl92K06WrZDGftYQdZs5SNu/70OK1Ike7V9ePEmodDGfk9a3QwYYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojzZSvzPkY+7+LT86tdEc83/ElphJtJLfXKcGaw9Q5zb9DZq+
	YwPCzk4m0VAmQFB+aU59R1hujnP5UX7teEgqJh5tgICKKTKoqBVN/2UFa1E1wc58shg=
X-Gm-Gg: Acq92OG42+CbDwf6xZYxSYxtoMEj7CF3nnr9q0CGGMkB34k/wCb+zz5RJR6YMaVuTjb
	u5JL06Y3Sj3oRQr9W5zggnQX/Jo+KOnbLbY/gqMSDRvOkNycgBbB/OxBrtUf7qQ6EAG6IYK59WU
	SDy+kwXy7aa7mzHDTnY1ZdQdusTBx119MLW+Eo8xKp5Pg/3Kb1s940Lg1cxBTuFwDrTPDu+mLJ+
	FSxQOawP/vABIp4Gp6rRKpJk7dcwc3rgY3c6G/wmhdKWNAyw6Sd3lFDpSLlhl0wEV1Jm0uzKNmJ
	BebHOgEuNcQyxT/RKDM/kdg8x3i4GbDwswWMMY3QW3Fmob8BnDfo4gStO6Y0iq1E3q08OLulkC+
	f7dVL1usgK1uoGblLPdEGDhYVBKTINvkkzqSt58bMdjQu7fQ6lRNlW+ta1zWikS9Ceepagnm58g
	h8mtdxFRa/ixctGNUdZZjnXwyYPrFXHqcvRB2wDI0TLBCjhQ==
X-Received: by 2002:a05:600c:1f8c:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-492200768abmr192521925e9.15.1781589109336;
        Mon, 15 Jun 2026 22:51:49 -0700 (PDT)
Received: from u94a (39-12-139-247.adsl.fetnet.net. [39.12.139.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30b6191bf9asm12009774eec.31.2026.06.15.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:51:48 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:51:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org, 
	Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 1/4] bpf: Track equal scalars history on
 per-instruction level
Message-ID: <ajDiLjjSYPp5p7KF@u94a>
References: <cover.1781194510.git.jt26wzz@gmail.com>
 <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>

On Mon, Jun 15, 2026 at 12:58:38AM +0800, Zhenzhong Wu wrote:
[...]
> +/* For all R being scalar registers or spilled scalar registers
> + * in verifier state, save R in linked_regs if R->id == id.
> + * If there are too many Rs sharing same id, reset id for leftover Rs.
> + */
> +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 id,
> +				struct linked_regs *linked_regs)
> +{
> +	struct bpf_func_state *func;
>  	struct bpf_reg_state *reg;
> +	int i, j;
>  
> -	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
> +	for (i = vstate->curframe; i >= 0; i--) {
> +		func = vstate->frame[i];
> +		for (j = 0; j < BPF_REG_FP; j++) {
> +			reg = &func->regs[j];
> +			__collect_linked_regs(linked_regs, reg, id, i, j, true);
> +		}
> +		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
> +			if (!is_spilled_reg(&func->stack[j]))
> +				continue;
> +			reg = &func->stack[j].spilled_ptr;
> +			__collect_linked_regs(linked_regs, reg, id, i, j, false);
> +		}
> +	}
> +
> +	if (linked_regs->cnt == 1)
> +		linked_regs->cnt = 0;

This part seems new, not found on the original commit, and also not in
bpf-next. Can you add some more explaining (in the notes before your
signed-off-by) regarding why this is needed?

> +}
[...]
> @@ -14704,6 +14899,21 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  		return 0;
>  	}
>  
> +	/* Push scalar registers sharing same ID to jump history,
> +	 * do this before creating 'other_branch', so that both
> +	 * 'this_branch' and 'other_branch' share this history
> +	 * if parent state is created.
> +	 */
> +	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
> +		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
> +	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
> +		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
> +	if (linked_regs.cnt > 0) {

Same here, the original commit and bpf-next has the '> 1' conditional,
where as your has '> 0'. Can you also added some explanation on this
part?

> +		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
> +		if (err)
> +			return err;
> +	}
> +
...
