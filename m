Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792999391;
	b=f0ktxxRJ7/7lJgUvXLP7I810cBtVjhPeJWTA3MagaVoMpkkHU25Wfr0AuVi/z6o2/O+D
	 cKuswE4qkCFh2m5fN/tMG658DlUElbo82ISpGIfPGUrKQTYvZeEl35XLuWPs64RnTEL4Q
	 ixcpviYiGFXJEYXkTMGvAnLoWiBNArgPFZADjuf/MlJ5Bb3nWHGSJJYaA8gaKQcNzg+s/
	 BNgdt7f6jIBLENwxrPt01Bmol0Owj2lRo6ZQn0CQSg816hsfL030xdFPeR1MywrtsyXeo
	 Hjb636/CEvaZeGBW4hMzDc4w8oi1Rt0b5C3tgQFecoJEh/ZMtdi8O0aJZ91Wj0cWEbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999391;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hdoxCROF22ZPqUPMUDtk3Ya/rjSguXnAXbrfTEBlp40=;
	b=KlrO+T/7Thzfrtyq+qkKG7mUPQY0k0MKGkBZVD97YVwSuDDMyTQSz6oLVmgSp5pcFPGE
	 EdEvVqlO0GmYSHkV7FlWiBj7gj7MJ920BR7qhATW6xPovT4l3hPT2U1AZU38Ecy81VZjM
	 BvSoHdf49vium8S0PmfH5OdoFTx9m8xIahBn5WD4iFZxG6XuMfLa0tPT0UHOgegUu0G9p
	 NOGLIvGSlSbLWRQ/QjNizkKlW9nr5FxAl5RxGEBtVpsUNKF1A/fZKbT+qteNa864evGhp
	 fIF9ZCPY6PxVaNFNkHDRsC3qMQf310qLGcXyQo6pX+1gXlc82f9LMwqWuwUDKdQen9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euVW7Bqy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B1606A31A;
	Mon, 26 Oct 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euVW7Bqy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792999391;
	b=XlI+tS32Z8zC1w9x+D8E+PsbYz+7WTMypecaD7s1ohA3jqAOi3sCo1uRxnrW0oFnxUtM
	 7rzuS69mttxyV3FhO+flUvt8N7nZPwOgXTm8xqVBD+tIidoxq8vJ/Y6ja+C4LJVrqd552
	 rLhZ2DYAc8bDyNLk6uq69HfM6l7G1Ooee/7pf3XozB9aYDUTdqdjz29BIbgO7oOcxTlk2
	 9CZtjlSrH9rWFGLtHAjTdveKmw8Ec7s+5W+BzXaDXNMx4hW9KhGRMwDU6kbEe+lgWLajc
	 l7iRP6H3QM/9Yh5t+xJkULvK4JgFN+MEyPQeMrnq1HLo0dqcPpNArlA4DHXQ7y/ITtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999391;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hdoxCROF22ZPqUPMUDtk3Ya/rjSguXnAXbrfTEBlp40=;
	b=C9RA12i11mgP87Y8RxojEgyxTp7k0Kd6CiKKI+BwRhRrv9AEn/gWCk/b8x9ZVaV6jyX0
	 73TXCvKG0C7NT+mzxEmIH6YUxnyeZ8tRFK2we46opKy/1m6ljx/om+lLWD/INanjznNIl
	 cG+2wMziN+xUdIqcf7z8balrT2vOwP2ePSHuSn7/GWIY3NOubXoiQ7UEi3dK2GmtefyC1
	 RnxXRZIacg0Kq/G6ef60mM2NxK/6PG19ZrKYip/Inf6kclQbbaesqrU+oD8iaJn+R3RqE
	 zdgbJbtmt9xzRZp3wqY1AM1PYhOshkSPrmWf4qKfY62mJht3Pq6DptUMNLJgZ+Ai7iQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4E6391F01828;
	Mon, 26 Oct 2026 07:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999390;
	bh=hdoxCROF22ZPqUPMUDtk3Ya/rjSguXnAXbrfTEBlp40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=euVW7Bqynryrrl1skxfTnbEHpBoDLpaNw8NUUBpwbk8F3286pWt+YFUMLwWNQ8/c9
	 TRhhqKhe/lp2NZx8HXsSxqtUb8w4RT1MnQAYtlD7F7zo3iJSmZo6jogvVGJ6erRgLS
	 7iMxnA72Dic2Dq0dpKrlSKlBNl8KWtrI10DGo3vcOLru4W2y6pywR+SoAcklVMdrF7
	 KcHgmZPHbJr8YhMgfjPRNMEZbITtyfyXmYV4ZOega4Qqie3Invt5t5qiPulHXZrtvg
	 +cfmZkKY8+nE+2H3sJs7c9Z4MAi5ltKvYNurdGiJb83SuD6eE/0Eh8TSI7zXY7zIpA
	 tzXuD2Lc78nrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D04B344C47;
	Mon, 26 Oct 2026 07:23:09 +0000 (UTC)
