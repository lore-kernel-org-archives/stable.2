Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876B4AD7EF;
	Wed,  7 Oct 2026 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382504; cv=none; b=d5Aj4nvnEJJp/hVm+1giPyLvxeNNh1+t8yZb4NJyLBXlQLz8MN+7/aQxWRT1DRK9wDt0MHPp2h4k8eyQ0Vb57k8XHWlyYZSawMRlVJ3/gvISJbIyBmoNwNkVEmuJviRrRjZ2Fuotlka6yXACKSmDeuj46S/ZT1nhNVGxx5AK1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382504; c=relaxed/simple;
	bh=BmfJieT/7exPTFpAf6O6V4IPKHT5/9HG90EL5l0Bdc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoLHlaM8MNKWWoO/2eZqeCzZlJr7Qv1SOkQemdOKuYQEIgvmSwMq2S+4bVzlAroQcbJR5uy6FzCMbB9We8bk77zD3Fy+zFH+ki8El53l6i4TS4MlTAXggUJCJeMGfpJX1lYZT6cvyU3DlHBS18hdLLqLJZISICqz6U9cKkgTSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwcVD/ch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwcVD/ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E5A1F008BC;
	Wed,  7 Oct 2026 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382490;
	bh=cmVnDEnEfK06/9W2nNmDkGaJ5NB1Grv8MQNfQmSKtls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MwcVD/ch/rCEDLa22eq72jjPwYp1EyuDUTsEnCge4IoCZu4EJrDCbfgrNLGm4/Im5
	 M4AHcMEWbbCt1h3AZTQJfkOtf0LrUT5lbGEYaH29kUxN+hteeRH09GVP9rysjoW+cc
	 WMBrs78JupCK3ZsV/8/jP+4A+auPC/Xgkv68CpzPdNL3AWjO69dqKVdbBjkgtf9TIC
	 AX+Gp0fJa/QWE9d9FUl6mluQAQc+R+M+dxCQIc/tFFV4AYgPywg/PVvIFkXkhA/EPk
	 NpmwgTMNj8q+GpLM0zceFVgq4XdM4cEpmO2QYcNpfavGjB/dW4VcGlvqHQDQ+Xpca5
	 /4Uaj4ToRxz5Q==
Date: Wed, 7 Oct 2026 16:14:47 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] ALSA: compress: reject restarting an ACTIVE task via
 origin_seqno
Message-ID: <asZT1yC4b5ipkG9N@parshuram>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-5-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007132509.18237-5-peter.ujfalusi@linux.intel.com>

On 07-10-26, 16:25, Peter Ujfalusi wrote:
> snd_compr_task_start_prepare() only rejects tasks with
> state >= SND_COMPRESS_TASK_STATE_FINISHED. Since the enum is
> IDLE(0) < ACTIVE(1) < FINISHED(2), this accepts ACTIVE tasks and
> rejects FINISHED ones, the opposite of what the origin_seqno
> mechanism needs: origin_seqno is meant to let a caller reuse a
> FINISHED task's buffers for a new job, not to restart a task that is
> still queued with the driver.
> 
> The seqno lookup path in snd_compr_task_start() has its own explicit
> "task->state != IDLE" guard, but the origin_seqno lookup path relies
> solely on this function, so it can restart an ACTIVE task, causing
> ops->task_start() to be called twice for the same task and
> runtime->active_tasks to be incremented twice without a matching
> finish/stop.
> 
> Accept IDLE and FINISHED, reject ACTIVE, on both entry paths.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
