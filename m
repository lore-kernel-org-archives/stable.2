Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C346F4A3;
	Mon, 24 Aug 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590153; cv=none; b=NcuT/2/cI1TTZ9x43Cm+7ZKlyYjkJYKFo1taJ197fHEKIz/z8z/ncy957IG/qp6uK4YxNcqhl8PF+xrIKZHwh3m8xySduIrtZzojqvnHN7DuRt6G5jaWUD7/t5aY3kOxb5BBLyVa/bcDXHpPF32R0vg448PSlMQdd6d0h9zJVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590153; c=relaxed/simple;
	bh=wFmWTAStTX7XmhsLRsns8ZJ1prYglytuM+Wjni22LNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTVPWmGX9492i4SkE0/NoJqSsi1CXavgR86ekWBeRqAGN3GWJMT4Oj0L+jSS4CST4XYWBARGyzCWZYX/zya7LHSPe2e1Ez1v4TdBGoKXG5FeUHWsZceqhhV3MlE/UG80oSrRAF1uwyEJMCWS7TeuSffQ8ZN5t5DptFKUBF05k+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJvaQGsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJvaQGsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC181F000E9;
	Mon, 24 Aug 2026 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590152;
	bh=dwAlsNpTCLO14qYMOvaje6gEA6ADvo64fj1m9jk6zjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MJvaQGsEqk5Aucv4DqzheTC0dLPIBEx4pVJOYQIkNaxD0zTNMx7tdhQbXtZxt1m/+
	 Ze0V7lWYFBrH8xKHR0wAkLSLnvRTlLY1ZVg1mvlTNUQRzMu7Hg6wQQwrLJE8wr68e+
	 BLil4q/PwoyoKXyThdaBfQ+jfcywOuzRMpFhzsPpEq97cQIGYTxvXWHaBvgyns2cqY
	 lxVks2ljBd26M8iSNx68avsdaL0cnSpR1jm/rohLBuoeewQiqBjBlwngqkBil5RrBS
	 rcFAHuWAq2ZpFpZCe5uEh1xoud33CGiXqg5ceCSbqLnJU1+MAPt+xu1pgYARLAgiIt
	 TOFdCTTc7X5TA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Aug 2026 18:48:31 +0200
Subject: [PATCH net 11/14] selftests: mptcp: lib: get counters for the
 right test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-11-a92309d121ca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wFmWTAStTX7XmhsLRsns8ZJ1prYglytuM+Wjni22LNU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ6Sp9Uq8emLp9ucfDO2oj5NxqWTdzxco7mIbufxky3G
 GTvzix+2lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR7v+MDD97XIQe3956xU9r
 K++i3S86l26eM7Hsn35DUilL7YpfMuIM/8Pa3t0vmBVdteD2wmd5C36rnuD5du/OjKLEdVKG02L
 Lt/ACAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the value for a MIB counter is required, mptcp_lib_get_counter is
called. It tries to use the cache, if available. If not it falls back to
calling 'nstat' directly by looking at the absolute counters.

That's an issue for tests that don't recreate the netns for each
subtest. In this case, 'nstat -a' will look at the counters for the
netns.

Instead, it should look at the increment for the current test, by using
the history recorded in /tmp/<ns>.nstat, if available, and not using
'-a' which was dumping the absolute values.

While at it, rename the previous 'hist' variable to 'cache' as it was
used to look at the cache, not the nstat history.

Fixes: 71388a9f331d ("selftests: mptcp: lib: get counters from nstat history")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index da1da414c30f..b9d14647f401 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -416,19 +416,21 @@ mptcp_lib_nstat_get() {
 }
 
 # $1: ns, $2: MIB counter
-# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if available.
-# If not, get the counter from nstat ignoring any history.
+# Get the counter from the cache (mptcp_lib_nstat_{init,get}()) if available.
+# If not, get the counter from nstat ignoring any cache, but using the history.
 mptcp_lib_get_counter() {
 	local ns="${1}"
 	local counter="${2}"
-	local hist="/tmp/${ns}.out"
+	local cache="/tmp/${ns}.out"
+	local hist="/tmp/${ns}.nstat"
 	local count
 
-	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
-		count=$(awk "/^${counter} / {print \$2; exit}" "${hist}")
+	if [[ -s "${cache}" && "${counter}" == *"Tcp"* ]]; then
+		count=$(awk "/^${counter} / {print \$2; exit}" "${cache}")
 	else
-		count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
-			awk 'NR==1 {next} {print $2}')
+		count=$(NSTAT_HISTORY="${hist}" ip netns exec "${ns}" \
+			nstat -sz "${counter}" |
+				awk 'NR==1 {next} {print $2}')
 	fi
 	if [ -z "${count}" ]; then
 		mptcp_lib_fail_if_expected_feature "${counter} counter"

-- 
2.53.0