From: Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 15:23:08 +0800
Subject: [PATCH net 1/2] Revert "selftests: net: packetdrill: add tests for
 advertised MSS with PMTU exceptions"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-advmss-revert-v1-1-272fa4b7ecb6@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
In-Reply-To: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Esko Mobius <echoowall@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792999388; l=5480;
 i=echoowall@gmail.com; s=20261026; h=from:subject:message-id;
 bh=uFnONYx2E6brR0l6+uJjUZUsugs/bXfH+6zBoDLWc54=;
 b=ULddStXmSXwCyHaZ46Fz3sv7//3MUR2oEh/dcoU8rRoKUg6NFa32swzD10M6rBqiBLz6pxB/j
 8ErFryqgmZfDuAGhVRXuNpw3laLQd4RMH3tfo21TFP6t+nVr47rQerU
X-Developer-Key: i=echoowall@gmail.com; a=ed25519;
 pk=9XP6JhqjjPsHCF6UZZZTeqTRnXIa4+ufggnxXtTJ+no=
X-Endpoint-Received: by B4 Relay for echoowall@gmail.com/20261026 with
 auth_id=1323
X-Original-From: Esko Mobius <echoowall@gmail.com>
Reply-To: echoowall@gmail.com
Content-Transfer-Encoding: 7bit

From: Esko Mobius <echoowall@gmail.com>

