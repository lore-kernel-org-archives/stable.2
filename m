Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792545408;
	b=2Ov1oTqos068OkDrUgzbh3C761H/IczZb8Ow5cMTtoTeawTXCv3VYLZeTjLXfingKmmK
	 5ABTcRkEDi+otjf6JBdU7EPcUBlRVC0oOnNa2vNtptfMjNTgRzxnkPpWXR1vI8fFCUbgf
	 LIcUwjVxJIUPfNob4VX+RTAh0O62ZGpYC9XtWhh0QUGPTLdINVArGzT2Q58z1z+StmMRQ
	 9woDO3EaSg6YvJzU6Gk9k8NjRdF3oYbuiYsyG9WbSu5MomJ2Wi3KFBderwXw71n+PUoY+
	 dHarpZhJXKceJmKrXcDwR9i4eG3EUfF7XUCUBiiIyEpLQMTRmp4E7uJhZHIpb002gKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
	b=Rx6wJouG8E1NXpBJY6Yn9clBP225uLVjn8W1qtwqW6IlwHCf9wXlckNvIKIoGEE2OVxH
	 jwGKOtNoXfLweX6kDk9euBLoiQ2hcjU0pRBp10H9a3IklVcDYeDHD32jLSpVvXYNyEt3w
	 LSdNmc5Plz3pooHmuhB9tCVovFm650A+9mEHxomLK5+LX7YZ47vAidgHZ6IV9BnQp+bwM
	 vOEcs99/CMfv1ZRfpnVJhn3L4ZhgIGAUKHryPJ2lfzMIcIr1MDD9OBc+XcNcpS1NClP4f
	 bZ9pXnQu4nWZKcexY36XzCfxMGfbVWW8Lrj2xvNIblN8HClc7dg6RdbbNq8pVgSrJ4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beAsBT3a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC772606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC772606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beAsBT3a
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48db8366c3aso76955f8f.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792545406; cv=none;
        d=google.com; s=arc-20260327;
        b=CrzK9hp2lRcQ+x676Icjy90CJHHqkOSnHE0gqxKjeNtd2PnD0PX3hAzCYB1HT2dfHA
         wFjGMO5lPIVevmpiAWZryXgQ71ubBmOsihegWmnKvbkmgWA8IOf8T0jrBVIv7d8ygSD8
         KVG8eNKVRsNR/6aTYtu9WsfZdSE8G5CY4eTsdFI8wXveUMq4S8iexrXj2t/+5ucke3tq
         RGYJFqOnubsR/dYzz2M2Z2Jwdn3HlOGjVdJVarLZ8qP5DGVUOye9kOg0Hb0iqpWkOom8
         MGaaMo4U5qyUMP9dKhiMGw4D7kjnw4dRmFsPrIhkWaL0KLekh36oH10RolW2imae0T8+
         v1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
        fh=zobXFvuXcbvo8KRPuyJpDEuL8bGCiRO4/hTyE+SOS3g=;
        b=KVPv1HpBMf9pNBwj/tVUBP9g9aHYAomBkj7DDEQner93Yf1Dha6mAMHSTk5N+SEgpn
         HwjmpCnF/hdISU0NCXcjCbeD9ekNyC2rHiKRWE8ZwzWm0M1hyNUovgcNHccjOiiW4aan
         7HwYnXU7YWOX7VkcFnB9YSGNbUkqjYURbDFTf2wH8i79H4iimMwG9nxz9FISmEsT0OAu
         AH9y5do4PEiH+RL6XZwUSRbgMNjxXWGzOdFv6cwJxB2kNtJ7avV+58xCMzSV4KY6TOrR
         yAarDoJQ1cNfOFtYuBfSE3eyOyPwm0b3Vffj++Q/6prRPMZufSkyIEHLr86X5PJvDW+t
         HnoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792545406; x=1793150206; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
        b=beAsBT3aYyD+aRBMzRCTp/Sd4kSLdXs+vuHnQONm/NdiwkWmX/7I9fmeJGjFqjXCJc
         Q8weid4V8ijcf1D4WFLflO5UI9ZPk8uT2F7aCXqgojtvuS8yymb1p82q+EtVh8gs3R1j
         1TutMkkf9s4C7vOUUR4hiAuAGTbThoSGLajhgumk0hfzK9Ln7MnXcGX9OpZUsFVVNQfj
         JJP+18IO/ppaHmqEUwqEcBY81UWYz7Ao47kYCq2bHX22qiIp6GlEjQnlW0HuKeuICpej
         gVgKiUvK1zzNl7f7x4gefejNK1Y0pNSezYpRgbqCXJOzhD3Z+0Mhio57sMBXIZytY9kz
         D4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792545406; x=1793150206;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
        b=a6cZ7SxsiRNdwf1JIOmQwesw9pJJw0h6etvxHUcOOCJ8Fs7NifQ41vVxt7Tpt4a/7X
         NOCq8n71voRb8aARLrks5NxYbizUceFL7eSKdAu6uVDXATRGqkhFbvAQfnX1ZLNJZGFo
         OVCYxoNxaZ87f2KjYXrpZ7XItTeNx7nj6NaRfIE51ImZQtkrxgef+HxoMvgGfcugiJaS
         mRJqJ9OVSA3AkIRlnMTudzSrOtvvNMwyOR1sWYj4IPBDvpK+5y1D7adVD1lZteCnPENl
         MK6dI8K0FbwbSAU3znIga4ridsxbkoJBeAalheZmyK5WaPI36e2f0z+6sWP2K9Z/68XS
         keFw==
