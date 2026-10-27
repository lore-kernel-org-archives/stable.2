Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101511;
	b=wgziFpv6HAOAPBKx3tMigJY4zaw8MqpW1uB1wRdKYqCwGQqw/CEbEShAZeCdSIZ3TLma
	 11E8D9YXvdgrOKtIqHAtaHCGVZhxUiLtuOEoiRumgpiXJ9gXDHlrDlYgQ2xv7jjwbPV0u
	 Gz9VsU1sRUodStuji1ft0f5+xRs4EZkvdtClYDEHw1oZx1pHiiYOKK7dBAHzF8lXJLQU7
	 WnjdZHHA6Qijv9c9gvDMPo3Kgb+Hb+o6jOwfjklT40EdS3uyJNh3vHDX1hNqPGeYyVpz2
	 YAr9WbrUtkSZjl/h+hzYZpzXX2jpLC6rGH4Gs1t171853xY6ClDEisT8hIiREbhjG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101511;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=w+micUHMJCLc/lb75lysczApibjwbQk5zFEVurbT23g=;
	b=zdIQZiztsOgqLaNGl7q/CV7euKFsOIgFrVteUroVuAV99A/2lV42bvB9lSjhthdaOZQ5
	 l6yvPys94j6dHgLNHrdPgHowIFK75VHVTWGK5u46m1KHCjUMjpQz856gmTiVfLa0bpKh2
	 kO2ZTExI+R74AxRmRgvfUumGRDcifURIe8wHfZbbOjIqIJAschPBHEQxkL7CwXC4P8gVR
	 7wRf5yuLNyuFd/zEZ0GPNwBlPVSGsKvUA7vChHy8X3U+6uZP9yIZcU6GiQTylNth4GLsT
	 S6PcTcNvGmFaX68eyQs1GBxohAkrjiz/MSfF5nh/Srv3bvRfASkN5F68RCiX01gRohQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JKO0xROa;
	arc=none smtp.remote-ip=91.218.175.176
Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E127606B5EF
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E127606B5EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JKO0xROa
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OYRd2GGQ+I0qeQXyHrVJjv4+JLHcc0nyipskIeZzEDk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793101508; v=1; x=1793706308;
 b=JKO0xROaCSWb3UCrmtd8gHzC9UDCajuqbquvbdi6v3l5T/Y0CExDZXnsNKg0B8kHnqi3AVdK
 lvAhep4Gf3aTSig7Uy0qJp/DT5NxW/BkPMUVXdsdKJhc0lCyUTORouU4pkvW3gm0FdgLqrOfAup
 hSUW2+TohkP7uhOLf7agnhUA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 452bcd924be0fdff;
	Tue, 27 Oct 2026 11:45:06 +0000
X-Mizu-Trace-ID: 452bcd924be0fdff
X-Migadu-Flow: FLOW_OUT
Message-ID: <bf5f8ecd-f2bc-4ceb-bafc-100bf7d7f697@linux.dev>
Date: Tue, 27 Oct 2026 19:44:59 +0800
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
Subject: Re: [PATCH net 1/2] Revert "selftests: net: packetdrill: add tests
 for advertised MSS with PMTU exceptions"
