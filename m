Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B330CD85
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746028; cv=none; b=ZTKF9IeGgBLylRroffVZSIGf6lwUZQy5AVtDqdSsPaROs221kNaYdgLxl0ZMKHxuSsk+bZXPaCqc5m4FBuK9PYvzMMTXoY4USuFHUBInbvWjD+PJE/2Bv4VBSLSGspc5mZJgCteKtH5NxDKpLrdcmqKMhcXiToiVMx482Ux1pU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746028; c=relaxed/simple;
	bh=w/YqicePv7emVd0mcauY6NNDXMttoi4zTr3TxZ0+Bv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDu5c/gZTUHpCYj47y/PJy8XUoD8Orm+t90x8lmd1i6acDnvfMeOVdMCpSx5KUc3z6mg5GGyJBwxKZ3u9ga0Vv8xQyqDL566COEzQ4Hc2vsPksXDySAgvBHrw5B1QmyWq4EL6C4mV5nzLxACPoFHYtNGJH0qTid1dskPiW1W0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV4+mZVk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV4+mZVk"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1350467f8f.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746025; x=1787350825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7i9VfPYGddFq4sUtK22qI3FlKr+Eu20bYiNUQXZ9HA=;
        b=YV4+mZVkTEQYoVeER0MOmyYHF9tYO88svVr02aIrHBBXiSh9stSG4X4BoAjB/M1E95
         0ntjE8MYRgCiciQ8WGpYLvjLPcab5Y8VQg4czZlR7m+HelsnEQmfcGVepxrEjWSYyBgt
         jrVtZBYJxmGYEPd0+X4KHiJo9aR6QMBKePmUsS8U9LY/hnCjcwgvG1ZVDUyQ1nMTedY6
         13c6Tun5cIEfGfM8d0iYBie7SNvBrZfWDvWvrew1DODxi4LxY7KEa5zSmMwizkvfyiD7
         Qn7aT1f+wFezmX/3gLQGj1eEOuWj6AHTxJ0pGo3vEUoL8XdJQufha0mpQfsEeI37EVq/
         Dn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746025; x=1787350825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7i9VfPYGddFq4sUtK22qI3FlKr+Eu20bYiNUQXZ9HA=;
        b=fpOdgiw+rtFT50t2UCN6JU5FHC+4xUowlKgiJxys42zUjPGTuPmNtJASn4UR1GkiAk
         uqo/ipLdWjZfe093ndsTRXH6OM3HHafcF+h/oKL9ZmYKiasYy8qTdRkXT0+JcObZHm+D
         /VYM1gK43ffwdRSDAOVg2kRwsiaqx4Qose9OuWAee86U33Ln5dx+S2vxE9AxQ3bDxfpX
         pWpK+MmyG1y/98LWC+2H60jfEKl6CKDS1d1GLUYEUK9D+1Xh6pWF3S5Q3SYxS1dgdWvy
         VesbIGeg+ui9RGZOl26fb4+V633z04Jp1ZRiwBLQCNHOwdTpIxmGy5Ki0QqJjzewqNo6
         6F6g==
X-Forwarded-Encrypted: i=1; AHgh+RoCnE5jfqeDBoYIjO6xwS02nSdizD9abm9LrNtnArBYZx+XVO94XrDas1B5Lfr/C68oha4w5kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTCuKZlb6rBm3ZwHW+nhF/Szs/5BsfplVrKe8XYZvHwxjcm5n
	TgZHLRZrvwevnPnYLIk4hKK55ZvrqND7OhvWS9UmebM3FwARyovbmEE=
X-Gm-Gg: AR+sD127b+tAkV8ohgJYwk4BOxWZZbSgVuIpnklxljBT+h6UeAK+RFfm2WMigQ2kMEs
	CB+M+Y96w31gnGIw8Nxu/RqMcgZCII2kYZs321OAnyIY828GYezOcCERXXq/k4aOR5oUJ/OZAfA
	V9z4nQ05qLv0hfCHDQHL3G8Bqetf4Y2n0f6ETT8XO5xVekILMAWzuhi7746w/UI9AZz96w1oENF
	blP2yP+tXkZn3d8EYLQwDWlpo7StnPrN/fd/l9L+Tuu7Z1PSMhNE+BQqTMphApDInAW1GkjEmhB
	Brxyc0fXZcSJcF/YfgoEuHqhCe8JFKcrOWbxJaf9GDZNo6CjeoiJ+EdXrosQpfymo+K3O4Decml
	pCCc+EyJvHQ5LJ9xZzi6l3qcsUkqVVcs48yiIgG51Mi8rkG3y6yjT3SjEq6MgL83SPUK3vcK1Cs
	vsr4F1RcRQI6P4KIs8gvtE7GUe3uZl8Q==
X-Received: by 2002:a05:6000:1844:b0:47d:fc20:e7ab with SMTP id ffacd0b85a97d-481607369bamr13831202f8f.4.1786746024753;
        Fri, 14 Aug 2026 15:20:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f1ffffdsm11219222f8f.2.2026.08.14.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:20:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] profiling: don't free prof_cpu_mask on init failure
Date: Fri, 14 Aug 2026 22:20:19 +0000
Message-ID: <20260814222019.3054116-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

When profiling is enabled at runtime via /sys/kernel/profiling,
profile_init() allocates prof_cpu_mask then attempts to allocate
prof_buffer. If all prof_buffer allocations fail, the error path
frees prof_cpu_mask but leaves prof_on set.

Since profile_tick() runs from timer interrupt context and reads
prof_cpu_mask on every tick, it can access the freed cpumask between
the free and the next reboot.

Don't free prof_cpu_mask in the error path. The cpumask allocation
already succeeded and is small; keeping it on this rare failure path
avoids the stale access without additional synchronization.

Note: mainline removed prof_cpu_mask entirely in commit 7c51f7bbf057
("profiling: remove prof_cpu_mask"). This is a minimal fix for stable
trees where the variable is still present.

Fixes: c309b917cab55 ("cpumask: convert kernel/profile.c")
Cc: stable@vger.kernel.org
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Added comment explaining deliberate leak (Andrew Morton)
- Corrected Fixes tag from 22b8ce94708f to c309b917cab55 (Tetsuo Handa)
- Added stable-only context in commit message

Changes in v2:
- Remove the free_cpumask_var() call instead of adding a prof_on
  guard in profile_tick(), which still raced with the free (Tetsuo Handa)
 kernel/profile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 984f819b701c9..dcb65a2501558 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -123,7 +123,14 @@ int __ref profile_init(void)
 	if (prof_buffer)
 		return 0;
 
-	free_cpumask_var(prof_cpu_mask);
+	/*
+	 * Do not free prof_cpu_mask here. profile_tick() accesses it from
+	 * timer interrupt context without synchronization, so freeing it
+	 * while prof_on is set leads to a stale read. The cpumask is small
+	 * and this error path is rare, so the leak is harmless.
+	 * This code was removed entirely by commit 7c51f7bbf057
+	 * ("profiling: remove prof_cpu_mask") in v6.11.
+	 */
 	return -ENOMEM;
 }
 
-- 
2.47.3

