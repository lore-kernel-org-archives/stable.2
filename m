Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423623;
	b=hi+XWvJsQzdDY0o/32AqJcESZIoedVvKYxBOO7BcSAZlv0hWLBIk5BjS6wW+7inHzKiT
	 kzyuxAQf8qobKrHL4JU+59shVoM23w5m4aQvpWNV7keWkny4AB/hC5DxUHzhxoPjmFuEH
	 tVVMqfEH01K+2CCFyu67RtOrlsPCIyEDfGLyNImd2rOWIu6okbGNeGkYqOspfRuK1GaN2
	 cbZZbFMfL0/tZ/eO1KmK46tZ2/NzJq3mRkKasY5v3rSth7MMOuS4PhqDwpDUkQJMj7/cS
	 qShaz4Ty6OO0G4S2pbVCeMCF9RyFi7gqrLP2cpgoFf9dAd5sGgwpZoVP7WB35nT9R4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xm9qK57iibUFwPkHb0+uEz3ll0FQuAb6bGI1ruSxhhE=;
	b=rxoYjs4+xqz3QrQucBGl1Ls0+S1r6tPca8pHR3g/6j9wRrWEufFLcSbrkl4bn11OtLF4
	 7RpG/5PcskMxOkk/YKzFZiU9IMdISkHYSkIPVFlEbd3HfZXoRgpl+Va8JUGK67iI+muHN
	 Us/2ohkpoXE5wBZebzvmwvnu+jNqGlw4x0gPQnf/gDyCvcHmQp8KgeuDrEJmOTuQGwqwU
	 Q7fPf6KRB0hxUl5ZxpD0ABMfoPC2eH2yqDibzTWcdOsm0VIW0Tr826p4rkQwdcw6/Jx/H
	 J9Y/02AKewkoDgFHfuwWLWghVJ2LxypFs9j0POkPpU1/P1xRSZhud4olJ8sMYYNMA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JPC+/c30";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F5606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 05:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JPC+/c30
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso525451a12.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423622; x=1794028422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xm9qK57iibUFwPkHb0+uEz3ll0FQuAb6bGI1ruSxhhE=;
        b=JPC+/c30XvM+AfKMmBz/VDN7Gir+Jnht5675kIV4lXshWC8EHGd2esTDByz/nABc8I
         f1u/x+JlkfUURWB/zBknNY4WmUPBHz1bDPS7mNVC/aScSvb3vuSEJUu9Y/zJA47IQaJ+
         l6nH/mc3LsPsCWPJnoVii8Lf5ZG8UD9tqcoInJ0ARdmgTQ/GVHuovpuwjFJ4os+V5bQu
         sNglM5uoe558zr43P+XnOd8YHRfpE2DmBMw7FPcKywmHeaniV80f4ZYi7sBZHHJMKpYu
         wzkwBJJW5YBYZoCk9/NY6LZRL2v+2sWoWFrfJHhZX9L754kOd+5eMi1gB1WKm763ZWZ1
         kNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423622; x=1794028422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xm9qK57iibUFwPkHb0+uEz3ll0FQuAb6bGI1ruSxhhE=;
        b=NT4kUEI8tbFSmNF6MYch480v15jNClRqflr5YnKXCW+zruzZaYylJMoZjCUOv82RsJ
         NpwJN7TtB2orCVvCXk15nOWcmSQdrmXe4sWT59pbiEIJFbCE8m6TJlHICRYnrDPDlOF5
         o8if9+ISAyFv+mxfn7qMHoCyXnJj19WDso2oEbY9656BgIxJH2gzdTUYLGWLxWx3Ck8G
         RDzDFLbkeSltUn+BXEpSmBK7vzKTGEwI1qzyMJVuLZBUbOEVFahdMd+V+EvpS5HuVfuL
         iH6/nhMzSWxTx4pit+EGA8XWjUU1lGrWfuK5ARiB02b0ww0DblkHeNWoR6K1pXAObm3G
         /ctg==
X-Forwarded-Encrypted: i=1; AKwUvBxMcqsHeS/aNfMDw7D7F5iDuKsFkqSGzIFjXjZqD3u4/2Af3YHsPvhnMtiYvCwOMijA4xga4xg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR/QBbgjmp3ywaVgKXN7uSitf4xlMXgLLhj2P6q5NpB3V/PTCk
	443k/nv+evJXM5pe1WjJy8EgWvSXcsF4VvBrVHgscp7rsUssXiumdsIjKubEfsjrt2bQUA==
X-Gm-Gg: AYBFou1kREIHrx4hJS8wF4S67kZbIS2stD1FhwaRKpfqiDTCH+yvYUgjGL3parJjuF6
	wpg75tfn3I/qVR//EB+2Vsox1UaMH+AtcDOvMhtb8j21jZhKQ11cejwaZmHK/qwOXzKh3JhQmGC
	NfUNyogEOClq8xOglgacf862DmEaJ7X+Fi9HFB+MD4uNnNj9Sxw6XtzU8CCc7GJvO/4WiOX60IJ
	RA1ix8s8UvxcJpQpl54PL7cMghwoOFpn/FsRWcr88gd6IuDD5nW2PcdkwYWTQLcVtvjXoFF5h77
	wJBy5eQdU5nVDK656xjSF3/tYKaoxXYK6Gc/VT9DfGDBoxbeMm/xSvwP6G4aBiZW10YHHlG8LFV
	xLUovxbItHXuUHk05NPlRZIVbJn+pLgVn4Cgp6b/Rb27gh//JCyU0MhxVXdywk9jP/pJFg2k3Us
	jc8BimJBANdRj9Gerc72qw1VbI6OEc3xb9Kos0WhCNaxSMbhCJcJo+q8l2DgROXK/FOUG/+Al0Q
	trX8br92xxh+xcf35Ylt9K2Ev1G/WCKxxBtpvKqpAWuJPJeI8X9IlCg753eHN6vKqzEcHISvglm
	OVMZ8NzLf74+X9RRML9mnYsM
