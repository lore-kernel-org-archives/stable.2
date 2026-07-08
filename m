Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BF422547
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508887; cv=none; b=Qlw1e8ipVODSqeixlv23PKY5WxiC3SnMIqfu/etRdvcMikgSauCHUiMyhUsJukfYgi6+jDqKtlipljziqQyL/exJht7kb48ZdIgVqwZ+lmNPLyln7IB06b7g6E1uNb8jE8HCGZCXlxpK1PeaH225pLzPAG+z4fYlTf91OZVc+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508887; c=relaxed/simple;
	bh=NTcQdvz0cR4eDOgCH5pZ9kcPw+nCYiZrb1LKuCO/DoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAy3r7YbmGKZXQ53EwnWGpD4oeK7UQM+NM8BtDDNz+Dn3ZVDY08Nm9pjR53nfRxuqFV26Gv662NHHSZbPscZxRAocc4UnMYTEQCs2LHFE/xRfIEsNm3e1XbhBDWHVBNqap328QkiBRYxuvK2H9KQH2SPQpdypmU3YJlmrXyxa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCQHP4/a; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCQHP4/a"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso614105a91.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 04:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783508882; x=1784113682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXBoNjYqVijB2YGKr+ij7ht747n3ecSYIrYL6ggZywQ=;
        b=kCQHP4/a30DAPY+VEylDlKyqF2WzadvMH8d8OdGHznWWaY19+3GVk1Di1BxiXYfDxN
         FyZZMHtcC92DY5zDiCqok5yPVxaYXvo/UAmYk1s4Gca4iAkm4rFD5gtJfz31CII8FKPl
         q3K+JFOzxXFaLbOokxIQMkM8boHAR5m/0bsd/g1uPMuXAoWbblvik5bcLbbjrUWfXJbC
         Zbz3oYC7ji2G19uG0e/j3e3qAQad9E0g5SgpmpguuI8VSkD9xKMNHOY8mywvJl1F/3mK
         e1+9Jgt9RmVhytbNUXWfNb4t1VOOpJFPJEIdoMvOX20WQ4xsKuXszWzh9ELQ6hgWzqH5
         MRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508882; x=1784113682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXBoNjYqVijB2YGKr+ij7ht747n3ecSYIrYL6ggZywQ=;
        b=p5nDeIZxNlUcC+iCZsIG1rBXn/L4zgpzPkncrCHjoZFT81S2evF4TQ4IKbwAUcfk+S
         Hy47uhCNsXAF895DP5nGlQTkalnCYLebNv3Hrm4YmJ2grdKEd0KdGjIcEJvS7dJ2nn/7
         Et1D36uAizulInx5Jkq6UDCMhXjDJORxMHZIMM8Givzo9kK/3cmNLUGi0TY/r1JFEzzi
         rL/i0yFxoW8vCpDlnawksaYtNxOp7mQ723A+0jcQqXdEM1PoDZPJQSxh/hYFoJTc5fXr
         dQCoGLhURt5zdbAs6vax6LkLXx61/PkTp6NTpBKGOLYnc+NAaeEPsD/a2IfLtlDIQw4w
         Pq6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpwVhwbSHl1RCpsfB6qV/krxiTz9paS0Z06yzNMi0Pi7PWXuDxDTO2Xu3wmuujKCtPHxdLfed0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRa6+6SgPCcEeBc4sqb15ugEfrmiVSpBllwQDT505rWttjEOn
	1mjqie5S+jp1MD5kxIy7caq+rPuAU43BV0dE6Mg7y7IgjA+qx0hlnMlt
X-Gm-Gg: AfdE7clF0INypezsoIR/xsWIgTRsNgQ3VP461YkdOrNAvcT2cQzYHEDCK0n2A4UcAIC
	r24BKOF1ahzu3wTi3FBd/U9ov1y2YaXtaPfPUgapcqUgfQZpmoNZj94JAdxtKNW7RRlG8/jt9rQ
	eKmwm73/qsCzSbVjAMlyVee0qg6ohSgeZtSbJF2ZP9nlvEC70fPNWyIXW5IWAyc8sjMNtwFD0gX
	mchACHEUBs/7bgEld6svUrJSLIpQemuLRakJou9uERmC1Z2Ec0uVOOXdIM5zGCIkj8xahESSXZV
	6/qeIgvNjCWEe3GFCQvGxDTaYH6WhCIVzyYtLLfNkiR7jc0ea2iyFHAvwDPSDL6FJI+S08bQMit
	LWZtsqxQPmqKNfFW783z7RUp7zNJl09ZlYpmOepiY1YbutBAgpa0P6GmqCS2YAdzBmE46KY+aFX
	Lay6g6OeBnldXdTG2R/z74aA==
X-Received: by 2002:a17:90b:58e5:b0:36b:9e24:c692 with SMTP id 98e67ed59e1d1-38942f73563mr2056426a91.20.1783508882198;
        Wed, 08 Jul 2026 04:08:02 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d229a20csm2570824a91.16.2026.07.08.04.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:08:01 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org
Cc: longman@redhat.com,
	d@ilvokhin.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v3] lockdep: fix NULL pointer dereference in __lock_set_class()
Date: Wed,  8 Jul 2026 19:07:55 +0800
Message-Id: <20260708110755.1636112-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260418141450.1499057-1-gxxa03070307@gmail.com>
References: <20260418141450.1499057-1-gxxa03070307@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Gao <gaoxiang17@xiaomi.com>

register_lock_class() can return NULL on failure (e.g., exceeding
MAX_LOCKDEP_KEYS or lock_keys_in_use overflow). __lock_set_class()
uses the return value directly in pointer arithmetic without a NULL
check:

  class = register_lock_class(lock, subclass, 0);
  hlock->class_idx = class - lock_classes;

If class is NULL, this computes a garbage negative offset that corrupts
hlock->class_idx (a bitfield). Any subsequent hlock_class() call on
this hlock returns a garbage pointer, leading to memory corruption or
a crash.

The other call site in __lock_acquire() (line 5112) already handles
this correctly with an explicit NULL check. Add the same guard here.

Fixes: 64aa348edc61 ("lockdep: lock_set_subclass - reset a held lock's subclass")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 kernel/locking/lockdep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d4c5bab5af8..e0de81114824 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5437,6 +5437,8 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 			      lock->wait_type_outer,
 			      lock->lock_type);
 	class = register_lock_class(lock, subclass, 0);
+	if (!class)
+		return 0;
 	hlock->class_idx = class - lock_classes;
 
 	curr->lockdep_depth = i;
-- 
2.34.1

