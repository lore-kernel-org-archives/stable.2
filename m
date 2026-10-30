Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350939;
	b=Orcr4oznAECN7rDPxYfPRrNsIc6OHKd00ggW0nJZ/rkgni235qslu9M5beoQ7wLYqrxm
	 Bl/Ao5EByPORBrGXQPs0vL506H6jMVRraRAz4V5avDR1PukXYsXBRBhvTmD0sIZyB0ZjJ
	 mGL1k4TGkkU/y3o1lUdE1lqA9O3NCEAGnTsgmfUMdA3wyWaqcJWXTAR9HRxl1S6FTYDiD
	 oxOABMMIV2tl1mO+mzbvt8MgoBegG7RIGHv6XRirA6q/LvrYS+4lV0qcXQepqcWxTvxMr
	 7b2pSTvfmI0kqS6+lgl5WIANZIyXtHa5IbrwX8VrnjUoyDT/8JBAgL2z+J4Vp/vxWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Mihb4OPZBic55UeIz2xeg7uf8TjtjfwKjVCpWgCi8w=;
	b=dSm+wWEhGMmicBUM7PHi7T2NMBdIQUvl7GE/e36DxSchtEuYftv+TDvamep1FEFiEMup
	 SrYTaCBF59Nz3kSf4L6LO7jNU76FUkCmdZP0xSidPBQ4VuJ76IZragJNkgBXAM3p0oyeK
	 S8qOkF1ldvrXlHoheRb1ZL5/md6zC5WARKwk/j51OV9dq2h62tyC6xps+Vi+IotjnUuh8
	 QPtoJKL7zN0JEW5lULCp6OWITVoqdhQE9k7KlSQyuN30WVZ9fgxsFUHe4+MaYtobIDV3l
	 530MmQHjCUaSp6EFx5U6Z3FZkY/j5NVjJEvngycci2vmBbviyRaLgzFvpayEU14DfuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="dbg1/IxO";
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586E606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0586E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=dbg1/IxO
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53512cd2f85so5793601cf.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793350932; x=1793955732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Mihb4OPZBic55UeIz2xeg7uf8TjtjfwKjVCpWgCi8w=;
        b=dbg1/IxOZ96hc3CHweDCGa5yfW18aW/qdKsZ36dESwYy/4+LqKm2LjwafpEoenOP3L
         KBnEKqqo78/1KSRUzRUK6zksH0nLRI638ih3w+LnUILAhwxqz1/TnX/HJXnll5CkPT0E
         U2qRG9IaXl1/2fITjEbMrYdEfGo1kLQgziGPtHlCDUYOwQCLdgBix8QuBT10F7jH9iso
         ZcvTyx7jmmrTYaxKJABa96QcNO9gFYVjRxOuoDk/eFUDkcNpuM4ABcgYI8ulSSXsGe3y
         yaGjTjAcpSJMroXXHfANtFep8YfXmGERoHVZiEr34KvHUcBixyM7RxLaL4tZ9EsNX0Mh
         kqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350932; x=1793955732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Mihb4OPZBic55UeIz2xeg7uf8TjtjfwKjVCpWgCi8w=;
        b=lDyCbhrI2Xxi8Hu0HnXW56qS7VAuiNetdsvnXpW/gpNsavURQ2PIJKSNHK1aWyzsft
         9h3e3b9Xa3Y/A57hzUqygblDRvVkxZQ7qC0t9TCx6yLjCViD/jyOs2GdcKzrrgIewFu3
         dka1PxxhSilEflLDkAeOc7deCJXSFPT9RolYkMi7ci43RQazq5QYyK/jYBdfyxv/5QYU
         w1BnPzxBph2YDZPHa9iL7agSZddQmYGcb9lQ9SEubM6UTQ1812WzN9xfT7LpQzONxeBJ
         HCBiBjuDUz3xqFUF7HJKd61gONYr/lJSr1+b/+JA/fRASEyzy/tekKATkgHGvqOHjeCY
         8a8A==
X-Forwarded-Encrypted: i=1; AKwUvBxzo1iulhAo/mhMi16jIHrDydXOEMjy0AYyRA5AYgicta2EvA1SJrV/7KkH9SHe6gf3a/wBbVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvvfWyn2UsbhnjOMPreJbZY0Q1ayWNAui6WbjpY3rzL5OvMFAH
	DxzOMwj4IFS8/z5UwYjQ8G9zNUQgECIdfCtnQujdFnL3H3cYJXJ9Lyc9ME9Ko4PwopoSd7hmg3b
	So6UOrA==
