Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958605;
	b=NM0thawbtvYdQaZlUXA3KEO4Vjs8iWelDK7ECWRrOWvNGZX1oDySxNSqnmHmSC3OmB6T
	 5LSAC8bQRU4HxakR3+mIigrFdkzxgYSabSZcjskw3EYYhxCuibuHwtohIY8babO9imAhd
	 XocIlAESVWsNliZPANaH3z+A60jTfhaD+gKM3Ab+vkc7zeVqu83DH8rsCZyud4NpANVkM
	 2pin0AYr0R0toeGqQLRJFDbPkWQGDopvP6rfPTb6Po8GPM30XdSgAO4rbPqRjwyPGbPto
	 JD9fG6iGSZb3pYjEsmE5KYTQtt0ox/K7XmJfAMAmJk71j17maCFgut3QsasChZzBOEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
	b=Yd+482Xjdja/x0kylI24mPCCHmvP1dRHmNubg0jB5Tebtu46zzDvvLi86aPiTzVkZK4Q
	 SlG3PCAMJq305Sd/4+P4/O7Ye2BPfE+tuunMJGfXpYb+HOGe49T08f1CyqouLslnewKBF
	 coKgE3m4WGA6N2f7u273+uOOSFwpdIQuzTD5d2qLuqSGQu0NIJeek9cQpR+UdVmFzP+6o
	 GBFntww1W4OhjoTSiELWHTvpB2KCWm5vOlHNnjBPqg3NQcPqmOzJdffm6hpX5VuO6ea2z
	 pqKKkK/cixrmlmuQWSR2YIo2JVzPlOaisFz/0UFKXNyz0gA/46kWpVfmQsIVulgS9Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzqR38H4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062E606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A062E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzqR38H4
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so444400e87.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793958603; cv=none;
        d=google.com; s=arc-20260327;
        b=b46WbDLq+2YmOOojZ4kxraCCd8j66yE0o4G0d6+1G5+2mZTC4NDYxVIcManpR4SqFD
         LbukgJCipzUpd+XZeKyaMP+/Vphxpya9zppoiYjk0MFxkGVT2V8uKWfPpwM0LLp2h0Ie
         t7mLxjB03PrCZFT4HHQHwaN2+NxwMvDks5R46RsFbDFr2W0G7IUz0hLSwI3cvx8pzZSV
         wkRhMjdJ/epJ0Tj5mND2lv3J0xjad1Oj95knMeFKCJGIza6km+2UQNwB4rrpILU4EMOS
         5med51UTn7bNcN4KO/IwwpNs089BmAz19Up48GlJ9MApUZIro3KG69IU2KMLiDpO626T
         v87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
        fh=ZBKvK/7Sk1K2a/48EUU9an5S/G24r1gfSz6xu5Fysqo=;
        b=ah8+b+oGa98vKmwCZHp67c0na0hBKrU1N0hPNAafctv7YcOGr418Ju10k/N5mbmmO8
         PSZH/TGfmxjXXTTl9aEjuyKt791VmJEaHrnyoaZ+qAeyinfhkeZYcH1OMRSYe/9GQFtt
         72mxiYmATamy0TIX9b+xN9mXHwTlAImpOmLZ0U/h4s+fwfdMjt9JZOI3mQqC3brgbGJJ
         heyi3zbUdCTPp1GuuQ0D8jqtBPmGcQ/flCPWlxnDGz/q8KX6WlCdbYPvUMYWf8k5Ukz2
         lL0iRRJXYEUiLsFIBOUxn0/0sdCX/39MDlqb3M5lWuO0pEFTqxqD14VTYB9xp9pkRIbM
         IBrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958603; x=1794563403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
        b=rzqR38H4iEVTKI+W8IRWYFkzq+tJB5Y7OYE9A4p0tEOBaQNsBTdTA7sSi1pfsAY1gG
         7QzqTwgXkb2GChWskkYKohzYaCfimpwZohcZRYXI5LPZIdrMA6g7TisHn8U7fkyUXuc5
         U/YenI1adZs2ilmqX4Pgvr7Bs7vHRHF7PiYReq1EXz8HxxEqDio8FhdexnCgFeiO/w1f
         +H6PTu+wk31z+u3rJvDtXUeF9MmDkKwKJ6ZJI2154C/4yzyF+U2IHBRZUqC1zOB1LJmZ
         /fFUHYTr0qn1emJpZ+d/AlxRHbtK7oDQUTIL8ATlZnPPGHw5I8zXcqoTmn9j5pcnh6in
         fpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958603; x=1794563403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0RXhXRHqPQplgUbaoUrvnlIZ5UbVQs/4MlB5+exT+o=;
        b=BNWjiR7mVASdKLM8bcSHAk6yGyXG4iLoI4Z3pFvVQPidnUKhu5KkGKr332w4+uOowS
         Lk/+RLMLOvJ46VN59rveSVGjBxpSu9rL4aUAWWSVN3BD4/L5nKl83p6opv31U+rvEdNN
         vOaShEQj69fi5WWxap9VLejzZOiRJBy/K+BIOO+h5mO+P1RJXnviwfs69EUiZDnjwJib
         /lLiZllRAmNzBBBUFH3uFKxunzBcJkZ8c9g1qxvXO7lqyL5aU8p0RChFzOXmTeLE4AUt
         8tKkSKAyWwPkji4/hPW2ngw7Qme0juVlw54Nw6yBBFlEQd9OCwp1cXJTUx9dXOImZOxu
         Z98w==
