Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846526159E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331507; cv=none; b=ru+Oo6wIMvlEGnwrEZFcyjp+r8JI/l2JV0g4qZKqIDxHw5btO+nOZKb+6R9/PaypnGI7abKRlzD6UCBgFxr0MAX2uBtgGt6sJ54EZLWy9k26So330vh+TItr7uSpCT/oTgWeC2vtXyUEgrI91LfITZju1n2D8y0AqDzVBklZm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331507; c=relaxed/simple;
	bh=ZxKFKkRM8oXFOFl97A/fFfxND2n+rPDeZs/wlH5nD1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cid7HTj824iHhpga+b6+ifNncIquWBQQeOdXisI9UPWeDdPL2vZzI6ph38MJlM8hydb++ly8KkUuxpznPil2WiZHJaBvoWIkP0sqUv+RCuRnr1MYSyZ6gIi3dlwzWXbSQhd8fCNWxIcg11OVbVOcdnFwyYpDoGt6tfNNO1WySFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7JWDkOt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7JWDkOt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso972562a91.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331505; x=1789936305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jASMuUqBprwXkBkHSWhbe8r2/E5/xJ7OJmCuBUolA=;
        b=a7JWDkOt+9MeYruo4fRFTgsm6zQ88d8VrKV3jMuHYErofOEDhMrbzM8eFlwrZS5DPf
         k+Dcl5h3zP1i9gptSWPjNBLOUJE9uxZSJ5RYDv24OU993pAx8lmJpq6YWxuUscniOVjb
         ExwGraszTG9uUbdKUrfB4HpPYQOMd1V57hhWINpFZ3VFolsI/MjdS8JGpochhEZAYgyh
         fBH+oLVuUiICxpRSpijY3zMUxSY/l1r9aCxefFGIO6oRSzQxxk3JYJzgH3CTZO8C/Xu2
         POH7cKsS4XHsK9akATj1RsveY6lQQYytoBcR6jjS7Pmiyf0wQARmoaoAkT4XTLIu5O1E
         eB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331505; x=1789936305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5jASMuUqBprwXkBkHSWhbe8r2/E5/xJ7OJmCuBUolA=;
        b=dnCNSnYRT5WC5j+ArTkH8QrF+2SKXpayd42f49ecvYqU29Jyf+I6W3CH2cBRgPtvgl
         /q7R/g6Y+DemVsGZ3O+HVwnMG69KD9aTmaoBmINX67F3H4VhLsxmWyvdliVHlpruddY0
         GUzMz8QuwwvNE9Y5V9sur+zegaw3SIfwfRzfE0PiT6KpjF6zN79eItUbByYcVrC84v2i
         8V3DO4a2l5KBUTWEgsuZtMyXPO1FsttiD03X/9OI3eMO2mVbZLw55CYmv+v/oMcggJKa
         bH2XfHoOV88s0eOVxcMLRROS5alkpXHLLt1W6tVdi4C4OeeE7PN8uxh6RjwEm7YrpEfD
         wT0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSQOyrnlt/HFCavGXOj/d3NN4MEP8eT6qSaLHLL01UW0L88W6AmVgFVMK21hzqG7bDF63RkUY=@vger.kernel.org
X-Gm-Message-State: AFuF++lDTEz+/9iXsR0rmU3km3cRzGqXFqrFnkN3Kg3z7H04THLKFbQZ
	aCFX6OvBhWjUadB7snWMz1lqxgAlVpzBqAS8dqOfj/8lG6YqDTScSjQ=
X-Gm-Gg: AYBFou1FjzodNprq1YXJLl8j/PWW3Db85SMbnIYszPpCZ0wvKJZzvXx4mYR1JAUs5M3
	Ivx5ICuq/4AGXqUK+jdoLukajkeNTe+hSwXwrUet9ZbaX/Ahz1pSV/TeLmM9jCCwPGvaeQb/Wv2
	QbBOXQC39+2z/RJCh4JafqS/Z7JPmUTRAKrRfnb8T8J1S8GtvWX3PDvi8GEkeNy5DR5LXxvO9rf
	AylwE0noVA3J58aSJimncAHm4DVpilk5bplFFz7LLVqu2J0jMs1kQz31D5zcYxFvetY5U0ZsJV1
	2El84ROC3h6RjXm8C9ZBfRNvBNlGOM7euPtFfpFEfRi8pg8Pz6pi5IOkposeIqPzrFjACoQXgVm
	Dwe0XvaESb2wIec8Xl0xRb4l+DWOIlVoLK2NuIsVSI3ZrzfXGrtCBN6dlH+uu+uY/WOOtzMloQl
	UDv5uVetwOro4A03KPz+zqSXMXUCb/TMgO6SwrTr3uHa0wODG9j6EXafLO/fwgIbY9Y+ATgwZX4
	wfp7aHf2tH2a5OIu3dui/RkVw==
X-Received: by 2002:a17:90b:5785:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-39de9b6d48bmr415809a91.7.1789331505011;
        Sun, 13 Sep 2026 13:31:45 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm17530220a91.0.2026.09.13.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:31:44 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] tracing: Fix NULL dereference when copying keys for a field variable
Date: Mon, 14 Sep 2026 05:31:29 +0900
Message-ID: <20260913203129.941270-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
References: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
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

A .buckets key needs the previous patch to render, so apply that first.

Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9d7ce01fda36..b43b83d7c6f3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3097,7 +3097,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

