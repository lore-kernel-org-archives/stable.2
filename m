Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530413;
	b=m7aP1Yyc8iJDoPUbRVy+mAI5BGZt5ZWswMa7+mZuuvTnXLrfODsT3Xglp4PoOSiI7/Dt
	 u2nBW1NDu/LIxMkX1RTHqZ8OpMrr7lr/VjDjwgo1VqpA3o3/qa+gVUBbCgGT/Z73ZD4r4
	 fEGPML7RDFHO6/h8B4XCZP3GSZG6/JljWmXVuC4LC5OTEK45ehwDGmDlDx3h5InLOuP29
	 flPP6f+cx4xevpnhFjfD7tRDHRHUrA/dji/f6fjo6mt7Y8vglpqgXjOY4jRGYZL82STK0
	 JGqrZPFZDuEPXFHkUD51ddow3U+ONjrEvWw0OUncSONlKXU4SfQDP2ky9n9OIPWxXnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530413;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mTwBFRyFSROWCnCFCSSel89ouxGBgoxE6b1oZnyUXq4=;
	b=wE9dX2kk6M7avozW0o+Je6gCmHzmv3nUHYQDmOd1jNQ/aOq5blqh/ga/HVa2m8G81rnP
	 3mzvVTZod9Chl1W3imuj9pVCdcdZ2xmM5VnF31jYqLjpg+VO7BkPYYGmpGfoszkZWt7JF
	 1+6qyrcMdeULMG7rguLLTnMYgpPG10sgJnWZCYuON8R5h+LTyfC4yEahES8V747GU3Etq
	 h2DD6VNHJwCbZwDyUMK7k2Ea5mzQ7M46KKnES5XCP55TVwF3S+jdxaeyQvncjiCmyljvJ
	 yWSvt07nvnzlm9y1Sfm5wKdmfo10++Ryn4vOQodfxDmvUsB7YYQ0/6iazu/WvJ9v1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5UEACMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B17606A321;
	Tue, 24 Nov 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5UEACMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC91F000C6;
	Tue, 24 Nov 2026 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530413;
	bh=mTwBFRyFSROWCnCFCSSel89ouxGBgoxE6b1oZnyUXq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n5UEACMURgjfpgLFKrsVZFmC2awe4D2PQaskzHFD4iJKlNUhanPH9qPBzrspXZY91
	 baGS4Fj1wT/jhTrGgr7T1gMIx0J3gfqmR77tS6normc8sU1b6DqOcRfcJJ1YgxX9hb
	 OT5lNHfWt0gW3ayaKFpt/Pi55o0akAfLOAe+1s/I8SRbMktmNzMAKx+UwcCA264ZtM
	 snimwJfXoSB3HZeOoF5i+K2nfaLIteU4laOZv3YWc3kyo8xdD0g6i3XmkehtZMxa+U
	 Es/BMhvxtxpu3zTaohOPN1BTmL0Kh67iz83EfFLMYmRWG0r5WehR6lLFK3cG4Cbvgf
	 kTEwORPTf0lYg==
Subject: Re: [PATCH net 04/10] mptcp: fix use-after-free of the subflow
 context on the delegated list
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org, martineau@kernel.org,
 geliang@kernel.org, cpaasch@openai.com, fw@strlen.de, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, dcaratti@redhat.com, mason@kernel.org,
 stable@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, kafai@fb.com,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@kernel.org,
 bpf@vger.kernel.org
Date: Tue, 24 Nov 2026 14:26:51 +0000
Message-ID: <179553041150.3135.10012593386905502123@kernel.org>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-4-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-4-278042217e8d@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comment in the sock_owned_by_user() branch of
  mptcp_napi_poll() (net/mptcp/protocol.c) is now wrong for the case…

--

mptcp: fix use-after-free of the subflow context on the delegated list

This fixes a use-after-free. subflow_ulp_release() frees the subflow
context with kfree_rcu() while the context is still linked on the per-CPU
delegated napi list. A new MPTCP_DELEGATE_DEAD bit hands the free to
mptcp_napi_poll() when the subflow is scheduled, skips delegated actions
for dead contexts, and moves delegated_status out of struct_group(reset).

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 50c294d925b0c..23d35f43b566e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4803,10 +4803,13 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  	delegated = container_of(napi, struct mptcp_delegated_action, napi);
>  	while ((subflow = mptcp_subflow_delegated_next(delegated)) != NULL) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		long status;
>  
>  		bh_lock_sock_nested(ssk);
>  		if (!sock_owned_by_user(ssk)) {
> -			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
> +			status = xchg(&subflow->delegated_status, 0);
> +			if (!(status & BIT(MPTCP_DELEGATE_DEAD)))
> +				mptcp_subflow_process_delegated(ssk, status);
>  		} else {
>  			/* tcp_release_cb_override already processed
>  			 * the action or will do at next release_sock().
> @@ -4814,11 +4817,15 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  			 * CPU that scheduled it.
>  			 */
>  			smp_wmb();
> -			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
> +			status = set_mask_bits(&subflow->delegated_status,
> +					       BIT(MPTCP_DELEGATE_SCHEDULED), 0);

[Severity: Low]
This isn't a bug, but is the comment above this branch still accurate
once MPTCP_DELEGATE_DEAD is set?

The comment says tcp_release_cb_override "already processed the action or
will do at next release_sock()". However, every path that reaches
mptcp_subflow_free_ctx() runs after mptcp_subflow_ops_undo_override() has
restored ssk->sk_prot to plain tcp_prot/tcpv6_prot:

net/mptcp/subflow.c:subflow_ulp_release() {
    ...
	mptcp_subflow_ops_undo_override(ssk);
	if (release)
		mptcp_subflow_free_ctx(ctx);
}

mptcp_subflow_drop_ctx() reaches the same undo through
subflow_ulp_fallback(). __mptcp_close_ssk() only calls
mptcp_subflow_free_ctx() when icsk_ulp_ops is already NULL.

So for a dead context, the next release_sock() calls tcp_release_cb()
rather than tcp_release_cb_override(). Any pending action bits are dropped,
and the commit message says that is intended ("the pending actions must not
run").

A dead context can reach this branch. __mptcp_close_ssk() holds
lock_sock_nested(ssk) across this chain:

__tcp_close()->inet_csk_destroy_sock()->tcp_cleanup_ulp()->
    subflow_ulp_release()->mptcp_subflow_free_ctx()

That means a concurrent mptcp_napi_poll() can see sock_owned_by_user(ssk)
after DEAD has been set.

Could the comment be updated to say that dead contexts have their pending
actions discarded here? It could also mention that status is captured so
the context can be freed with kfree_rcu() after bh_unlock_sock() and
sock_put().

>  		}
>  		bh_unlock_sock(ssk);
>  		sock_put(ssk);
>  
> +		if (status & BIT(MPTCP_DELEGATE_DEAD))
> +			kfree_rcu(subflow, rcu);
> +
>  		if (++work_done == budget)
>  			return budget;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d%40kernel.org
