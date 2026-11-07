Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073083;
	b=SH23jVSHkJ5AfSDMqqehbXgc7XhZSqHtqRUG06Rna2pYdA1V7Gf2LbnuUmSsFN+Emcgj
	 KJgeP7KZRar8OR8IS67FJfy03VMZ7gdSBY4LqERTSNwI5ehk2S1sCB39klozjdRVOaQag
	 7zALghT6iGzYuxHi+UieOoElrVAljrkF45YfZFLH7wHAnN3JzjXvepkxrNo+awhfg3Q3T
	 6UyhkMq3O+iANvavrCoKKqroNRD7u9zDlMZGIW03uQV0eqVyBmj+Z3tmkTTdugZu2Ks8Z
	 X51qLLGM6dJOg6HNBRV1resFptcXdJFIZ/O+kIeXOeiDlaS59GPqVEZnU4Rz6qRFPxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073083;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Z24fIgrg332IE6A60r7YoNBcp+hbvJa6DyUXEc2zlxA=;
	b=KvzqiE2QbnGAjRQXWC7PHgZHzh3F1BA1hL/LN+Od4OJEUn1wvwLHWZvYIcsejD+i9L9V
	 KNMo66iaEqHTS1q0ouf8r6uQkdxdsnznHzSL66+qbjLnXQpYGjGiHjCObG4P+jomAVdU5
	 7ffBx/+vR3tV3Big602Hfc4zPI4JmFvrdxoX2ZGqfYUKtrnUL8dXJwpzWw508h3RAWuBy
	 l1aJxMXx7ShZscOnMoj2JS00/nSwduTy/hFjVUnO8bc7O4HeE0ZT2XFd3cYHdnr502ZvM
	 b7r9NA5zDxm2cD8331/VuWdclgw5/MGAnwCK6W5MaE1eJxuLlW99t9Vhq3HZl5YGxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5ztWKaV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UToDImFb;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 17:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E0E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5ztWKaV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UToDImFb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794073081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z24fIgrg332IE6A60r7YoNBcp+hbvJa6DyUXEc2zlxA=;
	b=H5ztWKaV7PH/3Ved7RuKZSru+bN6CAalPIaoK9/gW+tAimk3TDf2lLH1AHK05UJVovSvwy
	kfw/4zucOQw/YE7873fOkagR3Q8dhP0T7x45klS12ReDjZuouCHVpyAGxCHV8xdNu9YoNN
	yXTgpul8DerW4mKN0MN+RYZlcm6OPiQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-7Y9So77jO5uCHe1qSV9s7w-1; Sat, 07 Nov 2026 12:38:00 -0500
X-MC-Unique: 7Y9So77jO5uCHe1qSV9s7w-1
X-Mimecast-MFC-AGG-ID: 7Y9So77jO5uCHe1qSV9s7w_1794073080
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0d978e4faso24148817b3.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794073080; x=1794677880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z24fIgrg332IE6A60r7YoNBcp+hbvJa6DyUXEc2zlxA=;
        b=UToDImFbgIathTRFcm0KCUed+Rq+pCXk9AjiiRXnexCf10ZTT/1t33J3uGJtXxw3oo
         L2vBOwAUTi87dlYvU7h68uQrvBfEgpf708DjZkBr2gvk5zIZ0keeqITRbi86k0zyc/mT
         mzcIoBIUfUgkgWfQKM+zkRkHSZMRmalmeWRnydT7DwzfKeQ7e+KYX8G9mnzcXmIG3wFe
         Nqn8rMKoWkNxXJ3O9y2MQMNsPKI4Hqz4iMbF/3jl5LiiliNbZBXgbDQ/Duq9UgOIQzzl
         85pD+pmL7M8/NQio698gkwH2SVGby2o0OaDfot4/PflOP0uxquxVvy1e8tYTpmSess6p
         hxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794073080; x=1794677880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z24fIgrg332IE6A60r7YoNBcp+hbvJa6DyUXEc2zlxA=;
        b=jKIYhVWzHfMMdQR1VEvqJX/SlVX3F7PVvspJWTmCWc6o0KLS3TYPL/XSzfW8Olrdwm
         zS6V64hPRXUR9UkD9I8HSKpUUczdLtTDfv1wcYt/cnqhx41bbrkc6+u52xtnEDIUMq2n
         Rj4EEs0vPcvYbLqgWkeaHl1yjguV+qyDrHfOVOc/2KFB3AmdyuAoG2LmMkyhpWvk/LZ4
         Eh+qvtIL16LpeLSCUITrGMTrdpjk6S3JOUYF2i15LquGDZV8AdVc7WDHP1nK9Z7M9ItO
         AdScBiIW8cSBGzjwIP8YoUfbIfKPMxqvBnV5Q2GIgde/sTm/xz54EIaj1b/D0d9iHU9g
         mpPQ==
