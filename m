Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52946EF65;
	Mon, 24 Aug 2026 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590151; cv=none; b=d/smm23ziPpFMUdjaLGGAhK5L2gx7vF493AgeoaRsiNsvkOfX2acGIhjPe/LXOZdP8E7WFMF/wqyNshSLor0KH2uQHx7KdmFWHPYtAEobuBwemS9G/p2hZQFm3tZWl/ejPbRgypRepSVmh0hGGvb0zshmydn1pRVPtYL99tRXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590151; c=relaxed/simple;
	bh=VwiADovx0M3SfhMosDIPq18c1t7jCdFuJKetSuohDbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHdZ5rvqwqO5GUufw89WcprM6BldEfNZLsgvdtQLlDI3/CGzcml3kT88Xb/98qupKP/o/NTyYYjwTyNMF53pFYa0Wb1tlITtx6AENfcd5vKdl/RKFiv0QCE34iAU9pbJC6IqebUAUo4Py/ptuxRxiab9Tnypx7z8/pqUP9WMkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ2ObGqv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ2ObGqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B72F1F00A3D;
	Mon, 24 Aug 2026 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590149;
	bh=OVO1Lrh+Hiat6g54B8rauSX2MJAQBUJFTOBLlbhcSpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fQ2ObGqvjo7cZR4H0OxQnLfIQuRh+bpitZWhkdqnAnGuqB1+2Z2Ytz7nD+vPB+Bbu
	 KsdJ3q9bAahd1LV4YCBNtUH/wVOMQzmX0GIRue7BF3WpDf+oQKpTO4uUqwW7BjkSb/
	 YPs6HGSgAdrSM499qYE9QmWqdjB3urBQB88twB0HZ4ZLa4kcpawVyZ12+dv7Aec+pa
	 HSfOectSYCFxjNf36jh7AITWFaabxRvNvSKa04i2LtsmmJS+fDLcSfWBlScuv35xaK
	 m6FaXE9RmaoYT9xLJp8Q1ezDMs81wH8kl0Tz22Le9Vbf+7OYqVXjhi/EB8oVBaGzGy
	 SgH5OHZ4ispuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:30 +0200
Subject: [PATCH net 10/14] selftests: mptcp: lib: dump nstat for the right
 test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-10-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-0-a92309d121ca@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VwiADovx0M3SfhMosDIPq18c1t7jCdFuJKetSuohDbc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sh87nl7XHu1Q23Sk4meEY9cNT52rXvqH+ycqnBfcv
 C1z62fxjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInYTGRkeLq09pFQz/Lvtn9P
 X3wz49jXTfwKZTf5z8bk18dWyEqbhjMyTAkM4uz+XRA2l+XzLD3lAI/+2vW6y51OX0/v+397l/t
 mXgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, mptcp_lib_pr_nstat is called to dump the nstat
counters, but for some tests, it was dumping the counters for all
subtests, not just the current one.

That's an issue for tests that don't recreate the netns for each
subtest, e.g. mptcp_connect.sh. In this case, 'nstat -a' will look at
the absolute counters since the creation of the netns, making
debugging harder.

Instead, it should dump the counters for the current test, by using the
history recorded in /tmp/<ns>.nstat if available, and not using '-a'
which was dumping the absolute values instead of calculating increments.

While at it, rename the previous 'hist' variable to 'cache' as it was
used to look at the cache, not the nstat history.

Fixes: 658e53141780 ("selftests: mptcp: join: dump stats from history")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5ef6033775c8..da1da414c30f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -108,12 +108,14 @@ mptcp_lib_pr_info() {
 
 mptcp_lib_pr_nstat() {
 	local ns="${1}"
-	local hist="/tmp/${ns}.out"
+	local cache="/tmp/${ns}.out"
+	local hist="/tmp/${ns}.nstat"
 
-	if [ -f "${hist}" ]; then
-		awk '$2 != 0 { print "  "$0 }' "${hist}"
+	if [ -f "${cache}" ]; then
+		awk '$2 != 0 { print "  "$0 }' "${cache}"
 	else
-		ip netns exec "${ns}" nstat -as | grep Tcp
+		NSTAT_HISTORY="${hist}" ip netns exec "${ns}" nstat -s |
+			grep Tcp
 	fi
 }
 

-- 
2.53.0

