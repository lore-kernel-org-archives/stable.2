Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709877;
	b=kV5Kepdda8+cdT2jm11ulWnM2AJXf26eFMOw12+pBusHz3OH6wj1txRZEXwpwiIQJJSw
	 bFnICKqtkI1H6nGXDsr53cnKJP+ISFPZH2W6q99XlY0eTB26dcQcZmsARlZclqsBTK+sI
	 jrDY5RxZ2OJATPsj/Qt0J3WX2QrBIVduzELaQqR5vMbc64bFVMWo983xN/OK1P/mk/T+8
	 J1L1BEHec6RV4b5t3XuoLeS3fPmDM6J+vOziGGTIGyYtFFRSsnlEGVnVxaVr5+aagS4t1
	 czC5dzRENJLfBTC/hHeJi1t/wTa08hSpHoAzLUb7bSkAnsxTb5Cuib3+fSmG14cTu1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709877;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=stSLXlobOeNYQpr82D2/1dF4bsjCQsp5v/wivCmGpZE=;
	b=1JyukNEblv8IiwZ9qobDsjIlHZHwth3SmeDmXeB7NBzxv2Imd69AQHUcn/Dgzeqgv2Uf
	 A39mPYQrk5VZwtcxGFGvyWEnVj/LVVeqbhd4LqBc7E4600xwKTLB8qAnowckH1KQb+Iqn
	 Pjv/fqj63MYIOl4DZlNuW/Lgt74sZjYYgH2w7Gef0LKxdUE0zP/zM/5UguCCpA1vmetz9
	 D7JaR4niweoOmRGf+RgBt0jHbt7qzKgMknOb4CtUyvAPRNOmC7nzA/Xlkfh0IQaIKEC+C
	 5jmOzY2zwL1UzWKmbifByLB2JavxCziJYgb9MfwtGDepMUlOcLGmMzfDsKeyXLgJ7BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GClbfwYG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 41016606A327;
	Sun, 15 Nov 2026 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GClbfwYG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 597D61F000C4;
	Sun, 15 Nov 2026 02:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794709876;
	bh=stSLXlobOeNYQpr82D2/1dF4bsjCQsp5v/wivCmGpZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GClbfwYGCafBU0ZDAyu0rjj2UH0PxwIhVG0H/EuvQuKw4OuKaPzy9PGEKI5SmA46B
	 KpXpc7BLrP4Mt46AXlOs5XWGX1RQ0yE2xaCockLko979jDpgg/e/1bSadwTvWjcqBQ
	 j8zxX6pS3qkEE5srinmB9pkYHp6T5JiSoAKkZ4nWH3RSPZLxIdYxGCeSVoIlbinJeT
	 nOrrvC1lRKsDmsxx5fZyA8pqFSp3V8rqbe45/Z46sD0C3ImX6npxAcIbU9iAr8HH4D
	 ZGbG3KfkzSihYShrRMW72iopMM6oUupIYVjCUh0sBjXYZ1UrU4qTIviuydQEyFgLF0
	 mRNhi1UTDoUvw==
Date: Sat, 14 Nov 2026 21:31:15 -0500
From: jfern@kernel.org
To: Chris Wiseman <chriswiseman@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
	Cheng-jui Wang <cheng-jui.wang@mediatek.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Keep lazy timer intact on second lazy callback
Message-ID: <20261115023115.GA3752240@joelbox>
References: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>

On chriswiseman@google.com wrote:
> wake_nocb_gp_defer() checks waketype == RCU_NOCB_WAKE_LAZY and
> rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT in one if-statement.
> 
> When the first lazy call_rcu() in a NOCB group arms rdp_gp->nocb_timer
> for the 10-second lazy flush delay and sets rdp_gp->nocb_defer_wakeup to
> RCU_NOCB_WAKE_LAZY, the next CPU in the group that queues its first lazy
> callback calls wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY, ...). Because
> rdp_gp->nocb_defer_wakeup is no longer RCU_NOCB_WAKE_NOT, it misses the
> first branch and falls into the else block for RCU_NOCB_WAKE, calling
> mod_timer(&rdp_gp->nocb_timer, jiffies + 1) and resetting the 10-second
> lazy timer down to 1 jiffy. The same fallthrough also shortens a pending
> 2-jiffy RCU_NOCB_WAKE_BYPASS timer to 1 jiffy.
> 
> Commit 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power") wrote
> this check against rdp->nocb_defer_wakeup, and commit 463d46044f04
> ("rcu: Fix delayed execution of hurry callbacks") switched it to
> rdp_gp->nocb_defer_wakeup, which exposed the fallthrough across all CPUs
> sharing rdp_gp.
> 
> Give waketype == RCU_NOCB_WAKE_LAZY its own branch and only arm
> nocb_timer when rdp_gp->nocb_defer_wakeup is RCU_NOCB_WAKE_NOT.
> 
> Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
> Fixes: 463d46044f04 ("rcu: Fix delayed execution of hurry callbacks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>

Looks reasonable to me. Is there a test case that you added to find this, or any
power savings that you found with this added patch?

thanks,

Joel Fernandes

> ---
>  kernel/rcu/tree_nocb.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index b6cfee4e5039..347d718befd0 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -335,10 +335,12 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	 * Bypass wakeup overrides previous deferments. In case of
>  	 * callback storms, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_LAZY &&
> -	    rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> -		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> -		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	if (waketype == RCU_NOCB_WAKE_LAZY) {
> +		if (rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> +			mod_timer(&rdp_gp->nocb_timer,
> +				  jiffies + rcu_get_jiffies_lazy_flush());
> +			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +		}
>  	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> -- 
> 2.52.0.rc1
