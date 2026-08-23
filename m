Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D42441B8;
	Sun, 23 Aug 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787522795; cv=none; b=c0Ft6PFFG/fktC7WnUuEoOcM9R3sPNXpbj99Lh2626kq7+rsyUKUfpo1FxiAZMlNUTQo6iYbaRmPNCu27LvHbNC3Z9ycfjrIAENjty/d5ZsyU/qQooYgUa1xn5vZ38gLTD9At1DIYphSOjZYJKKFvXZn9lQ00BwyittMbqKfLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787522795; c=relaxed/simple;
	bh=xvvPlb3P4KKibqc1sugfc/MKgV+HbS16jkaTd35/pjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTYI0grLGpF3cjzKxlStlRQLOe3U40FRR8ji+00N3unnX/PovKsa00QwzvC1CSNulee0KMYQlEpoJQBHCdTMWKk2NqFmegiVO1MIQ/llLJPNLn8xjjNhR8K1/1QWzNJ53bNoGW4F1eDNCIA2MZn6v4UXdmc1bCXJnXYeJw0NtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZVXQjUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZVXQjUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B091F000E9;
	Sun, 23 Aug 2026 22:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787522792;
	bh=nWnAqUMLFtZc20z77AoYiAzz+XiM9rBwf+D/Y0esJAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NZVXQjUqRXakACXi1TwZHg5J2+eT8kmspzblL5UnCtn20yiTbubkG7BVisiWvAczQ
	 gxDBiV0fwbGTWcQlcvHu7bjI1AKB9qHjdH2cNUlQT8RFSBNTclvFLGobEM8HlIEDm9
	 LrjsaCfBCyH5xR2nvj6wwgxtHzC2JNLefyV78iwMKwsE3TQQda8lDEVBdP/Y6ucgvi
	 BnQtExqgB9dgRkPIkqkNHp6J3ono4Y6A5I1vX6Nz7eluzamAAj3jDbvIqOE2k5fwwR
	 sgfT7nPsHQ3ir3+Z0sXGmhhnwd64LO9YvDgg16OZxk0bnBHOqwyfEI3ywKcKGROegn
	 O29uADL4uoe5Q==
Date: Sun, 23 Aug 2026 23:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: cancel reenable_work before freeing
 trigger
Message-ID: <20260823230627.4670d9b0@jic23-huawei>
In-Reply-To: <20260806142502.475394-1-fanwu01@zju.edu.cn>
References: <20260806142502.475394-1-fanwu01@zju.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 14:25:02 +0000
Fan Wu <fanwu01@zju.edu.cn> wrote:

> iio_trigger_notify_done_atomic() defers ->reenable() into
> trig->reenable_work on the system workqueue, and the worker dereferences
> the owning trigger through container_of().  Nothing cancels this work
> before iio_trig_release() frees the trigger, so a worker armed by the
> last in-flight IRQ can outlive the free and touch freed memory.
> 
> Cancel it at the top of iio_trig_release(), which every free path
> reaches through the device core's final put_device().
> 
> Found by an in-house static analysis tool.
> 
> Fixes: 9020ef659885 ("iio: trigger: Fix a scheduling whilst atomic issue seen on tsc2046")
> Cc: stable@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Logic seems correct to me.  Applied to the fixes-togreg branch of iio.git.

Note the only way we can see this in practice requires a race with a race handler
closing bit of code. Having said that, the inner one of those races handlers is
occasionally needed, so fair enough that we need to fix this.

Jonathan

> ---
>  drivers/iio/industrialio-trigger.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..68e92eac2b77 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -509,6 +509,8 @@ static void iio_trig_release(struct device *device)
>  	struct iio_trigger *trig = to_iio_trigger(device);
>  	int i;
>  
> +	cancel_work_sync(&trig->reenable_work);
> +
>  	if (trig->subirq_base) {
>  		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>  			irq_modify_status(trig->subirq_base + i,

