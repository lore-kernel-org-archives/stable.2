Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627383;
	b=5DGfp3dv2F/hSiipGBsQLK9KWk4SHa6WoqxVdEy2NCMxaGhiMqvFZtOB3zgsQ26SmgHf
	 8yonSfCI4tfwHBl9VviLklV9r1EXR4lQ3LDLIXV0CNI7pOUn9ZoliL7qOEPuGxR0x8ux4
	 O8Kb8AeEwFc+q/H20UnNFccd577UituAxjkchdZ0lhm4DQJ7opsonIi5whReoe13RbdP9
	 xMrmH6scoIOWHVKMsqa50Eo0hT71onkVtfJhxNcdvnaNlziwiQ9UniBGdIRzcd1tNXE1b
	 6J05gcQHI4VVCGiU69y1AwhcVREH5jY9oYYHT9yJP5+p9K0kFuRHNT54QgPz4/oBwPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627383;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=zAJ9Mn2avE5C30UeryxkBbMoYHhwjMDvxRsW3oXLKk4=;
	b=kOz3c9zbj5QE/yhCVRv8mNVXfRWwBfHlLea1dcbGS/rZClzZT338PpbXip78rnF7LL6C
	 tLOUJiVZnUj+UG72S/BD/cU/BPZcO533WhGFBXSly1ksOHXq94LeNJzbKuIwY6k8byBnh
	 BQrPDMG+WTJbj45Rxb7NmCaudb1J+tjbIc9igBTp0flrs3ejKsMzfmI5gvXVgWExxdMqn
	 SAWoz5qraTeXIv9Ej4HMN0t7yH7yjyssYy0jCbm/MwvgDVeo3NZP/yjA03gtuRQHOoqIm
	 sfhZ2wK107usHJZLDLM/gob8Vp0T0MYVDNCyoG+6VgLDolLbm5MOSnGnli/53Ow+k/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A391606A32F;
	Mon,  2 Nov 2026 13:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A391606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJCk82ycXz57HS3;
	Mon, 02 Nov 2026 21:49:36 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A2DnWZL086857;
	Mon, 2 Nov 2026 21:49:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 21:49:35 +0800 (CST)
X-Zmail-TransId: 2afa6ae894efd8b-13b89
X-Mailer: Zmail v1.0
Message-ID: <20261102214935612btR10gHRJy3yrzqeLcnE9@zte.com.cn>
In-Reply-To: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
References: 20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn
Date: Mon, 2 Nov 2026 21:49:35 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gdWJpZnM6IHJlamVjdCBtYXN0ZXIgbm9kZXMgY2xhaW1pbmcgYSB0b28gc21hbGwgaW5vZGUgbnVtYmVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2DnWZL086857
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 21:49:36 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE894F0.000/4jJCk82ycXz57HS3

validate_master() only rejects highest_inum values above
INUM_WATERMARK.  A master node whose value is below UBIFS_FIRST_INO is
accepted, and ubifs_new_inode() then allocates inode numbers starting
from that value, i.e. from the range reserved for special inodes.  With
highest_inum = 0 the very first new inode gets number 1, which is
UBIFS_ROOT_INO and is already used by the root inode, so two inodes end
up with the same number and the index is corrupted.

Check the lower bound as well.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index a148760fa49e..8a1ba81c10bb 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -191,6 +191,16 @@ static int validate_master(const struct ubifs_info *c)
 		goto out;
 	}
 
+	/*
+	 * Inode numbers below UBIFS_FIRST_INO are reserved.  If the master
+	 * node claims a smaller value, newly created inodes would reuse the
+	 * root inode number or another reserved one.
+	 */
+	if (c->highest_inum < UBIFS_FIRST_INO) {
+		err = 24;
+		goto out;
+	}
+
 	if (c->lhead_lnum < UBIFS_LOG_LNUM ||
 	    c->lhead_lnum >= UBIFS_LOG_LNUM + c->log_lebs ||
 	    c->lhead_offs < 0 || c->lhead_offs >= c->leb_size ||
