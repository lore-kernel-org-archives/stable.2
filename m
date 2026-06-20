Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E39443
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947763; cv=none; b=BgpQlIzNkNqBa/SYZkI4HTo0zDmGybFsBSzi9uwUoguCEzsWziwPuNfYhXhuit/mTIjgNZpoZO6zNkLKpFf3kmrMNhhJ/+p8LOCYuxL7UJT8eFaZ6vrJNQYxq7BilTRfpjIMUJkYi0EWTURw19Y8i7o4fwK4pwoOWMti/cUIhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947763; c=relaxed/simple;
	bh=5APvOQGjBXdDnIo4nhOU+JqLJI07zTuCW2waT0JM4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAJhvgvLzAc8VZcuWK6w9zGuRdxbNIsOlSPfvZdrqmypUo15TPMMHug3p8tKvtEO7d49XGLKlBIbXUKCWDoR0f7YYMKzBSOxLBpHPr+OYzKXhH0OfQ5EBJB74Fmhcs37sF9epiyhl+GFQs7xso1QUtUXLwXTc0aZPvd6CMzs3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCRTghDU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCRTghDU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so20715035e9.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781947760; x=1782552560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G7AUd5H2ycf67BaRCEhRwe9JqDuDQY8lDx0k8sMpCM=;
        b=ZCRTghDUuZAPU1FrQTp7UbR0QkBJAbCzeenXF1xqpORz+jtn+HLfGUBWTYM2b44Vt3
         u0+2GctwQkmdy0Gmk6Ou+6zSEg0dBi0VG6U3UfzAl4yGt2ThcP167lUtwmF/72sMrzpE
         qtb4KeGHWCVmn+EMIMM1Fs/nx5IEbBcVzFxpB9lRANy8z8iQzUJa0QpHGKbn9e/KEJL9
         lW9yvtoktEpIEcVJPzOxoVfiClrW6y0kGksLjjJm+MksdDT+zvCk8A1All7Wb13ObWkB
         VZ2ZFkIlOd6l0YWU1gLqe06Jlj0XEWr7q3uWRfRX5/ncX3Sf3fEEVRfBr/Q2BHjr49qb
         Nxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781947760; x=1782552560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3G7AUd5H2ycf67BaRCEhRwe9JqDuDQY8lDx0k8sMpCM=;
        b=SHERFQ56y99Jxe+MqOzXuhY8qRaokpR4BmmhU58q60T3bGmlemh7DYK3BwiwrceDDq
         XuyD7+TazKbfwN4TBOcxpFiIx7LcnAz+HwXaH5Ly5xWijFS6ZzzY8AD0y0E4Eo3pY21j
         +dX5RoVqnVAviX3fIwKyu8+5h9TW0JVUPxsI54kOiY8xzBm2OCXOlRCwsOlxYNqB6JHA
         hC/5Z48l2pb6F3lWMfLmzna18My3+RjhDQlk2do8PripyfRXOYwRImOPvf6efQ2ns9Vj
         rcYc0Okne4A8JELcZxkLJQ6qa/cEB1Ma//KxBAI2pFOHzkjHsYIz8cDEox9I0L4OMWWj
         7yPw==
X-Forwarded-Encrypted: i=1; AFNElJ/UtcEJQCxG6OBccOAm+pR/rthZUMGqAmFlBn4lYNd/Tq1bbWmQD3nJ1XGweoKBpRA0BanKEZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFWJWRLIOM4Yn+IE6iuJQTH/C7mAdYqNv7q/+hwg73EQEs70D
	VTAb2tC0hhCpghxjQCzUtoimDgb6k9oIEg8GJcfMMOpjK5eqbU/K71qn
X-Gm-Gg: AfdE7cmZiP+GjV9V/82ntWvpEgc7f1dKtZvRcnHSe+bGlhtjRkb+YNSlFLas7+8dLQY
	oxPa6q4U91w4GXd5SnsGfWlV7x7UkKFDSfEaX2eqZ3SsGb5R4dbIWUMjqH6SaqDLNVTUEJZ6fly
	5z5DCxDnfw6+ZUwp4QBN+HnXtm86l8O7upgp960LK+hddRGpvsWyOHjVbRYcV84eSd6Cf6aLlvD
	YRzEmwgvhh1dXqZnns66TojbmnPPINcESrzdtlniH/uk94SfWS8HJ/BOnDi5JoMM7bbd72ffdww
	RNAxThw/8v394FihvlY1d/GfR7rJWVH+g5rB1qgrThi2jMRpx8Xu2xrX5VK8Qci9tdqa3IqOZF7
	+nMm9sy48z5XFLTpEHKGrFQUvgpcbvsCcTOoJBq69/mAMmT4yRWRGsJ3GlfXxFWTOoUrBDFOzkQ
	1AUrpg6PQbcs9VqhKQE+cVMp4PClOhbyS12xjVSn23YjDr4Du2OqnEZVkGgONv
