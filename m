Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0374AEBF9;
	Fri, 11 Sep 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150580; cv=none; b=p+AB0cEL7H0hEcxUDYUaDiS1BSTCP4u3mswSBh5PJm1PGOiOGo6jtUEi/SNCl6qPqiLj7iNA9EIJQOG2GQ69UbClzaf3qq6+Kqs6TOvz9Yg+kUUQkW3WoGBjVOc6J12VT3taO+BADA4DgrI7Lb0JnGHCw/kceO+jXxF5okK92Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150580; c=relaxed/simple;
	bh=ESv02GWyTuZyme+ZIbqMPOevUrjH5HoNJruHBg9X3pE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vo0GgYMOBj8q/WVAn1i94UmfesgUSNqWiEljQ+N+kbQdtZZQe2HDOYzz6Wptm9vX+PJ5+Z2JECfB2j2GDLX+vd3F055RYR79N8RCfNxQ+/xrAPCMSq4kd4YL/785Zn2pxiuZJLgQ9nRTyMN7jz6sZZ0nKuT2I4Xq+4ozuvt+LVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgFOD70w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgFOD70w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB61F0089E;
	Fri, 11 Sep 2026 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150568;
	bh=vIILeZZui+JTV57AhAjUl87zg5bT89Mh3Q5N+4tiYZ0=;
	h=Date:From:To:Cc:Subject:References;
	b=KgFOD70wbFkqaQvkJuuIVXSjds15VEn+IKaswo9d9f4p5MOazgDr8ublO8dJpsaqO
	 xki4M31uHu7W7FIalkS21Oc6rcMaHzURqDRMFXuIbNp031TL+22RqHc+ai26P+lDxw
	 mH+9EdELuv+66QWnxOVpqTPru9L542RBsJZPZxRLCU8sCsX9vRCNtX8ITpwdqC1MBF
	 m0tswrjb8Z1qiM6EkLOOLjF47qLUvEDlmBJm42NkT10Kein5upxY3ea8jNoeBg5NFW
	 PEqdJaMmzt/NOmng/enmg0p1fZU5gNxb6SPcPTkxCgO4ycEcp9zMXq0HvhDiJ8VTN8
	 svAbrAxh3MS7A==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oY-000000094yv-02Oa;
	Fri, 11 Sep 2026 14:17:30 -0400
Message-ID: <20260911181729.830006531@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 08/20] tracing: Keep the entry count when the histogram stats allocation
 fails
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

print_entries() uses n_entries both as the number of sort entries and as
its own return value, so the -ENOMEM it stores when the stats allocation
fails overwrites the count that the cleanup still needs:

	n_entries = tracing_map_sort_entries(map, ...);
	if (n_entries < 0)
		return n_entries;
	...
			if (!stats) {
				n_entries = -ENOMEM;
				goto out;
			}
	...
 out:
	tracing_map_destroy_sort_entries(sort_entries, n_entries);

tracing_map_destroy_sort_entries() takes an unsigned int and loops up to
it, so -ENOMEM arrives as 4294967284. It walks an array of at most
map->max_elts pointers and calls destroy_sort_entry(), which dereferences
and frees, on whatever lies past the end.

Reading the hist file of a trigger with a .percent value, with that
allocation forced to fail:

  BUG: KASAN: vmalloc-out-of-bounds in tracing_map_destroy_sort_entries+0xa0/0xb0
  Read of size 8 at addr ffffc90000045000 by task init/1
   tracing_map_destroy_sort_entries+0xa0/0xb0
   hist_show+0x6f7/0x1df0
   seq_read_iter+0x2b8/0x1190
   vfs_read+0x176/0xa40
  The buggy address belongs to a 4-page vmalloc region starting at
  ffffc90000041000 allocated at tracing_map_sort_entries+0x5c/0xd50

A few pages further the fault is fatal. The registers at the oops confirm
the bound: the loop's end pointer less the array start, over the pointer
size, is 4294967284.

Return the error in a separate variable and leave n_entries holding the
count, the way tracing_map_sort_entries() does on its own error path.

The stats block is only entered for a value carrying .percent or .graph,
which __create_val_field() has rejected since v6.3, so this cannot be
reached in mainline as it stands. It becomes reachable again with
"tracing: hist: let values keep the percent and graph modifiers", so it
should be applied first.

Cc: stable@vger.kernel.org
Fixes: abaa5258ce5e ("tracing: Add .percent suffix option to histogram values")
Link: https://patch.msgid.link/20260907060323.480728-1-donggeunyoo.kernel@gmail.com
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260907053113.1CED91F00A3A@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8cad99a8d01e..8d80562fb502 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5677,7 +5677,7 @@ static int print_entries(struct seq_file *m,
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
-	int i, j, n_entries;
+	int i, j, n_entries, ret;
 	struct hist_val_stat *stats = NULL;
 	u64 val;
 
@@ -5687,6 +5687,8 @@ static int print_entries(struct seq_file *m,
 	if (n_entries < 0)
 		return n_entries;
 
+	ret = n_entries;
+
 	/* Calculate the max and the total for each field if needed. */
 	for (j = 0; j < hist_data->n_vals; j++) {
 		if (!(hist_data->fields[j]->flags &
@@ -5695,7 +5697,7 @@ static int print_entries(struct seq_file *m,
 		if (!stats) {
 			stats = kzalloc_objs(*stats, hist_data->n_vals);
 			if (!stats) {
-				n_entries = -ENOMEM;
+				ret = -ENOMEM;
 				goto out;
 			}
 		}
@@ -5716,7 +5718,7 @@ static int print_entries(struct seq_file *m,
 out:
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 
-	return n_entries;
+	return ret;
 }
 
 static void hist_trigger_show(struct seq_file *m,
-- 
2.53.0
