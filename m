Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635C513552;
	Tue,  8 Sep 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876899; cv=none; b=WWbMagBfSQSP6g/C2yRjxJQgL6bxoqj5J28AwkHiGMSVoX660T69MEcfUaDCr9tgfcHnD7F6CZr/wFo0RbA3iGmy2uIE+kOhsyf3c9Gl9xoJHLXYuk3oR5emh4F6qWTBRaLuU83paaI0LZ/U+ZyAmzyhcOPzR37in9qasY6Aw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876899; c=relaxed/simple;
	bh=c5IXRGjuz0fSPa4V5Xz2gLhzLB899t5Sk/STYYx7jXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCwMmkQvUcqUt6+IJHpK2/781tKhYbIghMMUwkHKJhudQCTT84HdwG9oD4zXdP/NaWv4IAPmCYRNusc14FbJVObItfGpxs5qrk7LuEoqOZm/PrSgulqyjDHerYyn2r9+3g2NUA691V7K587N84QEIPVfsb0cQxGgfloE7qEX0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlb8d3lD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlb8d3lD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454511F00AC4;
	Tue,  8 Sep 2026 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876882;
	bh=oCwaDeVCnMEOM3Suj5i1JtmGB4sF4AjuaGS8MXJAUMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zlb8d3lDTI3j816xJQJWU2xsXUNOVRup5KU1RLEIL58RlxNK+7SyN4rJznxthjVG/
	 /hO69OTWrjMJz6H+GNRRhipxbdkuaV46BDgDAGvGrUV5xujkUn1mfX+ghYNZTN5SIr
	 sqWDDpph/e3ajmp3/5Ab4yL321L97YWJ64fwDLYzYgwXNEHlE61RRNzSlVgFE+ug3G
	 nRcabVn2QNEduwG/6dirafSmylmoXuyCRVljrPTnq/z+t9CDqsFULCbTzyV1k0x8LJ
	 NJu0x8kxXjOFIFKkzD161xXQePYvtoxTTBpar9nXtVOtkmgoKmiRMfvOmxEYGlzHZ/
	 4p8JhfP6j/PaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:16 +0200
Subject: [PATCH net v2 11/15] selftests: mptcp: lib: dump nstat for the
 right test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-11-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
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
 h=from:subject:message-id; bh=c5IXRGjuz0fSPa4V5Xz2gLhzLB899t5Sk/STYYx7jXw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSOgryodM9s04z7lPMDnAMvvlpKrsSPPjocFmi60MZ
 Rjap6ztKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEhCIMN/Lxk1dYnHonoR/3hM
 /t1ee96rfUHMBK9Dbn7b/PYwXjbaw/BX0qX4zP8GGUfN1RpFJrpcHK/1/61kOXRP4d67BxZcB9M
 4AQ==
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
2.55.0