X-Received: by 2002:a05:600c:45d5:b0:490:bb3e:30c2 with SMTP id 5b1f17b1804b1-4923f56c0bbmr114244515e9.18.1781947759946;
        Sat, 20 Jun 2026 02:29:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667881bfsm6721948f8f.22.2026.06.20.02.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 02:29:19 -0700 (PDT)
Date: Sat, 20 Jun 2026 10:29:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org, Samuel
 Ortiz <sameo@linux.intel.com>, Christophe Ricard
 <christophe.ricard@gmail.com>, linux-kernel@vger.kernel.org, Jianhao Xu
 <jianhao.xu@seu.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: st-nci: use unaligned accessors for frame
 length
Message-ID: <20260620102918.7f3e0eb9@pumpkin>
In-Reply-To: <20260620090536.1701282-1-runyu.xiao@seu.edu.cn>
References: <20260620090536.1701282-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 17:05:36 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> The ST NCI I2C and SPI transports parse a frame length from bytes
> received from the controller. Both paths first read the frame header into
> a local u8 buffer and then cast buf + 2 to __be16 * before converting it
> from big endian.

Then align the local buffer.

	David

> 
> These are transport byte buffers, not __be16 objects. Use
> get_unaligned_be16() for the NCI frame length field in both the I2C and
> SPI transports.
> 
> This issue was detected by our static analysis tool and confirmed by
> manual audit. A focused UBSAN alignment validation kept the original
> access shape, be16_to_cpu(*(__be16 *)(buf + 2)), and ran it on an NCI
> frame byte buffer with buf + 2 at an odd address. UBSAN reported a
> misaligned-access load of type '__be16', and the trace contained
> st_nci_i2c_read().
> 
> The driver has the same source-level issue: the transport helpers fill
> u8 buffers, and the length checks only prove that the bytes are present.
> They do not establish a __be16 object at buf + 2 or a 2-byte alignment
> guarantee before the typed load.
> 
> Fixes: ed06aeefdac3 ("nfc: st-nci: Rename st21nfcb to st-nci")
> Fixes: 2bc4d4f8c8f3 ("nfc: st-nci: Add spi phy support for st21nfcb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/nfc/st-nci/i2c.c | 3 ++-
>  drivers/nfc/st-nci/spi.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
> index 9ae839a6f5cc..29fdb4ae56e0 100644
> --- a/drivers/nfc/st-nci/i2c.c
> +++ b/drivers/nfc/st-nci/i2c.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/nfc.h>
>  #include <linux/of.h>
> +#include <linux/unaligned.h>
>  
>  #include "st-nci.h"
>  
> @@ -120,7 +121,7 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
>  	if (r != ST_NCI_I2C_MIN_SIZE)
>  		return -EREMOTEIO;
>  
> -	len = be16_to_cpu(*(__be16 *) (buf + 2));
> +	len = get_unaligned_be16(buf + 2);
>  	if (len > ST_NCI_I2C_MAX_SIZE) {
>  		nfc_err(&client->dev, "invalid frame len\n");
>  		return -EBADMSG;
> diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
> index 169eacc0a32a..1326c20e43fc 100644
> --- a/drivers/nfc/st-nci/spi.c
> +++ b/drivers/nfc/st-nci/spi.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/nfc.h>
>  #include <linux/of.h>
> +#include <linux/unaligned.h>
>  #include <net/nfc/nci.h>
>  
>  #include "st-nci.h"
> @@ -130,7 +131,7 @@ static int st_nci_spi_read(struct st_nci_spi_phy *phy,
>  	if (r < 0)
>  		return -EREMOTEIO;
>  
> -	len = be16_to_cpu(*(__be16 *) (buf + 2));
> +	len = get_unaligned_be16(buf + 2);
>  	if (len > ST_NCI_SPI_MAX_SIZE) {
>  		nfc_err(&dev->dev, "invalid frame len\n");
>  		phy->ndlc->hard_fault = 1;

