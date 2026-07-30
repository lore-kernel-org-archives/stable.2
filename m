Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AC2E9EC7;
	Thu, 30 Jul 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429377; cv=none; b=PYTQDIJNHQ1NeztqwUXcVqAT7WmJcJSyBlQWwn8KroC9aSEZzJ1dmds3q9dbInoBsr4ZKzI7+sJd6i4nvqbegifZcoi2ZS7d3mFa7DWJcqcoFr2ixqyJ7Ien3ELxOgE68WTrMzeE6lWiBLAtEIzMxy/kAkvcu+Jk98zOONDvado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429377; c=relaxed/simple;
	bh=AwGpnlAGnMbULBmDsy0HxgoE4RRfehw/3TXMFWtyIbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QogHVZttmXMnU2JMixC452I2KsO7+pDf/tUg5sVvkSCqGkczGTkrctl1nu4s+ZKrIXeR3P76Nx727mnIV7bHSJGT0zmYfBCSyA/PtnOAhgU9kHf+L6jMEg7Mj5fQRC/f70Zuo7YOvk3clwiTWL+zsIkz+H5rbl6NFRRsQIAsEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Fg6HGVsY; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Fg6HGVsY"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UEhAXl629888;
	Thu, 30 Jul 2026 16:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=s++PNopmcE/OnTl0vqAKkZTLDXqSCgMAiBUbsl5HfOY=; b=Fg6H
	GVsYqDaLnnvPPz7sDrJyCnzBpI2ugnuemPeWb6EKsEllA1/82j92dNilKIsWOwNw
	uZepshi5SxYdWtIELNMmuyIrWE53QRQfayQs6m83pzJtihCuQJYX+vFta6003ziL
	RwDU2jgugCXH82RDOqQBstZSZIhtcpWAXxh1bbdptPOQ+1ZhsfVw6pzNspVjHnex
	TfqdJ6hK2Oy1jlcCG4aSFXzbR35SNhGnio2T5Sw1cXOOF5zquHRZ4oinPSe990uu
	JI8JOrd7YYvE+mzona2WqWe+LLAS9E6Nzu+A4/dlRVQmCBCHR/6oXxxotfWd/VMV
	wrgE+OuMBxbW8FCECw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fr77x93fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:35:50 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 30 Jul 2026 16:35:48 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <rostedt@goodmis.org>, <corbet@lwn.net>, <jpoimboe@kernel.org>,
        <shuah@kernel.org>, <jolsa@kernel.org>, <mbenes@suse.cz>,
        <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/livepatch: update test-ftrace.sh for deprecated ftrace_enabled
Date: Thu, 30 Jul 2026 12:35:44 -0400
Message-ID: <20260730163544.2042327-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com>
References: <20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: E7ZFAr_IKF5miHNtEFRCpsAjWodObrcu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX6As5spNlofPZ
 w/xoNf3jOab/Yfi6t3cy9OrTWXMTi4PdDjviKuaLbkh0PCH3dAkzd6qC6naGdViccZIHarFrpaj
 ijCV6UsFj+udsVIAKy8VBLa2U6xo5tba/jwf55yUaTDpdtyUpuiK
X-Proofpoint-ORIG-GUID: E7ZFAr_IKF5miHNtEFRCpsAjWodObrcu
X-Authority-Analysis: v=2.4 cv=BJSDalQG c=1 sm=1 tr=0 ts=6a6b7d66 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=KbNV0rzHY6R870x3uNgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX/BU82A7adgRJ
 mQCobVHIsqfwabrjxyoRNM25QgElk4PXeacoqRovZ9UB+wsAeId33nAgTojrcD06kdAT0RzqREv
 yRdrxZfQ9pIR7zLoomjORL+uMxwiA208iSjCHlr/2pfD64it4c/pS3InuWIDBx2v+Encz8/87CX
 WsciofjVaymq1n0HnOr1pFXvUbggubfCKhqBzeMB7rlesrQpCKOC40v1WoF4SGmrhhCvNj4xNgu
 t2yAxeXzO5cBOpuhXPvl1T/WbWjMGrFZrHOhdWRHzxkvRRvF2PJ7VdV/RvYn0Hc2HEzskICGtv4
 FVzE1BYJG5cJhHgaM2P/GbEzJTtJBOMPYNoe19yuNuOeTasiXJlvBX2XPgHnj1KVFWc7Q5/ppPZ
 dielz+rcxVYvxYy+H04NkT+y42zwnHYtGT58Sw1tP24n8LZElOlbkpRiiUzX3fziFomir0VD8Vt
 8lJfkYt1T/bZ0tzx2JA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11860
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300124

kernel.ftrace_enabled=0 is now always refused, so the old scenario
(disable, fail to load a livepatch, re-enable, load) no longer applies.
Replace it with a single check that the write is refused with the new
error, and drop the now-stale disable/reload flow.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/livepatch/test-ftrace.sh        | 49 ++-----------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index d2c3dea63104..c88f4d13a134 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -9,56 +9,13 @@ MOD_LIVEPATCH=test_klp_livepatch
 setup_config
 
 
-# - turn ftrace_enabled OFF and verify livepatches can't load
-# - turn ftrace_enabled ON and verify livepatch can load
-# - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
+# - verify that kernel.ftrace_enabled=0 is refused (deprecated knob)
 
-start_test "livepatch interaction with ftrace_enabled sysctl"
+start_test "ftrace_enabled sysctl write is refused (deprecated)"
 
-set_ftrace_enabled 0
-load_failing_mod $MOD_LIVEPATCH
-
-set_ftrace_enabled 1
-load_lp $MOD_LIVEPATCH
-if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
-	echo -e "FAIL\n\n"
-	die "livepatch kselftest(s) failed"
-fi
-
-# Check that ftrace could not get disabled when a livepatch is enabled
 set_ftrace_enabled --fail 0
-if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
-	echo -e "FAIL\n\n"
-	die "livepatch kselftest(s) failed"
-fi
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH
 
-check_result "livepatch: kernel.ftrace_enabled = 0
-% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
-livepatch: failed to patch object 'vmlinux'
-livepatch: failed to enable patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
-insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
-livepatch: kernel.ftrace_enabled = 1
-% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-livepatch: '$MOD_LIVEPATCH': patching complete
-livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
-% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
-% rmmod $MOD_LIVEPATCH"
+check_result "livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Operation not supported"
 
 
 # - verify livepatch can load
-- 
2.34.1

