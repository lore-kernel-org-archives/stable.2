Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382500;
	b=dVQFP9q57FwJoyG6EyJkclK8Pi3qKh5eb0TRJdFb2yTFw6zyJIaijYZq003EvXWQrVPh
	 LPlzvax0yVC9Ecxw3wBSAhJDj5FGbsFu/YZr7Ro6WEixaSzVCLJ8pbY/+xbKZs9HeIWke
	 KsRZ/rBJ+q7fZrszhnm5QhusUZamCLg8YxCmuj7+lUUX5fzwNbX7eLVCl7WiM3O7WbszP
	 YQVcEXfM4gdhS/SO3FaNS9X/S7CDQ5+4JirxzgwRju2j8GsSoyJq6gSLngr3e29MU8Exq
	 hbNV/4psDziMc41O5PPqYrJQR8UBP0h4Rg1kLOXaAoA1iV7Q09KpncUiAOLJjxg9CnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0FM1eyvAUwK+fLhgDxNFYZgoPZUDzKxnOOEbqswS2Es=;
	b=tOXTDRwJHJxM1TkBFEfkFE0d5tGbDLmt6mr/SKFxmQASyBhQj9Y4McnJlDYhcPR99BWD
	 RDivT4cPmUbU5vSqv0Sb/1hXQrvzm+jkLAKbMvGgBxEPt4rqkO/mn3A8C5FvTLuxUs5xi
	 s9yVjw58p0OjWWkKEyytbm+Zl9HI1D52hgDd/Dr0kW+2VlJcaBiweZ5LMk9ov/7Vw+kzH
	 iqJtFiK4SpeIVcLBujKQvbu85INSWAWXAc9am5OrbpPSVZfmJzG6HBUK442j6qXwL567/
	 FZNEnEyuuS8qyloZi2u99R4KDzkVLoZoflt3OUYMXJm7AzKN0a9z5HdFBY2IBxEoB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xhYnTDgb;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA8606A321
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AEA8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xhYnTDgb
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso418788a12.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793382500; x=1793987300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0FM1eyvAUwK+fLhgDxNFYZgoPZUDzKxnOOEbqswS2Es=;
        b=xhYnTDgbjHVEDgLd9FeTne28vMcHSOYTrn9emqGQjUbi7VmzKD7Bc3veKg4GaTkhxb
         VH578t4aonLwErix+BvTS4CePJD6pz1x4JpizuSozYDRPGHMY0WqL1rzG8hAX10QfxoN
         slsC8eOO9A/HGY2jOtEnWgnLRLCZwUgb2HBm0U+r8guFc8VpvPzV63mSwxXhL43SN56h
         3ui3PTG8AFMemE4L+RblJZsAzaC3w3GogKUBai0JMDElGxOzKQUSD8Kov3jjZWi4UaZy
         sYq4U0AiE/9jbJ03K47UF/vDxwyTtcxD5RNl9IwwYWTBENpeyJzrZfmu2M43YFicc9Gb
         0Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382500; x=1793987300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0FM1eyvAUwK+fLhgDxNFYZgoPZUDzKxnOOEbqswS2Es=;
        b=z02At2cg4vvpjTNrwkt1TQDdkW5fO8zILAwDqSA07sVU0xculOQIun2zJBAOoE4Hhl
         Kgz4FJMFGrjCAkBNhMiE2FfBaGm8JMacoC0qsO1+2131SPIRJSvA2xCdYDhHuerJkgo0
         a++xz+aeSoiCtCBeV2kttaf3frM3T1Jy0PeC4tyPPR5t6Y1MXpJhUVighAwccL0yPyEv
         9jACD/xlS57rC+HYKowiQztBHiND7Cj6hQ/zkn/hPaa6lmKTPJZbN2nBwJqZw2zT0PiV
         kopKiSNSHs6spY76I0NA2u1iGcK8fGJby4+NdQCWDal5wAmO+H+sijywOeHb8W7eIVCL
         0Ejw==
