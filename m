Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409088;
	b=DiICjo7f4p1V2P6pmINUJixTDCWrDaSJcJ9+YVynuA5+ug07rVzU2DV+gTqY2B2QjFO4
	 Lyf/0OwiVAVt2cHpHHULVONTVTCyxXk298y1WO3ThSuPp+ZOCOGYiwEigrtqkSfCnChhn
	 RViGJHQdHnZ7eyVJJC9fS5GlEvQlz6W7evT/X5RTKrqSJghsXdky1COUUnBIp7sPBqot1
	 pH9yhcXhTgV8WuSp9pQqQSqEV3sOshLg6HAHaHty4r8ZWQT/2lhHFctSyAKEe5CsPC4LV
	 y5ve3NdblVn0ZG4GqKx3tlkrsM7QeEIZb9d1xrqpfncI5OS3tUF9txM/SrbQXPsnZUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409088;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=cBvDgqEsTvbNmR8/AMgl32bg/O/obhso+hCnoCRmmGE=;
	b=jncD7jjs4j7jV+H+x1NxWVj4IgUZHxdNjXDl9PQlkcZHHCo3jZfjhC5SoODN3B2kH3i+
	 1WFei5OGkUYQH8Z8RdDP6sbSdVAQKl5Zc/WgUcKa2FEd/3pzP6ezDwttLAzKYtQeDe+zD
	 56l29yj27eq2kmqZriJ9VLaLEmcsLpX0/B9NnEFaQi8RQmk6zLA6ioSQYff/j5dRVA5Av
	 2YcgNkHKJDHBG0bgOUK6F644cC/Mv/IpDddnk9D6gHbFML9yZjfF9a7G06INAZ4P7R9d2
	 accPB+/gkXdGLOvQiVrZzqc9eql6Cy/ShPu828GBjgF8rETMvL27bWpHuboRECXFXAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JLVLbopy;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BC606A327;
	Wed, 11 Nov 2026 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 100BC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JLVLbopy
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmq261KVz5BNS0;
	Wed, 11 Nov 2026 22:58:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794409086;
	bh=gOxO2Yk5AnG9ld7VSp27XoszDCOCbadioHHXCb71iJ4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=JLVLbopy/HteP8MEl/eonfe9fY11ERFR8O3hZhSLMQCpwVRU6Rw2YBNHxfT73EjXH
	 ovjEVe11TvDNwcj0LaGkAMNlI/AsPBSDUE1q7fg7JTU26cwVeM/P2Dycel8lxvV74P
	 i+XsMLuJhhdhay5xhETaLYlGBTblV7SLMiFhz9KYVRqFUcd+abjllkhrWI2Vp/GNU8
	 qUE4sqHwUeeKXTR4zxgNdObHfGtK0rjaSj8GtFKiEnXt1xQ/FoEMVgD3jUoshNWIhV
	 IGvrtCY04XEAhXLanBiwumIKSNt2IESQouuKF131NfvWhnfhWSTpkcxc6MS+pUtpz+
	 onmx0mATiyMdg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6ABEvulX003780;
	Wed, 11 Nov 2026 22:57:56 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:57:59 +0800 (CST)
X-Zmail-TransId: 2afb6af48277b2d-70a09
X-Mailer: Zmail v1.0
Message-ID: <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn>
In-Reply-To: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
References: 202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn
Date: Wed, 11 Nov 2026 22:57:59 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNF0gc2VsZnRlc3RzOiB1YmxrOiBwcm9wYWdhdGUgc3RyZXNzIHdvcmtlciBmYWlsdXJlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEvulX003780
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:58:06 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF4827E.002/4jPmq261KVz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The stress tests update ERR_CODE in background subshells and use a bare
wait in the parent. A worker can therefore fail while the parent still
prints PASS and exits successfully. Calling _show_result() from a worker
also removes backing files shared with other workers.

Generalize the recovery PID collector and use it to wait for every stress
worker in the parent. Return errors from the worker helpers, leave result
reporting and cleanup to the parent, and reset the PID array after each
batch. Keep failures ahead of skips when collecting worker exit statuses.

