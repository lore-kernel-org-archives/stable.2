Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5E30DD11
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841732; cv=pass; b=o/pjYn5iAT3067qVR0QcCZCwNjexjwBogMWx3vnSA/8h0GHJX9NnmQbnbB78T7HcdtCJpBI5lNIrLIgNVZdclPK2zFCdA5+7f9gthp4gqqgygaVnne2A4MzoNQCQQAcOBxMMQ1HdiohQIKAumNIFXIvXkVsInayLoRqxX8/mgQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841732; c=relaxed/simple;
	bh=SrmVCuE0z2A60bEwTGx2vI1HOCDindP1Sg+9lAI0ufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf+I+vaX5XCuJKgen9KrUwgOHutXdw7p5+cwCgdF1FV6OBQb2IQ4GuMJz4G2fjFeGtYO3zkj36EswWKfYKncGVMuokrbWKD3FWhdRRDTfGrfzAr9MbxfYZzxXGr//mTZxOhCORcHBkymK9ox0bULoSYhD2WmF3WBm43DHtt8LSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9pMEGVX; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9pMEGVX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso16456095e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781841730; cv=none;
        d=google.com; s=arc-20240605;
        b=TJ5pLi2fKHsoSbTKd6XlKF/De533TVGO/R+oVeOWMCY2pMXDAkS37SMJDZfu7GOwLT
         L/dDR+1oJCmDq3ahHMMG+2rU+FXE6ysmvV1TWxxPGHS/pYu7X92cHIuYVigMQwOP9nCk
         ZR1TJDIBz4ZVh/HMJR8o3FuU6U9WqyYGic6/x6lxFTIXyW9gxrDBrDDsmMCe6Zwc5GC8
         c6EHXg2xylAbNRneeqzYSjYJp10wSbXD64/668BeDoJ3efJrPGcIyUmCTwAHdT9bz99f
         1APSayeSdNwOhBfYYxqYLkOwjrMZEbGwgTz0krFvFAKIX19oRrnUPx41HyVu8vX8nAbu
         gDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4J7Oj3rQ90qWkUx3SPFCrLpqO7hYMcDVBOpscrXdscU=;
        fh=kutPr8HN14k8j/zN79ALQtxESAfOXbrxmfdHblAzx8E=;
        b=XuF+vNFS+nI1MC/5ImBVFwqyqLVvBTyP0dMEgT3gNooNmlXLsUOiKtFLjEr8YVksxb
         LjNjhiXSgZD6SF2qGR/RTV9KLkWChR8gyls/C1mUDBT/ZNVTrmDQMXT/gp9PUe8Ngpzr
         Xk8VS514tlQgAhO+TjVyIKL1XDpyIMwccQU8zAnfkuTlHjCbxtAsTEO9tl/IKi8iOKDN
         xcPq9nnTIIEZb2nXYbPo+rA+Y4Rc3PNxNi6KasAjV2wQ9Y+yU3fsXDlF+WlCL85YzoWL
         n5clx4Pg3SKZfqnURRKNRKCodqexoVYy4VAAPRUQZChjuEHvWml+eZ84UZyZPYTp+T6S
         NP+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781841730; x=1782446530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J7Oj3rQ90qWkUx3SPFCrLpqO7hYMcDVBOpscrXdscU=;
        b=C9pMEGVX4hivZfVg1Oz74LLyaOMRiVCS70aR94ntPVsyeM4AtkVbhhwdiVTioCWUKt
         5MN0jtsNBr+WuOdnJLBaWyTW2SHn/m/kNmvChXLcctTzxi+eEe5EbD2Ky+nTTyg64jc3
         e75Q4h0geARrFSY2+74G8DSGKqpEmpY4UanUjyofGI3KwrepLbqXd+xHk8npuDJGgZc+
         LrGMAE4krntE7+j7d2cnWrZM3CKhDiSe73k3iPbFUkqVKWaaM+y1i2yzSBUW5E1GpfOi
         Mb9Uhwnq/Z+ZKpLVDIzh8ZSrh3dg1Iy3Igz6yuFMPn8SaFFoh0Xqa/mNAnG7Y+piQWao
         J0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781841730; x=1782446530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4J7Oj3rQ90qWkUx3SPFCrLpqO7hYMcDVBOpscrXdscU=;
        b=kn2V8rpNjylKFeispAWGAIIJyTUGFJjfB8pCeD2p1IcwF34j51duwzw9LlUiNMF8FT
         4HqRYwT7Wm/4nxbNLy06MXT2jZTm+dpY70HQuhVLSxKXZqoPZThhtKmwg+suKHF7KX/X
         Paxm5Y0u6IVnRrSn7mlvwmvMMcABxwCnbkiYCiBt8JJLfUDDb3BVukTq89vABToYCc7+
         S/Kfa6nyqg4yekT3Dpz4qH2zE6GnJZzvZmCB64iqURk9yQPAJlGzy99CP5cz/vPZkOP3
         g30N81t3AijZhrFiRwn+58r4NngsmQ7hOXo8tYSY8+jfdQgYpG8E9Fzx8TzREn0fHWvF
         W+DA==
