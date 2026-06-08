Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8933F5AE
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935158; cv=none; b=GMD9IRSDNBk6I9XtAk1KNvLB3gaTM+znIGjSzVYTGBHvN3z1thACteeWMGLwVikxS3RtC2ATqavEIcTbMywwCDHtrJHSOIOGKkHxXU2fz+XDnsgQL1PtdILPzjYiWAoOlXgIHiDsccposn5ZHJb32oFEzX3Wbzre6oChQ3pCYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935158; c=relaxed/simple;
	bh=QK2d+EFkM2Jtcy3rK4m4tmFaP/iY5rpk9MkUsFv20kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPFReDzTUf+hPYx8041HA9YZ/i4wPDoK2mQH1xmmt20Q7Eb11iNRoO6EjDOCctEjl8ienqgHplMSUrqcDK0cpcYV/xdZ007wiJG4zKZIgNX5VRsmUbkqLwdhVNoVkkeflSsBBFFE9RBrXwxCaAiUlOqZABnSewKE2hz/80IDRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4UxEjMc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lbviphp0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4UxEjMc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lbviphp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780935156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Vd3ZUm0dCzJ/8uu5rCwpPdtB8pbC5Kh3pUk3hRwNB0=;
	b=V4UxEjMc97H+RXp87pmpFqk8qKkp+P9+0rM1A7LulrmKTiHUJ2UenjSVfaO+wRY0nKzhs6
	H+kv8yPTL7JNl4OJzXW4kFeyJYbQzRdE3odn921bLAv3Cc+jodw3UO2oy4x1B9YgiJb0cI
	SaqiWzBVsFBKoFmi6NALunSYpZnikME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-2Zxtd5AaNi-s3THc4-ughA-1; Mon, 08 Jun 2026 12:12:33 -0400
X-MC-Unique: 2Zxtd5AaNi-s3THc4-ughA-1
X-Mimecast-MFC-AGG-ID: 2Zxtd5AaNi-s3THc4-ughA_1780935152
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef9f0af71so3412598f8f.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780935152; x=1781539952; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vd3ZUm0dCzJ/8uu5rCwpPdtB8pbC5Kh3pUk3hRwNB0=;
        b=lbviphp0DoQPv1e9fNAnYoWbVCHmRe7sDFD+y+Ebf8iRu6jMg+aen/qafuxZItmm+N
         qqhPU8cb/G21NUM8e1Itzz3sQ0H3qwS2C61GiwQmAApXZx8UdJ1AS9tPpvYTTmygRXVo
         B0AOmRu3hYzgY48UJxzOwU0bqfUbixbV5ETE4T/mkiLFJVyPz9x3JNeCszzznqrk0PtS
         8B8NAFbaoMlzcnEmnT+F/22XJXRtE5DIjC3quijKCKJy2Xh752kQWK6036oJ46Irn+uX
         SuBUxioFI5nufxHHDFJSYDG3sgRTLANXyfLvtWLqv+YhrL89g7H1luCAQCzLh2Aj9zsZ
         97hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935152; x=1781539952;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Vd3ZUm0dCzJ/8uu5rCwpPdtB8pbC5Kh3pUk3hRwNB0=;
        b=mT6kys1uZeTWo9tPs9whU5pgI6ViqdOgxwwV2d29XtpNmbYj7mN8K7Op/op/BAh5VX
         BVo7f8qlTFr7hXq/ZZ5nxfvZc71CG6lrtFCVwNyIby7XuJ/uZkPfgd7PM1ZXxtaSOzUZ
         hEFX+cIieRu7Zi8Qn+Od2dLkjY3BuUMy6yB6surISaC8Pdtb9GDurV5KlhuyWazR5/jY
         Y2ivxoGPSXPGaP8vqXQrI+dRCgUcZDzTrm2AIwxN53x04hgPLjtIdEwJbg1Knc269Jty
         +kB84x7E1LcIVyFrzCZqWqbdM1/97ZOG3lVMVFLPdtlm1CkUX1PMG+QqZtNd2nUcmCLq
         D2/A==
