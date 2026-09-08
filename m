Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698C552920;
	Tue,  8 Sep 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876897; cv=none; b=IeVRKYmab1us0tQD/b1i6cjSBQWgTUpjhAKF9GA161gUd2WMIg+BweS6WKJVFw3anfj2mYVa4ScqDgquJnoYTZgRI5SMELmfLxLmh2o1HucVd2ri0DQSEoBEzs+kAMbRVWjRkxP+IaM5hJDM0T1Vx5EqObpxAf9xBAZYmFwm8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876897; c=relaxed/simple;
	bh=CCaezY8L2QGxE1d8YVG+RIwjuxy2v9Yrtn18wTD4RmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qETOOV5akPjrL96Xp/L1zRVbgHNk3yjLfXjqhPpRuE96OZyXELHOTCZphLeA1lqftyRHrls94Rv3mRg6ebcw6S3KDs2yOYlbnWtuj3/GHX1qB5k1V779Ozmtcj1QpwyP1CN+dMKS2+UPzy/PDe3OMdv97gF/QlXSLiZoDfKFxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io/D9wmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io/D9wmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71441F00A3D;
	Tue,  8 Sep 2026 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876885;
	bh=nt14iCy2+3ATRgf1ASvH3cbgbaTCA1uqYuD/SL6AALg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Io/D9wmqvKDw1HZ1UlOpw5WRs7Sh6y9emFzUX4mzxqWAySra1rXI6rB1/4DC1rqAH
	 6Znug0rgJRb1OPQEYwVey3PQOX2Y4ocrVd97Bkd/hjh67Jzprn49EIrZlTrOX2CRMZ
	 SyhrM5sek0LbHmdLUNAwmcxpfkhBwQCmBkPUThQj/J+4e6sIwPP3p3/OfRvuLWZFIa
	 0jXqRqD8LQbxBJYR1GWUAa6T+7Bq8dSf5qPiEgtPmRWuitqiSyW6yy8cfYIodpdk1X
	 u6jpv9ft2MkM2s0bFomst1VwMxpA6mZdhNqpqTQf6BNGB0K5uckYGjKzRh40uvE8GU
	 nqanft1mRZ4/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:17 +0200
Subject: [PATCH net v2 12/15] selftests: mptcp: lib: get counters for the
 right test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-12-df1de70348b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CCaezY8L2QGxE1d8YVG+RIwjuxy2v9Yrtn18wTD4RmU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSBiobq1dpMO9br3wvYJVXypndW95emFXX17n6Vkv7
 l56N2nnzY5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJ6L5g+Kd8YBfTnLpnqw4I
 zbV2+1xjpnAnadKhoI4rU9yz5Pkffa9hZPgtnOV7NnSdhhR/b2bPK8PTMtFaiUVLpsjFG7l1XDg
 YxwAA
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
2.55.0