Fixes: bb2cabf23568 ("selftests: ublk: run stress tests in parallel")
Reported-by: Ming Lei <tom.leiming@gmail.com>
Link: https://lore.kernel.org/all/avJ0Vn9G7XhZv-XL@fedora-laptop/
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
This follows "selftests: ublk: propagate recovery worker failures":
https://lore.kernel.org/all/202611092358134332uegNg75loROSwL53Em6A@zte.com.cn/

Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
VM (4 vCPUs, 4 GiB), using the in-tree kublk and real fio I/O. All nine
stress scripts pass normally before and after the change. A test-only
argument wrapper sets loop ADD_DEV queue counts to zero, making the real
kernel reject them with EINVAL: all nine previously ended with PASS and
exit status 0, and all nine now end with FAIL and exit status 255.

Initial recovery runs exposed failures in recover_01 (remaining QUIESCED)
and recover_03 (remaining LIVE during quiesce). Follow-up experiments
reproduced two independent defects: reused batch SQEs retaining MULTISHOT
and commits arriving after the quiesce cancellation scan.

With separate fixes for those defects applied, the four original
recovery scripts passed twice (eight invocations), without C or driver
diagnostic instrumentation or reduced fio load. This recovery result
includes both separate fixes; the stress A/B results above did not
require them. The original recovery failures are retained in the record.
 tools/testing/selftests/ublk/test_common.sh     | 14 ++++++-------
 tools/testing/selftests/ublk/test_recover_01.sh |  6 +++---
 tools/testing/selftests/ublk/test_recover_02.sh |  6 +++---
 tools/testing/selftests/ublk/test_recover_03.sh |  6 +++---
 tools/testing/selftests/ublk/test_recover_04.sh |  4 ++--
 tools/testing/selftests/ublk/test_stress_01.sh  |  9 ++++++--
 tools/testing/selftests/ublk/test_stress_02.sh  |  9 ++++++--
 tools/testing/selftests/ublk/test_stress_03.sh  | 23 ++++++++++++++++----
 tools/testing/selftests/ublk/test_stress_04.sh  | 23 ++++++++++++++++----
 tools/testing/selftests/ublk/test_stress_05.sh  | 28 ++++++++++++++++++-------
 tools/testing/selftests/ublk/test_stress_06.sh  | 15 ++++++++++---
 tools/testing/selftests/ublk/test_stress_07.sh  | 15 ++++++++++---
 tools/testing/selftests/ublk/test_stress_08.sh  | 10 +++++++--
 tools/testing/selftests/ublk/test_stress_09.sh  | 10 +++++++--
 14 files changed, 130 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 367df2d..be99f46 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -353,13 +353,12 @@ run_io_and_remove()
 	local dev_id
 	shift 1
 
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev "$TID" $?
+	dev_id=$(_add_ublk_dev "$@") || return $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
 	if ! __run_io_and_remove "$dev_id" "${size}" "no"; then
 		echo "/dev/ublkc$dev_id isn't removed"
-		exit 255
+		return 255
 	fi
 }
 
@@ -369,18 +368,17 @@ run_io_and_kill_daemon()
 	local dev_id
 	shift 1
 
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev "$TID" $?
+	dev_id=$(_add_ublk_dev "$@") || return $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs kill ublk server(ublk add $*)"
 	if ! __run_io_and_remove "$dev_id" "${size}" "yes"; then
 		echo "/dev/ublkc$dev_id isn't removed res ${res}"
-		exit 255
+		return 255
 	fi
 }
 
