Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795247526;
	b=hrOgWhWu39JGfvBtR+8IAmdAfkjX+N70uIXgiLNwybu+lY3kAqzFqyZ0J8HvQBUU1QFZ
	 69RPWMcwT4H5mvLMK4I5zxdI9PhS8yLlW4jOa+QmrXKfGHYl00vqJQfmd7ZSC41TOVEJE
	 G2AIlYSfvFfH3+ZE7DNkcfGbM00dypNv08KcsU5m5r70EUapx20PErbQwivdKC02ZLIr3
	 BmdCRH4r3ecIjd3cSktzgMU5R2t8RHOolWEyL6arM3iTv2Zl3IWo0cKZuZYcyHMJX5+1Q
	 lFymN6wdriiT1J9bg8dpkG95CzBFdqf14+UKkgjcxGmRxmJE5G2obtDmAXHxxBq7Erw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795247526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1hYw1g33ZMFOQ7DBwiFeU4k0h/WUx3Md8Zv+IeH1Fvs=;
	b=nDrEad0MQ02J9W3dBDhytat+y0+rGT5f1nQhSNE2edoOavkPVVGAlnGx0N7M2Sxp2F2f
	 OeZ1t1srXpDgY0edAzSdqxL09TOMRk7RhQTp1Jom1OlIFkzKI81tdeDmMB63NOda6Szq1
	 mlsMkJ+dQaYFmdtft5HMPo1azuaRfthnwQezuyo6JAC2dwz2v2Godaosz3EeMLNfnkzIz
	 th7cjK2slzqlO/Ezq+bzlJ0IKGORtYLFL+7eJ/WLvR8Ck4eIhBwA7QilRBxDgMU/nE+bd
	 a1yh9aYCWjAdgcq7JGn0GXw0UYjtgIqhY/XMqsAZSccUGC+wljahmDCz3GhellFWOkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+gkpbZ0;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED024606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED024606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+gkpbZ0
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so1490665a91.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795247525; x=1795852325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1hYw1g33ZMFOQ7DBwiFeU4k0h/WUx3Md8Zv+IeH1Fvs=;
        b=O+gkpbZ0bFWcOAMp0zzqenLDkZZPHHdPU71qyJSkOakrMhknWdELDegIbChG5Thv+q
         rJ7uSyX8QIgEVTuF5Jf5WxxsNvSBLvgOi47Ru7NJVUjxlPVnD824tCvxETBOZP1XLImU
         Ly3qpiWATfGbmh7DS4SSlXMbBlxetKDJEq/1Kac9GNzbtfc0vbWK/Ml74WIUoO/1bTnz
         QxEQ91bzwrFDfKJLpHvr6wFLR4PhiIpgsaxFHtN9Dz2yJp7IFzya5ztEHnUNLcza6FXj
         s/MxbhkZXaVqWV+3hhNCG9IJ4BVX96SrOZUQk2DTXxYlW8X/S3NxKupfRwCGd51cHfqC
         8+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795247525; x=1795852325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hYw1g33ZMFOQ7DBwiFeU4k0h/WUx3Md8Zv+IeH1Fvs=;
        b=P69YdHv5S5OuAU9nZrO/8iYKdXru1i2M0EbwZ5aqsL4TgsloU2N8ayuJh+T9GjdITV
         Ibukg80LejILCT7J1AXgN00pUXyfGRaXTQL9Mjii2tzsx+MmAxjHTpnKJEooSF/y56jl
         +MyedxULsnF5wXkdVDJShI46zzVf7UTdAZJ9fc4t4BG8QOBhvXfeifA4BjYHaEm3Oa2a
         7Tj8IkT2iwTCojoqm6u99y3Q0W2aiL4XJY19H5Yz2qKZsyEs+Zu4nzFeqZMzIAxvokwd
         F1/MS5FLy+EtO1VJGEpWdG6L11A2kM9zhYtR6tt0oLL1ObDmWgEyDYI8X7VilBK13q9D
         e7zA==
X-Forwarded-Encrypted: i=1; AL+hErHngZ75oC7yFmfpCQaNhvSQM8CpJ9aDbvCpJqn8B1dDqkl6y2GQRFengzkEmtd7Nu9N6c1p5V4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tB3p5f4/vVDwCnKHhHiCNmPKTpspEXXDHn+LtePOtMvssrPM9
	C+gSp8ze4bXQ8YJq0jTJsVqhUeTYvU5tFuE8Lq8EraEddbJmfghs6l0q
