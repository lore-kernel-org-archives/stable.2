Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793075514;
	b=nGZeDqjJcJaFCOmiuXgteC9qTp4tYD9UP45gf4Tj86wyupQTQQGKIYCxrNCSWt7ml+Yc
	 wGwd//xoQcKnW4Ed03wreKKPWgAub6Zjl+M471xyTCn8vvZk7DUQtcFkJrlOG8MZgBz8r
	 bw1QiYGET5HWycscLv9CTQLHjEVsPNL6x5hEWzvZ02m3NdCdg8mkaIG2L33S6R/t//DNC
	 HsgqNYQKhuU4dAj5f38h/rt450N724i2ibRd6lDXjiH3LiWiZ37CPskE3Mfn80PiRZDe7
	 Ge69OzDRycQYqHlOsp4TRdBXQWert3eNEligu0HsertkeMrWD++ogk2Q5/VNfFIeezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793075514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9XcXpTHmLfHB2Be+0WH2R/6aY5PlfN5yRc5K8VlYOZ4=;
	b=rY6iKp9hyIUuKvW8UpeHf0ZpsWN7VjfhRPv7x69q3Mbnd4tXqa3N2F+bVRUakre6m/Jl
	 O6tjZAlq0q+Qrq7HcKqnOL4T833P9RhqBoQG8BZ03AO6oQAeUKhsjcfXflqDX9V2Swvx2
	 I62eDNjrWNf0YNNovs2vWZjDf/tn6LvXfj6nz/RcVVEzDKYyljdH0tgiJIpo8y3mgKucU
	 SXHA5YIaasBFRUjeOW0Tgkkex9ky+l6hUyCGhgsGi/LjYFaGGuwMdrrTm16Mx6FzWkDmL
	 o4jrkqov3CZE3gkXyBJqCo34cttmsCvpJlSBHVUr4P0QFvD7y0SC38CeaPmr37KjwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft+kc9d7;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D25606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D25606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft+kc9d7
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so2524209b3a.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793075513; x=1793680313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XcXpTHmLfHB2Be+0WH2R/6aY5PlfN5yRc5K8VlYOZ4=;
        b=Ft+kc9d70C01oMLfCbLd9iWGPhjlf1sER8D1d7A4Xht4btHHd978r+0PHX6XK4pGDc
         zsk96tl1jWKHoqatlBACQde7hGlwGuFGfiU9zb+jAxWfc4g/065naoYH2FHrkQCvQ0UY
         Y3NbFR2W0R8uYkZgLMT46jgTrMLKEe0rrBNwkCfLMC7KSIghk3ZOVWRxlbx1PnQykHiJ
         r3vF7QmJp3BqYeqPc5Ohkp2GpGFE045NNyg30cIehDS2fdqa5fmu6XLx0myEDfV1OQDb
         xMma0Hoq0nkUyw58L1WkLPU+R4cLeE6PVWruk73dIVoeeovUfnsj4/sNIVaiPytviYNj
         hvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793075513; x=1793680313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XcXpTHmLfHB2Be+0WH2R/6aY5PlfN5yRc5K8VlYOZ4=;
        b=kG4cVL2a2b+FOVOWRcUu1dRTSI1HPxLQzY/O2rB/rK997t1+AmnQdzx4ugRzVQDn7R
         lEY75iwDI8JKoPnOkO4GBl1X4My2RtQ58gLt+6QyyOWc5yorQkIONBZ70vYlWt9Pndxi
         LYH8f6PXM/P3+FdE3AhzgGnoqQh1zeX6zEvaONwTdkG1nRXVZrCYGnayvHD4MNySYEmp
         ze7NGbf+6V5A9IfqdA9lFKe7+Dj5t9Jsca97dRi8lcbCbSkWqFkmA9mz7g7RQjAts06J
         xy3D4iSBVDWfZFA3Qz+8Z15kewWilAR1SUipk2yk5sUM/Nwcvko86L7JFxH63ji8ZOLh
         gKAA==
X-Forwarded-Encrypted: i=1; AKwUvBw4jKC1Kl29Cx7pQjPjZCAlJkpz5o8lc0MeuR6BijK08AhcubrdT4Q1O62nNYbN8zo65bC+nRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIst1GKjBGIpIAhZyv1ZiXP6GiXEoCulOCmKqbPuoi5TBvVQF3O
	YWkP/IAoPDQ2HqOvcUTd4EIqJGijxebRurjr6K4G7k7n9jxynmJmFL9y
X-Gm-Gg: AYBFou2wO4dXvSsluz6GCskx8W05rBEB8TYnvgjXtkP6IXxm4t2zq5SABlgPulYJkjN
	99M3FlVa1WBDPzcmssw3XQAi+zP51yBD3/6N43d6rTN+A2tmspsWZrUKoHUhjg+dy+g3Hu9rBLM
	L0rBiHCCEQEAWPsHquP03ow2ZNenNRkzmhxG46DNjIrwzSyNVmxMXUH89nRRYJBDYflcO+R+h2t
	eDUqkzpGsnoPsJjtqJgB2At11YyYWf9vFMBH9e5o2WFK2g3AysWUbBpHUqkEt/A4IUcbbX3cGLk
	TUaXpBmjS7WWjYJ9+MozQ9HKfwX8u9S5isddH5AG3sq5WZMyP0xPuuELI40OeyhbuJoJufwR98j
	wXlg9tEA0UInw0WCjtJYgqbGuMmrKQ4nTQgYxgtqUUabJUbGH+RD5dBA9Hgw7grMik6+1RlW5oX
	c58zdpujeIaxTfs1bw8qTfCsRUStCbBqf/rr8QWZ/x3xQoqUPRvvEvPF6Jt61M7B7WP6E6Aim8Z
	BrYBSjI6fcq2d8yktdqBdTuh1cH8DidftsZVH27T5ZpiVh8q8iUstoN/xZxJ+xtoEZualbA
