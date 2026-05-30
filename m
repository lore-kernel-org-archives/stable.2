Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999D2F8E85
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151319; cv=none; b=e+Xn759QI97ysM+09I4YuYsV/nbB/nAahJAvQJEU33MoMhzP+d3xQRowlSkamjyW+k8DxQKsfEInBj/KFNWe9KZEArO440RAInf3/Y+GJYZokxiN8APQT3metDxSaKCLpg7KjCIHJU0Odj0dhdu6LGPWgwtv6bbLFEHqyUrJL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151319; c=relaxed/simple;
	bh=UbvP/nGhEzBVqBxpf69F0mfxr4b4ofYefN5xKfAm7jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbr8QKuXPChZg6K2PjD377YFde2ca3rrQjHGtaXs/PGZQ51u7rhrZaLkozL3Nkm39GvCasB/Teepg5H4YPqq2Db0RM356gEr0iyJs6bWGNot2NvAkV4m7hS4O/VO87BA/JCR6kgot7g2Hu2mN5Hgy1HSYfw3vxkxz1iZw+VTRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJx1fVQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJx1fVQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B41F00893;
	Sat, 30 May 2026 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151317;
	bh=U8R7M0yOW6boewu0lRLSBAmPwh90KJZE6O096O0SGFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJx1fVQZJ46FFYjlBj4F7kv5ZNxPP8ZgSdYEbbUWZZTXMrn2q1UYRVZt6pTIQDbzE
	 l5dzz9oETrxXzKxwj8x2fEgdFOkjzTwDOweS/PH/CkOzDcCCMN1XzavaVcH439ibQ8
	 7DTdAj0w6mWKF/MIQUSsAddsBupNi2y+HP5TNTrSmEJrHc1jpap6GjktkzuhpNHUd+
	 2t7rWpyZjL3LPU5RlImRMT6QnMak7xvuqeMcG5nUX7RIQkXYzcWOBB9PWcbS4QBNbX
	 oisKvPVsm/I96AWL0gKpNub9XExGffUMr5CCr8z4G9fqMLnCBimdCzYUjVuzUYXrJF
	 cat5Q2Kr+I/pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: drop nanoseconds width specifier
Date: Sat, 30 May 2026 10:28:35 -0400
Message-ID: <20260530142835.2434049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052828-blurred-trifle-8582@gregkh>
References: <2026052828-blurred-trifle-8582@gregkh>
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
index d43eb907d244e..09c4330b8473f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -450,7 +450,7 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
 			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -463,7 +463,7 @@ do_transfer()
 	local rets=$?
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -479,7 +479,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
-- 
2.53.0

