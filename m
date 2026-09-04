Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35C2D2385
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527902; cv=none; b=k3joGdubNrj9mEqX0TtfpwbaX1XESDCB+Tzt3QRmCeEFB3BnXTbx/O2snpRmlC2Ey/uHVysxe3WlCeY7JSRgK7FrqYcFajxvIb5AQ6PZt5Cl2+x8haG0YTfz9SDCunP9WMu/KA5BAjVxQscGW7J14C18XGDEIlMyC8V8KbG82sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527902; c=relaxed/simple;
	bh=WdyAKzHpoisOlZsZH2fywSTNWA1ruDt4nnUkyeoD8/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHzUAT9/HVDVz7r0pf90MwNhnfxymemP/LKQGpOyOBRU+zVYzSFKyU4sqHEOLkmg4eWbUcYnVuMn/7+ivmoV6qgaMYBTNpmj4ldVf5Asr7yU02Qd9hNjcSADHPSO/Gc25UNOITpkjjXSdyA+0mlOGQ+4z9oENqW315on776mbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG7oURlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG7oURlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66EA1F00ACA;
	Fri,  4 Sep 2026 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527895;
	bh=qOg9AgW2rwLbqIgpSJeT2chm4LhIqh4+xRqjfVguBtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iG7oURlKUojtY2H6ncrFOAKc8R1/2My2iXl2ksx19gwazAZvSeOr3baDz2i/7Da2+
	 gq/aSqMJqIRH9Em2XKwbRK4hAzMFWNuoIpRm8DrTh33A+MpaQQfCCQ2jtoG8Bu3M46
	 UJcIr/JPQ4zYf7JiJOR3DU5qeHyvOBS8QlE5vPkeDkFIaZNtHQ/h2YcM6sFRobEQGE
	 1+PavnJ0sWpwYJE2LnFKHjFWMhygEENJ/mA+LjKfJu7IJnAKW+phvhO4eS1Q4DwWzx
	 lfmkRRpPhQpNGixOwDtqGsD9X7ZOv1L105wmiZUGmlSuUopW6aDwTO0RaByUOkluob
	 k3tvhVo4/2lTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] tracing: Fix NULL vs IS_ERR() check in enable_instances()
Date: Fri,  4 Sep 2026 09:18:12 -0400
Message-ID: <20260904131813.503518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-creole-floral-cc49@gregkh>
References: <2026090305-creole-floral-cc49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 94dfa500e7deddceff22768bb994f0fa67bd2fd0 ]

The trace_array_create_systems() function returns error pointers, not
NULL.  Fix the check to match.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Link: https://lore.kernel.org/9b23ea03-d709-435f-a309-461c3d747457@moroto.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: a9a01be2834a ("tracing: Fix logged instance name on creation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f57baf67726da..61e7c857a4652 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9416,11 +9416,17 @@ static int trace_array_create_dir(struct trace_array *tr)
 }
 
 static struct trace_array *
-trace_array_create_systems(const char *name, const char *systems)
+trace_array_create_systems(const char *name, const char *systems,
+			   unsigned long range_addr_start,
+			   unsigned long range_addr_size)
 {
 	struct trace_array *tr;
 	int ret;
 
+	/* Reserved-memory trace buffers are not supported by this kernel. */
+	(void)range_addr_start;
+	(void)range_addr_size;
+
 	ret = -ENOMEM;
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
@@ -9494,7 +9500,7 @@ trace_array_create_systems(const char *name, const char *systems)
 
 static struct trace_array *trace_array_create(const char *name)
 {
-	return trace_array_create_systems(name, NULL);
+	return trace_array_create_systems(name, NULL, 0, 0);
 }
 
 static int instance_mkdir(const char *name)
@@ -9548,7 +9554,7 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 			goto out_unlock;
 	}
 
-	tr = trace_array_create_systems(name, systems);
+	tr = trace_array_create_systems(name, systems, 0, 0);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -10300,6 +10306,7 @@ __init static void enable_instances(void)
 {
 	struct trace_array *tr;
 	char *curr_str;
+	char *name;
 	char *str;
 	char *tok;
 
@@ -10308,17 +10315,21 @@ __init static void enable_instances(void)
 	str = boot_instance_info;
 
 	while ((curr_str = strsep(&str, "\t"))) {
+		unsigned long addr = 0;
+		unsigned long size = 0;
 
 		tok = strsep(&curr_str, ",");
+		name = tok;
 
 		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
-			do_allocate_snapshot(tok);
+			do_allocate_snapshot(name);
 
-		tr = trace_array_get_by_name(tok, NULL);
-		if (!tr) {
-			pr_warn("Failed to create instance buffer %s\n", curr_str);
+		tr = trace_array_create_systems(name, NULL, addr, size);
+		if (IS_ERR(tr)) {
+			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
 		}
+
 		/* Allow user space to delete it */
 		trace_array_put(tr);
 
-- 
2.53.0

