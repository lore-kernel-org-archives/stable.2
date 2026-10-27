Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087773;
	b=e3fqDMytvqsnPXueWe0/ZhM5QqQGJeGkhQZ/416s4X8IxgMPcb2Mba9oLB1kyTDpj7AT
	 XRAb9AMX37M7usN8AOiBT10nIZmlhxFE9xQgVeo1oXMTplEHnpOMSHQ56msSRArRv2MPM
	 PqS9t5kDX6RHzgq/3CpPIiax8toZIMp6OLqJz3Id/ksJ+6MZBSrOHgU1ouYLldW0rihJz
	 l8TwHywO0hRhEb9JWtAQ+S7l23mpqxVimqB7rN/1R+96i3MQ43iAVoYqQkz0vbhHIhzLT
	 mW7R4rgOZi3mCbIlWVn48rXrChBnMF9J1zBIV5RzLUQfldcHAzZR1qWTSMlg2Rw4ZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087773;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=woMxwONMWLKksu9rxoNrHmFj3q/ZBtmMPIuY/EKOGOY=;
	b=VUR65y3pVpP660UtgXFO0PankqlDfCMO/O1hT6afJE37kH4CxX52xkE+WgRwL7O8nNmc
	 GMv3k7ZnMO6F1usaVKR2pJZ5K/FfohaH3tYX9U1u90lhIB80qPRRPp3hGsERdtNH4n612
	 oof+g6P9/NPTHm6xZaa3ZPKCDZ6V5SX1Iwoha6fvvS6srXW0VqX1cD/KQ0DckK7/myxJq
	 DISg4zB2k7gaGrKIk+DeSv6bjzF29WI4ntRAeDnzONTcxv9ZnF5HrGI+ypEZiJ9Mf2ObT
	 3GWYyL8XMT+ZRWejiO3cljd5TSXysufHBIo4kHBzXobi0n/edcZaqOZ9l/z6Kr/1FXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxksHaZ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72B606A31E;
	Tue, 27 Oct 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxksHaZ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C133E1F01825;
	Tue, 27 Oct 2026 07:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793087772;
	bh=woMxwONMWLKksu9rxoNrHmFj3q/ZBtmMPIuY/EKOGOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OxksHaZ5enl/EVu7xalL7FuVNyTCAS8GpVwtsqBBTm+6VTbfPqvmqpjL/tFwixt9e
	 be5X/xxndT/m9IrNDsDz6iPv0B30Y/P51fDCoV3nqqbdq1UDuEmehYZtKYtrGlKMNk
	 wdFD3fG6oA+EoEeQCYBL1YtDiLqf/w29J1piBgZN483puJhr2t+q35y00o5zUipuif
	 1qM5IPtYEJH82NSGlj1ciiv81lyndHN7JdqOijCHkxvXzHePwlMcKEU1Fb53o0Pb0O
	 jkaFi5oGeILQ+SpJgf7dpmLbFvgKhF7Qlcoi7ypelmb2WqxTwOJHgslQIIVkf+KcL0
	 vSsCGwgFrJVlw==
Subject:
 Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linville@tuxdriver.com,
 sameo@linux.intel.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Tue, 27 Oct 2026 07:56:11 +0000
Message-ID: <179308777133.3134.14547624262445573198@kernel.org>
In-Reply-To: <20261023195409.3532540-1-tristmd@gmail.com>
References: <20261023195409.3532540-1-tristmd@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

nfc: llcp: use timer_shutdown_sync to prevent timer rearm

This commit switches link_timer and sdreq_timer in local_cleanup() from
timer_delete_sync() to timer_shutdown_sync(). The goal is to stop the
associated work items from re-arming the timers while cancel_work_sync()
runs, so that no deferred work runs after kfree(local).

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index 74bf817007cf2..a098d72a15ba8 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -173,14 +173,14 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
>  static void local_cleanup(struct nfc_llcp_local *local)
>  {
>  	nfc_llcp_socket_release(local, false, ENXIO);
> -	timer_delete_sync(&local->link_timer);
> +	timer_shutdown_sync(&local->link_timer);
>  	skb_queue_purge(&local->tx_queue);
>  	cancel_work_sync(&local->tx_work);
>  	cancel_work_sync(&local->rx_work);

[Severity: High]
Does this fully close the use-after-free described in the commit message?
The timers can no longer be re-armed. But tx_work, rx_work, timeout_work
and sdreq_timeout_work still use cancel_work_sync(), and that does not
stop them from being queued again afterwards.

tx_work is cancelled before rx_work, and nfc_llcp_rx_work() always queues
tx_work:

net/nfc/llcp_core.c:nfc_llcp_rx_work() {
    ...
	nfc_llcp_rx_skb(local, skb);

	schedule_work(&local->tx_work);
    ...
}

Suppose rx_work is running when local_cleanup() reaches
cancel_work_sync(&local->rx_work). That cancel waits for it, and in the
meantime rx_work queues tx_work again. local_cleanup() then returns and
local_release_work() does:

	local_cleanup(local);
	kfree(local);

Can nfc_llcp_tx_work() then run on the freed local? It would touch
local->tx_queue, call nfc_data_exchange(local->dev, ...) and call
mod_timer(&local->link_timer). The pending tx_work work_struct inside the
freed object would also still be linked on system_wq.

Here is one way rx_work can be running during the final cleanup:

nfc_llcp_data_received()
    nfc_llcp_find_local()             /* takes a reference */
                                      nfc_llcp_unregister_device()
                                          nfc_llcp_remove_local()
                                          local_cleanup()
                                          nfc_llcp_local_put()
    __nfc_llcp_recv()
        schedule_work(&local->rx_work)    /* system_wq */
    nfc_llcp_local_put()  /* last ref, queues release_work on llcp_wq */

After this, rx_work and release_work run at the same time on different
workqueues.

Digital drivers can reach this. nfc_digital_unregister_device() calls
nfc_unregister_device() before cancel_work_sync(&ddev->cmd_complete_work).
That lets
digital_tg_recv_dep_req()->nfc_tm_data_received()->nfc_llcp_data_received()
overlap with LLCP teardown. nfc_tm_data_received() checks dep_link_up but
not shutting_down.

There is a related path. nfc_llcp_tx_work() passes the raw local pointer
to nfc_data_exchange() as the context for nfc_llcp_recv(), and it takes no
reference:

	ret = nfc_data_exchange(local->dev, local->target_idx,
				skb, nfc_llcp_recv, local);

For digital devices, this completion runs from cmd_complete_work, which is
only cancelled after nfc_unregister_device(). A late completion goes
through nfc_llcp_recv()->__nfc_llcp_recv(), which writes local->rx_pending
and calls schedule_work(&local->rx_work). The local it touches may already
have been through local_cleanup(), or may already be freed.

Would disable_work_sync() work for the LLCP work items, or at least
disabling rx_work before tx_work? That would match what
timer_shutdown_sync() does for the timers.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023195409.3532540-1-tristmd%40gmail.com
