Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E765540A9;
	Tue,  8 Sep 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876882; cv=none; b=RjDiW0k7LuOwl36Uz0akZeUEkfvJmBbSJDL11lBHauWGNB38u47yXD9A2bZA+3xSRxe11nP5VaYHRc6X3eTQ/MCBgDcWJGT5lPf6HggcacPF3IbHVJZ8kR+39CGAahh3UdjhOwK1GLxVMwBPy2wXdF9b2/QbENZvZrDgREWU38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876882; c=relaxed/simple;
	bh=8JjDG2J3jEdCZkbqt3U//6l4ggwme3t78z+VOG5XkDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InMbnZPTqBrTZXMYHGycwhzHkU1tKlLXAC/xFaGLjCPb0JWzwhf08D0wL6UaZu4Yu8eaMWXm9SIguk+XLue+UtjpJw/dWflPPY+I7GfJs6VuseHWjQPh5HjGsCoGhdT+22UzJ5OcaHNoUc4AAtvhsCTB05hnxKl0PNxJsry+vdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLQWE+6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLQWE+6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C9A1F00A3D;
	Tue,  8 Sep 2026 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876872;
	bh=bI1QFqme7+lJ2wpHo1+LquJZx4pXgkY27jmIYw7Nq6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hLQWE+6tYqw8dRYth7l9ETFNf4PHqPHGwio52LkyvJp4WA1DvPuVl66scUUbcAuW3
	 htYbBUVVFYRQcGJjXwkcgbErzmNMAGFLBqgdtex9tzEW6/88eVKni4JF8nk0ClIY0q
	 UKUNaXg+baVlvj8wKYrFsNfI2kkDoItHwe3cl6n3VeUv3ONglLXux/ASJSUCC3b7Uw
	 yDYMpDyV3JbeO8BJpIJt6Ur5TUUN6B2BHHxMzF+nAbqgqTY+UWzOn0YCXfneJEQzMy
	 ZzWlL/uTIdbmHjqwRTYf1Vgd6lvdrqyxlG8AiOIN44D3lpSQViOICNHT9kIhaM9YnK
	 BGxAaxBA9d+0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:12 +0200
Subject: [PATCH net v2 07/15] selftests: mptcp: fix an UAF in
 mptcp_connect.c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-7-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
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
 h=from:subject:message-id; bh=z1iJ73EI6mQ/ELE58y3y+0cCYyNXtjGYVHzqia9Z/wc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSOikTO9ZY3HypsMioRjWrQ0SkvIss+8cDVz7+3ziZ
 XP3BW+MO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYy5wYjw7QvD3b+NjqtVtTl
 /W9+XVN8YN2H4JltDNXfql1Vo/L29TMyzE8tOZx2Tv3FSafMrNiXAcrbOFlmXJr4PuFXT6rwIYN
 MDgA=
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
2.55.0