X-Gm-Gg: AZFdTZcxfEbnE2Em51zLWAWrhVSu8W2Gv57cUKBYeQXr/73acEh7GcH900nkTlhlen0
	MGDMiTx1zm/p996BG77WjCbCNWJVqGvxVBCEd8Kg5nRj2AwYuPYmanoO3K3npqIskh3krTQXSzO
	a4xRD8vDyhBZpS+ZO9XvFw5V0db8iDwXvklmFc3czUScRS38n0EW8l1Yp5MZKhPl5YVCsWDKdWp
	2IUGOin5DHbbO54tkI0QN3fBaNfy1BDSiw/rnKjvfBhyH5Z8C6IUSZKmjtev3ACP4Ha0SCKdRP6
	ny0QoASxr/u8o8tx8RWNZ4GGk1UvF+xIpUHSjZKNRKLJwD4cSnOl9A/0USovQJW387k0uUkhKJt
	N8aFjfSzeYx3rlr/PXS35iAUmkklgO1eBQrCUPxCfVdphLT0kvL/JazFwtHE5YwgEolO/nuj+WW
	gwvAT1DZAVlTVuzL/Ealrx+7Aj2AEduBzec55yOABjvm1kt6u318jg/CffDe1R+aH8vhYtZM25B
	ZOyY6jCYCQ+YxuiIPsoZ6QwGuyYMWVXz5W339rqIEQCa0EZ8H/LjUDEVlOTJrXPwqUvxgBaEfZe
	Yd36KyKKC9PJjZLsZvbZeb4c
X-Received: by 2002:a17:90b:17cb:b0:3b0:cc6f:1046 with SMTP id 98e67ed59e1d1-3b41c9bc517mr5638283a91.67.1795247525168;
        Fri, 20 Nov 2026 23:52:05 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfec090sm2401719a12.14.2026.11.20.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:52:04 -0800 (PST)
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
Subject: [PATCH v3] ocfs2: drain fs_state readers before journal teardown
Date: Sat, 21 Nov 2026 15:51:57 +0800
Message-Id: <pm-ocfs2-objects-candidate-0003-v8-8fb510a5c52b337960c9@gmail.com>
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

The fs_state debugfs open callback builds a snapshot from mount state,
including the journal and cluster connection. The file is published
before ocfs2_mount_volume() and removed after journal and DLM shutdown,
so an open can overlap teardown on unmount or mount failure.

Publish fs_state at the successful end of ocfs2_fill_super(), after the
last fallible mount step. Remove it in ocfs2_put_super() before calling
ocfs2_dismount_volume(). Debugfs removal excludes new opens and drains
active callbacks. The release callback only frees the per-open snapshot.

KASAN reported:

    BUG: KASAN: slab-use-after-free in ocfs2_osb_debug_open+0x967/0x15e0
    Read of size 4 at addr ffff888116a56028 by task cat/502
    ...
    Freed by task 504:
     kfree+0x308/0x580
     ocfs2_journal_shutdown+0x10a/0xc20
     ocfs2_dismount_volume+0x315/0x940

Fixes: da5e7c87827e ("ocfs2: cleanup journal init and shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v3:
- Create fs_state at the successful end of ocfs2_fill_super() so failed
  mounts never publish it.
- Remove fs_state in ocfs2_put_super() before volume teardown so creation
  and removal are paired at the superblock level (Joseph Qi).

Changes in v2:
- Address the osb dereference before BUG_ON(!osb) raised by Sashiko:
  https://sashiko.dev/#/patchset/98583
- Remove fs_state after BUG_ON(!osb) in ocfs2_dismount_volume().
- Trim the KASAN report.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0003-v6-2f69dbb7417fcd537be6@gmail.com
Link to v2: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0003-v7-1522d068e5b943786c3e@gmail.com

This patch was written with assistance from Codex (OpenAI).

 fs/ocfs2/super.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0af2245ae303..2a58d3cd9690 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1072,9 +1072,6 @@ static int ocfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	osb->osb_debug_root = debugfs_create_dir(osb->uuid_str,
 						 ocfs2_debugfs_root);
 
-	debugfs_create_file("fs_state", S_IFREG|S_IRUSR, osb->osb_debug_root,
-			    osb, &ocfs2_osb_debug_fops);
-
 	if (ocfs2_meta_ecc(osb)) {
 		ocfs2_initialize_journal_triggers(sb, osb->s_journal_triggers);
 		ocfs2_blockcheck_stats_debugfs_install( &osb->osb_ecc_stats,
@@ -1158,6 +1155,10 @@ static int ocfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Start this when the mount is almost sure of being successful */
 	ocfs2_orphan_scan_start(osb);
 
+	/* Publish fs_state only after all fallible mount steps. */
+	debugfs_create_file("fs_state", 0400, osb->osb_debug_root,
+			    osb, &ocfs2_osb_debug_fops);
+
 	return status;
 
 out_dismount:
@@ -1555,8 +1556,13 @@ static void __exit ocfs2_exit(void)
 
 static void ocfs2_put_super(struct super_block *sb)
 {
+	struct ocfs2_super *osb = OCFS2_SB(sb);
+
 	trace_ocfs2_put_super(sb);
 
+	/* Drain fs_state opens before releasing their backing state. */
+	debugfs_lookup_and_remove("fs_state", osb->osb_debug_root);
+
 	ocfs2_sync_blockdev(sb);
 	ocfs2_dismount_volume(sb, 0);
 }
