Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9C51DE1B
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067670; cv=none; b=O+xMp99wgfzNvkE7aHArsY0kbj6kGncyIr5cPvg6jS2Eyd9jBOS7p2YAFp2cNSp3pnyxJXTD9wZWfK1lQbuaymhSBff67e3nggy/Y+Ha+l6bQT1cuJCOavjIWFP/7unVafRj4DIHj3nrZUaAFLEO3htbbk+U+hsvHL+M1c+9wRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067670; c=relaxed/simple;
	bh=6RYCJTgmZtkhTJF0IB6+IuC6pGbjy5IhOnHcNqjkuBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ulm5g/ViKdddCtFrvIf9PV90z0+f1AJS8YiBFuTZF1UJ9leHhFIiEZa/YNztCjTivgPNoDe5a28DSL+L4JRJFpJ8FzwqqthdmjnLuScLH/zPqUBnCe7oSWTXW9CDxjNDF9Zqw5hl5QFzUH702dW45bUrNsBnkNXi49uNvXlV3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bes+hyL9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bes+hyL9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso944067a91.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792067669; x=1792672469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuIQxTwfSJeHtZkn09gsG33Ccv5vPWVkF/kC4waNbbY=;
        b=Bes+hyL9Gkg2QnWiLjSO7paxXpTj8q8o+7xp0hD4eT5TyitpciP5VjBUkruqGr8qnd
         AUp7tKX0/tQmzet2x+L5+1nejaeSgltV9+JQGzrZt8hM60yGd8woKFFoByYE3+R6T+jg
         c3CQJD30XJZkFlMoxBSVzRrtkBznVTgE3M9AU7g7MI8LEUcpKMS5WQ/jq2/Gfaj8s7Uy
         kIKua/ipYWIPcc/AqFO4iQsM1Sdz6Qdz42z2bXMl2mk7eKP7zWIa/LNY8+xkdkPboy8Y
         6NfaDYgA79uzWwRLExul81/0dLyM9lYnSv5+ZhWOA2jGyj8JsS+RoJ9PhsuUj4AKk7oM
         k0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792067669; x=1792672469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuIQxTwfSJeHtZkn09gsG33Ccv5vPWVkF/kC4waNbbY=;
        b=AgnHh5RsFO6Oang9Xxb2VDTH6llUCCrQYmKWCQFqB71XD75FyZ7NTAJipbUQZ8X5Zj
         TZScn1Itd2i+aRdRx9ZNmzszUGCoaP1LuocB1YZFqKDFQXh1iihQzYnqfmEsOyav+FDH
         wgPncyyE4yNJuJAPxFprhSs/HJlWE4qamhAgelHs028Z4IQ0RIZRHpYGWIy0dnSxD/P+
         y2rE31DuvAy9/jtIOSCrD9F/b7FBI4dwMbUsBgkJ7N77pI3b2Yzqd+RABO4a5eDd3dZ0
         kt5eg0tAm8UWAImC+N9UDCnUFkx1Zp/iNWLh84Ghb7MiIj12Rgu6ifMzOcsjYqyt6tsX
         eErw==
X-Forwarded-Encrypted: i=1; AKwUvBxLtJdlcQdM3po76tKfJNG8laMKmSo+3UK/HJQ9D/C30aEBnHjiViT2Vim2Ah6FYtiU0oiIrSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjtRS934XZhvHcl7iz/SzOsC9EA5YEVDicmJoS1U0u47v0g0ka
	TMeitqWL6okXaA2GrB7dDlmFd6G3NKfJ4NtEBWxLgWKUdsu6imkcuJ4i
X-Gm-Gg: AYBFou3vqtHoxRZmfWNh+eZjtGgYIFaQicMB0wfoku2Q0R0eBA2WQrw4iRxOMh/dbML
	0cwViQFp7mNDEcKimA/UrsvWjEu3A72LYsmhxGo6NDf8NEZQwMWJE6YC6BLYW0lnhxqq0u9AjtB
	h0KVpRjXrSFjdEvJLfJpkk45WLKLh9Kvl0RHDd3h1vJ5LB0qO7JQH4dImkf8HwtC/rhem5MVHmb
	D5Nh+BdyLHrylihl3FUnyR49oeG06tFzeTN88Lxneh6OQ19VtPL6gBLBKsQvSieN5iS8zU1DA3x
	WgcMs54Nuu7uCKETsKp5kZl49r7h1ghf3oo8x7eeGT+UmbK5K3zjlN9+5w0oxmAEiU6H8vb5nyj
	ZenigU0ICEF38GGE/lEubSNmgIn8fs+0NHdyuFrDL01muPIIe/y3/oknE1JWSQWuQDDkj9axsna
	LviiEz001J/a/eqWcYh8utRLPN9HfhMNNhkyIPEiip9BInkBPP+1OJknpOuJeHdWmbQsOyC7jVh
	Hc+W2suix8=
X-Received: by 2002:a17:90b:314d:b0:3ac:7556:8eed with SMTP id 98e67ed59e1d1-3ac7556a42cmr3796079a91.44.1792067668726;
        Thu, 15 Oct 2026 05:34:28 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9444a0c6sm4714146a91.11.2026.10.15.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:34:28 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	elver@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/core: Close owner-list publication race with remove-on-exec
Date: Thu, 15 Oct 2026 21:34:16 +0900
Message-ID: <20261015123416.795008-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_open() makes a user event visible in the target context before
adding owner_entry to the opener's perf_event_list.  For a remote task, it
also releases exec_update_lock before adding the list node.

A concurrent target exec can therefore process a remove_on_exec event in
this interval.  perf_remove_from_owner() sees the published non-NULL owner
and calls list_del_init() on the zero-allocated, but not initialized,
owner_entry.  DEBUG_LIST reports a NULL-link list corruption and can panic
the kernel.

If list corruption reporting is non-fatal, list_del_init() initializes the
node and clears the owner.  The open path then adds the ownerless event to
the opener's list.  Closing the returned file descriptor frees the event
while it remains linked, and the next owner-list insertion accesses the
freed object.

Initialize owner_entry when the event is allocated.  After taking the
opener's perf_event_mutex, add the node only if the exec side has not
cleared the owner.  The existing mutex then makes both orders safe: the
open side either publishes the list node before exec removes it, or skips
the late add after exec clears the owner.

An unprivileged remote-task reproducer triggered the NULL-link panic on an
unmodified hardened kernel.  With corruption reporting made non-fatal, the
same reproducer triggered a KASAN use-after-free in the next owner-list
insertion.  The patched hardened kernel completed 1,264,540 remote opens
during 60 seconds of concurrent exec without a list diagnostic or panic.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f6c..5e191757a08ccc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13382,6 +13382,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	INIT_LIST_HEAD(&event->rb_entry);
 	INIT_LIST_HEAD(&event->active_entry);
 	INIT_LIST_HEAD(&event->addr_filters.list);
+	INIT_LIST_HEAD(&event->owner_entry);
 	INIT_HLIST_NODE(&event->hlist_entry);
 	INIT_LIST_HEAD(&event->pmu_list);
 
@@ -14252,7 +14253,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
+	if (event->owner)
+		list_add_tail(&event->owner_entry, &current->perf_event_list);
 	mutex_unlock(&current->perf_event_mutex);
 
 	/*

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
