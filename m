Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011856;
	b=q7Wh9snv/7a0LISPJ9lHOnuBze6+q+WP2Ydp45MSm32Ey+q16o4vff8GMnNyd4A7rB9/
	 za8zKYxtimpi7Cs02MqN1if+qdb9yNxEu/+8Gm6TzI34oApUO+zQ/PY36s6R6n9YoaLxM
	 vtmWMWEUdJGZzYR/kHsNV5PjKqEq8wmA4a/BnqfwarQbnLb1ZZIjJSk5wtaFRPU+1jCIF
	 +l85OA4vXF4Cu6gq5P9XOKbjCc4BLG6WismlwdwDZn+dkG4LeDUZu1wv7PmL9sKrasDHA
	 vBN0CmONktSU73jNptEz+fQOkCkhjV3Fm86rCh9a30IhqOXqfLFX+WOJczXxFDj/WOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=;
	b=4PvWj2PWKozTLjEJVwX+IWC05xPBg4nHNMiC8xcqNfrkUfS5QVPLBM0mkbJla1uTgQG/
	 5+xH0hgqfBUr65VfNJdBEA8gwPbABdEiCBD5/9KkF20aSvXcg5SiubYXDCpRw0E5TY0lx
	 trdfmKDudLN4dX3VFRf9Q1HO8oBagX0faUnkFI0qyi6KTGM3niCsrcv5J5+jXFlAJfj+k
	 SUBsFqbEBJY36eFU6Iyhzz5I2rnoJgHepq0teQpnXRHbnqqv4Q7HbyliJbVXZ2CUnDIkb
	 n0scAamR5ITdpTsjfdFFHFz7AYpUTipl/xVkK/AOIetCPmnW7NKVyOpoyAwVUiXqe8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eB3nclYt;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC81606A32D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC81606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eB3nclYt
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-369f33df08eso2563669eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011855; x=1793616655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=;
        b=eB3nclYtzQ1Vfnnnt0Y8TG+UyWLz923k7t7nN2Di5brv/ggzQ4Dz3kBr1UOF2P8UZE
         rz+Y090lcdMA/sMuB9DsSHZFLY7RVlzw3y0PGtEXtkL/Y4FAFikeIaHOUzD2IEZCOaxA
         xVRlD1KfozP9xRkz1IaAX3XtZnrsE3Raa9Pw30n08wG0fllkcWIKlA7VekuMCA3kJiHw
         vBvJrntCZLk6Xlq60v06lgHfFWxfRZ8PaM8jwcjMusAZX7hZMcTR+ZLjnAdTMDniTYBa
         4qSAULj9o4/FXp67/nlVWKsQROJqdPOMYg8TLnbm7cYw2MucyIhtcHympgNclzaiclwd
         WeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011855; x=1793616655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zpoGBsTQ1MMQtEr8iRtFOb/elu0nHODI5EyL2pzDfwY=;
        b=QuPNa36n3Ngjd3PpFTXXe33q35Os2clAnniNXFFU1/fYlSOjXVvE4+lArcyJ3ing1w
         zO5xbIuF0XI8xSl6loMzZhQQVgwZYOJu1WfRNQ8r416JfgfHcc1CSJfSToyvA+GAOQBI
         JRb61xqp3ebWlvvtW39PPFwRyZK2E8ri2X6SAJ259cNczQkwNGtdbZ56OKevIPjMjcFI
         JVUmyPcDBgvD2rxAql5CrfTiv9VAM2G56ySAnqeFjA5CSmzsuH05llBcEtNCzRO9AG+y
         j60TUwsJbW5MWMI6En1LkNlj7YlnddWwUcqKQiLrNWHHuhWn64w7cj1PsTUtguPY+UwN
         qM0A==
X-Forwarded-Encrypted: i=1; AKwUvByWNn/Wp4jpTtCpT7XiRBIZgRtqtC2SD83KnHTBQnJhRzrk2td2qHvaa3yIajiUwn0CCKdjlKs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcvsN3W6Gb0jJ4dBni8S8lGpA9FaC4gabHbPY1xW5TbGuvIfpw
	P/zYwaEX5mi/4fdjYyxc9KeeI1vtYBPsxTlboart02oSxc/Ebv+gBum1
X-Gm-Gg: AYBFou09ffBl61nCBF8fOHKCwUoQHHWjaSMa4TuYi2tj53uQaaaMxQ8gTNGONU3Y95t
	KQ+Cy7aW5llxroeopEvBTiDCyuR0O9f7tjnRPVEGfZXwN7uPgBQ3dEl0NnnDchkUnofc9N4YAyF
	9xxEW49ViEcNu8BGe2OleaZWDgSXTEbDqeaK3/lmk5OIijYy3mZJ4NOga1s5vZBW0KVEzE3rMsk
	43La0n1FZfbQN4xxQKXNvFxnLxfEmrts3419BlT4M/MrTn/i/s5TwTkBM3E56JF3KYGbYSc8KwN
	Qa8FPuKVEwYDE8yyrOOiSX3yueA5f4PN/AK6ZYqIH6r5gKyPWGpR7B5ZreuQlUGlviUGiUxyJyD
	gJ/+tQQVYBEt7/mzopFScWdQa3vnSnGJi23eR4pB1zd1m1kYAHJMCh3aciS8u7f0l+jjitfQByb
	E0OfpABT1szVsZPfERxTSTBzb8YRBlWia3CRsq5ou4e3LnXi+i0FeTyuwRRdZ+ow1xPjYWvgV/8
	3Gtb/tzDoM3MuCp745y/YaJZRORV+vI5EXAoZVF36PSopcWmj3FRMWwDuLgbDZ6oyblV4ZSUI85
	ZE2/m3FBnU3JS1YzPXw=
X-Received: by 2002:a05:701b:4586:10b0:196:4eeb:76e8 with SMTP id a92af1059eb24-1993562594bmr9140816c88.20.1793011854790;
        Mon, 26 Oct 2026 03:50:54 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:50:54 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] f2fs: reject non-directory parent inode during dentry recovery
Date: Mon, 26 Oct 2026 03:50:39 -0700
Message-Id: <20261026105042.1148554-2-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026105042.1148554-1-teel4res@gmail.com>
References: <20261026105042.1148554-1-teel4res@gmail.com>
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

recover_dentry() takes i_pino from the on-disk inode and uses the
resulting inode as the directory for __f2fs_find_entry() and
f2fs_add_dentry().  A crafted image can set i_pino to a regular or
special inode; the recovery code does not check S_ISDIR() and then
writes a dentry into a non-directory inode, extending its i_size and
changing its directory-only metadata.

Reject the record with -EFSCORRUPTED and mark the filesystem for fsck:

  F2FS-fs (loop0): recover_dentry: ino 4 is not a directory
  F2FS-fs (loop0): Cannot recover all fsync data errno=-117

Fixes: d624c96fb324 ("f2fs: add recovery routines for roll-forward")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/recovery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 54b524660..3e8054324 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -209,6 +209,13 @@ static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 	}
 
 	dir = fsync_entry->inode;
+	if (!S_ISDIR(dir->i_mode)) {
+		f2fs_err(F2FS_I_SB(inode),
+			 "%s: ino %u is not a directory", __func__, pino);
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	err = init_recovered_filename(dir, inode, raw_inode, &fname, &usr_fname);
 	if (err)
 		goto out;
