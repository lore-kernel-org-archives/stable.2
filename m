Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16661E22E9;
	Fri, 31 Jul 2026 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504308; cv=none; b=QdKnfXs9lDbcQX7GXURq9RnVihafbCnSISHa9kPajdqdFNWtCAI1wqplcUBAdZBHpJk4bgbrTdrcnZswzoZuF8NiB6a4axw2MIPx3tJ58npVoYrLDQrh0vi3fieaHzTYCj61TclTR9sUR8A9RAydy7cIdgyYfvy5C01KFT5utKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504308; c=relaxed/simple;
	bh=SNqW0AcC12UUHiXLwJjL7nphdBNEiPpISj+Qn4EYqdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjzB38U2vhKhQ4dgqd2fFo8KpVQUhBeByyXoQsvTo2Aznh3zNbrCLfb0MHBe7gu46qqGkg1enuJu08aZ8mc6M4t9sFl4CCZ/jshJ9LbKULsGc87LzUltr6hCISwYnWescgy5wlTLY+/nUjgENSxoqeeYlCRcbzN//3XZBGkZ1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBzqJasP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBzqJasP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC271F000E9;
	Fri, 31 Jul 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504306;
	bh=utjqEB17tKWhckTFh1NqEfXTplQWPtaUNOXGP6fvNZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBzqJasPBrgN5I6aKiksVfo7lPXdHuFUpgQa29YF5Rs2DVWR2op4G7w8WPZq96wml
	 w7wL7B8p2ZbZFgVhDqNBWItwVRRMgPZsh2biJrbtW4kM04T5FGbDkdIbkWyH4qHpvA
	 NSObXoj61256/1sxb6GQeXo2vsm9dG9U1x7YbZJc85icgI5buSNSSSq+XvHvxwOnJ0
	 OwX0hSmnFZpWxL2kKNkQsEIKmSjM/s44IpnICRWH+Rj4ihytgH3XmJP+0YqCVSW6IL
	 orjsbh4N/Y0A6TGzTojoBzI++EO7FYOvkA3/UfQueaaZ8L3HPipN2du587K+X66Vk/
	 M5DJJUmmd7P6A==
From: Simon Horman <horms@kernel.org>
To: fanwu01@zju.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	david@ixit.cz,
	mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: trf7970a: initialize lock and timeout_work before requesting the IRQ
Date: Fri, 31 Jul 2026 14:24:54 +0100
Message-ID: <20260731132454.277038-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728031021.230831-1-fanwu01@zju.edu.cn>
References: <20260728031021.230831-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728031021.230831-1-fanwu01@zju.edu.cn?part=1
---
--- Patch [1]: [PATCH net] nfc: trf7970a: initialize lock and timeout_work before requesting the IRQ ---
commit 4be20d05d9fa2b3917899acbab0b48bcd2d1125f
Author: Fan Wu <fanwu01@zju.edu.cn>

nfc: trf7970a: initialize lock and timeout_work before requesting the IRQ

This moves mutex_init(&trf->lock) and INIT_DELAYED_WORK(&trf->timeout_work,
...) above devm_request_threaded_irq() in trf7970a_probe(), so an interrupt
arriving right after the handler is registered cannot touch an
uninitialized mutex or delayed_work. The IRQ-request failure path destroys
the mutex inline and returns. Tagged for stable.

> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index 60883001fa5d..3e57f8cf229e 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -2124,18 +2124,19 @@ static int trf7970a_probe(struct spi_device *spi)
>  		}
>  	}
>  
> +	mutex_init(&trf->lock);
> +	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
> +
>  	ret = devm_request_threaded_irq(trf->dev, spi->irq, NULL,
>  					trf7970a_irq,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					"trf7970a", trf);
>  	if (ret) {
>  		dev_err(trf->dev, "Can't request IRQ#%d: %d\n", spi->irq, ret);
> +		mutex_destroy(&trf->lock);
>  		return ret;
>  	}
>  
> -	mutex_init(&trf->lock);
> -	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
> -

[Severity: High]
This isn't a bug introduced by this patch, but since the patch fixes the
setup side of exactly this ordering problem and is tagged for stable, is
the mirror-image teardown window worth addressing at the same time?

Nothing in this driver ever synchronously cancels trf->timeout_work, and
the devm-registered IRQ is only released by devres_release_all(), i.e.
after trf7970a_remove() returns and after probe's error unwinding at the
err_destroy_lock label.

First case, work still queued at unbind. trf7970a_tg_listen() arms the work
in mode-detect state:

	trf->state = mode_detect ? TRF7970A_ST_LISTENING_MD :
				   TRF7970A_ST_LISTENING;

	schedule_delayed_work(&trf->timeout_work, msecs_to_jiffies(timeout));

but trf7970a_shutdown() has no arm for TRF7970A_ST_LISTENING_MD:

	switch (trf->state) {
	case TRF7970A_ST_WAIT_FOR_TX_FIFO:
	...
	case TRF7970A_ST_LISTENING:
		trf7970a_send_err_upstream(trf, -ECANCELED);
		fallthrough;
	...
	default:
		break;
	}

so the queued work survives, and trf7970a_remove() goes on to

	nfc_digital_unregister_device(trf->ddev);
	nfc_digital_free_device(trf->ddev);
	...
	mutex_destroy(&trf->lock);

and returns, after which devres frees the devm_kzalloc'ed trf. Can the
still-armed delayed_work timer, which lives inside that freed allocation,
then fire and have trf7970a_timeout_work_handler() dereference trf->dev,
trf->state and trf->lock after free?

Second case, work already running. The only stop used anywhere in the file
is the non-synchronous variant, in trf7970a_send_err_upstream():

	cancel_delayed_work(&trf->timeout_work);

If trf7970a_timeout_work_handler() is already blocked on
mutex_lock(&trf->lock) while trf7970a_remove() holds it, that cancel
returns 0 and remove() continues. Once remove() unlocks, does the handler
acquire the lock and run concurrently with the rest of remove(), reaching
trf7970a_send_err_upstream() -> trf7970a_send_upstream() -> trf->cb(trf->ddev,
...) after nfc_digital_free_device(trf->ddev), and finally
mutex_unlock(&trf->lock) on a mutex already destroyed inside memory devres
frees as soon as remove() returns? nfc_digital_unregister_device() only
sync-cancels its own poll_work/cmd_work/cmd_complete_work, it does not
touch trf->timeout_work.

There is also a debug-only aspect on the newly funnelled error paths. All
failures after the IRQ request (VIN and VDD_IO get/enable, ddev allocation,
startup, nfc_digital_register_device) reach

	err_destroy_lock:
		mutex_destroy(&trf->lock);
		return ret;

while the devm IRQ is still armed, and trf7970a_irq() takes the lock as its
first action before any state check:

	mutex_lock(&trf->lock);

	if (trf->state == TRF7970A_ST_RF_OFF) {

With CONFIG_DEBUG_MUTEXES, mutex_destroy() clears lock->magic, so does a
late interrupt on these paths (and on the remove() path) trip
DEBUG_LOCKS_WARN_ON in the mutex debug checks?

Would adding cancel_delayed_work_sync(&trf->timeout_work) plus a
devm_free_irq()/disable_irq() (or registering the mutex and work teardown
with devm_add_action_or_reset() so release order mirrors setup) before
mutex_destroy() in both trf7970a_remove() and the probe unwind, and handling
TRF7970A_ST_LISTENING_MD in trf7970a_shutdown(), close these windows?

Verified with git grep on drivers/nfc/trf7970a.c: no occurrences of
cancel_delayed_work_sync, flush_delayed_work, disable_irq or devm_free_irq.
