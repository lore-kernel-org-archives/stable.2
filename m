Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AE3AFB0C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131405; cv=none; b=NC+wuvmGiM8jvjoY2oqZQgnn7MSWHkredgvp44rue6vH5QAzkNBJ4Dvk/nIAri3UNhuQioZtLd+f+vrwYp4w6hkMnmQOMP0mPsm/T4J+/hWeFQtik3jKYow7b4+ER0oaCMRsIC0+Ma6eiq/ffV8Ujh/zoa5Kzi0+WuX2UW+ZbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131405; c=relaxed/simple;
	bh=sRH0ha2EZ153ajq54eM0Yi85dNlM+hFCBKuV5K/D0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5Cae5aEopfMs/kBXrWBH+thGwP1GJJYDJYsy8e5gFzMToIfABxcNzHo8xBlPyAc46XOafBAl7jSP2J1FI8hiNgnephBhq1jNG7g+vyTEkOqXCAmJPtemoADBg18qx8LQ2jKcMWDHROp1Jn/FjkgSITCAKBsi4aqJSyBtixQ8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj/TK+CH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj/TK+CH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso39245105e9.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131402; x=1792736202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=haJU0ShvAO1LQDIvBwK5BiMB17AU7LxjM0Mr3FtXsAw=;
        b=cj/TK+CHWG6KFcmymsS6BeXkwJ2UsIkY1V/npmXtcHN+DQVISft2xO2Gwwu0m9kikL
         NptuJtZIkc7eLt3FaylMwDc0DxFgc1QQqsiaU8H9mO918fKDSLkx8JGhi6QqfDeVDQR2
         gHSJRW3EWz0hIYsI4wT+D8RCPQG2aq0W2FwJHhhZeNPB+gwM0307TdsOpYQHeE1/byDh
         k9yWu8X3wD3aw9oQL1sVSeS7lTPohobIu2sRVY6ZVjf/8KXAhRUAeR7YTmYf4QKb12AK
         qMTcP8sghXXmNEjv6AIXxVSbSr5Ap3ocxdG+QHwPRmpuMowzqqa5ibGCAP2iespk8/Dn
         Y1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131402; x=1792736202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=haJU0ShvAO1LQDIvBwK5BiMB17AU7LxjM0Mr3FtXsAw=;
        b=C5E4JTNj3nJF7GddpGL7pbALZW91PmLCRFZG/I+805YXNHwjLQebyZEwMC88YYpn+l
         gyg/3yj6yvCz09BWncMnCJl9/m4GOzjYLsoTTnSzv9pfXEHDE1wMR9MmssuXU7bnk7YO
         msNwrsNuOIOjAZNU1ZYy9GEco3ZKBH/JLndICWVQCMeRDviHzeA0zUkkt9T6zL4xCZk6
         eB9XDTdxjdcK1x64Omo2i8Bt/T7B/zQSZLfRq9vjeRGRfLrF+cv2iNNBexOT3QiGnCgK
         oQsNwFc8rg601OZZke1SB7HXI2umy9iisHr6ObuNX6axTybU/ExILOW3Rnj2wsijWV/e
         phWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeDGG+keVbDPYxZ0j4mDBMRb1YlDqEp2sj5VIfMQt1oLMyOmrZtiQTYjstFBC9lJGLFB4AVQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPJb9Ykg8KdV3NOdhig/xB/2JOmWj2jgjD3Quq9uB5zVg7ftib
	9DV+SktdTwgmPvMwKSSMP137zI3K1Yb0HBr1g60TOJlNxQiDDEm+jyX8
X-Gm-Gg: AYBFou3aJ3+q7630pXgIf+waAFOdLNoYGxOhASUL6DNVQ5NVyCffZiGCgJu9aZhN7xR
	Yt0CHtzE0Y//Q+8YjbdEq6cDE+vPHY5XBT2Qv1MI7OY3bSAIM7UWN6UIR++t9Z2RF8UoTlipW9R
	zQE8p1PmmNQ3ntXUtbVg8K3UGYoqYoDlgXibUoF4aifPLKBufaxdyl+28qy9OlV1Rp92vbShZos
	ufY0A4mi4XE4/rb4tNamFbuffCNofNytmqMk593XNGkIIL6g4BdLlCVdBVi5tzDDHygkPe2TF3A
	s5hmYSAsvvG1yqHhhNRXHs1PasdwgNP9KLatfZTXk0PttupV8VX9iaLTE/2B5+tQ8iLpyI+4IGg
	nwOo33Q6l2SY+PJfH5hItwu0yF9/V3LPs6jD2wV+Hnptr4d5ZKol6UubtHFwBZPkJvPbEukegTI
	3l5gIl+sGWZ8ChsIfOc0X+arWI09b9u3Hdc5MNVSnKV7KNtm4IQEgQwC3j1NEDTKVu4Gqrt3w0b
	iyvEesZt5O1w9wd0JqMt6NTB2J3qZpkD6bJDAfs+hJbyxLkJBce+JEQqgE=
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr454717125e9.16.1792131401674;
        Thu, 15 Oct 2026 23:16:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8abfae7sm14985945e9.0.2026.10.15.23.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: Hold trace_types_lock when updating modules in persistent instances
Date: Fri, 16 Oct 2026 07:16:34 +0100
Message-ID: <20261016061638.214847-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_module_record() walks ftrace_trace_arrays from the module notifier
without trace_types_lock. A concurrent rmdir of an instance removes it
from the list and frees it under that lock, so a module load or unload
can walk into a freed trace_array.

Fixes: 5f3719f697c3 ("tracing: Update modules to persistent instances when loaded")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..d3ffbed9c44b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9247,6 +9247,8 @@ static void trace_module_record(struct module *mod, bool add)
 	struct trace_array *tr;
 	unsigned long flags;
 
+	guard(mutex)(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-- 
2.55.0

