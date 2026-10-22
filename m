Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678146;
	b=rTstl5jF5vWeRyY4EUDwswPEs8sKRGueQuKh/yK4/dvANtHV16Emb04Zv8vuBDUiS3pz
	 hZ9Z7WxVO4pcpJP6V/XO09kRAcl0uKF8wLbzx/1xmuGZGnHPFDmdXTY5JNC5chfq6kjui
	 voFL6T2a1U7MW0Lg++qtaC7r7/SCpnDzosfIR73BvpCMeY3cs9VM0mR+0PXEZoEfJoABx
	 OU4v8dxEJm5C3BB/5rPKcerJ3ADHKoG9HyolI3Eor1Iy9BnboQhYSONGB3F2/2YJ0Xba+
	 waTParYscD8iJb3BixMtpHVGXeNxer62xzV7lTJeRdasggwlQxGYE1LhKP92JhrnBVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aQs6I7ecl8kONrNGvwpS+WNzHfc4oeZkcTe0xW7iEn0=;
	b=p3Bm0/wWDGR3xijh1vbrYUIxxt8Ja9+fx+rwtIur/qy8Kl9g3LrW1dNxs7OrZ8H5P45T
	 fGWa4Rpu6V0W82mgZqAM9vSsMXCWMnq9mEwYExtR+HCowCGlQEkusjY7Jh5tGGS60300P
	 9OgjsX3O144OfJWPh6q6/RcN3AsmYS1xAdQd7jHOolF1xi9Epy24uhiP42tffr8k+lx3V
	 Gl0PMIfOojXtWIJryPmGfEh59/ifFMZ343954L+Kozpo7WqTrfIyIL574KbAQtye8WAET
	 MZt3v1/Sp+nf3Vrat+dINobaOvYSLsix9/ADQmdpQjqoG76wNKw9JSe1kd1yk/8I4qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P2m/JtWe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6F606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2m/JtWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDB21F000C3;
	Thu, 22 Oct 2026 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678145;
	bh=aQs6I7ecl8kONrNGvwpS+WNzHfc4oeZkcTe0xW7iEn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2m/JtWes6T9jTDjZob8vFzYiAlRPuzHjjCZzd3Z7lDIH1MmPqSkoKlbDgHnTb5JE
	 Dww0kRdRE8g+UzxZTq9jfRLjg0Qu71TI7BjjQtkncNLcSXXrDLcECXMLXzKT1SUKvH
	 I3lAde7TaJRTBNSeM51/x7tAW/Ps10xnvDwqJnSzj6fND5gpYa49sSetukQc85V1ke
	 94xRypMF9O0Bl3onKN2pKrEadmivdzC+B3fAKcGNuGmhLxPRp6u2CMrUIMWiZzVvyI
	 Ti1c632necPwMVMVfNLwgGYeVpPXoZheRRruxXWdo1EzSY2WfE0YgGxMVr1MMFrOOm
	 0B3k3JWvSaETA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Thu, 22 Oct 2026 10:09:01 -0400
Message-ID: <20261022140848.1513845-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022140848.1513845-1-sashal@kernel.org>
References: <2026102122-sandy-lazy-aa40@gregkh>
 <20261022140848.1513845-1-sashal@kernel.org>
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
index 4f1c8dd3b83c3..8b210fc4746da 100644
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

