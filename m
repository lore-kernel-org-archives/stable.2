Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897783;
	b=J5UXeWrX2oL5pKNDkc26Xi9pPzI7Mrjm8Z0T/ketCdbhAezbbHxXk3GL3J+bIAwdSXf2
	 nj4PXUEau9kej26pEqmCFqzlR3UrQyfL4+QQX/bQlZua/n8hXg4xW2J+9C2bA42aGdcRD
	 EncYfgYiSzFwGBaejfcYvYPamlPqorF+2k1Aawx1wpbu325Mi2gBgVpIe9QbDa1TdeXPb
	 BbhEF/4K73lZgVXujcTxu0I6E5MuZS4vA1h6WcNFdI1sPN2Tc19563uOqVz3kk7Fn/pFU
	 jJA2K7gZfSo6FAFgCwIBntUTpJ6ZQ1JlyHnY7O5QYFClAk6hfW98nmnyEFB16Th/DmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sXd2orHtvS28hhtBKOplUBavOCjio3xkwlj67EhnJWU=;
	b=IJdGkIqQ4q86+uFFeR6F+0A/fbTsOHrR/VsEGwsk/TE7LJx31g1Z8X5DF+vPDBa6Q92F
	 LTBwLx/Mi9b6Vbz3u2tHJ5LmUGF4nwCJxeZbVayN+tysbELMHO9T0cnlhqqvZpCgWTx2P
	 sNnmUYZKk1x0yeE6cldJn7FMyVrzho0K5kn5Xn8NcbP9HbPGaw247yA0LLI/8YaeifMle
	 E3E0cqxolVIIAyBMDuKEkj46yN7LQN5XlKAOpDwaRL+7xjGzraFzcG6OUu6sifryBdlIX
	 Kod7B0RB4YATK6g6a2OvP8VaLwwjDeiNmMDsl0NYgtTtllCXWla+MBHnK1Y5yQ+AHug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ogmv7BG4;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F884606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F884606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ogmv7BG4
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso12117665ad.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793897782; x=1794502582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXd2orHtvS28hhtBKOplUBavOCjio3xkwlj67EhnJWU=;
        b=Ogmv7BG4r7uuYCYpQN4niqDJbGkvLKQFENVq0R4ZDqv8WEJDpk9oXeQLiFTF0VDwVh
         ZW3dRsM8vxcktUqR8BLPtebX//inW1Bfn+BdikoT2ufnSbeXAlawBDAqYnbaT3ve01DM
         3G8UuPv4JjwWiGSABW/YQ7BK3i6IWEMQ9LScK6uM0QnBbM5NUX9L6hePyG/VFQGhGVwp
         yrutnEdo+lMbKqhRElOL/guTxtCUcJSmflLE54qW0EGDnf7gaUt6sZCWETWxTFMS2xBC
         qsOyvOrwd2F/C+7CAIc8Ue3hnsor2FaZUI+4GfsKHJuF0Q/sB7GfEwgbcbMAkxaqgHXu
         eEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897782; x=1794502582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXd2orHtvS28hhtBKOplUBavOCjio3xkwlj67EhnJWU=;
        b=wlc3Q1+o5l26zaukOzGfg13DpT+r+eRcs1HqsqmejHPwT6rB5MYbDhXPSNv8MMPNQq
         WQKQakG1G1uuv4EeOlNirN4fhUefYNe1+5OpPu18/DU0rWx7LL4BKchAZMk3fqKZL7hq
         ZppvwHuY9v86GIEKMmXdJWqX2lL5n3EO69KxRxJ+IqIw+hZmha1Q6zr9wClp1Rdb4fgR
         SlA8wVxuQMzloSIYhpnD5JMhqU+ev+5QtGC5GpjtFe1L3B7rp/fPekANK/3d9b2d7kEz
         rBz8zsd6rhc+4bdjan1zEcONhJ4b3FHaU8wSBdtrfTROl5dXrNGOGVy8WYAovjZuTLfj
         mEeA==
X-Forwarded-Encrypted: i=1; AKwUvBw+5kt35GyjAaFRgoV1+HE0krHZWdyiUen4Tkn9RXAVDyfCBW3w6Ow/zKAeC4ZuWFoeWIB5368=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uZsJOS1VzsuEjffuKRBLzdB3OwYpFzmpR+uj36ta7TNz0mz7z
	+Y0l34OzyQ3mefPdtfEPBGrtMquVmRP2nhQV1zKKcjznvlxxGTmojK/AQkTy0uujWb1X2gJsmr2
	3ZIH1
