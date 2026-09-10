Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B243C3F7B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029891; cv=pass; b=AWakWRsrB6Dhr0c4JIr38pUiCB/LFdo1idOJvN9opfGNSYa3Ulgokg8hr8M2bWn1WAH4ZUo6y9TULCDWUp99jWDkgfbhY2Ihfs0oK82B5ZZTpeS68HS/KPspYw8DLThgm9jMWcvkxqnpcp+YMmbG+BiiYsb7MNGsrV5oQBB5KNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029891; c=relaxed/simple;
	bh=2L4i5AeMVgZ8ZbU5eaRQAyD/0mMzF1qyndAZfksaAzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNd2cAc3iGG4/E0t3uUUqolFYWugN/4S4lYaZ6Z697zf14MFjMnNONAQfSArvpc6nB+kxsLVb/KL0vLboSxGj9WrXxfySeRqOQwIpBDjmPyG/t3BwiM+t7EJ6qWe731abiBfm3LGBp4CKaGErEXK+K2PesBzyAqpBQATTToIkDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=LGfFbAZ+; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="LGfFbAZ+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so53246715e9.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789029887; cv=none;
        d=google.com; s=arc-20260327;
        b=mz676EBZfvC6CuiF32Do08o1P6K9TXRq42JsHHpYFIl/5HB/kVOh4wIi6fPcc7rmvF
         OrBcvQMG6KTR8bSobCDaZpjf12b9mMWJ1fCk/MK8B/BYWAavfVQvIovUYtFoB6nknnTv
         OCTxVu2F9Nhz2SYn/L1zSiqRsIpmrX3+bF4YYyP3WAFb+Nt0a9UXZmXQZUdeDNhjiO07
         rbDdeSQg1BUpqDWqlV+xLkxWdMKoZKVDqVlUylKgv2/2P8df6VJ4AD1X9ajNdsqbHzXp
         Hfg8Wa5JF0XnuXmLJkLlVODR73F9IxlznLKKJERDY/XOBNe+ilaKq1cw+rva4283NDEm
         xnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scbEHeSfgSCcxK7Ny73Kn4g0gC7DW9iSvZ1f2Vwg208=;
        fh=EZVSuOFyO3BhcOemrfPE0nijWuRXsFS5/Oc546dmw1M=;
        b=NyKrTXF1WQHrIbxHh/dpP7k4UTPq6oJJ6QNNv0PFBSQpFarAj/RjqtYL1G5fFnfuYR
         4YxfOSswqJdcvbVxKQNTzUdcA0G2+Qtgv6uC2iCOSU90DrAZ59aMBPore/9NHnJoxcUC
         ALoJb8LWI0HNh7lefaygBwMiD8SoZmV2hC9M9ylDYGNGDkoHVw0/hxfj7mZxOwm6oW+T
         d8kUeffeCczJl3IO9YlRuzk32JStv4tee+V7O3LOtcpoWub2yKnsEJJ/U6oulJtFZYmO
         JV0dmmkEIyJRi/ptRl3xjQ8egEXYvUjD9/tI8Bq8ScEQm/9uVLB1shfOl/cLYECfTCB0
         m/AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789029887; x=1789634687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=scbEHeSfgSCcxK7Ny73Kn4g0gC7DW9iSvZ1f2Vwg208=;
        b=LGfFbAZ+C4M4vmS0ouD6dDR8QuWuY8OfJWvxoyirrdZ37ynmROZ1tSFs//8SLoetpI
         plGxxh68Dq+w0UVkHDPq4Kl/kzQLDUQky/AzW3HTL4YXWkMiDMg6biLRY5D5Z+QjyPaT
         mDDx2Gm9SQU5IBoReB1KTPfgP+jkxbpAF2N3VZ7xPowWHGXbWs2feuiSOMFs81pmAsvd
         O81b6GC7xxdbOQiqz5wrsUvxyFmf4e8YyzgSTh+Q8WW7hdLkxRb4UweYKWRREp8lB02V
         ZckgyHMMpVgJy2ANgWDVYKzXRePlCiLZmaO5mCuhEID17ZTtzzsLV8zVqEazHyXwuFth
         ewgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029887; x=1789634687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scbEHeSfgSCcxK7Ny73Kn4g0gC7DW9iSvZ1f2Vwg208=;
        b=JNy3Nijdz9GH/+IA3xtmzDAMnYoZxWGGvd7C+oEK5pU3PumhdkiXDttcglBe88l3EV
         MCHLfp7uTTxQZ2BVLv3xXWolTaq9/xld83iWmGR22E7aYvjmXGzDtl+NPbwpq3wPBFKg
         sspZv3NqMSAD3wQG7NzdGD/a/FxFADPkPNTWNJnt85shSgcD28E4gDomxGqo8zs/BU1G
         eg5U1/KPHSVBKveTbkLzqUk066TgaeSsIU5SJ7U1fxeHU019LCGtynq4C7Xv3VVf/EPZ
         OwWPlnjss20x1yfKeUtcXkL3F6XP6+IER9FF+2Jj4SSMBKuCJ+Q5nWA+MiMYD9N2u6BV
         kZVw==
