Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4833FFAC1;
	Thu, 11 Jun 2026 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190881; cv=none; b=Us1SjRoyzfCwbIbuVfewGPvwSyNA6rHZkIniuAD44DdBSUDhDQhpk1aGOKFkuKNMvsq6ExL3Y4FTlJ6Igb0pci1kyATuOXsQXFYD2iFt8t9JwYKHDzSHCcvxI1VQWMc+U8e0gktZ5TX3oI21x6IpeqP8aPcPAwn5nY0PaN2eKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190881; c=relaxed/simple;
	bh=zxpIPJPxzL4cXmPFrR+19nmED9wNZIY/Ks1hHRdvehc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4Iw5rjtwWOCZr/yB4UnPNpQV3h5oDrL1IWttuMzMZa+Prx7lOvjZZPuoRkeRiRntRHZqF+EN7NrRcH22saKPnhAGqScBL8LSR9I0uGW/wI47CRrP+OYHGJBaeFbl1aJvzlwpUfCCENeLx7IfmndMNaTDH44LkKfFg1sqrIJM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXdeReEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXdeReEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F731F00893;
	Thu, 11 Jun 2026 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190879;
	bh=vS59teIiDlts9NPHogyQ4TbGCImDPrejJPxZv7Cl/jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXdeReEvDOXtS5dRlYe9GvVzPhHVqnT18yGqhcVKMCVFV0t34cfHA8iv36A+Jdzr6
	 cYdHm7NOjC+wyXTRhxDh4Yc3zcGILNLtAYucWZVKnRMhtQgo6k9COy6Sj6idYVqanf
	 4IxhjeM/wQ4ZSMt16hUD6BJJr8U4FzGxHT8qeHQ3vvmQRsRw7858Lz3noga/TxGi8Z
	 4A3rlCt2OGVntVqZRQgJXQmyPa8qvaZ8nS7OkrTih9zsp2i/5Lo9GMGdBzlERaN5tp
	 /pvKdHeVkM0YL5p1vDv0U1eFKJN9Zo8b9ZG8DgxfSjnaGHHJ4v3ZbGTpNCqA/M+iV1
	 SnWhSx4cmLGbA==
From: Simon Horman <horms@kernel.org>
To: vulab@iscas.ac.cn
Cc: Simon Horman <horms@kernel.org>,
	rmody@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] bnx2: fix refcount leak in bnx2_change_ring_size()
Date: Thu, 11 Jun 2026 16:13:50 +0100
Message-ID: <20260611151349.607666-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609074746.206312-1-vulab@iscas.ac.cn>
References: <20260609074746.206312-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
bnx2: fix refcount leak in bnx2_change_ring_size()

This patch attempts to balance the intr_sem semaphore on the failure path
of bnx2_change_ring_size() by adding an atomic_dec() after the
bnx2_napi_enable()/dev_close() sequence.

> diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
> index f5722e929833..7f8ade29b7e5 100644
> --- a/drivers/net/ethernet/broadcom/bnx2.c
> +++ b/drivers/net/ethernet/broadcom/bnx2.c
> @@ -7360,6 +7360,7 @@ bnx2_change_ring_size(struct bnx2 *bp, u32 rx, u32 tx, bool reset_irq)
>  		if (rc) {
>  			bnx2_napi_enable(bp);
>  			dev_close(bp->dev);
> +			atomic_dec(&bp->intr_sem);
>  			return rc;
>  		}

[Medium]
Does the commit message match the change?

The message states:

    Fix this by calling bnx2_netif_start(true) in the error path to
    properly release the semaphore count.

but the diff inserts a raw atomic_dec(&bp->intr_sem), not a call to
bnx2_netif_start().  These are not equivalent.  bnx2_netif_start() does
an atomic_dec_and_test() and, when it transitions to zero with the
device still running, additionally calls netif_tx_wake_all_queues(),
bnx2_napi_enable(), bnx2_enable_int(), and bnx2_cnic_start():

    static void
    bnx2_netif_start(struct bnx2 *bp, bool start_cnic)
    {
            if (atomic_dec_and_test(&bp->intr_sem)) {
                    if (netif_running(bp->dev)) {
                            netif_tx_wake_all_queues(bp->dev);
                            ...
                            bnx2_napi_enable(bp);
                            bnx2_enable_int(bp);
                            if (start_cnic)
                                    bnx2_cnic_start(bp);
                    }
            }
    }

At the patch site dev_close() has not yet run, so netif_running() is
still true; calling bnx2_netif_start() here would re-enable interrupts
and NAPI on a device that is about to be torn down.

Could the commit message be updated to describe the actual change
(an atomic_dec), since this affects stable backporters reading the log?

The message also says:

    bnx2_netif_stop(true) increments the semaphore at the start of the
    function if the netif is running.

Looking at bnx2_disable_int_sync() (called from bnx2_netif_stop()):

    static void
    bnx2_disable_int_sync(struct bnx2 *bp)
    {
            int i;

            atomic_inc(&bp->intr_sem);
            if (!netif_running(bp->dev))
                    return;
            ...
    }

the increment happens unconditionally before the netif_running() check,
and bnx2_netif_stop() invokes bnx2_disable_int_sync() near the end (not
the start).  Should the commit message be reworded to reflect that?

[Medium]
Does the single atomic_dec actually balance intr_sem on this error path?

Tracing from the bnx2_open() baseline of intr_sem=0:

  1. bnx2_netif_stop(bp, true) -> bnx2_disable_int_sync() does
     atomic_inc (0 -> 1).

  2. On error, bnx2_napi_enable() does not touch intr_sem.

  3. dev_close(bp->dev) dispatches via ndo_stop to bnx2_close():

        static int
        bnx2_close(struct net_device *dev)
        {
                struct bnx2 *bp = netdev_priv(dev);

                bnx2_disable_int_sync(bp);
                ...
        }

     which performs another atomic_inc (1 -> 2).

  4. The new atomic_dec brings it from 2 to 1.

The semaphore is therefore left at +1, not 0.  Compare bnx2_reset_task(),
which uses an explicit atomic_set(&bp->intr_sem, 1) before calling
bnx2_netif_start() to forcibly reset state on a similar error path.

Should this site either set intr_sem back to 0, or perform two
atomic_dec calls (one for the bnx2_netif_stop() increment and one for
the bnx2_close() increment), to fully balance the count as the changelog
claims?

In practice the residual +1 will be overwritten by the next
bnx2_open() via atomic_set(&bp->intr_sem, 0), but the patch as written
does not match its stated goal of fully releasing the count.
