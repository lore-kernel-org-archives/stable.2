Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5713B636A;
	Thu, 30 Jul 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429376; cv=none; b=ruclJArjQr85uDV6L2iqIZEzNBRky4wHp/yS/jYC6+4TJh1nhx8+8+Y8oy9b1Mw3dwnCFCn3/NHKlkeE0tApan3Jf26QTpTeJEPW6KdFih+Y9Q71trCA3pzYRjHF8YXV7rOX11Bg7iKGUGbQac+6LEBlahOXlLwfuSyJOe/Nn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429376; c=relaxed/simple;
	bh=qr5r+bAR9t9YawLhjXHn0s8dhhvAP3uxjDSVv9UTfcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUvJ2O0Bs+o6GUdPGr7Cs9g7eHDnmEdk0HQxgXES2vWPn8FUqDs63y1j6UpaLqo0P8ytU3+ll1hojblAp/v6gsUzygAgI8xJgrzJNEcL5eq4Bh+X9UQYFbozy2CLIdFj/dbylnHoK+V6jvksM/S7FlIsNSyXWsh3kSQGa3s9wWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=RyqO5Oij; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="RyqO5Oij"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UEdbKd1352574;
	Thu, 30 Jul 2026 16:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aPFUvNh49KyhEnoc3gwHxHob1HdUvc0JRVdwObaOFuU=; b=RyqO
	5Oij29Z7LwknSkQ6BaDUqGYINl/YBFPHTeGue8dvD3l4GRyEO29wcKTzfhK7PkQV
	dQN5E2ZrcXbt6rRQN6hMav3M4t8xtTb2kA1DXacqIbUUh9q0nDOibjTCapPeOTPQ
	QY8Q9MiAn3EhsURfcbE9JWCTFzcgqs3LALC2KcawjxBkT6vGhUa0vHvDwoZI76gD
	S5bistgKvr4l3Kg4PGdyA1GNIaCa+SZrek3ne0nhWRcMkPPDpJtXgKc+lug5TXnN
	qYRwi0kH592oNx+QTj4RkKTfjX5JW0rEZytHqfiP8TokPgb715nsAgGNEjCTTYAr
	zNsQNUaxXTr4+hn7ew==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fqp17vf9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:35:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 30 Jul 2026 16:35:46 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <rostedt@goodmis.org>, <corbet@lwn.net>, <jpoimboe@kernel.org>,
        <shuah@kernel.org>, <jolsa@kernel.org>, <mbenes@suse.cz>,
        <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 1/2] ftrace: deprecate disabling via ftrace_enabled sysctl
Date: Thu, 30 Jul 2026 12:35:43 -0400
Message-ID: <20260730163544.2042327-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfXxl95eovquwHx
 EAd6CuMAw5mdUwvh+qFx9urUFmpLFgLvZfcOrroYmvz7Ap3mxHCU/h+RjjqKPINUEvUA8Ro9CkT
 r1aHZV8WTASV+3UShD0ETXT9ENElBYQ983jSJpImi75r1HEhQ6HJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX+wHOFl8cjIQL
 kJEOHlKVl5NFpI9zk3gbj/k9leIuUQw7dO2SGaYuVOXgiU6FICSlAWgaKnon7VDA0+vSMI8TN6w
 hM0pYYE8YGYtprHGlz35KdyGGDyV7e38HdCjcIojaHXIuJzBrYg62gGaBDkwmPyloLJ5Ad0XfAq
 2eQ9PpPCAqm/jmeGOGaVxVhrBHhtq/WlQZ/BlSenIcFUgSxbaCMY2AqU6WGAtPKYyiiMeGQ8NWT
 pE2HuHUnQ2Y1secCZgmnpYyJKG0FtNZtJ81oyMHEND78QfjI+3O/cBNSzKpc1phY0oZZuxKA0yI
 XFyquW07y0JxmAtj+bhfSK/i9ufn2Co8SfiIbKztS52WyPHNsQ04TJfONPjpwpVB6z7BCuI9dZm
 5v4o0WxC/U01Z1wWDBxDcQmzUbcq5S7HluL9vJJc+yqPlLgOy9xdkCVvRfe/91Qao5M+xWGae4M
 ucZ7jiucPeYv1kOTRTg==
X-Proofpoint-ORIG-GUID: jwVzv_2IEuttl9QA2MqVEf20rcPc0Qjn
X-Authority-Analysis: v=2.4 cv=Pt6jqQM3 c=1 sm=1 tr=0 ts=6a6b7d64 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=meVymXHHAAAA:8
 a=pl6vuDidAAAA:8 a=DP8ZHgaaT86FnG86Ol0A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: jwVzv_2IEuttl9QA2MqVEf20rcPc0Qjn
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11860
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300124

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

