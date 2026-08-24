Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEF376A10;
	Mon, 24 Aug 2026 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598108; cv=none; b=t7sz3Caencgv97BV5wJ0O/WedTlHRe+k4/vyWeaFdxeLjX9h9kAxNuosGG/GESNbMSxJ7nXWEV20QIV8KjPp5bibkHkwVl/i2cbC8/gvxffkhz/qnAlymHJlMGc7dh+dMiIoS2bcJmMWHnt3pvjBTcrb/c8w+t6jAnW/nRQNYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598108; c=relaxed/simple;
	bh=QPG+5zHZF8Ux1aDsagZX6ts4+HP84U3dMCEfF7MrHbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGsv6rWvsP7E+Mf9qb6k1g9FTqNB+x+jG748s83u7uIanbziAdIUl+QSU8qjIQw7Bi8BLnuPGWlcPlGxj6XOwvfWiXARL1dcfaDEPryItA9fRPVeVi/g4uBKkvOzz7vnPQvyegS69TcJzZXkD42h2ICPmRWLeqvmVQaxlgt/Z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV+hujfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV+hujfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87121F000E9;
	Mon, 24 Aug 2026 19:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598107;
	bh=z3oH1SxaO2SwL91Ta+fmi+p0s6Gj/py/2Bq4Gth7lSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QV+hujfsLtm8xqiDvBxnAtkpQhSztVxo1MpB1tjCOssuEidIQ4aiJ+Auirh+w8fiP
	 4jlzDyRbxm/QJQDhj69G7R8EL3HtZQHT7+ff+TkR4SDsxp657WEodenqkwRJHEPNTc
	 XwcZm3i3TV7gxNNVXSV1vicY0R2GhmeLRYOoxE4B+ohhyZeU3WbkUKRTY8jz1Ck8zO
	 QeMgkdfOexJAU7nEmqbbA5rUhRKFKdMX7yMdB/rPoTUp/PFZy+3yMiVR47DOPzIvX6
	 p15mlOHGgZ2vx0oYf01pp/f6RP16yBkuKY28+31StQ/Wa7dSWmUbKson6xLN2+Vgg0
	 yaARQjGSuAsJg==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	jtornosm@redhat.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	stable@vger.kernel.org,
	rafal.romanowski@intel.com
Subject: Re: [PATCH net 1/4] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Mon, 24 Aug 2026 12:01:45 -0700
Message-ID: <20260824190145.2714480-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204537.2189112-2-anthony.l.nguyen@intel.com>
References: <20260821204537.2189112-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
iavf: return EBUSY if reset in progress or not ready during MAC change

This adds an early bail-out to iavf_set_mac() so that a MAC address change
returns -EBUSY when a reset is in progress or when the VF has not yet
reached __IAVF_DOWN.  The stated motivation is to avoid waiting inside the
ndo callback while the netdev instance lock is held.

No Link: tags present in the commit header.

A couple of questions below, one about the commit message and one about the
new check itself.

>     After commit ad7c7b2172c3 ("net: hold netdev instance lock
>     during sysfs operations"), MAC changes are called with the netdev lock
>     held, so we should not wait with the lock held during reset or
>     initialization.

[Severity: Low]
This paragraph describes a user-visible behaviour change caused by
ad7c7b2172c3, but there is no Fixes: tag on this commit.  Was that
intentional?

Worth noting that this commit does not actually remove the wait under the
netdev instance lock: after this patch iavf_set_mac() still calls

	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
					       iavf_is_mac_set_handled(netdev, addr->sa_data),
					       msecs_to_jiffies(2500));

so a Fixes: ad7c7b2172c3 here would arguably be misleading.  The later
patch in the same series, "iavf: send MAC change request synchronously",
does carry Fixes: ad7c7b2172c3 and cc: stable, which looks like the right
place for the provenance.  Is that the intended split?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 29b8403a066b..630388e9d28c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1042,6 +1042,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  	struct sockaddr *addr = p;
>  	int ret;
>  
> +	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
> +		return -EBUSY;
> +

[Severity: Low]
Is this check-then-act sequence racy against the reset scheduling path?

iavf_is_reset_in_progress() does plain reads of adapter->state and
adapter->flags:

	static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
	{
		if (adapter->state == __IAVF_RESETTING ||
		    adapter->flags & (IAVF_FLAG_RESET_PENDING |
				      IAVF_FLAG_RESET_NEEDED))
			return true;

		return false;
	}

IAVF_FLAG_RESET_NEEDED can be set from a context that does not hold the
netdev instance lock:

dev_watchdog()
  netif_freeze_queues(dev);
  dev->netdev_ops->ndo_tx_timeout(dev, i);    /* timer context */
    iavf_tx_timeout()
      iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED)
        adapter->flags |= flags;              /* non-atomic RMW */

net/sched/sch_generic.c only freezes the TX queues around ndo_tx_timeout(),
so there does not appear to be anything serializing that writer against
iavf_set_mac().  If the TX timeout fires just after the new test, does
iavf_set_mac() go on to the 2.5 s wait_event_interruptible_timeout() with
the netdev instance lock held anyway, i.e. exactly the case the check is
meant to reject?

The window is small and the fallback is the pre-patch behaviour (blocked
for up to 2.5 s, then -EAGAIN), so this looks like a best-effort guard
rather than a new failure mode.  Is that the intent, or should the state
and flags reads be done under the same serialization as the reset path
(and with READ_ONCE(), given the concurrent non-atomic |= on
adapter->flags)?
