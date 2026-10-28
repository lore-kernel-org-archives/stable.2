Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219627;
	b=E7LWIkmeLJ7THRelekQ045YlhJspyWVysgG6yMr0F+YHnxxwREddac2u3nXXlnCB66kG
	 cxUftJr+YXkNkZ8JVlFLcc7WSU20fLKE9depf7IA7DTJzSwtU7EyTSgRJwqZZZ1a0YMiw
	 f3C2Rvr+Uw8747sipXIHleBMGDk3QktF0FDDei5PItFAZ6/H4pEgs0aD0O4D1KrqKsmSM
	 a8yzC/5EO9FAFAJ+UzX6kETq70wIaBZN0beo4N63U5BW6URRtpWR7Q7JZiTcxAmV7Uom7
	 ug/zsduCgg4Re/0hANiZAnaM6bBDwRE9sCuyymQvmNVW6QZqy+Wo6OcDpMO5ynHTheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lb/W93mWkP3TBmUhejtZ18o//62t4qTaZxB1+dKBVHs=;
	b=Rl69MaPaDWmMTJfzNDiXfyB88ecWFZS4MlIl1SETMSo1Q/Ej1gW5vGozfdNfBVwGQuMH
	 fngczhw6D9lzRWJ11+Il8Z1V7putoPDWaSZkAlbJU8PSsjGNFfxpMZnP81Rj7sokUsjiF
	 FNvrawfmnq+njlqyK71aq5bL/sDzYuaX/w9HAtDuDw4/8lqoRTK3JxrGEG0mPC6GwEpuD
	 2GQ3+qv/ULURKTxbSlqz81C0tx5gKiASHOunMNqFTV6UwHd7tRe6/Sx3l20uqFwqcN0OQ
	 A2iycEKJgK4xYPsNQHH3qfLC0oopCnyEaNrS++e8xxAeqljqBcZq5pWXsxd5ikR9SFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VIAHYoX/";
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF617606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF617606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIAHYoX/
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-143255db95bso127658c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793219626; x=1793824426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lb/W93mWkP3TBmUhejtZ18o//62t4qTaZxB1+dKBVHs=;
        b=VIAHYoX/gWbWjx34bja30pDruefzNGvjIYWXpOMoYXWW1mUOtOZlhkvEbPwNePYFUn
         QfUIJQixpcDi+reeukzBUdBkhjA55ttY+/3fETjJdUOW42FIxNYzDebmi7iCh2VWl/ln
         ze5aI4gcNybe7B7pq1gtOGt2W27Tt+dYcpcb9tWCgdnIFk8QRtvL6+ROASGzsvO5gLbH
         JZLIbEqVx5aY8Ke7U/Va1aHI+iEx3VlpkWO6TdszAMuDSf/kKvcWRuc2aejFyJYHcI38
         VhZ6b5Te9kYxtYtCfqqZWVZNG3QlQFpKwz3bQ2SeBxyRwFd7ltstAnke9Y+vHzAmf5A6
         OQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219626; x=1793824426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lb/W93mWkP3TBmUhejtZ18o//62t4qTaZxB1+dKBVHs=;
        b=GlgA4RdbJ4/inC4ou+IjOmeiqPcm2U74ZaWlE2R5937cPrXvp7xH0gWid7/o0/rnMy
         YETzSYG1RF+DUP2Xvjzw77L6MzTwPraQ8logafgIUYLdQUwmrRvGZ63EtSCllQ6+s/kR
         7ND1/of6vJ/LfsiUZwx6oDwm3s4fM4avvEZ/P8sslAJVdy02uqHwQxEDmdzXRhU747k5
         hl5imp4z5qMn54DGRHAbHiKVO3hXlIiCIZ1zG/cO/0QvlX8J84p+2csCa86UbrmKCTOA
         LzqCmx7ZEIptlCBf6rokdEzkIskef2moZBwqBpC6Tvt4/xRr785lE5F6Q5IRch5cJYOt
         mqVg==
X-Forwarded-Encrypted: i=1; AKwUvBwt9ftE+5pjeou+4iibTvVJsXu2kLEzl30ihEkSRUp7IZ9irmSezZW/VfJnLW3yDClNzK+wAek=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtHB44M9ao2dqQCVAQTuh5fw2fMAH19h/kAgPcjXxJbyRXnZoH
	2wA23p0AnIZ+eLNpM1FuurCenV4i1OjBS0vhZMVOB8fVATQjh5lqkMw1
X-Gm-Gg: AYBFou3oJEbW+vODBO2YcaVPecBs7qrz9CIohuoux1xTIzVQZqKtANU9HcsMgKDbI86
	DqtqAyYXJ6gG8AVeEM7mfl2muWIFvumlORlTlGdBxhamFhRbpRMHbAf3dpBP9T341La582KiniB
	ByI6DE7hvW5IwEofexYRWLP36Vmm8RxZDNyta94EnGHbPucnj9tjuzulaDxkUZgJnGfm4CSDSo2
	G0CrieyicYoW0zKa4EQ2ReaM6F/PZ6R20wyUJeBLqGP+z7ltoOkkurFr0ZAH7r8OUllK8VTOve0
	Fh6MbO94K7BSAq9x/Bx4mw2PIyceUHjHpaltdHksJVw0Vty3ztRR59o42x8inw4bqvUwtMFQDV/
	/XU6pBKXIG6fyZFtH5PFUu2Oj5JT9/uafzB5W8MYgb4iJusSBftLjul4D+oYR9D1Zw9bIXb4FAN
	wBCkYZkPqmtOrQhFj4gTiwQbkvu18Lo/HTnR/biLqvQ7nt7dcKWZjbhQq+2ECkZhZ1xb3gBlHIT
	XWzz5xYEwE0EXPhfHMbFdYvyWU3hLpCMWpWHeF+4aOF616vkl6mkuSDXFMUL8Ct0ux5dHgOuF5z
	89tFC/qL0uzzUB36UqQ7VzgyoeVl1bYx6/yXTdDQ3sEVRM6kXRA+aHAhlE5XjsYlCgwQQjvIONO
	Stg==
X-Received: by 2002:a05:701b:281c:b0:16e:c820:b20d with SMTP id a92af1059eb24-1a6c87bcdabmr3617245c88.5.1793219625684;
        Wed, 28 Oct 2026 13:33:45 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e5c6d4fsm14699522c88.14.2026.10.28.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:33:45 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: linkinjeon@kernel.org
Cc: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] exfat: fix parent link count when replacing a sibling directory
Date: Wed, 28 Oct 2026 20:33:24 +0000
Message-ID: <20261028203324.6073-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

exfat_rename() adjusts parent link counts only when a directory moves
between different parents. Replacing an existing empty directory in the
same parent also removes one subdirectory, but leaves the parent's
link count unchanged. For example, renaming one of two sibling
directories over the other leaves the parent with four links instead
of three.

Also adjust the parent count when a target inode exists in the directory
rename case. Keep same-parent renames without replacement and the
existing cross-parent accounting unchanged.

Fixes: 5f2aa075070c ("exfat: add inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/exfat/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 68ddb9c5504f..24110e7fde47 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1309,7 +1309,7 @@ static int exfat_rename(const struct mnt_idmap *idmap,
 	else
 		mark_inode_dirty(old_inode);
 
-	if (S_ISDIR(old_inode->i_mode) && old_dir != new_dir) {
+	if (S_ISDIR(old_inode->i_mode) && (old_dir != new_dir || new_inode)) {
 		drop_nlink(old_dir);
 		if (!new_inode)
 			inc_nlink(new_dir);
-- 
2.43.0