X-Forwarded-Encrypted: i=1; AKwUvBwf7l//IW68XDhZkDS9e9SzF50Vq3lNAA/J6YWScUjk/8vfMamt8v1l1OokpJ8uREVvPe+mmvA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA8mx38oyJxZNyyTswjloyFwwMs3i1ZEFosf3ncyHwv2wRj3gP
	q3x75M4ksv8jpiXT5d+q5C7w7WpPupm/yb/UNYgmfljqtlcDRP0KQUqCY7WZkCp9cW6alm8bBv4
	jn7Yu0JXCnTqmrP5zCl1dPqXcjOq1RLU=
X-Gm-Gg: AYBFou36P13RBAx3U4p58a52EDqSfzduHfHJh+nVD3zhGjojwFmq8nntIX8bRQ3oKbZ
	CqBpxu5q2l6tbPox11qwKEK4knLvJx+LrOY988mgXCiAQek+HjydgZLkyi/tcvrB5TKjLFlkUYe
	I7t/uS9sPP/PmqxKrbgZ4vQkw7L9gg5e/b6ce4ZAmFoFVJn+a9VTXmorUgZDMGlDXCViD+GqImx
	pLxscFRVpdD+TO1atSO8EkuQscQScCpZbQB7z/gr5LLmckb9fi6+pYVvhBqKMoA99DlSubwKlx3
	YYD9YR6oRw9qJY2fmKuPke/lypsoJ2h19mTnbyc2NBxjqyB9FqNYCztYTXqc22UNc7c5nXnDXwP
	nCxWwIPJ7MUTeef+onTGtuQWzSB38zDxHZIBVbRH6WZzCeqqLTBeUL57IB/OVsBk0M3HoNQ+bPf
	FCabUGZXnTKOMuTNBYUYNfNWH0HI9OxA==
X-Received: by 2002:a05:6000:29cd:b0:48d:fd4b:cdd6 with SMTP id
 ffacd0b85a97d-48e264a7c37mr375570f8f.25.1792545405965; Tue, 20 Oct 2026
 18:16:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020145059.2146170-1-utilityemal77@gmail.com> <20261020145059.2146170-4-utilityemal77@gmail.com>
