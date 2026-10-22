Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688157;
	b=vGSfZcac7waFKQoOYnUce7npYuDKX+piAaJ0JYIGhamIARa9sB5lR2DMowMerKz1EOC0
	 1zJeLBJKhkakjGyoMxmsBzzNFnxQGJ4k4Iiz8zyueLuY9qybEznPMSBiVB/bDkSZrMzEy
	 qjHw/iC0GZj6Kqspj3/zGmg8uDPWMme85bxtJBTHKpHfcwMUPtRYh9tUG7dy3nR2nIaHY
	 woY36pee79DD+hYzrU207iV52+ih77E7l1Xhdiy3nyRlKfcP/8+oeAydXvHankloqH+vT
	 PHz858T43CHL2Vy1gtzBB8bPK5nz/IsxW11T7g62RY/eZ7twuboQSiR+dol6qARiv9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VA9V0YBG6b0q0IcQYLKm9l1pDTTiK+Lqvk1PdMP2dC0=;
	b=YykdgcyXBhuEdO9ycqvx8RVlGtpezwlkRYXI0lYMK5kUSTCHEwD7kER3P6L/MgkYib2l
	 IJCoJ3uxkavmvYjg7gALd7Q27+cftCk5jStRgSeqoMFB13WRjTdDyqWh1gw91qsBSngR+
	 V+chnWvVOlp4Eny0knwvNQyqy4NkNwd0eQuVtJAF3O9sh9ZptlBvZepzce+n8L8ETZzQa
	 at6JdUuUrgyqko/Ho9XnLo0pUdnVYyDL016zf2lISFNpUtFwsdzPogs3YqlImSYJ1wefy
	 XYu2YgvA91i4QcHC8U+2IZOf6XBoT2FoA+ZzU2YdwQzSnr35QT36iddYmQ3LcNaNX9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A7yaAfo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7B606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7yaAfo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4821F01828;
	Thu, 22 Oct 2026 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792688157;
	bh=VA9V0YBG6b0q0IcQYLKm9l1pDTTiK+Lqvk1PdMP2dC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7yaAfo/JEWAYvKPINlXxlyNvl9BkIxVEoCyb2rKLCUNVEqAsTyBuisT2MfEi04mU
	 6yfHhuD5YzGO/q6KCmlCx9pvmLcEbMiua+glwI3Hnh3BK3OmWL96+JLIugQAc0KJ6Y
	 Mup9cO0nQSWtXVwutj1jxXSS5BeZUMzunkw4x/JnukKXuPmuYSEWR6pRSTU7R7cuqf
	 WAVyY7UcJnkebpKj0LjopJ2CyqUBW6F5oINikUWTzDlJXIFrY9EtHAN0GlgVqWD9Pk
	 UyzcbnXRsnr7jQUfPzwH2LA+/bBdeYbqnA2RIGJA1bg4B6YMC5aD1WBLSYeSqX0ekD
	 FT11oHizwiLug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 12:55:55 -0400
Message-ID: <20261022165145.1679070-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102127-reclining-snowplow-d25d@gregkh>
References: <2026102127-reclining-snowplow-d25d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit a0777b9e53157f1f6848a0fd0650f5465391ea81 ]

In event_hist_trigger_parse() where it needs to create actions like
"onmatch", it calls:

  event_hist_trigger_parse() {
    create_actions() {
      action_create() {
        trace_action_create() {
          trace_action_create_field_var() {
            create_field_var_hist()

Where create_field_var_hist() does a loop on the hist_data
representing the keys. The issue is, if the keys uses one of the
pseudo field types (like common_cpu), the hist_data field element
will have NULL for its field member causing a NULL pointer
dereference when accessing the key_field->field->name.

  # echo 'hist:keys=common_cpu:ts0=common_timestamp.usecs' > \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int prio' > synthetic_events
  # echo 'hist:keys=common_cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)' > \
      events/sched/sched_switch/trigger

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:create_field_var_hist+0x771/0x1380
  Call Trace:
   trace_action_create_field_var+0x360/0x600
   trace_action_create+0x393/0xe80
   event_hist_trigger_parse+0x3e47/0x69e0
   trigger_process_regex+0x1a6/0x250
   event_trigger_write+0xce/0x160

Instead of accessing it directly, use the proper handler
expr_field_str() to get the name.

The three previous patches are prerequisites: without them a .buckets
key and a common_stacktrace key each render into a command that cannot
be parsed back.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914053443.981201-5-donggeunyoo.kernel@gmail.com
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ sashal: adapted the expr_field_str() call to pass a char * buffer instead of a struct seq_buf pointer ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c93254ae83ccc..c38728abda17f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2593,7 +2593,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			strcat(cmd, ",");
-		strcat(cmd, key_field->field->name);
+		expr_field_str(key_field, cmd);
 		first = false;
 	}
 
-- 
2.53.0

