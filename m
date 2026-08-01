Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEA288BA;
	Sat,  1 Aug 2026 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542445; cv=none; b=VzbFkcWGajdI3MTk9Tk3dEUgcGpJDF3SlTviT27VoZwJ3nuVE7PyXVYUrxua65KCEWl0F2brM9f0HKWrQcf0ylhnhEREJJOCjR9oQkNlpEMI2bkeLQDjjvVIaRzI9fz8VYgJoMGiZ/5P+Y05X8PaIpqMGAlt9SKB0qi4JueXFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542445; c=relaxed/simple;
	bh=S0VWoZGcaimIZLdJ0bY+pvtJf+RUpknhPlieoL+sHnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV8XgQp8b+rLIORIzzxCV0EB3Mnb2LXTa6l2yqRHvdnlLrVsNMnASG2VybywLBqCRoQNLeuZVQquozNfQfcRCx1i+s0qvN3KPx6FzHmjyFW66DJfWYLLsGbVvEFMse1vSA86k/gnMt8eG4P2JG51xdWJEX5k+T+Yf4jnjdGPADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHujfMiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHujfMiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A456E1F00AC4;
	Sat,  1 Aug 2026 00:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785542442;
	bh=yMSl9nxxy6ecn8SS8SUYw2J4FDB9e4+TO2lJG/lK4+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHujfMiFMUE4RvXA65JvdK8rj7QoTSV9voUwwrMUgqfR6y/64yF08xTCvIWxncPhl
	 p3xNOKuGv6xHt/Rzjf7EN1ki1mVyEINj5gci+D6pBzfCvT+xe1WRUKmp7iRqtGxg7B
	 iesQmE9qezhlqn64Vai+BaYt4SOAHhP/tJgQH5P4NkS7PyqOaP/TpvqR9bTh3ULNGj
	 fvtjs7BpdIa3PwbwBsezY81gV+itNyzGw9pIBEApaP9z8W1hNoQB2ADRD82jJTe1f4
	 o5nXPCyAAWYR4IqDk+i/IzhqNaVIanW7JI/gBQfCaRFqV6tDSARU4zfrllLPxAYLM8
	 IltbxLnw5is5w==
From: Jakub Kicinski <kuba@kernel.org>
To: mhun512@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com
Subject: Re: [PATCH net] ptp: fc3: unregister PTP clock on probe failure
Date: Fri, 31 Jul 2026 17:00:40 -0700
Message-ID: <20260801000040.1274739-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729021750.49181-1-mhun512@gmail.com>
References: <20260729021750.49181-1-mhun512@gmail.com>
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
--- Patch [1]: [PATCH net] ptp: fc3: unregister PTP clock on probe failure ---
commit b2adefd142cc562a99e7438a6d4b4f057c1bebfa
Author: Myeonghun Pak <mhun512@gmail.com>

ptp: fc3: unregister PTP clock on probe failure

This patch unregisters the PTP clock in idtfc3_enable_ptp() on failure
paths. It ensures that the registered clock doesn't refer to freed memory
if post-registration operations fail during probe.

> diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
> index f0e000428a3f4..32b61bb09b892 100644
> --- a/drivers/ptp/ptp_fc3.c
> +++ b/drivers/ptp/ptp_fc3.c
> @@ -835,16 +835,20 @@ static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
>  
>  	err = idtfc3_set_overhead(idtfc3);
>  	if (err)
> -		return err;
> +		goto err_unregister_clock;
>  
>  	err = idtfc3_init_timecounter(idtfc3);
>  	if (err)
> -		return err;
> +		goto err_unregister_clock;
>  
>  	dev_info(idtfc3->dev, "TIME_SYNC_CHANNEL registered as ptp%d",
>  		 idtfc3->ptp_clock->index);
>  
>  	return 0;
> +
> +err_unregister_clock:
> +	ptp_clock_unregister(idtfc3->ptp_clock);

[Severity: High]
Can calling ptp_clock_unregister() here introduce an AB-BA deadlock?

Looking at idtfc3_probe(), it acquires idtfc3->lock and calls
idtfc3_enable_ptp():

drivers/ptp/ptp_fc3.c:idtfc3_probe() {
    ...
    mutex_lock(idtfc3->lock);
    err = idtfc3_check_device_compatibility(idtfc3);
    ...
    err = idtfc3_enable_ptp(idtfc3);
    ...
}

Once ptp_clock_register() completes earlier in idtfc3_enable_ptp(), the
device is exposed to userspace. If a service like udev immediately tries
to read the clock, the POSIX clock core acquires a read lock on the
clock's rwsem and calls into the driver callback, which waits for
idtfc3->lock:

kernel/time/posix-clock.c:pc_clock_gettime() {
    down_read(&clk->rwsem);
    ...
    err = clk->ops.clock_gettime(clk, ts);
} ->
drivers/ptp/ptp_fc3.c:idtfc3_gettime() {
    ...
    mutex_lock(idtfc3->lock);
    ...
}

If the probe thread then fails in idtfc3_set_overhead() or
idtfc3_init_timecounter(), it reaches this new error path and calls
ptp_clock_unregister() while still holding idtfc3->lock.

ptp_clock_unregister() attempts to acquire the write lock on the clock's
rwsem:

kernel/time/posix-clock.c:posix_clock_unregister() {
    ...
    down_write(&clk->rwsem);
    ...
}

Would this result in an indefinite deadlock where the probe thread waits
for the rwsem and the userspace thread waits for the driver mutex?

> +	return err;
>  }
-- 
pw-bot: cr