To: echoowall@gmail.com, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-1-272fa4b7ecb6@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261026-advmss-revert-v1-1-272fa4b7ecb6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/26/26 3:23 PM, Esko Mobius via B4 Relay wrote:
> From: Esko Mobius <echoowall@gmail.com>
>
> This reverts commit e5c8e301b497 ("selftests: net: packetdrill: add
> tests for advertised MSS with PMTU exceptions").
>
> These tests assert the behaviour introduced by commit 2640e6419594
> ("net: advertise TCP MSS from the configured MTU, not the learned
> PMTU"), which is reverted in the next patch because it causes a
> regression. Remove them first so the series stays bisectable.
>
> Signed-off-by: Esko Mobius <echoowall@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   .../net/packetdrill/tcp_advmss_pmtu_ipv4.pkt       | 67 ----------------------
>   .../net/packetdrill/tcp_advmss_pmtu_ipv6.pkt       | 67 ----------------------
>   2 files changed, 134 deletions(-)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
> deleted file mode 100644
> index f2ef931b7..000000000
> --- a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -//
> -// Test that IPv4 advertised MSS in SYN-ACK is derived from the configured
> -// interface MTU (1500 -> MSS 1460), not the ICMP-learned Path MTU.
> -
> ---ip_version=ipv4
> -
> -`./defaults.sh
> -ethtool -K tun0 tso off
> -`
> -
> -//
> -// Connection 1: Learn PMTU exception (MTU 1200 -> MSS 1160)
> -//
> -    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> -   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> -   +0 bind(3, ..., ...) = 0
> -   +0 listen(3, 1) = 0
> -
> -   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
> -   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> -  +.1 < . 1:1(0) ack 1 win 257
> -   +0 accept(3, ..., ...) = 4
> -
> -// Send a full 1460-byte segment
> -   +0 write(4, ..., 1460) = 1460
> -   +0 > P. 1:1461(1460) ack 1
> -
> -// ICMP Fragmentation Needed arrives indicating next-hop MTU 1200
> -   +0 < icmp unreachable frag_needed mtu 1200 [1:1461(1460)]
> -
> -// Local host retransmits using the learned MTU 1200 (MSS = 1200 - 40 = 1160)
> -   +0 > . 1:1161(1160) ack 1
> -   +0 > P. 1161:1461(300) ack 1
> -   +0 < R 1:1(0) ack 1461 win 0
> -
> -// Close connection 1 and listener
> -   +0 close(4) = 0
> -   +0 close(3) = 0
> -
> -//
> -// Connection 2: New connection from the same peer
> -//
> -   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> -   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> -   +0 bind(3, ..., ...) = 0
> -   +0 listen(3, 1) = 0
> -
> -   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
> -
> -// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the learned PMTU MSS 1160
> -   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> -   +0 < . 1:1(0) ack 1 win 257
> -   +0 accept(3, ..., ...) = 4
> -
> -// Verify: Outgoing transmit MSS is still constrained by the learned PMTU 1200
> -   +0 write(4, ..., 1460) = 1460
> -   +0 > . 1:1161(1160) ack 1
> -   +0 > P. 1161:1461(300) ack 1
> -   +0 < . 1:1(0) ack 1461 win 257
> -
> -// Clean up
> -   +0 close(4) = 0
> -   +0 > F. 1461:1461(0) ack 1
> -   +0 < F. 1:1(0) ack 1462 win 257
> -   +0 > . 1462:1462(0) ack 2
> -   +0 close(3) = 0
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
> deleted file mode 100644
> index c7638b11a..000000000
> --- a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -//
> -// Test that IPv6 advertised MSS in SYN-ACK is derived from the configured
> -// interface MTU (1520 -> MSS 1460), not the ICMPv6-learned Path MTU.
> -
> ---ip_version=ipv6
> -
> -`./defaults.sh
> -ethtool -K tun0 tso off
> -`
> -
> -//
> -// Connection 1: Learn PMTU exception (MTU 1280 -> MSS 1220)
> -//
> -    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> -   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> -   +0 bind(3, ..., ...) = 0
> -   +0 listen(3, 1) = 0
> -
> -   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
> -   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> -  +.1 < . 1:1(0) ack 1 win 257
> -   +0 accept(3, ..., ...) = 4
> -
> -// Send a full 1460-byte segment
> -   +0 write(4, ..., 1460) = 1460
> -   +0 > P. 1:1461(1460) ack 1
> -
> -// ICMPv6 Packet Too Big arrives indicating next-hop MTU 1280
> -   +0 < icmp packet_too_big mtu 1280 [1:1461(1460)]
> -
> -// Local host retransmits using the learned MTU 1280 (MSS = 1280 - 40 - 20 = 1220)
> -   +0 > . 1:1221(1220) ack 1
> -   +0 > P. 1221:1461(240) ack 1
> -   +0 < R 1:1(0) ack 1461 win 0
> -
> -// Close connection 1 and listener
> -   +0 close(4) = 0
> -   +0 close(3) = 0
> -
> -//
> -// Connection 2: New connection from the same peer
> -//
> -   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> -   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> -   +0 bind(3, ..., ...) = 0
> -   +0 listen(3, 1) = 0
> -
> -   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
> -
> -// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the learned PMTU MSS 1220
> -   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> -   +0 < . 1:1(0) ack 1 win 257
> -   +0 accept(3, ..., ...) = 4
> -
> -// Verify: Outgoing transmit MSS is still constrained by the learned PMTU 1280
> -   +0 write(4, ..., 1460) = 1460
> -   +0 > . 1:1221(1220) ack 1
> -   +0 > P. 1221:1461(240) ack 1
> -   +0 < . 1:1(0) ack 1461 win 257
> -
> -// Clean up
> -   +0 close(4) = 0
> -   +0 > F. 1461:1461(0) ack 1
> -   +0 < F. 1:1(0) ack 1462 win 257
> -   +0 > . 1462:1462(0) ack 2
> -   +0 close(3) = 0
>
