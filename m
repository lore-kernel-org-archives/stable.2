Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793432156;
	b=rLIsSDmVLlHovZEv6w+OTGs/s/fvlpEfWvwKbE3NSHgfoI4RbPZBeicNdoVwifdw2EC4
	 b5vQFk4v3p0+jUIihzTZrUaJPY0IV+SEE+QF415h3qHBP8kUgUQtzXahhNZpAH+mY3HYZ
	 Y3c6MwzlbpNn4OgE1HpPcJKHmpQKBYNQZS0XSzO61cTt1AdrmZXy78AikuqCKvMR61iwc
	 YbEGU5wnPAtgiahWMJZwgBpo1UYXFi5siWlGi3jh6aPGHfatYtABYRuB9yrutij1JWW9C
	 VMzunYgIhzDMGlgAhxsnN/u9empLkqrnr/LzX7w9GQl9y+5pycCLp4W3ar8Cg4hNPjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793432156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+5gslzg9a9JuwOK+he4tla1iX8VcD5cZjM9BmN7Nz9c=;
	b=LSp+XQYPC+Z88QGelSeN5EygXgrOcLMq1fNVcg4RY1QBr7UZJEw/Gww8Z3092wK3xZOI
	 c4LjYPPvQ+txctaSGgiKnisOsg/esdXOrZqAMzI40OO9gGQXEO6+3FnESDmLP48Ot461f
	 j1/eZ+RASe8gRg5FPNgXYTd8B4m8/UF6a5HBGiy8ouloD6nLGSIAohi2GsKY97Zsh/+d2
	 YCFjAm4CdXxLZ8Kgx1tkAptv2/k4R+35Axa1beYFyoeMbNIXJMdaTNoE/xXY4KALfSKo5
	 X5pt143cWYof2m99oL264ZMZurySSzVq8hqQ1WAfkQ1pwCIkRZhsNsMWW+bJigfpouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SvKOnNCy;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F3606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 07:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SvKOnNCy
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so665371a91.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793432155; x=1794036955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5gslzg9a9JuwOK+he4tla1iX8VcD5cZjM9BmN7Nz9c=;
        b=SvKOnNCyFstvcC9D57o0R6N7UChcOOFDDSKBMGmzKSZMYaWEPLwhthA5qCBMuRT0hs
         8Q9hOT4Vxx95cknrInA1Z8kNyA2UmISo9OONbtK1JgolMNARnBRcW8KRIhfpPshYU0ms
         TXaM027a6jBuHZkG1Qga9X1F20DTFfOBBGqZayDyosLbvChxAb4SSCMVICfaK1Jf/+Q0
         SrCerN8m4BR3FpbeCuWLupxdTjru7XTAwV1yTWkVg02f2gQVcEDEHtTTLu8zaBtSNrwD
         CVDq/LM6McTGL8FuxPP18t37Wb0QqkTj5uVCiVxw4QIJRi5Ey5nGHtq+hrWDUbYFC+O1
         Wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793432155; x=1794036955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5gslzg9a9JuwOK+he4tla1iX8VcD5cZjM9BmN7Nz9c=;
        b=tHh66TkglB3yA8nLAv89lpW0lonhyLLQbzeIRhnUgyPfIiMT7oVFJyXG5djyEkA6/q
         KoxCvj3I7OzD7Gf7UwC1vI+TvXCOHoFrcCTCfB0mcnQiul+UVqiCxnF8NP3AnmwHQEk/
         6P6EH1hVOx+hhlvDXnmzqYWpHSq6NbF+phFJ8RqDFWJuwmSZ0guV9w+A41oADl5VqZNK
         ZFB/QBX1fdvC+QhpZHXyfPhTkEEVmNBqP46nqqIVSOAyWiwFtsRLTSfp/teQZhDBw/rf
         el237t/6hT7dHkC/7OpOzjH+fuH/ZotMSz3JmthuYyb24Dm5dAEL8jbeIW69hRtTWWDL
         vvzg==
X-Gm-Message-State: AFq9FYJLP+sjz/QA1LdfFAqfssKH2mA9hLRF5C3Y55ItBUosPS5yGZr5
	QvR0liGOjEwlR5Z1ycmkymVzFIICm4UwKaxgGhp9Lclec9Ipbgxm1PHM
