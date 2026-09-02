Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BC41685A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342156; cv=none; b=YiQ3JB2ZuMAl2fxjbLQKJWHxxvQmmjNlr9b8YA7KQT1/fIDY3jLRue8ZswTZLCI6ynmCP4tJESIoLWevHvdvyiZRJ4IWwFXvZcCnGNWWIZQrRN8BIrWJxTI1sQFB84ZowwqUWWLh+Xs3WvBjmTeJJI8GQOlTF526w7bbF8ZL6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342156; c=relaxed/simple;
	bh=433trI6+oEXVqgdT4UrTuL7+1+EccinCYsJYQCSnr20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EkFX/mVaFiTmFco5B2ybQ8QABJ1Ypvk+gfgTCY+JDQGm3dBcoJD159JJvZriF5eLCvlFqUcWmv85LmZxLyzbamXY6LhGnxM26L3XzngVuYC5u0PXixPxM48Bs9qkyZE4PDU6SDhsu3tLO0ngNs2zCLsQLPZ1UXTJAWQ36Ns4rlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZd645fvbzKHMZR
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 17:41:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 953D840539
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 17:42:24 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAXgEx675dqi_DkAQ--.23253S2;
	Wed, 02 Sep 2026 17:42:24 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: raushan.jhon@gmail.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH 6.6.y] trace/probes: Fix memory leak in traceprobe_expand_meta_args() on $arg0 error path
Date: Wed,  2 Sep 2026 17:42:15 +0800
Message-Id: <20260902094215.1515011-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXgEx675dqi_DkAQ--.23253S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW7AryfGF1kAr4DXFyDGFg_yoW8Jry5pF
	93Kr9xKr18Jr4UKFZYvFn5KryFy3y8Jryagan5Cwn3XrnxJr40qrsIgFZFqw15WrWkt3ya
	kF4qqrZ8Kay7uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The backport of upstream commit 00a8ce2a2a9f introduced a memory leak
for new_argv.

The upstream kernel uses __free(kfree) to automatically release new_argv
on function exit. However, this stable backport does not include that
mechanism, so the $arg0 error path incorrectly returns ERR_PTR(-EINVAL)
without manually freeing new_argv, leading to a memory leak.

Fix this by jumping to the existing error label instead of returning
directly.

Fixes: 451ee0f9ca1e ("tracing/probes: Reject $arg0 in meta argument expansion")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/trace_probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2fa7b596f03e..1f55268fbf63 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1724,7 +1724,8 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 			/* Note: $argN starts from $arg1, so $arg0 is invalid. */
 			if (n == 0) {
 				trace_probe_log_err(0, BAD_ARG_NUM);
-				return ERR_PTR(-EINVAL);
+				ret = -EINVAL;
+				goto error;
 			}
 			ret = sprint_nth_btf_arg(n - 1, type, buf + used,
 						 bufsize - used, ctx);
-- 
2.34.1

