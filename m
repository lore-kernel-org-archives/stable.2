Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D33E1205;
	Thu,  6 Aug 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030237; cv=none; b=BNGwKlDKG3gxCZ4TFpJd1c27HimTZVuF3hEdTS78HKWh2QzbV0Bwf7GE0v/paUFEyWJgXlXOsJWZhpPzX2gMCLeADSiyZEo3P7BCgL7IE/8vl9bRp+p45cqhYIx1X59na22jE5xnlF4XwZ5IwqDAIJHL/6ZuxdFLVOt1vpFKOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030237; c=relaxed/simple;
	bh=0PsiP6XLNgx1B8qCAtOy9TctaqYgvjMsLtdZ+zDu22M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzAK4hrq7YBnNlb2mAATYH5A7uX0hNcqom1JPtTkhKrraStPjJGqkosGhfBuQRhpQp+WikiI6TfvbOtL1T6KLmahAabibjt37+zdIQVfZ+twG1g+uuLz91GQv8pL7HNCLNgZ09AtaGpe3na/nOYLmVukH6dXG6AnuWtvEyCKPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=coSF3ov/; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="coSF3ov/"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EK9Ab791541;
	Thu, 6 Aug 2026 15:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=4R0Q2D3S9SSDGj3zQrCGa1KW0JTFH+rYYGs3A9AbRLE=; b=coSF
	3ov/pgcqP1l8eBxpFH/LBNnjZvELa1KQdE7nZZccSfYC+vUtWQSlx0BU92EHU2tI
	3fHBHMG/1BnJizo56wCT/8PDl9BiTU18m3QiqRjuaeMcv//Zxf86sj1sCZ1InZyt
	9clzlj1/vzm5LNnnHzgShqZWAHtjDaO6rkf8Huj2IdB5AaIe5bso1q2GpGvyg1iL
	sHRVhybVshmcUqD9Ii3TWQN/sFu8aLR2yKtPQcQmWdHsjEA84ZX6bNR8cn7R+LOf
	8CmdQFVt9zlKgznI7EcQXQ6vqWN8JvXpVxS3Pv6f33VZdn0RrtBekpq2Etwr6Czt
	EV1MfF8rALLBWOE6AQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fv69t6j3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:30:05 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 6 Aug 2026 15:30:03 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <rostedt@goodmis.org>,
        <mbenes@suse.cz>
CC: <jolsa@kernel.org>, <mhiramat@kernel.org>, <jpoimboe@kernel.org>,
        <joe.lawrence@redhat.com>, <mark.rutland@arm.com>, <corbet@lwn.net>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update test-ftrace.sh for deprecated ftrace_enabled
Date: Thu, 6 Aug 2026 11:30:00 -0400
Message-ID: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a74a87d cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=meVymXHHAAAA:8
 a=20KFwNOVAAAA:8 a=pl6vuDidAAAA:8 a=Ku0EqlnfZouDhdiH90EA:9
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: ygi1jIpO-HAUXQ5MwlzBSrde2wi5TObq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX4uwjFTraZZ/3
 LGUWi9ptsuXCHup8vMnpN+s1kpsgDpr/1w3meGTFD1D5ivdyINWfBi2qycxepqvqc4lIoyXt10F
 uB9TPwrs0Zbi8wGXpcrYWrwGq5+vHYfzl52c9URx5aSMrFvZ78hPXI04aLiJDvF7JD2Kxu9Rd65
 bR+g6S0Dk1nJiDYcNJGdDEqTXta4fZhoUnVZZd6K+SQvYdHxIGegG2mu6mBm9pBR6I4XMhyQNwx
 j94SAlNWUzi0OLKXBcIXzry8Upe5mziiof2wkMRNtpJhQLva3oxjZw2IPQXqOZjMpgrYAlPGzgb
 t1eiti2jJuNLbfEfVtLnxMyo784TGlrsX2CUz+i5awb7RXdErA8jt+yKaADbs5++cVycLMwRGir
 sL8t+2LZEqrf6cMHg4vpbDrwxZtD/Wrurwwi1YskxbtA3+g7WjX1dL7x0WS4dcqKfqYZtFzqjht
 FzJhZFL1i8ntGIG2enA==
