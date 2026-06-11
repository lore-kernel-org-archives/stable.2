Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00A2512C8
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189681; cv=none; b=M72b9/AGRQ3DJOW0E/htq33zMjU7qTT6zCf02MAYWBE2jbpnGrPUthXZ0koSocxiElmXahJswJZqbE9DiXAgg7l08chLm/x+eUUKi3d1UD9rgh66TGwBdsF914Aeqtl1rZyzt64ouzXKcSenAxemA8rM6kT3WEdBpG6H5o9xtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189681; c=relaxed/simple;
	bh=i9goQK+PfYxDMzpCTFRX9PHYViJz9NrGz6efZpUIYp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpK3ZOBV/b85D7am1Tz2Tt9/2ESntzaBUAMF4WlRzXnAvNeNfeKcqlPdGV8ypsBzs65RYd8UYoRge57gxTOIin8Tvem0MfCs9+u7/LWpdSW6Ep7JswW83XorFmZJIU0RYFzf6FtW2uFoPhwqxErpFr8OtRYCilqgYiLB5xX5Xf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XW54+iVu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XW54+iVu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=L7V10b80aH2eAPlxp6gsdj3fgz/Fgp1to3s7xDTV0x0=; b=XW54+iVublKhNpEzF1YWUiUMyw
	Cq2XoLLaCfEBTWihUWiE5efWodqtb437avV+hx/WWyMLE7b6NcEomzOqwlDSeW23wt0osIC79wCDt
	fKiNoab6q2tasjw8kcVmjBbGAzJ13xZMZup/UhRsqTdbqejm/DudlUtS1I99Zck4q8qrxrDnpUQmO
	blSh74DGqa2bhbzoh4L9HkfLy6/LfQJir9qe+HigrQckXPaDBAi3PuJJNRMKGnkAgMAgZkr9LTyEj
	Zwdq3U+BvwdGcZf0loLFt88lCZuh/k0K/mBjRq7rBoh2glCkdSgRbPDX07hQ6TxOe3gkIgthnfy0n
	oWADHfXQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
 syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Jakub Kicinski <kuba@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 6.12.y] wireguard: device: use exit_rtnl callback instead of
 manual rtnl_lock in pre_exit
Date: Thu, 11 Jun 2026 16:54:37 +0200
Message-ID: <2278549.Icojqenx9y@diego>
In-Reply-To: <20260611144615.478035-1-heiko@sntech.de>
References: <20260611144615.478035-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi all,

Am Donnerstag, 11. Juni 2026, 16:46:15 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Heiko Stuebner:
> From: Shardul Bankar <shardul.b@mpiricsoftware.com>
>=20
> [ Upstream commit 60a25ef8dacb3566b1a8c4de00572a498e2a3bf9 ]
>=20
> wg_netns_pre_exit() manually acquires rtnl_lock() inside the
> pernet .pre_exit callback.  This causes a hung task when another
> thread holds rtnl_mutex - the cleanup_net workqueue (or the
> setup_net failure rollback path) blocks indefinitely in
> wg_netns_pre_exit() waiting to acquire the lock.
>=20
> Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
> Add ->exit_rtnl() hook to struct pernet_operations."), where the
> framework already holds RTNL and batches all callbacks under a
> single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
> window.
>=20
> The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
> from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
> because all RCU readers of creating_net either use maybe_get_net()
> - which returns NULL for a dying namespace with zero refcount - or
> access net->user_ns which remains valid throughout the entire
> ops_undo_list sequence.
>=20
> Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3Dcb64c22a492202ca929e18262f=
db8cb89e635c70
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> [ Jason: added __net_exit and __read_mostly annotations that were missing=
=2E ]
> Fixes: 900575aa33a3 ("wireguard: device: avoid circular netns references")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Link: https://patch.msgid.link/20260414153944.2742252-5-Jason@zx2c4.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

sorry about the mail-noise, but I messed up sending this :-(
Will re-try once I fixed my mistake.

Heiko



