Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908634;
	b=HGO/GjVDlrx1AIvlvlQ4ImCfznyBOo3tGGT1lqwO6r93nwGveHw0BmDrL1hjmhPz364e
	 68OSOG/8cfNqeBnJnPk4dZ67MIP8X6RigyC9yZ+Lgla1SJN8vJsjq0Yf1czuQI0EyEIan
	 +q396tf1S2NIIsFPK7Df6P7Sx5yU9VPaBBmZRmbH5qOpTwQjDikyegq3Ip15p3KOjUzdu
	 c67NbSPYXnOhPE1I3/cmD4tXesn/A71kxSOqWzB2EfeSNdaIv3PRP03AmhPomqL7chjH/
	 camm4KOFJFrCxYCL18xCelfyym51odVwXdnnAQ0MROXiJOCnNt+CgivZ2nGxKfgYLsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908634;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lj/H6ObV+NiCkgR1Za56Q0sbCpzNk/GAy356ZgMOwhs=;
	b=mSJdslcjBkjwxrodkhQwjXYkVNV1DqHzvOfAp3UPHbmEyBUwWLYLaG3FhkwJSrL4HYPZ
	 dQXZ5KZF1+l8y55BVT29i+wYA7LBoueOR7mri7IVDfjW2vk0T2/Q6w2/Od19V6mc1sNfh
	 tsXHgv8rjFVGpUrtZV/tlsqBAq+6JJ3oNqB6lcp1z8LOT6k7zBeIvGcq/1yjxgVjQ5C37
	 XjVuS0z8tvyKI3UE9GQC8wP1wG7QlDc3QHO4jTJJJy5ot+JFDmwkCh/XVqt3G1z4w5QXt
	 7J2Sifn/v7194AerDRGZMlw8q5NvZSajnpk4n5Rhh8UCQo3Eg4y1zzCsbuTxpksGVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2SGxfYE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AF606A330;
	Tue, 17 Nov 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2SGxfYE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52671F0181D;
	Tue, 17 Nov 2026 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908634;
	bh=lj/H6ObV+NiCkgR1Za56Q0sbCpzNk/GAy356ZgMOwhs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b2SGxfYEDMWwqaoLT/DMSAPcHCMLtUMRmGRwU0qTq7lYx2HkQQdrWIWozD9/d7X/D
	 rdeqw6ATESA/iJfR11weE/R5/hA378fwDxhVFg+di3tTSTBZ0TeQWD8jjWcTt9ZwZJ
	 Hugm5qyQix0ea2pP7/z0TCkLw0Y3NB9dpModUZVl3kHP7nc+YyYom3TgebPrivBPVm
	 FPiu7BQ7H9WkQL7WqWRZwZ6vKNw6CE7vmCyRQeU6LRhl6KyIyoI3Qv5wKhiKrpc5LU
	 IfCtQf6j/wbBewtiDeJsdMPbgDLGqcGPWQeujOUQEuOhWakQjYfpLgyhLfw+x+x0dg
	 jKoMLHTdc40+A==
Subject:
 Re: [PATCH net v4 2/3] net: mptcp: reject token 0 in mptcp_token_get_sock()
From: netdev-bot+sashiko@kernel.org
To: 2122295973@qq.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 09:43:53 +0000
Message-ID: <179490863332.3133.3484259413562043053@kernel.org>
In-Reply-To: <tencent_43D317CA682E96EDDF89E59E669052BF7E09@qq.com>
References: <tencent_43D317CA682E96EDDF89E59E669052BF7E09@qq.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch rests on the claim that a freshly allocated msk
  "holds [token 0] until it is hashed".

--

net: mptcp: reject token 0 in mptcp_token_get_sock()

This patch makes mptcp_token_get_sock() return NULL early for token 0.
The commit message says token 0 is what a torn down msk holds, and what a
freshly allocated msk holds until it is hashed. The goal is to stop an
MP_JOIN SYN carrying token 0 from matching a dying or half-initialised msk.

> Both validations in mptcp_token_get_sock() compare the socket's token
> with the requested one, so for a request for token 0 they cannot tell a
> match apart from a socket whose token has just been cleared.  With
> SLAB_TYPESAFE_BY_RCU the same is true for a socket whose memory has
> already been reused by a new msk that has not been hashed yet.

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 3429b43a9f7c3..8a603fc8dc059 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -299,6 +299,10 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
>  	struct mptcp_sock *msk;
>  	struct sock *sk;
>  
> +	/* Token 0 is never assigned, but is what a torn down socket holds. */
> +	if (!token)
> +		return NULL;
> +

[Severity: Medium]
The commit message says a freshly allocated msk holds token 0 "until it is
hashed". Does that hold for the passive MP_CAPABLE path?

In mptcp_sk_clone_init(), the real non-zero token is stored well before
the msk is linked into msk_chain:

net/mptcp/protocol.c:mptcp_sk_clone_init() {
    ...
	WRITE_ONCE(msk->token, subflow_req->token);
    ...
	mptcp_copy_inaddrs(nsk, ssk);

	mptcp_rcv_space_init(msk, ssk);
	msk->rcvq_space.time = mptcp_stamp();

	if (!mptcp_token_accept(subflow_req, msk)) {
    ...
}

Consider a reader in mptcp_token_get_sock() that holds a stale chain
pointer to an msk whose memory is being reused as this clone, and that is
looking up the same token T. It would see token == T, a refcount of 2
from sk_clone(), and a matching netns.

In that case both READ_ONCE(msk->token) != token checks pass and
refcount_inc_not_zero_acquire() succeeds. Nothing checks whether the
socket is hashed, so an unhashed msk that is still being built is
returned. The new !token check doesn't cover this case.

subflow_token_join_request() then uses that msk without holding its lock:

  subflow_check_req()
    subflow_token_join_request()
      mptcp_token_get_sock()
      mptcp_pm_get_local_id()
      mptcp_pm_is_backup()
      mptcp_pm_announced_has_ssk()   (different source port)
      subflow_req_create_thmac()

mptcp_pm_get_local_id() could read the listener's addresses copied by
sock_copy(), before mptcp_copy_inaddrs() runs. It could then return the
wrong local ID, or add an implicit endpoint that shouldn't exist.
subflow_req_create_thmac() could also run before the keys are set up.

The token store is a plain WRITE_ONCE() with no release ordering, and the
reader has no matching acquire. On weakly ordered CPUs, could
mptcp_pm_announced_has_ssk() see the new token but still see the
pm.anno_list and pm.lock contents copied from the listener?

If mptcp_token_accept() then fails, mptcp_sk_clone_destroy() tears the msk
down while the join request still holds its reference. Because
mptcp_token_destroy() returns early for unhashed sockets, the msk keeps
token T.

The third patch in this series ("net: mptcp: verify the token slot in
mptcp_token_iter_next()") does not touch mptcp_token_get_sock() or the
clone path, so this case is still open at the end of the series.

Would checking that the socket is hashed after taking the reference work
here? Another option is to publish msk->token under the bucket lock just
before hashing. Either would cover this case as well as the token 0
cases.

>  	rcu_read_lock();
>  	bucket = token_bucket(token);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_D0DCF4B132B20B70FB5AE2D9272AA4AEAF07%40qq.com
