Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717393;
	b=i3bldPxcPlJmSnJ0pTs9rvCTq6+VKuKWRInhxs00ch9FuIYP/7DlNDB1raWSYNc9fa6R
	 B6kS7FIX2ajP7slhwGRvouY80AM8KvNlZ4/zqFx0riyD1jvPeKKjh6XaOoOrgoxJ81Hit
	 0PbpxrREMkJ2Q2aqkdvgaVNSBtpgPjCa9i2n0MOCH9MOYjq1Fs+qATWiM40QIR3AvQZjd
	 c9QHXurmY9DzJle9n6BDzdI/ZPscqdu//xBJtaPn6AK0zlEdTpiWD+aZlF69oGwZwW5Gl
	 vTzMQZRbrVH8bg4q0wNhHUkQCqxi0dE6cAzx4hW0/jl0g8YFuElnrsJ4om43jaxd64g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717393;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=27qD6Pz/Glh9kkpJIUr3/I4AZLpTM9yA9jtQ1ZwO82Y=;
	b=AQVqicBi2j2/5KlhX9gNyWRdwR8gF9DjvvEuhn25H/uGedoTRq9cAq/SEAf+1HgmS6Qf
	 0iksGf20omo3Gt2Je40knIL6mtJXxOOE/wcBA8xaNMNwi7hLemyV7cp+Hs9CN9vhMWj/n
	 p5iu7UONfXGMtIvJefv6DXFSXdbjulV10tJ4ULs2sl2odcpjBTQf3qGPTEv61lNfvWfO3
	 kKFwYxs0VCyTRXPH0roE8rcYSZw7YvHaBkul4IMEo8yQWTBzUKEth5mAy8rLrIgiESCW4
	 +MH4Dgmn2IK+X2ih4hvQwhOvnzlbUOqwNCrzziw+efCv0XAZTkGl3Y/28lzLZesRrLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIGpP7aR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E3606D83D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIGpP7aR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F711F00A1B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717393;
	bh=27qD6Pz/Glh9kkpJIUr3/I4AZLpTM9yA9jtQ1ZwO82Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kIGpP7aR1scUpNqCFWVyvqhbrG/s9k0ZdkJR1J8ckr4werPo8N7S+1tPRuPNdQFUD
	 S2mnA5AqFPe1HAd+zP2JYrtXwIUwCn9gjRuBBVMJJDvA4Gzox/Mww6czHdYdFh1hCd
	 XLHRgRYM993qy1/tGMyVR3tvKgGZ6DNU5nXVziqSkJF0SWCUdrFtl0r2nGu6rnGQH7
	 Ir6Wdei4nXB8Ce9rCSQjcQTaO5UUFWOWkAOheJ9QFY2fULmkdYYj2zTmRVoIoPIKeu
	 tcKp5zfJAUZoqF6kKbNWNHONOU06KmjLwsJTd5xXnfzATKI3WDldEJzkaCFYuE3iUn
	 NwrQP67uMQPuw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4f488ba6e90so1574085b6e.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:49:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz/feNRmEHIG92LvoJJYEfMhuJ0T/UFHP2W3qwkBURqRMvIywli8DNKng90EVx+dmCY14GGU4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/oNYSf5z6WRUn1T30rOukVRARJQQBAOwrcPbaL4DV7m2kWllp
	rR9xY+oJc+U8GXcfDj9A2KDeBupw5E9OuPzHxpvdMMQ684OTWFb5mNKQK53jabcATiEd+CBVIoC
	xwzMTFqMAy1eDNrXi1bjNJNqRV6b4ZqM=
X-Received: by 2002:a05:6808:11c7:b0:539:dfe8:9960 with SMTP id
 5614622812f47-5640de0f2bamr8850934b6e.56.1793717392538; Tue, 03 Nov 2026
 06:49:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029214219.1035176-1-imv4bel@gmail.com> <20261029214219.1035176-3-imv4bel@gmail.com>
In-Reply-To: <20261029214219.1035176-3-imv4bel@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 15:49:40 +0100
X-Gmail-Original-Message-ID: <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
X-Gm-Features: AclHuK8zhh9M8Ej8AYQXAAw1VHdM8fimcEAeuD8qgg1yWG-Nxe-lIMO_Y4uRs9Y
Message-ID: <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 22:42, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9=
crit :
>
> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementation=
s
> of refcount_t"), default builds implemented refcount_inc_not_zero() using
> atomic_add_unless(), which provided full memory ordering on success. The
> commit removed that ordering on weakly ordered architectures, allowing
> accesses after a successful reference acquisition to be reordered before
> it.
>
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> lookups and in inet_twsk_purge(), where the socket is validated again
> after taking a reference.
>
> bpf_sk_assign() can receive a socket pointer obtained through BTF
> without a reference. Use acquire ordering when it takes its own reference
> for a refcounted socket.
>
> Use refcount_set_release() when setting refcounts in the SYN cookie,
> TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> TIME_WAIT smp_wmb(), which separately orders the refcount store before
> ehash publication.
>
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of re=
fcount_t")
> Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_=
ID_SOCK_COMMON")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---

Lack of links to prior versions is rather annoying.
