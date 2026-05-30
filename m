Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4232A3FE
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155641; cv=none; b=twE9MEAAyFwH87/nNEoly0GoOZxUGKVGG2LYir4f6x0VXzFwldlvmDYMUbyQDGecbsU/5i8GcL6Cajz5Q+cuyihvoDx61iS28fva1gCmtdPime/KHIbE02+gGYOSDuPxZjKQiSaEaR85Q5/HSi3y1ix2iNhj8jPmaK8lDR00YWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155641; c=relaxed/simple;
	bh=IcXtRd1xRTwpRllVcbjz0iDygABbwXS7segaEh1MOC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsawxlK5UX+we22EcpQTp1xS3Sb/0NqMvEgeCwA1Sp+0e8bj6Z2NtVIYdKPTDgcxXB6biHXIw9qYwRGXuuUd5xT+IfWFmdn2eSNrIP8OCiXzmi6DZl4coPq8gvjbvfWpoen8Pf85x2YMpVxmUOAeoAlh0poTfluXAv9TiJYFMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP3DwqrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP3DwqrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9511F00899;
	Sat, 30 May 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780155639;
	bh=N+459GfZdsw++VWaoEjxNQmReIV1wx4sw5D8iVVcEWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VP3DwqrF6sknd9vnZ/O2y5uurVGSVccEjin8x3udPzlTX97Zq1xIjq1uQECETul68
	 Nh5YR9r+M8bD+5krlx9U5BeekkD8TiyDgaXQsRMwtnrU1FDVLsQGOKrWAv1gy90bHc
	 eDWkkrIYG0M1xJBi7uC5ppsTv9Qpm2uhpp85uM6grDnpyreMQ3Ongx34EMGm4WifLz
	 XpZ4Ovm7zs/C8Qkd30KR75/0yzr+QLjh9dLIMw8qm+FXoK8nuLET6lwL0XzdhkWcRG
	 Z8dlIElh5PccWkub9VJFWOeNSFBfH+W4/hrV/w/p7iFY131BOmoE7fEuBCz2ID7Nge
	 1kHGZuOxcGoHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] selftests: mptcp: drop nanoseconds width specifier
Date: Sat, 30 May 2026 11:40:36 -0400
Message-ID: <20260530154036.2741872-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052830-expansion-earlobe-eedc@gregkh>
References: <2026052830-expansion-earlobe-eedc@gregkh>
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
index fb89298bdde4c..4e7c82eddf713 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -421,7 +421,7 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${cl_proto} $extra_args $connect_addr < "$cin" > "$cout" &
 	local cpid=$!
 
@@ -431,7 +431,7 @@ do_transfer()
 	local rets=$?
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -440,7 +440,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	duration=$(printf "(duration %05sms)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
-- 
2.53.0

