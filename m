Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589134A5C21
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000082; cv=none; b=LFpf0osiHaz70LTNEEqynRwQ/rsCrjukm/FFFAzuy9d34L2WdVkWS7mGNKvfXvEtnIGwZqiYvRWfJl4+zRzdOnW0wrTP/dlC4dyD3oJ1P6XdNbzXxvlozjTNXtydlUtIhh1ZU/Qm6NyLl8agpuuiOjg9rlbgT6CM8WfnSNqoecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000082; c=relaxed/simple;
	bh=A3lMAoHzvdrIRHmu0U9O1DHYioyKBVDwytLfoEf9Ugk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjeS3cpYIRgSFGV8UrXQh9Ozrz07uS8iAFylj9nbPOlDPJ5q6cb18Gy8mjwrKycFNSIUXA36A6gBz/nM6NVjxJjk7Kmk8sezn71NMm0y3DSMQKy/SVLmAuYQSJxNjJA95q7r9BQSJRa/FaHStIJo9u7sPwU+I5WllTZp3n/R+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GBOj/dTt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GBOj/dTt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so16409085e9.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790000078; x=1790604878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gnaVA0UVg6a41pLazpe1rvpHFpADsMibbWOKFLPcI8=;
        b=GBOj/dTt0Pnzf1RehLOSf+1dOdqVXbCtTPy/3WB+gLuPImY6+Eaf0qTsiS2vcjXk/Y
         x5Fqz7rK0U83YB880I53upchyDBUQakYuPGRO9MLHFS6KcopxaYkXKzhEjcQ6OMqs0vy
         NrlT3UmAOpPIXM2ql9eo4Lm2AopyEP829oDUSL7cZ93tUcI4GSGHuzWheXX8Dez78qnP
         8r+1UQOqP9xCle8mvaZWAzb3V7ebpEtCcVYpbCK8f8BwG1sppWESUQHWyTajoChF09qs
         fXnH0tgeF4nEWgzqvz9UYQUhUWliKiNexORApK2XSUs37DMCd0/7lNx9fAlTSjlTpnRp
         /H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000078; x=1790604878;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gnaVA0UVg6a41pLazpe1rvpHFpADsMibbWOKFLPcI8=;
        b=DnRFqHYNufqI/gWkSQwr5rPZOsxffmSBX28xZAa01TQpQeKd06nIof83e9VCmLB5od
         Q8pCY4qwK46Rchxg/X1gtdfHl6JLiRa0LeGJcxkfnVZpjyGHQUJ/liG/BhBVKjcmrXmD
         hc1gS1wkyVHdZIRVaNitJ0U/YvEXNqWBn1gsjtvOSHDCe7u7xzSFmuh2Bfxf4ra7gUf2
         /d2/7rKPWHgHgCsjrpypEShIby6jNiU7pVeNTxTS0VyIWmjJi2+azCLe6U/mGKa18DYp
         rX2KYCnpT8ea3zy/tcPpQDJB4ppQ7fLirZTA63YYAsFl6QPG5t1pH1+vIuzivpooeKWP
         gSDg==
X-Forwarded-Encrypted: i=1; AKwUvBw0q36VqcLX5SyOk/Ty4gpP2IqhIZ4XKBETxUu5xHWX6/TQSh58h5Rg67dA7s8G0ti8KOggi9o=@vger.kernel.org
X-Gm-Message-State: AFuF++n7m8piGXOE7HNGq4yNtfHIgV9lx3YA9iChWno8jQjCnG5jMAn3
	HOSojrPZqspNW0knfwJSSTiYX/JWZ8u0IsW4mHlLPLiF2eOd9ATHmAb8gD7EjQeAOqI=
X-Gm-Gg: AYBFou1u8dUSB3CQ7Q0neSNQZhZJKhulW1cWgiJAhcoCC995OnBcOQWMoSuxZ/x38+m
	1dd+WtiRhMvXgKUoKM4khbXeLzNjRZKIM9bSx5UTua5iHqOwCK2o319WxZhQL8K2hI8jsI5a5NT
	6Nz3gDE32SKZKad+MzkSgRU6jiZqCw0BhgIHuyXfD+/evzrrX8kEw+Rvc26gk1L3PJha+LZ0dUO
	JCxgYNVNZAyfpa7qAzZkb1SNmV5J4tXY+QJDYycgsrorJ+X1Yq4CkUHuYciZ4F3orwSD7y9SC7F
	9YSz1x7qRXx3e32k2J9x1zWNEq28IOJeFoW7y84eR+wfPW0vYuRzdc/+cRz7BYTk5qz9Dz4yco1
	sAqnA3rvTHIvBTXjnD2hi+c5aG8Kb2aQq5qMQqRsURhhKMz2gQZk2c2q9GXMl3/fJrI18ZIqiKd
	+M91LSmL4O7G0TdYqJG4jOyoI24sD/3D8ve/7Ef/4J8fOoyvfvXHoxLdKPA/1OpfAf9zW7DjgQY
	MjFarF8nMR/IywM92ncWInirXnU/g==
X-Received: by 2002:a05:600c:3b8e:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49fc57144aamr194759525e9.8.1790000078224;
        Mon, 21 Sep 2026 07:14:38 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244229d5sm24216068f8f.2.2026.09.21.07.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 07:14:37 -0700 (PDT)
Message-ID: <ab670ef7-7650-4a39-9871-b5182725beb1@blackwall.org>
Date: Mon, 21 Sep 2026 17:14:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mdb: restart port group walk after
 deletion
Content-Language: en-US, bg
To: Fourie Zhang <littleddfu@gmail.com>, netdev@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Petr Machata <petrm@nvidia.com>, bridge@lists.linux.dev
References: <20260920110852.60293-1-fouriezhang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260920110852.60293-1-fouriezhang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2026 14:08, Fourie Zhang wrote:
> br_mdb_flush_pgs() keeps a pointer-to-pointer cursor while walking
> mp->ports. br_multicast_del_pg() can re-enter the same MDB entry through
> br_multicast_sg_del_exclude_ports() and unlink other port groups. If the
> cursor points into one of those groups, the next iteration dereferences a
> stale cursor and can leave mp->ports pointing at freed memory.
> 
> A following RTM_GETMDB exposes the dangling pointer:
> 
>    BUG: KASAN: slab-use-after-free in br_mdb_dump
>    Read of size 8
>      br_mdb_dump
>      rtnl_mdb_dump
>      rtnl_dumpit
>      netlink_dump
> 
> Reset the cursor to mp->ports after every deletion. The deletion removes at
> least the selected group, so the restarted walk always makes progress.
> 
> Fixes: a6acb535afb2 ("bridge: mdb: Add MDB bulk deletion support")
> Cc: stable@vger.kernel.org
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> ---
> A reproducer for this issue is available if requested.
> 
>   net/bridge/br_mdb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index e0c7020b1..a01bd280c 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -1523,6 +1523,8 @@ static void br_mdb_flush_pgs(struct net_bridge *br,
>   		}
>   
>   		br_multicast_del_pg(mp, p, pp);
> +		/* br_multicast_del_pg() can remove other groups from this list. */
> +		pp = &mp->ports;
>   	}
>   }
>   

Yeah, this seems like the simplest fix for stable. I will post my conversion to
standard list primitives and will remove these issues altogether with it in
net-next.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

