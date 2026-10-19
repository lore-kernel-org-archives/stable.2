Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437842;
	b=QzJ2gIpO7ozKlA0HqO7vI3+3sbX+3P0ECOsyO3HYV0980JB21oIcxl/9lzuEinSuidtM
	 AljFN6Z8L4tAE18ajCWVuxPecPApIiRDzDPqWLuPIvZYqF5mrGi5WHD4v4XD/tZPa/G0f
	 ZlwZeOUEOKDevHa/pzJYpo4MEteF2FQ4D107TN3wvWtmKgP2YnuC3xeho02nnS8MMllSY
	 5/6lZbaE08yejSjuFU1AHcb9eJieXZaGZmQXXbnuA9GiGiXMih32pRgzYzXtlyXks5KJD
	 X9hnpd8bb/THZnoVM+qwqrzRTW1V0/2STViVvTFEmgoegDk6qLwXGqlnjGO8WhFfGAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437842;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=qvo4bbQ/ofSmszMuiXKQj2CYkjAHtS+en8Odnv1yaQc=;
	b=HEb7yX1FUDUFXX/Vnwd+GrZE6WFn6y14lffOETTtGB8Wrdse7e81UDUGgNhDcB4+PJ1I
	 X6p3/QsHF5Q+UlKc5fmYXVRIoZreLqMig5EcWgZ5x2o1IHgXpYwgnEOak1JwpPt82Ncs6
	 E5SPkWus/LOGRB49wLikoUn6DbicYMTNIDOam9WRCjmuw2nuI2VQkOmqMdN1PU5RE1zs2
	 LiKTenFNE+HBNmXXHYzid3IaRJd9/44s4tX90/xr0wdwsbypmW7VV0nmUZZueww2UoW2w
	 YGmnlU+gayCoT3O04fDlg7PErr+tAWl0huDNIw9ScMNmI5rIU0lAje6wmThxNsfuF0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhGE3IOa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2B606A31F;
	Mon, 19 Oct 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhGE3IOa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5131F000CD;
	Mon, 19 Oct 2026 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437841;
	bh=qvo4bbQ/ofSmszMuiXKQj2CYkjAHtS+en8Odnv1yaQc=;
	h=Date:From:To:Cc:Subject:References;
	b=nhGE3IOa9e7MlwMMkSKbH8E+KHWEoKO7IgMbDUJOyMCNPE+VhKTgsTKtnwWwscMiq
	 hCnWkd01Xqgag2SD2r8U98a6DSoL9yZWAhtNj+g14GNW8W+DcARG1ClTSkBKodtst/
	 97jwaKz5snV3WAsQmHpMOjxBhDnP8x6SWGkiJ1kGo6c2mFfFBo7nq57NTb9g5tO4DN
	 VkQ6qucrAqB6K0HNYeaGBjw0VC8GRpoXQgKiGpPTJ1HnR/uAaatAz1RyfCQnvt6CNr
	 D+kgG4kIUU5h4iQpsUj23BaCm1jA9QAC11bstbty4VLblGk5xN7lcl80ykqGmKc+oy
	 Y3yI9YIwsWbDQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xIsxk-00000001eJp-47N9;
	Mon, 19 Oct 2026 15:24:00 -0400
Message-ID: <20261019192400.787979601@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 19 Oct 2026 15:23:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Gavin Inglis <giinglis@amazon.com>,
 Aaron Ahmed <aarnahmd@amazon.com>
Subject: [for-next][PATCH 9/9] ftrace: Initialize modname and offset in print_rec()
References: <20261019192344.004592683@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Aaron Ahmed <aarnahmd@amazon.com>

print_rec() leaves 'modname' and 'offset' uninitialized and
kallsyms_lookup() only sets them on success. When the lookup fails like
when a module is being loaded or unloaded, 'modname' holds a garbage
value, passes the 'if (modname)' check, and is dereferenced by
seq_printf().

  Oops: general protection fault
  RIP: 0010:string+0x48/0xe0
  Call Trace:
   vsnprintf+0x1f5/0x650
   seq_printf+0x8e/0xb0
   print_rec+0x6c/0xc0
   t_show+0x4c/0x440
   seq_read_iter+0x119/0x480

This can be triggered by reading available_filter_functions while a
module is being loaded or unloaded.

Initialize both variables so a failed lookup skips the module name.

Cc: stable@vger.kernel.org
Fixes: b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
Link: https://patch.msgid.link/20261016230403.4916-1-aarnahmd@amazon.com
Tested-by: Gavin Inglis <giinglis@amazon.com>
Signed-off-by: Aaron Ahmed <aarnahmd@amazon.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b2597eb9581b..c7d74b33d36d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4431,9 +4431,9 @@ subsys_initcall(ftrace_check_for_weak_functions);
 
 static int print_rec(struct seq_file *m, unsigned long ip)
 {
-	unsigned long offset;
+	unsigned long offset = 0;
 	char str[KSYM_SYMBOL_LEN];
-	char *modname;
+	char *modname = NULL;
 	const char *ret;
 
 	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);
-- 
2.53.0