X-Gm-Gg: AYBFou2jUKEPPYJQaYAcAj17X01mh8+B9hRdLIkIId2+QYSU8LTaLEmvpOjCNZPww2L
	QrkaXkElp4IIiOzJubmOFDlkni6YzRcUZfw64sw2968JiBxm2XNXmdzKYvFcambhKEUmQNBr/Uy
	FBXmpBHwxRnhZGpzHooy1DWwqeaCbXgXWsvj1t3g0jaBaaOuGX0kz8swoGUjDR3lSJscIfXekl0
	edQ8AzvenTS/lbWxG3Yb6imhuqutRaD4zFFvrlHGPZwoC5Z6zFQKsGgNdPKCp18FAq+x7jKNIAo
	6tc6nPlMuNR5p3lVmW1SCdN9iBRmqJrG6fFxjZVrv6CsfmUE+26ZCx6JDiIe7UkifigGvP7+mdn
	quNNj7VnR4wMM8wzGkqT8Ws3cGtFlCuqQIVOCLrkPaG13UuI/7guikGgcaJoyULOxWe/CnciESP
	hv6tHZAloNuGP4d/T3+yOa1eFCLCa6xANuOdpxk+9ORuvdfb0FcOCaN2OFw0vpyK5ufTZm+ra1k
	aEVhM5VHrLQrE98pAcn8wO1xyKIJGbUXMLy2TNrFmxsXklDcRcyJQFGIWd2fNGtqdT7CC5hF7xg
	tNdT03iD1GHdUZ1L6bsSlGSL/PJqA4USZJUDui1RKq5KTz2Qknvd
X-Received: by 2002:a05:622a:408:b0:536:2fd8:a4d8 with SMTP id d75a77b69052e-542b6689ab9mr23251791cf.15.1793350931563;
        Fri, 30 Oct 2026 02:02:11 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54313234047sm8404251cf.28.2026.10.30.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:02:11 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: hirofumi@mail.parknet.co.jp
Cc: brauner@kernel.org,
	technoboy85@gmail.com,
	teknoraver@meta.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fat: check for hidden entries before overwriting end-of-directory marker
Date: Fri, 30 Oct 2026 05:02:05 -0400
Message-ID: <20261030090205.279419-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Since commit 6a2875517c77 ("fat: stop reading directory entries past the
end-of-directory marker"), lookup and readdir stop at a slot whose first
name byte is 0, and fat_add_entries() reports corruption when its scan
finds an allocated entry after that slot.

The scan stops as soon as it has enough free slots, though. When those
slots include the marker, the new entries overwrite it and the allocated
entries after it become visible again without being checked. A name that
lookup could not find can then appear twice in the directory, and removing
one copy leaves readdir listing a name that stat cannot find.

For example:

  mkfs.fat -F 16 -C fat.img 32768
  mount -t msdos -o loop fat.img /mnt
  touch /mnt/aaa.txt /mnt/bbb.txt /mnt/file1
  umount /mnt
  off=$(grep -obUa 'BBB     TXT' fat.img | cut -d: -f1)
  dd if=/dev/zero of=fat.img bs=1 seek=$off count=32 conv=notrunc
  mount -t msdos -o loop fat.img /mnt
  touch /mnt/file1
  ls /mnt

lists file1 twice.

Before using free slots that include the marker, scan the slots up to the
next marker and take the existing corruption path if one is allocated.

Fixes: 6a2875517c77 ("fat: stop reading directory entries past the end-of-directory marker")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested on x86-64 KVM with KASAN, comparing mainline at d89e1d186ec9 with
this patch:
- The example above: the base kernel creates a second file1, which is
  still there after a remount. With the patch, touch fails with EIO, the
  error is logged and fsck.fat only finds the dirty bit.
- vfat, three-slot create whose free run ends exactly at the marker:
  the base kernel exposes the hidden file, the patch returns EIO.
- vfat, one-slot create that leaves a zero slot after the new entry:
  succeeds on both and the hidden file stays hidden.
- Valid directories on FAT16 and FAT32, msdos and vfat (creates, deletes,
  renames and mkdirs, then filling the root): the same entry counts, ENOSPC
  on a full FAT16 root and no FAT-fs messages on both; fsck.fat -n exits 0.

 fs/fat/dir.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 35bdb62944a2..ab99d53a719a 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1318,6 +1318,32 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 	return err;
 }
 
+/*
+ * The free slots chosen by fat_add_entries() include the end-of-directory
+ * marker.  Once the new entries are written over it, the slots up to the
+ * next marker become visible, so make sure that none of them is allocated.
+ */
+static int fat_check_after_eod(struct inode *dir, loff_t pos)
+{
+	struct buffer_head *bh = NULL;
+	struct msdos_dir_entry *de = NULL;
+	int err = 0;
+
+	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
+		if (de->name[0] == 0)
+			break;
+		if (!IS_FREE(de->name)) {
+			fat_fs_error_ratelimit(dir->i_sb,
+				"allocated dir entry found after end-of-directory marker (i_pos %lld)",
+				MSDOS_I(dir)->i_pos);
+			err = -EIO;
+			break;
+		}
+	}
+	brelse(bh);
+	return err;
+}
+
 int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		    struct fat_slot_info *sinfo)
 {
@@ -1351,8 +1377,14 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 				nr_bhs++;
 			}
 			free_slots++;
-			if (free_slots == nr_slots)
+			if (free_slots == nr_slots) {
+				if (saw_eod) {
+					err = fat_check_after_eod(dir, pos);
+					if (err)
+						goto error;
+				}
 				goto found;
+			}
 		} else {
 			if (saw_eod) {
 				fat_fs_error_ratelimit(sb,

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.53.0