X-Forwarded-Encrypted: i=1; AKwUvBwq/kQsOhXEPhjHd6ZDIqxcjVJEWU9um0Xm8Pg9rw1jBpABgA2X+JWHPjeqjGJLCKdUe36MF/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9TQGsicjnv8bO/7c5zA0wBwffBt97K1SBCIXwqCa+MLt5GYUV
	v/rUQGr1LKTKscp8CPY+w1sNet2RLXv94qekSjU99ObSwzFFY49GtlrQWYuc1zqQQj7VnI3rAx4
	6o3qyhhb2HsEYe2o342gL+584OKR3Yw8=
X-Gm-Gg: AYBFou1BnatsqGrsvxmLpBC2S0Yr5NcPKyn/m9w+DrvsvgW4rUFTqVhFecdpTnAxzMN
	262kbfkTodcShDkQLIFESsVn3A9LI7joRBbXv9jnxhyP8DWtNDTR/MVQYwI0Q/iOJzBUX6V9EIk
	kYJJDvmsgKIAPrYCBxmaVA3VaINJuT01C57K23EUOxsQbQvj/CB6mVW1IWZ6tsyQg1fVr7VRi0o
	W1vndBZRo5mUaptuhQQ4jy7cVnqaOZQT9lS87r8Vqu0adhy3Levxubg2+s9ZSJ9v87Sc19K9dF5
	vySa82YiZp29wwzwCDqmXC5mQiV0EW5bztFaxPmtxtz09DMzzpGpsoicu9010IKB3qMcZXJ/mM1
	FRK0cr0UHrhFxHdgmzBUr1+XmzE1x3bd4rvUaxJgk4ETRIhYKCdFjWpYM+cayAwrFeAcS
X-Received: by 2002:a05:6512:3d93:b0:5be:3d95:3c7e with SMTP id
 2adb3069b0e04-5c003c084f6mr599060e87.65.1793958602580; Fri, 06 Nov 2026
 01:50:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017030927.345454-1-suunj1331@gmail.com> <au01Qocxd1gsXs42@inochi.infowork>
In-Reply-To: <au01Qocxd1gsXs42@inochi.infowork>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Fri, 6 Nov 2026 18:49:51 +0900
X-Gm-Features: AclHuK_aMmYFw0Il5my2_hqoI2l0YbFq5ppI5iN9PgB32Mkgeg9mxiSxKYMIzIU
Message-ID: <CAGwK=3q7MuQQxMZSS=c=UxXX08xgwPqs7kpsPy1EiXgbZbknCQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on
 host-writable leaves
To: Inochi Amaoto <inochiama@gmail.com>
Cc: anup@brainfault.org, atish.patra@linux.dev, tjytimi@163.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	andrew.jones@linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:03=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
> I guess this fix miss a part:
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 53bb25a5a60b..1b35ab980a10 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -761,7 +761,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>
>  out_unlock:
>         kvm_release_faultin_page(kvm, page,
> -                                unused || (ret && ret !=3D -EEXIST), wri=
table);
> +                                unused || (ret && ret !=3D -EEXIST), hos=
t_writable);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
>
> Regards,
> Inochi

Thanks for the review.

Sashiko also caught this shortly after v1 was posted. I'll include the
fix in v2 and send it shortly.

Thanks,
SeungJu
