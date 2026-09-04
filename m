Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114B43E9FC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516526; cv=none; b=tG7rJ7HSC866ZFDTdiZ+VSjSKLSASQqXKRkJMIdRBgHemWWavULvRTiDMVuFXM2444aOUYiC2IapieuyFX3HaHnX7VVUQwFqp8sy/BN3isp2BZv26wpfMm+8KEYGAIhlQcrUZXqL2hMZKwoIPJhbfJ5fPp2SPt+/eB6MMpw+Au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516526; c=relaxed/simple;
	bh=i1Y0VjW9BWwPMAg7mYJjxBDW5inPM6uPrRZpBnIMpe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MarAAUkhXKFz8vgn6q616m0KKhSRMVuJjEuA8V8p91LP/CFJlVEP3UMqhFHeUPh+o580GHXNwY0hrm+I3jvkJh+vFQZ3gRYtW+B78yr4Nj24S1tOxEWtp7mWib64oJcpKgThvLY/o4+y5MzKghj5lEI1LM1QleYnnFno3sHkJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tmYTvYS4; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tmYTvYS4"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i1Y0VjW9BWwPMAg7mYJjxBDW5inPM6uPrRZpBnIMpe8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788516521; v=1; x=1789121321;
 b=tmYTvYS4navZS5aFJLWEb6aQ5oXUXWP8ck1mcUQZnNvi6kETcbFogzsHa58tdYiLJx3qG86T
 6xtjBUQCQNdWFuHfdTsAV93X442a4Vb2upuL/FS1oSyegMa4yMEOTAzpj3TH54YW5/e3aeaHG4r
 UhOCh9h15CK+tk33Lqzevcr4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e463b848106c95a2;
	Fri, 04 Sep 2026 10:08:31 +0000
X-Mizu-Trace-ID: e463b848106c95a2
X-Migadu-Flow: FLOW_OUT
Message-ID: <783cc6a6-78ff-4bbd-ae64-7cadfdead560@linux.dev>
Date: Fri, 4 Sep 2026 11:08:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ptp: ocp: prevent watchdog rearming during detach
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 07:43, Runyu Xiao wrote:
> ptp_ocp_detach() uses timer_delete_sync() to stop the watchdog before
> freeing the ptp_ocp state. timer_delete_sync() waits for a callback that is
> already running but does not prevent the callback from rearming the timer.
> 
> Since ptp_ocp_watchdog() unconditionally calls mod_timer(), detach can
> return with the watchdog pending. A later callback can access freed state.
> 
> Use timer_shutdown_sync() for the final watchdog teardown. This ensures the
> callback is complete and cannot rearm the timer before the state is freed.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/ptp/ptp_ocp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 3d26ec1f7..6b5f615a2 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4870,7 +4870,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>   	ptp_ocp_debugfs_remove_device(bp);
>   	ptp_ocp_detach_sysfs(bp);
>   	ptp_ocp_attr_group_del(bp);
> -	timer_delete_sync(&bp->watchdog);
> +	timer_shutdown_sync(&bp->watchdog);
>   	/* Disable interrupts on all timestampers */
>   	if (bp->ts0)
>   		ptp_ocp_ts_enable(bp->ts0, 0, false);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
