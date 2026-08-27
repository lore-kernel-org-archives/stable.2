Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24533B6FC;
	Thu, 27 Aug 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812387; cv=none; b=SIXQf8g7lEaUb9DyOuATm1GZbNYkBhTYE4c1K+08+3Um/ioyFjK/X6xYc61cEmAKq4ZKhVYuAb0a3/wh4wcyVNPdfsAG9+em1dojIWTboQycp9PwmgVX9A7AH+ex7DPS8SW4jWng2y8N9uKZMQHSnEkJO8KruAc3YZPj3Pujf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812387; c=relaxed/simple;
	bh=2lgJVWDLJSRQTDln7hZ5jKmiXAVgwNTHvtaG7S34XZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nw9WESIvaOeOMxb9xkUbR7ER5olAbGXymEBWxIcb9LEM2F6rXO0SK727vAISPeMdVQIFPV1Sl+B9BX8cIl9NTu5NuA7OVb/n7dscmNH56wncy+TH7HJ1dPlbEpzrKXRrs6W2JP+UOnD2wYt1kQ20kHHarL1MIDygDwRnM0MUWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QLpYWgV9; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QLpYWgV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kF
	XxZJ9VVh7dL52uS7/oN/owmsUDo+btzoy5sSb0lOE=; b=QLpYWgV9+o0HGKpRjp
	zPTLG1P2Ps8FN6YgX/nxB6gFupqxvydMDiDDMzVA4tn7lmczwq6Y6MuCxCjh/aLq
	OYi8apR81vgPyfzh+CtvCqbQHJj++YXA8+yMDj7C4UHpaCYwDWpDrD0/1JF2YAh1
	owqh+yQ6Cyc6A7TVmz1WD2YwM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3j4oG2o9q0hcgSQ--.17256S2;
	Thu, 27 Aug 2026 14:32:39 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v3 1/3] md/raid5: set pool_size before extra_page allocation to fix leak on error path
Date: Thu, 27 Aug 2026 14:32:33 +0800
Message-Id: <20260827063235.85375-1-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827023803.36602-1-ghuicao@163.com>
References: <20260827023803.36602-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3j4oG2o9q0hcgSQ--.17256S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryDXFy3Zw47uF4fZFyxXwb_yoW8Ar1Upw
	srWw1Yg345WryrGry7C3y8uF1rtw40qrWxCFW5W3yqvr9Iqr9agF4rXa4YgrWkAFnakayj
	qFZ0yrs8Jry5taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrL05UUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC4Ac2yGqP2geuKgAA3l

From: Cao Guanghui <caoguanghui@kylinos.cn>

In setup_conf(), conf->disks is allocated with max_disks slots and
extra_page is allocated for each slot.  However, pool_size remains 0
(uninitialized from kzalloc) until grow_stripes() sets it later.  If
any allocation or initialization between the extra_page loop and
grow_stripes() fails and jumps to abort, free_conf() iterates
pool_size (= 0) times and skips the extra_page freeing loop entirely,
leaking max_disks pages.

Set pool_size to max_disks right after the disks array allocation
succeeds, so that free_conf() correctly frees all allocated
extra_page entries on any error path.  This is safe because:

- If kzalloc_objs(disks) fails, pool_size stays 0 and free_conf
  skips the loop (kfree(NULL) is safe).
- grow_stripes() later sets pool_size = devs, which equals max_disks,
  so the early assignment does not change the final value.
- resize_stripes() only updates pool_size on success and reallocates
  the disks array in lockstep.

Fixes: d7bd398e97f2 ("md/r5cache: handle alloc_page failure")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/raid5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7732,8 +7732,9 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	conf->disks = kzalloc_objs(struct disk_info, max_disks);
 
 	if (!conf->disks)
 		goto abort;
+	conf->pool_size = max_disks;
 
 	for (i = 0; i < max_disks; i++) {
 		conf->disks[i].extra_page = alloc_page(GFP_KERNEL);
 		if (!conf->disks[i].extra_page)
-- 
2.34.1

