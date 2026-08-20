Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B01714AA;
	Thu, 20 Aug 2026 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208843; cv=none; b=pw59dYHtgx/PDl+Xu/qOTqlLXe0GcOFvUaYiLWgcNrhl7k5maYNlyOyKgjnix6mS4otvZjWspn13YVXz/e9/FHih/3f4gizdXFMitSSLc7fk8DPeZ+HRIPYTFnt7mXQ4clxNkFT0nbyqwxZsjLnwT7GLxZ5kbkiS7xQC0nVvPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208843; c=relaxed/simple;
	bh=0P/PA7Id22qKU77FALfOINJAeUDFVfM3Cye6rbcBpgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H/4rVopwUr0TnJyqRfDbzRormznTWXJ2EZRjKFzDXgTw9H5ACbxu83P7NdHbHcISiwAQqO8K1RnMOQi0PeMqFHVml6EalV2AeBW80RNptJ5oC4doEdbcM7Ppy5ziDArERmKAsq4oUSzaqwt2uGqJ7gIwtHkVp0RqOOVMrl5fXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3_y97pIZqQW+sAA--.2727S3;
	Thu, 20 Aug 2026 14:53:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgC3BZ56pIZq6LYCBA--.31554S2;
	Thu, 20 Aug 2026 14:53:47 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: agruenba@redhat.com
Cc: swhiteho@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: Add rcu_barrier() before free_sbd() in fill_super() error path
Date: Thu, 20 Aug 2026 06:52:51 +0000
Message-Id: <20260820065251.88719-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgC3BZ56pIZq6LYCBA--.31554S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?cO2JdQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBFfFt0bGohL8E29ILBJeWu5VXnR1NJ95UAX55X4hcKqH16j
	lqWgsXGU0+VYJX3OYfbN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw47GrWDXFyDJF4fAr47GFX_yoW8AFWDpr
	ZrAF17KFWDKry7uw4kA3Zag3W8t3y5uFsrCrW0gw4YqrnxXw12k34ktr42qrWYg397A3s8
	Xw1qg347XFWDWFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Xo7JUUUUU==

Commit f9c9ec2c319f ("gfs2: fix use-after-free in gfs2_qd_dealloc")
added an rcu_barrier() before free_sbd() in gfs2_put_super() so that
RCU callbacks which dereference the superblock through qd->qd_sbd have
run before the superblock is freed.  The error path of fill_super()
frees the superblock through the same free_sbd() call, but without
waiting for those callbacks.

Quota objects can be alive while a mount is failing:
gfs2_make_fs_rw() runs gfs2_quota_init(), which creates quota data
objects for the entries of the quota change file; if reading the file
fails part way, gfs2_quota_init() itself calls gfs2_quota_cleanup(),
and a withdrawn filesystem makes gfs2_make_fs_rw() call it as well.
Both dispose of quota objects via gfs2_qd_dispose(), which ends with
call_rcu(&qd->qd_rcu, gfs2_qd_dealloc); gfs2_qd_dealloc() then
decrements sdp->sd_quota_count and may wake sdp->sd_kill_wait after
free_sbd() has already released the superblock.

Mirror the unmount path and wait for pending RCU callbacks before
free_sbd() in the fill_super() error path.

This issue was found by an in-house static analysis tool.

Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 fs/gfs2/ops_fstype.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..7425720697ef 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1314,6 +1314,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_iput:
 	iput(sdp->sd_inode);
 fail_free:
+	rcu_barrier();
 	free_sbd(sdp);
 	return error;
 }

