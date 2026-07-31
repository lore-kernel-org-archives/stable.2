Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154F3AFB1B;
	Fri, 31 Jul 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520470; cv=none; b=LyhsPnfFG4ZkOIK9AlQvYhuvGZxbag5ZC+ohGAK/qFcpaYf4PTuflUTm5keU4/7ZOdTaPrvgjxsXD/dLL2qS1Sl7ygpTyhaD87WUXkNi2+++VL7sDd+z85SPq6jO7mHWIw665oRCyZVqnVSTTnRLAW4sZGtI43aiVyHDKn4UXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520470; c=relaxed/simple;
	bh=qr5r+bAR9t9YawLhjXHn0s8dhhvAP3uxjDSVv9UTfcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOhB7+z3c+cvj4G4MRf84AbjrCUR6si61rSavWhKjirjtDoYBt5+JacB5Nnv82DAFNE52ferNXE6Sf0WLWWeATrYSApGpO2jtwmXCnSxYY2ssLPnzPpMBnRVb8rv9rCoFoBUmzqjU18enrMCmhmvJOFD2yP1xIaKJ61XkGy01ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=f0/gPqH6; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="f0/gPqH6"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFbFe83434333;
	Fri, 31 Jul 2026 17:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aPFUvNh49KyhEnoc3gwHxHob1HdUvc0JRVdwObaOFuU=; b=f0/g
	PqH6peE1LT/jKslwegCASBwOaZrKMhdx6e76t/R1A1GbKWMCxZR7/f3d0fMwCOI4
	CjMjfwSkYA7ubUed32U/ccbQHwmqaQR9VImISy0pU84a95Dyrw98MTsAY0g0qIfm
	6JG0Q2tWSwGbD54BomtxhqKA+TVEvxs7GfUnEUOa6PEr5KNhLT3evCI446kka3bt
	MZvUzD4ZacX6GjosncecvO72mgS6FeyvjFqwxMwLQKITdj1wOsY9HNwwoAygAiHm
	e0J0yxEf4FhT8vQN4MykKh96kyaC1TQiHPufMbFE72e1NI7PWqhGnIOLGNYFwEwC
	EkpZCKHjGvUtEGXIZg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4frebv3nj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 17:54:02 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 31 Jul 2026 17:54:00 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <rostedt@goodmis.org>, <mbenes@suse.cz>
CC: <corbet@lwn.net>, <jpoimboe@kernel.org>, <shuah@kernel.org>,
        <jolsa@kernel.org>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v2 1/2] ftrace: deprecate disabling via ftrace_enabled sysctl
Date: Fri, 31 Jul 2026 13:53:57 -0400
Message-ID: <20260731175358.3542156-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfX1n1T0fJQr6PQ
 rJOXt+m0yVxqCssnwhXdlOChmTnHMtk4/TV+CMzFLYCP4xBk1C9EBFxWt5B0BBjq0jbH9/GO/5K
 NCR5pTQz6N52ildi/JggApKHeVACqFIj27en+FuJ6+5B80eKbYtTJe0BS4OEOTV05YJNVJQ30N8
 fqgJDAqGaEnqe29NnwsPY5bkJBmO44s+FXYBx54FhlpjR2LIx4V4Cjk3iWgil8MvI/yy8dGPqKq
 WYTe9LYY0jUs/XyAMXyMtT6XrjbYCb1OQZm5gtG1XNFhgGkwg+/CVbRb+x3o95Xf27e0lJp2JOx
 obBlJMW4SwpiV4AzG99PDBrBCaqay71AThy9pBbO7K6n70JNx2MXZsLOfmYEERxeAG+G0BljWuM
 lI3zYs+UqihB4TDMv4v04QSMOIvPVNgPFeggeKR/XykSnuxgRmno3wd5E0pM/aNY7Y3skqZzu+G
 FzJq5EwbhyI1gfh3Igw==
X-Proofpoint-ORIG-GUID: 4YXlTKOsE8QrS3B5N0Mic60Pc-BZYm_Q
X-Proofpoint-GUID: 4YXlTKOsE8QrS3B5N0Mic60Pc-BZYm_Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfX4qGsQ1pEmUjp
 Q9xL0R7JLogpoE4GlapYs9xeQB8u5DdIdg0bvxgmfUeqfon5MkEdn/NDVFUN4JZVx4e6xoRLEUn
 KcaIomvYlgziM1x2yHjkUBN3MA7IQ6dg/7joWEPZFKHottQuwJNI
X-Authority-Analysis: v=2.4 cv=NrvhtcdJ c=1 sm=1 tr=0 ts=6a6ce13a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=meVymXHHAAAA:8
 a=pl6vuDidAAAA:8 a=DP8ZHgaaT86FnG86Ol0A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11861
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310137

Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
callers rely on ftrace always being on). Refuse the write instead of
leaving it in an inconsistent "disables some, not all" state: return
-EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
unaffected.

Update the docs to note the deprecation up front.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 Documentation/trace/ftrace.rst |  5 +++++
 kernel/trace/ftrace.c          | 19 ++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 84f06bf0da9b..7261f25f8b4b 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3313,6 +3313,11 @@ this special filter via::
 ftrace_enabled
 --------------
 
+.. note::
+   Disabling ftrace via this switch is deprecated. Writing 0 is refused
+   with -EOPNOTSUPP and logs a warning; writing 1 and reading the value
+   are unaffected.
+
 Note, the proc sysctl ftrace_enable is a big on/off switch for the
 function tracer. By default it is enabled (when function tracing is
 enabled in the kernel). If it is disabled, all function tracing is
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..82bb7356ccce 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -9357,7 +9357,7 @@ static void ftrace_startup_sysctl(void)
 	}
 }
 
-static void ftrace_shutdown_sysctl(void)
+static void __maybe_unused ftrace_shutdown_sysctl(void)
 {
 	int command;
 
@@ -9377,7 +9377,7 @@ static void ftrace_shutdown_sysctl(void)
 # define ftrace_shutdown_sysctl()      do { } while (0)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-static bool is_permanent_ops_registered(void)
+static bool __maybe_unused is_permanent_ops_registered(void)
 {
 	struct ftrace_ops *op;
 
@@ -9415,15 +9415,12 @@ ftrace_enable_sysctl(const struct ctl_table *table, int write,
 		ftrace_startup_sysctl();
 
 	} else {
-		if (is_permanent_ops_registered()) {
-			ftrace_enabled = true;
-			return -EBUSY;
-		}
-
-		/* stopping ftrace calls (just send to ftrace_stub) */
-		ftrace_trace_function = ftrace_stub;
-
-		ftrace_shutdown_sysctl();
+		/*
+		 * Disabling ftrace at runtime via this knob is deprecated.
+		 */
+		ftrace_enabled = true;
+		pr_warn_once("The ftrace_enabled file is deprecated and no longer disables ftrace\n");
+		return -EOPNOTSUPP;
 	}
 
 	last_ftrace_enabled = !!ftrace_enabled;
-- 
2.34.1

