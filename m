Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814214;
	b=URHzW0mVzzyycBYgl2SpXzEJBTVgb4kjlFQGC8G4P+oMWT5m/GBvZ6i4RuYKJLdWYfvn
	 AUlN6LBRVkoRuYZXE1OwAirlv1mYbEC3RW1PAhlL+12MFI6zkEfJPrI6YLRVNT7I0RAKH
	 iCALhjcwBkD4AdtXg5hBiZUzDCfBwu6Y9FuI5ZZlDQKRPyKhi2h5v5MIQkn1y/RQkT1L0
	 UWwXAKDTNrcSMGnNe5PK1jEp2N/Ownxh1fNBoHBx1hMrk7Jyrfy+xtZji8KhGgcGANsjf
	 yRorrat1BjWBhFUUm+zjLkAgPTZwiK1Pf1qhSBy69BPwV1EonqBT42Oiu7+E4Okj7+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QmLSHEUIlzA6b1Z8wErarn2CLIxesBi7GU7DAVJa58Q=;
	b=QPhPHsObT/zxaS6XWkulqfyA6IK5YELPvi0S+n14r7CY4boT3xWYEK1jGsASXg7xxNTY
	 /RyXMffI3XTGCx/6fnd5gWiin/1X2XpUZcVoUIZclQg8i7YpoqVR7l0pzWv6QOTpvQzKQ
	 qB9YdWDOdQMwJiAwA6pIZcC++A5dIApIfjjJvr0shwD3koFiuq4ksEsn7P3yt08kXsm66
	 66j6R3lJjJmoi4Bqn/W9GQjXzXv3F/rt4hvuzXaERsUHwGaXsR/8gE3QLgygquub7FHC9
	 1k/pPLU3GQ+wVhF3d/jCBfAkEt2xTLnD3eEgGZJg5vPYtnQlGLyq15EjiY3AwdZEdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=GWXPbxaZ;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DA606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A00DA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=GWXPbxaZ
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f488ba6e90so338540b6e.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792814212; x=1793419012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QmLSHEUIlzA6b1Z8wErarn2CLIxesBi7GU7DAVJa58Q=;
        b=GWXPbxaZfIlF570IH3NjtOMHKT5q0tJsRhdbgvH0qPd37glkoO169EZbWvInzeLaVW
         y4nazItapdO6NsIJBsQgFvTj7Pi/4N8XapG3/8GNXuKnLSFHij38dMxI/TdOQiWqidhS
         HW8vNzSnm5ix+/fxpVJyYlicd+v71ya+MWW6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792814212; x=1793419012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmLSHEUIlzA6b1Z8wErarn2CLIxesBi7GU7DAVJa58Q=;
        b=vntAFUoaWRUEFkguGKvLLAJX74BnjrJN7PwkGzKcF9CxN47vf6jMHTR+cXKjV+dE5G
         3xxwUC/vx7Fm+ubxJ8YLYQooL3dm5snvqiv0PkVoZgdzvD6pJmzFmk8bnYGqdg3uFBPL
         6+NyHn9FO3iiTvlo6xgDXEQ8k3KZFappav6GPOtT+l+3rnuelQo5JJz702fOS/hdxfBR
         8Wxz7h3IorGR5UJ8rG7mDHFbQxYVhcUqqZxvM7c97WUrXQ7pnM+dLslvhYyHoQnSReia
         4RR7M8Qar1hvDZpWRXn/HT9gWkMuSS8VjvUIQIuDM28kUdTjSVVDBWymXWS3u7GjBCR1
         N3xQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjQVYI6KEa71CekuqWvutpu1CF2MC0SFV1u11Fz/zPZsR6+EM33JdQl+J7R3nyZ2VfyjK/+W4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI172RXmCUzcXvFN6fRfJ+i+uO6KXfn4dZzr5b14CN+slG8wnpP
	au0rs53v/SiI4ieEqxfaQBRBV6Vgs26UefBG9/hU4AR5apyUwrSdzZ5E/3evMHrUVU4=