-# Collect recovery workers in the parent before removing shared backing files.
-_wait_recovery_tests()
+# Collect test workers in the parent before removing shared backing files.
+_wait_test_pids()
 {
 	local pid
 	local ret
diff --git a/tools/testing/selftests/ublk/test_recover_01.sh b/tools/testing/selftests/ublk/test_recover_01.sh
index 950928a..ad5f915 100755
--- a/tools/testing/selftests/ublk/test_recover_01.sh
+++ b/tools/testing/selftests/ublk/test_recover_01.sh
@@ -32,7 +32,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_recover_test -t null -q 2 -r 1 &
@@ -41,7 +41,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -i 1 &
@@ -50,7 +50,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_02.sh b/tools/testing/selftests/ublk/test_recover_02.sh
index beeeb35..abdc8c1 100755
--- a/tools/testing/selftests/ublk/test_recover_02.sh
+++ b/tools/testing/selftests/ublk/test_recover_02.sh
@@ -36,7 +36,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -z -b "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z &
@@ -45,7 +45,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -z "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -z -i 1 &
@@ -54,7 +54,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_03.sh b/tools/testing/selftests/ublk/test_recover_03.sh
index 0c6b312..aa84354 100755
--- a/tools/testing/selftests/ublk/test_recover_03.sh
+++ b/tools/testing/selftests/ublk/test_recover_03.sh
@@ -36,7 +36,7 @@ ublk_run_quiesce_recover -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 &
@@ -45,7 +45,7 @@ ublk_run_quiesce_recover -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_quiesce_recover -t null -q 2 -r 1 -i 1 &
@@ -54,7 +54,7 @@ ublk_run_quiesce_recover -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_recover_04.sh b/tools/testing/selftests/ublk/test_recover_04.sh
index 232ae7d..ed508b8 100755
--- a/tools/testing/selftests/ublk/test_recover_04.sh
+++ b/tools/testing/selftests/ublk/test_recover_04.sh
@@ -32,7 +32,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -u "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 pids=()
 ublk_run_recover_test -t null -q 2 -r 1 -u -i 1 &
@@ -41,7 +41,7 @@ ublk_run_recover_test -t loop -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[0]}" &
 pids+=("$!")
 ublk_run_recover_test -t stripe -q 2 -r 1 -u -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 pids+=("$!")