X-Gm-Gg: AYBFou0ZihT90i5ALb5UvOjHn450F68SCwS9MgQ60KFVYhWhQvP2/6+Tl+/iWF8PIsy
	CsEcqS64kR5VCSCc37sfghLm49J5wEeVln75Mek0mm9kW3V6v1EYKNsjW5h03y5kj6R+1ih87V7
	f+Pt4vxqkFGHy1F/yDhdN2iy2/fteI10WVz3vcBL3wEG7LRT/gU5OkrMEOe/32mxW7+5TUJtLRt
	wtvjGwsocg4l9cDkys9KN3xO981a652fTcK9bPxM6e/jXwCeymTldZmJpAFLn7e8gVp8eCrE3xI
	v2LAZDeK/E6mSezZbQMCt2FhUD7Pm79fo/cm7MSKtNASh9VkzVu+ubOpe3DeOWsof/oSOaN5cC4
	uI8QjmiXnM/Qb6r4KTzKsSWsbD9dVevP34LxYeFVeKlj0q1PWJj6DxG5tJk4E2mzw40dmMzSx62
	mPHdbtziECaXdXEDFJgFwMrAtNIfhOcZ0Jmy7pTHhue6Z8RaUfrc+bG3N/nPxDGWqgIcQbWmjUV
	MjbWJ99YSy9h4XzN6wguQ5PcA/B6pAyPn9vfFaTqt7OTqP53I6OUYUo06FTp2J9exN5SUZUztbq
	fhu7PFCMd9PuOWxT6JyROineodWY2kk=
X-Received: by 2002:a17:903:2290:b0:2e8:3d48:4d8d with SMTP id d9443c01a7336-2ed40ee5387mr1933055ad.0.1793897781997;
        Thu, 05 Nov 2026 08:56:21 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:c7a9:fa1d:b267:7419])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed09127905sm20286145ad.48.2026.11.05.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:56:21 -0800 (PST)
Date: Thu, 5 Nov 2026 10:56:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: char: take ept_lock in the
 SET_INCOMING_FLOWCONTROL ioctl
Message-ID: <auy1M1b4-ymv0OyD@p14s>
References: <20261026100306.68019-1-yuz08559@gmail.com>
 <20261031090650.23701-1-yuz08559@gmail.com>
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
In-Reply-To: <20261031090650.23701-1-yuz08559@gmail.com>

On Sat, Oct 31, 2026 at 07:06:50PM +1000, Yu Zhang wrote:
> rpmsg_eptdev_ioctl() handles RPMSG_SET_INCOMING_FLOWCONTROL by calling
> rpmsg_set_flow_control(eptdev->ept, ...) without holding eptdev->ept_lock
> and without checking eptdev->ept for NULL. rpmsg_set_flow_control()
> dereferences ept->ops, so this is the only eptdev->ept user that does not
> honour the ept_lock discipline.
> 
> eptdev->ept is torn down under ept_lock: rpmsg_chrdev_eptdev_destroy()
> (reached via RPMSG_DESTROY_EPT_IOCTL on a second fd, or when the rpmsg
> device is removed) and rpmsg_eptdev_release() both do
> 
> 	mutex_lock(&eptdev->ept_lock);
> 	rpmsg_destroy_ept(eptdev->ept);
> 	eptdev->ept = NULL;
> 	mutex_unlock(&eptdev->ept_lock);
> 
> and rpmsg_destroy_ept() drops the endpoint's last reference and frees it.
> A SET_INCOMING_FLOWCONTROL ioctl running concurrently can therefore read
> eptdev->ept just as it is freed and dereference ept->ops -> use-after-free
> (or a NULL dereference once ept has been cleared).
> 
> Fixes: 5550201c0fe2 ("rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---
> v2:
>  - Drop the paragraph about the other ept_lock users from the commit
>    message (Mathieu).
>  - Bail out early when the endpoint is already gone instead of an
>    if/else around the call (Mathieu).
> v1: https://lore.kernel.org/all/20261026100306.68019-1-yuz08559@gmail.com/
> ---
>  drivers/rpmsg/rpmsg_char.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>

Applied.

Thanks,
Mathieu
 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 550fda2..d8868fa 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -343,7 +343,20 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  			break;
>  		}
>  		set = !!arg;
> -		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
> +
> +		ret = mutex_lock_interruptible(&eptdev->ept_lock);
> +		if (ret)
> +			break;
> +
> +		if (!eptdev->ept) {
> +			mutex_unlock(&eptdev->ept_lock);
> +			ret = -EPIPE;
> +			break;
> +		}
> +
> +		ret = rpmsg_set_flow_control(eptdev->ept, set,
> +					     eptdev->chinfo.dst);
> +		mutex_unlock(&eptdev->ept_lock);
>  		break;
>  	case RPMSG_DESTROY_EPT_IOCTL:
>  		/* Don't allow to destroy a default endpoint. */
> -- 
> 2.43.0
> 
