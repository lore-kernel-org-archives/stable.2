Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF737BE7E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976909; cv=none; b=dq00qJ9Iz3vUUoy/InHapErmAKaE/YSEshrQrbPidPBbtPjYAPtGlzRbzpodrzxAwUs6vwGfP5lN+o4ZOcuPaB/PggIgTJ0mu5fFnosKP0k85HC9O0pZTKt0Z01YfyNmmfmLXd0H70Sqkrxf2XU7/dQnRs4GkJki8raXyKjOlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976909; c=relaxed/simple;
	bh=GG8pFvCYlju27mE7uNA7NfAlddJXiZpGOvkluyIkBMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d40c3r/DcmFfWdk2ugOHJJhkUvOS+OqJFGG2eVGxJlpqydoeyMklBxopCg5cxLxAsr+vTyYV/1ySVnKjotVpmeQweIMDfcHBqBLFnga44Sye7Y79sbVR4MOvPhn6Jer10JOYxFaHzeoeFUshXc1cNThPWyzXA1/egxkgl2PYLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Npby1FB1; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Npby1FB1"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so58832685a.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1788976906; x=1789581706; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ViCBkdbLW7JdXmtrQtir0eAwLk4ivWB6Xk+gL7SNqv4=;
        b=Npby1FB1feUrqqGhVK5Jden+msFFDuJUEaGOr7CAmN+XghUrw5D4mA+XIMv1A6dFkn
         O7+2rhV2wGGmgnWI7bQXKrV7h+qHWICV8a4XkJiENExh4hqyuZzYT5DRoQWYHf9WEIpd
         A9d4uCPUnyFTE2qi/Kun3dIU53rjqyXal7tYLn8Ef9miLIgjnGr55ikHs0Uu77zoTteB
         KGfUB4FnxYzBF4HU4aMMDBRc545HOQz2m1zJgJgESbZDZZOxI7awnWhS9mlObB00sGfj
         REQqJ3Rs+6W0wYDOhPa5oB0oN51+TVgtqQhw9oq2GGjn9QeFghrCfy+G8J91TFtkV1rK
         dv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976906; x=1789581706;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ViCBkdbLW7JdXmtrQtir0eAwLk4ivWB6Xk+gL7SNqv4=;
        b=peBfgOXpPUWmebfGpYUXvHBfhhYKl0Tf7XLXjFzYr4Do3uTJsfA1//ZTO/gxcxsXFb
         hMVMaYyA9vWwTWVoHMFo2ZCYIynoan1VTdDfS1W9ZLU2jwctPLJ8HppzajfN/QupxqrG
         ZuzSzhKrP+NS0sgVZxMqWfRpeucxDB26LU9T25Hl4jOuDrzx/W1+Rrg1swTk+rffSVdT
         J8UOU4Qs1A11XLUTALVqLWW5jQ1+51skXCR1A9rCo/ss/hnZTMEzdPndXP0g5guTZQ1z
         i7SEhGp/5zlHhDIZSOsZDkVnnAS0MZmsQVUUZIoNv8mStitdQMQja8yEZmrDDkiG2xcR
         ET7A==
X-Forwarded-Encrypted: i=1; AKwUvBz2qGTsqhNSkseyVxEkBcdhPjdp+DP2VkjNX5kGzYtBPxlLsJ2oHC/HAhzz2R/Khw8CLnUvAWE=@vger.kernel.org
X-Gm-Message-State: AFuF++mCVhsWmQ3nUcbWlmSaHjYeGG/yLs5K6GEY3+Y8TQRGEN45/U3m
	dvbl8NsxmJwRQzpYxKyopie9jAAThT2qd93gRVvBiTFXc9e61GBNhdPFH78EDS5RzyA=
