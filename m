Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430232;
	b=r+yqZw/7K2Ug9PyMFFCpMNCPi/7NIe2bs0gXntFowMYZkaCorM5xYj5cpvFYts6+kUCp
	 AznH6DZfWlGDPFgPgTma+rvZew4PFpYfqRpCCkq73WUrWTHnJ2yj1krKtrIzvv/L76zEU
	 QyTDqEW9AMptyFj2FDxbaRCL0Wav5GgBaK/Cw+nVyrTxLRJnkwifazZhhVtppyu3KeAkk
	 bWpn+FpG1aluHCUOL6x3XSGv1BntCJ8cTTuXJJ7XJRZYkcyqZfLSe5DSL9Xqrkqii4UKp
	 9CYCqRzl3MT9FikGYgQ854fuKoVgcj/jJwaN3eqarCuM/9VJZ7jVywewfDrvCv5sN1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hp49m+PlmWDptABb0PwnQYI2/1Zwbtqs0bt0NWyh6Yo=;
	b=fC7k7nDyuB3O/MznVG16eQAfVOdwndPmjxOM5s0ZaBYxRxxCQxT3sJt1t4r3MlWoa+mE
	 2GwmUy+exaVGf8oNxjzmpqEqXExRJ9f3e7akuegoGpmx+hRluxBm2Jeh02Nt9vYlkWb3N
	 q1hmnQHZ8iiXN5Wtv0/JyKzQAzLDXTtQ1TV/pkkjgobM0LVbJY5U57FPr9ZblV2T37OHI
	 LEr/snXfDbzZxt/l+wHyi4DXQFHmwZ2yyJgpr3taPvhwYfUwnaEqeqAhhBs3kJA0qg1Xb
	 07QPX1STUUm1iT39J4YAHMi2nAQraRF1Y72PKwkDbYZOzBGkfLjwrDBs4WITErQh0jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Vz50jCiw;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0089606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 07:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0089606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Vz50jCiw
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df54150dfso653177f8f.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793430230; x=1794035030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hp49m+PlmWDptABb0PwnQYI2/1Zwbtqs0bt0NWyh6Yo=;
        b=Vz50jCiwmutBeV363EBZSdExKVPSOYpLovNtxOSkkSBzWmKtijM9cv0xnfLinhLFem
         6bMDI1kwHFldgnlCxCPZ1KY6kGF9JVh3gIvfmZj7DK0NiRFDBW9uTbOS5R16oUx990En
         s2TIgwJebIP54DV2Eb7A5Ky3xzs4qGhncGfeDQ0bfPD/TCD0zN5saWKJMwXaOIuetbk7
         VAo59PmExaM0TjUu2cHTVo3e76oaCqwTTLUxKnCZwG3XTPo5uS9vG5rKnLHCKmbXnrZs
         +2M7Be+FVbR41W42Uknh+ASbZ9lKVv7Mhxe4C2fkLw5xjuVr3NKDf1FEnLIehCD7gLtW
         usBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430230; x=1794035030;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hp49m+PlmWDptABb0PwnQYI2/1Zwbtqs0bt0NWyh6Yo=;
        b=bgH4xEygvqid++fnshaeUh32DpkKWsRUKDM/3LyP6d6MsC8JGxSAUHNUHcHGqiOqWS
         JzwK5j1abL8c9njOwXQ9IFmLcceCTKApvabeqSmXxQJ0e94eS8H/WFrGaEqbI7St0886
         ymd6K2D0BmR9j4wmBsOwPNJ1OoZ2LAJCXKkpRQuJC6AkWYxIdr4sZhe2hWoXEWfUi4sz
         xTGtxR9gwxgLr/U22I0cHOff1B4w1oxZGBCTlI7g7lPkCNgDnFYvvE5HvkDMeEErVbKD
         OX2047T37IJgh64UBhb9qVLmQkA+L66t+0jLv5/9ZJDIDeZ6wyTlD5pWSF7aQTWpo5Af
         IdWg==
X-Forwarded-Encrypted: i=1; AKwUvBwOvq+ATa9TMVsTU+DKyBbonqcsdU8eZWdr9MB13CyDMHJrRjtnhnDkUzG1Cv+rbtw6b8LYZ38=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPFLUIZ6QQh5AluxzQVpKeDpOihS+QjEwnzh9K4gyUHAwjqmt4
	bYmJ8X0Hxvv5yuJ3vN3uDOkwjak2Pq8Xv2WcfFJwM7yTr7GhKlcnfcm5NrHfe3OimDU=
