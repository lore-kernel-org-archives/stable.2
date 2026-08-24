Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96046C847;
	Mon, 24 Aug 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590140; cv=none; b=ireBC3r0FQEFmF6ha6XRqK69eHOwWfqRjXUh/LdN56BKH0CPjZ5WDIQ9Ubtv5LSeHpkD5tLZP4kp9HggIr9GIvJPNkKSucU419I6son14kTsyx4ZaFS97bcwErYG4EOBUc6VOCcKhHegrVjj9RSWl/0UOhwl7UT3r8toKlDCoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590140; c=relaxed/simple;
	bh=nclcvAWM+rxAFCIypV1GWTUlmTEbYqtUNG34WGkugFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abtA46oDK/J/1M2BiG/9bg156wxtpMbCRQTfEn9+E8DcdxT5dSlogFW9rcIpLCBs0jg6qH4RUNJXnF+J+p7axHqnCqd7+FGRonYMUFMnJ1hrYG3yO1PG86X6aD5MSCNDdR4RodG5isWobLmCEFQ+xMltl8KtPkmWjV83RSQti8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMYkNJdU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMYkNJdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6B71F00A3E;
	Mon, 24 Aug 2026 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590139;
	bh=DsadEfKHony/UW+E+mkIQ6tS46I5w+msFRIBJzgL6A4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CMYkNJdURsvpvYA/w5PSLua8T+O/xNjcdtXUL+D3CUxxq5naMd2N/fkTy+hrgvUhR
	 JPscYEhvQazF0NQym2fPqP1H1AYftdINlrasi4IV+bUH0LytUMRcnJeNhPHJ09tyzB
	 7f+b34uGDyhQEkV+JxS2ScUlVhjZlE7J75bQxPxNCe855GxamJaeuBc/pjeoWijSY2
	 32y+IUsAZsnLvO3DClV4ynFLgSwlCAlgCmcfm5DZ4LQbkHv15YdNuuOn5KdywdE1hS
	 sr/iq223X+1eTXD04aReA3dvc9AtUXmWWpjaKvvzbcPZ2n2bL4XN8beNIOV/2sdDFQ
	 /f3gDjjXfdR1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:26 +0200
Subject: [PATCH net 06/14] selftests: mptcp: fix an UAF in mptcp_connect.c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-6-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VwiIPbnwYQK4JDHlSn3SFDG8QpIppPrQ9GfT9gtOoC0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sh8u9+VecGaR3Gq3mcZrRKZfeBPLf2fByo1/FXwNT
 qyr0Jef0FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRpwsZ/kqflLM+8U9td94C
 I29dt20vPZRmhOjV/DcV0+t3dugSPsTI0Dtn5kbf9p4Tzx/un/16QnV3/PXv64NPHeYwWfG2aO2
 3cmYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)',
the 'peer' pointer (which points into 'addr') remains. Later, the main
loop uses this peer pointer for reconnection attempts. If the memory has
been freed and reused, the address data could be overwritten, resulting
in an invalid remote address.

This patch keeps the addrinfo list allocated for the whole process
lifetime so "peer" remains valid across reconnects; the memory will be
released at exit() time.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..178d98d91fea 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -381,6 +381,9 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 
 	hints.ai_family = pf;
 
+	/* Keep the resolved address alive for the whole execution: it is
+	 * used again when reconnecting, and will be released at exit time.
+	 */
 	xgetaddrinfo(remoteaddr, port, &hints, &addr);
 	for (a = addr; a; a = a->ai_next) {
 		sock = socket(a->ai_family, a->ai_socktype, proto);
@@ -421,7 +424,6 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		sock = -1;
 	}
 
-	freeaddrinfo(addr);
 	if (sock != -1)
 		SOCK_TEST_TCPULP(sock, proto);
 	return sock;

-- 
2.53.0