X-Gm-Gg: AYBFou03a1pfRfikPEDRw477tNnqNkybFaZU4bAl5BHTOJxHJi5SLoJcLIomG/pEaJX
	EzhcSUSqJikTesrObTBEMI3gP2ePIGeVXkP0lHdByscFGI+Uk6QGULCpLiFzO+OdEf9yQ0BoiLh
	NwDSzioOxFnPzkcwU1Xpn0UfG1kH2Xjs/PJYh+zY/4v5drsaQqASJrKzVyEwiszz2TcnHa2qIof
	RzOqtBUKEuvY0pny7VWfOlq//M8+Xf/pAGUzTlTXDd3HN9eikv0+xdp3tLw7Umu+jRS7f6/47Ue
	/scxGAXnvWtAE6ahRk703AFZj6TOS8B+8mFk5DtpDibFQf8QHTknZflhsIkwKa7b2sCO7WD4gp6
	yoGCTa3fIX88RItHGLG/hgX6GOcNHhfx8Ne6m8pB5MDX/iGzdaDYjyi5hDjtZXFn3uJnqViGxmY
	nkECi0phUNKg4njt0cNxfsi0VlMbdOFc2eDErBjy662JBkbNJFs4GrGl/jy18xbp/7Ct5wrqL7A
	4qzVAqJXDMpvc7yw//PhwbZ3WqsslO3QL0XgpKbubs57CyJSMxduzRW
X-Received: by 2002:a05:620a:3941:b0:92e:4927:2002 with SMTP id af79cd13be357-939d4a8ebb0mr452910285a.39.1788976906226;
        Wed, 09 Sep 2026 11:01:46 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9398c498610sm1295435685a.43.2026.09.09.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:01:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 09 Sep 2026 18:01:07 +0000
Subject: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAOKeoWoC/yWMTQ6CMBBGr0Jm7SRtISZ4FeNiWgaoxqozRUkId
 7fV5ft+3gbKElnh1Gwg/I4aH6mAPTQQZkoTYxwKgzPuaHrTY5g+HjPpTVHCgi/FzrWdLeXYsoX
 yewqPcf05z5c/6+KvHHIV1YUnZfRCKcw1upNmFtj3L1UhlqWOAAAA
X-Change-ID: 20260909-cgwb-tasks-rcu-qs-42341609f3e1
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Dennis Zhou <dennis@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

cleanup_offline_cgwbs_workfn() drains a dying cgwb by calling
cleanup_offline_cgwb() until it returns false, with a cond_resched()
between passes.  On a CONFIG_PREEMPTION kernel that cond_resched() does
nothing: _cond_resched() is a plain "return 0", and under
PREEMPT_DYNAMIC the full and lazy modes disable it.  Since commit
7dadeaa6e851 ("sched: Further restrict the preemption modes") those are
the only two models on the architectures with PREEMPT_LAZY support,
arm64 and x86 among them, so the drain loop never reports a Tasks-RCU
quiescent state.

A worker draining a cgwb with millions of attached inodes runs for
minutes.  On a 6.18 arm64 host in lazy mode the cgwb worker drained one
dying cgroup's writeback domain for over 11 minutes.  A BPF program
unlink (bpf_trampoline_unlink_prog -> bpf_trampoline_update ->
unregister_ftrace_direct -> ftrace_shutdown -> synchronize_rcu_tasks())
waited on that grace period while holding the trampoline mutex, 42
tasks queued behind it in D state, and the hung task detector fired at
614 s and panicked the host.  Any BPF or ftrace detach during a long
drain inherits the drain's length.

Fix this by calling cond_resched_tasks_rcu_qs() so we do not stall out
anybody who calls sycnrhonize_rcu_tasks().  We put this in a do { } while
loop because if we have many small cgroups cleanup_offline_cgwb() will
return false and we will never call cond_resched_tasks_rcu_qs(), creating
the same problem.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/backing-dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index cecbcf9060a6..18e999053bae 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -910,8 +910,9 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
 			continue;
 
 		spin_unlock_irq(&cgwb_lock);
-		while (cleanup_offline_cgwb(wb))
-			cond_resched();
+		do {
+			cond_resched_tasks_rcu_qs();
+		} while (cleanup_offline_cgwb(wb));
 		spin_lock_irq(&cgwb_lock);
 
 		wb_put(wb);

---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260909-cgwb-tasks-rcu-qs-42341609f3e1

Best regards,
--  
Josef Bacik <josef@toxicpanda.com>

