Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC737DAAE;
	Sun,  9 Aug 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242738; cv=none; b=IcjbPmYJzhqEatqRyj533A01BXPHxvMpSjQ6mlOWKYJUKGmlMHbn9O/GDcU6iSCQ1j/1Myvsws68UC9ossi7fzDEoUzVGOZk35TTW3zu5o7fYWF3AV/uCBiZuunxEANUQo9HKVV0Y3i+8WIkgJflf+Wwbj5/IuxOnQX2wBcFYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242738; c=relaxed/simple;
	bh=qYArbJM/Ky7ieTV7mLSRd5w7dIPe9cHsHZQxM03DSE8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EZCmVOf95W84pq4mNA/ZLb5ypU3eKiUzpEOBBCsTo1bzZLiy5dkdC5r8LQZjsjOn9HntySr0TJgRWD44dmgGylrBRr8W5tvJGvaIcodDPGHcQqv9H11o0ODK1oZw26M0vLzbTvXomCymspjwEPLMDfmQEflXMOxd2njf30os/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu1llMDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu1llMDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6EF1F00AC4;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242736;
	bh=pTR46X70duIEW3e4MGyPdQ0CYj/oUx/vVN7OebHihLA=;
	h=Date:From:To:Cc:Subject:References;
	b=Lu1llMDCrCUI4g0Ew1KuH9XWoDj8v32ATCJVUKm6Mhghi2OxdTmtRGiV6ALzfNSMm
	 qhIxe/K7AE9DVT81uPNGhoXddk3YMHRUgz+EvK3+9CDDUJfGovWJGjBVhoTNIKqrSY
	 ko9ZUg3mYYfdMl36qidsRSxDwgmltW0BkclYas7wDsuwxIzGDbj888PpVjgdCD8T0x
	 DcSw8IOvrs4lPv9ZbdEVwlI/gmk3peXeAnd0TECXJ+PXrkh+A1Ua4FNvjmPEj1M9V0
	 TKk/iEUI+fjtav+PJo3dcUvF/NX5BF1J1VZeI4gJTz+jPQjU1mxukSNEeOBeuM1wle
	 w/B775sj0uLiw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKo-00000001N6C-2fxo;
	Sat, 08 Aug 2026 22:32:22 -0400
Message-ID: <20260809023222.497514011@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [for-linus][PATCH 08/12] ftrace: Fix off-by-one fentry site disable in ftrace_free_mem()
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

When a module's init text is freed, do_init_module() calls
ftrace_free_mem() with a half-open [start, end) range.  However the
ftrace_cmp_recs() comparator treats the upper bound as inclusive, as all
its other users do, passing 'ip + size - 1'.  So ftrace_free_mem() can
delete a record sitting exactly at 'end', which is outside the freed
range.

For a kernel without CFI or IBT, the first record of a function is at
the function start, which for the first function in a module is also the
base of its text allocation.  As the module allocator packs its regions,
that address is often the 'end' passed by a neighboring module's
do_init_module(), causing the first function's ftrace location to get
disabled, preventing an attempt to livepatch it:

  livepatch: failed to find location for function 'pcspkr_probe'

Convert the exclusive end to the inclusive 'end - 1' the comparator
expects, and return early for an empty range to avoid the subtraction
from underflowing when the init text size is zero.

Cc: stable@vger.kernel.org
Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record init functions on boot up")
Link: https://patch.msgid.link/1b5ccfa8095bdb1277f84af1c2c2e2205aca03ae.1785992188.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 414e425c2d80..7c50f8ae5a0c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8305,7 +8305,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 {
 	unsigned long start = (unsigned long)(start_ptr);
-	unsigned long end = (unsigned long)(end_ptr);
+	/* end is inclusive and end_ptr is exclusive */
+	unsigned long end = (unsigned long)(end_ptr) - 1;
 	struct ftrace_page **last_pg = &ftrace_pages_start;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
@@ -8315,6 +8316,9 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_init_func *func, *func_next;
 	LIST_HEAD(clear_hash);
 
+	if (start_ptr >= end_ptr)
+		return;
+
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
-- 
2.53.0


