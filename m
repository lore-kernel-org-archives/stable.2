Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C747CC6B;
	Thu,  6 Aug 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030236; cv=none; b=YzKgFtOmUksBtzVWjDdtVMvfKVOdzF1fM5icrhnfnsKD/7B1g2H1bKGZEX8wVD5vdyzRzqOxbpjwjeaBiYCleAjRqeT9v5LNm/f7oV3AyOavRfbyl8i8XK6KWwVF/WaQmqW+DyfP5s4zmPjljiQsP400Rl647RNiPvXyCtsvjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030236; c=relaxed/simple;
	bh=ZtIq6/5bAhllRQcM6dw+CmERgXnw6MpXcKHxDfb5F7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xbuvmi1XmqSozkxvGX2wFt8AdJzt2h1/N2ZKPLB2nCyOd1Nu3K6Ckz1VpqwkWv9LlHbZoDmyZpeSANxEQMky78YnaGOALjPcFQtbxqn5eY/uXJtZtTYB+E/d46S4XFvyG6y40XQO5z1goL9V6TdyRKlxeO5udcCWNX/jg3yuH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=aDasLJhI; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="aDasLJhI"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676F84Gn1695370;
	Thu, 6 Aug 2026 15:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=LlzcFzO05CbeOTXkpW4o6fZ5jrxdT7zClT10VI4GfzU=; b=aDas
	LJhIfzbq1OJxwlx6mHf8kTXS5Gk5pXftpAp12BeICD0zmS1LZuJrTg6FeFQTjxk9
	htWTakG7RWmWC2GIOpcTU+cWw7GfDVvUY5fkgdqYiHKpzjd4QxHIb1/3dkBlDc5l
	wl1iCc4lViGyFHhGusTjpVPC1XdqIsLXZxSQ4gRPMPYUEGePR5FUkQlRL6OqNyyh
	N1s/TVWDYOwthix6qT6x8X/AowIz1pJTN2zFv1OmTn/0jScglMMRnU9YhM+0ort0
	TAJodgYcWmut/DHHdXNlAcv0qtkzTQWQ2gmTDz9t5RwJFCBIR4ynHFfPx1r5jAt9
	jN9NosnHS7eQrCo55Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fvs8vs75y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:30:04 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 6 Aug 2026 15:30:02 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <rostedt@goodmis.org>,
        <mbenes@suse.cz>
CC: <jolsa@kernel.org>, <mhiramat@kernel.org>, <jpoimboe@kernel.org>,
        <joe.lawrence@redhat.com>, <mark.rutland@arm.com>, <corbet@lwn.net>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via ftrace_enabled sysctl
Date: Thu, 6 Aug 2026 11:29:59 -0400
Message-ID: <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-GUID: eiX1hENDWMuUNbHPAjyfAyxKV5sLht3U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX9OqOavE7Lf+2
 yi/aJe/SDiWNwERK/HWjkkrxIwx0OedetXWNiqkqARfqAb8IXV+F6LOKN0Qo7YPa9cPDgYmSnZs
 BI2VaiuHgMb8MZHeos/rimx9EjWyezxc2WTlhGJX1dSMiLJRXJ+b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX4u+JVSE2aOY+
 DQqTX3+KKFe2Z5G9FVrZiXyl2K9eenJmEfYYIADGdTphHft6vRQDcZKsIvNSK5+xLHLijYoLXpC
 YdfzfaFy04maTw6x5FcboGsYEezdwB6VFcaG0D21e+OJZ68b4kZCwMBl7KYV5FR010PQiME+Pyb
 c4yiR2HBE7zvJlqRUu9XhPRqvHXfmaaP8IyGG/MHjtKYt30pcuLl6GWUnYhVZ3YIR8jFeaEdVWX
 NtZ6jMRCOvqqIr6u9YCwV9lWXQpOHPTblGeXVXFweCDi3upHwPanW4yV1IYFdOobJtiRVpn8+8I
 eJo8C1xET14aJ3TudxYjTF+ZxVFXUY4TJnchoYxuxbxUfUvkznhAb2iU/kmgSC/du+zH0OH6n7D
 pmQxdyqUm1ObavzKG8V47AkY/L7pCkXKXBHvmPkW+1xZyjR+HeaOGqm2hFYT/2RKHGO5xJNGyxm
 5nU4yjIBZXeULCDqVgA==
X-Authority-Analysis: v=2.4 cv=VvsTxe2n c=1 sm=1 tr=0 ts=6a74a87c cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=meVymXHHAAAA:8
 a=pl6vuDidAAAA:8 a=7442PqFpXPzSHI4nqToA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: eiX1hENDWMuUNbHPAjyfAyxKV5sLht3U
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060120

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
 Documentation/trace/ftrace.rst |  5 ++++
 kernel/trace/ftrace.c          | 43 +++++-----------------------------
 2 files changed, 11 insertions(+), 37 deletions(-)

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
index f93e34dd2328..3c0231ad6473 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -9357,38 +9357,10 @@ static void ftrace_startup_sysctl(void)
 	}
 }
 
-static void ftrace_shutdown_sysctl(void)
-{
-	int command;
-
-	if (unlikely(ftrace_disabled))
-		return;
-
-	/* ftrace_start_up is true if ftrace is running */
-	if (ftrace_start_up) {
-		command = FTRACE_DISABLE_CALLS;
-		if (ftrace_graph_active)
-			command |= FTRACE_STOP_FUNC_RET;
-		ftrace_run_update_code(command);
-	}
-}
 #else
 # define ftrace_startup_sysctl()       do { } while (0)
-# define ftrace_shutdown_sysctl()      do { } while (0)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-static bool is_permanent_ops_registered(void)
-{
-	struct ftrace_ops *op;
-
-	do_for_each_ftrace_op(op, ftrace_ops_list) {
-		if (op->flags & FTRACE_OPS_FL_PERMANENT)
-			return true;
-	} while_for_each_ftrace_op(op);
-
-	return false;
-}
-
 static int
 ftrace_enable_sysctl(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
@@ -9415,15 +9387,12 @@ ftrace_enable_sysctl(const struct ctl_table *table, int write,
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

