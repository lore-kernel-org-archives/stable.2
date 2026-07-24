Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32F37C91E
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875348; cv=none; b=eKFTaXz+SN4TZ1Cj7NP4zErA3SD0cY1skdXIK4GswlEzUnXWwWUdHyV0NVRa9F9AfwRo2R1H7UQ0227nAtyY6E8f/Myfiq6c9wtpL4j1MR3GL3Hhe4aIPz7xoOn1o52nTi+Q4lOByF8CYy10xJWxCwnoXmT8fX+WUyXksMLOQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875348; c=relaxed/simple;
	bh=UYfnAVkJYqrCgRSzVomRRD9UqZf21Lsk6dNux6uNhHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flYInVPZ7hBLbw7v+AyB254jF4vLWxcFixlQWL6vfsYD7JJ5P+UcvUBuiK44OuE+og43+0jdjb6x1VHYraLJTtiHwJ68+8xHgP5tS3abJfL2ABywtD9ixaW0OWr14UnRAKZfd8Z5O0WOA0uylznWO7vKK2VSTFxeFS441u1EZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGESawy5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGESawy5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f236418so49824b3a.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784875346; x=1785480146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3jI/otvSm+1a57vqHZ9bhuvtuCSbIaM8PvVKGIua6t8=;
        b=GGESawy5hAJ+3Xcl6UzYqF2Z52pmqvAQe6obk7kR9j7TDLwBqT4Q2BzyqfxoBG8nVS
         uvP5SM5SRzuPlf1RvT8UJC8poJisgbu8qTqYPIxgQGXq0Vjs+rDrw+bVVFIAActZcUcP
         WB/rS4BhtZmQ+Av21i62/4QZ2ZHLdJ76yV9/HQFVl43BbJ0irRQjkP9/M643Dxcv0Mhc
         PexzvqjSr7LxBvap91qpNw48z8MMhaER8cbjmOAymS5RVdFXhXwERVekWAVzANQgFR8B
         LcNUDMqMW98PJKvKXK0s6eOopqmTMGJmm7LFqX57pG8208Ko9tCmTmhJ7180qJRCBIdC
         sRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784875346; x=1785480146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jI/otvSm+1a57vqHZ9bhuvtuCSbIaM8PvVKGIua6t8=;
        b=P9sw3/6usS2ljiyQL7Ecp51MyH4jOgD4u7DfKDHyPUA12/VADR6Uq+H/PIJwiWSTCd
         +qcprbRHLC+pfHH+Pofi3JgVHgK1+a/xo5unXcOBNlM5XZ4mWa3sf75MDZLIHyrTtA/P
         7uii9H2wD5lGny13vF8L4+F/oUiwOMztg9oJVAEmXW/Xb63bK8gZQtA66ajxhDTwsygg
         uOjsxiBA0z8SqFn4v8qW3G7gXfEzFrbNwq25qlWOCubwk+22jjQMpqZiGpYSDMcZcJxB
         TMEEsy3mZKUvgugeshsJJefcUOrr2oGqpLRaQofrv62i8Agi5ZfBZmeqaCiGzi3PRnwl
         Fr/g==
X-Forwarded-Encrypted: i=1; AHgh+Rp/gqfjEEJ2dWc41Nq6aVY7B10WEb0OGm9MNfrr8MNk/8emkQyLHPfFJ2OPwIM+LhHbz+9kbrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeVfDFd9RnuWmx72rh4awqp+Hzby/yHVRG9gCD/TxXKrFl2D4
	q+zh7N93kMUUSx+9K5bf7zyPGN9rk3fjR8uPcGW72s7hwWiJK2x6NTdr
X-Gm-Gg: AR+sD11CLQNj44AHLp/7vPIrU9eBYJb2hh5kq8CSB0tKGx461H1dvp86OFp2QACjvk3
	8fr37vY4e4qDdBkoLqm4gA+c8LLAsa8RNsgf1EBWWfM8JuuX3l+8XImR/92wXTH/SysD8AGo0o3
	FjYYKkT8BqbluCUBdoXp0NK/GvTYQsr3/K9f7QTgy6MEZxFwaO4j+rXL4IdGQFiw/Gp1JD7fgYJ
	ZsEWaocsHarrfE1RP7uvsHRngC3XBiRU58KWEFSHzLYzfgMawVCP4hWxh3bpo31UeFWvKHeAd/T
	xPqWkW309rzzPTsIjk0Nl/EYklynQiZeP/pUplP891VTrjkKWfoJFpJuxefvhe0n3ul9DHYgPi5
	fvCsqUX1FpnHfrZcA+XaHkLSr8TEVkQByymjRxsP5rKQpaSbQh3qCrI/uKvOti/gWj5l6iQuUch
	IRkqgSmGW39g2CKw==
X-Received: by 2002:a05:6a20:a126:b0:3c2:dcdd:a85a with SMTP id adf61e73a8af0-3c44afcd25emr7057739637.13.1784875346272;
        Thu, 23 Jul 2026 23:42:26 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([1.22.231.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081985sm27783326eec.23.2026.07.23.23.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:42:25 -0700 (PDT)
From: Raushan Patel <raushan.jhon@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raushan Patel <raushan.jhon@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/fprobe: Roll back on enable_trace_fprobe() failure
Date: Fri, 24 Jul 2026 12:12:08 +0530
Message-ID: <20260724064208.480030-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

enable_trace_fprobe() sets the file link or the TP_FLAG_PROFILE flag and
then registers each trace_fprobe in the probe list. If
__register_trace_fprobe() fails partway through, the function returns
immediately without unregistering the trace_fprobes it already registered
or undoing the file link / flag it set, leaving the event half-enabled and
leaking the registered fprobe(s).

enable_trace_kprobe() already handles this with a rollback path. Do the
same for fprobe: on failure, unregister all probes and clear the file link
or profile flag.

Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
---
 kernel/trace/trace_fprobe.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9f5f08c0e7c2..3120403a5b60 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1481,11 +1481,21 @@ static int enable_trace_fprobe(struct trace_event_call *call,
 		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
 			ret = __register_trace_fprobe(tf);
 			if (ret < 0)
-				return ret;
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	/* Failed to enable one of them. Roll back all */
+	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
+		__unregister_trace_fprobe(tf);
+	if (file)
+		trace_probe_remove_file(tp, file);
+	else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	return ret;
 }
 
 /*
-- 
2.53.0

