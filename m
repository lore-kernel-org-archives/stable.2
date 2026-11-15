Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745904;
	b=sxkvxZQuOdsOa+BSa0jQlECD/JJdRhE76lHxdauueIgxxKnW7b3ERA1IRA97ISwGwWim
	 xRNSe8THu/C+q51rqBRe5z6lEeQs7TW7tcs0w1BgQ592SwuBWHCYyVclA4hMApAZauNiS
	 qOR1JRYRxH4em/wYnPkFvQkxxqtdTLtrP6TosUgYPMzMrGBZkTQ1kyWDeqrOcOB4oHVyl
	 d/Kvogskn5bhFxm8NsCvurA23wu9qtE5kMuSp8EkWNE0LAI/hkbLSvVmZwyJdqh07sMgr
	 O1SueD99jBv/zxgPhYAv0FEPw/EMfvQVxF3hqVFt3hTUAFUEWK1Gdzx7nL20p6wU/Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GlevWmVgnm99xWVRUylqyXtiUrBDAyjJZv3w5J7mbDM=;
	b=SBZBetw90DA85a/jsq5883gCeMybvKn0dC/erb/ePb9nAqOB2VuIuAGVXH67Iv/AFZiV
	 GTo8RhwVK7wwip1EudZZHv7D2mnEYV1KlrSonG36MlyYcJOfSKsz+aQVpEx9GRlBX29d4
	 SFlRK6VK+KDzD8+MXXsSsCo/gfNuOofbcLEtqABBGcalU6/r6CveyhC1uifve3X9QBVWL
	 oEkk4v6kSpV/LYaQbIgq78Wv+NSaf811PF9tSsJADl2YSmcFZlpKnOaEvCkD+pPU/uq7k
	 zQJHBd/moNTe11ydfkELk2A9LYbN1fkNF3s67IUX7Hu0NJXsbs3/bGsjFWAh+Sh/4Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7glPu0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 757DA606A31A;
	Sun, 15 Nov 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7glPu0B
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E93171F000C4;
	Sun, 15 Nov 2026 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794745904;
	bh=GlevWmVgnm99xWVRUylqyXtiUrBDAyjJZv3w5J7mbDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S7glPu0BlJ7Vq+IWNILFSE3/hQnCsjmROKUgrsXtRCs3hC6cZL/GBusLuhKRKZ8+K
	 Zpr07TzgPc7iA/anIH4DFuHa+O2Qrac02QGzfkuBO5KzgR4KIHP5z2THeqYo71Wacm
	 tI6WjZnbmM7QSKY1/B8smjENxExr6EBraRFARAmzivrBR9iQSjAB5J735uZNx3Ycjw
	 G3T6WBq5vR3SEPcC/YiOIwomIFwvuED3XlyvljHhJ7yuqfUhfhPVx5ayyXweIwmtZL
	 SB9ERAHjw1AurnstMpVTE2y80Nvsp4Cbk/Nas4zqWspUXNCCJWB85LbWThevJrGi+h
	 NmhUS2UQ6d0jw==
Date: Sun, 15 Nov 2026 07:31:42 -0500
From: Joel Fernandes <jfern@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Avoid unsequenced accesses to jiffies in
 show_rcu_nocb_state()
Message-ID: <20261115123142.GA650613@joelbox>
References: <20261114-rcu-tree_nocb-wunsequenced-v1-1-057996a86f0e@kernel.org>
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
In-Reply-To: <20261114-rcu-tree_nocb-wunsequenced-v1-1-057996a86f0e@kernel.org>

On 11/14, Nathan Chancellor <nathan@kernel.org> wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in show_rcu_nocb_state(),
> which can break the build with CONFIG_WERROR=y / W=e:
> 
>   In file included from kernel/rcu/tree.c:5123:
>   kernel/rcu/tree_nocb.h:1651:3: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    1650 |                 jiffies - rdp->nocb_bypass_first,
>         |                 ~~~~~~~
>    1651 |                 jiffies - rdp->nocb_nobypass_last,
>         |                 ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
> 
> Add a local variable to hold the value of jiffies before the function
> call so that there are no unsequenced side effects, clearing up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: f7a81b12d6af ("rcu/nocb: Print no-CBs diagnostics when rcutorture writer unduly delayed")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2192
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>


Reviewed-by: Joel Fernandes <jfern@kernel.org>

I will send it for 7.4 -rc.

thanks,

Joel Fernandes

> ---
>  kernel/rcu/tree_nocb.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index b6cfee4e5039..8448a7c578e8 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1618,6 +1618,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  	struct rcu_segcblist *rsclp = &rdp->cblist;
>  	bool waslocked;
>  	bool wassleep;
> +	unsigned long j;
>  
>  	if (rdp->nocb_gp_rdp == rdp)
>  		show_rcu_nocb_gp_state(rdp);
> @@ -1639,6 +1640,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  		rsclp->gp_seq[RCU_NEXT_READY_TAIL].exp);
>  	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
>  	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
> +	j = jiffies;
>  	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
>  		rdp->cpu, rdp->nocb_gp_rdp->cpu,
>  		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
> @@ -1647,8 +1649,8 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
>  		"sS"[!!rdp->nocb_cb_sleep],
>  		".W"[swait_active(&rdp->nocb_cb_wq)],
> -		jiffies - rdp->nocb_bypass_first,
> -		jiffies - rdp->nocb_nobypass_last,
> +		j - rdp->nocb_bypass_first,
> +		j - rdp->nocb_nobypass_last,
>  		rdp->nocb_nobypass_count,
>  		".D"[rcu_segcblist_ready_cbs(rsclp)],
>  		rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ? "" : bufd,
> 
> ---
> base-commit: 18b332441bbf59fa537929fe390238e137a6caff
> change-id: 20261114-rcu-tree_nocb-wunsequenced-02d11678cf42
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 
