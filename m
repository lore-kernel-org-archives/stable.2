Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496341;
	b=Rk6RB40Lf/S/4GDJtDIYntCALOI1t4uZLZpXW0v5W5JDLstEwHd9Nfbr/L1IrScvEPk7
	 ynmqxUPJZw+qJjYuZE4f0u9tFrnXEaDcvELMg23p7J6IoAiMGrrtln22iwCE6fhys/fJN
	 gRPJDkLZwYyEI6foHCb+DP9kx7cuBcmwvAh/R90B1dce5QNreKClIGNVyAaDLXC53n86F
	 LJAWULAshKcydGFHfSn76NQgXhYbcDgKc1MeMMDpN2XF+2HVO9LYLz0Ss0F4ygzRvP7Tt
	 Rjnq2zU3H6EWMeRtFpVuMtghzXVg11rI9Wes2zgAvCMikmxXoxfLlpQFx33Gm5z/D8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ao8/+Hhm6PmG9ujCJCc0WSzt76ZNCfRYeI8J8JiLVbs=;
	b=OJf04sgNfJvejZg4ch5pSCKVaOT5oL9ersSvHaDvcUoQ1XGgGf2f5dVeGq7jaY00hGPF
	 UaOnz8Ni76Hk2m89xiHc53hRVTZ0KUJUunuysaD5r4l93Duuwjvwrh+IoGt2LS466ss8x
	 qKEWhFmkNnHvPchYdH5HSIGav4696tSJ7s2LLt7Xcv0ms9dvuVw1J2RY6gUTCEbywAkVn
	 fb2290KjX/PpkaN9y4r5kW1fx3IQvnTH9qwmYOHMO/NxR3/ePvpGBI1uLrZS29MMGZQBU
	 P/Lc55MHMYhvPK28aM5FRGV1uOMhSOxeCrUcGm7wLNYp0a7Zcyl2JF0+q0E5Dtk5Ojw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3pIvZO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1BA606A31C;
	Thu, 12 Nov 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3pIvZO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C701F00A06;
	Thu, 12 Nov 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794496341;
	bh=ao8/+Hhm6PmG9ujCJCc0WSzt76ZNCfRYeI8J8JiLVbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3pIvZO0S3F9nHSr41UxG1ifsYasfQs0KrY7WUTuhgNsFdUP5VgYCJgSsC7OEzxd3
	 AipO66CkNsxuaiK6EdZFUlLTOFFVlOoBhumBRIG58JcO50RHag/jfh1RUAv9odJM+Y
	 mNqw7DeYwa5MRnzinwFRufMcWT/clFliH01atrKV2GbL8Vx6ibt0XwgqoKgBn38Hdy
	 5uaBQ2jVwqC1bLAw/QdQNGpuR2nVPvaMz7sTlQqaM43Aod4XeFE9Iwad9XNbhaBdUa
	 j/iYs1yueFgQN0nklMISEUhkI5qJI7oeIgxEtNtassvMu2DIQJwFVbuvbM3ZKgR4FA
	 nZdMea5lTB6Nw==
From: Simon Horman <horms@kernel.org>
To: xuyuqiabc@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	weir@nebusec.ai,
	xuyq21@lenovo.com,
	mgreer@animalcreek.com,
	u.kleine-koenig@baylibre.com,
	ian.ray@gehealthcare.com,
	dmitry.torokhov@gmail.com,
	thierry.escande@linux.intel.com,
	sameo@linux.intel.com
Subject: Re: [PATCH net v2 1/1] nfc: digital: fix use-after-free in unregister
Date: Thu, 12 Nov 2026 15:12:08 +0000
Message-ID: <20261112151208.496636-1-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107141910.549465-1-xuyuqiabc@gmail.com>
References: <20261107141910.549465-1-xuyuqiabc@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107141910.549465-1-xuyuqiabc@gmail.com?part=1
---
nfc: digital: fix use-after-free in unregister

This patch aborts the in-flight driver command in
nfc_digital_unregister_device() before freeing the command queue. It
also blocks new submissions once shutting_down is set and frees any
leftover req/resp skbs. Per-driver changes in port100, nfcsim,
trf7970a and st95hf try to make sure no completion callback can run
after abort_cmd() returns.

> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
> index ddfc58c299649..87c833abb36af 100644
> --- a/drivers/nfc/trf7970a.c
> +++ b/drivers/nfc/trf7970a.c
> @@ -1903,6 +1903,7 @@ static void trf7970a_abort_cmd(struct nfc_digital_dev *ddev)
>  		trf->aborting = true;
>  		break;
>  	case TRF7970A_ST_LISTENING:
> +	case TRF7970A_ST_LISTENING_MD:
>  		trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);
>  		trf7970a_send_err_upstream(trf, -ECANCELED);
>  		dev_dbg(trf->dev, "Abort process complete\n");

[Severity: Low]

The commit message presents this as part of the unregister fix ("handle
its MD listening state in abort and shutdown"). Does this abort_cmd case
take effect on the unregister path?

trf7970a_remove() calls trf7970a_shutdown() first. With this patch,
every active state, LISTENING_MD included, goes through
send_err_upstream()->switch_rf_off()->power_down() and ends in PWR_OFF.
When nfc_digital_unregister_device() later calls digital_abort_cmd(),
trf7970a_abort_cmd() sees PWR_OFF and takes the default: break case.

This hunk does change behaviour on the normal digital_stop_poll(),
digital_dep_link_down() and digital_deactivate_target() paths. An abort
during MD listening now cancels the timeout and sends -ECANCELED
upstream right away. Before, the listen ran on until -ETIMEDOUT or until
a target arrived.

The same applies to suspend, because trf7970a_suspend() calls
trf7970a_shutdown(). Before this patch, LISTENING_MD hit the default
case there, power_down() returned -EBUSY, and the chip stayed powered.

Could the commit message describe these behaviour changes? A stable
backporter would otherwise assume all of them are needed for the
use-after-free fix.

> @@ -2017,6 +2018,8 @@ static void trf7970a_shutdown(struct trf7970a *trf)
>  	case TRF7970A_ST_WAIT_FOR_RX_DATA_CONT:
>  	case TRF7970A_ST_WAIT_TO_ISSUE_EOF:
>  	case TRF7970A_ST_LISTENING:
> +	case TRF7970A_ST_LISTENING_MD:
> +		trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);

[Severity: High]

Can this assignment overwrite an ignore_timeout = true that the IRQ
thread set for a timeout handler that is already running?

Say the state is WAIT_FOR_TX_FIFO or WAIT_FOR_RX_DATA. The timeout
expires and trf7970a_timeout_work_handler() (H1) starts running, but it
has not taken trf->lock yet.

trf7970a_irq() holds trf->lock and runs:

	case TRF7970A_ST_WAIT_FOR_TX_FIFO:
		if (status & TRF7970A_IRQ_STATUS_TX) {
			trf->ignore_timeout =
			    !cancel_delayed_work(&trf->timeout_work);
			trf7970a_fill_fifo(trf);

H1 is running, so the cancel fails and ignore_timeout becomes true. Then
fill_fifo()->trf7970a_transmit() re-arms timeout_work. The SRX branch
does the same via trf7970a_drain_fifo().

Now trf7970a_remove() or trf7970a_suspend() takes trf->lock before H1
does. This new line cancels the re-armed work, the cancel returns true,
and ignore_timeout becomes false. send_err_upstream(-ECANCELED)
completes the command, and the state ends in PWR_OFF.

H1 then takes the lock, sees ignore_timeout == false, and falls through
to:

	else
		trf7970a_send_err_upstream(trf, -ETIMEDOUT);

That leads to:

trf7970a_send_upstream()
  trf->cb(trf->ddev, trf->cb_arg, trf->rx_skb)
    digital_send_cmd_complete()
      cmd->resp = resp;
      schedule_work(&ddev->cmd_complete_work);

trf->cb_arg is still the old one. Doesn't this write cmd->resp into a
digital_cmd that was already freed, either by digital_wq_cmd_complete()
or by the new cleanup loop in nfc_digital_unregister_device()?

It also re-queues ddev->cmd_complete_work after unregister's final
cancel_work_sync(). On remove, the new cancel_delayed_work_sync() only
waits for H1 after the fact, and nfc_digital_free_device() then frees
ddev while cmd_complete_work is still queued. On suspend, the second
completion either hits the freed cmd or completes an unrelated queued
command with resp == NULL.

Before this patch, shutdown did not touch ignore_timeout in these
states. In the same interleaving, send_err_upstream() cancelled the
re-armed work, ignore_timeout stayed true, and H1 did nothing.

H1 also moves the state from PWR_OFF to IDLE here. Doesn't that
contradict the new comment in trf7970a_remove() that no command path
can arm the timeout again?

>  		trf7970a_send_err_upstream(trf, -ECANCELED);
>  		fallthrough;
>  	case TRF7970A_ST_IDLE:
> @@ -2230,6 +2233,14 @@ static void trf7970a_remove(struct spi_device *spi)
>  	mutex_unlock(&trf->lock);
>  
>  	nfc_digital_unregister_device(trf->ddev);
> +
> +	/*
> +	 * shutdown() leaves the chip powered off, so no IRQ or command path
> +	 * can arm the timeout again and unregister has cancelled cmd_work.
> +	 * Wait for a handler that was already running before freeing trf.
> +	 */
> +	cancel_delayed_work_sync(&trf->timeout_work);

[Severity: High]

Can a timeout handler that is already running still deliver a
completion into a freed digital_cmd before this point?

The IRQ thread's error paths call trf7970a_send_err_upstream() without
setting ignore_timeout. For example, in trf7970a_irq():

		} else {
			trf7970a_send_err_upstream(trf, -EIO);
		}