X-Gm-Gg: AYBFou1pH+our09HBa8yBbLfY7ZXDwddDnZYllozXNr8pImawk08ZWMrudC/7YLnVF/
	JkWhwJTtcTLeWTtv+pvvMaHyjGzQtnRU53NpX6LsumiuMDTymLAHQdtKOAvVCijdkH2s5EuKxxm
	EXLZuQKrzKmuYXM3RADod/THLowXs3sjZxS8lsF/DGcYL3BQ1Yu0C6k+uzgih4jGJwf3aO+53Hi
	mrPwNyYLBb0GjGk4WMYCikbHEC1lcn4iqb7BHXzpx9+SYrthQ/8sfMF8QWWc1cCHtv9BpD1KNM5
	cRSCO7l2HBb8AvGr0c6aYd/rm+SHswNAZcb7M+q/tCfZZHt7POKg4rulrhYE4BBfIk7jBZxniKw
	EFsrGZCtzBfbtokjQGJ5XABN/laK60UO0B5hsxSSgy76aZs5t9zI3W8okaueEoilq+Zi4Bq2QmP
	N3aXrbHnFDWQ8IgOt/Ij+ASvlt6x3Dg5tjp1WpiwANRPN9Mbi0Weu3lo/okSH3d3pE1s11Huq9C
	nQ8qzz96+w/e4iWCzTGMqExt6JyOIGwuMoC5l9r4MB9gQniLwbpC03V9NYBU6L6n5K9s0fXwnfG
	af6WQu0ns3gspKXPUSmZyeG+AiV938suth4mcXEwCcq7C2zZRoRgFpQSSdc=
X-Received: by 2002:a5d:588e:0:b0:48e:6bbb:c3f3 with SMTP id ffacd0b85a97d-48e6e2fd071mr9785683f8f.28.1793430229695;
        Sat, 31 Oct 2026 00:03:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm7181698f8f.27.2026.10.31.00.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 00:03:49 -0700 (PDT)
Message-ID: <78c8a252-5e0b-4a38-8dba-125c0dab8ac5@blackwall.org>
Date: Sat, 31 Oct 2026 09:03:48 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: Stop rejecting dynamic FDB entries with a
 nexthop ID
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org, sf@techfak.net, stable@vger.kernel.org
References: <20261030133750.28668-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261030133750.28668-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2026 15:37, Ido Schimmel wrote:
> Commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
> nexthop id") started rejecting FDB entries that point to FDB nexthops
> unless they are configured as "permanent" or "static". The intent was to
> prevent such entries from being aged out by vxlan_cleanup(), which runs
> without RTNL and can therefore race with other VXLAN devices that modify
> the same per-nexthop FDB list.
> 
> However, FRR installs remote MACs that are behind a multihomed Ethernet
> Segment (EVPN-MH) as dynamic FDB entries that point to an FDB nexthop
> group. Since the above commit, these entries are rejected and traffic
> towards the corresponding MACs is flooded to all the remote VTEPs.
> 
> These entries are also marked as externally learned ("extern_learn")
> and are therefore skipped by vxlan_cleanup(), but exempting externally
> learned entries from the checks is not enough: vxlan_cleanup() reads
> the state and flags of an entry without the hash lock, so an entry that
> is concurrently changed from dynamic and externally learned to static
> can still be aged out.
> 
> Instead, remove the checks added by the above commit and make
> vxlan_cleanup() skip FDB entries that point to FDB nexthops. Such
> entries can only be configured from user space, cannot be learned and
> cannot roam, so there is no reason to age them out. The nexthop pointer
> of an FDB entry is set before the entry is linked and is only cleared
> after it was unlinked and an RCU grace period has passed, so it can be
> checked without the hash lock.
> 
> Adjust the test cases added by the above commit and add a test case
> that checks that dynamic FDB entries that point to FDB nexthops are not
> aged out. Without the fix:
> 
>   # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"
> 
>   IPv4 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
>   TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [FAIL]
>   [...]
> 
>   IPv6 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
>   TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [FAIL]
>   [...]
> 
>   Tests passed:  44
>   Tests failed:   6
>   Tests skipped:  0
> 
> With the fix:
> 
>   # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"
> 
>   IPv4 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
>   TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [ OK ]
>   [...]
> 
>   IPv6 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
>   TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [ OK ]
>   [...]
> 
>   Tests passed:  50
>   Tests failed:   0
>   Tests skipped:  0
> 
> Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> Fixes: 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a nexthop id")
> Cc: stable@vger.kernel.org
> Reported-by: Sascha Frey <sf@techfak.net>
> Closes: https://lore.kernel.org/netdev/20261028142928.GA8406@techfak.de/
> Tested-by: Sascha Frey <sf@techfak.net>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c              | 14 ++------
>   tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
>   2 files changed, 31 insertions(+), 23 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

