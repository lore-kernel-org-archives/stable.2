Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E458E2D6
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172849; cv=none; b=XwHwkv1nRzJqQ5PXD6uizzUGWmMjKiLgzVASBfiPSS2A84Oxeo7t9UdpPzCsFVH0Kk3bt/3QLTTJr2bZodgKnHIZymTYfdExpXvDGyCrGNGbeUzX6FQEoRo3jGwMKL22gLiNs/iACpXF/0PFFJUXmIYSStdFbGSpNVfLMCTMiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172849; c=relaxed/simple;
	bh=97wBu5DSvx9rNKNsfmvL4+FAQtdXKRZQZU6dewKD/Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEb0DdGv+C6zxmZLnfQTsz7BAlJgkKELqiEvor/V7Uwg5SEuf+QMk6oqnfEu3+YSXlnnW8bVCvfgKKZKQMk781DWHzjbclE+FBWUqE+4z/FLpBmhhUFpLbqEYmx2mnwmIqqpqM0JbNNFboe0RCP/zZhQ7RX/13CInEMnm9Xwd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhbOPgMx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhbOPgMx"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso125431a12.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792172846; x=1792777646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKoJikkf8KNTjGtZcVhqWM6F5oLRE7WWybC2K+96Qrw=;
        b=hhbOPgMxhZS7VrDRLmJFo+kPRJ4yM3NsdRIwzQ4YYdbfwNj2mHr/UUPsO1bo3E1zYc
         KMLg/gCoUIhShTF1jf3V5z+JtD2QheHOba/OwrgnGbe7DScGAm/mkfTyAZLIfi52kz4D
         Wwjht22FzWymYmMNnnTYdfG1ylLntJ1HeZC3soH1Kql7+u46sr8O+1zQTm1bnkx/Plqz
         bEqNGRwy8bnCir1V6EkZKAFc0Ex6NaRvOBu/5mjTdT7Ssm/frNLbyJMNEG49xS7uv77X
         HPB4qHIKrXTI6SA2BfQnnv64Gdzwnq99kJOFnUWTK7RwQpKP78wxTEm2UBCQc9P7GSMG
         532A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792172846; x=1792777646;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sKoJikkf8KNTjGtZcVhqWM6F5oLRE7WWybC2K+96Qrw=;
        b=07bwQ0sKYN3WDsO2No4tbndIUoslKBje9pYh4dh0NUDz6vzJUX2OfhmMC/O9uf9KD9
         WYDIHty3oVeek+QyRFLOp3RzNeddKkXnpQkjgtuTdTEfUHdPHoWQll0FmB9WRS2Ppf8f
         BuHIUntkHnHmrYYZHv7tdgWLCjaemdyTABgtTmyEZaQlBZMcHWZw2VrRfdnrJMRGLFLM
         a7j+tB8kN4AIz2uWOT8IHJPimkdHXUqN5tPqc1OhM8khOPHFXV65/X7DmnauZpBBA2/z
         RFVjGclekBjd73ANWfk/iWVYKXSLKlZkFeAt58KVSRWb1j3kXBAhk/ucQ97Bwm9DASZj
         gGmw==
X-Forwarded-Encrypted: i=1; AKwUvByJ209TxyO6j5Y3qS5MKUpb5/H1qycMiRoGcZI0wTflOPjKoPk2Tu7Q5C+DeDVZ19Oeip0Lu84=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0Kl5EXpJBVJ4vmRoQx/PJVQYnZyOyCq/on1RzYW7njyACcdE6
	D0PVb4gdwOVpvqyfu/fZbB4wZ5cCY5491lbw4ZvmWng7CiRXN252ny4+
X-Gm-Gg: AYBFou1wFA3cBluFPmyLTspZYmVbT6Ve0tJE07E/CHH+nh8fQlAl+8wY8YZGtEFIFQb
	7KIq0olUS/4xl+Pet9BCLPrd4mLgkAO2c8p7aj1DMb1RIMUOtNrIheqz6GMDQcQcoUSzgqrCCFX
	IssxK0VSYhYglxrEwGse9eOHHJpZdbT4Moo18L5KL2Zr5tDGMNTWE4e7tVd/h7hp1pwlAtDU51n
	VTl3HUd7wvqlOtmznGIpEwT5cYuiAhRXu9mhZ4waf73iRoTF5zO+ltuxKEexKtB9dz93a0CZQVd
	Cx5Zt129WoiepGxIbP1N+cxt00YHLKvjAZMoIcliM4YhogHciKb6ZvEqHi1ywTor1kPYHXS9Mdq
	7BGqxGuDG3S1i+eABOUF8hzsG5MN77vFfvnJ12ToO90kylo33j+OPpWSQFdpxLuAkc3GZi5vWj2
	egw+ePVsY3NvC6uTfyWvXALrMYyfpb4eqOrGLymCVlP4H//I22D/OBKEP7Jh/MMTUD4MouOy2/r
	jHTR6HhyDhp5ckeSaptDFoRF/7DKDDvQM/ES9kIxXpxjPtijg==