X-Received: by 2002:a17:90b:3c08:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ae897a64b7mr3802893a91.52.1793423621840;
        Fri, 30 Oct 2026 22:13:41 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f5dcc3sm3229860a91.3.2026.10.30.22.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:13:41 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ocfs2: drain fs_state readers before journal teardown
Date: Sat, 31 Oct 2026 13:13:35 +0800
Message-Id: <pm-ocfs2-objects-candidate-0003-v7-1522d068e5b943786c3e@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The per-mount fs_state open callback formats journal fields through
osb->journal. Its debugfs active-user guard protects the open callback,
but does not keep the journal allocated after journal shutdown.

Both unmount and the mount-error path in ocfs2_mount_volume() can free
and clear the journal before the debugfs subtree is removed:

  fs_state reader                       Mount cleanup
  ---------------                       -------------
  enter ocfs2_osb_debug_open()
    ocfs2_osb_dump()
      load osb->journal
                                        ocfs2_journal_shutdown()
                                          free journal; clear pointer
      read journal fields
  leave the open callback
                                        remove the debugfs subtree

Remove fs_state before cleanup releases its backing state in both
callers of ocfs2_journal_shutdown(). Debugfs removal prevents new opens
and waits for admitted open callbacks to finish. Later reads and release
use only the per-open snapshot buffer, so they do not need the journal.

Keep removal in the caller paths while the per-mount debugfs parent is
still present. The remaining debug files retain their teardown order.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in ocfs2_osb_debug_open+0x967/0x15e0
    Read of size 4 at addr ffff888116a56028 by task cat/502

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     kasan_report+0xe0/0x110
     kasan_check_range+0x105/0x1b0
     ocfs2_osb_debug_open+0x967/0x15e0
     full_proxy_open_regular+0x193/0x310
     do_dentry_open+0x595/0x12d0
     vfs_open_consume+0xd1/0x400
     path_openat+0x18d0/0x2020
     do_file_open+0x21e/0x470
     do_sys_openat2+0xf4/0x1b0
     __x64_sys_openat+0x136/0x1e0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>

    Allocated by task 495:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x28d/0x610
     ocfs2_journal_alloc+0x91/0x450
     ocfs2_initialize_super.isra.0+0x11b8/0x3070
     ocfs2_fill_super+0x801/0x38f0
     get_tree_bdev_flags+0x35d/0x5f0
     vfs_get_tree+0x93/0x320
     fc_mount+0x1d/0x200
     path_mount+0x592/0x1e00
     __x64_sys_mount+0x24b/0x2d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 504:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x308/0x580
     ocfs2_journal_shutdown+0x10a/0xc20
     ocfs2_dismount_volume+0x315/0x940
     generic_shutdown_super+0x15f/0x490
     kill_block_super+0x40/0xa0
     deactivate_locked_super+0xae/0x120
     deactivate_super+0xa2/0xc0
     cleanup_mnt+0x217/0x450
     task_work_run+0x144/0x230
     exit_to_user_mode_loop+0x17d/0x570
     do_syscall_64+0x4d1/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888116a56000
     which belongs to the cache kmalloc-512 of size 512
    The buggy address is located 40 bytes inside of
     freed 512-byte region [ffff888116a56000, ffff888116a56200)
    ==================================================================

Fixes: da5e7c87827e ("ocfs2: cleanup journal init and shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Address the osb dereference before BUG_ON(!osb) raised by Sashiko:
  https://sashiko.dev/#/patchset/98583
- Remove fs_state after BUG_ON(!osb) in ocfs2_dismount_volume().
- Trim the KASAN report.

Assisted-by: LLM

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0003-v6-2f69dbb7417fcd537be6@gmail.com

 fs/ocfs2/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0af2245ae303..c02896e127e5 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1783,6 +1783,9 @@ static int ocfs2_mount_volume(struct super_block *sb)
 	return 0;
 
 out_system_inodes:
+	/* Drain fs_state readers before releasing their backing state. */
+	debugfs_lookup_and_remove("fs_state", osb->osb_debug_root);
+
 	if (osb->local_alloc_state == OCFS2_LA_ENABLED)
 		ocfs2_shutdown_local_alloc(osb);
 	/* Drain pending suballoc reclaim work before the journal goes away */
@@ -1812,6 +1815,9 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 	osb = OCFS2_SB(sb);
 	BUG_ON(!osb);
 
+	/* Drain fs_state readers before releasing their backing state. */
+	debugfs_lookup_and_remove("fs_state", osb->osb_debug_root);
+
 	/* Remove file check sysfs related directories/files,
 	 * and wait for the pending file check operations */
 	ocfs2_filecheck_remove_sysfs(osb);
