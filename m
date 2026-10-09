Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354148425F
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533066; cv=none; b=UnMK5r/3J6qWf7EowCN+XSkVyAUWD/FWb21Bve5KJpYCsFSdgOgXzIDSFotR9nQcOyPQ9W6VcW2sxohuPmh5BvLGa1BsgzgVIz25Rm4wAcGgUc8ncJ/iwDI364H/ujNq5DF1k1iSpgP3G4E2JaJn1879MlY7Pi4Yqnqqc/7Rp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533066; c=relaxed/simple;
	bh=0y74i2STDjmKr4lBePoInGDutw/6C+poWpHkbdAVK1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+NqsVq6+Jr5/drVdqy5AEfmGJnGiU0g/wZo0tvlb+vPEbZ4tlet9P8tcKNmQ4bD89aUAnKvJYMekBVZhDp9IvgSuHUK1AhJiMcKbdUWMiMZBLZHqk5Sb0B2yBF5h7HM/8zQo/7f+VjunepmCYHQOgSwiSSHxSR1cXUit5K7w98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd2yY7Bf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd2yY7Bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667E41F000FF
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533055;
	bh=s/5A+ZClw8uFOpyIi+IWKMRcAZDloocaw/uDqLtwjvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hd2yY7Bf/6HQv2JT31eHw4xxh6qv2pVK2+TKA8ZZGIN+Fepttoygqwu8OGSD6E3JT
	 WVW5BGva4e8Mp5TXySE3UdShEOmo7j3JK7BcR8aWYW3hEJ3UNo+973//1z9xefJJa1
	 E6dytF5qet5tUAjrmBLU38VdIuerB97XgCwIzJz+JX2sgrLXbJHEjgPKVAambKGcuJ
	 R//Qczr4xpAX5vpu8sjsHRcTlorJmH99LH/GBKvT/I+q33GJEZOmJ6gFLD+7cage1e
	 9gUAde6xeQa1VaZt5kRBE94YLVgAmuEH6krMMIFliCM3Y0/O4oeBNttM1V1LNgi1CV
	 o9+kr/XnqTqlA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-483d290f398so2153474fac.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 01:04:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrSogYEyifnao9jwhXuyI7/LFKKSiF9Cv5MObLLZXSy55nKOmN7O/A2jcdwGIEk6hPBh+BsJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPh9kLMJ5A0idZeUCg8LorIuLmQ7+cH0iftmtRYnC1Vm1riseF
	Ie9zf0jNsQDiRvoz6Mda6zSrcU7XZELzLqC4Yzn1M6KCgOB4adYm27GEoJ0YwJcNJpgP2vawQlj
	glWCfVQ474vZKUGS2Y6ar1XhMDF5dGkE=
X-Received: by 2002:a05:6870:6493:b0:4a2:4d77:866d with SMTP id
 586e51a60fabf-4a2a87ff162mr990737fac.11.1791533054730; Fri, 09 Oct 2026
 01:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009074523.2747168-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261009074523.2747168-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 9 Oct 2026 10:04:03 +0200
X-Gmail-Original-Message-ID: <CAL4WiipX3uc6FD1=saqEthm+PTCKkoY=J7cXRf9R9FTqd68raw@mail.gmail.com>
X-Gm-Features: AclHuK8ltwaJAIjTWP05-fE44s7cCMnjL8O00smo3LgS1FtFj3W92as-vTo_gZ4
Message-ID: <CAL4WiipX3uc6FD1=saqEthm+PTCKkoY=J7cXRf9R9FTqd68raw@mail.gmail.com>
Subject: Re: [PATCH] ipconfig: fix use-after-free of device list after ic_close_devs()
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 9 oct. 2026 =C3=A0 09:45, Henry Martin <bsdhenrymartin@gmail.com> a=
 =C3=A9crit :
>
> ic_close_devs() kfree()s every ic_device node but leaves the static
> ic_first_dev and ic_dev pointers dangling behind.  When a DHCP reply
> consists of an OFFER that is never followed by an ACK (a misbehaving
> or lossy DHCP server, or a network that drops the ACK), the boot-time
> autoconfiguration loop becomes vulnerable:
>
>   1. ic_bootp_recv() accepts the OFFER and records ic_dev =3D <list
>      node> ("We have a winner!" state);
>   2. the retransmit round times out in ic_dynamic(), so
>      ic_close_devs() frees the whole list =E2=80=94 node included;
>   3. the dynamic retry path (try_try_again) runs ic_open_devs() and
>      ic_dynamic() again; on failure it falls through ic_close_devs()
>      once more, where the entry point evaluates
>
>          struct net_device *selected_dev =3D ic_dev ? ic_dev->dev : NULL;
>
>      =E2=80=94 an 8-byte use-after-free read against the freed ic_device.
>
>
> NULL both pointers after the free loop so subsequent retry rounds
> take the clean empty-list path instead of acting on freed entries.
>
> This vulnerability was discovered by Tencent CodeBuddy Security.

This is __init code, on a boot that already failed to get a lease.
I would not call it a vulnerability.

>
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Wrong tag. In 2.6.12 ic_dev was a 'struct net_device *' that was only
compared, never dereferenced. The dereference came in v5.12 with:

Fixes: 46acf7bdbc72 ("Revert "net: ipv4: handle DSA enabled master
network devices"")

> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/ipv4/ipconfig.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 1b8585404a41..ac4851e59c3b 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -346,6 +346,13 @@ static void __init ic_close_devs(void)
>                 kfree(d);
>         }
>         rtnl_unlock();
> +
> +       /* The whole ic_device list was just kfree()'d above; clear the
> +        * static pointers so retry rounds (e.g. dynamic retry after an
> +        * OFFER without ACK) don't dereference them (use-after-free).
> +        */
> +       ic_first_dev =3D NULL;
> +       ic_dev =3D NULL;
>  }

The change looks correct, but the comment is not needed.

Please send a V2 (in more than 24 hours) targeting the net tree
([PATCH net v2]).

Thanks.

pw-bot: cr
