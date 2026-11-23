Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438135;
	b=EZ5jreZFIdqoJCiZ4WAImpeQWDrA3BKTqzGnjCCfyfqlhEoM7PlXJYXPZbJsJCIfjACD
	 59CNy84NGabvDEydYq7sKN7dmPwt72qQuRy7+Rvb9OstdQ2ENc0N2kEGI+odX6IqmU/Ij
	 hM6fwN8jgiNYyGKeJISi7lp59MbwiqhzlGP/CZflrKa/8jZ7nCD1X8KInjT4/TqjRmjEW
	 ndyrQhkNO05qwI4pLcLXmdu+7DukHi66Jv4WBvSXr3wDSkC/QWvNzPOuVuqYG0aaTMIVG
	 xfXV+1YRdY/8IuoyxBBWsae04/G7FKluIRfsZRGQcIdODwK/9FFobLzgH/ZAZHCNDBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438135;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yI2Wo78/lAboL4lqhYNXgiMMUATpxcgIbU7d5ySHTsM=;
	b=tDzsCzKyR2euU20ManvBRvUjYmTnwdkszjLGHqcw6JtHjNNK7FyHVfOY1lncakyEwFWh
	 dv6uudFkhjdIKqNkUY2/UJKI2L6dAQ+qCW/tebMGCrMYnBYfujKebAuC0jg9OOmJhZTDh
	 BRS3o5c+977Cb3wP8wVRACN30DhK8f+EXayeMFd8MuVigDURw7g41pWXYnXI1aOJSrVcB
	 OiZsZIBBa0nmHFnkExpfWbkzIPr1bG2sHaKcyxiH8Lq6p5rlItth/ViV/flpqq9U4gu6J
	 wRwxLC62JYJKFhAnlqoL8OvphHJ8RgeuhjNV+TnHySehkmezTKW5UJ+5K+rIobSJ8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nilGTLgC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA6606A31A;
	Mon, 23 Nov 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nilGTLgC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C4D1F000D0;
	Mon, 23 Nov 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438135;
	bh=yI2Wo78/lAboL4lqhYNXgiMMUATpxcgIbU7d5ySHTsM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nilGTLgC5K9CC6eh63Q0pR7rGHQfz6Pjl3M2IuE6LL6EKvJStnDSSHvavsd5JP3ip
	 AqEu1ZMc2cbdH34sZnguZeHE9WfwW0jJvWHLv20K/2w7BigtbyoFbcdYMpBEebNscM
	 wwAtuLm5mBFjX39eX4myW4HlkRrLqQk1Zwva8ZU8zl4geMZ7ocf83d1IjgAtxo+Uz0
	 ZylFfG8IdUXhShpMDqangaE49FOVy8YxlNOhxnNgjU01NznZ9x2btjqQPugeYkhQVO
	 9Cns9kWwFkfX9PfSOl4waywvScWLXVke/iWMbe3221BzJdjMOzMhyAptTU7goZ3Bsd
	 Ae+aixnb7+E4w==
Subject: Re: [PATCH net v2] net/sched: act_ife: return -EAGAIN after dropping
 rtnl_lock in load_metaops_and_vet()
From: netdev-bot+sashiko@kernel.org
To: fadouse@pm.me
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 23 Nov 2026 12:48:54 +0000
Message-ID: <179543813406.3135.15745616872300382040@kernel.org>
In-Reply-To: <20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me>
References: <20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me>
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

- [High] This patch does not fully close the use-after-free it claims to
  fix for cls_u32, one of the classifiers named in the commit message.

--

net/sched: act_ife: return -EAGAIN after dropping rtnl_lock in load_metaops_and_vet()

This patch changes load_metaops_and_vet() so that it returns -EAGAIN when
it has dropped rtnl_lock() to autoload an IFE metadata module and the
module then loads. The caller is then expected to replay the request under
a fresh RTNL critical section. The goal is to close a use-after-free in
RTNL-locked classifiers that hold unrefcounted pointers across
tcf_exts_validate().

> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 5a527da005661..5d6ca124e0047 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -275,6 +275,14 @@ static int load_metaops_and_vet(u32 metaid, void *val, int len, bool rtnl_held)
>  		if (rtnl_held)
>  			rtnl_lock();
>  		ops = find_ife_oplist(metaid);
> +		if (ops && rtnl_held) {
> +			/* We dropped the RTNL mutex in order to perform the
> +			 * module load. Tell the caller to replay the request
> +			 * under a fresh RTNL critical section.
> +			 */
> +			module_put(ops->owner);
> +			return -EAGAIN;
> +		}
>  #endif
>  	}

[Severity: High]
Does this fully close the race for cls_u32? The commit message lists it as
one of the affected classifiers.

RTNL is still dropped around request_module(). The new -EAGAIN, and the
existing -ENOENT when the module does not load, both go back through the
classifier's error unwind before tc_new_tfilter() gets a chance to replay.

On the new-key path, u32_change() looks up a hash table pointer without
taking a reference. It then reserves a handle in that table and calls
u32_set_parms():

net/sched/cls_u32.c:u32_change() {
    ...
			ht = u32_lookup_ht(tp->data, TC_U32_HTID(htid));
    ...
		handle = gen_new_kid(ht, htid, &err);
    ...
	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE],
			    flags, n->flags, extack);
    ...
}

u32_set_parms() reaches the RTNL drop like this:

u32_set_parms()
  tcf_exts_validate_ex()
    tcf_action_init()
      tcf_ife_init()
        load_metalist()
          load_metaops_and_vet()

While RTNL is dropped, a concurrent RTM_DELTFILTER for that non-root hash
table can run u32_delete(). The pending knode is not linked yet and holds
no reference on ht, so the delete succeeds:

net/sched/cls_u32.c:u32_delete() {
    ...
	if (refcount_dec_if_one(&ht->refcnt)) {
		u32_destroy_hnode(tp, ht, extack);
    ...
}

u32_destroy_hnode() then calls idr_destroy(&ht->handle_idr) and
kfree_rcu(ht, rcu). request_module() sleeps while it waits for modprobe,
so a grace period can pass and ht can be freed.

When load_metaops_and_vet() then returns -EAGAIN, u32_change() unwinds to:

erridr:
	idr_remove(&ht->handle_idr, handle);
	return err;

Would this read and write the freed tc_u_hnode before tc_new_tfilter()
ever sees -EAGAIN?

The patch removes the success-path access to the freed table, which is the
ins = &ht->ht[TC_U32_HASH(handle)] lookup and the list insert. The stale
ht is still used on the error path, though.

tc_action_load_ops() also drops RTNL and returns -EAGAIN, so the same
unwind looks reachable through it too. Copying that pattern into act_ife
may therefore not be enough to protect cls_u32.

Could u32_change() hold a reference on ht across u32_set_parms() and drop
it on all exits? Alternatively, could this path avoid dropping RTNL at all?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928%40pm.me
