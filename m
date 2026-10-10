Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FFF1D9663
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620774; cv=none; b=qQQQjPebchZTwsWzHsjIeS9Qd+2QgssZJmNWRhunm8muwYmh4P1iGxht2oitA9wmu9qHy6jfJgV48w0Nj6Ys6oypnpFJpecT6JD8AOkDcB/mKQT8WMFGyzvFChVpgmtBSOF9v6sPDwbUWOhWWdpGL2lQ/fe+msxSP156JqAd1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620774; c=relaxed/simple;
	bh=vi5jpLGy+JwHOFQXGt9InSXMZQ//fuL1+427dpdSnQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oC4uH2RAcNWc6iJFoaZ8oDL52C5tDcFY6iT4yUatVT53s7Z1IS5fyllX5bOrNjCAUFbW3lkkOxwOxy71Nkhum5m11JTNKlpctSMo1uPfODUO2aE6qpXF2Be02LUJ1TYxkZowX8esVXz+Jg/1dy9JZTVzvMom/xUDHPshlQ1I82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2HOMi88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2HOMi88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D171F0089B
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620773;
	bh=OH4d1I58KRGiSRV9Dj+44ocHv/O2DZTJh8ELdSAq85k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g2HOMi88/qygg7slQTfltPgS/6rezeYPMPPffhcUgKaWhorTBPERjVpt5UtG4npBg
	 7urZh2sc7dQIFl6AEwkelipTOYpBNPNhJz6agTRB8aW8TtP5xDv5/JE3+HTydI/WOo
	 AI9YW3EJQszt7BwQeoF/O8pU4sFRJrrXVDNFlko3H85myTE8JC/3CvZObUXSBn0T5x
	 AYyckvY7qUosfyXjFjH+83o0oUdpvNOtvVTn8dorAkRFh/RRZcgT5RL2kVtSvZZ+4W
	 j4reE9Nm4CTlIBfa0FSzmpQs0L7xa4mdaTpJTX9YPxXz3gujK5dr0ve9AwNH5jjQZn
	 sJkIn356J7CBw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82380b0f55dso252115a34.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:26:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYWOyB2Lf7IaY4r+Zpjx8tA7kUKWIoN4PMCpAQ0kZ+ifR7eysW8w9LrK5eCw9xlqoyK2WwPHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4LdswlT4DXNhro5JAyluEjHGWcAxKNgg1E7brwk5MQECw7Eqt
	Z0aIq4StNqEdGQz7AqES9ws53W0ForwGBkoHdntPxrbvMenS3wzPkO/FCMSv52oQIAvSkqqLCDU
	EZcC8Ztu6bGAVuBA93/gOozM5VPahlHc=
X-Received: by 2002:a05:6808:c2b6:b0:4ec:d580:2440 with SMTP id
 5614622812f47-50c56348bd3mr3537338b6e.54.1791620772707; Sat, 10 Oct 2026
 01:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010072548.2869465-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261010072548.2869465-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 10 Oct 2026 10:26:01 +0200
X-Gmail-Original-Message-ID: <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
X-Gm-Features: AclHuK-HBhWUWJd8z0U94No5sZEEaJ0hMqagbNquWcG66cocr2HtoJN_Y12NuYc
Message-ID: <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
Subject: Re: [PATCH net] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>, 
	Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>, Jeff Layton <jlayton@kernel.org>, 
	Kexin Sun <kexinsun@smail.nju.edu.cn>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 10 oct. 2026 =C3=A0 09:26, Henry Martin <bsdhenrymartin@gmail.com> =
a =C3=A9crit :
>
> netlink_realloc_groups() sizes nlk->groups to the number of groups
> that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
> are registered later (e.g. a new genl family), existing sockets keep
> their smaller bitmap.
>
> __netlink_clear_multicast_users() however iterates every group of
> the departing family and calls netlink_update_socket_mc() for each
> socket on mc_list, which does test_bit()/__assign_bit() on group - 1
> with no regard to nlk->ngroups.  A stale socket therefore gets bits
> read and cleared past its bitmap allocation, corrupting whichever
> heap object follows it; the corruption repeats on every family
> unregister.

Do you have a KASAN report, or is this from static analysis only ?

nl_table[NETLINK_GENERIC].groups only grows when group ids no longer
fit in mc_groups_longs * BITS_PER_LONG.

On 64bit, 59 ids are free in the initial bitmap. I count 58 genl
multicast groups in the whole tree, 4 of them using reserved ids
(ctrl, quota, pmcraid, NET_DM), so 54 dynamically allocated ones
if every family was loaded at the same time.

I do not see how a 64bit kernel with in-tree families can get there.
32bit kernels could, and then only from genl_unregister_family(),
i.e. at module unload.

The check itself looks fine and matches what do_one_broadcast()
does, but the changelog should describe the real conditions instead
of suggesting a generic heap corruption.

Unless you have a reproducer, I think this is net-next material,
without the Cc: stable.

>
> Skip groups that lie beyond the socket's bitmap: such a socket could
> never have joined them.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Cc: stable@vger.kernel.org
> Fixes: b4ff4f0419ae ("[NETLINK]: allocate group bitmaps dynamically")

This commit did not add netlink_update_socket_mc() or
netlink_clear_multicast_users(). This should be

Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")

> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/netlink/af_netlink.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 9fdf964224ab4..8cc655aa927f1 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1657,6 +1657,12 @@ static void netlink_update_socket_mc(struct netlin=
k_sock *nlk,
>  {
>         int old, new =3D !!is_new, subscriptions;
>
> +       /* A socket whose bitmap predates this group can never be a membe=
r;
> +        * don't touch bits beyond its allocation.
> +        */
> +       if (group - 1 >=3D nlk->ngroups)
> +               return;
> +
>         old =3D test_bit(group - 1, nlk->groups);
>         subscriptions =3D nlk->subscriptions - old + new;
>         __assign_bit(group - 1, nlk->groups, new);
> --
> 2.43.7
>
