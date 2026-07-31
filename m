Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4FA3A450F;
	Fri, 31 Jul 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520469; cv=none; b=stROMPkB3N+t44j2vQbLxNnlmSwNW1PWKXX9iRGICLOjXEI/73Y6AFjkXii+oXlv7mJFN2Y1uwJ2FVjFrHWZcNmzSFuZZoViuBrvXZt5WuaHgUkn8I91pxWSMhLvRVs8esYEg1EkppmdJesiRQifyCvkKTHtmi2ht5+5jNtubd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520469; c=relaxed/simple;
	bh=8v94nutMpChKPRnGMO5eUCbScoSX6cySBz4PK1ahrw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3wbmn0MBqSOsYcLp9SrM0ahNNc/IGAbdNrl7UQQoYV4Wo83t0Gd5/LqOV13Er90DVU82XWdrCHexzyn/2fo3X+IbVh3Ez333kLIc3oKp27zGbXmre8Y+6fHZbxn2TXbmpist6RN8BwpU0E1OoeQmgx3mJ0M3IWHF2OaVBnqeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ha13xABf; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ha13xABf"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFTMaf4119247;
	Fri, 31 Jul 2026 17:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=YMEyYKhaMhDYoH6es38RljHHtfE8ppTFpeU0O/EvB94=; b=ha13
	xABfGEs1YtNQqmiKOnsc/j+F49mY2PetP/CYFfYMtD7kgHm2GG9vGTLiZab0vg2R
	bkvu4Zv5dCH6yPBr2grpWVBdeohCZ8R6sIH77L/hemjSCRjLnLvVYbkVN86bTEC+
	/VgxzPh45x8UA6KF82KPo/kdMOYtrudkX2+4XysFR2HGigCBaLXhwonu6/bIkSf8
	Igi6kAP3E3aBF5aMY+6+c2yM+VFmHguvaKuwyiib/MDr7iiLPCrD6PTJDAr4WqrZ
	7hV9hm0VOTJjLbvDAUaWC4cXpqJChcUnRH5dVJXaGezdJc79/RLtDFofVSdN0aUi
	5K02zbp54bCTS/3m6Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4frqukt7ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 17:54:03 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 31 Jul 2026 17:54:01 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <rostedt@goodmis.org>, <mbenes@suse.cz>
CC: <corbet@lwn.net>, <jpoimboe@kernel.org>, <shuah@kernel.org>,
        <jolsa@kernel.org>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v2 2/2] selftests/livepatch: update test-ftrace.sh for deprecated ftrace_enabled
Date: Fri, 31 Jul 2026 13:53:58 -0400
Message-ID: <20260731175358.3542156-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: FMfRzp8bCjOEwNy3DIQSFuxQa3EnpBp6
X-Proofpoint-GUID: FMfRzp8bCjOEwNy3DIQSFuxQa3EnpBp6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfXzzuQTyh0Jcqg
 bOJSxc8wDZReRG6uVLb4oEe3+vvox59OFQPXDTsSl7E27bJjefCb6Y6l4SWpGIKT1SLi4YeslOl
 IISiqwkzpc2MThLdhiZX87eFS6lA7aXOB4ychsel1V6Us1BWCwCe
X-Authority-Analysis: v=2.4 cv=LOFWhpW9 c=1 sm=1 tr=0 ts=6a6ce13b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=meVymXHHAAAA:8
 a=pl6vuDidAAAA:8 a=Ku0EqlnfZouDhdiH90EA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfX+xJ4y5iri6Kc
 qkImBUvp74QNfZboBOpMX0Vybprn+rmNzl8P/Yak+wq0JyAUme1ipZfe0i2CzYHaxgMY5xmGeRI
 PH08w/xutaC6RGxGTtIb4bGT+v1by8swPq5i81H/vLpmV0kvKvQ+0afXJEtRDS9R9bLflkGwOA3
 afITwGstkRGRASwG62AqkCL2Ccp4E3SSNN7OEIQd3LZdiWYnyvK6jYUt71LWMQKR+PKcASfoLLO
 +RAD7GbRT+bWsmYaa3k6HwZew99IpnlClSls2DpM8pyAiZ/z1xbMO1qLbHVQU/7ydti16TBYJqk
 4PZ4xgSEZGzDxWeE9tzge9a/F5wakkXIPCRmV+XmZ4YAlbl2iR049eB5y+xOMxFnsfuGThBKqji
 /35ar/zKBJazC/LfBVltojmYNKTkrgKnlH1anCZD8PFRaaQxSGKH/JUTWbeKbCq8nY7FsTU3MQH
 cUxJEvSjo5/E5l9UQiQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11861
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310137

kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
knob, so the old disable/reload flow no longer applies there. Probe
for this with ftrace_disable_supported() and keep the full original
scenario (disable, fail to load a livepatch, re-enable, load, confirm
disable is refused while loaded) on kernels where it still works;
otherwise just confirm the write is refused.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../testing/selftests/livepatch/functions.sh  | 13 ++++++
 .../selftests/livepatch/test-ftrace.sh        | 45 ++++++++++++-------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30dc677b2f45..7fa4bda70221 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -126,6 +126,19 @@ function set_ftrace_enabled() {
 	echo "livepatch: kernel.ftrace_enabled = $result" > /dev/kmsg
 }
 
+# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=0
+#	can still disable ftrace on this kernel. Newer kernels deprecate
+#	the knob and always refuse the write with -EOPNOTSUPP.
+function ftrace_disable_supported() {
+	local result
+
+	sysctl -q kernel.ftrace_enabled=0 &> /dev/null
+	result=$(sysctl --values kernel.ftrace_enabled)
+	sysctl -q kernel.ftrace_enabled=1 &> /dev/null
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

