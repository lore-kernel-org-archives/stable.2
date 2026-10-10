Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723228B7EA
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613985; cv=none; b=OSey2OnRX6wyFpkyTB7odhIJbjDxHJPTqNKy0SnDDCBy1JCJ5DlD/9E8ZEJH96nc7+7Llk68FGrNVAPdJvUpFtldYYXDTIpGXIDm5lCiA+MrABmrW/bg/eZLuTQk1+fgpYw6NDsMSNVblCCRM90sFa7qYFizzXZ9JyXeOyRK1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613985; c=relaxed/simple;
	bh=js99Rxw6d4LTQnUdeK4/G0TvZ029qAkf0Iwu2klLhiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB/l5K7E5rWT55U30zxSXmYXRWF2IfT57Gse05bL3xDn5fxgbli3A6paq8/dFcQNlX7ozU2vLP3lMMjYr0h737Q8GgTvyUWfxH3NdQgg0qoNU/Tdduj2y01oibA0W+2YYwcgBmiBeM1cbTYRmAsDZ9BcMOodxSBftqdILdo4nPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAc/Q2au; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAc/Q2au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C530F1F0089E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791613979;
	bh=b16zzei5UU6y9ZD9txjezNSP6bvSMZ1kmlNghkWbFz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AAc/Q2auzXjSpVXcsaVhWISGHKrj3x5UiTJNzPACL1YXdbxK7Cm5cskufzGIVIFwd
	 hGTr3L6MFHLzB1uTih/FxI5u8pz/3KXQpshRMAqYBQXyBEKUNKIY4G3zJrwbGiiZeq
	 4bEmyPiNui+mK8jT7xo5ds0KrpBnGocp/plFt2Hx2dHeOF3eKOTdBZPYsDiZ0O50Wq
	 FOJ1+iiN0vxiu8bwjaiyMD8UNFtizaUV3vDQGGVMcpTVaRCnF7Vt92lMcuwwfs6F+L
	 mDATorta9/uOoribRgbSxCc2SFIVob1TEBhd4tnGBiWXLvCuSHkT55sN/Ib9LLvd+8
	 sSttQTqLt8O/Q==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6de2f213b7aso210453eaf.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 23:32:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxxEs8aM69Eeke+wXDdWjkMuFCkJmfYZxXn9I5KK6NI/O5zv6UNlxbu18jyX0dahAXA7qgkf7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5my1ibOAnSD+VqU24XPLNxOmv5GTpZHwomYDk6DnWi7suNNz8
	XyxSH8VI7BO3XvDJqOkfLU/6cjlcIeUAVHCMBdN4YMZEGn/G4lpuUcNd2pSLkNDbMMrkb66y2lD
	vjGyHzwFuJNVtNBpulyQ29LWlb7bun1w=
X-Received: by 2002:a05:6820:4dc4:b0:6e0:1599:a5c with SMTP id
 006d021491bc7-6ef1009c43dmr2740104eaf.71.1791613978986; Fri, 09 Oct 2026
 23:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com>
In-Reply-To: <20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 10 Oct 2026 08:32:48 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqALaRC5U+H_tc5nUmkN932pHPE8Z94x4cB5X7vbuGRCA@mail.gmail.com>
X-Gm-Features: AclHuK_jW0xWSuvSePWtjINEueMh-yMLMabcZhyjAtOV1tnHpIDfomRToV0aEFo
Message-ID: <CAL4WiiqALaRC5U+H_tc5nUmkN932pHPE8Z94x4cB5X7vbuGRCA@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
To: datrujillo@nvidia.com
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Alexander Duyck <alexander.h.duyck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 10 oct. 2026 =C3=A0 07:37, Dani=C3=ABl Trujillo via B4 Relay
<devnull+datrujillo.nvidia.com@kernel.org> a =C3=A9crit :
>
> From: Dani=C3=ABl Trujillo <datrujillo@nvidia.com>
>
> fib_table_lookup() checks the child index against the bounds before
> passing it to get_child_rcu().
>
> The index is derived from the lookup key, which in turn is derived from
> flp->daddr. A userspace process can therefore influence the index by
> triggering lookups for chosen destination IPv4 addresses.
>
> If this bounds check is mispredicted as in-bounds, an out-of-bounds index
> can be transiently passed to get_child_rcu(). The value loaded beyond the
> child array is then treated as a node pointer. A later transient
> dereference of that pointer can cause a data-dependent cache footprint.
>
> This was found during Spectre-v1 research. Leakage was demonstrated with
> instrumentation that delays branch resolution with a CLFLUSH before the
> mispredicted branch and makes the leaked location
> deterministic for reproducible measurement. In that setup, a
> userspace-controlled IPv4 lookup key was able to trigger a transient
> out-of-bounds child access. The transient use of the loaded value as a
> pointer caused a data-dependent cache footprint that was recoverable from
> userspace using Prime+Probe. A real-world attacker would likely
> need to delay branch resolution, which was not demonstrated end-to-end
> without the added CLFLUSH.
>
> Sanitize the index with array_index_nospec() before accessing the child
> array. This removed the observed leakage in the described setup.
>
> Apply the hardening before setting cindex in fib_table_lookup(), because
> cindex can later be used by the backtrace path to load another child
> pointer. fib_find_node() has the same pattern, with the checked index
> derived from a user-provided key in fib_table_insert() and
> fib_table_delete(). leaf_walk_rcu() has a similar checked cindex before
> get_child_rcu(), and the traversed state can be influenced by userspace
> actions. fib_find_node() runs under RTNL and
> leaf_walk_rcu() is not on the packet lookup hot path, so harden those
> analogous accesses in the same way.
>
> Fixes: 9f9e636d4f89 ("fib_trie: Optimize fib_table_lookup to avoid wastin=
g time on loops/variables")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Dani=C3=ABl Trujillo <datrujillo@nvidia.com>
> ---
> Changes in v2:
> - Move array_index_nospec() before cindex is set in
>   fib_table_lookup() so the backtrace path cannot use an out-of-bounds in=
dex
>   (Eric Dumazet).
> - Apply the same hardening to fib_find_node() and leaf_walk_rcu()
>   (Eric Dumazet).
> - Add discovery/testing details of the gadget to the changelog.
> - Link to v1: https://patch.msgid.link/20261008-fib-trie-nospec-v1-1-fa18=
726d485e@nvidia.com
>

This looks good to me, let's wait for final Sashiko findings.

Choice of net vs net-next tree is also debatable given that
performance impacts are unknown.

Thanks.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
