Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109549;
	b=v5CpCUwthkBZW91oKhvCuV/XkTLWEucuRH5Q5uXHMrfaiO9MifJg9O1E+m9PBsBmlE/6
	 0dh5X2Utc6ohnGwOxb/D2k18507LUSKB4IlNMkXz9an3jVLWR5XdKN6L3hCe42fYzVqtS
	 5UItsJr5/JNjCBpFjlsdaApabnfODVsVZVy2EPxdIZgvGyzaDmahVmi74nGP9xpxQNeDn
	 FfeXW08azPH+lj2dGbvYkhaO4bx54Gl+CngQEhFqnLKtC7APh216n0BhcXyMHWB/VeklX
	 RF0F5sIz85xGf+OAYDzirRffs6dzo9JZ+YLr5z7tZybTBqx/50+p3O6lLGykqxqgAUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109549;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=8evx/OnDv2YPWD6aIwDbgZ+0tUSDkhKzy6/0pfCa9R4=;
	b=EHZfwqs4IHx+XhOe7Jp8z5UAt0xF96CxhO7qZdLSiZXe3/Y+BLTP88OouRc8s2GkyExJ
	 jwJFAonTcLFIg/K97hzvlUQWeltzXmhjFkae/kDFN5qgoMZqCcVVOZW/jVTbukHHWvt09
	 rmqXafluXchukL2gF2gniWRYTeCfd/cr7lzmUsZwsUhZCoAsA4NYJNIInZhlC2tlR9CsI
	 1LDzRMVEIh+Z+AzqlZY28nllSPeTolGKPTwpmCMwEl2GpyUHXQWzKpft+a0P7SeEMrDfS
	 z0CTQ7NXWo3t/OVPMBldx9JQNYJcooRBD41LFJAJ7nz0v55gvkJE3s3exPbmB87VccA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFWfkF5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B59606A324;
	Thu, 19 Nov 2026 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFWfkF5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F231F000C5;
	Thu, 19 Nov 2026 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795109548;
	bh=8evx/OnDv2YPWD6aIwDbgZ+0tUSDkhKzy6/0pfCa9R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QFWfkF5MFqECFm/ONqh0GfMItM4A93vTc/TBcvj6O/vqZO/X1Q6n88h3KFQc836tZ
	 RLqwoitUZ3cpgCoLNL2G1mtKOWPtVnrJgED/cgpPGmBorDmjhJMxZWHct138p9bRQN
	 edUNTLD9OSwX+jWfEbFAAyAbu9UBXKG1A73c8V4h5qPKQbcRSMP7y8c82qYFoG3iCf
	 qxaWnT+xXRMrmmDts42W+XOoTKqo1IjDfmrfMA2ZZad6h0YOGY2lhH9IlTH3b07wQl
	 xV01+40vanE3Ha1necrLGocmmsEolUYlf4yhFTxmusUfloSAkneP2MeOflIhvJ/lVU
	 GIBulwDEPtQTw==
Date: Thu, 19 Nov 2026 18:32:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
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
Message-ID: <av8yqfimCeSkQrq0@localhost.localdomain>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114-rcu-tree_nocb-wunsequenced-v1-1-057996a86f0e@kernel.org>

Le Sat, Nov 14, 2026 at 09:26:10PM -0700, Nathan Chancellor a écrit :
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

We indeed want a coherent snapshot for debugging.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


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

-- 
Frederic Weisbecker
SUSE Labs
