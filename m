Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480666;
	b=htSt1FJBZNWgVT883vsCycdR6RduJOaK/c2rS7hYoJMWxxpZTxV++oZ/QvoydNy3qmVW
	 xT7UahULiqeZTEZqFsgD9jKx5n1GuQGnaHogksxX+I5obzVDtgqtNmuu6UD1avvL68CHr
	 ud2o+YnkI9Z0Z0KDvysW2yffxd2dcst/ZvmNKwkNijwMelhUMq38HWFkticyMwjc925eA
	 D0nDUbtOAYk01bc0OCItAljMRIwumlxJ7yB5f5oc8UrjvA6EtKmRiFU59ZLzP/nKCJDi4
	 i8J1EMae6i0iUFLroDhHUVewpd7/XtJeaKdrJgawW/hebrzFDajmkaXvTAC/9AxtDkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4szFGphMtUoKYDwEO3ILc85/4qEVkI9CTfJtlLVXdJ8=;
	b=NQ/RuxkvtlkHDiYV3BTAM4gg1pqQ2JGFKu3fGxu5Ma163ManXKNZsDLIIy9jAMTMUNDO
	 ruIDXBJArXTTpqGBMEVyGhYsNvkVuYRJRTz28oUXgZlYhfd8OdcCz8Z4wCdMc0Lfl7FD0
	 Mg49oEl/NzpIGR+Rznz+RNxl9FvS1Nf7ZvUDm9TFsK7qswdYlunHMW/+/mI9iwbKZwvCY
	 lshhTbH4Q8ta8AMsGLiarv/Z7d0WfTXYFhB2+pG0O+JrF0nme/vsni5lzIImlvExQlbix
	 ZlWDcUqSKr+3LWh5Gr6mWVXoXd+yJViXwhiJe4YM8ANWWdeWcvReTKbboqobPi3IoiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zv+gfP3h;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D22606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 21:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zv+gfP3h
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so1299035e9.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793480665; x=1794085465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4szFGphMtUoKYDwEO3ILc85/4qEVkI9CTfJtlLVXdJ8=;
        b=Zv+gfP3h0dCGmKQSZJgc9BXKNly7hCWlQkiAVteubsCa1u8VJ8/1FknfrfEcBt+UkT
         mOnyh6DWoAmpnQqC81pg58KWwTDOT9GxDj1gRLyayrMmXzDhpHmc9aIQT0Ulc3qv9X9x
         IePk9f+V2iIgPxdC/nJEzxDizOpW4wiwUb2U/RNLyQtG9VtPjEQqmA23Sj6PQPmexqMW
         anVZDFm1hcJSP8zcwfreAaYqg3gklAghiV2RgGjgEumSkmteloWLAJCDnAPnUejHy6xp
         RUlG7Y5Y1YMBYmWPwNz/xMwU7JeVpsvK5YtHqiudSHqfmKGFrt7CfHw3qhBD5xQc80i3
         or0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793480665; x=1794085465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4szFGphMtUoKYDwEO3ILc85/4qEVkI9CTfJtlLVXdJ8=;
        b=Y8+MQ6Uz+L8VOnBhrbUlAPQj1uVwCpz4HuFIfjvYmmRhO5NQII1WX7e721Z7bwFb8q
         wW9MozjFk5l1WvUo0JF2dGZ9P9Kgqizp2eNqZDJf/rUhqNFviL/dr3Y2kw/khZhLsvAh
         J6Et/cxvHG/ufnIrcq43h3kj50MZx9zXuXMsKX10LG5mWonO1E7SWUA5Y1FPSBF+WqGg
         Y8qfk1gur2G8uuvlX4oMrg4kzOFPQgQsIKBmdaK+cwyY0HnTEVXT+5uF1aRxgYVZ14kJ
         RjRaR4DcCcteaaFbkPXCk4FAhWNnds9u7LBQ5g1Ao57VyX20kDWLRVrgp4r+8nfRFo+h
         6xoQ==