X-Forwarded-Encrypted: i=1; AFNElJ9/tzviukTpeKZ/btwYZh3KmkkSMmWOKLLT9rjKqRpq4EuLAktciFBF+4bDBtCJISI9nwkM8ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIyyb+Y6P/a1DKIPFiG7Q06n8wQokwpvPUAYBV2NIHDu9/utK
	BjvHLmvNISRfGWeSPqc+RVVaAJzFET5auvU5uRL4XtdTwK6Wf1VvjDSg42vsdtSz9eiL1qwbUZV
	C+8JID1emYR8f6klIsk0MPPqJ+xU9qMw=
X-Gm-Gg: AfdE7ckSidUdvpRYA37UhmK75L1JpPB5/v6PvZrLp+kPDSZJXsV/fZRIkZCg2nXdb5y
	SeNZnpXkUBn0xwVvlozRIj0ZS+j+eKdwz5npN1WjWvAgm5tRbzjVdanfWa/W5+lnNDgQe08YOat
	NyesdEfq4PXugZwBix93oQ6OoVB/X+UOQbV5/7aIFa2YZf8y11OKq82HTG4GAZRkUAOxivpC9nU
	m03prlm3vpN3MkVxY8qB0Z/x9FSjfszm+JI1mI1bupjxh9rN3W4bbqfwZE/bbVBP2b0KmEbfzlq
	/8gAHqP3jKbJYiy/n0KViutSxt1cHg==
X-Received: by 2002:a05:600c:1552:b0:492:1e36:4271 with SMTP id
 5b1f17b1804b1-4923f5a3015mr33871615e9.37.1781841729565; Thu, 18 Jun 2026
 21:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781194510.git.jt26wzz@gmail.com> <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
 <ajDiLjjSYPp5p7KF@u94a>
In-Reply-To: <ajDiLjjSYPp5p7KF@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Fri, 19 Jun 2026 12:01:57 +0800
X-Gm-Features: AVVi8CfIxnV6GRS_uMsP3TeXzLkxWVmYY9cT2iPjdN2Mvfo3khN1rli6Wc4V29s
Message-ID: <CALgi0XkEqMdawDeU5ewz_uzyweMd7XvhPbNt_qQNd=KCZYziqg@mail.gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 1/4] bpf: Track equal scalars history on
 per-instruction level
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On second thought, I'll drop the cnt =3D=3D 1 reset (and the matching cnt >=
 0)
and follow upstream's cnt > 1 in v4. It gives no benefit over upstream, it
only adds the corner cases the bot flagged. And The other two points the
bot raised (clearing id on overflow, collecting src/dst twice) are upstream
behaviour, so I will keep them as-is.Thanks for the pointer.



On Tue, Jun 16, 2026 at 1:51=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Mon, Jun 15, 2026 at 12:58:38AM +0800, Zhenzhong Wu wrote:
> [...]
> > +/* For all R being scalar registers or spilled scalar registers
> > + * in verifier state, save R in linked_regs if R->id =3D=3D id.
> > + * If there are too many Rs sharing same id, reset id for leftover Rs.
> > + */
> > +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32=
 id,
> > +                             struct linked_regs *linked_regs)
> > +{
> > +     struct bpf_func_state *func;
> >       struct bpf_reg_state *reg;
> > +     int i, j;
> >
> > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D known=
_reg->id) {
> > +     for (i =3D vstate->curframe; i >=3D 0; i--) {
> > +             func =3D vstate->frame[i];
> > +             for (j =3D 0; j < BPF_REG_FP; j++) {
> > +                     reg =3D &func->regs[j];
> > +                     __collect_linked_regs(linked_regs, reg, id, i, j,=
 true);
> > +             }
> > +             for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j=
++) {
> > +                     if (!is_spilled_reg(&func->stack[j]))
> > +                             continue;
> > +                     reg =3D &func->stack[j].spilled_ptr;
> > +                     __collect_linked_regs(linked_regs, reg, id, i, j,=
 false);
> > +             }
> > +     }
> > +
> > +     if (linked_regs->cnt =3D=3D 1)
> > +             linked_regs->cnt =3D 0;
>
> This part seems new, not found on the original commit, and also not in
> bpf-next. Can you add some more explaining (in the notes before your
> signed-off-by) regarding why this is needed?
>
> > +}
> [...]
> > @@ -14704,6 +14899,21 @@ static int check_cond_jmp_op(struct bpf_verifi=
er_env *env,
> >               return 0;
> >       }
> >
> > +     /* Push scalar registers sharing same ID to jump history,
> > +      * do this before creating 'other_branch', so that both
> > +      * 'this_branch' and 'other_branch' share this history
> > +      * if parent state is created.
> > +      */
> > +     if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SCAL=
AR_VALUE && src_reg->id)
> > +             collect_linked_regs(this_branch, src_reg->id, &linked_reg=
s);
> > +     if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> > +             collect_linked_regs(this_branch, dst_reg->id, &linked_reg=
s);
> > +     if (linked_regs.cnt > 0) {
>
> Same here, the original commit and bpf-next has the '> 1' conditional,
> where as your has '> 0'. Can you also added some explanation on this
> part?
>
> > +             err =3D push_jmp_history(env, this_branch, 0, linked_regs=
_pack(&linked_regs));
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> ...
