Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4A12CDBE
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100441; cv=none; b=ByrM4v9ZtSUgQODXB9J9L0K5M1kyBnJoY+Ji4ARaLKAVApW2uSc+xiOdSCEHaSIt95KPaLK0TYsHTTX5lwp+090mR9mBphhGSy7WcW3LbyXnkHG2Inj1WrCGYwGHAih0pfW/Zt0UdRwgpYTAzXKK2X6gFdYl1KpkOKLYALv00lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100441; c=relaxed/simple;
	bh=atBOVTZArLt2ZlMKWEbeM7hhocwj4b+DERWd2zxLfzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsq26jic4NvW6FbbufA81VdL+F//mwSE3x3IWM14GkGFkjDpXJ1Z4gfyeTdl1F5sVwNIcz3rbicmKb7Jmg9X2zcWUrFMrlGXHMi/O8F58BSEUjKNoDHjxAtrEhyv0+mF+73+jkzSWWZ3i0gXqZOyLYuBrWAi2KCu2MIo2sGNKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9bexmxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9bexmxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1881F00893;
	Sat, 30 May 2026 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100440;
	bh=tqt1G8tZ8TXYUF49+8inw51UTPUUFLVCJoftDzovAUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9bexmxzFaGIVoa6IKhfguYzzi33+Khsz2i3v5qXiAzwgBsWAW0KSW7tPtXEosj7U
	 /FF5vzAlJQ95HxY/bSJOq/ICMFbdu8pwLvs2KfIt4ok7wrhGQoDGjuTBmDCxwPAfXb
	 OVBwrFl/rlkv5Pk1XmV04xg1mrqcxkd5Tk/EFp5fF12UowIdHWD9F92DIyA0Dz5CPS
	 agJ7fDEBWNNPOXleNt2iyYt5qWHIHbtgT9X6RU2QPV8luh0KDt9EYOMdSAIC8osKSc
	 rJA6e3/tRUSvzZDtMTGz9UaSvwtBOrcjqBHhxMe19MyJymrMETB/wpGgg+Jg/0y5Rh
	 oalf/M2XIH3nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] selftests: mptcp: drop nanoseconds width specifier
Date: Fri, 29 May 2026 20:20:38 -0400
Message-ID: <20260530002038.2170683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052826-strep-drum-dc14@gregkh>
References: <2026052826-strep-drum-dc14@gregkh>
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
[ kept `timeout ${timeout_test}` wrapper in do_transfer() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 9b7b93f8eb0c3..fa7abcaa1414d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -415,7 +415,7 @@ do_transfer()
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
 			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -428,7 +428,7 @@ do_transfer()
 	local rets=$?
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -444,7 +444,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 8b5c2285ad73c..a64133cb82f77 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -28,7 +28,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_SUBTEST_FLAKY=0
-MPTCP_LIB_SUBTESTS_LAST_TS_MS=
+MPTCP_LIB_SUBTESTS_LAST_TS_NS=
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -227,7 +227,7 @@ mptcp_lib_kversion_ge() {
 }
 
 mptcp_lib_subtests_last_ts_reset() {
-	MPTCP_LIB_SUBTESTS_LAST_TS_MS="$(date +%s%3N)"
+	MPTCP_LIB_SUBTESTS_LAST_TS_NS="$(date +%s%N)"
 }
 mptcp_lib_subtests_last_ts_reset
 
@@ -246,7 +246,7 @@ __mptcp_lib_result_check_duplicated() {
 __mptcp_lib_result_add() {
 	local result="${1}"
 	local time="time="
-	local ts_prev_ms
+	local ts_prev_ns
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
@@ -256,9 +256,9 @@ __mptcp_lib_result_add() {
 	# not to add two '#'
 	[[ "${*}" != *"#"* ]] && time="# ${time}"
 
-	ts_prev_ms="${MPTCP_LIB_SUBTESTS_LAST_TS_MS}"
+	ts_prev_ns="${MPTCP_LIB_SUBTESTS_LAST_TS_NS}"
 	mptcp_lib_subtests_last_ts_reset
-	time+="$((MPTCP_LIB_SUBTESTS_LAST_TS_MS - ts_prev_ms))ms"
+	time+="$(((MPTCP_LIB_SUBTESTS_LAST_TS_NS - ts_prev_ns) / 1000000))ms"
 
 	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*} ${time}")
 }
-- 
2.53.0

