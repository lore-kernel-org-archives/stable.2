Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F83A7848
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286581; cv=none; b=ohscTTLRqh7ERCccof9jd+Fp4X/uITFfvZAaa25j8nVdrFV08JVvNtrmnzkGYSp32xwo8VVESF04Lp5S+PuTi4Vi5Bb7kQuFyPBHQQLC7QrtfmBPkNPjWsADPS4q5XjOcfbA/JFOFIE4JgFBxZUg0cFOxlv0XX39d8OpkkO3pJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286581; c=relaxed/simple;
	bh=Uyl8fsKqF2hZuM9YDMoKvgjEFiqVl+i1dh3r2f/VXKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vi2XKSZZGKmubnHw04mnt2OBEo/bXn0iE7jZBeb5eznUJLKjyb1sHaYq06seuLFxY8V69Bv9cZbpd2p/F5WDLf8MH0F1Cg8cd2IJI8op45jEx7Ec2fB49EI3mIoc49a9nDEr/GL3AbY5r6gMfTIfyHUDyvl4bREzhoN8AyUuqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a01933b584so5395615e9.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 04:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286578; x=1791891378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndzzUuEtcbTKrn4r7tACpiIJyXYLhlhQwb4ACs5k4Lo=;
        b=hyXXBg82ezezkxwnJgS++CLKXm4TpcMiUSfuqqqRLrV+fa6Qt+3jHb5Fv7R60NSxrm
         TF0cuLnZP3RGT8eQbX6DSyJNbq4uf3/TljzKuI8Jj9i6g5FcsbwGrNfpWP0Jw+tzjl2B
         Q96eNZ9oBkl1OhR/F2kLPmt2/8MXTQBScOTkIOJviI0M0mxzVjOOOJTgIKVwvLLlAR7p
         FmPseIXWafx8qanS/T5GRnHGvJN9kJFbaLkIuI22EUNEGsgPftqRhiJ6WBQNHBHXtqgO
         63CYIcJEYwfBSIQFrtyUrR1S97c+QQTNmVWnVgcY/YXRYKrjvyBLu3k81t5GPaEwVr7E
         uulQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjvFPFk/QJXRXbBiwYwYQv+ZYRl6/ooIqhTdAYqaBd7tuTLqGXNd2aEPe3OfSWU0RBAr/9MhU=@vger.kernel.org
X-Gm-Message-State: AFuF++m6boEPFqKkCftdrOdhBZzLeXXNoxP6ksppmboxfTeLkBPzGUQp
	VtdbGb+oQ4BIV7z4LyldcFaeT/x8RgW8tQhiFEwBe/712Qv2qkaKqhRkpxO+E9SxoR4=
X-Gm-Gg: AYBFou2w055+MBgZBkk1b9sb7QaFnkuQSCpBqsusGQCZ/emK/KUMMNEs0sXg3Q3DFv+
	7ar5NerKGyYKwZ+xQg5dXiakK8spKMCizGjz2wQPX5Wh59heKBshbARv9aNXSA+CNRubvFCPrZJ
	egR5rXi8ijCuaLj1E/LKXKbVoX96S9VSv45INWoLW1MqetiG9bQTClxzRonA+sz9jctszkbkoLz
	lpuMoWjoJBm7sIB6tne/i51yL5f2VVooSzELlAEMlK874N6xaCuDzrAKxhBjaZ5JD3Txwrq76jW
	cvZ2k7zODDJdtwS5Ls3+wx3pvg+Hadu+ihi2QCYq2aUrvT7EY6GK7HAHh1NOrj7sLfSsqBTkuXl
	tCo+knzl2xLw1SZJVYMPcbASX/pDHjuRUV36CbaIjIY3ytaPoSE/JzdqjVHviyYKswO6J/msupj
	lahYyFP6Uu2fkxm6sSwXO/oahD/KwpgneUO2mBYMiVtE0sI9yrE/9CFBayJzyTW9WuCP8MBBBU/
	2XRPO86pMxO3yjtQkSos+Ngcc4=
X-Received: by 2002:a05:600c:1c16:b0:4a0:258a:8de4 with SMTP id 5b1f17b1804b1-4a17b4f410emr22540365e9.4.1791286577693;
        Tue, 06 Oct 2026 04:36:17 -0700 (PDT)
Received: from white (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a178c5d8dfsm70158865e9.14.2026.10.06.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:36:17 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>,
	stable@vger.kernel.org
Subject: [PATCH] floppy: take floppy_lock when rescheduling the timeout in queue_rq
Date: Tue,  6 Oct 2026 15:35:47 +0400
Message-ID: <20261006113547.2099599-1-efremov@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__reschedule_timeout() expects floppy_lock to be held. floppy_queue_rq()
still calls it without the lock, which was fine when the request function
ran under the queue lock, i.e. floppy_lock, but not since the conversion
to blk-mq. With lockdep_assert_held(&floppy_lock) added to
__reschedule_timeout(), the first read from the drive triggers:

  WARNING: drivers/block/floppy.c:671 at __reschedule_timeout+0x180/0x1e0, CPU#0: dd/561
  Call Trace:
   <TASK>
   floppy_queue_rq+0x17e/0x300
   blk_mq_dispatch_rq_list+0x3e9/0x1f30
   __blk_mq_sched_dispatch_requests+0xcfa/0x16e0
   blk_mq_sched_dispatch_requests+0xd5/0x1c0
   blk_mq_run_hw_queue+0x341/0x670
   blk_mq_dispatch_list+0x50c/0x16f0
   blk_mq_flush_plug_list+0x131/0x600
   ...
   blkdev_read_iter+0x2b5/0x4e0
   vfs_read+0x7fd/0xaf0
   ksys_read+0x12a/0x250
   do_syscall_64+0x106/0x5f0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Use reschedule_timeout(), which takes the lock.

Cc: stable@vger.kernel.org
Fixes: a9f38e1dec10 ("floppy: convert to blk-mq")
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
There is a small ordering conflict with "floppy: select FDC before arming
timeout work" [1], which moves the same call below set_fdc(0). I will
resolve it when applying the patches, so that the timeout is armed with
reschedule_timeout() after set_fdc(0).

That is also why this patch switches to reschedule_timeout() instead of
moving __reschedule_timeout() into the floppy_lock section a couple of
lines above: there it would be armed before set_fdc(0) again.

[1] https://lore.kernel.org/linux-block/20260504032853.316099-1-zzzccc427@gmail.com/

 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..5bbd385f837c 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2872,7 +2872,7 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&floppy_lock);
 
 	command_status = FD_COMMAND_NONE;
-	__reschedule_timeout(MAXTIMEOUT, "fd_request");
+	reschedule_timeout(MAXTIMEOUT, "fd_request");
 	set_fdc(0);
 	process_fd_request();
 	is_alive(__func__, "");

base-commit: 22430ae5d90ab288b0ee2ad99ae941f4a666b694
-- 
2.55.0