X-Received: by 2002:a05:6a00:2d91:b0:89e:f8e9:205e with SMTP id d2e1a72fcca58-8a369072e1bmr6269839b3a.40.1793075513176;
        Mon, 26 Oct 2026 21:31:53 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a368d85e22sm1887537b3a.8.2026.10.26.21.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:31:52 -0700 (PDT)
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
Subject: [PATCH v2] ocfs2: keep locking_state within the cluster connection lifetime
Date: Tue, 27 Oct 2026 12:31:44 +0800
Message-Id: <pm-ocfs2-objects-candidate-0011-v7-61e3ef8b1ad44ac2e817@gmail.com>
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

The locking_state reader calls ocfs2_dlm_lvb() through the selected
cluster stack. Its debug-object reference keeps the tracking list alive,
but does not keep that stack selected without a cluster connection.

DLM initialization publishes the file before establishing its connection,
and DLM shutdown drops the connection while the file still exists. Both
the mount error unwind in ocfs2_mount_volume() and ocfs2_dismount_volume()
remove the debugfs subtree only after ocfs2_dlm_shutdown() has returned.
Whenever the disconnect releases the last stack reference, which is the
case for a failed mount and for any unmount without a pending hangup, a
concurrent reader dereferences a NULL active_stack:

  Mount error unwind                  Debugfs reader
  ------------------                  --------------
  ocfs2_mount_volume(): out_dlm
    ocfs2_dlm_shutdown()
      disconnect last cluster
        clear active_stack
                                      read locking_state
                                        ocfs2_dlm_seq_show()
                                          ocfs2_dlm_lvb()
                                            dereference active_stack
  fill_super(): out_debugfs
    remove debugfs subtree

Publish the debug files only after the connection and the mount lock
resources are initialized, so a failed DLM initialization has no debug
reference to drop. Remove them again in the common DLM shutdown helper
before the connection is dropped: debugfs removal waits for readers that
are inside the file operations, and the parent directory is still present
at that point in every caller. This covers the mount error unwind, the
ocfs2_fill_super() failures after a successful mount that dismount with
mnt_err set, and unmounts whose disconnect releases the stack directly.

Only the relevant frames of the report are kept:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
RIP: 0010:ocfs2_dlm_lvb+0x38/0xf0
Call Trace:
 <TASK>
 ocfs2_dlm_seq_show+0x36a/0xb70
 seq_read_iter+0x480/0x1110
 seq_read+0x362/0x5a0
 full_proxy_read+0x11f/0x180
 vfs_read+0x1a0/0xc20
 ksys_read+0x111/0x200
 </TASK>

Fixes: 286eaa95c5c5 ("ocfs2: Break out stackglue into modules.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Remove locking_state and locking_filter in ocfs2_dlm_shutdown() before the
  disconnect instead of only in the ocfs2_mount_volume() error unwind; the
  old placement missed ocfs2_fill_super() dismounting after a late failure
  and unmounts without a pending hangup, as the Sashiko review of v1 pointed
  out.
- Drop the super.c hunk; the patch now only touches dlmglue.c.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0011-v6-14cf2458f4fc90780f76@gmail.com

 fs/ocfs2/dlmglue.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 88d946466083..412ab0808c59 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3356,6 +3356,14 @@ static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
 {
 	struct ocfs2_dlm_debug *dlm_debug = osb->osb_dlm_debug;
 
+	/*
+	 * Drain the readers before the cluster stack goes away: the
+	 * locking_state reader resolves ocfs2_dlm_lvb() through the
+	 * stack. Every caller removes the parent directory later.
+	 */
+	debugfs_lookup_and_remove("locking_state", osb->osb_debug_root);
+	debugfs_lookup_and_remove("locking_filter", osb->osb_debug_root);
+
 	if (dlm_debug)
 		ocfs2_put_dlm_debug(dlm_debug);
 }
@@ -3370,8 +3378,6 @@ int ocfs2_dlm_init(struct ocfs2_super *osb)
 		goto local;
 	}
 
-	ocfs2_dlm_init_debug(osb);
-
 	/* launch downconvert thread */
 	osb->dc_task = kthread_run(ocfs2_downconvert_thread, osb, "ocfs2dc-%s",
 			osb->uuid_str);
@@ -3411,9 +3417,10 @@ int ocfs2_dlm_init(struct ocfs2_super *osb)
 	ocfs2_orphan_scan_lock_res_init(&osb->osb_orphan_scan.os_lockres, osb);
 
 	osb->cconn = conn;
+	if (conn)
+		ocfs2_dlm_init_debug(osb);
 bail:
 	if (status < 0) {
-		ocfs2_dlm_shutdown_debug(osb);
 		if (osb->dc_task)
 			kthread_stop(osb->dc_task);
 	}
@@ -3443,10 +3450,11 @@ void ocfs2_dlm_shutdown(struct ocfs2_super *osb,
 	ocfs2_lock_res_free(&osb->osb_orphan_scan.os_lockres);
 
 	if (osb->cconn) {
+		/* The disconnect below may release the selected stack. */
+		ocfs2_dlm_shutdown_debug(osb);
+
 		ocfs2_cluster_disconnect(osb->cconn, hangup_pending);
 		osb->cconn = NULL;
-
-		ocfs2_dlm_shutdown_debug(osb);
 	}
 }
 
