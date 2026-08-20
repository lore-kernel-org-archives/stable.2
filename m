Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8728A370AFC;
	Thu, 20 Aug 2026 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192354; cv=none; b=i9PsSF+fSFJ+jjoydHRT+wYDdnrvcr/eeWRgtLpzZz7JbevwrM3TuZrtMKdpLH4zzSmi8qQ7IA4Yh+KtD01EShA2GOwllfl3fW31qiO5yn5dfEvUubGMfsCjM4PkcE7HhcIEplsQrtI38KEu1vEuT3T7bSnHOe59wL5GJm9nBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192354; c=relaxed/simple;
	bh=Q4vnOpmdq8yMGzFxcBH0hfScW02YmBnIesFyAFY9Jek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZS9RBSinx8IszxoWpifk3b1ioXSUiSfd6+46u//+SeV4eiteOeN9JqVrtPqwU41I/+xld3V4b9l1qg5xMfiJTiyWflD8FjNmJkA07McTBNiBFsi0iXo7EYjTWA9UKuYBFh/tjuVWDlUI0R0JvHqfUHItMdTCJ5fn5XiNDRsf6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBH8zwZZIZq3GyrAA--.594S3;
	Thu, 20 Aug 2026 10:19:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCXUpoZZIZq8KgBBA--.27111S2;
	Thu, 20 Aug 2026 10:19:05 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org,
	tj@kernel.org
Cc: chenridong@huawei.com,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] kernfs: recheck of->released after acquiring the active reference
Date: Thu, 20 Aug 2026 02:18:10 +0000
Message-Id: <20260820021810.163082-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCXUpoZZIZq8KgBBA--.27111S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?MW0qewXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGQXeKY+XhMOLM+jBDyGHIiSSNfzltiyPRG/I89NU3pWLLF
	H6zPj208BhChSJWIGubN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxZFW5XrW5Zr48tFyUXw43urX_yoW5CFW8pF
	4fGr4xXr17Ar1DCrsrAF1xuryFv3s3tFW3Xwn7Jwn3A3Wjkwn3tw1Ygr10gry5Jr95Jw4Y
	v3W7tFyUta45ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
acquiring the active reference on @of->kn.  A hide/drain/show cycle can
run between those steps: the drain path releases the open file, and the
reactivation lets kernfs_get_active() succeed again.  Any entry guarded
by kernfs_get_active_of() can consequently run its file operation on an
already released open file; on the cgroup pressure files, the poll
callback dereferences of->priv while forming &ctx->psi.trigger and can
hit either stale, freed memory or NULL.

  CPU 0 (kernfs_fop_poll)       CPU 1 (echo 0/1 > cgroup.pressure)
  -------------------------     ---------------------------------
  of->released == false         kernfs_show(kn, false)
  ... preempted ...               kernfs_drain()
                                   kernfs_release_file()
                                     ->release(of)  (frees of->priv)
                                     of->released = true
                                kernfs_show(kn, true)
                                  kernfs_activate_one(kn)
  kernfs_get_active(of->kn)
  ops->poll(of)

The cycle needs the file operation to be delayed between the two
steps, but kernfs_show() cycles like the one above are fully
userspace driven.

Acquire the active reference first and re-check @of->released under
kernfs_open_file_mutex.  While the reference is held, @kn cannot be
drained: kernfs_drain() waits for kn->active to reach
KN_DEACTIVATED_BIAS before draining open files, and the only other
kernfs_release_file() caller, kernfs_fop_release(), is serialized
against in-flight file operations by the VFS.  Since
kernfs_release_file() sets @of->released under the same mutex, a
false re-read settles the question for good.

This issue was found by an in-house static analysis tool.

Fixes: 3c9ba2777d6c ("kernfs: Fix UAF in polling when open file is released")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 fs/kernfs/file.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9adf36e6364b..561f66e4095a 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -73,12 +73,22 @@ static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 /* Get active reference to kernfs node for an open file */
 static struct kernfs_open_file *kernfs_get_active_of(struct kernfs_open_file *of)
 {
-	/* Skip if file was already released */
-	if (unlikely(of->released))
+	if (!kernfs_get_active(of->kn))
 		return NULL;
 
-	if (!kernfs_get_active(of->kn))
+	/*
+	 * @of->released is set under kernfs_open_file_mutex.  While the
+	 * active reference is held, @kn can't be drained anymore and
+	 * kernfs_fop_release() can't run, so re-reading @of->released
+	 * here settles whether @of was released for good.
+	 */
+	mutex_lock(kernfs_open_file_mutex_ptr(of->kn));
+	if (unlikely(of->released)) {
+		mutex_unlock(kernfs_open_file_mutex_ptr(of->kn));
+		kernfs_put_active(of->kn);
 		return NULL;
+	}
+	mutex_unlock(kernfs_open_file_mutex_ptr(of->kn));
 
 	return of;
 }

