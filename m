Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67623183F
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786764154; cv=none; b=Vc6r65ag5Q7W2we5NuSxQV7CZx3yWcUtObSoUeA1TLSfy0U82Cz9d1MpmqevwNxRsr1cIvYVuceVpRPv3jBbGO40YjCW596TPkQ+EmKj9ONPjbeHhj2MY5hJ4ymUpXDV5Bh3L0hJXvpYZv8K5UX6YLRZ6A7vdl8wsJa3aaMIN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786764154; c=relaxed/simple;
	bh=gxd8EQtDJL+7J8yBONl7zGvyZm5F7eTxJ5MSfYlRQ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvmcvsbdsOftqgCYuQoWoGtkAKOcWvq+kW/gLxJpyEZlPhVxbSI3546aT9p83wF1Nf4MPWK0usP+N/xXttwS8+qBnoHDPxX9d6RG+W1j6tQiDcHUJaRJXoBCxbvvHPIQ8s7LfI1BtCWo/9smWNSgTGI52kjgO3nsC7eSO87liDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNkYat3c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNkYat3c"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1480340f8f.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786764151; x=1787368951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ye0y0tRevzSPz6VhXI7jbdhAlgjaMxZeRJ9jaKbqMD8=;
        b=aNkYat3cEDckdeW2elc3he4YO73JqPrhDGPLSc6OjaxuEJpcHf8m+ib++leDzp/W9b
         WX4d9PUBJAz6+9UsALRe2WznNepNPpqBECQp6I0/EPdGpH0pOwbhTnolX+NF7/mgKTO6
         CTqYaz/Dm/KDVtGe13/lz7QBLxMGxmv0iottE+B2i+lYDbe7TYVrjMjycLpsHcxV5p1P
         lvoOR0Xk7ltClIfZ8ahQwDwl6BSM42ZzZqqVoK1eaJg2uYcWeAQIwHT5uu64C60MNi7O
         ngSpEibZG6NFUMz3jsb+UKHU8+mMtBWhjpGhrAjs5njmpyOx9dv6qtBvilfAHTYwuylc
         Tvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786764151; x=1787368951;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ye0y0tRevzSPz6VhXI7jbdhAlgjaMxZeRJ9jaKbqMD8=;
        b=M2xkTmnw4tDmTyozVewakiBSiTzy8hLkLSCySde6R7M+B3+2AC9ERT/SEeMYQeLnrC
         SIiwQUHh/F61X8djEBR6gNMbZM7YkyiFHc+tCNiOUfdFHmPuybRzumtWAEirIm5Iw3nE
         jGQ2CXVeX4AyzWN/wUy0VkYM4/MwbMntWaeGbjjh/Bns4/4XIk1qjS8a1mDznd3LF1nT
         1kPwK+BCisJT/xMgnMBUQwakTloXd/rJAcNCn4GnJTwImvcnL4xI75zAjIh9euesTv6j
         EVn5Os3qLrBqlk57OikiuKvJYFrVuZExEPK0VJZTA+fCpKHpITJSY7RNw1AD4DcCjIFQ
         wezQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp53BtqMGCIVQSX96mUdZnDj21dLYK2ChmMU0Rx+Pil/7pGn7ihG/b17ckItio2ETR68IExEug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9XsH3tQBRMKLl4PohULTHGiM5HoDtfi5l6CziYvOLTfff39l
	t/dtkp3phr1znkDAGd2+3jmJ0YD2W74Y19HAmdaggQug0D4MIYmS/FzA
X-Gm-Gg: AR+sD10oCC3Hf4Sm7tmGC1G5F5wAQXgRTfkddZAcw7VyfRMhJvQDjFNtOLf+lcJqvwG
	V/gCnBlljlPDfZvZNet8SNEe6yc9MzUZaqRLhd2iEkO/qwKQjFUDqoJYBt2zLQ3X/E59sz0edse
	uWvlYGHHus8K+XwSXCmsZSauqJlvtidpa81DILzw0+ASnvFAqnf2/nO9Y+srxddgjf1iohmRBJs
	gF7B2Kkt2Pr1ovQ8yrdOezscVzhIlDJ6jWQo3glF8K2iUa8HdfNN0ONeQSVWhJ0oUaoPrCcWtED
	lj2lYlPYcsOzPjcut/0hpSdnWUAW2NHV82W+oiaYLUJZXGfNo8wWTH7/SyTlR9AXuw0yYtrBKop
	qADhSVv3z0f7jcIgaH0z73cCnreYuYzE+qtmqpSatd5vAJgfze8zVQrIzPpEq7JmG04ykagHMtr
	wfKIEvS00SKUhDPX4oP2vbtYzWqBzest/c2neW3fMeT97jUpIJrh7Eg02KR5AF8FHIUwzl8Swaw
	pt43Ohp3/VPQO+fYbgolXsNxmuaIMt7mCEjXw6LM2biZvghEXjsphN3ZgEKGQWMigAnpNBjvYZz
	MI2bPxtXGoED0rgT6IMMl832NKEGZXYrHdk3oVKo3N6VDQ6SOsneH9fOwcWmmXBWJA==
X-Received: by 2002:a05:6000:dc6:b0:47f:7964:9887 with SMTP id ffacd0b85a97d-481607aafc9mr10977350f8f.25.1786764151253;
        Fri, 14 Aug 2026 20:22:31 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de. [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c07d2sm13323196f8f.30.2026.08.14.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 20:22:29 -0700 (PDT)
Date: Sat, 15 Aug 2026 05:22:27 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, ljs@kernel.org, 
	Shen Yongchao <grayhat@foxmail.com>, Wei-Lin Chang <weilin.chang@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix life cycle of the nested_mmus
 array
Message-ID: <an_ZDzaiPxhrp9zs@gmail.com>
References: <20260814103230.858578-1-maz@kernel.org>
 <20260814103230.858578-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814103230.858578-2-maz@kernel.org>

On Fri, Aug 14, 2026 at 11:32:29AM +0100, Marc Zyngier wrote:
> +int kvm_init_nested(struct kvm *kvm)
>  {
> -	kvm->arch.nested_mmus = NULL;
> +	kvm->arch.nested_mmus = kvmalloc_array(KVM_MAX_VCPUS * S2_MMU_PER_VCPU,
> +					       sizeof(struct s2_mmu *),
> +					       GFP_KERNEL_ACCOUNT);

better: sizeof(struct kvm_s2_mmu *) or sizeof(*kvm->arch.nested_mmus) 

> +			return ret;
> +		}
> +		
> +		guard(write_lock)(&kvm->mmu_lock);

tabs in the empty line.

Thanks,
Karl
