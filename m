Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731580;
	b=M7Ym4b579K4GCgqmgNOGBQLlK/AVt+R4zqOeM+4monOeObz5k3+QKylosXzxl++/zTgb
	 XzkRZUtg+l2M/hDpdcZpkmxgCOtBglAmY/IM0l97/ov/Dy9PPnsfh/lOe5YdMquhoYr9S
	 s/krDxdQHP+1nfkxpQUkkJoUTE6gwzcO9hCrRlAAeuBXWq+CqsTZAzVLWuLHEgD4KF5XF
	 4dyBL1Sl5HR7juFNi5NpBV9I0F5bHFGcN86Zlgxs4G/RK7q3+mVCVWyzYJdQHdVt/xS+i
	 EWYs1mpqxMNDvAJN/zkoW6SS8+DwgPB9cEoudN+YULUlht2VYaUaviqYdFn1l0oKUDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731580;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=78fWkS2YWTJb7t6FsSnWQIR2C3mUObK3JQjnGJfkMvk=;
	b=MLpP1UJAzsm7pBt2ms22uxJjM3Dc7dg0fr9lnW9PZeqwANcp6GovkG0S2IZeqoFqVFRT
	 2ym54AnvKz4YYu2VqXk/naV7obA9oqfHoziAK0xZusxl8kxsXY7z83lQaA1tkRuGExgiP
	 QRhYv51PLY4k03mKPY/bOoQ9lO3F28oXkQIJqfW29NqTfkQGYfc/erNksyY5TmXbWzVhH
	 Q52xeLobQervjXF5KMQhbN+jhNwVpMIU4IAwDVoRUIPNtTNOfwgTa9XKr1XIntVtl6bTx
	 w/1HbRkC5OcV+VMF+6oD979BdguYYSLndLGAzTKeXDSdUHhY0pczmeEE8PM9bD4JPyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIYaOhvH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488C606A335;
	Thu, 26 Nov 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIYaOhvH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69931F0092B;
	Thu, 26 Nov 2026 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731579;
	bh=78fWkS2YWTJb7t6FsSnWQIR2C3mUObK3JQjnGJfkMvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SIYaOhvHubijw0//5Ald1UPP9Da3ycPrlm2agZYi21s4nFc0BE/ur1u70D2ASGZIc
	 A23RjMqpX1rsBR+2L7sHx0KAimGidZZvqeTbwldK53qZUk6d8ieTRx3VQRiXhMSdBu
	 tHDBal2n6L0e1XJ59ZvwT6rNN/y7H6YPKLrYxL+6Gr+BASuRulu5No1o4KsBX+mrBd
	 JA/dr9mZoYtqihELA9tbr1z4k5pewQlqpNaU2VVxP+hZOGLbVUM3snwjkeFXlKaDse
	 aS52ZVxQsEtpDmZclS18FpwabGOi1AULw3XWKwP6N8idY78sw6xKiDrQ1XOdY+PiQ/
	 dxjJvKcRYrorg==
Subject: Re: [PATCH net] nfp: fix use-after-free in nfp_ccm_mbox_skb_return()
From: netdev-bot+sashiko@kernel.org
To: elkin@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org, horms@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, irogers@google.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 22:19:38 +0000
Message-ID: <179573157826.3135.7446124224703168884@kernel.org>
In-Reply-To: <20261125221658.1420387-1-elkin@google.com>
References: <20261125221658.1420387-1-elkin@google.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch is incomplete.

--

nfp: fix use-after-free in nfp_ccm_mbox_skb_return()

This commit changes nfp_ccm_mbox_skb_return() to save cb->err in a local
variable before the skb is freed. Before the change, cb->err was read
from skb->cb after dev_kfree_skb_any() had already run.

> diff --git a/drivers/net/ethernet/netronome/nfp/ccm_mbox.c b/drivers/net/ethernet/netronome/nfp/ccm_mbox.c
> index aa8aba4ff7aac..c0f1d84208a41 100644
> --- a/drivers/net/ethernet/netronome/nfp/ccm_mbox.c
> +++ b/drivers/net/ethernet/netronome/nfp/ccm_mbox.c
> @@ -420,10 +420,11 @@ static void nfp_ccm_mbox_run_queue_unlock(struct nfp_net *nn)
>  static int nfp_ccm_mbox_skb_return(struct sk_buff *skb)
>  {
>  	struct nfp_ccm_mbox_cmsg_cb *cb = (void *)skb->cb;
> +	int err = cb->err;
>
> -	if (cb->err)
> +	if (err)
>  		dev_kfree_skb_any(skb);
> -	return cb->err;
> +	return err;
>  }

[Severity: Critical]
Is this fix complete? This change makes a non-zero return from
nfp_ccm_mbox_skb_return() mean the skb has already been freed. One
caller still frees the skb again after that return.

The in-progress branch of nfp_ccm_mbox_unlink_unlock() passes the
helper's result straight back:

drivers/net/ethernet/netronome/nfp/ccm_mbox.c:nfp_ccm_mbox_unlink_unlock() {
    ...
	if (nfp_ccm_mbox_in_progress(skb)) {
		spin_unlock_bh(&nn->mbox_cmsg.queue.lock);

		wait_event(nn->mbox_cmsg.wq, nfp_ccm_mbox_done(skb));
		smp_rmb(); /* pairs with smp_wmb() after data is written */
		return nfp_ccm_mbox_skb_return(skb);
	}
    ...
	return -ETIMEDOUT;
}

__nfp_ccm_mbox_communicate() treats every non-zero return as "the caller
still owns the skb":

drivers/net/ethernet/netronome/nfp/ccm_mbox.c:__nfp_ccm_mbox_communicate() {
    ...
			err = nfp_ccm_mbox_unlink_unlock(nn, skb, type);
			if (err)
				goto err_free_skb;
			return 0;
    ...
err_free_skb:
	dev_kfree_skb_any(skb);
	return err;
}

Only the -ETIMEDOUT branch, which unlinks the skb without freeing it,
matches what the caller expects.

Here is one sequence that seems to reach the double free:

1. A thread that is not first in the queue waits in
   wait_event_timeout() with NFP_CCM_TIMEOUT.

2. Another thread's nfp_ccm_mbox_run_queue_unlock() adds that skb to
   its batch and marks it busy with nfp_ccm_mbox_set_busy().

3. The waiter times out before the skb is done. It is still not first,
   so it calls nfp_ccm_mbox_unlink_unlock(). nfp_ccm_mbox_in_progress()
   is true, so it waits for done.

4. The batch fails in one of two ways:

   - nfp_net_mbox_reconfig() fails and nfp_ccm_mbox_mark_all_err() sets
     -EIO.
   - nfp_ccm_mbox_copy_out() sets cb->err to -EIO or -ENOENT.

5. nfp_ccm_mbox_skb_return() frees the skb and returns the error.

6. __nfp_ccm_mbox_communicate() jumps to err_free_skb and calls
   dev_kfree_skb_any() on the same skb a second time.

The commit message says this fixes the free-then-use of the skb around
nfp_ccm_mbox_skb_return(), but that path is still reachable here.

Should the skb be freed in exactly one place? Either the in-progress
branch could leave the skb alone, or the caller could return the error
directly instead of going to err_free_skb.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125221658.1420387-1-elkin%40google.com
