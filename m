Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B638F656
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929790; cv=none; b=ea1J/wA7ouyWcN4L4u6tt48U2xFIIhTrU7HSQN0mvootF8d3+88uk8Q8eV9zVymOpg8aUU4GhaltgtXyBeewl1gUYMVkoIggR9dvfC+A3/g/sIFjbFMQoGzaYUo6+B8PTHi75Zf4ShcANF9Y0X8dOqx+u6DSGkOVoAOvyr/fdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929790; c=relaxed/simple;
	bh=LiJGqnwA2nbNfc/ScFgDdE5J0y9Mr9eTfs65O0ZeCeg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=RDMVLEbyQ2AlLuNgCNT+UrNP9nLXXYURpv0QxumfpyU2uAhi9Rlrgx7lLEehaCvfaldEdZHkcTHGSBnNAjRavWjFTzInLSeiOKCwQemABDpBEn0nvDpm2k0ragaaSOTnL6SR7NWw8TI4mKSWJLnTpkCBpW9Pxe75Ey1LzAzkRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EIysrxJO; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EIysrxJO"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783929785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgeUVtJCXB/fFNNUy6l/+1m+eDcFVxzQ02OOwPJpQkw=;
	b=EIysrxJOe6ThpSVo+Ge8JmLtPikqhrs2yQN1e81Wcz8tNJB7aK7V5CXYqYplzMQVVS4b7u
	f0I0K08XtfD//J25dY+ua/ETIWxT7VGLZp2QTDsZ+H7gxpa+d/ANTri4L8hWy6Iw4Gq4Sj
	Y46p11FQ9wqcIuB3+RT0zmgqnOaEVDk=
Date: Mon, 13 Jul 2026 08:03:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <b3c317fda3d8d3efa349933723e549933ffc0bf2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] mptcp: pm: fix use-after-free in
 userspace_pm_get_local_id()
To: xuanqiang.luo@linux.dev, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, "Xuanqiang
 Luo" <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
In-Reply-To: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
References: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
X-Migadu-Flow: FLOW_OUT

July 13, 2026 at 3:47 PM, xuanqiang.luo@linux.dev mailto:xuanqiang.luo@li=
nux.dev  wrote:


Hi xuanqiang,

Thanks for the patch.

But AFAIK, geliang has fixed this in [1], and your test verified this iss=
ues.

@Matt, it seems that [1](geliang's patch) can be merged.

[1]https://patchwork.kernel.org/project/mptcp/patch/4e50adfde3b80f433e13b=
86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn/

Thanks
Gang

>=20
>=20From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
>=20mptcp_userspace_pm_get_local_id() looks up an address entry with
> pm.lock held, but drops the lock before reading its ID. A concurrent
> subflow destroy command can remove and free the entry in between,
> resulting in a use-after-free while processing an MP_JOIN SYN.
>=20
>=20Read the ID while holding pm.lock, then use the copied value after
> unlocking.
>=20
>=20Fixes: f012d796a6de ("mptcp: check addrs list in userspace_pm_get_loc=
al_id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> The race window is narrow. It was reproduced only with a locally
> constructed stress test that repeatedly overlaps an MP_JOIN SYN with a
> MPTCP_PM_CMD_SUBFLOW_DESTROY request.
>=20
>=20However, the KASAN report below confirms that the race is reachable:
>=20
>=20[ 666.319362] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 666.319376] BUG: KASAN: slab-use-after-free in mptcp_userspace_pm_get=
_local_id+0x1dc/0x1f0
> [ 666.319386] Read of size 1 at addr ffff888124845610 by task swapper/0=
/0
> ...
> [ 666.319401] Call Trace:
> [ 666.319405] <IRQ>
> [ 666.319408] dump_stack_lvl+0x53/0x70
> [ 666.319412] print_address_description.constprop.0+0x2c/0x3b0
> [ 666.319418] print_report+0xbe/0x2b0
> [ 666.319421] ? mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
> [ 666.319423] kasan_report+0xce/0x100
> [ 666.319426] ? mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
> [ 666.319429] mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
> [ 666.319433] mptcp_pm_get_local_id+0x371/0x440
> ...
> [ 666.319821] Allocated by task 45539:
> [ 666.319844] kasan_save_stack+0x33/0x60
> [ 666.319855] kasan_save_track+0x14/0x30
> [ 666.319858] __kasan_kmalloc+0x8f/0xa0
> [ 666.319863] __kmalloc_noprof+0x1e7/0x520
> [ 666.319867] sock_kmalloc+0xdf/0x130
> [ 666.319885] sock_kmemdup+0x1b/0x40
> [ 666.319888] mptcp_userspace_pm_append_new_local_addr+0x261/0x500
> [ 666.319910] mptcp_pm_nl_announce_doit+0x16a/0x610
> ...
> [ 666.319967] Freed by task 45560:
> [ 666.319988] kasan_save_stack+0x33/0x60
> [ 666.319991] kasan_save_track+0x14/0x30
> [ 666.319994] kasan_save_free_info+0x3b/0x60
> [ 666.319998] __kasan_slab_free+0x43/0x70
> [ 666.320000] kfree+0x166/0x440
> [ 666.320003] sock_kfree_s+0x1d/0x50
> [ 666.320007] mptcp_userspace_pm_delete_local_addr.isra.0+0x157/0x200
> [ 666.320011] mptcp_pm_nl_subflow_destroy_doit+0x51d/0xea0
>=20
>=20 net/mptcp/pm_userspace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d100867e9202f..27fa8dc757b4f 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -132,12 +132,15 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_=
sock *msk,
>  __be16 msk_sport =3D ((struct inet_sock *)
>  inet_sk((struct sock *)msk))->inet_sport;
>  struct mptcp_pm_addr_entry *entry;
> + int id =3D -1;
>=20=20
>=20 spin_lock_bh(&msk->pm.lock);
>  entry =3D mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
> - spin_unlock_bh(&msk->pm.lock);
>  if (entry)
> - return entry->addr.id;
> + id =3D entry->addr.id;
> + spin_unlock_bh(&msk->pm.lock);
> + if (id >=3D 0)
> + return id;
>=20=20
>=20 if (skc->addr.port =3D=3D msk_sport)
>  skc->addr.port =3D 0;
> --=20
>=202.43.0
>
