Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871543;
	b=omY5aNGqj5b6y05jHKhrcIhWHGTFsuIpmJi9YOY4cwkyk34wLzwf7UaSBbwcNDdTzXH+
	 uOTmb75xHzKRxCUJHuLyUTCaVf33tWXLoFpYnXBs/SOwddo4qQ0EwdvUCl00cex7kwOBt
	 MCcZ1ZBm4lJJgIRcNHoB8Rdi0Mbdy5ybHA6BgaEmHCOQBm+KiwWyWF7ZPmYdl5iG2RXo4
	 ifgblNXSWHh802TUHwwJeg3FSAccbjLZd9+bqrNdx4JFpi1zxwlC9igy4j13BGmqeityX
	 r5l8ncm9orGpNFy67e/HdnvsmRjOGEK4WyznUhT+Y5I46yzPW3b1Ff0WpD8OBs6EFXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871543;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nOWIFWh+1CEqipH8Zskds4nwG3GpkW/ipctC03Z2qdY=;
	b=TzNkodtso0iqPm+KRPas2hi5uoAYYo4qR8zsZqAXpIbNtCw8+gmjEq7CpKK8+uJkKP8F
	 D+S1xsQukvSPMSvJDaQj2OtPG13X8thcSYTfW21/sOJm0fT/seA5I31BpFnQ1phlPE84h
	 38o9DyxJTiVKSmC4/EPl7lAFPNF+IToBftBxEexz/Ve6DV9TtIdbgAL0GrormloKC2hGC
	 z5m1Vl/sg2owHqmQsYhDPsrXjutdFExLj7t2Nzj87R5EGiRDTSvoGE8LmMf2BZxozLfOL
	 FPYlbfExgzA2T80nzFhJbN/qDTHcd3HOkuFT+kGLyBnczSsQqiIKYnX43xSx1JdTGeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEV2hKzx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D7606A339;
	Thu,  5 Nov 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEV2hKzx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF61F00A02;
	Thu,  5 Nov 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871542;
	bh=nOWIFWh+1CEqipH8Zskds4nwG3GpkW/ipctC03Z2qdY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fEV2hKzxVlnyyzz/+Ijpzj8+tZwVIb3yoZP98/MQGep/idZoFnVjQyF866h1KWeVf
	 fO0Sk7iLN3phAX28vLVafI/flF78fI/EcQ2Pb087tNuMdmsvLVt5H5m4Fz/gIzvZF9
	 xpjpMzW6GGKnYc0gLAPw6jhTd3XmT43C1RopWEscevHp4XG7fDv3zspYIQLzCZ8i74
	 a5UOxDRXcthsaEm2rAZ+3QOhGs7q0vx00eKqIhJkXL9CMcy1nJVyFBBtTbxcCmBL/a
	 8lkOQNPEhnGsGFDx6w5umjDuFwhxeaNbDWw0Zi8PoBmnuST3BLYnYNukdesOhqWg1+
	 o4irIM89ncIpA==
Subject:
 Re: [PATCH net v2 2/2] selftests: net: exercise SO_MARK on connected sockets
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, willemb@google.com
Date: Thu, 05 Nov 2026 09:39:01 +0000
Message-ID: <179387154116.488856.7164246185525969593@kernel.org>
In-Reply-To: <20261104092252.15712-1-yanxia@cmss.chinamobile.com>
References: <20261104092252.15712-1-yanxia@cmss.chinamobile.com>
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

- [Low] The new "IPv$i $p connected mark 0" cases in
  tools/testing/selftests/net/cmsg_so_mark.sh can never fail, so they…

--

selftests: net: exercise SO_MARK on connected sockets

This adds a -k option to cmsg_sender that calls connect() before sending
and leaves msg_name unset. It also adds 18 connected-socket cases to
cmsg_so_mark.sh for IPv4 and IPv6 UDP, ping and raw sends. The
per-message mark in these cases is the socket mark, the prohibited mark,
or zero.

[ ... ]

> diff --git a/tools/testing/selftests/net/cmsg_so_mark.sh b/tools/testing/selftests/net/cmsg_so_mark.sh
> index 772ad0cc26304..7a5e317bc4c94 100755
> --- a/tools/testing/selftests/net/cmsg_so_mark.sh
> +++ b/tools/testing/selftests/net/cmsg_so_mark.sh
> @@ -68,6 +68,22 @@ for ovr in setsock cmsg both; do
>      done
>  done
>
> +# Check per-message marks after connect() has populated the route cache.
> +for i in 4 6; do
> +    [ "$i" = 4 ] && TGT=$TGT4 || TGT=$TGT6
> +
> +    for p in u i r; do
> +	for mark in "$((MARK + 1))" "$MARK" 0; do
> +	    expected=0
> +	    [ "$mark" -eq "$MARK" ] && expected=1

[Severity: Low]
Can the "connected mark 0" cases ever fail?

Here cmsg_sender runs with -k -M 1001 -m 0. connect() caches a dst that
was looked up with sk_mark 1001.

opt.mark.ena is set, so ca_write_cmsg_u32() still sends an SO_MARK cmsg
with value 0.

The only policy rule in the script matches MARK:

ip -netns $NS rule add fwmark $MARK lookup 300
ip -6 -netns $NS rule add fwmark $MARK lookup 300
ip -netns $NS route add prohibit any table 300
ip -6 -netns $NS route add prohibit any table 300

That means mark 0 and mark 1001 both go through the main table to the
dummy0 route.

On IPv6, ip6_datagram_send_ctl() sets ipc6->mark_set for any SO_MARK
cmsg. With mark_set, udpv6_sendmsg() does a fresh lookup:

    if (ipc6.mark_set)
        dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
    else
        dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);

If the zero-mark handling were missing or broken, say mark_set was only
set for non-zero marks, the send would reuse the cached main-table dst.
It would succeed either way. ping_v6_sendmsg() behaves the same.

The IPv4 and raw mark 0 cases don't use a socket dst cache on this path,
so they can't tell the two cases apart either.

The paired kernel fix ("ipv6: fix cached route reuse for SO_MARK control
messages") mentions "including an explicit zero". These cases expect 0
in both situations, so they only check connectivity.

Could a rule be added that prohibits mark 0 with a full mask, for example
fwmark 0/0xffffffff lookup 300? A plain fwmark 0 gives a mark_mask of 0
and matches everything.

With that rule, connect() with sk_mark 1001 would still succeed. The
IPv6 UDP and ping mark 0 sends would then return 1 when the cached dst
is bypassed and 0 when it is reused, so expected=1 would catch a
regression.

> +
> +	    ip netns exec "$NS" ./cmsg_sender -"$i" -p "$p" -k \
> +		-M "$((MARK + 1))" -m "$mark" -s "$TGT" 1234
> +	    check_result "$?" "$expected" "IPv$i $p connected mark $mark"
> +	done
> +    done
> +done

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104092240.15649-1-yanxia%40cmss.chinamobile.com
