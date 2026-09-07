Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F9501F45
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796257; cv=none; b=tHr2VU5HTboQ1/yIlzZM0MapjNk736xWG8oSWazaAIW2s3ayxCE3N64n44FKKMioi6SZn0gKAvhUDotnYo9jSq075465lPV8RF0J6VJ3nRynyc2OUvxSueW0jiudwXnh08T6ZFkGEYsPdob2GMy3fEeZAfC8ZiSLqpHEak4YpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796257; c=relaxed/simple;
	bh=/wFHNVYGcrOSVECo7JtvUSY2wUEfxq3JHU1raIZ47b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rduF3iWyovDonqxV1S8vJ4Lqk5l2vOukYjs9clrxCuSYaUnMtaXFsrGtbRXHGaYlZGV1h/AVf2MMNJyUgxB4a96XC29inYGITq0Z1f9MAP93DKARsG0m1lybt4Bk++qqfLukgvmT9VcNid7ncGg8wqjX8/gvST+pi0BiWMkx9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgVH/cjq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgVH/cjq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db710396ffso1885795ad.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788796255; x=1789401055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8T4KrmsHv5t9brNBOkcCKbXSGpHZ29F5DJQ1O40Or0=;
        b=fgVH/cjqTpWUoVI5intCy8fVhj3GzZqKqnitSB4Yjqt/sd30XBLZqj6na2Ir+7MmQ2
         BLbw7v9ZjoGfsgHqqNdmQVQcseUKPoZyADhHdxghlYF063oDf6OZczGKWhQhkybAxJ02
         iy/DIaIUk+3pWIXV2JpZVuSUDuxwaC05bgRN2gIj+9eeMS1yfL75eV6wEm88uYslEyfj
         6a7lCsafpRHwqeYwV82QtWP9Qu6lA+tBGgIGAuMARYz84TM79CCxYL+8OEDhaRgRAbAk
         DW9X2YhdkzdYjuBbkEgHHs/NVbnFoeIeuJhNhFM0T/mJlGUXXZ8gW0S9s1rSR7KgGBSi
         dp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796255; x=1789401055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W8T4KrmsHv5t9brNBOkcCKbXSGpHZ29F5DJQ1O40Or0=;
        b=pUIIF1+ZKNYMwGZVA1drIEpXJpRFDUlI6gBfWn3Owk4TsupfkvCJwiDIroBjxe2ll6
         WqhHSW8Bb+dag/NjfpAMeGFm92o28HaJVIn73Qk0+Q9GezZPHxAq+10M0PjXsfksZ/7z
         xy4Bh4fbq+rQ4rCIm179W9MifhqsjXPkhpd9PUHISFdHYgW4aizfnMb+DZCLj/6QqyY7
         vdYq0HiZRIfnT7fwZHNTFz1/Swya0xlw8a2+U+5cqrP7yt+GhIFPnds6DF66tdGTvH6m
         up+vSymnJgVJ3vaJp7RMkEjKy7wEGekoAke56c1ha6hqhGcIQa1ms+cG7SUKpCCaTknj
         TVig==
X-Forwarded-Encrypted: i=1; AKwUvByt79ycjINPewKwZgqKFrwZeEGJsgbh2D74wF99Liwjh9LGeWEC55ZYUti8EJkqtPzsiRp7etY=@vger.kernel.org
X-Gm-Message-State: AFuF++nEJf+h4uZJ912BaJWg0WsAxogCoPgPbtdTddOZFQkkLYzVDksZ
	LvBgxLI+qAsAcdrO6iqhfN2igta0uz3MYZq8hhL2yWmOU3Ew22GGvPw=
X-Gm-Gg: AYBFou0LozHM+X4cBBg4xcnhdhYuFed0C9NdkDY5mU2mXTiCXHeFJ41TS0mhpqFx9vy
	/U4jR9FDhaDw9iUv2coQRUs9i6QlDVVO6gbzTqGfZ8Ddrtl9LU+5cuaPltENnTla+Xd7TvlmPEu
	B+RNd7V8ezi1raQDy3zGfs0phX/bx4Jb7ANtyjYW/ujJ7dz10fLsvwQAIwN2D9fC1iUgK06oQQ/
	dEW4yZZpG03gXZQ/LHpRRVvUQnEFNiQUTYtpabGOWKWFXiE4ra3bmKK6p3gQzjKmNeV5J/chHom
	o9XvdpW91i8ye2lq3BnNcOVgFR51012BMZoNy0Yk+i50bNisvc5qU4sQKfaxjQyTbEKXI3wZKZ0
	M5O6FY1mTGPHmqwl0+ZAfn7Bh4TpwxhVLq6dP0A/zSDU9HDqJLfiwzpqz/nC5QO4q2WUxSI42hg
	CvgH9qW4+hYTkRI31/gwba3xqwAnaQFnDh/A1jsyy0Sy7JqLEBBRO6Ht9RCjVQFzZaLOG01LNXF
	5gGt5w/rrpH3yKX