In-Reply-To: <20261020145059.2146170-4-utilityemal77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 21 Oct 2026 03:16:08 +0200
X-Gm-Features: AclHuK_K5Xm8sAmH-AYY7GPbGPUkCACRVkryFSpARJ2cxbI30JD3SrlALPBIioE
Message-ID: <CAP01T77TTMfAExOxcVnyebdNKc1aTFw0yOXQbEW5zZYxKgMUEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Bind trusted fields to their
 parent's reference
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 16:56, Justin Suess <utilityemal77@gmail.com> wrote:
>
> A field in the __safe_trusted or __safe_trusted_or_null set walked out
> of a referenced parent yields PTR_TRUSTED with nothing tying it to the
> reference that keeps it alive. Releasing the parent invalidates the
> parent's own register but not the walked field, which stays fully
> trusted after the object may already be freed:
>
>         file = bpf_get_task_exe_file(task);     /* acquired */
>         inode = file->f_inode;                  /* __safe_trusted */
>         bpf_put_file(file);                     /* inode stays trusted */
>
> Set the walked field's parent_id to the parent's reference id, or to
> the parent's own parent_id so a chain of derived fields stays bound to
> the original reference. release_reference() already invalidates every
> register whose parent_id matches, recursively, and regsafe() already
> maps parent_id through check_ids(), so no other verifier changes are
> needed. An RCU-protected parent keeps bounding its fields to the RCU
> critical section through MEM_RCU instead.
>
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 534200c0d27d..c85c83a6ee63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6562,6 +6562,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>         const char *tname = btf_name_by_offset(reg->btf, t->name_off);
>         const char *field_name = NULL;
>         enum bpf_type_flag flag = 0;
> +       u32 parent_id = 0;
>         u32 btf_id = 0;
>         s64 min_off;
>         int ret;
> @@ -6716,6 +6717,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>                          */
>                         flag = PTR_UNTRUSTED;
>                 }
> +
> +               /* A trusted field is pinned by whatever pins its parent. */
> +               if (flag & PTR_TRUSTED)
> +                       parent_id = reg_is_referenced(env, reg) ? reg->id :
> +                                                                 reg->parent_id;

This bit looks correct. While you are at it, there is also another
related case that needs fixing.

        file = bpf_get_task_exe_file(task);
        inode = bpf_real_data_inode(file);
        bpf_put_file(file);
        mode = inode->i_mode;

still loads with this series applied. bpf_real_data_inode() is neither
KF_ACQUIRE nor KF_RCU_PROTECTED, so check_kfunc_call() types R0 as
PTR_TRUSTED with program lifetime and nothing ties it to the file:

  6: (85) call bpf_real_data_inode#65472  ;
R0=trusted_ptr_or_null_inode(id=3) refs=2
  9: (85) call bpf_put_file#65416
 10: (15) if r7 == 0x0 goto pc+3          ; R7=trusted_ptr_inode(id=3)
 11: (69) r1 = *(u16 *)(r7 +0)

The verifier cannot infer that relationship, the kfunc has to declare
it. Current proposal is to add a __derives_ret parameter name suffix,
in the same
style as __sz/__str/__uninit:

  __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file__derives_ret)

At registration (btf_check_kfunc_protos()): at most one argument carries
the suffix, that argument is a pointer, the kfunc returns a pointer, and
the flags do not include KF_ACQUIRE or KF_RELEASE (an acquire returns
its own reference, a release has nothing left to borrow from).

At verification: in check_func_args(), when the argument carries the
suffix, record the lifetime id of the register passed for it, which is
its own id if it is referenced and its parent_id otherwise. That is the
ternary you have in check_ptr_to_btf_access(); factor it into a
reg_lifetime_id() helper and use it in both places. In
check_kfunc_call(), after R0 has been typed, set R0's parent_id to that
id for pointer returns. On the PTR_TO_MEM return path, skip the implicit
ref_obj inference when the kfunc is annotated so the explicit annotation
wins. A program-lifetime argument has lifetime id 0, so the return keeps
today's behavior, and a trusted field walked out of the returned pointer
inherits the same parent_id through your 3/6 patch.

Then annotate bpf_real_data_inode() and bpf_kfunc_call_test3() in
bpf_testmod (it returns its argument), add a section to kfuncs.rst, and
add reject/accept tests for the real_data_inode case next to yours.

One known limit: if a KF_RCU kfunc ever borrows from an MEM_RCU
argument, the return should carry MEM_RCU rather than PTR_TRUSTED. No
such kfunc exists today, so this does not handle it yet. It might be
better to future proof the handling for this so that we don't run into
similar bug later on.

Also, the last sentence of the commit log about RCU parents belongs with
1/6, where Alexei suggested the __safe_rcu_or_null route.
