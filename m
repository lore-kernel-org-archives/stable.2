Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1A3BED55
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360813; cv=none; b=JPvgDUUhRM2y75LoexNOBRRMxLL4f4P1bszyfjFYBuGTnI46e2Xxe/w6E/97nJAgcCBJ1Qazxb6399XLlUKvL0Yhb5rjl+3ymW56NANcxc8ZgOuo/ZCEL/ZsmM5cLWaLXazUxQot29LyVgr+uDs5k+91NDWQE15ag0XdUOmB4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360813; c=relaxed/simple;
	bh=bsnh9gOaL7Rt2V+xeyeNRAfwOn3S2p6enNw0gjImK+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvQB7DDPp4BBvv62PKQC173ITjdZp84vK/9Q7srwnOM1JEWdDaC6qn35zGhlkRD8rvbo43/ZdrJ0dCsPtvgHQ2TD+LR9yyleV4KKEISBPXM9oYeccAFw8hV8+7ds5/WYAUgRPHmzg8m1KI8o44vs5Iqx28kL/yGMybaVkAWdaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5y846/D; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5y846/D"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacb8416a1so27286275ad.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360811; x=1783965611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1i9opHM4bOHdKev3pbWNXUYFj+izXMcvOiuJ5Sb6Isg=;
        b=M5y846/DuX4UOzda7uWIICWGFGodw/V1ifn2QtF6j19meuUUn5GEf1LCo8S2AgBiyv
         NRGKuJqqZFADBBNW541GflpI3yq9Vw4mAHKLgQYeqvgwbM/qfrEdhTsssHmmHd5SNmF6
         nItcviU66RhAFFbpAdDOYFbQwAM7Vr+9DcHSS4SI/yzrFdOicPL4h70KOvdoi+7jZJno
         7jqekoG4mPzejT43gwju9lNRQfOVwgzgGqXWv7JOzMjcNR1VNBf0f/Z/bI79gjJe4ls7
         94BsTtbj+rO9PmQK2gsT1vmC+zfea743StaK3zNAGCyKXG9enkwtZjgxifM/F8nr0SFm
         mFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360811; x=1783965611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1i9opHM4bOHdKev3pbWNXUYFj+izXMcvOiuJ5Sb6Isg=;
        b=f78q+fx5Nhy3x7iY8fQkoL9PoEK+vDptuyM0xIU7oPH8twwwc0DW7dKZYgEwx+Ioe5
         ys3mArnzZ39qvTFihBL23RynG39VdC3zuMCL5DJ3ri7sGnf7Ck6UPF/q3ErEZij1Cco0
         tOS+sKZJyWo8KWHyrP2bV5D9fa8i/Bxzljjacz3Omgl1gfjZAfBRDY+3A5AhNkKUlA/n
         +h6cyDul3NGl5u8xj9G0o9up+akyKwMh9BD/uJWAlQD9qe2VzZFDav/+4O43v+mumS5p
         iqwzzgbKpt+fDlTuT+E2jBkFfVQywtRL6Agf9E4ImroIj8ujXKTaak/E2ykTOZnoMBh8
         8fZw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/OdlTivudAGr54B8iIuwsLoT+/y/zMGNoRoqpHeies2ZepbdGSL3jFyJpsHtPrOodhE0hZs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPs0uaxMyuupSmafAYSFsa4396ozS3G4B8bxudnGuPl+1QQQ8
	5gm1IoCHehekmly5Fg5OcsKY7l2+eRZqXE12nSbwmt6LyPeS7laoo+eh
X-Gm-Gg: AfdE7cnoYSZ42f6XcActlAq6eHIE3JetFyQN/JO7irL6VQxxdXhYfmv1amcdriVuCzf
	BVc+YDyLtECCGy1DvtwY7xu72dT+8ZbBF7zzqwMrB0axn2x5D1vHJMg0HvdKOgL/48jUOsbfhm/
	ZqgrCNRNioxCxf02IIfLcMo5qhUR8Qz5SU01LkJMbEylDAAB6bgSaRe5jdQT0Od/XXBpQKFZIO1
	AKriLglDg5SLeguAwJviJ90obJVIrekvkvobnOv8WIB+z8L4RI1XIZgx1V8TqQcieBt1785RwhA
	O1p1cySNbHekrXH6TuzZfReuQB0RXJl7Voj1NJ5ZbUvl/j/RukwRYwGwri7JcTDo0NNv8r+kgh1
	p2TmAjoSlzRhz7IpngsZt1QzbXBCnSoOronXeXzeFP1gmjLqbyLC9QX8+NwpJlambeOtyhoxZEk
	ucDLkSCgrZ9gPGs4X0bb+6Zzc=
X-Received: by 2002:a17:902:ced0:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2ccbe617d59mr15890325ad.4.1783360810922;
        Mon, 06 Jul 2026 11:00:10 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893dadsm54829455ad.74.2026.07.06.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:00:10 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: anprice@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	stable@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
Date: Tue,  7 Jul 2026 02:00:03 +0800
Message-ID: <20260706180003.2124317-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A corrupted GFS2 image can store a dinode size that is larger than what VFS
i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
writes it directly into inode->i_size. If the value is larger than S64_MAX, the
incore i_size becomes negative. That negative value can bypass the existing
stuffed inode size check:

inode->i_size > gfs2_max_stuffed_size(ip)

Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
passes it to memcpy(), turning it into a huge copy size and triggering a
out-of-bound issue.

Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
inode->i_size. Also make the stuffed inode check use the raw on-disk size while
it is still unsigned.

Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
Changes in v2:
- Drop the defensive unstuffing changes in bmap.c.

 fs/gfs2/glops.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424ee64..8c5d257451d5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode_state_read_once(inode) & I_NEW;
+	u64 size = be64_to_cpu(str->di_size);
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
+	if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
@@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	i_uid_write(inode, be32_to_cpu(str->di_uid));
 	i_gid_write(inode, be32_to_cpu(str->di_gid));
 	set_nlink(inode, be32_to_cpu(str->di_nlink));
-	i_size_write(inode, be64_to_cpu(str->di_size));
+	i_size_write(inode, size);
 	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		return -EIO;
 	}
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.43.0