This reverts commit e5c8e301b497 ("selftests: net: packetdrill: add
tests for advertised MSS with PMTU exceptions").

These tests assert the behaviour introduced by commit 2640e6419594
("net: advertise TCP MSS from the configured MTU, not the learned
PMTU"), which is reverted in the next patch because it causes a
regression. Remove them first so the series stays bisectable.

Signed-off-by: Esko Mobius <echoowall@gmail.com>
---
 .../net/packetdrill/tcp_advmss_pmtu_ipv4.pkt       | 67 ----------------------
 .../net/packetdrill/tcp_advmss_pmtu_ipv6.pkt       | 67 ----------------------
 2 files changed, 134 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
deleted file mode 100644
index f2ef931b7..000000000
--- a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Test that IPv4 advertised MSS in SYN-ACK is derived from the configured
-// interface MTU (1500 -> MSS 1460), not the ICMP-learned Path MTU.
-
---ip_version=ipv4
-
-`./defaults.sh
-ethtool -K tun0 tso off
-`
-
-//
-// Connection 1: Learn PMTU exception (MTU 1200 -> MSS 1160)
-//
-    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
-   +0 bind(3, ..., ...) = 0
-   +0 listen(3, 1) = 0
-
-   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
-   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-  +.1 < . 1:1(0) ack 1 win 257
-   +0 accept(3, ..., ...) = 4
-
-// Send a full 1460-byte segment
-   +0 write(4, ..., 1460) = 1460
-   +0 > P. 1:1461(1460) ack 1
-
-// ICMP Fragmentation Needed arrives indicating next-hop MTU 1200
-   +0 < icmp unreachable frag_needed mtu 1200 [1:1461(1460)]
-
-// Local host retransmits using the learned MTU 1200 (MSS = 1200 - 40 = 1160)
-   +0 > . 1:1161(1160) ack 1
-   +0 > P. 1161:1461(300) ack 1
-   +0 < R 1:1(0) ack 1461 win 0
-
-// Close connection 1 and listener
-   +0 close(4) = 0
-   +0 close(3) = 0
-
-//
-// Connection 2: New connection from the same peer
-//
-   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
-   +0 bind(3, ..., ...) = 0
-   +0 listen(3, 1) = 0
-
-   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
-
-// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the learned PMTU MSS 1160
-   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-   +0 < . 1:1(0) ack 1 win 257
-   +0 accept(3, ..., ...) = 4
-
-// Verify: Outgoing transmit MSS is still constrained by the learned PMTU 1200
-   +0 write(4, ..., 1460) = 1460
-   +0 > . 1:1161(1160) ack 1
-   +0 > P. 1161:1461(300) ack 1
-   +0 < . 1:1(0) ack 1461 win 257
-
-// Clean up
-   +0 close(4) = 0
-   +0 > F. 1461:1461(0) ack 1
-   +0 < F. 1:1(0) ack 1462 win 257
-   +0 > . 1462:1462(0) ack 2
-   +0 close(3) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
deleted file mode 100644
index c7638b11a..000000000
--- a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Test that IPv6 advertised MSS in SYN-ACK is derived from the configured
-// interface MTU (1520 -> MSS 1460), not the ICMPv6-learned Path MTU.
-
---ip_version=ipv6
-
-`./defaults.sh
-ethtool -K tun0 tso off
-`
-
-//
-// Connection 1: Learn PMTU exception (MTU 1280 -> MSS 1220)
-//
-    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
-   +0 bind(3, ..., ...) = 0
-   +0 listen(3, 1) = 0
-
-   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
-   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-  +.1 < . 1:1(0) ack 1 win 257
-   +0 accept(3, ..., ...) = 4
-
-// Send a full 1460-byte segment
-   +0 write(4, ..., 1460) = 1460
-   +0 > P. 1:1461(1460) ack 1
-
-// ICMPv6 Packet Too Big arrives indicating next-hop MTU 1280
-   +0 < icmp packet_too_big mtu 1280 [1:1461(1460)]
-
-// Local host retransmits using the learned MTU 1280 (MSS = 1280 - 40 - 20 = 1220)
-   +0 > . 1:1221(1220) ack 1
-   +0 > P. 1221:1461(240) ack 1
-   +0 < R 1:1(0) ack 1461 win 0
-
-// Close connection 1 and listener
-   +0 close(4) = 0
-   +0 close(3) = 0
-
-//
-// Connection 2: New connection from the same peer
-//
-   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
-   +0 bind(3, ..., ...) = 0
-   +0 listen(3, 1) = 0
-
-   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
-
-// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the learned PMTU MSS 1220
-   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
-   +0 < . 1:1(0) ack 1 win 257
-   +0 accept(3, ..., ...) = 4
-
-// Verify: Outgoing transmit MSS is still constrained by the learned PMTU 1280
-   +0 write(4, ..., 1460) = 1460
-   +0 > . 1:1221(1220) ack 1
-   +0 > P. 1221:1461(240) ack 1
-   +0 < . 1:1(0) ack 1461 win 257
-
-// Clean up
-   +0 close(4) = 0
-   +0 > F. 1461:1461(0) ack 1
-   +0 < F. 1:1(0) ack 1462 win 257
-   +0 > . 1462:1462(0) ack 2
-   +0 close(3) = 0

-- 
Git-157)


