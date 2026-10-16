Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99E3BADBC;
	Fri, 16 Oct 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141763; cv=pass; b=Qc6dp4G7MYjzRVq5n3w0WvK7a+aBMszdVempaL0dw+MjNhKNBBO8ig1INtQq7M8SMnbBi8aP+Z+9vajV/1J3OwqcGTH9EJtiN70xKhT6a+lpS79EPLjlY+TnboG5gO4yOwJlSvfMg7T+P+400OxONjESu3hjqBAj32M5Fcx6EsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141763; c=relaxed/simple;
	bh=UgXnxwCLGuvqZOSsU4fy+wfie1bi2sWpkIg2c8gWxmo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JfuY7C8ojXrLt0jUaXt5WmLRU1MV6nFoSEm4lurr3DuQW1yuvzmLEoF87M/pyNdWDNKWdSJm1MCcyBV6eZlAWJPEmhq05afXngXlfXfvpJwjM1Tt+EjtkZ2cSTy8jIBgDrrfznvpJQLz3LTyjxqEyVPYbszKRDjOV3NqhrH3ots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=SNfZkt1Q; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="SNfZkt1Q"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0B35B20191D;
	Fri, 16 Oct 2026 11:09:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792141758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtp5NswhFEl4YgfVOTFchFoV/7fpLXSgI5GX6kOAYdE=;
	b=SNfZkt1QfAc5uLr7EUQBfbpBaRcAbHw1Yuyt3twRw4YbszCy86yGQqxM3HvZHnboioXDqj
	RHCtmkjRRcp+GQEc99Y0RZCfnMyzs2NwY1t6HpeGLu7wm/40t/RL8h1IHU7m5MrcwC28i1
	kgTcDbP/ar8Av/fQmngr1kEOSfyY6U7OZd3nC8zrqXGZi1PSasfXFKpeTx6+Hw86syK7nH
	Ge6xBpuBPqdBleK6TVR9i464/MQEeV5x8tdpLEwKIkxblwGntC9I20Cr5wkBsryBwAIYZ1
	BqAkyEYnr6YXpUNAENetyZz9YsbPvZQSPxEaXpTfARrQVhqSESjC3YXa1GnqjQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792141758; a=rsa-sha256;
	cv=none;
	b=Pp66GAVX+QW8y0MtmdJzjRbQ4yxZjg84XqkiAH/MJ+a/4KB92SAXhEhvONfpNRxSON9vFK
	3dDbSFnL7vRQ86SbKlItvIEhggrrBC5SzH8qR5y8mu/wqUAcGli0gxv1QLB7YSi06tyEeu
	DDgSdR3nP8BlHho6ah2jNk5VMjIFywmEy5BBv2R3ot6Stv5tr1UYlETRfosrCRioMVS5mI
	gzbjUkmqt0QErI/pqijRQ+6yZnXBzk58EBEBMedf5gemsdv6p/wYW87K8IoyVEDHWSfTSp
	uHXsNS9cyQir0FziogMNvZi1I9OVacDPTPcyvz5DGq/APvDpq4zMD5ChmQzDKg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792141758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtp5NswhFEl4YgfVOTFchFoV/7fpLXSgI5GX6kOAYdE=;
	b=aZ7qeMtnQ1UusTO+62J7uEUX5csbh2ka8J3IOtkgFtmXtIdFxwTpUWIK0kVinOrL1ZFqjq
	a+0/p83PZovGBsoekS0DKbOpK8d89lolwKQMICBF7epif9F+b0Cs9AgVs6y4V9ZgCIi3Ja
	R7MHZAFRPdfl6RtM3HYqQ+KSa5hA5OfGGMSQPRVhBkWaN8LISMM5DuELxFvJ9IgHJsEajq
	4YjeNrmx/tXjaVUd1NYxV8W+KOsP8X4hDYqP8UAWzfXRue7E0dhCfMiZspc/AZaoHH8pp3
	N8b/5AqTdow+WACJUSlZ89bjoTCHlrV3sn7gvShjsEGpqMQox1cBtBRdXTHN0w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHdwD-0069xl-2z;
	Fri, 16 Oct 2026 11:09:17 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A130C5C5E94;
	Fri, 16 Oct 2026 09:09:17 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: proc: reset pkg_stats atomics individually
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
In-Reply-To: <20260512133937.21957-1-runyu.xiao@seu.edu.cn>
References: <20260512133937.21957-1-runyu.xiao@seu.edu.cn>
Date: Fri, 16 Oct 2026 11:09:14 +0200
Message-Id: <179214175419.1231518.15412443291350448797.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=10686; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=UgXnxwCLGuvqZOSsU4fy+wfie1bi2sWpkIg2c8gWxmo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6+HJX9pfp+/d8q1Lysur/0pR3wnkXF4uUYqzogWoWz
 a3bMlvudpSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAivusZGXbd9xdUVz2We7Jq
 kZOIjxHvJOG5+4sTelPmvUj1PCg2s4+R4doDxtchi0/N3hL4aLJ7H8+V7L7LAgEzEpNlW+fu55J
 OZgUA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-05-12 21:39 +0800, Runyu Xiao wrote:
> Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> converted several members of struct can_pkg_stats to atomic_long_t and
> updated the hot TX/RX and procfs read paths to use atomic_long_*()
> helpers. However, can_init_stats() still clears the whole struct with
> memset().
>
> can_init_stats() is reached from can_stat_update() in timer context and
> also from the procfs reset path. Those paths can run while the TX/RX hot
> paths are concurrently updating rx_frames, tx_frames, matches and their
> *_delta counters. Hitting the whole-struct memset() in that window
> performs plain writes to fields that otherwise follow an atomic_long_t
> access contract, which can lose or mix live statistics updates.
>
> This issue was found by source-level API-misuse analysis looking for
> whole-object resets left behind after atomic_long_t conversions, then
> manually audited on Linux v6.18.21.
>
> Replace the whole-struct memset() with a helper that resets the
> atomic_long_t counters via atomic_long_set() and clears the derived
> scalar statistics explicitly. This preserves the existing reset
> semantics for scalar fields while restoring atomic access discipline for
> the live counters.
>
> Build-tested by compiling net/can/proc.o on x86_64 netdev/main.
> Runtime-tested with a QEMU + vcan setup on Linux v6.18.21 by driving
> concurrent traffic and reset_stats reads, which reproduced inconsistent
> exported statistics before the fix.
>
> Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

The netdev bot has found some issues, can you take care of them?

regards,
Marc

--- Patch [4]: [PATCH net-next 04/37] can: proc: reset pkg_stats atomics individually ---
commit efa392826f228e08df66ba3c5bf707d70092f478
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: proc: reset pkg_stats atomics individually

This patch replaces the whole-struct memset() in can_init_stats() with a
new helper, can_reset_pkg_stats(). The helper resets the atomic_long_t
counters of struct can_pkg_stats with atomic_long_set() and clears the
scalar derived statistics with plain stores.

Link: https://patch.msgid.link/20260512133937.21957-1-runyu.xiao@seu.edu.cn

> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae3459..64b3bdc2fa7e 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] = {
>   * af_can statistics stuff
>   */
>
> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
> +{
> +	atomic_long_set(&pkg_stats->rx_frames, 0);
> +	atomic_long_set(&pkg_stats->tx_frames, 0);
> +	atomic_long_set(&pkg_stats->matches, 0);
> +
> +	pkg_stats->total_rx_rate = 0;
> +	pkg_stats->total_tx_rate = 0;
> +	pkg_stats->total_rx_match_ratio = 0;

Discovered by: gpt-6-astra, opus-5-5, sonnet-5 · Missed by: sashiko-gemini · Called a false positive by: gpt-6-astra

This isn't a bug introduced by this patch, but these scalar fields are
still written with plain stores from timer softirq context. The writers
are can_reset_pkg_stats(), can_init_stats() (for jiffies_init) and
can_stat_update().

Process context reads the same fields with plain loads, in
can_stats_proc_show():

	seq_printf(m, " %8ld %% total match ratio (RXMR)\n",
			pkg_stats->total_rx_match_ratio);

and in can_reset_stats_proc_show():

	if (pkg_stats->jiffies_init != jiffies)

Without READ_ONCE()/WRITE_ONCE() or data_race(), will KCSAN keep
reporting data races on struct can_pkg_stats? The commit message limits
its goal to "the live counters", so this is only an observation.

> +
> +	pkg_stats->current_rx_rate = 0;
> +	pkg_stats->current_tx_rate = 0;
> +	pkg_stats->current_rx_match_ratio = 0;
> +
> +	pkg_stats->max_rx_rate = 0;
> +	pkg_stats->max_tx_rate = 0;
> +	pkg_stats->max_rx_match_ratio = 0;
> +
> +	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->matches_delta, 0);
> +}

Discovered by: sashiko-gemini, opus-5-5 · Missed by: sonnet-5, gpt-6-astra · Confirmed by: opus-5-5 · Called a false positive by: gpt-6-astra
This is a pre-existing issue. The commit message says plain writes in
the reset path "can lose or mix live statistics updates", but the same
kind of loss remains in the regular timer path after this patch.

can_stat_update() runs once per second from the stats timer. It
snapshots the delta counters at the top of the function, for example:

	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);

It then derives current_tx_rate, current_rx_rate and
current_rx_match_ratio from those locals. Only at the very end does it
clear the counters:

	atomic_long_set(&pkg_stats->rx_frames_delta, 0);

