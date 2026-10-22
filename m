Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680822;
	b=tgIjXSkPVLfANMXbM2j79z7LNWwHD0PaeGQcBOjEWFxk93J4XmgJSVXKGKKBwSCe7mOT
	 zE/Y+mdLPmac2H1EC8dd6Wr1fYZvBTkr8J+WAwSrWmwnf9zYiXi9NvqdiRuX7UyGKt5EJ
	 +mZYKCMstExJ6haCTvHve6ayDUYDtCRi91dgbE0Q2FYX6dvnSfAIwNrBz7SFgXHI1Gdq1
	 CybdwPI6DOPD89i5ITLgLTSIrc8EUTkB4PW6Zk5Nypj21zrIgHXN7fJoPZaFPQI9MX3Ss
	 tIRbebXcQ/yHcBe6OpjHrd+75iZ29d25ewjDlj64EfYRTJ3dOpGnnZdA2+dsMC3mGvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mJY7akWAoupUA6VSo7V4mxucq+RAYNM6RphG/mYT//M=;
	b=Lfq2DOK9dnShDsdbBw8RU8tbSkIU/KgE+Ae6ptSGiuLYeBvNHrbkf/igMMB+U97scu4N
	 lBqwueKfRiL5gRKsr1BwmpgmUd66mag8zv/uBV11RMn3339H1Fr6rmGZHkkbAfcSTaqfL
	 0qPV+uBvFx7ur5RClPgVwC7G10yIHSODb8ywMS+G/7sGil32b+8esdQu/g4q8Rfi2C54O
	 nhzkIWrRnx59NI34ds0ACks/OWMu42JMdAk0tFdHIN1AQ4rwMVctQgGgojhRqHpK7hA+P
	 IriZD2LPyg0NrLeXQ3RBMpdehV+kCgRjjkTFSF9sOBZ7Wj02ijFjJCoSz9L1Y2U/f9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QGx/W0lk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB16606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGx/W0lk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87661F000C2;
	Thu, 22 Oct 2026 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680821;
	bh=mJY7akWAoupUA6VSo7V4mxucq+RAYNM6RphG/mYT//M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGx/W0lktu+IY2QShPxtDUWX2Fs9gpog7pnR6LiNQHqZ84ZveMHQClfD3FaHJ7Lhe
	 ENZg/B/VS2siKAZz4z8fD++aaJeqa730BC5aPmyXZ0kB3sLDhofv0/M6MvXUiPU9gO
	 nb2Ai6DceiY30oFlnb5s5AAN+w8abm86SdNpOxQmf+WyTsoq9Zy2P+sSQryleTV6G5
	 34x0nhVqO5+Uj51k+mF3JgFVH76ugcW+T3AzAIWU/aZllZgBKVI7SxwUO8G1gKOozl
	 VdgcoSS9RR+buaMwpY1D5SK6stjAz/pYNY9LT1939xOUmih4qh+ZDcdz3vQ+jYk1Ll
	 x2wYjXND6BxhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 10:53:37 -0400
Message-ID: <20261022145315.1599452-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022145315.1599452-1-sashal@kernel.org>
References: <2026102123-faceplate-shallow-02a0@gregkh>
 <20261022145315.1599452-1-sashal@kernel.org>
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
index 18e3503bdc79b..002c298602fde 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3009,7 +3009,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

