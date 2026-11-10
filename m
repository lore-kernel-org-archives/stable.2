Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=206.220.120.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291386;
	b=rL+u36c9YYnB876a79tTKrdJ+eSdYD2K3XoTaCYQ4qZm0OoT/lmaC/lf9+5r10rwndKq
	 yWZnnnJoeRWLjQvqTq4Tb5AzAXNLApoAAWoH72MZfmOaHsrIDytPkzUc+Sp1NKaA+/l5A
	 ax1LYaKeKuSlx3ywCXDgWr1GMXOgGirhKNcBq54NSfgrOQvQxBxqBSrrPFLXTWvBpC/3C
	 8vHIpuvIiwF/7ie3got6aHdgrPqMc+8CyaVcXlnLbsMpPBoybTgZeIictmsdHMTwTbGr8
	 +RxZgXXWpzZ436/l6IZZhDS1foA96UOi56tDCCwdX+bMyOePIiv2F06pp3pAaX0TSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291386;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ypmdc9LRw167gugGDg07KkUZquQ3UhxsSBuTy1wAvvk=;
	b=ccd3CgXSCeB54rRu++hHHDPPiJ5IUiPYxVIYnpNFfn0MJwW0TXYMQ9gDRuip3srVzWjc
	 LFHNieo4nExmERx+TaUA8oYgy/IuWtPXGKw5BbOgJwD7nudD0swHa1Dc8RMTVvXh1VweY
	 BcUoMxuxf/KraAx9+Ltd2gi02Sn7dOhR+a2bxhx+5ppJvcgIErNxKTfOyRjobJmhAaaIi
	 RMwzC13hBWSrWlRh7LkF7LZhTzZCdBbuKaWzvUl9SUSE3aPBT3f/wQyqnE9HoLOmka7Vl
	 zynSXUGY+ePUfMCjOSVTtA4Wmm/feUw70GTZDurq8ACQWD/9T1MJ2Z7+4OaW4vmeMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grapheneos.org;
	spf=pass smtp.mailfrom=grapheneos.org;
	dkim=pass header.d=grapheneos.org header.i=@grapheneos.org header.a=rsa-sha256 header.s=default header.b=awO8h0OL;
	arc=none smtp.remote-ip=206.220.120.4
