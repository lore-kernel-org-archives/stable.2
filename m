Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696781;
	b=fWvZFxsXclyawz2Rx3KoSCciUDuo03F0po9rRYPE7cjrYj1qY0EdCSTdAO0TdYgLxt+D
	 N6xdbBJ10nloJSUtgtwIk6nhCuJqfm4V71l2egdf/+COTyjN17+AQ1EApt6tnSpqT2Rx2
	 Fdafl2tfAb6r3KEWmLonhZay5xRbpPCnVtwwfYq+rWU/HDlHz87x4tzTvH2PYXfP/atls
	 YjkR5THpQ35blDkik9oa0mztqiZJJHOxE9pwGEjtkQqI1RLiibB6b1bzjO6b2yU10xviu
	 XqOJJ87Ws3znDjsOivYC5JlZ9YuwQ0RGdONwtxJXsL6fpUb2xZmadww/o1VmWuVTh7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696781;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sK4GHNL9gmDBjz2ViVdNiPFt2ia0Pe8XcstqG/tyicU=;
	b=a9nmd5NsklRyifsIJVO5c37YrRJmoNBUleFv3HGoC0XEXqcLMdbccgpcuF/Ls7CwFrP8
	 MoCisD1Z+YkfMQE3RTBhpH88/HYuwMLqwZYvZ8HvVSlz/jpwCjVUZqDUKo3XHocOQNZW3
	 5n7uhfbEDiRw88bPO2CI8FHjSlONEpq1niWWz/TeBfMG+nMQ/CZpWAOeeFoq7ybK1rI44
	 5OnwD8mTXUppWgesggmsY8hUiMcdUiLHF8CHpbC87rc8Nq/TBZfkAjhD09+jjd2b5ysQ8
	 6Tn6PQJe2z4uumYiAejJCHF7MnyQcGhsaMM8SexAW6VkGUUSH70ZWTzAfREWGjr0/oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sd2hl5d6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2D606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sd2hl5d6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CB81F01825;
	Thu, 22 Oct 2026 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696781;
	bh=sK4GHNL9gmDBjz2ViVdNiPFt2ia0Pe8XcstqG/tyicU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sd2hl5d6/nrKZ+TJDIH8t3nXkheSRHiOD6ELV1zoeIM58sD5gHzVhvVpv52NSVRps
	 CYrFPzLkRu/6xYorY9cmwdlyW88dYMzDLk2TqoucJEAh5gG+Tz1pNWQoLfNqKRcgqy
	 TO9/zGzQPqyIXarZxETV9gjwmDG8Ojhlw/gbQ1yrq1PYK7ZFMt6EoUKHFcFNf8saVy
	 iDZJXhffAlVTv3PP//OSA4hvpSvqW7oLPiaJ5j15wpatIB9w5riKur2wZKwgYPrQF2
	 6ZlOj8FxRNA1Ouzls54DR+K+qC6t9mA2TxflBjOZdmwlDgQZdkj0tWoTu94PIxqhK8
	 wI4/PpzsuZ4rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 15:19:38 -0400
Message-ID: <20261022190948.1767308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102127-agreeable-wisplike-bc63@gregkh>
References: <2026102127-agreeable-wisplike-bc63@gregkh>
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
[ sashal: adapted expr_field_str() to use the cmd string buffer instead of a seq_buf ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5659009450caf..187b59350ee1f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2527,7 +2527,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			strcat(cmd, ",");
-		strcat(cmd, key_field->field->name);
+		expr_field_str(key_field, cmd);
 		first = false;
 	}
 
-- 
2.53.0