X-Forwarded-Encrypted: i=1; AKwUvBywo81BOs8L859S6nbh+4BhRfnlORlS+NlOctnRUv9tU4JotQ+Ubc4DsmCVGV5JJO3e0PTfdn0=@vger.kernel.org
X-Gm-Message-State: AFuF++kmjDF6QrJBcCWlqoxu5+zxcDbd/q0ZIm7B024gG9yBj+75WRB/
	mEQQ+Me6edI5Cfkicfcy8pjmCXQP7D9bOQIL9bi9nCIRGnzAUgt7TipXYKZfTvGckXjcERLZAdR
	JLB8/qI7nN6l4dnGlUU53GFJEquqYFQJU67MgwS+Zaw==
X-Gm-Gg: AYBFou1c4bboqgEPQhFENQ7+S8Tfw3nfwCGduYmq4XnkxFpyUoRBC/xGnZVwWNa+UV3
	6DAFYgwqR/JysKvYiLfqATWkVOKUKPFgp1W9/AukoyGIr5ybN0Q330d/Bo60GjMxg2b9EScg8Vn
	fL0I7E/fKM4dYZ0dDG6BqNe98zdJZ4MFpMcre7NohBuH2C9JYo0yVQ1kmP8nDQBb4EpGKyXFG7m
	pCV6FCl7Z6CO6WY22JTaK1vMU7ffbcTPWB7t0sag5udqTfR3vlfsPc4D3aez6Pq4Pu/pw/dsdMx
	wEgjjgqj11zeAZd/oTkpK57sqlouAnTtZh2MEjvR8ZmKWdR07wa3DzZf+FXshWY1/Wwv8stK7RT
	7IgIoIiYT5ryAIh13JfyLanYArW4qIQm0ykTrvGBcvGtm8AiPEZN2zhXnrwtrr7sjtc+h+Ckbhd
	U=
X-Received: by 2002:a05:600c:3148:b0:49d:1e3d:3b3f with SMTP id
 5b1f17b1804b1-49d1e3d3b56mr116962455e9.8.1789029886716; Thu, 10 Sep 2026
 01:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
 <20260731163550.46991-1-mhun512@gmail.com>
In-Reply-To: <20260731163550.46991-1-mhun512@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 14:14:34 +0530
X-Gm-Features: AcwNN1V28fjgBOHn1dVY71XHW4M_hQYvtSbbXwHks3Yz0rwxCZGQBzSs1WPsOfE
Message-ID: <CAAhSdy27Ou5CJ8CaKE+QdnK_n+rq9nBJHWOu2V02DvUDQFXWcg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Synchronize hrtimer callback during teardown
To: Myeonghun Pak <mhun512@gmail.com>
Cc: atish.patra@linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:05=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> =
wrote:
>
> The non-Sstc hrtimer callback clears next_set before its final uses of
> the enclosing vCPU.  If teardown observes next_set as false while the
> callback is still running, kvm_riscv_vcpu_timer_cancel() skips
> hrtimer_cancel() and kvm_destroy_vcpus() can free the vCPU before the
> callback enters kvm_riscv_vcpu_set_interrupt().
>
> A guest can arm the timer with SBI TIME and request shutdown with SBI
> legacy shutdown or SRST.  A VMM that honors KVM_EXIT_SYSTEM_EVENT and
> destroys the VM supplies the teardown side of the race; no post-launch
> host ioctl is needed to arm or request teardown.
>
> On upstream master 62cc90241548, generic KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in do_raw_spin_lock
>   Write of size 4 at addr ff60000005e58898
>
>   kvm_riscv_vcpu_set_interrupt
>   kvm_riscv_vcpu_hrtimer_expired
>   __hrtimer_run_queues
>   hrtimer_interrupt
>
> The object was allocated by KVM_CREATE_VCPU and freed concurrently by:
>
>   kvm_destroy_vcpus
>   kvm_arch_destroy_vm
>   kvm_destroy_vm
>   __fput
>
> For deterministic validation, I added mdelay(1000) immediately after
> the existing next_set =3D false assignment.  This only widens the
> existing post-clear callback window.  A no-delay trace build naturally
> reached the callback-after-teardown-start/before-deinit ordering in 12
> of 200 runs, but 1,500 stock-kernel stress iterations did not produce a
> KASAN report, so natural reproduction is timing-sensitive.
>
> Always invoke hrtimer_cancel() for an initialized timer.  Preserve the
> existing -EINVAL result when the timer is no longer set, but only after
> synchronizing with a running callback.
>
> With this patch, hrtimer_cancel() blocked for the full widened callback
> window before vCPU destruction.  KASAN reported no error in 100
> fixed-and-widened runs or 200 fix-only timing-sweep runs.
>
> Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.6
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup

> ---
> Changes in v2:
> - Add the required Assisted-by trailer.
> - Drop security@kernel.org from the recipients.
>
>  arch/riscv/kvm/vcpu_timer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> AI disclosure: I used AI assistance during the audit and am treating the
> issue as public as required by Documentation/process/security-bugs.rst.
> The reproducer and full KASAN trace have not been posted publicly and
> are available on request.
>
> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index ae53133c7ab0..a2cd277a4059 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -61,10 +61,13 @@ kvm_riscv_vcpu_hrtimer_expired(struct hrtimer *h)
>
>  static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
>  {
> -       if (!t->init_done || !t->next_set)
> +       if (!t->init_done)
>                 return -EINVAL;
>
>         hrtimer_cancel(&t->hrt);
> +
> +       if (!t->next_set)
> +               return -EINVAL;
>         t->next_set =3D false;
>
>         return 0;
> --
> 2.47.2
