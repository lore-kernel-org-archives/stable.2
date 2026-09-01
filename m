Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182C3AAF65
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263314; cv=none; b=JuyNakM47CsLdcHb69t3Zo2K7C5aSFnX6Y0XL+G9w2WHZ+i0e8P9wNTmlQo8TTmlIm4xQhFW405r3bbOCSn7GTWpOoaoLoQfg0ufhmPLmBlPYpb3dajEIMM3HMljdoL8xMkmmLWwbxX2QECiBzzvNv0Qd22qDef7AM6uReXUS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263314; c=relaxed/simple;
	bh=EmcvMgWnU+eynTHcQrpUKhBCbJysQIL0DcglZ59zZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9gyzaEg/e6i15Ojy0GlQm9vJswnbtVLgp8E9iqMDZXmNv3p4y8BlQG9lPZPQbMm9m7I8GKZUQ8LZ0pYeQMXZRO8MqKlRFwfsDl3DOQn4NVvliLIqSq6Ah8gX8c6OZvQeJDjyvllnB5nISCOGGbJ7dIceIfAHTL9rC6MNoXttlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9nxtXlG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9nxtXlG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85377c8bc96so4352871b3a.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788263311; x=1788868111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lc63gXB6sWM/VXbWlt8W410Sjt0Osog05aJqYWSF9g=;
        b=m9nxtXlGQt1JJtyJxV0lPd3kpo0oNfFXPTf+5+n2KIj/z0CTogp6aI5BSr7ZUk0sZQ
         Rrsj+nHwPrdt7XnIV4goWnmkuL0D7W4O554RWyChElP+n2mGyKdJyX1kdFZUjmQJKWcS
         1ydwKFApR2GNqrrW+JjPOb9dZ7PmDcmhAZ2d9mr4Yl2IW8q5FEFvUIk5VC2AQZCTMyJW
         gGj7yOIUH8CTvXnD+pLL87/dXHYt4DXaKZnu9Qtlmq3Fe7pipyj4iIhYJPA2rX5FPQku
         uJeZ6hgypMPz15OfiM3hGZb9f/QnUfmDlA99E4TMwUL4LwLyjJ2XsmINEynuesU0T3Gs
         Nimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788263311; x=1788868111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lc63gXB6sWM/VXbWlt8W410Sjt0Osog05aJqYWSF9g=;
        b=D7ntfk1qD2klCQS8vvAkV5cC9KD6YR03hMdK8zADL3v4k9ATpJOI0eoxwAZIVFzmbY
         /9IqT4LakL5GkVOVTQ9njP9nogrkIcz53I1zoBlytlzV3Z7v2jlMAB7+Q4aJ5Q7E2wZJ
         e6QV1230zdamPfArKBdu7Xj6mF8csCYkxPNvFQrnV7QzcKQ2ZFGhTxLMikKhYomaXuYI
         XIpRpwRjmCvn4gWRLhJZCza44dJd1HkbgxyrdjwzGcke4/WPAYP22Tuk2MV+LZNF1/5L
         WQGL9o12SEYNBw2QNqKZux9LFNzKnYStMo0SE6fBSc36lkn18iJdc6TJE0OcAW2RVeiX
         GhlA==
X-Forwarded-Encrypted: i=1; AHgh+RrWrWq6H9QeNNA+EsUfKYbIx0sLiHNr6/jXy2qk7+3/K+ZQvOhJ7gMseDiH9NWbai1TMtXEP2s=@vger.kernel.org
X-Gm-Message-State: AFuF++mhyPFLSm0ahZkPpq3J8Y5iN23u7e73ZMQ/xBpSesF6tgSNjq4E
	ZVnJyVI2l6wY0io64FbFLhUbfpf9rffnkDxdIG042Kl+tX9pvrsk+S0N