While this runs, can_send() and can_receive() keep calling
atomic_long_inc() on tx_frames_delta, rx_frames_delta and matches_delta
from other CPUs. An increment that lands between the read and the set
is lost. It is not in the snapshot used for this interval, and it is
wiped before the next interval starts. Under load, the current_* rates
and the current match ratio therefore undercount. The rx_frames,
tx_frames and matches totals still count the frame.

Switching can_reset_pkg_stats() from memset() to per-field
atomic_long_set() avoids plain stores to the atomics. It does not turn
the read and the clear in can_stat_update() into a single atomic step,
so this window is unchanged by the patch.

Would taking each snapshot with atomic_long_xchg() against 0 at the
top of can_stat_update(), and dropping the trailing atomic_long_set()
calls, close the window? Should that be folded into this fix, or sent
as a separate patch?

Discovered by: gpt-6-astra, opus-5-5 · Missed by: sonnet-5, sashiko-gemini · Called a false positive by: gpt-6-astra

This is a pre-existing issue, but can_stat_update() reads the *_delta
counters at the top and clears them at the bottom, after the
calculations and any can_init_stats() calls:

net/can/proc.c:can_stat_update() {
	...
	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
	...
	/* clear values for 'current rate' calculation */
	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
	atomic_long_set(&pkg_stats->matches_delta, 0);
	...
}

Meanwhile can_send() and can_receive() call atomic_long_inc() on these
deltas from other CPUs, for example:

	atomic_long_inc(&pkg_stats->tx_frames_delta);

Any increment between the snapshot and the clear is overwritten. It
never shows up in current_tx_rate, current_rx_rate or
current_rx_match_ratio, though the totals still count it.

Would taking each snapshot with atomic_long_xchg(&delta, 0) close that
window?

> +
>  static void can_init_stats(struct net *net)
>  {

[ ... ]

> -	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
> +	can_reset_pkg_stats(pkg_stats);

Discovered by: gpt-6-astra, opus-5-5 · Missed by: sonnet-5, sashiko-gemini · Called a false positive by: gpt-6-astra

This is a pre-existing issue, but this patch has Fixes: 80b5f90158d1.
Should the reset in can_stat_update() be handled as well? That commit
also changed can_stat_update() to snapshot the counters into locals
before any of the can_init_stats() calls:

net/can/proc.c:can_stat_update() {
	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
	long matches = atomic_long_read(&pkg_stats->matches);
	...
	/* restart counting in timer context on user request */
	if (user_reset)
		can_init_stats(net);
	...
	/* matches overflow - very improbable */
	if (matches > (LONG_MAX / 100))
		can_init_stats(net);

	/* calc total values */
	if (rx_frames)
		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
	...
}

After can_init_stats() returns, the pre-reset locals are still used for
total_rx_match_ratio, current_rx_match_ratio, current_tx_rate,
current_rx_rate and the max_* fields. So the values that
can_reset_pkg_stats() just cleared get refilled from pre-reset data.

With the stats timer enabled (the default), can_reset_stats_proc_show()
only sets user_reset = 1, so every user requested reset takes this path.
If no more traffic arrives, total_rx_match_ratio and
current_rx_match_ratio keep their pre-reset values indefinitely. They
are only recomputed under if (rx_frames) and if (rx_frames_delta).

The matches > (LONG_MAX / 100) guard is also defeated, because
(matches * 100) is still computed from the stale copy after the reset.
On 32-bit with HZ <= 100, rx_frames and matches can both pass
LONG_MAX / 100 in the same tick. Can this multiplication then overflow a
signed long and export a garbage ratio?

Before 80b5f90158d1, these expressions read pkg_stats->... after
can_init_stats() and so saw zeros. Given this, the commit message
statement "This preserves the existing reset semantics for scalar
fields" does not hold for the default timer-driven path.

>  	pkg_stats->jiffies_init = jiffies;
>
>  	rcv_lists_stats->stats_reset++;

Discovered by: gpt-6-astra, opus-5-5, sonnet-5 · Missed by: sashiko-gemini · Called a false positive by: gpt-6-astra

This isn't a bug introduced by this patch, but user_reset is a single
file-scope flag shared by every network namespace and accessed with
plain loads and stores:

static int user_reset;

can_pernet_init() arms a separate can_stat_update() timer for each
netns. A read of /proc/net/can/reset_stats in netns A sets the global
flag. Whichever netns timer runs next resets its own stats and clears
the flag here:

	if (user_reset) {
		user_reset = 0;
		rcv_lists_stats->user_reset++;
	}

reset_stats is created with mode 0644. Can an unprivileged user in one
netns therefore reset another namespace's statistics, including
init_net's, while the reset requested for netns A never happens?

Separately, with the stats timer disabled, two concurrent readers of
reset_stats can both pass the check in can_reset_stats_proc_show():

	if (pkg_stats->jiffies_init != jiffies)
		can_init_stats(net);

Could they then race on the plain stats_reset++ and user_reset++
increments and on the user_reset test-and-clear?

pw-bot: cr

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