Received: from mail.grapheneos.org (mail.grapheneos.org [206.220.120.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D598606A31C;
	Tue, 10 Nov 2026 06:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D598606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grapheneos.org header.i=@grapheneos.org header.a=rsa-sha256 header.s=default header.b=awO8h0OL
Received: by mail.grapheneos.org (Postfix) id 891863C08EF80;
	Tue, 10 Nov 2026 06:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grapheneos.org;
	s=default; t=1794291384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ypmdc9LRw167gugGDg07KkUZquQ3UhxsSBuTy1wAvvk=;
	b=awO8h0OLfJTzQLAJ8FTFK1aRK/cgSbpFxHHrtwcyU9kTj9pExCZeRlHxw+UTWdZlpdt646
	nQbVlZ2BJB15iklJRmFOuOEzVtkI3nhtIwuDcjkkkjJ2BHkAmhVGytuI14b68MS0j+6w/T
	W6H4OXUGChe/xyyWMx/6ABQqTeXvJO2wLR3DO9KGa5ErF5N2fjJaF0928Xnq24mzJoG4G3
	WzqB9JXppEb2d0u4vFRvxdSU6Dyu31MMocxJzh23pId8LwRuuYFkksopIQ+FUo+iCyI41Z
	5LO1UoFvb/JSjQhzR/nOByt7DXVjD2T33Wr3hwtD/XSvc9P7Y+pNKRaZ80uvqw==
From: liamsmith827 <liamsmith827@grapheneos.org>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liamsmith827 <liamsmith827@proton.me>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] selftests: net: test restricted on-link fallback
Date: Tue, 10 Nov 2026 06:15:35 +0000
Message-ID: <20261110061536.10811-4-liamsmith827@grapheneos.org>
In-Reply-To: <20261110061536.10811-1-liamsmith827@grapheneos.org>
References: <20261110061536.10811-1-liamsmith827@grapheneos.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liamsmith827 <liamsmith827@proton.me>

Update tests now that the on-link fallback has been restricted to
routing lookup misses for non-vrf unicast.

Cc: stable@vger.kernel.org
Signed-off-by: liamsmith827 <liamsmith827@proton.me>
---
 tools/testing/selftests/net/fcnal-test.sh | 47 +++++++++++++----------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index a50609535fed..c048d5be139d 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -619,17 +619,29 @@ ipv4_ping_novrf()
 	run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
 	log_test_addr ${a} $? 0 "ping local, device bind"
 
-	# loopback addresses not reachable from device bind
-	# fails in a really weird way though because ipv4 special cases
-	# route lookups with oif set.
+	# loopback addresses not reachable from device bind, unreachable default route
 	for a in ${NSA_LO_IP} 127.0.0.1
 	do
 		log_start
 		show_hint "Fails since address on loopback device is out of device scope"
 		run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
-		log_test_addr ${a} $? 1 "ping local, device bind"
+		log_test_addr ${a} $? 2 "ping local, device bind, unreachable default route"
 	done
 
+	# loopback addresses not reachable from device bind, route miss
+	log_start
+	setup_cmd ip route del unreachable default metric 8192
+
+	for a in ${NSA_LO_IP} 127.0.0.1
+	do
+		log_start
+		show_hint "Fails since address on loopback device is out of device scope"
+		run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+		log_test_addr ${a} $? 1 "ping local, device bind, route miss"
+	done
+
+	setup_cmd ip route add unreachable default metric 8192
+
 	#
 	# ip rule blocks reachability to remote address
 	#
@@ -643,10 +655,9 @@ ipv4_ping_novrf()
 	run_cmd ping -c1 -w1 ${a}
 	log_test_addr ${a} $? 2 "ping out, blocked by rule"
 
-	# NOTE: ipv4 actually allows the lookup to fail and yet still create
-	# a viable rtable if the oif (e.g., bind to device) is set, so this
-	# case succeeds despite the rule
-	# run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+	log_start
+	run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+	log_test_addr ${a} $? 2 "ping out, device bind, blocked by rule"
 
 	a=${NSA_LO_IP}
 	log_start
@@ -671,10 +682,9 @@ ipv4_ping_novrf()
 	run_cmd ping -c1 -w1 ${a}
 	log_test_addr ${a} $? 2 "ping out, blocked by route"
 
-	# NOTE: ipv4 actually allows the lookup to fail and yet still create
-	# a viable rtable if the oif (e.g., bind to device) is set, so this
-	# case succeeds despite not having a route for the address
-	# run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+	log_start
+	run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+	log_test_addr ${a} $? 2 "ping out, device bind, blocked by route"
 
 	a=${NSA_LO_IP}
 	log_start
@@ -692,10 +702,9 @@ ipv4_ping_novrf()
 	run_cmd ping -c1 -w1 ${a}
 	log_test_addr ${a} $? 2 "ping out, unreachable default route"
 
-	# NOTE: ipv4 actually allows the lookup to fail and yet still create
-	# a viable rtable if the oif (e.g., bind to device) is set, so this
-	# case succeeds despite not having a route for the address
-	# run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+	log_start
+	run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+	log_test_addr ${a} $? 2 "ping out, device bind, unreachable default route"
 }
 
 ipv4_ping_vrf()
@@ -1602,10 +1611,6 @@ ipv4_udp_novrf()
 	run_cmd nettest -D -d ${NSA_DEV} -S -r ${a} -U
 	log_test_addr ${a} $? 0 "Global server, device client via IP_UNICAST_IF, local connection, with connect()"
 
-
-	# IPv4 with device bind has really weird behavior - it overrides the
-	# fib lookup, generates an rtable and tries to send the packet. This
-	# causes failures for local traffic at different places
 	for a in ${NSA_LO_IP} 127.0.0.1
 	do
 		log_start
@@ -1613,7 +1618,7 @@ ipv4_udp_novrf()
 		run_cmd nettest -D -s &
 		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV}
-		log_test_addr ${a} $? 2 "Global server, device client, local connection"
+		log_test_addr ${a} $? 1 "Global server, device client, local connection"
 
 		log_start
 		show_hint "Should fail since addresses on loopback are out of device scope"
-- 
2.47.3