X-Forwarded-Encrypted: i=1; AL+hErG738oodg9pEIn2cHZn1PlNEs4qinssLUs9NNkeUaKmXM7B+L09yazPVKYGYSGRmicC2h6reAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bCYs2YqnHwHzZOJBpDvyltKRRhlsfM0tF5+FenxObG4KCTwoF
	nHENsxjZrBcK4JYiHPPAH2L9WxUTUbQL0ffnGHwNOZP2Au/4n9jdpDGlXzQRC3/I9CB7kq+3hSL
	yLqCZD3r0jvwSTIUFhy9eWT7hjrayBYqSRINKaznkoSpJHqucaE3OzviqWw==
X-Gm-Gg: AYBFou3+lAy2WM097WYSXb/GLLQ3NKLFyY0EAu3YOBKbiN12WA7VXtPoMSzMxwJ8qLO
	DWDy5ahgKQNpjairruPOG2qfnHvL/8WQ5Ea3/gYjc8ME6nGbBsrftXul/GpDFdgVI7kZZb42E6t
	ntrZ55rLznqgyo9dGUYus9AUPcedNHZWLcavYPkhlKSqUympBRPGukjT8tZzBpMJdGQrMgM3OaD
	uJ7WhD5UezcgPmJDDqorM+/ioyfQ9zzLpy3OHa6us1O6JfLh0xuPKTABeYSzJUT6EY7PmN11kGl
	HanxHB//z3RaE2dFn0jVeG9ank6iCt+AN230tGOaonCgjoiGSAkea/bBWjMSldlHGG2W15TUPM/
	+7q5FSBUkHkjt60/H2df20NSh
X-Received: by 2002:a05:690c:dc3:b0:8b0:ecb2:883a with SMTP id 00721157ae682-8b341b65934mr35021297b3.62.1794073080174;
        Sat, 07 Nov 2026 09:38:00 -0800 (PST)
X-Received: by 2002:a05:690c:dc3:b0:8b0:ecb2:883a with SMTP id 00721157ae682-8b341b65934mr35020987b3.62.1794073079453;
        Sat, 07 Nov 2026 09:37:59 -0800 (PST)
