Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828523;
	b=JVqez0qxCmMeqbbnS37VAdJeFKMASqr1PlIWkRkSDROe3Vmj8fnaBf0VykddUovfD7eq
	 Iddp85aVbPwbDqgi/6UIWF+esb336GxKo7TtoW0lH7fcPg8iyb0e0p3QWCZClmoqHfbH7
	 ZNK0JsMuoEXBT6iYyXIya3vNZo5fwX9yDWNGQ6obpbhxM2UO79IcGtelhU6BnlUMDnEn+
	 FGfcJR5iaSweMMT1DKVno/3OiCi6MZc3SPvhtCIDMspQ/yeJBs3RHseDavMuaUx6MqJXH
	 l5TOGwCxEtJA5uIZ9fATJ1P90TGUkgZQhbydnHCkhX0wVGb9yV71s5ygkY6BieQV3Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=g73PX0PTBDOigD/y1VmqsLoo3oXmbxRQK+YkYSvt5eM=;
	b=HclkFKnyfKtGheYpRfYnx2TlnrOwWdZi0QeRfngzMeTO/1b5qpa5VMbOha3Z5lvqrfZE
	 mVYjRj5IsOim+Arevwt+OXIawMo7wou0Yo1RdPE936ouiTFUdJBCUn0VVGRBj8yNCl2Bv
	 ojn9FjgpgGChR/JKHVsgO6v6qfiCRe6aeeGubRMnxaxsavtw0O6zF43dfc4MMU4QcD8N8
	 IiDOXD8/30Kt5AntgwaY182WKD8VblaVQcFC1u0BC1JzuhasBtiwCkrVXJUBWjRtWauu1
	 ABs4E2SWELm/4cARLs1dPvHoY1qa4nV6uAZj/cZj7ZsMyywfHPuRsvq5j4IoyaDDU3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="c9hC4F/N";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCC606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDFCC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c9hC4F/N
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4910b863b84so2399764f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794828521; x=1795433321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g73PX0PTBDOigD/y1VmqsLoo3oXmbxRQK+YkYSvt5eM=;
        b=c9hC4F/NSxunMp98Uy5o26LR1MQvaKR9NzHdHBnsHjCptC/4eMfWfcc4Vc8rw1cQL8
         m4BU2M28Y8C5vgchczx9uDMfstCjmuhu2TfJTh34rolCj4oECv7+dvIBcaOORfCkWclT
         zycX8wLPseRJeGK7tiZQoGV+Q0rh/1mP1uyRoTx0UMM6nPm1Fcdc2lRqFOz+5l6brteN
         dQwCeLiEmfSB6E1/52AsWfp6RqJYvEMNA1ltqOuTlD7JYU6MyZjniAyi5MYLfaYjVARv
         2HSswS31FUiU42Z095awEC1TaQMSK/f6zPPT/V9Ew8LP/tXWIs6LM4Xaz85FOIVOtblI
         ASpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794828521; x=1795433321;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g73PX0PTBDOigD/y1VmqsLoo3oXmbxRQK+YkYSvt5eM=;
        b=pRQ5h3ADuK0k2MifUdWz2hjzGrieOVD73wWstTSiqfwpzn3h/YUMlTBmR8ABvIdFkp
         4lpBRrOzbMiOHwWlJy9oU4KsAqVrML5Xc++JccPhiI5b/O/0E8cWoWQuB1zJ8Sh8RJuY
         VWBMiPgefiBedADxEtp6QvCcGmcr9NqqX+UdGITylAQBhdOGhlesb62ybY3xwROdmySS
         E0dSvf/3GXnYl707dCc36ci4i5jcC4V3wd8hNynmWb7gvIt+3l7c35rgiQc4mgMn9Rak
         KKbEHx9tl42mjhtajiVHkIIODDsAd6VL24mBWAuUTbq4UpERYKNiPacX33ShBR7CGoE8
         qEDg==
X-Forwarded-Encrypted: i=1; AL+hErECSTgo02L5+zRE+EKyL/sBTqCDUOeZuHElGvaccoFVbOgjk6UWabJzWYd/1+Hhqedjx+PZtQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jA3o/xKO1LkjPtdpFnd8G9RprszzVClN1jncvxC8Bvj/8hWsC
	WgXngfzma9tjar2nFYUMlrz7Idhhl63qaN1ijKx0XFqqAozlYdrOWnMG3oiSYxRPHw==
