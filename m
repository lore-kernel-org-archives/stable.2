Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673700;
	b=LCIY7zSd2rR2m9JS//XiJNMQv0cBnbF0S4u6d7buQ+rgdso0eU8eUY14S5ATtvI6+OlL
	 GP3WlWfrNQ6oAzWCuMzxCGm58NeLyhml4JluFel7H9iFGFnD5ozmTptWQobxyz4YmLBu+
	 9hIjgzbWpY4b38UDEcFVWBi7wOfoQOpiiUawA+y5VtlNR6XB8fR8kOS7UHUiPvsvB27ZE
	 fd1Ye3TJ47B+QZm+tcgjFnB0iJGsYZUBOj46n7feHKY7dxNxZ82gj0pQK8OwfZckAbSG/
	 nm0v5BOl+guPe+fWmrycsXGWPDqolhALS+zJDuYEPoTVGJ2uxwvEoEEmgmVsSHXAdRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ut596dSYDA9muKlngf95bMEANj8c9d53sp5+5NOhEJk=;
	b=maDULup1aZ6/uo+D6Ar8ZT75wOeO5t9TT+kQFz5utQVGTw44m60Z8UhFk4yXFKG8Y3O+
	 svRaneRRvigNiVasdi26zd/uTwa+DDB2Y83x5Z/zsB08ZSp/QaLHKYAqkQOtleZVigm7U
	 kUodAol/k7inzD3zbBK57VKsD3kNiTEDA2ILRG5oFXivqnAVo6YpK2RoYkhPh3jetoDQJ
	 4RdgsXUhdiNxlDkEtuwAeA6ykUwXRe3rw+RqmsRL0mVfRT96xRLbXd9fV8EfVFhCt7T72
	 +vh+cR+7xQ6ZQDuYykZLXplUxOXNW8PV/tpqMVBObDmvUY86BirezYPjhGWcu1p1EzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFj3uWnG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9B606A323
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFj3uWnG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0B01F000C1;
	Thu, 22 Oct 2026 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673699;
	bh=ut596dSYDA9muKlngf95bMEANj8c9d53sp5+5NOhEJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFj3uWnGvN211ipES/YXsjnTdTPT7CWdqMof+SAHAvKdXhgtQAZuYGj6r2kuuk7NR
	 UV2lk4ImjksqChlZpI+x5brNGpQzULl5AKyGxMZb0IeEwZdaCZWgn8nVCiQO59I/0n
	 SYW2jOWrxHW+DIslEuQmOKtq3xExWAp2o8O8uudZzQljQRw8LNAcqoQ3vl2ILguZ5/
	 ttny9PMJP44M0pPQFWaNfIG+ZHZFIa4rh7BzN2835QQ/Zmt89Wc6BizERMd1fl+kHg
	 1cnUlwnlrQZGB3/sT0Ud6kPirw2bEzHAFxzMpVGx1ooyc6sqV5OKofZEk1s0x7wx1Y
	 04DbUTPRF9gZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/3] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 08:54:56 -0400
Message-ID: <20261022125436.1346436-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022125436.1346436-1-sashal@kernel.org>
References: <2026102121-bronchial-ozone-0317@gregkh>
 <20261022125436.1346436-1-sashal@kernel.org>
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
index 8caeb6bfb7d5e..2295ca7bccefd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3078,7 +3078,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

