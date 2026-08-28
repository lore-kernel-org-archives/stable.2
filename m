Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99AD21C173;
	Fri, 28 Aug 2026 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889915; cv=none; b=Ib8DfPudxCxCvPJSwDBGat/gpjCNbzeFFPX0dc1xit1Y3d4q1uo9N7ZkYJVDLJeBHy3ayMdQmvpbe2nAzDRNnne7evOednVX/U5TfDxD7FZg0GVoHhqjd71lDmEl4seYgaexAnbhu/lO0QWdf2K9eeSV5Js6c1NDrXGB2o3NawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889915; c=relaxed/simple;
	bh=ug4Wy3wBJUcuCXxvPXvLKPYJRwW8MtrVX/USNQJOnmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kWT7rn0NR9aol/aZfi8l2JdfrMXPpyGLM2AoO6A2vOv2ABv5SLULIefJRjqcrvFaDcc4lmCbDmv1iAgnsAw9Fyxoi5PTtvwmussp/IDydJadSlboNiNxDetH6x/pdgGPlyWGRlXfX2UNNykdTqkbjeyl6lHjhDJbrEvlNxQZYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBXQT_hCJFqZhXOAA--.1313S3;
	Fri, 28 Aug 2026 12:04:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c7dCJFqX_QuBA--.63973S2;
	Fri, 28 Aug 2026 12:04:47 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org,
	tj@kernel.org
Cc: chenridong@huawei.com,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] kernfs: recheck of->released after acquiring the active reference
Date: Fri, 28 Aug 2026 04:03:48 +0000
Message-Id: <20260828040348.1809278-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c7dCJFqX_QuBA--.63973S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?FOFEVgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI3gGUhJIyk5DkEkhl6m75AgdOplLpL3Hqq6nhqan3ICX0ks
	AbKSuAhYMJqOa/3GhZKp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxZFW5GrW8XF4UZF13Jr13trc_yoW5uF48pF
	WrKF45XFZ7JFyDCrsrA3Wxua4Fv3s3tFW3G3s2gwnYy3W5Kwn3t34Ygr4qvwn5XrWrJF4j
	v3W2gryUtw15ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

kernfs_get_active_of(), added by commit 3c9ba2777d6c ("kernfs: Fix UAF
in polling when open file is released"), tests @of->released before
acquiring the active reference on @of->kn. A hide/drain/show cycle can
run between the two steps: the drain path releases the open file, and
the reactivation lets kernfs_get_active() succeed again, so a file
operation can run on an already released open file. On the cgroup
pressure files, the poll callback dereferences of->priv while forming
&ctx->psi.trigger and can hit either stale, freed memory or NULL.

Re-check @of->released after the successful acquisition and drop the
active reference again if it has been set. No lock is needed:
@of->released is only ever set to true, the drain which sets it
precedes the reactivation under kernfs_rwsem, and the fully-ordered
RMW on @kn->active in kernfs_get_active() then orders the read after
that reactivation.

To allow the lockless reads to use READ_ONCE(), drop the :1 storage
from @released and store it with WRITE_ONCE() to match.

This issue was found by an in-house static analysis tool.

Fixes: 3c9ba2777d6c ("kernfs: Fix UAF in polling when open file is released")
Cc: stable@vger.kernel.org
Suggested-by: Tejun Heo <tj@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v3:
- Drop the :1 bit-field storage from @released so that READ_ONCE() can
  be applied to it, use READ_ONCE() for both lockless reads of the
  field, and add the matching WRITE_ONCE() on the store side.
  READ_ONCE() on a bit-field does not build, as reported by the
  kernel test robot on v2. The logic is unchanged from v2, where the
  Acked-by was obtained; happy to drop it if you prefer a fresh one.

v2: <20260821050720.14848-1-fanwu01@zju.edu.cn>
lkp report on v2: <202608230046.Ixvo8Av6-lkp@intel.com>
---
 fs/kernfs/file.c       | 10 ++++++++--
 include/linux/kernfs.h |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9adf36e6364b..98adceddbcfa 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -74,12 +74,18 @@ static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 static struct kernfs_open_file *kernfs_get_active_of(struct kernfs_open_file *of)
 {
 	/* Skip if file was already released */
-	if (unlikely(of->released))
+	if (unlikely(READ_ONCE(of->released)))
 		return NULL;
 
 	if (!kernfs_get_active(of->kn))
 		return NULL;
 
+	/* @of may have been drained in between: recheck. */
+	if (unlikely(READ_ONCE(of->released))) {
+		kernfs_put_active(of->kn);
+		return NULL;
+	}
+
 	return of;
 }
 
@@ -762,7 +768,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 		 * and being drained.  Don't use kernfs_ops().
 		 */
 		kn->attr.ops->release(of);
-		of->released = true;
+		WRITE_ONCE(of->released, true);
 		of_on(of)->nr_to_release--;
 	}
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b5a5f32fdfd1..e95e333e24ea 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -269,7 +269,7 @@ struct kernfs_open_file {
 
 	size_t			atomic_write_len;
 	bool			mmapped:1;
-	bool			released:1;
+	bool			released;
 	const struct vm_operations_struct *vm_ops;
 };
 

