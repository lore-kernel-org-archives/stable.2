Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795824160;
	b=liy8mMXnyD1uwjwgqfHcPbqFJO2jWtXzYeeVdYNFaCG5PWfxZTFJ3QP8B+7iICPfqeZZ
	 GBWrWhRAD94HpjT8DeWoYFyw348bwiP56rBHFPi4PKlJ7cQtHZ1j2voKnc9bOe0Rcn6Jg
	 ZJZhoyrIXn3O1UODvRtIQx3rPK0dzEnGleRzxuUmeejVJl6RCemGt7xQI3pKj5yZNcDxi
	 n3ux7KSpEZZeYGRoA2iPXMfGqAk3vedcXc2Bi9EzsXAsMYyAlSdLqycLq+bGvcfjjJTy5
	 MHhgQMFt+aiEx/E+3SKhEr+hB02fh3hiBUkKZAu6V9rXKiMpwPPpF0RLiTh61zPR8GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795824160;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=4ZLS6a32u2SsroRYbtW4gJwlixCmphvsqZgeXv5FA2w=;
	b=R0wrQ0PwNFNj0IoUpXnR+T2CAztWrI8AbrG+2l50Jy+9wvudMASaQZOb3WevrwbJ+F6j
	 O01Ab2sxGtrdZwhSW1LUgAGmYkkbCg/XSdQ7IzdPb5hPbSLUt2bf/jP/3gJCnVXn0sJgn
	 ptsXZ+pEMGcCukFkGZznyIcGGTL849YTgeo2hy1DuI2nQFcIraDOU2EbyRXhqktXRJolx
	 TnL8oMH7PchcHn4v59oCXB6qDaj9H4lrPYVma1EhJV2rwMRYpcRqw5dx088CXryHSr9f0
	 TN6XArJfVpDdBUfVCWtiZQJmqd2ZfiKovzPy9HiqDtRL2ZYwa+m2eqYjC6APv/DudEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="YLK82nT/";
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB839606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 00:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB839606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YLK82nT/
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/suaZrbhY33p54vbc3ZqMcQPDilQeSKhEa+pO35DDfU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795824156; v=1; x=1796428956;
 b=YLK82nT/IFLWAuOOxJc81HEj+gAznVwamjVFg4M26Pnxme/0dcbUCOYPS0Tkt+AMGaLl9cwz
 sJJVzkvSwwdpuwdGAWz5N3upl8plku8594f3atr5KUj59KxXFbOLFDn/6YQAyAmx7gtT2z5YPzN
 hpcvIur9345SUFsjS/4tNySk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id caa90b19f0d4129a;
	Sat, 28 Nov 2026 00:02:36 +0000
X-Mizu-Trace-ID: caa90b19f0d4129a
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 28 Nov 2026 00:02:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <46df7273bf182ac9e1666c706d3f56d3af8d0b59@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v10 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
Cc: "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau"
 <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
 stable@vger.kernel.org
In-Reply-To: <20261127213756.4154872-2-w453y.me@gmail.com>
References: <20261127213756.4154872-1-w453y.me@gmail.com>
 <20261127213756.4154872-2-w453y.me@gmail.com>

November 28, 2026 at 5:37 AM, "Abdul Wasey" <w453y.me@gmail.com mailto:w4=
53y.me@gmail.com?to=3D%22Abdul%20Wasey%22%20%3Cw453y.me%40gmail.com%3E > =
wrote:


>=20
>=20With fullmesh endpoints, if the endpoint used by the initial subflow =
is
> removed and then added back, no new subflow is created from it: the
> connection never uses this local address again.
>=20
>=20The initial subflow is kept in the conn_list once closed. If it was
> still established when closed, it keeps the local ID 0, which is also
> the ID used by the re-added endpoint, and
> fill_remote_addresses_fullmesh() then marks its remote ID as
> unavailable. If it was already in TCP_CLOSE, e.g. after a reset, it is
> disconnected and its context is reset: the 'closing' flag and the remot=
e
> ID are cleared, and its destination port is zeroed. It is then picked a=
s
> a remote address, with the port 0 and the ID 0, which also marks the
> remote ID 0 as unavailable. In both cases, when the peer has a single
> address, all subflows use the remote ID 0, and no valid remote address
> is left.
>=20
>=20Skip the subflows being closed or in TCP_CLOSE state, both when looki=
ng
> for the remote IDs already in use and when picking the remote addresses=
.
> __mptcp_subflow_active() cannot be used here: subflows still being
> established have to keep their remote ID marked as in use, to avoid
> creating duplicated subflows.
>=20
>=20When no subflow is left to take the remote ID 0 address from, e.g. wh=
en
> the initial subflow was the only one, use fill_remote_addr(), as for
> non-fullmesh endpoints: it takes the remote address of the MPTCP socket=
.
> Before, re-adding the initial endpoint created no subflow in this case
> either, and another endpoint only worked by picking the closed initial
> subflow.
>=20
>=20Without the fullmesh flag, the remote address is taken from the MPTCP
> socket, so this issue is specific to fullmesh endpoints.
>=20
>=20Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
> ---
>  net/mptcp/pm_kernel.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
>=20diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 88610aed45a2..f1e1576fb375 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -199,6 +199,13 @@ fill_remote_addr(struct mptcp_sock *msk, struct mp=
tcp_addr_info *local,
>  return 1;
>  }
>=20=20
>=20+static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *su=
bflow)
> +{
> + struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> + return subflow->closing || inet_sk_state_load(ssk) =3D=3D TCP_CLOSE;
> +}
> +
>  static unsigned int
>  fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>  struct mptcp_addr_info *local,
> @@ -216,11 +223,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock =
*msk,
>  * already created by incoming ADD_ADDR
>  */
>  bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> - mptcp_for_each_subflow(msk, subflow)
> + mptcp_for_each_subflow(msk, subflow) {
> + if (mptcp_subflow_is_closed(subflow))
> + continue;
> +
>  if (READ_ONCE(subflow->local_id) =3D=3D local->id)
>  __set_bit(subflow->remote_id, unavail_id);
> + }
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
> + if (mptcp_subflow_is_closed(subflow))
> + continue;
> +
>  ssk =3D mptcp_subflow_tcp_sock(subflow);
>  mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>  addrs[i].id =3D READ_ONCE(subflow->remote_id);
> @@ -243,6 +257,11 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *=
msk,
>  break;
>  }
>=20=20

Hi=20Abdul,

Thanks for the new version.

Reviewed-by: Gang Yan <yangang@kylinos.cn>


> + /* If the initial subflow is closed, use fill_remote_addr */
> + if (!test_bit(0, unavail_id) && i < addrs_size &&
> + msk->pm.extra_subflows < limit_extra_subflows)
> + i +=3D fill_remote_addr(msk, local, &addrs[i]);
> +
>  return i;
>  }
>=20=20
>=20--=20
>=202.43.0
>
