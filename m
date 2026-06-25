Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99780282F1D
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410530; cv=none; b=r1mHcbDJCFydGLUwS1dkGgoIDfDJM+puYfQ+PMpCpp/Gmnr8Uxzyp7VoRymJ8pURtAi6oDVDb/j7iYMvNBBeg7gfwxBewV8QIwD75giRvo7QLi+cKVSYQaZR9C5q4GP2uzoLSmTEXRkAA0ahvZynGnsIgcuqrxFymq3h61i/o6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410530; c=relaxed/simple;
	bh=AwfADB71gtX5OxxtbKioKMZhZz+x2T/CDlQMHNmN75w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUbFpVUc1Wpqd1RHntHPLuS3Zj6lExgG/0Uepg+M9wm0jOOafh4urw0NmNeFt3X75ZhgPBgun85QYjzHPEHe3a+zUHo7x1evkWhEVHQQVq0Dxs21/CYMZZuDl/T1GtWeB/mj7Lij8Aa7n7kzW7RUOz2iGMbNZdlFWh8NKN014M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UujjQC+d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UujjQC+d"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46cf972f281so13743f8f.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782410526; x=1783015326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy1R4WQwhE6n66P48kYKV+Z4fPY/RPEMTv/PHWH3DUc=;
        b=UujjQC+dVVcLWdT6443TjHND8FA6tfKWMXtRpVakfUHjeIBzApSRAV5wNF0/ZbmJuR
         waQ62L7pF/NubVS3fX/0uNXHPgxorntkpsbgKNZCh+Vm2l08VDk5/TGPl8W6yC21BsvQ
         gS3e5RcBBSRKsegsUEdDeS3eDhlDENyoq2Aen5SP46HgI846u2oLSb+Zit1+her4VNbO
         VGqRY6fNRwrXopoVTMeKLA9BcIoomnqhfs0myqBMqv3XPxvBvZM2eG72sJyfV55cwrWw
         QYc8oR/sMFU9Lk4euzOXMivZYrrPEx1PxCSdjrstdRi9Lpax2uMmMXyNIDlP3siwCN6i
         hSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410526; x=1783015326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy1R4WQwhE6n66P48kYKV+Z4fPY/RPEMTv/PHWH3DUc=;
        b=qjuHGGgYsXnUkv8pFwiLcluVvxNjxiL7UBW7F5Kf4TWzfVmoTUf/k3tuPHgB6sW1xN
         S6L3x8dacZe7pr0R+mnVEMYlV1tzdjdPa1ZuK3Nt0gVbsbT0Ogt8YQ9n2V/WLmsjqyq+
         l8iA8Ae9oJH0yqrNJWw2yKHhC66+T6T/Kv41cNQ7e+7Vub06X6YB2UCHbTZ+0mr7MBVi
         b+ggxyCyufXJWhnvg59y+uddFyayjkwi9hC/3nXHGf7QN+KHUBcKuoiCDYxfjEMqM0Ti
         nE8J4FbflrD85nxXvM37QGpcynaiNbPR14E9xs7p1UIRfqZ5GDlb/dFvvdQ40rxAwq4V
         CW9w==
X-Forwarded-Encrypted: i=1; AHgh+RpObGaqbwvBFRSYIvJEQfgA8eSdC3nadq5FlBvTqwq5Tqtm9N2zFKWmf3Diy5b5zDWQHb3cAtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzP2yDb14opyy6zdohrVlzOEFeCKo8tH7cuN4ezh24hk40HpT
	Vg9JyDfBFu4RWxCNcedV2AKCfeGQbTTK6xYT0q+VN4I7rKWimGeKcrQ=
X-Gm-Gg: AfdE7cmdi2a9bn0fYqcIcbtsyg1GzP5m47pDxkiDFfY9/P5jssDigpEnM/xxmFwVKv9
	6/4/ncvQnlzC3FGB6QztG2DRNcIEmOBTX4A7Ve4G4z9pF+FqGS+CYUb8iRN6g5/JWY1RLk+QNRP
	HT5UdoCY0XJJ30OYaJKi1yTSPk4JQdegeZeC1ap2u4V9PXeHd6Ly6KuOO+JSoI50Q+jpxntsJiA
	v78S/9/SdJVOU13pvJ5A9Z+yQJgXWUC/tcP0py99NHDZCrbdljtHe+kf6LsYLI7u5bSSf0Cz2X6
	HErnS/0NDI7tWlnGQYc0sEXqYk6ED3N6e7RsWrPRqtzV7gSi5dR1c/JxYtnkflA4ztInYj3UpsB
	LnST56YRg2qE+726MCpHdSywurwFJwRTcJ1IZCyxviDk/g8ZD63FHUUX2Rykeu1m93bUh
X-Received: by 2002:a05:6000:4b15:b0:461:e43d:7d98 with SMTP id ffacd0b85a97d-46dc1f7a1c5mr5570318f8f.43.1782410525621;
        Thu, 25 Jun 2026 11:02:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b85csm16743544f8f.28.2026.06.25.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:02:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] tracing/user_events: Use kfree_rcu for enabler cleanup
Date: Thu, 25 Jun 2026 18:02:03 +0000
Message-ID: <20260625180203.3343545-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

user_event_enabler_destroy() removes the enabler from an RCU-protected
list via list_del_rcu() and then immediately frees it with kfree(). This
can result in a concurrent reader in user_event_enabler_dup() accessing
stale memory during fork, since the enabler list is traversed under
rcu_read_lock().

The ENABLE_VAL_FREEING_BIT check in user_event_enabler_dup() is not
sufficient to prevent this, as the enabler can be freed between the bit
test and the subsequent pointer dereference.

Use kfree_rcu() to defer the free until after all RCU read-side critical
sections complete.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38b..72bcb429eb4f3 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,7 @@ struct user_event_enabler {
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
 	unsigned long		values;
+	struct rcu_head		rcu;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -404,7 +405,7 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler,
 	/* No longer tracking the event via the enabler */
 	user_event_put(enabler->event, locked);
 
-	kfree(enabler);
+	kfree_rcu(enabler, rcu);
 }
 
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
-- 
2.47.3

