Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663786;
	b=BUb2OOngGJ1RbfD73lZS90btkGQxGTFzrFY467uYwV0YzNxysmGzI8yMwiAu63zetnBh
	 4Z7lmU80ItFojle6fw44QKM8nXakwdzlxyl+og6qUSpuZyOwX/hYt2T6B6d/+a+4jYd8T
	 +/O7c5y0DC2RcDfYzDkmAZZrZxXATtPHbD1LG1+D0yGYdkUr3nYQ0lsM/4/FlUqoAOSTh
	 d7emYavsYrTmUaEGXzBbkBm6HAmEvn+VYbL6p/idbA79+ZePobB5T0tcNUcdjpcKmLNWg
	 UfbUToP32HNdpFrwvBzKg379BN5nLHrRxkrQ+liP4EKmpaZ4PnJuP1XHgvGRjeBFGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+bQlBTYtkAoBws6JgVwmAU54iz9oraRWE7IfPY9x/zw=;
	b=VAVT6f4jvM0Kpq3mKXbyx8bC1/4bes/uaxlDELbvSyqKqUe4ABzAwjkFjTThl+9T9acP
	 tnegpuP4+VfwimP6qvKbedXPQsDjMwB66KRlTUWZAo6maKsUQebnFuxwwFsW1yHMfeYsn
	 ZL6i1NqCJzF6wN+yEYvVoXevoP51WOsK/MtzVTwwIcN43Jt+nnk+t45/A4XbMcUuEYnvZ
	 ijq+NJLhMjHm/uPD3otCFMljueg2SqE8e6OMzjAaxwq9V9jYEoqcBzxxnivZ0u1TTZ/HH
	 0kaK5GlnVZeOnLWevjZibMsfY8wcdedN0DRr179RPVD+OzpODNCckTzhK8VMdKJevNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mY2S7fDn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555EA606A31E;
	Thu, 26 Nov 2026 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mY2S7fDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646E81F000C0;
	Thu, 26 Nov 2026 03:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795663785;
	bh=+bQlBTYtkAoBws6JgVwmAU54iz9oraRWE7IfPY9x/zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mY2S7fDnQgUD7EECM/t+cXrhZBxCIDHaM5mA21LFWhX7mGM2gXN8HrGyzFjYWhPSU
	 rqY7oTfO+GWuWAHrpqjZMScWjyw0NJAIKIHwkIgAO1oNjDQ1zRqEk29pkC2dqmxj7v
	 UxZpf+EAt3vCJ9EM75bLNxBgvTZ59Oxeronq0ogRVUEvSHKnK9LeciiO79n08GTEf0
	 jZS2/mYHJyU6TS4ylMlLPugAbSxjIX4Sel7d2h7oPfh/iYaeAZ7ww4UqpHAxOINhLo
	 Sim9HtXYzBcDO5xI1jrxnJKlr6F6TnyQJBBCgskqcWvRUsD+oZw7Jth5a/v8zRhWjl
	 owPOwxJkEwGdQ==
Date: Wed, 25 Nov 2026 19:29:44 -0800
From: "Peter Chen (Qualcomm)" <peter.chen@kernel.org>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: core: cancel power_lost_work on removal
Message-ID: <awenqGbTNLEp2Oc-@hu-petche-lv.qualcomm.com>
References: <20261110111402.2504885-1-hj351016@gmail.com>
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
In-Reply-To: <20261110111402.2504885-1-hj351016@gmail.com>

On 26-11-10 20:14:02, Hyunjung Ko wrote:
> ci_hdrc_resume() queues ci->power_lost_work on system resume when the
> controller lost power during suspend. The work (ci_power_lost_work)
> dereferences ci: it touches ci->irq, ci->dev and switches the role.
> 
> ci is allocated with devm_kzalloc(), so devres frees it after
> ci_hdrc_remove() returns. ci_hdrc_remove() never cancels power_lost_work,
> so a work queued by a resume just before unbind can run after ci has been
> freed and dereference freed memory -- a use-after-free.
> 
> Cancel power_lost_work at the start of ci_hdrc_remove(), before the
> devm-allocated ci is released.
> 
> Found by static analysis; not runtime-reproduced (needs a chipidea
> controller losing power across a system suspend/resume that races unbind).
> 
> Fixes: cc509b6a47e7 ("usb: chipidea: core: handle power lost in workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>  drivers/usb/chipidea/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 3461dd7..400e4ca 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -1246,6 +1246,13 @@ static void ci_hdrc_remove(struct platform_device *pdev)
>  {
>  	struct ci_hdrc *ci = platform_get_drvdata(pdev);
> 
> +	/*
> +	 * ci_hdrc_resume() queues power_lost_work when the controller lost

There is no function name ci_hdrc_resume, it should be ci_resume
Others are okay for me.

Peter

> +	 * power during system suspend; the work dereferences ci, so drain it
> +	 * before the devm-allocated ci is freed.
> +	 */
> +	cancel_work_sync(&ci->power_lost_work);
> +
>  	if (ci->role_switch)
>  		usb_role_switch_unregister(ci->role_switch);
> 
> --
> 2.43.0

-- 

Thanks,
Peter Chen
