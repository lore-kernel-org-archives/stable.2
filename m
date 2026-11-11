Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409088;
	b=y53TS6k9Xkikh7WhBJ6QNINPobmwjJe5FCi7s8HoS+yeWrXaIlHDQ2vLEm8KGmvP8Ccf
	 MgtkIxsuNdtJ0wcJKmgYD9lZj6dhzUVfN+Vp0Sitwubaf1sKL2vO7p9y5I+gDL9V0eOew
	 0mJzb6jGeOepAblIq10QT4GmvHEjerH85n7asnw+B7Q7tHWYRpeVxLRDf07yTyG0GkoSR
	 m2/WIEjl1NuA526w+8wDnbVDy9Dh4/md7L3XxKKdogr39VRJWZ78EI5dlu4coe+YAOVBi
	 Cl7pwl0XLd4bwUbvxBItcBq5vDFctv2in/cITpRqPNkROUey8dv+bBAa7iVMrRLp+yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409088;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ZmVOIgqY7UvElWZIETg1Cecmw95r6BvR1m9duw4jE34=;
	b=4FMdRcwrbfV1cM8NrSBFvRTX+k9YI1131kxwX5mJk5eDhRxomyhydn0Y/j2/J7K8eQMk
	 a5gtmprNykU0vYokQVkEnzXANyLbPsvgyLaYwMTpFrzJDnbqA0QA5jp3AOlGVlsqYe6NQ
	 fxNfEBpUeJH0aTCn8Evu80pmAZFuAtLmP0NEq2tmM7Zf6jl2KVoRNzzH0et7cPdP+CcW9
	 fvaqIg9dp4DfOkgh9UpI7Mvlo25iuDGPnygsVHctSitDpZrg4ABjrY7Hi7kAlOyAQS3Mw
	 4xvnRURjPggbCx3R50Mrvdxa/S1h0BApO9W92BcbKlmrSIOi+S5RwuvG+JcqiRg/tRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="Uk6/S38Q";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB8606A32D;
	Wed, 11 Nov 2026 14:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBCB8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Uk6/S38Q
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmq22VzCz5BNRx;
	Wed, 11 Nov 2026 22:58:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794409086;
	bh=Pp7nVk6cyVDatBLjK7a+1BF0c26oi4E5Yg+DHfhszHs=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Uk6/S38QCUCKr7/e1R+9gXReUdQRMN7GOBhYxV+VNsRQ+DmUzHJVjpm1JQ6i613GA
	 QSUAa3RI1HJGYy1Mt9+cBUyrWhjCl+YgBBsjBwWhHN81esGIVYaN2EZN8mPFug3brO
	 MEHQ0m7pD8aWp8QjcjsDsyjD/nOan+ap15gw5IqcqwaDNiEgbetTFi8Bx17QweTqMV
	 xs59uwa7GlgUdnFQ6IcTLYgAjqz7gTRklHwUgQ51+pH7UHJ/mskkBT9MhYLG8PPWUW
	 w/JRQGHMIxWEKvEfNqQz0S1/IkmDg6NG2vVqZaT8OroGSkEYFYHzcp7Xvtu9H2/9C8
	 a3eKfcptXKtRw==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ABEvs8T003777;
	Wed, 11 Nov 2026 22:57:54 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:57:58 +0800 (CST)
X-Zmail-TransId: 2afb6af48276ab5-70991
X-Mailer: Zmail v1.0
Message-ID: <202611112257584444otw2q05tB3ZkEpW5_Q9j@zte.com.cn>
In-Reply-To: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
References: 202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn
Date: Wed, 11 Nov 2026 22:57:58 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>, <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNF0gc2VsZnRlc3RzOiB1YmxrOiBwcm9wYWdhdGUgcmVjb3Zlcnkgd29ya2VyIGZhaWx1cmVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEvs8T003777
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:58:06 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF4827E.000/4jPmq22VzCz5BNRx

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The recovery tests update ERR_CODE in background subshells and use wait
without PIDs. A worker can report a failure while the parent still prints
PASS and exits with zero. Calling _show_result() from a failed worker also
removes shared backing files while other workers may still be using them.

