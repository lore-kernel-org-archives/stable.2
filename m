Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735022;
	b=5K6diJdTsNgaRCQ1O9oxKpX3i5s1yQ6ZZryzr0bcEK0h7IOlrCbvMb6eF9SwVvm8SpMC
	 WqmYMeeMRGoqKEvFhwWqh5FcUCb/EXegNdeVxo7bBLc4s/B9pNpNXLqDzuUSYNAhP5oPH
	 D8WjCc2xylS7hPAhwBL21m6zzecgV3nJ21ze9T/hQhU9DYrWdfZS6VkNqA2IFMA59kV1S
	 9vX53Flq30Fs1JGrkCjHqQGUnvldl6gTWaCFthvWopo49eLYiPuNemoPPZ9Lng9KgyeSD
	 QsOhIMtdWa84dy+bVQAWUOiLZabGiYs4cU+alq5eOAeovk+vOfBDOjG8LkvVmh5Lsng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pM+ObFq+7UvTBHo/IKaCGchHuKGnrduWJa929a2AGj4=;
	b=A5ajhASRAov+kLzor683B299NgNeCqy4soAuH0mdF+1I4VZyoXNY2uRr7J6g5Phk2jyO
	 P0MbNyAEXKhEYVaHHQwxsPNQ3C/RTJadvmjpVbbzyDb+1c2dx3jaDlYji8JHZvIV0vOuF
	 8dfAHNIlIRdYRyHnjxhhacvVDQ74m63VKNb4CApVAuiGJobVPAAGq3CqJRuEiafPKt3bs
	 YvaWEyYFMwuvoIufChB97ZfJbxf5pEadZ8J5EIfknpsxv7nXfU9GiXDTx9svlTOsh1XrO
	 g2gHAH1TMreXcV/FoFcIJdZLOVoiEDnT/7bgeVvztzkwS1865sERCDWrf4FvohYJ/oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lbPap6xL;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6894606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6894606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lbPap6xL
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14fc585291cso3687505c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793735021; x=1794339821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pM+ObFq+7UvTBHo/IKaCGchHuKGnrduWJa929a2AGj4=;
        b=lbPap6xLlqMk+JYnuSIyFjcRQFqANvPP5Qqin+Bz3DY7GsGTRk8PniDPJ15f+G5ilO
         r9FUH9gktdgCzOrQpBTRygzrW0nj0WmLAxNtcOyIHnDJx0oZzTd14VRe3a1Nni0MjvN0
         78W91quHXoMTrB33+q740l4pO9Al9IeFiNf8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735021; x=1794339821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pM+ObFq+7UvTBHo/IKaCGchHuKGnrduWJa929a2AGj4=;
        b=D/rsxOkOw/SdHoEHZgbIFki+tD1a01m7zk6Skt/2KOrM/ZVEMNsGwsQ6GdTo4RYmTm
         uRs1vLSFmZlaMsp3JN78p+nGSM+DUxk/gDIRY9qsTlX+gI4UlxIB7AXCJ7Id/ynsnGub
         RzGBr5qbpa+5CiwLuTYa5Rq84EOw0F7mxFsxLqofjcLf4NoduPcrnnpha9qMU9UtnTZR
         kpfqtjtQjmC3SMvpfHQNgjVkswk3fM5RnWquQrBycvmMFAa8GWHdEC3oY3mdia3/b3zu
         kxdqrn8T6vrVFqgm6azgOwNKKjtzsjsOAes4636mlSlYtbSzDVwFobb0CmXjIyQlhOOe
         tq4A==
X-Forwarded-Encrypted: i=1; AKwUvBzY34Wolddq8J1hlIHIa198ENZDjLy9nARPw1dwAlbj+pm++nF07Qg0PaZl4vQzLXgXXn8lqZ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xJKkbLrUu8+qoLX+ZRf2qTUWsY9ikxFdhapUzv+FxYS70tHuK
	cbsTN9C6cWRFPl0dfM8aKahT+B1S1/EsHaI2jxbG6/IZF1UTqgcvN3HHb/eRSNBKZQ==