X-Received: by 2002:a17:903:2ac6:b0:2d7:1858:1d96 with SMTP id d9443c01a7336-2dafaf5f50dmr277579735ad.7.1788796255098;
        Mon, 07 Sep 2026 08:50:55 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm47265405ad.63.2026.09.07.08.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:50:54 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] tracing: Fix memory corruption from the stacktrace modifier
Date: Tue,  8 Sep 2026 00:50:44 +0900
Message-ID: <20260907155045.692664-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
References: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_field() sets HIST_FIELD_FL_STACKTRACE from the ".stacktrace"
modifier before it looks the field name up, and nothing afterwards
checks that the name resolved to a field which holds a stacktrace.
create_hist_field() picks HIST_FIELD_FN_STACK on the strength of the
field pointer alone, which reads a __data_loc word from the record and
follows its low 16 bits as an offset into the same record.
event_hist_trigger() takes the first word there as an entry count and
copies that many longs into a 31 entry array:

	n_entries = *stack;
	memcpy(entries, ++stack, n_entries * sizeof(unsigned long));

Neither end of that copy is bounded, and the count is whatever the event
holds at the offset, so any field will do:

  # cd /sys/kernel/tracing/events/sched/sched_process_fork
  # echo 'hist:keys=parent_pid.stacktrace' > trigger
  # (true)

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:rb_insert_color+0x18/0x130
   timerqueue_linked_add+0x7e/0xd0
   enqueue_hrtimer+0x39/0xb0
   __hrtimer_run_queues+0x10f/0x1f0
   </IRQ>
  RIP: 0010:memcpy+0xc/0x30
   event_hist_trigger+0x165/0x690

The timer interrupt landed on the rbtree the copy had already run over.
No debug options are needed for this; KASAN reports the same write as an
out-of-bounds read of 13835058055416381440 bytes.

Documentation/trace/histogram.rst already states the rule, "must be a
long[] type", so enforce it once the name has been resolved. Names which
resolve to no field at all, "hitcount.stacktrace" and the common_*
pseudo-fields, are refused for the same reason: they hold no stacktrace
to read.

Fixes: cc5fc8bfc961 ("tracing/histogram: Add stacktrace type")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
This rejects triggers that used to be accepted. None of them could
produce a usable histogram, the key was either whatever the memcpy()
left behind or an unrelated value, so I took an error over silently
reading the current stack instead.

 kernel/trace/trace_events_hist.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..620a74fc62e4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2330,6 +2330,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	struct ftrace_event_field *field = NULL;
 	char *field_name, *modifier, *str;
 	struct trace_array *tr = file->tr;
+	bool stack_modifier = false;
 
 	modifier = str = kstrdup(field_str, GFP_KERNEL);
 	if (!modifier)
@@ -2352,9 +2353,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			*flags |= HIST_FIELD_FL_EXECNAME;
 		else if (strcmp(modifier, "syscall") == 0)
 			*flags |= HIST_FIELD_FL_SYSCALL;
-		else if (strcmp(modifier, "stacktrace") == 0)
+		else if (strcmp(modifier, "stacktrace") == 0) {
 			*flags |= HIST_FIELD_FL_STACKTRACE;
-		else if (strcmp(modifier, "log2") == 0)
+			stack_modifier = true;
+		} else if (strcmp(modifier, "log2") == 0)
 			*flags |= HIST_FIELD_FL_LOG2;
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
@@ -2425,6 +2427,12 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			}
 		}
 	}
+
+	if (stack_modifier &&
+	    (!field || field->filter_type != FILTER_STACKTRACE)) {
+		hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+		field = ERR_PTR(-EINVAL);
+	}
  out:
 	kfree(str);
 
-- 
2.53.0

