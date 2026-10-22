Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676567;
	b=0FdJ7JUSPMjR6q5/99ZLly8GofIYoGYP2p5OFaNmb/x5X7nTw4LjUNndOcohH7hT+MAv
	 l3MokJ46hjfUirDkEudh/y4OiHveG72NfV+VSsdcsig9ohoMC3YWlpZBzrKdjxcVSowV/
	 Ag8HGT+aU8CPjnCH/r4EKkSdmHm9faNwxkdNTpJzp2vC0GZ6oFZvb1n+18Z+z0d0lAfhL
	 HaraOke6fs52XvZqLJ1MabvIWfes9DIwwhNxP6M/JxMvhWU7yddLaxyeK19jplINL1RFm
	 EjZS6SGkkmFxoA/NVxQV46bXQk3WM7AENEfxG+m5qOc0/DpZu4DhYFVdsKoZCmS0zUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s4AuCrYsn4dS2nLKpVvR0o43olVmPhMRKwWCMlr93FY=;
	b=mrUnDtBJlSbU2jNRfwsHryKh6Hil4K+FDMkZbGWCvvWBycqxKVsA4xu2Ajdu/+6wzchz
	 x5ybZ3jILTaTDCnwq7061sPEvxXnm1hZ4e5sYIairacx7hQBm0xKMNc8Ipb5an5r1eTuq
	 Mx39Rgz70X4hXTZh5wD2RHaGUm5ucEFTKRZRrKCJOh/jg+yGWKt4ug+CIhnN2GkAFEERR
	 Ub1M4IZL4bxuhWEBMpovZBmJK3l3CKLxLcUvQr+mTIXa1HuwUGnSdIeZbdSymMlpEEWiU
	 DGhIlLLdiFsi3Ob0U/76ExilsDQGqm1cSKXPJPgf19YE5iZDC4wkCycYINVKd6h7F/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxbRc9k3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F460A3803
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxbRc9k3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773861F000C3;
	Thu, 22 Oct 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676567;
	bh=s4AuCrYsn4dS2nLKpVvR0o43olVmPhMRKwWCMlr93FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxbRc9k3HUL3lTMaa5NWXt15ynEQ0jMHR7pVZVs/o+2254/iYkKL/qGhyF5Qdii83
	 WUDZpOdJWsb4iUl0S9YlCSe4isqgDVse4mBMhQQN//S/J1yS62wVo2j2h4zrzpAnH6
	 uuGbwKnO43VA4j8+YRzB7P/Nyd0uPscAKWNVS39cc7YjSByLRBnZqWF6GtV7VifI/r
	 4QHaVwa20f/dlRXw0dKFFjs7nleLF9+Ze3nHGc4+KKzX3JJwG3NUu5fPDUFr+mOCEH
	 j78YwfUkDcRe5X4Bl0+TY63mSEW/03FteIPqJI8aES+VNVGwQN2vpAjwMwTbUbUVDA
	 qKD9JnKUfZMjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 09:42:42 -0400
Message-ID: <20261022134230.1444063-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022134230.1444063-1-sashal@kernel.org>
References: <2026102122-spinster-handler-2d56@gregkh>
 <20261022134230.1444063-1-sashal@kernel.org>
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
index 6e9400c62cd01..200373e19e383 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3081,7 +3081,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