X-Gm-Gg: AYBFou2/18P4ef439/LnhP7XnDO98jFXc39FOHUQpGa077iJy9fRm2LTPIkSQVwpn/A
	EkxDKPP4KFZ1vciefqCd13i4wWSlQ/obD2JZKuYq455LfHM8mozW7RJF4ZrwR5Xnbs6YxZ/0Dm2
	OkPBCJopltpmYoQnMrHSvJcPI0jaXg/NoogLlYqmNXzoYeMQx6Q/N7qj/4gf5OGiMdE7DD0hxS6
	M8a0aQhjwpjdspBByhg3DvrNsf7j8hwzC+7xg2X/+q6UmQxYbZemnX3+CoyXnL8uDxsqOM0JnkK
	kvofvJEu2S8FsMPAzkxNJIBR2D7cWoXQ6scVYgSmNvfFVcBIhvO1meCV0wS8mfvYicPhli7J0wz
	n3iEaXAxq8TIAmMDXGuoSdbIN67C9AoK9hXQxEArnE94CB4vjzxTRrcWifCNMRtcFtOQaVCGtNY
	uG2Gr2wjCLqM4ZGJCGf1aBKYtgG91xUsEuYE9/me9wUgQbIoCulT0bAHLRTejFbhVHmkFh4q9+H
	nWD2AYqtSdl4OuO1NjyrqtLlpBiD8P5acIpluGz2k/AIX4EbRXmzhugNja/3+hPrTbDln+2T/1o
	eIpwSM5fyxjqhhUtF/eyQpgVwxoMb0+K1WqrNypFs0XvKz5qB9ZgDQWa
X-Received: by 2002:a05:6808:309f:b0:539:dfe8:9960 with SMTP id 5614622812f47-55c00335864mr1018155b6e.56.1792814212486;
        Fri, 23 Oct 2026 20:56:52 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm649076b6e.9.2026.10.23.20.56.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 20:56:52 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: pin the mm during PAGEMAP_SCAN
Date: Fri, 23 Oct 2026 20:56:46 -0700
Message-ID: <20261024035646.68348-1-kylebot@openai.com>
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

A pagemap file holds an mm_count reference, not an mm_users reference.
Unlike pagemap_read(), do_pagemap_scan() does not acquire a live-MM
reference before walking the page tables. Its mmap read lock does not
exclude the first phase of exit_mmap(), which also unmaps VMAs under the
read lock.

A process retaining a pagemap descriptor can therefore race the final
mmput() and access resources that have already been released. In
particular, a concurrent last userfaultfd close can free a context still
reachable through a dying MM's VMAs, and unmap_vmas() can free a shared
HugeTLB VMA's lock while the page walker is entering down_read(). KASAN
reports both a userfaultfd context read-after-free and a HugeTLB rwsem
write-after-free with unprivileged, read-only PAGEMAP_SCAN requests.

Acquire mmget_not_zero() after validating the ioctl arguments and keep
the reference for the entire scan, including across mmap lock drops and
MMU-notifier operations. Return -ESRCH if the MM is already dead, as
PROCMAP_QUERY does. Balance the reference on the bounce-buffer allocation
failure path and at the common exit. The pagemap file continues to hold
only its existing mm_count reference between operations.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue.

 fs/proc/task_mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..d2cee8dcba58 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3235,11 +3235,14 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 	if (ret)
 		return ret;
 
+	if (!mmget_not_zero(mm))
+		return -ESRCH;
+
 	p.masks_of_interest = p.arg.category_mask | p.arg.category_anyof_mask |
 			      p.arg.return_mask;
 	ret = pagemap_scan_init_bounce_buffer(&p);
 	if (ret)
-		return ret;
+		goto out_mm;
 
 	for (walk_start = p.arg.start; walk_start < p.arg.end;
 			walk_start = p.arg.walk_end) {
@@ -3294,6 +3297,8 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 		ret = -EFAULT;
 
 	kfree(p.vec_buf);
+out_mm:
+	mmput(mm);
 	return ret;
 }
 
