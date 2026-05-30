Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7693ACA57
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141766; cv=none; b=pAs+4QVEV4HAXjTYRDaF/UDacjNnG8HmxI6xXCXzziNK1Qn5f/4hNx1f3z1F31ti0DmBVFm0RFxs4fA+poIavXDXYoGPZ5M9ulxzxd5GgJKgrDudws9Rn9Ec5fGT9tzJBzGhfVRYqfclrmKYNdRTvsAPoCMLr6YpWtMvxawDHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141766; c=relaxed/simple;
	bh=h4UcprwXE/uf04JxiYKhpQQkVGWjcezthGonkaUWuA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO5mi1hpn7IcULimGgHmUoDN0Pk0LTnpOZQgW8IHlT8gChsa7mmakELu0e6kZyPZv38qNGmNz0u2OdLWBvi1Nxy+RWF80pmTlPk1Fpveiwj1dWkgtXRcXekzOHiWExWcgKOzzqJdsz6/lhZxZRGDoofLybdaSuV3Pf7mZkd5cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeSAsJUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeSAsJUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C13D1F00893;
	Sat, 30 May 2026 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141765;
	bh=o9ZmF8wbY90lAY3pW8zUQD3a6Vc4kDYgLIW5pHRkHWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AeSAsJUl32tkiR0hXmXMZqA+P/1IwfRKYijRQXZt9vZrYr0c4SM0XwH8cBDbLACxV
	 sCHfe+uZTTEPDXw4KeEZ88Do36WglBueb+SqMr4Ix3JJjfcRuaN1eHQ2HzGK57fqZu
	 b+EqoSp8mfKXkqdK+pj2SrzepVxaGo0NKUlSnbIzhjk4tFY+BzmXv/XR/9NtiIxq8Q
	 CE0+lsFu6/v7QqQZXgLt37OOxdy1jkKoRidUjoP3fMvoMgL2CrSzSmvToaa0iQorbo
	 33DrTvycOyN1XueOp41CHkVMMpd9AiHhSu8pWPW4Z5iMbs0Z3VdyAwW3+lZppG4Lto
	 MZUtpJ/5Elo1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: drop nanoseconds width specifier
Date: Sat, 30 May 2026 07:49:22 -0400
Message-ID: <20260530114922.1970609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052827-mushroom-undercut-d57d@gregkh>
References: <2026052827-mushroom-undercut-d57d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 01ff78e4b3d98689184c52d97f9575dfbdc3b10f ]

Using the format specifier +%s%3N with GNU date is honoured, and only
prints 3 digits of the nanoseconds portion of the seconds since epoch,
which corresponds to the milliseconds.

The uutils implementation of date currently does not honour this, and
always prints all 9 digits. This is a known issue [1], but can be worked
around by adapting this test to use nanoseconds instead of microseconds,
and then divide it by 1e6.

This fix is similar to what has been done on systemd side [2], and it is
needed to run the selftests on Ubuntu 26.04, containing uutils 0.8.0.

Note that the Fixes tag is there even if this patch doesn't fix an issue
in the kernel selftests, but it is useful for those using uutils 0.8.0.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Link: https://github.com/uutils/coreutils/issues/11658 [1]
Link: https://github.com/systemd/systemd/pull/41627 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-6-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f475b27185dec..89a6ee987ccc6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -434,7 +434,7 @@ do_transfer()
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
 			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -447,7 +447,7 @@ do_transfer()
 	local rets=$?
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -463,7 +463,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-- 
2.53.0

