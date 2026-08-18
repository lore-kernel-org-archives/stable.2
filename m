Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4C3F823F;
	Tue, 18 Aug 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059992; cv=none; b=b0smzz+OaSHDUYgeftT1RLUQ+421fg7ldLQrYXt58uG6CHbtdOVpu4JAjA9JqktkOTa6LbMeygs+m232CkHfW0XpuiIvWGSI+FalKQ40T2e4cbJIN8ekT3cb9z5UzkVzNUYpK2Y+C3VKwnU3tgJ9BYBSXmQ7MSeCC0Vv+r7c1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059992; c=relaxed/simple;
	bh=Oi1cTzgTprUd4WU5jM52yUOTkZAFOXmhRaKwVUAGG1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEn5IRUv/A1f+Rj3FPKR29eYnbfS0BlDrjVmfm4+/+HwDrlLodLxTj44BkkMS7uIq2UEpZDN/Wq4rk9xEz35ftsR7mRFG0SLJ4r5pKtO/oChyuSnroOSyXNVcaj5sfmpyBNIc+zEK1U+OeMUMbEg9+WfKMo/g386SeQmqOEQOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql3uSSky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql3uSSky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65C01F00A3A;
	Tue, 18 Aug 2026 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787059990;
	bh=CFD41dh/fwtM84XrgZgA3HsRy6U7C483I7C+CBFivAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ql3uSSkyHkZLszzG1X7krowpaIJRvcjqQkNAQdZnj3aaXo/3uBAi8vt3cpvSHQduP
	 8mwdkFIEnypZvn9Tr3iT9YzF/uGGKUvrQvfocZ8GxAKvwZ1J0DrnjXQGvd0CM1WQHL
	 b8o9PFK9DFiUCToqZzlEIXdSCK18CpG8xhxGgvRpdXXkc520yfYUjpAGvWWm14/oYX
	 CaNFwxHTwQD0krkk6mAy0SeCLSKO/x8trEnwjkaJq5+A0VeKl0wugFRxold0fwKR8s
	 Z7MlO/++68n/dJZdaRMGwkQMRzawKXA8xveagWEt5UabK5wQUKKjzyItJViKkQ3IRp
	 sobTOBppx+XZw==
Date: Tue, 18 Aug 2026 14:33:06 +0100
From: Simon Horman <horms@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luca Weiss <luca.weiss@fairphone.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipa: fix stalled modem TX queue after runtime
 resume
Message-ID: <20260818133306.GH265046@horms.kernel.org>
References: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>

On Sat, Aug 15, 2026 at 06:03:02AM +0200, Jorijn van der Graaf wrote:
> ipa_start_xmit() unconditionally stops the TX queue before calling
> pm_runtime_get(), relying on the wake scheduled by runtime resume
> (ipa_modem_wake_queue_work()) to restart it once power is ACTIVE.
> But that work is queued from within the runtime resume callback,
> before the device's power state reaches RPM_ACTIVE, so it can run
> while the device is still RPM_RESUMING.  The wake is then consumed
> too early: the transmit it restarts stops the queue again,
> pm_runtime_get() returns -EINPROGRESS without arranging any future
> wake (deferred_resume exists only for RPM_SUSPENDING), and after the
> resume completes nothing is left to wake the queue.  Transmit stalls
> permanently: packets pile up in the qdisc behind the stopped queue,
> the device runtime-suspends, and since the netdev registers no
> ndo_tx_timeout the watchdog never fires.  Observed on SM7635
> (Fairphone 6) as the cellular data path going permanently deaf
> within hours, RX included, since nothing resumes the suspended
> endpoints.
> 
> Close the window by making the wake work wait for the resume to
> complete (pm_runtime_get_sync()) before waking the queue.  Every
> queue stop is then guaranteed a later wake that happens while power
> is ACTIVE; a transmit racing a new suspend/resume cycle re-schedules
> the work.  If the device could not be resumed, wake the queue anyway
> so pending packets are dropped by the transmit path rather than
> stranded.
> 
> The STARTED power flag used to narrow this window: a wake running
> before the transmit path's stop suppressed that stop, but only once,
> as the flag was cleared by the first stop it absorbed.  Removing the
> flag made a single transmit during an in-flight resume sufficient to
> strand the queue, which is the form observed.
> 
> With an accelerated reproducer (autosuspend delay shortened to 5 ms,
> ~20 packets/s of TX), an unpatched kernel stalled three times in
> 230 s / 4380 packets; with this patch the same test ran 3601 s /
> 70298 packets without a stall.
> 
> Fixes: 688de12f080f ("net: ipa: kill the STARTED IPA power flag")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
> 
> Runtime testing was done on a v7.1.2-based device kernel carrying
> this same change, on a drivers/net/ipa/ipa_modem.c otherwise identical
> to this tree's; the patch as posted was build-tested on net at the
> base commit.
> 
>  drivers/net/ipa/ipa_modem.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Simon Horman <horms@kernel.org>