X-Proofpoint-ORIG-GUID: ygi1jIpO-HAUXQ5MwlzBSrde2wi5TObq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfXzjAy8E4A7zuV
 /Sgk5FygepscEqUAkwy+sFS1LPS+FVRTkEtD2WZk/+MfaqVsA1pvNCw+nbSvC9FfwHiROZNW22L
 ehj4cVTs5qzIsKt5HI8REp6FsO65+713srhxzf76jwU+3ILiMDff
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060120

kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
knob, so the old disable/reload flow no longer applies there. Probe
for this with ftrace_disable_supported() and keep the full original
scenario (disable, fail to load a livepatch, re-enable, load, confirm
disable is refused while loaded) on kernels where it still works;
otherwise just confirm the write is refused.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../testing/selftests/livepatch/functions.sh  | 14 ++++++
 .../selftests/livepatch/test-ftrace.sh        | 45 ++++++++++++-------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30dc677b2f45..a65b7b1ac8ad 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -126,6 +126,20 @@ function set_ftrace_enabled() {
 	echo "livepatch: kernel.ftrace_enabled = $result" > /dev/kmsg
 }
 
+# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=0
+#	can still disable ftrace on this kernel. Newer kernels deprecate
+#	the knob and always refuse the write with -EOPNOTSUPP.
+function ftrace_disable_supported() {
+	local orig result
+
+	orig=$(sysctl --values kernel.ftrace_enabled)
+	sysctl -q kernel.ftrace_enabled=0 &> /dev/null
+	result=$(sysctl --values kernel.ftrace_enabled)
+	sysctl -q "kernel.ftrace_enabled=$orig" &> /dev/null
+
+	[[ "$result" == "0" ]]
+}
+
 function cleanup() {
 	pop_config
 }
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index d2c3dea63104..cd27148510f8 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -12,29 +12,32 @@ setup_config
 # - turn ftrace_enabled OFF and verify livepatches can't load
 # - turn ftrace_enabled ON and verify livepatch can load
 # - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
+# (skipped on kernels where the sysctl is deprecated and always refuses 0)
 
 start_test "livepatch interaction with ftrace_enabled sysctl"
 
-set_ftrace_enabled 0
-load_failing_mod $MOD_LIVEPATCH
+if ftrace_disable_supported; then
 
-set_ftrace_enabled 1
-load_lp $MOD_LIVEPATCH
-if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
-	echo -e "FAIL\n\n"
-	die "livepatch kselftest(s) failed"
-fi
+	set_ftrace_enabled 0
+	load_failing_mod $MOD_LIVEPATCH
 
-# Check that ftrace could not get disabled when a livepatch is enabled
-set_ftrace_enabled --fail 0
-if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
-	echo -e "FAIL\n\n"
-	die "livepatch kselftest(s) failed"
-fi
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH
+	set_ftrace_enabled 1
+	load_lp $MOD_LIVEPATCH
+	if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+		echo -e "FAIL\n\n"
+		die "livepatch kselftest(s) failed"
+	fi
 
-check_result "livepatch: kernel.ftrace_enabled = 0
+	# Check that ftrace could not get disabled when a livepatch is enabled
+	set_ftrace_enabled --fail 0
+	if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+		echo -e "FAIL\n\n"
+		die "livepatch kselftest(s) failed"
+	fi
+	disable_lp $MOD_LIVEPATCH
+	unload_lp $MOD_LIVEPATCH
+
+	check_result "livepatch: kernel.ftrace_enabled = 0
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
@@ -60,6 +63,14 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
+else
+
+	set_ftrace_enabled --fail 0
+	check_result "livepatch: sysctl: setting key \"kernel.ftrace_enabled\": \
+Operation not supported"
+
+fi
+
 
 # - verify livepatch can load
 # - check if traces have a patched function
-- 
2.34.1

