Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F71F91F6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786327175; cv=none; b=VuWnG0bb6k1jLff/pHCpk90nfWUQc6bSVf2Rn2Xk+jXZMT6SF3vqBIjenLYhP92HdCPyue5hl7YFv2G51uat+6MgxbMgpaS/nhCNkW//lUkZDFvxj13nSCVqTqK+BGoWPA28Lrf3vboEB+yU9Rno/Whi8GCivC5YQwpCRkMNOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786327175; c=relaxed/simple;
	bh=/OvbaL8KTP3ySpTWRBsx162Pho9Kv/QSjRAlqlRYHdU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ejr1Q9jkdx32FugTXmXZYMBOvJfP+jWm3qnVQ3cetKLNfdKyRGHFdy5i9wUaVA8HgeuHyJqkdp6+fNo0I90k+98W+ZG4kjr2zOvOcJtKwpDf6PvoqAir+a3f5q2UZuv+Dwsi9z2KYPc5q3TIa1sheM2s4pCkKF51o0i2HzOouSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LU5JD8n9; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LU5JD8n9"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786327171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhKBG07NgjbV88z5PyXBU/EsEEP+BqBeiN00w24gQvQ=;
	b=LU5JD8n994QqhU8jAs0wc13L36UNwvy80gs6mWrOrmD3h/ZwPh6UICoSJXn0dqF/7vq2u0
	C38yml6cmr74UMU0QWTDyhYs0Vh0Vo5N0y3v+jxXjmBf1ffNDZ+i1XwJVd10b9LEkt4lIp
	BUhpnzwrlv1Y0Krtd1etQ5OAlNLtO0k=
Date: Mon, 10 Aug 2026 01:59:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <4e57509daf45aa8968140e7a7279ad0699249bf6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net] mptcp: upgrade network refcount before socket lock
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>, "Matthieu Baerts"
 <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>
Cc: "Geliang Tang" <geliang@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 runyu.xiao@seu.edu.cn, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
In-Reply-To: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
References: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
X-Migadu-Flow: FLOW_OUT

August 9, 2026 at 5:19 PM, "Runyu Xiao" <runyu.xiao@seu.edu.cn mailto:run=
yu.xiao@seu.edu.cn?to=3D%22Runyu%20Xiao%22%20%3Crunyu.xiao%40seu.edu.cn%3=
E > wrote:

Hi,

Thanks for your patch.

>=20
>=20sk_net_refcnt_upgrade() calls get_net_track() with GFP_KERNEL and can=
 enter
> direct reclaim. Calling it while holding the newly created subflow sock=
et
> lock can create a reclaim-to-socket-lock dependency cycle.
>=20
>=20Upgrade the network reference before taking the socket lock. The sock=
et is
> newly created and has not been exposed to other code at this point, so =
the
> fields changed by sk_net_refcnt_upgrade() are not accessed concurrently=
.
> The error path still releases the socket normally after the upgrade.
>=20
>=20The PatchProof static-analysis tool detected a GFP_KERNEL allocation =
while
> the socket lock is held. Manual source review of v7.1.5 and current
> mainline confirmed the lock and allocation ordering.
>=20
>=20A source-level check found `sk_net_refcnt_upgrade()` after
> `lock_sock_nested()` in the original function and before it after this
> change. A POSIX-thread lock-order model made the reclaim lock unavailab=
le
> while the socket lock was held, observed `EBUSY` for the reclaim lock, =
and
> then completed with the reclaim-first order. The model checks the order=
ing
> invariant only; it does not execute the kernel MPTCP path. No live lock=
dep
> MPTCP test or reclaim fault injection was run.
>=20

Maybe=20the commit message seems too long. Could you please send a v2 wit=
h a more
concise commit message? For your reference, here is a suggested simplifie=
d version:

'''
sk_net_refcnt_upgrade() performs a GFP_KERNEL allocation (via get_net_tra=
ck()
=E2=86=92 ref_tracker_alloc()), which can enter direct reclaim and establ=
ish a
socket_lock =E2=86=92 fs_reclaim dependency. Move it before lock_sock_nes=
ted(), mirroring
the convention documented in net/rds/tcp.c:rds_tcp_tune().=20

The=20socket is freshly created and unpublished at this point, so sk_net_=
refcnt/
ns_tracker are not touched by any concurrent path; the error path still r=
eleases
via sock_release() which handles both refcounted and non-refcounted track=
ers.
'''

Please note that this suggested text is generated by AI, so please review=
 it
carefully before adopting it. Also, the next patch can only be sent to mp=
tcp@lists.linux.dev,
no need to cc to others.


> Fixes: 1d2f3d3c6268 ("mptcp: adjust to use netns refcount tracker")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/mptcp/subflow.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
>=20diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e1f20ff8fdb4..a9f951cc6a0e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1786,6 +1786,12 @@ int mptcp_subflow_create_socket(struct sock *sk,=
 unsigned short family,
>  if (err)
>  return err;
>=20=20
>=20+ /* kernel sockets do not by default acquire net ref, but TCP timer
> + * needs it.
> + * Update ns_tracker to current stack trace and refcounted tracker.
> + */
> + sk_net_refcnt_upgrade(sf->sk);
> +
>  lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
>=20
>=20 err =3D security_mptcp_add_subflow(sk, sf->sk);
> @@ -1795,11 +1801,6 @@ int mptcp_subflow_create_socket(struct sock *sk,=
 unsigned short family,
>  /* the newly created socket has to be in the same cgroup as its parent=
 */
>  mptcp_attach_cgroup(sk, sf->sk);
>=20=20
>=20- /* kernel sockets do not by default acquire net ref, but TCP timer
> - * needs it.
> - * Update ns_tracker to current stack trace and refcounted tracker.
> - */
> - sk_net_refcnt_upgrade(sf->sk);
>  err =3D tcp_set_ulp(sf->sk, "mptcp");
>  if (err)
>  goto err_free;

LKGM!
You can add 'Acked-by: Gang Yan <gang.yan@linux.dev>' in your next patch.

Thanks
Gang

> --=20
>=202.34.1
>
