Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DE3603C0;
	Mon,  8 Jun 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948919; cv=none; b=d0mKWwAZl633kGSi6n5sbUFRwFm2iADleJUMCvHLyIuGAsY3KV/o/nVN6Ykx99lrHj9vhjsEP6TN0oIVN1eSB9aX35E7nnIpGU3zpzfSseqyyQelR4UsCaBckrrVqpKodsF1sSefmmUxWLXtbuqPPMmvajsgevTfMJk939Z9ATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948919; c=relaxed/simple;
	bh=emHeIW+ic01qID3ut+dDDjBVoDC3qX9TSpvwDwuMbKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX2U9duztRG91i2hr4v1ehabDrC2gOzJGOCvYDUtEiot6yHuQea7ihFwD9bNA05rJKvZzxsx5VLc+IZDFHuumlTFz1gfhUNgRQRl7autYMn7p97x92ayhw9Jk+lk+7vbTvpAvqRjZnF6sNSiBAyebmI/KgsRVPzEPqxicYytDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al+UjXKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al+UjXKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92471F00893;
	Mon,  8 Jun 2026 20:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780948917;
	bh=MnD+EC7uJrbXpuauh/PcvbPflEIWo+swMHx7t2qSfoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=al+UjXKyi1gADvWyzX8+HhyOCscmrm6AlCff4JO9umunNZkjGlzPWlBime1Cgf+Pi
	 T0zWfhgxRwGBzQpRHyz/H5R4jd6r8RStX0kdw/8VI/i+uBjYhLEIpOPzEQCOARbacy
	 XXNk79ZOvk01XturNQVPBZEtpJBp+CG/2llGzlHmWVXa6MslXByJIBE0euBVg9cy8B
	 30bB58fEVqK+7emC2ClMJUwOybgVfalIZ7RRrPOi7LiWlOCok+X5bFCqc0+MBkHLyH
	 5DrJ/sXg9WN206ZPP+0RAmamcZn5hm7fU5e31eeyFP8jdVd3QzT4UvtF2olD6VO868
	 8i8uDperVBQUA==
Date: Mon, 8 Jun 2026 22:01:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: w15303746062@163.com
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: fix hardware state machine corruption in
 error path
Message-ID: <aicfiAEdlbGmKIAU@zenone.zhora.eu>
References: <20260512093534.348655-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512093534.348655-1-w15303746062@163.com>

Hi Jean,

could you please take a look here?

Thanks,
Andi

On Tue, May 12, 2026 at 05:35:34PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> A severe livelock and subsequent Hung Task panic were observed in the
> i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
> unconditional hardware register cleanup in the error handling path of
> i801_access().
> 
> When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
> controller is actively used by BIOS/ACPI), the kernel does not actually
> acquire the hardware ownership. However, the code jumps to the 'out'
> label and executes:
> 
>     iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
> 
> This forcefully clears the INUSE_STS lock and resets the hardware status
> flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
> transactions and totally corrupts the SMBus hardware state machine.
> 
> Consequently, all subsequent i801_access() calls fail at the pre-check
> stage, triggering an endless stream of "SMBus is busy, can't use it!"
> error logs. Over a slow serial console, this printk flood monopolizes
> the CPU (Console Livelock), starving other processes trying to acquire
> the mmap_lock down_read semaphore, ultimately triggering the hung task
> watchdog.
> 
> Fix this by moving the 'out' label below the hardware register cleanup.
> If i801_check_pre() fails, we safely bypass the iowrite8() and only
> release the software locks (pm_runtime and mutex), strictly adhering to
> the rule of not releasing resources that were never acquired.
> 
> Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
> Cc: stable@vger.kernel.org # v6.3+
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v2:
>  - Reused and moved the existing 'out' label instead of adding a new one,
>    fixing a build warning regarding an unused label.
>  - Dropped the inaccurate mention of "another thread" in the commit message,
>    as i801_access() is serialized by a mutex.
>  - Added Fixes and Cc stable tags as suggested.
> 
>  drivers/i2c/busses/i2c-i801.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 32a3cef02c7b..b29c99ed3883 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -931,13 +931,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  	 */
>  	if (hwpec)
>  		iowrite8(ioread8(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
> -out:
>  	/*
>  	 * Unlock the SMBus device for use by BIOS/ACPI,
>  	 * and clear status flags if not done already.
>  	 */
>  	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
>  
> +out:
>  	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
>  	mutex_unlock(&priv->acpi_lock);
>  	return ret;
> -- 
> 2.34.1
> 
