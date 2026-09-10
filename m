Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C104440642;
	Thu, 10 Sep 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038483; cv=none; b=Cdi+N/Py+cKGn7Iqa8P4+EOQryagtN7ldTvjtsdyhcvE4W8/iCWdRz/SQHfHvS8iM0AvOyqruWas/3Ygx95rf2BP0Seeppjg56/BJRWcohcXqzc1q7MyUyPmEO/Iw7kzry4LVSoCcuzIkhkDiLdrEmx0Ra+XZscIeLCDFqoHsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038483; c=relaxed/simple;
	bh=zfJRJALs2g0rvfz+b5AmvlDUmpuSIDmsF9TKdxFxut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdddiMTIh12FNjsfNQFkcQn9Voq8XqdvszOjiMeLwnVoiF0mErr+rarlu5+t3iavi69xE1ge1OWcuSugXodOX8RcGLrKAdWYaJHkT+zXL2FxaRdeQn7hB2v8pkQUgSZyVnkIHgrUU+m4jmpSfG3nioJqdGcQSUlJDUHLriBkB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FejxJOty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FejxJOty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BCD1F00893;
	Thu, 10 Sep 2026 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038482;
	bh=aiCsYPAHQ6U49SCqLoVUxzBx8ajiKDd3seIzb2Ee4U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FejxJOty3q7paorRKtt/FMFZvrESh7HqeRsRi13jfQMGUrz7z6BTF/MwVKWu4O5/n
	 6wN9uk1wDPzOG7SGrvTsbKeN2CZVPsu2dyBg93MsyFaTlFZcK/fH+OKTPDoR8MUlbV
	 R322cWjKsoIRHkvl0bPBL5f84QildQ1xZ6Pk7zNHrdaS9MuTRugeGUf1yDN5ssTXQm
	 w6lII1XQHJh2ilYRIjR4/ZT88n4DFqeKPcWeKhKG6BShvTBFaoNBFqNcrTkyZt/J43
	 OOTM5QbXqRzz8cdwvla76uizosm6cKklHkUZlB5CieSknsKj16lM093opZ79wjDxSJ
	 7nw8T020QMnWg==
Date: Thu, 10 Sep 2026 13:07:55 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: kurt.schwemmer@microsemi.com, logang@deltatee.com, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: switchtec: Fix use-after-free in mrpc_timeout_work
Message-ID: <wxn55h6jtotl6a747ryoh4sksseavvqgo7xhnh4ayg5ajrsu2y@gp7jrxa4oyyt>
References: <e640c79072065c1a347ed25f7ce0fe1ba565f4fe.1786017236.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e640c79072065c1a347ed25f7ce0fe1ba565f4fe.1786017236.git.xiaopei01@kylinos.cn>

On Thu, Aug 06, 2026 at 07:55:15PM +0800, Pei Xiao wrote:
> stdev_kill() cancels the works before clearing stdev->alive under
> mrpc_mutex. Every path that arms mrpc_timeout holds that mutex, so a
> write that already passed the alive check can still schedule
> mrpc_timeout after cancel_delayed_work_sync() returns:
> 
> CPU0                                      CPU1
> 
>                                           | switchtec_dev_write()
>                                           | lock_mutex_and_test_alive()
> cancel_delayed_work_sync(mrpc_timeout)    |
>                                           | mrpc_cmd_submit()
>                                           | schedule_delayed_work(mrpc_timeout)
>                                           | mutex_unlock(&stdev->mrpc_mutex)
> scoped_guard(mutex) { alive = false }     |
> put_device() -> kfree(stdev)              |
>                                           | mrpc_timeout_work
> 
> Fix it by clearing alive under mrpc_mutex before canceling the works, so no
> new mrpc_timeout can be armed once alive is cleared.
> 
> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/pci/switch/switchtec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 235ca1877b6c..9127841b2bf8 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1323,10 +1323,6 @@ static void stdev_kill(struct switchtec_dev *stdev)
>  	if (stdev->dma_mrpc_irq >= 0)
>  		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
>  
> -	cancel_work_sync(&stdev->mrpc_work);
> -	cancel_work_sync(&stdev->link_event_work);
> -	cancel_delayed_work_sync(&stdev->mrpc_timeout);
> -

This part of the code never existed in upstream. Perhaps you are referring to
some downstream tree?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