X-Forwarded-Encrypted: i=1; AFNElJ9ZJo5WPRmqdrzXWgFrhqr73wD0+vNRXMw7joMVkpxMRgCAjlfS3t8hRyQB9XumSsLSnJaQaGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/H1ZMXlot+yJsUGM1V1kYxNgOuz/ALP3uMGR6rPw/6GpxjiM
	/ZRCw5khzRGJUIl58+0Utkm03YmAtuUvAV6hOq3tukoXGMwieuGHqRBrddyaGxc+WRaLyA5tos5
	PNLI4ZbzNAHqQBRWGmdDkTy5sNonggMUkcD1X7UtUlEu0toFTPgEz7lW0xQ==
X-Gm-Gg: Acq92OGvkvoKjiHJPFAmFiH34ENABxwNzS+B95TNHmESJR7mt2I2Yi0m9PJSZo9lvYX
	3nywcasA1yoIp7J4XXaEkFX20imaNHHuWMhN4/Ul+G2FcDSNK6cVSkpn98QZbEEtssnNFI3+rzQ
	8GXg0VtAgTucR1oEJPeeZNh65NlPLG0/QlEp+VSiueK31Ye1S6PdwyC43LWM07IF6Ct4in+Jjdr
	MkQAAupyS+LxfaU2wugw8xaFkOX88jKKaneBKhx/Y3K+HSUfFtBMQQXB7CVW/iPxSRHmszNph8P
	uANYoOWXJ1xesc769FQlKN4bLalj8PvIT9BvyXXPJ3fku58QdsBP69dTUH/ST7r0oDyipI2/txL
	3UiI9Em3M3Ypojh9hqz3Apo85
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id ffacd0b85a97d-46032b611d3mr24384796f8f.3.1780935152110;
        Mon, 08 Jun 2026 09:12:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id ffacd0b85a97d-46032b611d3mr24384745f8f.3.1780935151643;
        Mon, 08 Jun 2026 09:12:31 -0700 (PDT)
Received: from fedora ([91.219.240.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm54249702f8f.3.2026.06.08.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:12:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Hyunwoo Kim <imv4bel@gmail.com>, seanjc@google.com, pbonzini@redhat.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] KVM: x86: hyper-v: Bound the bank index in
 hv_is_vp_in_sparse_set()
In-Reply-To: <aiQyZIJtO-2Aj_xN@v4bel>
References: <aiQyZIJtO-2Aj_xN@v4bel>
Date: Mon, 08 Jun 2026 18:12:30 +0200
Message-ID: <87o6hlhuz5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hyunwoo Kim <imv4bel@gmail.com> writes:

> hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
> HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
> valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
> set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
> must be less than HV_MAX_SPARSE_VCPU_BANKS.
>
> The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
> which is below KVM_MAX_VCPUS and therefore always within that bound.
> The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
> hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
> without any bounds check, so valid_bit_nr can reach
> HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
> valid_bank_mask.
>
> Return false before the test_bit() when valid_bit_nr is not below
> HV_MAX_SPARSE_VCPU_BANKS, since such a VP cannot be present in the
> set.
>
> Cc: stable@vger.kernel.org
> Fixes: c58a318f6090 ("KVM: x86: hyper-v: L2 TLB flush")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4438ecac9a89..d8782cb7ba02 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1839,6 +1839,10 @@ static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_ba
>  	int valid_bit_nr = vp_id / HV_VCPUS_PER_SPARSE_BANK;
>  	unsigned long sbank;
>  
> +	/* A bank index beyond the mask can't be set, the VP isn't in the set. */
> +	if (valid_bit_nr >= HV_MAX_SPARSE_VCPU_BANKS)
> +		return false;
> +
>  	if (!test_bit(valid_bit_nr, (unsigned long *)&valid_bank_mask))
>  		return false;

I think the concern is valid, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

what I'm not sure about if we should also deliberately crash the VM
which does such a hypercall. This way it would be easier to find buggy
L1s but given that they are most likely Windows, we need to do some
tests to see if this is not actually happening today (e.g. Hyper-V usign
VP_ID or '-1' for something). Let's have this as a future TODO item.

-- 
Vitaly