The WAIT_TO_ISSUE_EOF case and the LISTENING/LISTENING_MD !NFC_RF cases
do the same. send_err_upstream() only calls the non-sync
cancel_delayed_work(), which cannot stop a handler that has already
started.

Suppose the timeout handler H1 is running when such an IRQ completes the
command. The state becomes IDLE and ignore_timeout stays false.
trf7970a_shutdown() in IDLE only calls switch_rf_off() and power_down(),
ending in PWR_OFF, and does not touch ignore_timeout.

H1 then sees PWR_OFF with ignore_timeout == false and runs:

trf7970a_timeout_work_handler()
  trf7970a_send_err_upstream(trf, -ETIMEDOUT)
    trf7970a_send_upstream()
      trf->cb(trf->ddev, trf->cb_arg, trf->rx_skb)
        digital_send_cmd_complete()
          cmd->resp = resp;
          schedule_work(&ddev->cmd_complete_work);

trf->cb_arg is never cleared, so this cmd has already been freed, either
by digital_wq_cmd_complete() or by the cleanup loop in
nfc_digital_unregister_device(). cmd_complete_work is also re-queued
after unregister's final cancel_work_sync().

This cancel_delayed_work_sync() only waits for H1 to finish, after that
has already happened. nfc_digital_free_device() then frees ddev with
cmd_complete_work still queued.

The race between the IRQ and timeout completions is older than this
patch. However, the commit message says trf7970a's timeout work and IRQ
completions are handled for unregister, and the new comment says remove
waits for a handler that was already running. Is the trf7970a part of
the fix complete?

> +
>  	nfc_digital_free_device(trf->ddev);
>  
>  	regulator_disable(trf->vddio_regulator);
> diff --git a/include/net/nfc/digital.h b/include/net/nfc/digital.h
> index bb3e8fdc06929..d5ae45da5a337 100644
> --- a/include/net/nfc/digital.h
> +++ b/include/net/nfc/digital.h
> @@ -131,7 +131,11 @@ typedef void (*nfc_digital_cmd_complete_t)(struct nfc_digital_dev *ddev,
>   * @switch_rf: Turns device radio on or off. The stack does not call explicitly
>   *	switch_rf to turn the radio on. A call to in|tg_configure_hw must turn
>   *	the device radio on.
> - * @abort_cmd: Discard the last sent command.
> + * @abort_cmd: Discard the last sent command. When called from
> + *	nfc_digital_unregister_device(), the command is freed after this
> + *	returns, so the driver must ensure that its completion callback
> + *	cannot run afterwards. Completions delivered from work items, IRQ
> + *	handlers or timers must be cancelled or flushed before returning.

[Severity: Low]

Do the in-tree implementations follow this new contract?

st95hf_abort_cmd() is still an empty stub:

/* TODO st95hf_abort_cmd */
static void st95hf_abort_cmd(struct nfc_digital_dev *ddev)
{
}

trf7970a_abort_cmd() in the WAIT_FOR_TX_FIFO, WAIT_FOR_RX_DATA,
WAIT_FOR_RX_DATA_CONT and WAIT_TO_ISSUE_EOF states only sets
trf->aborting = true. The completion is left for the IRQ thread or the
timeout work to deliver later.

st95hf is safe only because st95hf_remove() holds rm_lock across
unregister and free, and sets nfcdev_free. trf7970a relies on calling
shutdown() before unregister.

Should the documentation allow driver-side serialization in remove() as
an alternative? Or should these abort_cmd() implementations actually
stop or drain their IRQ- and timer-driven completions?

>   *
>   * Notes: Asynchronous functions have a timeout parameter. It is the driver
>   *	responsibility to call the digital stack back through the

[ ... ]