X-Received: by 2002:a17:90b:39a4:b0:3a7:a463:54c2 with SMTP id 98e67ed59e1d1-3acef1458ffmr468430a91.35.1792172846326;
        Fri, 16 Oct 2026 10:47:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549c5621sm1555161a12.17.2026.10.16.10.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 10:47:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e0d4d61b-6cc9-4395-91a4-d8c10c9aa1ab@roeck-us.net>
Date: Fri, 16 Oct 2026 10:47:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: xhci-pci: Add AMD 600 series to xhci-pci-prom21
To: Mirko Jechow <mirko.jechow@gmx.de>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Horvath <linux@stevetech.au>,
 stable@vger.kernel.org, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Jihong Min <hurryman2212@gmail.com>
References: <20261004002731.49927-1-mirko.jechow@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261004002731.49927-1-mirko.jechow@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/26 17:27, Mirko Jechow wrote:
> From: Stephen Horvath <linux@stevetech.au>
> 
> It seems the xhci-pci-prom21 module only has IDs for the 800 series
> chipsets. However, the 600 series chipsets also have Promontory 21
> chips, so we should add their IDs to the list as well.
> 
> I have tested this on my X670 board featuring DID `0x43f7`.
> 
> `1022:43f7` also appears on the PCI ID database
> (https://pci-ids.ucw.cz/read/PC/1022/43f7).
> Device IDs `0x43f9` (B665) & `0x43fa` (A620) were suggested by Shyam.
> 
> Also list the new IDs in Documentation/hwmon/prom21-xhci.rst.
> 
> Cc: stable@vger.kernel.org # 7.2.x
> Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Cc: Jihong Min <hurryman2212@gmail.com>
> Signed-off-by: Stephen Horvath <linux@stevetech.au>
> Tested-by: Mirko Jechow <mirko.jechow@gmx.de>
> [mirko.jechow@gmx.de: add new IDs to prom21-xhci.rst]
> Signed-off-by: Mirko Jechow <mirko.jechow@gmx.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v3:
> - List the new IDs on the PCI IDs line of Documentation/hwmon/prom21-xhci.rst
>    (requested by Jihong Min)
> - Picked up from Stephen; v2 had no follow-up since 2026-08-23
> - Link to v2: https://patch.msgid.link/20260820-xhci-pci-prom21-v2-1-638e5958fbbf@stevetech.au
> ---
>   Documentation/hwmon/prom21-xhci.rst | 2 +-
>   drivers/usb/host/xhci-pci-prom21.c  | 3 +++
>   drivers/usb/host/xhci-pci.c         | 3 +++
>   drivers/usb/host/xhci-pci.h         | 3 +++
>   4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/prom21-xhci.rst
> index 7984fb187bd8a..6c0b6e7368921 100644
> --- a/Documentation/hwmon/prom21-xhci.rst
> +++ b/Documentation/hwmon/prom21-xhci.rst
> @@ -9,7 +9,7 @@ Supported chips:
>   
>       Prefix: 'prom21_xhci'
>   
> -    PCI IDs: 1022:43fc, 1022:43fd
> +    PCI IDs: 1022:43f7, 1022:43f9, 1022:43fa, 1022:43fc, 1022:43fd
>   
>   Author:
>   
> diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-pci-prom21.c
> index 6486f4a093455..5f088a47d79f3 100644
> --- a/drivers/usb/host/xhci-pci-prom21.c
> +++ b/drivers/usb/host/xhci-pci-prom21.c
> @@ -111,6 +111,9 @@ static void prom21_xhci_remove(struct pci_dev *dev)
>   }
>   
>   static const struct pci_device_id pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
>   	{ /* end: all zeroes */ }
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index a8889081ae824..b407676808fca 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -701,6 +701,9 @@ static const struct pci_device_id pci_ids_renesas[] = {
>   
>   /* handled by xhci-pci-prom21 if enabled */
>   static const struct pci_device_id pci_ids_prom21[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
>   	{ /* end: all zeroes */ }
> diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
> index 11f435f94322a..533efc7db8012 100644
> --- a/drivers/usb/host/xhci-pci.h
> +++ b/drivers/usb/host/xhci-pci.h
> @@ -4,6 +4,9 @@
>   #ifndef XHCI_PCI_H
>   #define XHCI_PCI_H
>   
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7	0x43f7
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9	0x43f9
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA	0x43fa
>   #define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC	0x43fc
>   #define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD	0x43fd
>   
> 
> base-commit: 639df5d23876a548b86fe6526bed8b97edf64d96