X-Gm-Gg: AR+sD120mogMIqbldiMVMwawWSF9FSMAd5Eyp9kiKj37Jn9NESQsChZFOjT5CoTkzzH
	VPI2/DH1j+sm1hVAGI+GxJ9QHTpCqNteXikPQDMjE+wNbJUx6Ch1wuEi/gd3uAMaMo/mgIKUCy3
	t38eQoPCv7lWnZL+OfyWSbgi4BpQKslbjx5wd/Ak8aQYAwfHfpseT5ZJt9p/TTfDG0NWOXQ6E7U
	DbfZjmzmw0WkVX6Ek7M7PRXzWHDFz4aEtVyqw9myQxc3TspZlv9w05YK6ZmxwfJtS2DuKxbvnR8
	anVdAb39KIItcKzYlcOMWPF1uyfGb1/YEQQjFIylVdl9aJerNGRPVORxCMHsf7TOHuNvZt/Omaj
	NEZLW6+g07Iip74ldhFbuCuJzQ7qTyhnkYgPkmvQ2xrh7EtwGnDmAXdGJ/rX/X4xC1Aox/a9+CD
	Ar/sGXjoFoUHWefwmfVOlJvMy1g1UGgDE9O8Euhw1J8dl5/JBjUduijFNXxjinEY0KHjhhTD1jF
	vrpEqEYTHhmhhLwIwj93ZWLGdQVXa6kDnqf
X-Received: by 2002:a05:6a00:368b:b0:84f:5cd7:e3c6 with SMTP id d2e1a72fcca58-85628f66831mr53111920b3a.5.1788263311225;
        Tue, 01 Sep 2026 04:48:31 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be8d68565sm964610b3a.38.2026.09.01.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:48:30 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: Hash lock addresses in rqspinlock violation reports
Date: Tue,  1 Sep 2026 19:47:49 +0800
Message-ID: <20260901114755.1165703-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

bpf_prog_report_rqspinlock_violation() prints the attempted lock and
every held lock with %px, which expands to the raw pointer value.
The report lands in the program's BPF_STDERR stream, and that stream
is readable through BPF_PROG_STREAM_READ_BY_FD with no privilege
check on the read side: prog_stream_read() only validates the fd
with bpf_prog_get().

Any user with read access to the program fd (a shared fd, a BPF
token delegation, or an unprivileged child) can therefore read back
the raw kernel addresses of the rqspinlock objects, which are
dynamic allocations whose placement depends on KASLR and the slab
layout.  The verifier-facing log path gates pointer printing on
allow_ptr_leaks; the stream path has no equivalent gate.

Print the ptr_to_hashval() hash of each address instead, so the
report still allows correlating the attempted lock with the held
locks within a boot, without exposing the raw addresses.  Fall back
to printing 0 if hashing fails.

Fixes: ecec5b5743bf ("bpf: Report rqspinlock deadlocks/timeout to BPF stderr")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 kernel/bpf/rqspinlock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 111ec80ea958..5721dc1a9577 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/bug.h>
 #include <linux/bpf.h>
+#include <linux/string.h>
 #include <linux/err.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
@@ -673,6 +674,7 @@ __bpf_kfunc_start_defs();
 static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	unsigned long hashval;
 	struct bpf_stream_stage ss;
 	struct bpf_prog *prog;
 
@@ -681,10 +683,15 @@ static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bo
 		return;
 	bpf_stream_stage(ss, prog, BPF_STDERR, ({
 		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
-		bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
+		if (ptr_to_hashval(lock, &hashval))
+			hashval = 0;
+		bpf_stream_printk(ss, "Attempted lock   = 0x%08lx\n", hashval);
 		bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
-		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
-			bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++) {
+			if (ptr_to_hashval(rqh->locks[i], &hashval))
+				hashval = 0;
+			bpf_stream_printk(ss, "Held lock[%2d] = 0x%08lx\n", i, hashval);
+		}
 		bpf_stream_dump_stack(ss);
 	}));
 }
-- 
2.43.7