X-Forwarded-Encrypted: i=1; AKwUvBxdy0HWm+3t4WYvrc0U0etzgFH7Ch2VyFjNzw7JzdYRC26RDYKySnh2nq474FMNZCqSBMgpbhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE6a7C6r78oVPNK7MTCyUDHY11LWYOglzk+vXqQIbhruJAMJyj
	L9tDAAlceZftiISUKWZgSEbbtkN6BOTI4odXkgKCi7hJi/PbiMqdxBOXbC7/WHf7f/k=
X-Gm-Gg: AYBFou3eW8+9wj+Lb+1G+4lFAJA6PJVroBZDjikPYgDM9gtJfu+q6q1wsuV3+7TuF15
	T7z1XLqigm5eUnCg5idEFBEyOcmwF91lAHeyodagxe2T2xXXKuCtWGoew2UJNAn9eicOgsieacu
	Par0MuokjZpr/1Gje20+udtK1w+fT1TrlJz0XzY+eMORr8wIQgf//vTC4pjN5YZOKAwDzl8CPhF
	AEO0YFcNwif9gc46JrfXGx+7s40rq6OLCiKnvYGqs6kDJJ4iV9vdWnnzmzxcqbW5niiC8WdBDhs
	hdJ9ajkWSSmss8E45AYYObbBa76vjg6LiXmHqneREx92Ld+m5ajKTTsHpPI++wTH7EReP2PyBQT
	FYHTCDaXJeWhlJfPVhoINy8ALKyCCEdJTBfBRUFE+oE1b0aY2OelZn47WBcHX0moQCbAh6qA4C6
	4zxeghxsc55CWjYbm6I+tb3wy7s7pUM8cFPmdgtZlPhdJEugK3zYe7GQQ0jA2qKKQaL/gzonsN2
	SrDF7yS5mM31Kv2UcMt4tzodzPX3vYv0hL+Q6+e5EBf7ev2KgqYBMYlzn/hbcm/rMQp+Q7KWn0l
	rXxsVGws22zYbQwttR0AbGk+GF5wYHE=
X-Received: by 2002:a05:6a21:a247:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3e928ca2358mr2811333637.18.1793382499460;
        Fri, 30 Oct 2026 10:48:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1341:f404:be4:486c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada9ab752sm297668b3a.45.2026.10.30.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:18 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:48:16 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rpmsg: char: take ept_lock in the
 SET_INCOMING_FLOWCONTROL ioctl
Message-ID: <auTYYGFsSqPalG_y@p14s>
References: <20261026100306.68019-1-yuz08559@gmail.com>
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
In-Reply-To: <20261026100306.68019-1-yuz08559@gmail.com>

Hi,

On Mon, Oct 26, 2026 at 08:03:06PM +1000, Yu Zhang wrote:
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
> The other eptdev->ept users get this right: rpmsg_eptdev_write_iter() and
> rpmsg_eptdev_poll() take ept_lock and re-check eptdev->ept before use. Do
> the same in the ioctl. Lock only this case: RPMSG_DESTROY_EPT_IOCTL calls
> rpmsg_chrdev_eptdev_destroy(), which takes ept_lock itself, so the switch
> as a whole must not hold it.

Please get rid of the above paragraph.

> 
> Fixes: 5550201c0fe2 ("rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 550fda2..49c0784 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -343,7 +343,15 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  			break;
>  		}
>  		set = !!arg;
> -		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
> +		ret = mutex_lock_interruptible(&eptdev->ept_lock);
> +		if (ret)
> +			break;
> +		if (eptdev->ept)
> +			ret = rpmsg_set_flow_control(eptdev->ept, set,
> +						     eptdev->chinfo.dst);
> +		else
> +			ret = -EPIPE;
> +		mutex_unlock(&eptdev->ept_lock);


                ret = mutex_lock_interruptible(&eptdev->ept_lock);
		if (ret)
 			break;

                if (!eptdev->ept) {
                        ret = -EPIEP;
                        break;
                }
		ret = rpmsg_set_flow_control(eptdev->ept, set,
                                             eptdev->chinfo.dst);
		mutex_unlock(&eptdev->ept_lock);


Thanks,
Mathieu

>  		break;
>  	case RPMSG_DESTROY_EPT_IOCTL:
>  		/* Don't allow to destroy a default endpoint. */
> -- 
> 2.43.0
> 
