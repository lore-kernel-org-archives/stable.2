Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109034;
	b=qULUz3rxBh+55P56Uzz+1/ljtobklxJRXdUUFfmxac9iArKauIhuXaVqaeMlNcZofl5g
	 PaxwgIjzFYri2TIL+SRFjFXsVLkRvF/yx5p1Zl48qsw/uvTBh/KDgyWY+9j5QfJEN5FJU
	 oLmJvJA6n2KqxrmGSwIOHV0O2xqyvLDDz2B7tnY7K4bHn2Drve+hDqlmY+3CcXT1i8VWJ
	 hrSuVD3I8+Ax7yMgVXnfJkV2OgfXXT6aekS9kXVgwLDrJjfRGZwDUEvJ4rb2x6GZltmFS
	 KOKRbYYPTx7ksRDiN5Ym30AObAMacv+N+svXfHzXo0KrolfIP1RJALFX/L9GDchGBsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109034;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=t5wo7xXbJcuw9tovTj7TawORnslxAC42P735QvA1/L0=;
	b=gqeMFr6oJtf25EkwC4kywWQ7GqMt6DFYiH6eMIBuujSafCR5Utdck2+CXWMeTlAjNlYD
	 5cbFH02fHZ1TrIUzPEeMmwFDBdcb0TvOSYgWLc3VRyux0QalE6CSo5cE7BJMNnRochyx+
	 JyZwz9p6g2Yq2O8dz1PhBZWDfheYu20fnNW2j1xlM+XJoeBCVHDhVw10x33xzPy7NMJtU
	 rRf/kn5CsoljyRfe+qR5kthVT/u8fG79kLo2Q8yUkWatvbFX41/Ktl0YtpKLEZsu6iG2Y
	 JaxW/u5i4fewL54vB6Ok/gogZEplpl37nzNkrHWCqddFybtThIqnLX7uo5PmJ5CBdNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImpXvFWL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF7606A320;
	Thu, 19 Nov 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImpXvFWL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD781F000C5;
	Thu, 19 Nov 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795109033;
	bh=t5wo7xXbJcuw9tovTj7TawORnslxAC42P735QvA1/L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ImpXvFWLHFdaPZE2v0k1yuxko/IJcK+TfUIaNUDOCBb1abhtpt+LVF7XOb+RE+f2G
	 ICFhtkw1PYGgFGsGleBlk8e2Xj4a4MGLnQMas8212QP2q+6OEzV2D8vbA9U1ROILK/
	 /si9NJH0TNICuElKww7r+Jbw+8qEBqhRySu1aXZ0A79ECt9nAdUh4KRdlLc+59yxrv
	 w7nuAr1OrkFb2BMGd5KAcS6upvOzbkzWUG2OQ4BelDBclbNNHYAPVTmyUQFG6vpTkf
	 HabU/Ynl9fCsffEhxrrxFh/53CYYif1g4OM6PGbRgjtgq0x6HpqXO9TMZdncXROAwT
	 SzHIcLi+nNSnw==
Date: Thu, 19 Nov 2026 18:23:49 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chris Wiseman <chriswiseman@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <av8wpfu6yU3QgJXN@localhost.localdomain>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>

Le Sun, Nov 15, 2026 at 02:07:29AM +0000, Chris Wiseman a écrit :
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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

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
> 

-- 
Frederic Weisbecker
SUSE Labs
