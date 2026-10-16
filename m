Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBB39449C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129125; cv=none; b=YMzFuN4nUGx3vxUeAbdCeonAf1C5JaAkRg+CSZUZKZJKfnwnfZmtrW9k+BW3CM6u3j/R6EKZc8t74lei7X9cbOEJLT8XS0ACQELAGhxUwXXHKRZpQiEbRYH8bsKHKkJcaw/6XaqjUQeLcJa/YIG5DWYJ4Ewe3PI3u5PS8Si+IO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129125; c=relaxed/simple;
	bh=XA1td5RtXyr53ECVqINeTSELxJLO5VlbkDz1qkltoms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaaAbX8Kk3T0x3DcXyW3J4N89JBQS1SlUCr/u0Ce7s8YNAiDXLW6FxK+Z1IBr9yQgbdhpXzlDdo4Zq4NnIxpA4CQtsdJQQr0m0MChLjSVZSfS5lAMclxcR8TWUWER+RYBjkVRsRXEwrw+TPLYvYwpCBBtJaqT5MVxt/rLmQmOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9wC3PV7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9wC3PV7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so37680035e9.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129121; x=1792733921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TOIiQ6a4LuFeFNpA463QSfXeTShKxZ66XyKQsJ4fw4s=;
        b=m9wC3PV7XGX8JoHcO6Fb/rSPE/nxKaxOTssgwI0+SvUYKD7tLiN9shqpxg6gSlmA/u
         AQCprENSA10LROwWRnJJQDqrCfO4Yx1LWfzPdFuzTeWN5pnVpVQ+fZ/d7S83RdXDZHXt
         ckdzmxBV9Cfk31+QGQw0TvDSQ34/w8R5Fpr5Y71VrOHJX68L5iNkwcf8n0e07AyWvLoA
         d6Di+htDoFkSUednTuT6w5AM/U/w4EcHpgLhIJ3FdXviHtV82l9TTuXqxjgJQLx6r3TC
         2UDfFin2tMYb2QUKAkGgsv8B9zcex5HfMz5P+QahZIvKNJSvC2O5dz6FzeBp6OuKaH6v
         zkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129121; x=1792733921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOIiQ6a4LuFeFNpA463QSfXeTShKxZ66XyKQsJ4fw4s=;
        b=ht8EW6P1DVgVUkqRznGABGpxk5nm7JMvTD6bjMX8bXlEDZoGmMFoOUSgSHUtGRHmul
         dqDTukA6XJ6LkTNaJxcqafLPWT2C9VDmzjfIMGY/EITOjy9sPPp90Qb9DR8USfX0A1L5
         50CEoseF/mbeG+QQzyCbzD2szdHCkmIMQFgPJSTFlgh2rZEzGKV3CKV/Q8FS7FkBvnxD
         j9rZNfVvfBHqe8Y8rArLcYWtDao+9auzw5uQVCpNuuoznT0gSJyHJ2jfdYDoU6NxXKn8
         +JNDhwHXLZlbdukxEOeC+xmzaUG/6Nwk1ok3r1gqpt8pKoLPwUlj69x8A6AZsAH1hD5b
         zE5A==
X-Forwarded-Encrypted: i=1; AKwUvBz97FrjsiQNqFyIH6P4c9JTYvomW6ndZbRPtV/JfOfIP4F3b7C5c77xpvM/B8Lt56g1GR0OYmA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHVpa84euocsSX9q+axSM478xdTXpS/9Z2Z5ESfApNcxH1fH5d
	CfCOrez9ZAlR70vcDoyIP96VhBWlmRzKu4HnXALqthBYnl4KQ3p4mJ60
X-Gm-Gg: AYBFou2MwMuY+jDanh9Z0QF2HNDjUZlt3C37NoVBkZLRpQuNNcT4OBErEVZMilx4w+H
	zbql4l3WMIJsi+hMmd19e6YkLVHEa9YX5c9O977RfbbYx51LNYoxcfwUa0X/kscNBozA/vjkeQT
	ZhsPbyx1sxAWnjmYnZvEZeXLHXSr3kDHPTJ2rFemHKw1sE8kd9wrfKBW0Kp8LsQms93NiGEz9ma
	3X9FhicWYeQG541JP8fqyCkcpGWBZf8pTziuIgZZ6olYYxiDu0wnnDgc+ApobIAiOAD1KfFqQln
	+Z9NpYC6Yh81jGUOLSDpS37I9Zh4s9jstaV/iPWboUOIaXk4OyXgO/Fv1/6oCVHMmvnF6SjN6kQ
	/IdpVFD3kbqdOWP71aIHZqgelXG25htyzjywAmhsTYaqGkNp71ei1wv8zSn139KLCdDgbnHGEXl
	7p2nYJhMvpcYQZ/iy0JFT76Mwls0r0dB9kBYYGEUtGbcBHDtkfxiFaZHJmU5fxBKOZ+LxS14Eo8
	w0/pSUqD25m8RCVqE/K3+c4Sd5GCFDUaoj0WTwGeQA46Iz3YK6KoL/4MvI=
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr452496145e9.9.1792129120743;
        Thu, 15 Oct 2026 22:38:40 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c10fe9d3sm98463075e9.13.2026.10.15.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:38:38 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Hold trace_types_lock when updating modules in persistent instances
Date: Fri, 16 Oct 2026 06:38:35 +0100
Message-ID: <20261016053835.204353-1-devnexen@gmail.com>
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
can walk into a freed trace_array. The notifier also reads and updates
tr->scratch and tr->module_delta while update_last_data() may be
resetting them.

Fixes: 5f3719f697c3 ("tracing: Update modules to persistent instances when loaded")
Cc: stable@vger.kernel.org
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

