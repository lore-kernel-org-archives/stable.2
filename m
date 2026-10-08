Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594AA4349A9
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492157; cv=none; b=Yv81qaVuAhr4UhFmTWvv2usSPtDQ+MSnK128IY10T7HaCxfxhx2jXgyzSfR5p8TW3Pf08zmC8B6jfzG/zBqh98/BQe8ybZOX5WdAMYDEkYfaOAonmLtU11ixuU1Xj3sr6IngYflUiTH64pf6LrTxgdeKy9tEEMCJ8LpvenVgEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492157; c=relaxed/simple;
	bh=WYpr4925VZXRrI69knrSKcGIWyAyT4mQF+e3oRblhME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVCTKqy9tnfpXO5YNOZmnqaku+x4YthbS0T9o8PwuSbdMo58StbGcHstJHYGeagzX/FwhZJPQvnC3q0UXra7UkOrZPiXcFMfpi37xQw43cptwnVaXQHgwaQeKL9RWL+sKnLIP4OoTsUuxo/G7Ji8aw2PnEzlJNiAx9AwtuwZr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJuLzplX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJuLzplX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E351F0089B
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791492155;
	bh=OTrZCl1R2bazCkFWANoRICAVyJ+fAbAnYgUAxErJyIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZJuLzplXmkk8ml+BvSPAQIe9H+P5TM7J9WoD7qx6g6OLZ4MsFKfoa/+ZLtckygTuA
	 VwBFN5hkzIy5nRz0pRDx6a4j6S2Gb60Ji2tTdH9cBw4Za2rlA5qQylzqs02LHA0xso
	 YgMFHIs+OW2a/9xpkAEY8Hd7m0jWVS3BClLpaezeeA2NWRFE+wDLC+2RA+7Go4j0Pt
	 mud19wmHPa8NRv2L1gcbEugsv1whqZfbzMC21cMP02fSpOUYFNXDswKL0rFBaks9u2
	 CBW8YQmelIjTcVvCOvGCaCpfBh6xaQ8FeD9300bU3R3WqU2or6uijzRS3LsTp8yQ0f
	 trH0HXQ0lrxDA==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8241a56cd70so2898013a34.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 13:42:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7TmEqe9p5TxrSinod8jDUURUqV3mAyqT/SvBtH7QRwZ59f4/W9ARRc8G6TJGuYONtJuF9ywE=@vger.kernel.org
X-Gm-Message-State: AFuF++kba6RjQ+ba/SjOhKiGx64/e/hDpM5BQxerbOSVIJbplww0CAmv
	si2Kx7LCueJ71+Hzklfy1M3ReYjvt68uTAhU/AifC9CrLaoxDdBUttGVlAmWXTQQNEmtQ5oKKSv
	i6xrv9UoWWU/BntqxAmiWqeFdCsUsDkM=
X-Received: by 2002:a05:6820:81d4:b0:6da:9dae:a3a with SMTP id
 006d021491bc7-6e7a5c98a30mr6242776eaf.24.1791492154056; Thu, 08 Oct 2026
 13:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008194824.52351-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20261008194824.52351-1-cenzhang@linux.microsoft.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 8 Oct 2026 22:42:23 +0200
X-Gmail-Original-Message-ID: <CAL4Wiir+CBGE=hXxHEBkyk0Au9B6G3=AdHFd5botrC-FF5BM5w@mail.gmail.com>
X-Gm-Features: AclHuK_e_aUOabmbbNDHGa00E2_4FQR5zN33HNWQmdpUgX2mU850BpYco2M8iCI
Message-ID: <CAL4Wiir+CBGE=hXxHEBkyk0Au9B6G3=AdHFd5botrC-FF5BM5w@mail.gmail.com>
Subject: Re: [PATCH net] netlink: do not copy to user space under netlink_lock_table()
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Kexin Sun <kexinsun@smail.nju.edu.cn>, 
	Enrico Pozzobon <enrico.pozzobon@dissecto.com>, Breno Leitao <leitao@debian.org>, 
	David Rheinsberg <david@readahead.eu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 8 oct. 2026 =C3=A0 21:48, Cen Zhang (Microsoft)
<cenzhang@linux.microsoft.com> a =C3=A9crit :
>
> netlink_getsockopt() handles NETLINK_LIST_MEMBERSHIPS by copying the
> socket's group bitmap to user space with copy_to_iter() under
> netlink_lock_table(). However, copy_to_iter() writes to a user address
> and can trigger a page fault, and how long that fault takes is up to the
> owner of the page. An unprivileged user can make it take as long as they
> want, e.g. by mapping a memfd page and keeping it hole punched from
> another thread. While the fault is pending, the caller still counts as a
> holder of nl_table_users.
>
> nl_table_users is one global counter shared by every netlink protocol
> and every network namespace, and netlink_table_grab() waits for it to
> drop to zero in TASK_UNINTERRUPTIBLE with no timeout and no signal
> check. Therefore, by holding one page fault open, an unprivileged user
> blocks every task on the machine that needs netlink_table_grab(): e.g.,
> close of a netlink socket, multicast group join, and network namespace
> creation. The blocked tasks stay in an unkillable D state until the
> attacker lets the fault finish, and hung task detector reports is as
> following:
>
>   INFO: task V1-nl-close:103 blocked for more than 122 seconds.
>   task:V1-nl-close     state:D stack:14448 pid:103 ...
>   Call Trace:
>    schedule+0x36/0xf0
>    netlink_table_grab.part.0+0x66/0xe0
>    netlink_release+0x6d4/0x780
>    __x64_sys_close+0x38/0x80
>
> Fix this by taking a kmemdup() snapshot of the bitmap under
> netlink_lock_table() and copying the snapshot to user space after the
> lock is released.
>
> Fixes: 47191d65b647 ("netlink: fix locking around NETLINK_LIST_MEMBERSHIP=
S")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> ---

This is certainly not a net candidate. I call this AI hallucination.

This is not specific to netlink_lock_table().

We have many places where copy_{from,to}_user() runs while a mutex or
a socket lock is held, and some of these locks are global.

One example among many: do_ip_getsockopt() handles IP_MSFILTER with
copy_from_sockptr(), then copy_to_sockptr() in ip_mc_msfget(), all of
it under rtnl_lock(). No privilege needed.

Even in af_netlink.c, your patch does not close the issue you describe:
netlink_bind() calls netlink_insert() under netlink_lock_table(), and
netlink_insert() starts with lock_sock(sk). Another thread can hold
that socket lock across a user copy, e.g. setsockopt(SO_ATTACH_FILTER),
where __get_filter() calls copy_from_user() under sockopt_lock_sock().

So if "user controlled page fault while holding a lock others wait on"
is the bug, a real fix is probably hundreds of patches all over the
tree, not this one.

I do not think we want to do this one call site at a time, and
certainly not as fixes for net and stable.

What is the plan here?
