Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD537C0F5
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262382; cv=none; b=a3Wb2cKrrlVjYN0SDs6/7fuLo+UPS3fSCLiz7erolCD64n8AkOrEWoc9a1UkEPwANirIdlGuB6z9FLRf1V/44wR0I8/9u5O/utcDd66qTAi+YxfCfF151c60AMVi2Zl4SPFztXMTNFl6kndYjESr3iqxTqoay6EeqeT8rldFtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262382; c=relaxed/simple;
	bh=74GCVFBEaYoLkoDkeStCwsJ3MD5Xlz4Emhhsn4lIGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MW1rn9uSP4/t0u0kEZyEYEkh23okFLk5C6vYUra23d8rc8Q3JjJ5txDWuR8oSo3hF2b5LQ9DI4rGOjkhYYoXp3ta1f2dMpgoARkG2C15/7S+SasKGbtgwfwBqjL1Pbs4bNsxhQPsl1bgpjImYRyxhWdEGqZD6IC4gGla59BGmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiiEfowE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiiEfowE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a168355946so3035645e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262379; x=1791867179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HCOU2yJch70xiRkaLkSG3uKGxSg+aF17fZmWG9Aov0=;
        b=IiiEfowEeTTgP/y/kqj1w46wkdNDKvTCyz2R6v1ix4OKMS7WXnDLjffAJEaEBwtH9C
         t4RIDw0ZUFGxbLMwcDFI9xtRCPlqoMVgurbAiSckryWDiGp2biqNk/H81ZD/GqUkaU/i
         xZWLb8RTCMTbWuqsf5c4s/PyDlFMx+ph3alZch4PwUcu9II8U9pa3uaSv6/jIStrhnrk
         9/qbQhHOVOFe6erOK7VkwWWxddIxfuVd3LFBrHVFNPbjx/auOUC1FkevhGLxtlFruxIs
         6i7maErDuR0ieu32vuiQeLlz1SZG7wq2IFNClj37sQORSE10/lE/+wSB2ucC2JnmaWO5
         23cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262379; x=1791867179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6HCOU2yJch70xiRkaLkSG3uKGxSg+aF17fZmWG9Aov0=;
        b=jceomXv34+GNk9v8oPLriCRxZ5r0klQtusb9GHx0C98P8xdvBjpP+0OpF1hl2pZayw
         I8Uo55R8tmGarB/iDtf5Mf/BW1DA6dJLpD6JMQqzjgBvSdYn89gyxWUbJuZ6LjJNEeBa
         Vrkbz3sGVODAGwqIaJKUPg1bC2iEnIc5Av4VhuUowDZ3b4/xU/zqQgovMXsAJw93+HCQ
         5w4CAlDt2Wucfov4LAYD7BfDOJOoObspGuiJPK6ZbXQSBsAMmJ4Z+E6EOsrSLnUM3QE0
         raPEm45jZx2Aw2D9JcDRNLHgpPOppaXpwTzh/h5X0sT0d3fOEn5zhXNmI8v3eAMP15YZ
         dmdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ6Mg3uXHJ4wEve0Wkb242IuBI9nuM14359UztDthtBt7SIRCPe1/sVKfQYXVvllygPP9j19k=@vger.kernel.org
X-Gm-Message-State: AFuF++nVU1n2Uj3ExZB2U4mF+Olh1fISd4SGLzUvtbVdfeINp2YPVrgF
	E8NOmm8+J3kuUQ3rzYi/3QgkN8B+5PbrqMhGfr8bXoqafax8A2mPPtft
X-Gm-Gg: AYBFou1ejL0s+VeFLyv1gdDyVrx4N0D7ci+v/bBYyMnwCvkvHP6df8pOtVFE6Uqf/SY
	4uh9O+gZjhWmfKddjPoefZ4ipmL+iR9OkfKvBP969ymo8ep4+/yVvJwYhI9yJbff2sKwF4SKbn4
	Z7wB2BpQPJwGr2Hm4rx8cCGy/bf5XaQUAqszDn74MwbggUY6GAo0Xk1E6afaquFWowRk6XZInmp
	eI1/Wcv7P5lVe9ao+/PgnIgmsL8VRM13KZ8ur0ux55Efhj5GldjP6gjLPBwG3HF2u8RIuLNkpKk
	6doOHwi3mRxkClGdsBsZqy0FepUQfH61tK9R8MCkYiidYiyW+ntgB6zDHgxE6alryvlUqcEKezv
	B50yLIr7hEkpobhf+bNt9d6IZWjGvpj7XC0+Nayc/CDu0lPsrinkeHsdBm1siw5s4dx79ueQkQq
	fbxxZ4c+60VV9unvy8glIreQB0mlky1jl/+Gg9Kw4NgdOtE8w3PvF3U2RyPxgmDjbp29zl9ebkb
	KVbm8q8aGoFq/56GoTNBDTl83tOuUXOvwxU6n6nxFgk04H9oiyYMAb3rVM+wI7cdFxxPG9KGyzN
	Zo/p25Iptx+X4i2HyVS2NgrgnW31QtrXPLs=
X-Received: by 2002:a05:600c:4e43:b0:4a0:c4:a1e0 with SMTP id 5b1f17b1804b1-4a17b53bec8mr3771995e9.9.1791262379239;
        Mon, 05 Oct 2026 21:52:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c53299sm72322225e9.11.2026.10.05.21.52.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:52:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ntfs: fix kmap_local leak in ntfs_check_logfile()
Date: Tue,  6 Oct 2026 06:51:36 +0200
Message-Id: <20261006045136.5911-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261006045136.5911-1-kmehltretter@gmail.com>
References: <20261006045136.5911-1-kmehltretter@gmail.com>
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

