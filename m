Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CF134CCF;
	Sun,  4 Oct 2026 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108880; cv=none; b=gdfA/PJexPMahGmbezWp7CB2yomdThguvFX+Yb+cBpNQHUm8kKHRm/wkYk0yv1oDTNFZ1gdr7QhRKSq5Zi+88eKCVPd66eLMAiqdU1liIJMwwjzYeuMowvlhVGIS/9lJ6Rzg9bjzSq4DY0xmlm3vhQaTB+XNMYPBaojTDeFHApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108880; c=relaxed/simple;
	bh=aQBpPbkz7ZDBMOBOV8wDOvq9JzIBpm/LNzyMWA0JHKk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwjuaJxbtbBiHrdqHTp4Izii0+UosPtZ1hEbGR60MoZEhQQQv4FZYpW69pq97hJnupn9jaCV7OftgSEr/+a1wbDUKf3nxACRNd8o0D+Xzeht1TA5NbtKc0Lp9qDxvMcbOLSYiIwQFukmfkVrb/p9v/jY/IEBLXvbCZrLkSxmp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1FqCqr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1FqCqr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FFF1F000FF;
	Sun,  4 Oct 2026 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791108879;
	bh=4r5/C4JCJZeEUGXdTQ3rAADP0uRBtsY2xFNcp4jidH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B1FqCqr7nq9qX1hvafa0Lbd8V5iO0ku/V2kP3bolCqyZq+I7TwiCY0mTNr9X10pEN
	 McE0C235vtElkMMT9lhx06zpNaUxQ87p6em/bx937n9/L1CxTQ3LtblPyeY/0MYKxo
	 SwzESCLeTPhse3gAsCQgQf/TIjmyY6lu4fhejkrODtoviIDkScrRSUahjhpsObtLyO
	 ReNqSsFxrS/FhjmmRRiQ7x68q9iDQ9vt0vJoo4BryfVf25u1icLmq7L2TIKuF3uRNi
	 Bxnr97zdwov9KC/EPFMVKfclieVusXY5zb+cZSYIflGzf7slx8CU0hqcY6cSEELdp6
	 J1NgO9hq5bxLA==
Subject: Re: [PATCH] bnxt: prevent timer rearming during teardown
From: netdev-bot+sashiko@kernel.org
To: runyu.xiao@seu.edu.cn
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, huangjw@broadcom.com,
 eddie.wai@broadcom.com, prashant@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Date: Sun, 04 Oct 2026 10:14:37 +0000
Message-ID: <179110887788.434549.16288034417298811962@kernel.org>
In-Reply-To: <20260930092806.2977763-1-runyu.xiao@seu.edu.cn>
References: <20260930092806.2977763-1-runyu.xiao@seu.edu.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a bug that does not exist, and
  the change does not work the way the message says.

--

bnxt: prevent timer rearming during teardown

This patch adds a BNXT_STATE_OPEN check before the final mod_timer() in
bnxt_timer(). The goal is to stop a callback that is already running from
rearming the timer once __bnxt_close_nic() has cleared the flag. It is
tagged Fixes: c0c050c58d84 and Cc: stable.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d7728d0c5b6e6..c506b6160902f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14521,7 +14521,8 @@ static void bnxt_timer(struct timer_list *t)
>  		bnxt_queue_sp_work(bp, BNXT_RING_COAL_NOW_SP_EVENT);
>  
>  bnxt_restart_timer:
> -	mod_timer(&bp->timer, jiffies + bp->current_interval);
> +	if (test_bit(BNXT_STATE_OPEN, &bp->state))
> +		mod_timer(&bp->timer, jiffies + bp->current_interval);

[Severity: Medium]
Is there actually a teardown race here? The commit message says:

  If teardown clears BNXT_STATE_OPEN while the callback is running, the
  callback can rearm the timer after __bnxt_close_nic() has started
  deleting it.

In __bnxt_close_nic(), the teardown sequence is:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:__bnxt_close_nic() {
    ...
	clear_bit(BNXT_STATE_OPEN, &bp->state);
	smp_mb__after_atomic();
    ...
	timer_delete_sync(&bp->timer);
    ...
}

timer_delete_sync() already handles a callback that rearms itself. While
the callback is running, __timer_delete_sync() keeps retrying:

kernel/time/timer.c:__timer_delete_sync() {
    ...
	do {
		ret = __try_to_del_timer_sync(timer, shutdown);

		if (unlikely(ret < 0)) {
			del_timer_wait_running(timer);
			cpu_relax();
		}
	} while (ret < 0);
    ...
}

After the callback returns, __try_to_del_timer_sync() sees that
base->running_timer != timer and calls detach_if_pending(). That removes
any timer the callback rearmed. The kerneldoc for timer_delete_sync()
says:

  Upon exit the timer is not queued and the handler is not running on any
  CPU.

The rearmed timer could also fire before it is detached. In that case the
entry check in bnxt_timer() returns without rearming, because
BNXT_STATE_OPEN is already clear. The only other place that arms the
timer is __bnxt_open_nic(), and it does so after
set_bit(BNXT_STATE_OPEN).

So before this patch, the worst case looks like one extra mod_timer()
that timer_delete_sync() then detaches.

The commit message also says the new check "prevents a callback already
in progress from starting another timer period". But test_bit() and
mod_timer() are two separate steps with no lock around them. A
clear_bit() on another CPU can land between them, and the callback can
still rearm. The guarantee still comes from timer_delete_sync().

Would it be better to treat this as a cleanup? That would mean dropping
the Fixes: and Cc: stable tags and rewording the commit message so it
doesn't describe a teardown race fix.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930092806.2977763-1-runyu.xiao%40seu.edu.cn