X-Forwarded-Encrypted: i=1; AKwUvBymeQUQA+mvhbc/ARSAiu1XfLpimNYsj1GblnWoJ9LfgRGRGhCMF2tHTjiWx/Ghz7iFCgdEQ54=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzjT0WZtDhMs2P8IL5wKRApjK0s/YfDP0DNF1uBY++89ecHaoV
	nQWrPRHl643o4IWgAWceHDgdM9eakysQNODzvtHuOKZCtm1xFdWRVsZg
X-Gm-Gg: AYBFou1lCLgkSeNhMN4bCRsDg+p/xnB/NmAtlhojCNBDYwbBlY0lsAUfJ5loeaKk0Il
	4Nzk3KQeVMOA6Isd/w7kfyIFLHc0sUwQeUrsypgdPEBKpIrxWT552Lj8USxsEj821YtR1D16oFK
	z4S79cucBw3uSLerTcMfaarmNVSk6rIMaerP0wNf89B0y/SbY+rRikTd5wqjHI3jqhdQsYPejS7
	C+nnJGbsN7nzEUIb5kA1XvqoiZf4EUGcfA12DPvUjJijj2ZVU3ssWI+KyltPdw1ZVneeqxWz6IT
	A+ltlBQ48aYgt3oOWtsYUajgQDhzNG0tGH3B1WTX6mnPcDobpeSuR4qTrBL0DNPwrYslJkIbOF5
	S68JarziGKuUsBwMGdC2LU1tO57ixBR+ibtqahh7HFcQi7WfFlpa4kRbbtet5P8NSKskcbJrmYw
	PXNnb+y3nUhHqkMNi6K4KuVeu2synw60B7khH/X+qSfiGStagXDWT226O6g+QkHy+nCk9y5nUza
	JnBPk9CCnujp3pnqSsjFNGgsmC5cJ63+Iv8lq0gQC8jaWMoYjWh+swEjm7Quqcsgd1M5cE/Hvac
	zOzlrNgMWXqQMtA3Ot2GylJAR7yEF/hn5WGMvfH9T06KFYKLjky21gUKLRA4pvMG0TFiJc2QFIB
	+V6lgKEDpude8CQ==
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id 5b1f17b1804b1-4ac151a9077mr149862625e9.1.1793480664317;
        Sat, 31 Oct 2026 14:04:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abea72254csm82768725e9.1.2026.10.31.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:04:23 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/user_events: Don't free an event that a dynamic event still references
Date: Sat, 31 Oct 2026 21:03:59 +0000
Message-ID: <20261031210420.501187-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

An eprobe takes a reference on the call of the event it attaches to,
and kprobe, uprobe, fprobe and synth events all refuse to go away while
trace_event_dyn_busy() says such a reference exists. user_events never
checks it, so a user event can be freed under an eprobe:

  echo 'u:test u32 a' >> dynamic_events
  echo 'e:ep user_events/test a=$a' >> dynamic_events
  echo '-:user_events/test' >> dynamic_events
  echo '-:eprobes/ep' >> dynamic_events

The last write drops the reference on the freed call.

Return -EBUSY from destroy_user_event() in that case.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
A non-persistent event whose last fd closes while an eprobe
holds it now stays registered after the eprobe is gone. Can follow
up with a retry on the eprobe put if wanted.
 kernel/trace/trace_events_user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..49b857a7f1d7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1506,6 +1506,10 @@ static int destroy_user_event(struct user_event *user)
 
 	lockdep_assert_held(&event_mutex);
 
+	/* If there is a reference to a dynamic event */
+	if (trace_event_dyn_busy(&user->call))
+		return -EBUSY;
+
 	/*
 	 * Detach the fields before removing the call. Removing the event
 	 * frees the field list memory (trace_destroy_fields() is run on
-- 
2.55.0