Wait for each recorded worker PID and aggregate its status in the parent,
keeping failures ahead of skips and preserving errors across batches.
Return worker and device-creation errors without reporting or cleaning up
from the child, so the parent can finish waiting before shared cleanup.

Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
Fixes: 533c87e2ed74 ("selftests: ublk: add test for UBLK_F_QUIESCE")
Fixes: 63276182c513 ("selftests: ublk: add user copy test cases")
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2:
  - simplify the worker wait loop, as requested by Ming Lei.
  - the simplified loop is exercised by the real-kernel recovery runs
    described in the stress-worker patch of this series.
v1: https://lore.kernel.org/all/202611092358134332uegNg75loROSwL53Em6A@zte.com.cn/

Tested on native x86_64 Bash 5.2 with the recovery scripts and common
helpers from the unpatched and patched trees. Device and I/O operations
were replaced by test-only stubs. Single-worker failures at every launch
position, multiple failures, skips, signal termination and device-creation
errors no longer produce a final PASS or a zero exit status. Successful
runs still pass, and cleanup follows all worker exits. Prerequisite skips
still exit before preparation. The 71 scenarios passed their expected
checks on each tree. This does not exercise real ublk devices or I/O.

 tools/testing/selftests/ublk/test_common.sh   | 20 +++++++++++++++++--
 .../testing/selftests/ublk/test_recover_01.sh | 20 +++++++++++++++----
 .../testing/selftests/ublk/test_recover_02.sh | 20 +++++++++++++++----
 .../testing/selftests/ublk/test_recover_03.sh | 20 +++++++++++++++----
 .../testing/selftests/ublk/test_recover_04.sh | 14 ++++++++++---
 5 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index af2ea4f..367df2d 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -379,6 +379,23 @@ run_io_and_kill_daemon()
 	fi
 }
 
+# Collect recovery workers in the parent before removing shared backing files.
+_wait_recovery_tests()
+{
+	local pid
+	local ret
+
+	for pid in "$@"; do
+		wait "$pid" && continue
+		ret=$?
+
+		# A failure takes precedence over a skipped worker.
+		if [ "$ERR_CODE" -eq 0 ] || [ "$ERR_CODE" -eq "$UBLK_SKIP_CODE" ]; then
+			ERR_CODE=$ret
+		fi
+	done
+}
+
 run_io_and_recover()
 {
 	local size=$1
@@ -387,8 +404,7 @@ run_io_and_recover()
 	local dev_id
 
 	shift 2
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev "$TID" $?
+	dev_id=$(_add_ublk_dev "$@") || return $?
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
 		--rw=randread --iodepth=256 --size="${size}" --numjobs=4 \
diff --git a/tools/testing/selftests/ublk/test_recover_01.sh b/tools/testing/selftests/ublk/test_recover_01.sh
index 1cddc23..950928a 100755
--- a/tools/testing/selftests/ublk/test_recover_01.sh
+++ b/tools/testing/selftests/ublk/test_recover_01.sh
@@ -11,8 +11,8 @@ ublk_run_recover_test()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,20 +25,32 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -b &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -i 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_02.sh b/tools/testing/selftests/ublk/test_recover_02.sh
index 9c3f481..beeeb35 100755
--- a/tools/testing/selftests/ublk/test_recover_02.sh
+++ b/tools/testing/selftests/ublk/test_recover_02.sh
@@ -11,8 +11,8 @@ ublk_run_recover_test()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -29,20 +29,32 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z -b &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -z -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -z "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z -i 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_03.sh b/tools/testing/selftests/ublk/test_recover_03.sh
index 92f4012..0c6b312 100755
--- a/tools/testing/selftests/ublk/test_recover_03.sh
+++ b/tools/testing/selftests/ublk/test_recover_03.sh
@@ -11,8 +11,8 @@ ublk_run_quiesce_recover()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_feature "QUIESCE"; then
@@ -29,20 +29,32 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 -b &
+pids+=("$!")
 ublk_run_quiesce_recover -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 &
+pids+=("$!")
 ublk_run_quiesce_recover -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 -i 1 &
+pids+=("$!")
 ublk_run_quiesce_recover -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_04.sh b/tools/testing/selftests/ublk/test_recover_04.sh
index 4c83c18..232ae7d 100755
--- a/tools/testing/selftests/ublk/test_recover_04.sh
+++ b/tools/testing/selftests/ublk/test_recover_04.sh
@@ -11,8 +11,8 @@ ublk_run_recover_test()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,15 +25,23 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -u &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
+pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
+pids+=("$!")
 ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_recovery_tests "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
