Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239937EFE9
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364106; cv=none; b=rPoa9hnricFYUySkwAuRqhTMWEc6cRpl1bFYnNYeIWof9OH2/w8CUPCM/coGwCyQVqDtY55UVHPD9d3Hqn2pzoYOrPcTtGtAZbXnDu+DvWZYEafootI5BtPB9v5070PwewojTks3bVFWPTzQ6RrEY/Mp2D3ThCp2j31xe8nRLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364106; c=relaxed/simple;
	bh=EAtL5GAvLO8guoNp4qcczPosAY9+l1BK3hnEZ/prkhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDit43nSSrjWzBbvPDhV86x59MaDyzNcG59Du1cUNDlD/TIzvwTMV/pM9S+gNqJYtW9osWCrWM4dB8uJ76lar5DPSgxp2I5rV9u8AET8JpBtRBPyVFisBKsrQhX+/BQI8ZksmGTWAnjirJnBpQOLV5R6vmjx7Wvt0j36+R1eW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epWv7lNc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epWv7lNc"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so2210447a12.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364104; x=1789968904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQV2Lz18105+vTwI6s9YIFFfIpvfqowDaG0Sxm6VeMM=;
        b=epWv7lNcRNhOybE1X9TtUWaxee+0/HdIVUJ0N87AZVqMN6D5eKHVKtMWcPEWTLB/6n
         Db2HRmDQ4zjCEIz1hxZFw4OjoDrWKQ5Rm64DMwGdkXISZzg01kk81lkzvY6fDMj5EdDr
         61Zh0SOVPOaacNsP/Fj2HaNPYAcEKRxLrtLdqK2wbh+KrbEEvqV64sbZ/mX0PHwwrHgZ
         k1wzwWwX9YtuTHG500JK56NbrayCGpm/eXk7YV2z06eo1L5O2YyNMoOq2DfToZVCStrK
         FMa8rDyZ+imuJ75qUfGIkzvD6dQBVMaSD1CiK4NU6JfecxZ6uPR+4pWNKwKkPTlQWtNh
         RLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364104; x=1789968904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQV2Lz18105+vTwI6s9YIFFfIpvfqowDaG0Sxm6VeMM=;
        b=TWUzqK/coYDLl9M/AIbMz8xahYF9jbT4gz5M2JA0gMxe3UjxHcLISakhgXlYzSDXcG
         srNa1A9RWay9s2G6TZaLg4UbeTVLeIxSuKS9lep+yUw6DNDr6OQjZpSm9A5VLssJMBd8
         bNRZNPmMSE3nUosCECzI5HzrQagxj/vWgzGz8CtawwLlGmlo1MbhhTHWNulUquaqIFud
         75SKcESfTUuSi6WHmrjz5RjTbyEYXbNjE5lHhgySaQpW2l+tGCPeJz3Ft78NobKplbX5
         0/Ff5/Vk5wyYPKcDcyoXagjD4tImwjKx0NMOqTo/Fjji4R4VXzxTgxlelwxAzEHY3tvs
         yepQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL4rYMZszZTlx8Mjnouc+SYb+a7y7eAP+AksNpICn2nLbo/qQmdfrRRIOcB1Tab0EUmLTtqac=@vger.kernel.org
X-Gm-Message-State: AFuF++kXG1O8i2ed8AjBrIA5SXBC7sj/zupNqGNEmFhrIpPf7TAS2EL5
	e2oWfFWVnDyJ26JTru/y1ziYMu9q0X0BiQGMVp332BJ/cO82AKxBzvs=
X-Gm-Gg: AYBFou2wZCy9tyVfkkv8lYOg4OJCe2M9n+bo+pSNL7KdaUVS/gDZ6/iwneUIKkhViLI
	joI9VkGOT3MCB8WtIj/3S2NMV7OMEUXFo0qqU+vwlGkztyS9i7fjUnEr9BHvQvgb1YAc9HOpnFQ
	0sFrEChWzlPwyzfOzKyPe8ULTm7hKIDxSCGMYnmuOdYNZwpAM/nI0tdj25sCyDTAcK4Lzr7pLaG
	RwjrHwl/Wr3JzJ+dTqoKw2N3VpZwT9LSc1LYXGEMxkz5KGaELqgJUw/r8KUbWXnEOIv++9Kg1QP
	7RGzI3LahIsIw0fFgdLlFahGGOnKBWqvPvfA33ntBlAt/ngDPCiQMhZxck0lKQRGivHYrAfZWT8
	vwtDq4y5O1/ZO3QzHNxkgRLjDBYC8zIw5jUTCIdFIm9GiX44fQF16qYNxzAzlLNYpeHJXzC6ZnA
	2mC9VnIm9gpopBsUH7QhqIwkcEEJt+obsE2TjJiU5dVm1kcuhW+lhyk1snv/FeAoywlX48Ndmso
	rZKP+hKb4ciV6HCRRxbgR8UcBs=
X-Received: by 2002:a17:90b:4c41:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39dec05d384mr2377298a91.15.1789364104244;
        Sun, 13 Sep 2026 22:35:04 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm19009261a91.8.2026.09.13.22.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:35:03 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Mon, 14 Sep 2026 14:34:43 +0900
Message-ID: <20260914053443.981201-5-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
References: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdd097abb0d6..11d4cf2544ac 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3093,7 +3093,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