X-Gm-Gg: AYBFou0Kfiwn1sxZy4ezOYl0qz84NEY7Os/I62RaRIY/WSVuXGNHn4hq4oejBY83wa5
	+soIsMA0hMgijiGIjkPzYY1mQW/DxjhyWvxAypIIN+tFRQK0rKTrE5fZn0OA8iylLwFEzdUQLgn
	q7LCEFu4GMUdoiDWAcNrw0MIYV2hF59n7y1fbGGRbwSKui2NMEuCfAfn3S/+fA0PYoP6ibUN4SE
	g+psLgL6ntIrpZSxw1UqN1vnuQLWwZKx/ZvmXkydaQkb007bCLAMrHyHpfEnjSwV13vibXU2s3L
	6izgp1mh75P7AsZGCoB2GXKSL8H7O3qVjF02+aJ2wGdAckSt78hyanU8TuBDjxyRD666ZXvo5tc
	jGdY0viwTbxYuDHhL4afmyouaISKAvYIRc+zVraTjjz0d/v7LJNJU8TqwFCCZrGVOV5yzuo5mv9
	cEI49kfCxcuXwSnJcUJPb4OmIKpI1PeBqrxf1Q741MsYsAK8R46UvtWUoMueJwSHom1Wdcc0mJN
	C6o2jY1ysOALqCec1TOuFp02M3ioWBqwmRacZGgJF+B3ZgBdcbPpCHRCQ0pFXJ40mBYDDxFRUkU
	zDoMkGoahnGTRm9FY3DHU7HSJN708+RHUDFWwZ7Crh4SYv5o9H9hJYaPx9+/xjfalMI=
X-Received: by 2002:a05:701b:418f:10b0:14a:8df8:56c5 with SMTP id a92af1059eb24-1ac5dd5a055mr21441051c88.26.1793735020817;
        Tue, 03 Nov 2026 11:43:40 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c2c2ddsm985448c88.10.2026.11.03.11.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:43:40 -0800 (PST)
Date: Tue, 3 Nov 2026 11:43:38 -0800
From: Brian Norris <briannorris@chromium.org>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Can Guo <can.guo@oss.qualcomm.com>,
	John Garry <john.garry@linux.dev>, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Keep clock-gating hold on failed W-LUN
 runtime resume
Message-ID: <auo5ar8427cuH_nX@google.com>
References: <20261029040002.2100002-1-stanleyjhu@google.com>
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
In-Reply-To: <20261029040002.2100002-1-stanleyjhu@google.com>

Hi Stanley,

I'm not extremely familiar with the UFS or block layers here, so I'm
just coming from a general driver + runtime PM perspective. That said, I
have some thoughts:

On Thu, Oct 29, 2026 at 03:08:30PM +0800, Stanley Jhu wrote:
> 1. __ufshcd_wl_suspend() takes one ufshcd_hold() reference and sets
>    hba->clk_gating.is_suspended while the UFS device W-LUN enters
>    RPM_SUSPENDED.
> 2. Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
>    suspend callback failures"), a failed runtime resume (for example
>    START STOP UNIT completing with an error) leaves the W-LUN in
>    RPM_SUSPENDED with power.runtime_error == 0, while
>    __ufshcd_wl_resume() already clears hba->clk_gating.is_suspended and
>    calls ufshcd_release().
> 3. The next W-LUN runtime resume runs __ufshcd_wl_resume() again without
>    an intervening suspend and calls ufshcd_release() a second time,
>    dropping a reference it does not own and underflowing
>    hba->clk_gating.active_reqs on UFSHCD_CAP_CLK_GATING hosts.

I _think_ this reasoning and patch all looks good, with one possible
exception: ufshcd has explicit recovery in ufshcd_recover_pm_error(),
which relies on checking power.runtime_error, and then explicitly
overrides the status to active to clear the error.

It seems to me like commit eef1d74bf88f might have subverted some of
that logic too, because resume failures will no longer latch a
runtime_error value, so that recovery function may not be doing
much/anything. Is that a problem too?

> Keep hba->clk_gating.is_suspended and the suspend hold across a failed
> W-LUN runtime resume, so the hold stays paired with the W-LUN
> RPM_SUSPENDED state and the next successful resume releases it.
> 
> Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
>  drivers/ufs/core/ufshcd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index cc75384c6502..9be370cea52a 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -10626,8 +10626,14 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  out:
>  	if (ret)
>  		ufshcd_update_evt_hist(hba, UFS_EVT_WL_RES_ERR, (u32)ret);
> -	hba->clk_gating.is_suspended = false;
> -	ufshcd_release(hba);
> +	/*
> +	 * A failed runtime resume leaves the W-LUN RPM_SUSPENDED, so keep
> +	 * is_suspended and the suspend hold for the next resume.
> +	 */
> +	if (!ret || pm_op != UFS_RUNTIME_PM) {
> +		hba->clk_gating.is_suspended = false;
> +		ufshcd_release(hba);
> +	}

This looks right to me, as a non-expert in this code, and it may even
have been wrong before commit eef1d74bf88f.

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  	hba->pm_op_in_progress = false;
>  	return ret;
>  }
> -- 
> 2.56.0.313.g2479322e68-goog
> 
