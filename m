Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016940;
	b=L4hVw0lwcC2DOPlE+3yYDOuAR2pIloEnSSnytVOSdt9h3xrvfeq7KNJ2BQuZuwaIqJFD
	 JrDhpgLi4Vt4tktkdFWAPIRDwFRPUmWv5misgOjc6jX02jC7jlG8B0/9OuiNXxLAA2/JS
	 8uS0vVrDZ6nGNJY6mynsfuhOOLMi7+9Fl7QdobkAxwFJ0+zMl7NdB/ZyzhL4p3hVt5Sfu
	 NAQwpV0dAU76ifUdrC5XywlJEhEOH43i995wmDaEhnfAuZchTxsvM0Q53xlZeO+Xx2uyF
	 HejoEYjE4ESU1ERQqy+6ca8PqmI/Qlavk6+mgBSuTdxnQ/dkjBp+npyVLzVm/MCZYoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016940;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H8KnQWvxuK6V08t47ps2cs08V3cGZwetRofByIjuEao=;
	b=l9Ra475RgTXRk6D49ENBBs0B3z8/N3pEYLYumGzGYKMxwftQ7OlKe8eAJbc+vR3jurUp
	 OHZ3bgLKp7eZFcm7zh3ulO5K9PeiyNY+8vezu9+Dsxbf4KqQIQGCw/UQ6R6di8jNSSfav
	 yQhE6T2yVjg976+WOExO4+99EpTN44t4krHLgXbZzkDGHTr/wG/Zo94Ju9T6Zl2hx7Lqn
	 avc6Tgsotg8kuWYvT6Iy3v700evucXXbpohQCdNXi827UYVKjKgXExSrw6SNjonA73sKa
	 X0n4vEEdSsPASlMOBQlcNAHdRI6FM7bSzeWDrJZfiGBm3ADUlHqnwcQWdyfTEfn9wkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcZ+UzZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C2606A321;
	Mon, 26 Oct 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcZ+UzZh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04961F01825;
	Mon, 26 Oct 2026 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016939;
	bh=H8KnQWvxuK6V08t47ps2cs08V3cGZwetRofByIjuEao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UcZ+UzZh6envg0pIT6DV3Crs77mjh+wm0SzypbOqgqTc3or4MLJtFN5lhp8Uzq4BA
	 3s/VSsEJeN2tQF+AtS+f209Rqn7xqJR3LNj6S8U1CXmZdA5C1Q7bhDRuqaB0QBNe3h
	 6+gMbTFWeoCUMUtXOHOqDOUCs/f4+EeCD+dsjpecxOVev4K6UG4Xu+jaW9AFXRW/Fi
	 CBC8PufITzQsUvyQW/WXyO/5VBkwDZRR9cZDuET4Nc6ueVcqxn5f2O9dik6qV10mRB
	 yEgCPYGFMIRBF47ZKXsnxb00HMID1A3aQEfIu2k9TzfXL/PV9V0A9R/pRP3ie8hzbk
	 5D/LB80BoUj0A==
Subject: Re: [PATCH net 1/5] ipv6: restrict gc_elasticity to 31
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com,
 joel.granados@kernel.org, chia-yu.chang@nokia-bell-labs.com,
 bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, fmancera@suse.de,
 hannes@stressinduktion.org, fbl@redhat.com, pmladek@suse.com,
 paulmck@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 12:15:38 +0000
Message-ID: <179301693822.3134.16821045137329382001@kernel.org>
In-Reply-To: <20261023091419.167088-2-jiayuan.chen@linux.dev>
References: <20261023091419.167088-2-jiayuan.chen@linux.dev>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "ipv6: restrict gc_elasticity to 31" says
  only "Cap it at 31", and its reasoning covers only values >= 32.

--

ipv6: restrict gc_elasticity to 31

This commit switches the net.ipv6.route.gc_elasticity sysctl from
proc_dointvec to proc_dointvec_minmax with bounds [0, 31]. The upper bound
avoids an out-of-bounds shift of the u32 ip6_rt_gc_expire in ip6_dst_gc()
that UBSAN reported.

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 94e5ef1c4f83e..6f2efc219f395 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c

[ ... ]

> @@ -6627,7 +6629,9 @@ static const struct ctl_table ipv6_route_table_template[] = {
>  		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
>  		.maxlen		=	sizeof(int),
>  		.mode		=	0644,
> -		.proc_handler	=	proc_dointvec,
> +		.proc_handler	=	proc_dointvec_minmax,
> +		.extra1		=	SYSCTL_ZERO,

[Severity: Low]
This isn't a bug, but should the commit message mention the new lower
bound too?

The changelog says:

  Cap it at 31. 31 and 32 are equivalent anyway [ ... ]
  Values above 31 add no new behaviour, they only hit the UB.

This only covers values >= 32. With extra1 set to SYSCTL_ZERO, negative
writes that proc_dointvec used to accept will now fail as well.

The lower bound also fixes real UB. In ip6_dst_gc(), rt_elasticity is a
signed int read from the sysctl:

	int rt_elasticity = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_elasticity);
	[ ... ]
	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));

so a negative value also gives a negative shift count.

"Cap" also reads as if values get clamped. proc_dointvec_minmax actually
rejects writes outside [0, 31] with -EINVAL.

Since this is tagged for stable, could the changelog say that writes
outside [0, 31] are now rejected in both directions? That would help
anyone with a negative or >= 32 value in sysctl.conf who starts seeing
the write fail.

> +		.extra2		=	&ip6_rt_gc_elasticity_max,
>  	},
>  	{
>  		.procname	=	"mtu_expires",

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023091419.167088-1-jiayuan.chen%40linux.dev