-_wait_recovery_tests "${pids[@]}"
+_wait_test_pids "${pids[@]}"
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index f91783f..bff70c2 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_remove()
 {
@@ -10,8 +11,8 @@ ublk_io_and_remove()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,9 +26,13 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_remove 8G -t null -q 4 &
+pids+=("$!")
 ublk_io_and_remove 256M -t loop -q 4 "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_remove 256M -t stripe -q 4 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index b128d11..ef3a36f 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
@@ -14,8 +15,8 @@ ublk_io_and_kill_daemon()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 _prep_test "stress" "run IO and kill ublk server"
@@ -26,9 +27,13 @@ _create_backfile 2 128M
 
 for nr_queue in 1 4; do
 	ublk_io_and_kill_daemon 8G -t null -q "$nr_queue" &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 256M -t loop -q "$nr_queue" "${UBLK_BACKFILES[0]}" &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 256M -t stripe -q "$nr_queue" "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	wait
+	pids+=("$!")
+	_wait_test_pids "${pids[@]}"
+	pids=()
 done
 
 _cleanup_test
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index a0f0aba..9af68c3 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_remove()
 {
@@ -10,8 +11,8 @@ ublk_io_and_remove()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -29,24 +30,38 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_remove 8G -t null -q 4 -z &
+pids+=("$!")
 ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc &
+	pids+=("$!")
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
+	pids+=("$!")
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	pids+=("$!")
 	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
-	wait
+	pids+=("$!")
+	_wait_test_pids "${pids[@]}"
+	pids=()
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	pids+=("$!")
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	pids+=("$!")
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	pids+=("$!")
 	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
-	wait
+	pids+=("$!")
+	_wait_test_pids "${pids[@]}"
+	pids=()
 fi
 
 _cleanup_test
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 896eae6..85aaba7 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_kill_daemon()
 {
@@ -10,8 +11,8 @@ ublk_io_and_kill_daemon()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -28,24 +29,38 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -z --no_ublk_fixed_fd &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t loop -q 4 -z --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
-	wait
+	pids+=("$!")
+	_wait_test_pids "${pids[@]}"
+	pids=()
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	pids+=("$!")
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
-	wait
+	pids+=("$!")
+	_wait_test_pids "${pids[@]}"
+	pids=()
 fi
 
 _cleanup_test
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index d6c00c7..baf8e0c 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
@@ -15,8 +16,7 @@ run_io_and_remove()
 	local dev_pid
 	shift 1
 
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev $TID $?
+	dev_id=$(_add_ublk_dev "$@") || return $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
 
@@ -40,8 +40,8 @@ ublk_io_and_remove()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 _prep_test "stress" "run IO and remove device with recovery enabled"
@@ -51,33 +51,47 @@ _create_backfile 1 256M
 
 for reissue in $(seq 0 1); do
 	ublk_io_and_remove 8G -t null -q 4 -g -r 1 -i "$reissue" &
+	pids+=("$!")
 	ublk_io_and_remove 256M -t loop -q 4 -g -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
-	wait
+	pids+=("$!")
+	_wait_test_pids "${pids[@]}"
+	pids=()
 done
 
 if _have_feature "ZERO_COPY"; then
 	for reissue in $(seq 0 1); do
 		ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" &
+		pids+=("$!")
 		ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
-		wait
+		pids+=("$!")
+		_wait_test_pids "${pids[@]}"
+		pids=()
 	done
 fi
 
 if _have_feature "AUTO_BUF_REG"; then
 	for reissue in $(seq 0 1); do
 		ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$reissue" &
+		pids+=("$!")
 		ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		pids+=("$!")
 		ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
-		wait
+		pids+=("$!")
+		_wait_test_pids "${pids[@]}"
+		pids=()
 	done
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" &
+	pids+=("$!")
 	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
+	pids+=("$!")
 	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
+	pids+=("$!")
 fi
-wait
+_wait_test_pids "${pids[@]}"
+pids=()
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
index 9481a27..c6dea85 100755
--- a/tools/testing/selftests/ublk/test_stress_06.sh
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_remove()
 {
@@ -10,8 +11,8 @@ ublk_io_and_remove()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,14 +26,22 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_remove 8G -t null -q 4 -u &
+pids+=("$!")
 ublk_io_and_remove 256M -t loop -q 4 -u "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_remove 256M -t stripe -q 4 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 ublk_io_and_remove 8G -t null -q 4 -u --nthreads 8 --per_io_tasks &
+pids+=("$!")
 ublk_io_and_remove 256M -t loop -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_remove 256M -t stripe -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testing/selftests/ublk/test_stress_07.sh
index 3e01c03..d42df5d 100755
--- a/tools/testing/selftests/ublk/test_stress_07.sh
+++ b/tools/testing/selftests/ublk/test_stress_07.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_kill_daemon()
 {
@@ -10,8 +11,8 @@ ublk_io_and_kill_daemon()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -25,14 +26,22 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -u --no_ublk_fixed_fd &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t loop -q 4 -u --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -u "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -u --nthreads 8 --per_io_tasks &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t loop -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -u --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_08.sh b/tools/testing/selftests/ublk/test_stress_08.sh
index 5f32424..16dde23 100755
--- a/tools/testing/selftests/ublk/test_stress_08.sh
+++ b/tools/testing/selftests/ublk/test_stress_08.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_remove()
 {
@@ -10,8 +11,8 @@ ublk_io_and_remove()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -35,10 +36,15 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_remove 8G -t null -q 4 -b &
+pids+=("$!")
 ublk_io_and_remove 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_remove 256M -t stripe -q 4 --auto_zc -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+pids+=("$!")
 ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 _cleanup_test
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_09.sh b/tools/testing/selftests/ublk/test_stress_09.sh
index 64cb8d9..9dd7625 100755
--- a/tools/testing/selftests/ublk/test_stress_09.sh
+++ b/tools/testing/selftests/ublk/test_stress_09.sh
@@ -3,6 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 ERR_CODE=0
+pids=()
 
 ublk_io_and_kill_daemon()
 {
@@ -10,8 +11,8 @@ ublk_io_and_kill_daemon()
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
 	fi
+	return "$ERR_CODE"
 }
 
 if ! _have_program fio; then
@@ -34,10 +35,15 @@ _create_backfile 1 128M
 _create_backfile 2 128M
 
 ublk_io_and_kill_daemon 8G -t null -q 4 -z -b &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
+pids+=("$!")
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+pids+=("$!")
 ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
-wait
+pids+=("$!")
+_wait_test_pids "${pids[@]}"
+pids=()
 
 _cleanup_test
 _show_result $TID $ERR_CODE
