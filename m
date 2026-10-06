Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84323370AFD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261583; cv=none; b=Sk80F7YWQqhCmSGKJXLUshb4nWrhHuca9p8nMMfgqPSmExVO1N7G5wQitQvdRC4jtcXPQnnZjL7sFey7IOkXRHOcLAMMWkD5FQoIoDvcXKUUICk1aoquiRjr2voWG9mk78v9SoqZiBwCAXIuTKqBqxH4UyJ7n9YbXfZWqzcV68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261583; c=relaxed/simple;
	bh=74GCVFBEaYoLkoDkeStCwsJ3MD5Xlz4Emhhsn4lIGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrPNWWzSYlvCHJxv0btMWYzSh6Vh9J44wKJoDHUKCzCmFiJm1FmsikLkrYhfg8B3w8ZROerpaR8Id8uzD/ECd+vDslPeHJ308K+uiinMF+ApSNsi/66bVh+pLzatpYOAh1u0Tu3CIEVlVxphk1xGvp4a0TPNUghkOXRQfzotLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgM+KtFc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgM+KtFc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso3567325e9.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261580; x=1791866380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HCOU2yJch70xiRkaLkSG3uKGxSg+aF17fZmWG9Aov0=;
        b=AgM+KtFcUBVR1NiAU7kPfqLU3NN5JY5YIJ1iwztz8ef0p4qsGx3shOFqnKRFxJTZtM
         P82KwRMhF+KK51HdByUw3AScqBEg+31jSqn8Tf+5pCg7xhzrccVyJhPJwooSpQLebF/t
         l+p7GKekIwAKKa1CsMjdxIAvsbCLysPySBIuhVw73jcO5BgOKBOaH9wZJjST1duatCR8
         NcpQTPqk74H/rO/z+NWgOLmM+T1IkUwy9XvGOJ+LSxp8lvKhPhUAVpiTQSm1q+/wZMOV
         OmmCYYg4h1ndTDYnyVPQQoB52t+v3n+Ekd+MblRUftke2s87bXA7j8M6K0cQ/BU1j+Xn
         8SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261580; x=1791866380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6HCOU2yJch70xiRkaLkSG3uKGxSg+aF17fZmWG9Aov0=;
        b=Sf+YsJTLEOi2/xTIQubvcSmkyNesUt0i3EP3OawLH8juPSPrgWsRCYao3U6paKqA1D
         yA0hyqR4RLLks9pzd4f2yayTGAsddCKEaK0ExoBKOwV17O6VSmroXe2bn/fiEwDGTpcX
         EQokxJbranlyoRpG+qNW2MW6ELwnz5zkUVTauaPTuLGVzR9pSD3jE9uZHb3PWx0E/ol4
         1cvXmRKC+gG3cKY0/mdqG7vGu9gaXCA1AvaJx74s5HsWkmImg22qLC1+BITc+6fle4Q7
         ihxwlv3gJkqymbJKryItTnD8I0RXnaFL+qdgPaizJXRQVvgBh2Xyx6pk6V6wD082Kfxo
         jVAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy90ctFiUu+3glXdG8DSr6qUzu6SDvPEkzAFHCMHkJtgWv5FZf7KN0FnwCaXpelJfmQcHADIA0=@vger.kernel.org
X-Gm-Message-State: AFuF++nEdmqXLm/IPUUBCWhDi1sZ2HEmslWFoKPpQCXweFWxiS6HonCy
	wcQBGrhGiWcT41b9EqGysb4OfEjxYQDIoxnlKcJygHHRdtpvgGsi0Ssp
X-Gm-Gg: AYBFou1fpi16LFbgmYQUB5glNvrly3uvIU3Agav0LLhJEa4qFrJHwfaDVFS6GPrRJst
	JRBGme3pltjSQBlYLGSMLyv662tWjbV3f7iz0rcbUmv6GQtctrRCw66I3YNxY+nZTsjBxrRNNc4
	n8BH8/ZserqahoAVfEvrHcqCmm3grG2yNvLPOGgBgFRc5rlnGrrKrSeYTVZaFy0FstGiHnFXndC
	vaXQ6me1qTlluQRh76fM5pojLjs78KaJfVUzMOh/KYZDfbxSWQkcAuS9/uORTRFKR+rXQZKxMph
	hL1ywerF8wenQrrbVBD+ZxMxNMDZn8zmxkvlCmXqRoJwTMP/Ty2ZgyRyasvOZP4GPCNClfVH7bI
	Zzs5+MhFiw3vzW9dW/dflkjdVS+uZqhayrTCBxlDUugetNXe6MbmMCyMHUQC9uuAGBHFvdhURLR
	jDhMyadY9VkdXeYF0HJyIOvy5OB4KsjfwVug/jJ4oBltWfVs/T9Ld6aFu7dGi8r/2deSm/bf2R8
	qi8NZZUXFEjxIGRtSZ1vfksMOGroivPozDY7jiZK1bwQgO8mXKT6ADiiBInIgZnxI6+nEfbqu+q
	oXuj7vnm6YYQgJTda7xtUpPrwCHVKNwqzzc=
