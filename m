Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678672;
	b=jIgurHNTWPvMLjpVvYXSmXYzl1Aj+eaUeH7es0l10Dwv40tJwc5r/wZEedhltv+gSSbW
	 QAzc8OsKX94JX7sumtAVG3hDZwkAHrmfToO9fnGPggChjfJE59ZH9Sk7TmkTXQrUmw0Ms
	 9LfRHEIxKJz9il4qrACggj949rw6WffJ8tknZRZbwePbnZ6XxsTsErO59Bfh6A2U1xj7K
	 EMbGR7rfbd74mIU1fZct9ygyAofv9fJhXkDxHWhtLVW4l7siCVMPUAHgSrrhuvtGbjk5q
	 B9PyOKZppe7BdlGk5eQAMPkY7dxRCliixsLkQZpSHyLyqx+O6UcfYkxPPcBX4ZK+12Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KofXG14LZqiIaN7Gz529bQzE3SyVd3GZw16KGMgu6cY=;
	b=4zFfdJva30Mt2jlxRolvfoErwvk5NsNgjRxzYiEfM2jkmpcfYKjjS+/tleObdXa0iGKK
	 LSF46fAefkt5AuXXPJjT9lNHxLcZg1jwlXqhjpTNCQOG79aTkeQ/6kWPeaspbeFV7EGY+
	 cTL9tYQKZJfK2admSgll+fbsJdUq0M7HEwGm0CtdLMx14i8K32NsGku0Cd7O2OWc09tuI
	 nE0oKxyEgb6eBnn3VBZz3SOpelULpMtUaNVl5InjbfnHLRJ/sJaWdhok/pU+YZe9T9Vkr
	 0XEmvFwN+YHejaGslYa1zBE9iiyfAqwBqJqbYIjMqV2LS/rnfYzpqrktntobB/LhdlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fICNl4ip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4C606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fICNl4ip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B970E1F000C2;
	Thu, 22 Oct 2026 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678672;
	bh=KofXG14LZqiIaN7Gz529bQzE3SyVd3GZw16KGMgu6cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fICNl4ipzb/oqhj9/QcZc8bBQ32yheHE/Eqd3EocRjpCKC6ifFbAGGwV6HvFmbJsh
	 J2dN/Kk5Hvu8x4DVkrDouhSIhiZQZjzjhf6zVF7KPtEBX/tW1WxmFk/aAEvHGs0FXU
	 Ql4hYoS9hxMJlAHv/zQXesftv6p4pv7CWe8V2L0AAqQ42JIyIbFKLSoKgnyuV7H+Ne
	 GTmfz9y1+u78Qfru1tMCIGl61Q5fkOEPP6tfA1QzLv/ZzpSY2G7hL9sjlVTpni5dMb
	 YIg/VNdEC0GvgRewIIrqwypWpvQlFmxuPm/1RiTPwx9LY67S3bQXCwrHT6L7pfH0Cf
	 ffgt9USW1XNiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 10:17:48 -0400
Message-ID: <20261022141718.1585988-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022141718.1585988-1-sashal@kernel.org>
References: <2026102123-crushable-fragrance-1b92@gregkh>
 <20261022141718.1585988-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a3b0a8fa428a8..1c4dff1031a0e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3060,7 +3060,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

