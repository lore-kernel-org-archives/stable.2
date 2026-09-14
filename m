Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACB351C2D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364099; cv=none; b=JLrsU4B9Qdd5Vtzd+oVkeAQnaxzuLcyCGmqXFHDjrrTjsmymB/C1vPNEaOymlP9pgXya8QQUhEfQ2EAlo3jNNDodmCuazczhXN2yo3IM1ebZlyweQF7zQZo/htq6cELs86aSKyp7xR10rdM0fr1s1U+Vze2I8+SRMUaDpbPruSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364099; c=relaxed/simple;
	bh=pIQ9c55KC9C1IN19GUQ06sY5K4ji/wCShUGP3NMJw+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cd0W4mdizceyB7D6tRA7sXi2+s4/+dXcDX9kYifvhfPyQrS2yz5hI0O2yW8/qWPTlLEdwHVPbPJImZbYzJlww1WTIHSSMyibrmxzaorW/VG7s36+5zomM8kGM9QmWek7ic/Odtp2wisuGbQ+Exti+P2113o6++XtqO5+FnUbQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie/uE1ve; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie/uE1ve"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4d64bcea5so1486366a12.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364097; x=1789968897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWnHbjEBAwTuvLezoZnDfrNJHbYbnfIfEVdIgnju5lQ=;
        b=ie/uE1veeYdis4FZ810xJI8UPBOZlbilTNxbFvR4OGJtdsQjvs/e4Ua6MHYObh2JtO
         55ui48oSZXwzWmorkQZIFFu8RyUhZUAwQvKUDM4hmeBaLVaZHAMDMSiEMa89SAAPDQ4s
         +4dIgpegGmJVC/YadhW/X6M8YMaWscxCOui+up2Cs2hx6cHw007973LK8Es9L/XiEhNn
         7ir+r3bflWZrr666QrVPpK0zrsmPeW0VGqzzdeTNxaErz9SVvikZmP3wUGFTh/nD5PiW
         uf9JYZDNkjuOxKbScASVwOI6M9SlSGeioDS54H4Yx+D36Mz9RZp2DwHkWPYY6kf/30AE
         iHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364097; x=1789968897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWnHbjEBAwTuvLezoZnDfrNJHbYbnfIfEVdIgnju5lQ=;
        b=XckvTlwL8SPVJEAHDTwa9VB+5uNW2LXIZNkMAhne2Ch83BmwtH1UJ1REtV32CK93zM
         mUfsE8S6pIVlZb/SXXjll6NIEpqR/R5QMxQi3Nu80LpjSMtFM1hL0HqffZwVYYk9ZFVr
         JKvLs+N62ezOfwRk5168tditsTtq0DjCI98+a2AX5mCagMN1VATYlfDfRVzn4SNRrpx3
         XrUnWtA03tWcZ28U7TkckbE0c1FVH/Wa+FQPRwukPje+QsKUpe5uUeeD/rEc5j+UnnQ8
         eK17KOjQcKBY340cUDlcCKcoUhJfxmjXRiDkEujziNUrNpmu8IxWKrJ97kEPTlwNWiM7
         a1kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAUCPBlPXT2nBBlmJxRtW+LwN6IJlTzOeKgV7/cTzMufzpJC4cweAEXQGfMdfyAgUgUgTzVLA=@vger.kernel.org
X-Gm-Message-State: AFuF++mnfnrbce0qJKGsgu/UkSweMPPN13PZXKCWq5G8pJzIp6pe3e30
	Lk7cbpHwVzCeq08T9OTCDnhe+ebhahTlpFM2wHMCGw/4fA/f1FKTqVZvsc68Kjg=
X-Gm-Gg: AYBFou2lpQYqdr+Lu3anpKb164wD//Vexmta6TKZfiYM2hM3VWA/Ibe4+hbu/AqpPWj
	E8NaCam6STp24hvzzAgliQt5DerVcbW3VKkbitX/4vcz39lhoFKMyvQxXFGWsC3lHjfO5F/Pfas
	lAgl8FYQfMnpLUfVi5dBf1YVLQmB27dmH6jUE8fD0pzrp8RD7hCkRlFtqFvB3+iFzHhzN7uZkmQ
	R18d7ua+LCTmZsh7VgOUUijpZsg+VVh7+loEV41rpBqJ2uL3djdluj8Tyzxw2nwm1eI+IGCHQU1
	B85uv4KwO8VLGnTpkYn0nH7wUPNEyb8lgswGfr+VEULbVztG8Sir3wPekEkfiSUbDllm9w4kHua
	6wCg8Tm9heQ7OWw2FpbbtkxfyqPWmhIt4/AdwMrCAvtqDS2iom0H888mCeS4f4PYro9J+PuGIkl
	N8QghhVnSL7HrzGfCDHnt1NCL2q//FBejh6+u1jKFPnprqXJiocJFt+Bevfnz7zHw+HznU+czwi
	hKg59aWB5dgjWp88u5jDawrFSovr742LDqiSg==
X-Received: by 2002:a17:90b:2b83:b0:39d:ee20:1e38 with SMTP id 98e67ed59e1d1-39dee202423mr1419155a91.20.1789364097151;
        Sun, 13 Sep 2026 22:34:57 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm19009261a91.8.2026.09.13.22.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:34:56 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] tracing: Add the bucket size to expr_field_str()
Date: Mon, 14 Sep 2026 14:34:41 +0900
Message-ID: <20260914053443.981201-3-donggeunyoo.kernel@gmail.com>
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

expr_field_str() renders a HIST_FIELD_FL_BUCKET field as "pid.buckets",
dropping the count, and parse_field() rejects that spelling.

get_hist_field_flags() returns the bare string "buckets" and keeps the
count in hist_field->buckets. hist_field_print() appends it,
expr_field_str() never did. Nothing reaches it today, since .buckets is
refused on a value and no expression can carry one, but the next patch
renders histogram keys with expr_field_str(), where a .buckets key is
legal.

Append the count, as hist_field_print() does.

Cc: stable@vger.kernel.org
Fixes: de9a48a360b7 ("tracing: Add linear buckets to histogram logic")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a3eae5c1344a..91a550411e8a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1754,6 +1754,9 @@ static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 			seq_buf_printf(s, ".%s", flags_str);
 	}
 
+	if (field->buckets)
+		seq_buf_printf(s, "=%lu", field->buckets);
+
 	return !seq_buf_has_overflowed(s);
 }
 
-- 
2.53.0