X-Gm-Gg: AYBFou0H7LbpVIzIQTwcxUtaNDhUs1PRSiQje88OVoFx2k8zGTejR10tcw/KHxpC8F/
	OSHKij4vq+pigLNLMtSsh3GkrQCK2tdMdd0cqYgTOoYRtRJ4xoEMKq7KlAV7MXyQJ6ZbiV0CYIa
	k4g/0Z8JUSXp0uyZeAW9EzAHKu54LloK+hNu3mOj8cpMJXIoSYFtddxR9dKHQAWGpeNKSMyDE2a
	WuvejIqaWmRWxj8m+GnTzhI9LUdeS4qsTBdfhBcyc0ed5kJH4kEnRV1U/SEtFqUDB3IDouhNDSe
	NW1MXlyo9vFBZBrPfSvaN5axvNdt/b3gGrUHWNQI1mEISL96VZVpeaANl4pbe4x9lc+1t8JHspc
	BsFpXDn9w78o7L+uRAPEYeCty6ds3QR+DFghyxuJ+LalHI1tYnfQdqWp9M9biRRb+3MFCqTtylx
	a8z9wYuyPxHcx21kClRPshZZvREOThBHmbWsLYU7Fw4XrYcBDqDtgDG8I2QwH4ox4cvQkwxelsx
	DWq1CeeVtW3Qgd8Zqtsxlf+s+gJL9hhACCUof/0i7u/bbq2GCi6WU472S43/lrcqqBWlF5+/iB9
	BoXel2pD2cQYTestjJIKc12wW08b
X-Received: by 2002:a17:90b:3f84:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3ae897a5c4amr3793495a91.41.1793432155390;
        Sat, 31 Oct 2026 00:35:55 -0700 (PDT)
Received: from localhost ([121.128.153.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm6942497a91.9.2026.10.31.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:35:55 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Keep copying markers when one instance is stopped
Date: Sat, 31 Oct 2026 16:35:45 +0900
Message-ID: <20261031073549.2991066-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When several instances enable copy_trace_marker, stopping one instance
can prevent the remaining buffers from receiving markers.

Continue copying text and raw markers even if one copy fails, and
return the last error after trying all buffers.

Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
The current code stops at the first error without trying the remaining
buffers. This patch tries all buffers even if a write fails, and returns
the last error.

Returning either the first or last error cannot report all failures.
I chose the last error to keep the code simple. Per-buffer error
reporting is outside the scope of this patch.

Please let me know if you prefer a different error return policy.

Tested on x86_64 QEMU:
- Setup: Enable copy_trace_marker in multiple instances and set
  tracing_on=0 in one instance before a live buffer in the copy order.
- Before: No markers in live buffers after the stopped instance;
  write() returns an error.
- After: Markers in all live buffers; write() returns an error.
- Existing text/raw marker and instance selftests: 6 PASS.

 kernel/trace/trace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..bddcb35835be 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6316,6 +6316,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
+	ssize_t error = 0;
 	unsigned long ip;
 	char *buf;
 
@@ -6346,14 +6347,13 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
 			written = write_marker_to_buffer(tr, buf, cnt, ip);
-			if (written < 0)
-				break;
+			error = written < 0 ? written : error;
 		}
 	} else {
 		written = write_marker_to_buffer(tr, buf, cnt, ip);
 	}
 
-	return written;
+	return error ? error : written;
 }
 
 static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
@@ -6397,6 +6397,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
+	ssize_t error = 0;
 	char *buf;
 
 	if (unlikely(tracing_disabled))
@@ -6425,14 +6426,13 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
 			written = write_raw_marker_to_buffer(tr, buf, cnt);
-			if (written < 0)
-				break;
+			error = written < 0 ? written : error;
 		}
 	} else {
 		written = write_raw_marker_to_buffer(tr, buf, cnt);
 	}
 
-	return written;
+	return error ? error : written;
 }
 
 static int tracing_mark_open(struct inode *inode, struct file *filp)

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