X-Gm-Gg: AYBFou3c48T6uddXgEH+IvVq+cjs4lJkDF06QoEP0R1aEcPpeL7zcMQcMQ8fnqydY86
	pePI/7UW//0VAzrqZ83GxwfiRU2DVM79kvSr/xo7XdLDbqLc8e8QoE8zqztSc5WHrtWR9WC+1i2
	5gzC2TlXRa2J4PWNpT9qJsjDdcP/Xo9Yd81mQph0nvnCLqYWMGNaWb5LHi3NG1I+yXnCo0mbDUQ
	j78PZMkIUJzlU6fopApDG4ZpwcvRqLQnTGWra84nDa8npJf39uN0fZO6F8p7TANZ8Z2O5GIIRzs
	qEDYiSQ7RJv19SSituyphKV/r8n66V/dD097+aeXpZ7OW2h04f3Ft+W6tIyOJzJIIzo/axDIOXb
	oniXErs7gAr2SFQ65A7vUX/xA/3asg6n0EoJUsFyBUvs7tK5DUhBxKDBUL91b6Y6c8Fi+tGzVqs
	dLAKTyyXfdIa2UKBtLsgLXfQy4IL3Sq0mht3MJrs0eDh8Vlr+wLvk5f5NsLM0ZJNc9irVxzLBw6
	ADvbagWfksVcvOp3RukZYJLbiEeeXvp3UPARvAAMIeifF6C/sAmbW4rxk8sSHIk129/xYcBk6+9
	hi2skFY+eHNTLNXB1QxkHBsH1S4Zt2h5DeVRa7ZLseDShmwCrl7Skzqxug81o0XcGg==
X-Received: by 2002:a05:600c:5903:b0:4bb:60b3:7ea9 with SMTP id 5b1f17b1804b1-4bb60b38023mr126053495e9.0.1794828520786;
        Mon, 16 Nov 2026 03:28:40 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm21324022f8f.38.2026.11.16.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:28:39 -0800 (PST)
Date: Mon, 16 Nov 2026 11:28:35 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drivers/virt: pkvm: Zero and clean memory before sharing
 it with the host
Message-ID: <avro44jUWOARFzul@google.com>
References: <20261116110549.1863653-1-fuad.tabba@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116110549.1863653-1-fuad.tabba@linux.dev>

On Mon, Nov 16, 2026 at 11:05:49AM +0000, Fuad Tabba wrote:
> From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
> 
> On pKVM, set_memory_decrypted() shares pages with the host in place and
> without cache maintenance. The atomic pool, dma-direct and dynamic
> SWIOTLB pools zero their memory only after sharing it, so unless the
> page allocator has zeroed it, the host can read whatever the guest last
> left in it. Zeroing first isn't enough on its own, as the zeroes may not
> have been written back to memory, and a host that maps the pages
> Non-cacheable then reads the old contents.
> 
> Zero the range and clean it to the PoC before sharing it, so that no
> caller can hand the host stale data.
> 
> Fixes: ebc59b120c588 ("drivers/virt: pkvm: Hook up mem_encrypt API using pKVM hypercalls")
> Fixes: e62decaf98e7c ("arm64/coco: Add pKVM as a CC platform")
> Link: https://lore.kernel.org/r/20261116091137.94252-3-aneesh.kumar@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> [fuad: take the pKVM hunk of v10 patch 2 as a standalone fix, add the clean to the PoC]
> Co-developed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
> 
> Notes:
>     This is the pKVM hunk of patch 2 of Aneesh's v10 [1] plus a clean to
>     the PoC, taken on its own because it fixes a bug that has exposed
>     guest memory to the host since v6.12.
>     
>     Based on Linux 7.4-rc3 (aebb727447640).
>     
>     [1] https://lore.kernel.org/r/20261116091137.94252-3-aneesh.kumar@kernel.org
> 
>  drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
> index 26fe9c3f22e36..81d1cd24a2eff 100644
> --- a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
> +++ b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
> @@ -9,10 +9,12 @@
>  
>  #include <linux/arm-smccc.h>
>  #include <linux/array_size.h>
> +#include <linux/cacheflush.h>
>  #include <linux/io.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/mm.h>
>  #include <linux/pgtable.h>
> +#include <linux/string.h>
>  
>  #include <asm/hypervisor.h>
>  
> @@ -61,6 +63,15 @@ static int pkvm_set_memory_encrypted(unsigned long addr, int numpages)
>  
>  static int pkvm_set_memory_decrypted(unsigned long addr, int numpages)
>  {
> +	size_t size = numpages * PAGE_SIZE;
> +
> +	/*
> +	 * The host can read the pages as soon as they are shared, possibly
> +	 * through a Non-cacheable mapping. No caller relies on their contents.
> +	 */
> +	memset((void *)addr, 0, size);

Are we sure we want that? The guest may want to setup memory and then share it.
I am not sure about modifying this API. 

> +	dcache_clean_poc(addr, addr + size);

I believe the hypervisor is already doing the cache maintainance when the page
is mapped back into the host. (see stage2_map_walker_try_leaf())

-- 
Vincent

> +
>  	return __set_memory_range(ARM_SMCCC_VENDOR_HYP_KVM_MEM_SHARE_FUNC_ID,
>  				  addr, numpages);
>  }
> 
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> -- 
> 2.47.3
> 