Received: from rhdev ([2600:1700:f361:20bf::14c1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f525fsm44439167b3.5.2026.11.07.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:37:58 -0800 (PST)
Date: Sat, 7 Nov 2026 12:37:56 -0500
From: Jennifer Berringer <jberring@redhat.com>
To: gaohan@iscas.ac.cn
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Simona Vetter <simona.vetter@ffwll.ch>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>,
	stable@vger.kernel.org, Xincheng Ji <jixincheng@ultrarisc.com>,
	Jia Wang <wangjia@ultrarisc.com>
Subject: Re: [PATCH] firmware/sysfb: Avoid simple-framebuffer behind DT PCI
 host bridges
Message-ID: <20261107173756.1d273aa5@redhat.com>
References: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>
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
In-Reply-To: <20261107-sysfb-dt-pci-efifb-v1-1-86d6c598671a@iscas.ac.cn>

Hi,

On Sat, Nov 07, 2026 at 04:46:40PM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
> 
> With SYSFB_SIMPLEFB, sysfb registers a simple-framebuffer device that
> claims the framebuffer memory when it is added. On DT systems, the PCI
> host bridge may probe later and then fails to claim its memory window.
> On QEMU RISC-V virt with EDK2, a bochs-display and pci-host-generic
> built as a module:
> 
>   [    0.703813] pci-host-generic 30000000.pci: resource collision: [mem 0x40000000-0x7fffffff] conflicts with BOOTFB [mem 0x40000000-0x403e7fff]
> 
> In that case, register an efi-framebuffer device instead. It claims no
> memory before it probes, and commit 64c8a0cd0a53 ("efi/arm: Defer probe
> of PCIe backed efifb on DT systems") makes it wait for the host bridge.
> 
> Tested on a HiFive Unmatched with EDK2 and a PCIe graphics card, and on
> QEMU.
> 
> Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---

This issue also affects UltraRISC DP1000 boards such as Milk-V Titan.
For that system, a2d4a2d2479b ("clk: ultrarisc: Register DP1000 clock
provider earlier") was recently added to clk-next and can serve as a
workaround to make its pci driver be able to initialize before sysfb,
but only if both the clock and pci drivers are built in rather than
built as modules.

I confirmed that your patch resolves the issue on Milk-V Titan even when
building with CONFIG_PCIE_ULTRARISC=m, making a PCIe graphics card able
to initialize and function without issue. CC'd the ultrarisc developers.

Tested-by: Jennifer Berringer <jberring@redhat.com> # Milk-V Titan

> In QEMU, efifb takes over with SYSFB_SIMPLEFB and efidrm without it.
> With pci-host-generic built in, simpledrm is still used.
> ---
>  drivers/firmware/efi/sysfb_efi.c | 16 ++++++++++++++++
>  drivers/firmware/sysfb.c         |  8 +++++++-
>  include/linux/sysfb.h            |  6 ++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 2338de73c62c..5c2cb87178ff 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -421,6 +421,22 @@ __init void sysfb_apply_efi_quirks(struct screen_info *si)
>  		dmi_check_system(efifb_dmi_swap_width_height);
>  }
>  
> +/* Returns true if the EFI framebuffer is in a DT PCI host bridge window */
> +__init bool sysfb_efifb_behind_dt_pci(const struct screen_info *si)
> +{
> +	struct device_node *np;
> +
> +	if (si->orig_video_isVGA != VIDEO_TYPE_EFI || !IS_ENABLED(CONFIG_PCI))
> +		return false;
> +
> +	np = find_pci_overlap_node();
> +	if (!np)
> +		return false;
> +
> +	of_node_put(np);
> +	return true;
> +}
> +
>  __init void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd)
>  {
>  	if (si->orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 8833582c1883..8853a74560b9 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -164,8 +164,14 @@ static __init int sysfb_init(void)
>  		goto unlock_mutex;
>  	}
>  
> -	/* try to create a simple-framebuffer device */
> +	/*
> +	 * Try to create a simple-framebuffer device. It claims the memory
> +	 * when it is added, so a DT PCI host bridge that probes later would
> +	 * fail. Use an efi-framebuffer device there; it waits for the bridge.
> +	 */
>  	compatible = sysfb_parse_mode(si, &mode);
> +	if (compatible && !parent && sysfb_efifb_behind_dt_pci(si))
> +		compatible = false;
>  	if (compatible) {
>  		pd = sysfb_create_simplefb(si, &mode, parent);
>  		if (!IS_ERR(pd))
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index ed23d6516223..b136fdebc746 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -95,6 +95,7 @@ static inline bool sysfb_handles_screen_info(void)
>  
>  extern struct efifb_dmi_info efifb_dmi_list[];
>  void sysfb_apply_efi_quirks(struct screen_info *si);
> +bool sysfb_efifb_behind_dt_pci(const struct screen_info *si);
>  void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd);
>  
>  #else /* CONFIG_EFI */
> @@ -103,6 +104,11 @@ static inline void sysfb_apply_efi_quirks(struct screen_info *si)
>  {
>  }
>  
> +static inline bool sysfb_efifb_behind_dt_pci(const struct screen_info *si)
> +{
> +	return false;
> +}
> +
>  static inline void sysfb_set_efifb_fwnode(const struct screen_info *si,
>  					  struct platform_device *pd)
>  {
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261107-sysfb-dt-pci-efifb-d73b08ded4b2
> 
> Best regards,
> --  
> Han Gao <gaohan@iscas.ac.cn>
> 