X-Received: by 2002:a05:600c:1552:b0:4a0:1e37:ae41 with SMTP id 5b1f17b1804b1-4a17b559685mr3252685e9.24.1791261579681;
        Mon, 05 Oct 2026 21:39:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db8c6dsm62744995e9.14.2026.10.05.21.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:39:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ntfs: fix kmap_local leak in ntfs_check_logfile()
Date: Tue,  6 Oct 2026 06:38:09 +0200
Message-Id: <20261006043810.5393-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261006043810.5393-1-kmehltretter@gmail.com>
References: <20261006043810.5393-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_check_logfile() calls kmap_local_folio() on every iteration of its
search loop but kunmap_local() only once per folio. The loop visits
positions 0, 512, 1024, 2048, 4096 and so on. With 4 KiB pages the first
four are in one page, so a mount whose first LogFile folio is in highmem
leaves three entries on the kmap_local stack of the mounting task.
Kernels without HIGHMEM are not affected.

The leaked entries keep migration disabled. nr_pinned of the runqueue
the mount ran on stays raised after the task exits, so taking that CPU
offline blocks forever in balance_hotplug_wait().

The fifth mount in one task reaches KM_MAX_IDX (12 leaked entries plus
4 in the loop) and hits the BUG_ON() in kmap_local_idx_push():

  kernel BUG at mm/highmem.c:480!

On x86-32 the generic entry code also warns on return to user space:

  DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx)
  WARNING: include/linux/highmem-internal.h:17 at __do_fast_syscall_32+0x21e/0x550

Map each page once, when it is read, and unmap that address.

Fixes: 5218cd102aec ("ntfs: update misc operations")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested in QEMU on top of patch 1 with a fresh mkntfs volume, on the ARM
and x86-32 kernels described there. ARM and x86-32 behave the same in
all three tests.

- One mount on CPU 1 with taskset, then writing 0 to
  /sys/devices/system/cpu/cpu1/online: without this patch the write
  was still blocked after 60 seconds and new ssh logins hung. With it
  CPU 1 goes offline. The same write before the mount works on both
  kernels.
- A program that calls mount(2) and umount(2) eight times in one
  process: without this patch mounts one to four succeed and the fifth
  hits the BUG_ON() in kmap_local_idx_push(). With it all eight
  complete.
- Three mounts in a row with mount(8) are clean. x86-32 no longer warns
  when mount(2) returns.

 fs/ntfs/logfile.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 1404664dacc0..ce38ce87f8fc 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -457,7 +457,7 @@ bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 	struct ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
 	struct address_space *mapping = log_vi->i_mapping;
 	struct folio *folio = NULL;
-	u8 *kaddr = NULL;
+	u8 *kaddr = NULL, *kbase = NULL;
 	struct restart_page_header *rstr1_ph = NULL;
 	struct restart_page_header *rstr2_ph = NULL;
 	int log_page_size, err;
@@ -511,7 +511,7 @@ bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 
 		if (!folio || folio->index != idx) {
 			if (folio) {
-				kunmap_local(kaddr);
+				kunmap_local(kbase);
 				folio_put(folio);
 			}
 			folio = read_mapping_folio(mapping, idx, NULL);
@@ -520,8 +520,9 @@ bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 						idx);
 				goto err_out;
 			}
+			kbase = kmap_local_folio(folio, 0);
 		}
-		kaddr = (u8 *)kmap_local_folio(folio, 0) + (pos & ~PAGE_MASK);
+		kaddr = kbase + (pos & ~PAGE_MASK);
 		/*
 		 * A non-empty block means the logfile is not empty while an
 		 * empty block after a non-empty block has been encountered
@@ -574,7 +575,7 @@ bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 		 * find a valid one further in the file.
 		 */
 		if (err != -EINVAL) {
-			kunmap_local(kaddr);
+			kunmap_local(kbase);
 			folio_put(folio);
 			goto err_out;
 		}
@@ -583,7 +584,7 @@ bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 			pos = NTFS_BLOCK_SIZE >> 1;
 	}
 	if (folio) {
-		kunmap_local(kaddr);
+		kunmap_local(kbase);
 		folio_put(folio);
 	}
 	if (logfile_is_empty) {
-- 
2.53.0

