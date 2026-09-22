Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE7542ED5;
	Tue, 22 Sep 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080206; cv=none; b=ZOc3PVlSXhViWK+qQOTLKbQwAZCsiBts1QTIl0B41LbPlyi4m8+8bdMFXIoP9z2scsrYt6F9GWZ/F+COEI14n/T838j7uHyVFlwQWP5DG6MtAlfVfTB4etWnX9/fz6nJlJwTEzzwTW23ecJWyt3AzLSzxfpFKdzO4bX1spbpIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080206; c=relaxed/simple;
	bh=kvjYLm/dk+4s+Mv6NTFfsPwA0UEVspm+3CjszQbYoBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD0PuAexFloy8xTDOsu3zfaHdsI8utzz1oHENgJoXC/i0AGJRL0S38iFIbDuyYBmrXXhQFYhq3PKbGfYfpg2X4QzgWAuYgsfUK+7/jji+FM+SwrKT+64gUNLwud1fvTh7v1lsDzR+qsX7MWRu3vpkmkjT6TRGFw1S4ktN9aNdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=VRFqtcBy; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="VRFqtcBy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790080199; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oMlXdrGUkDd2x+R+qGZUFmpS/mij8+4hCn9f+C8UqJ0=;
	b=VRFqtcBy/udJEN0XiTMvup82I1/j8Z+mJk2KwdnGAAuHgfqzbqYTpXMmulJQ9aqaX1H5RplAYbSUeYKa6tsBlassdAr1M0uugDQFKFVc+xXqMZwXUIZEMu3uwih5CW/CUakyrNLvRSJsIoei0r3/PaHOy0rnEgzTpCmnqSTVa60=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04471682|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0180885-0.000132619-0.981779;FP=12497215314873208052|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jK24y7w_1790080198;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jK24y7w_1790080198 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:29:59 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xie Yongji <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vringh: add regression test for cyclic indirect descriptor
Date: Tue, 22 Sep 2026 20:29:55 +0800
Message-ID: <20260922122955.69433-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922122955.69433-1-fangxy@xiaopeng.com>
References: <20260922122955.69433-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a case to tools/virtio/vringh_test.c that builds a top-level
indirect descriptor whose NEXT points back at itself and checks that
vringh_getdesc_user() rejects it with -ELOOP.

Without the preceding fix, the walk re-enters the same top-level
descriptor without making forward progress: count stays flat, so the
traversal limit is never reached and -ELOOP is never returned. With the
fix, the top-level count advances on each re-entry and
vringh_getdesc_user() returns -ELOOP once the traversal limit is reached.

Use index 1 rather than 0 for the self-cycle, since returning from an
indirect table is only performed for a positive up_next value. A
self-cycle at index 0 would instead terminate the walk and would not
reproduce the bug.

Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 tools/virtio/vringh_test.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 84961b9..2a5d7f7 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -458,6 +458,8 @@ int main(int argc, char *argv[])
 	int err;
 	unsigned i;
 	void *ret;
+	struct vring_desc *ind;
+	char *data;
 	bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_range *r);
 	bool fast_vringh = false, parallel = false;
 
@@ -755,6 +757,45 @@ int main(int argc, char *argv[])
 		vringh_iov_cleanup(&riov);
 	}
 
+	/*
+	 * Regression test: a top-level indirect descriptor whose NEXT
+	 * points back to itself must be rejected with -ELOOP instead of
+	 * looping forever. Use index 1 rather than 0 so that returning
+	 * from the indirect table re-enters the same top-level descriptor.
+	 */
+	ind = __user_addr_max - USER_MEM/2;
+	data = __user_addr_max - USER_MEM/4;
+
+	/* Fresh ring and host state; resets last_avail_idx to 0. */
+	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
+	vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
+			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
+
+	/* Single-entry indirect table pointing at valid data. */
+	ind[0].addr = (unsigned long)data;
+	ind[0].len = 1;
+	ind[0].flags = 0;
+
+	/* Top-level desc[1]: INDIRECT, and NEXT loops back to itself. */
+	vrh.vring.desc[1].addr = (unsigned long)ind;
+	vrh.vring.desc[1].len = sizeof(*ind);
+	vrh.vring.desc[1].flags = VRING_DESC_F_INDIRECT | VRING_DESC_F_NEXT;
+	vrh.vring.desc[1].next = 1;
+
+	/* Publish head 1 on the avail ring. */
+	vrh.vring.avail->ring[0] = 1;
+	vrh.vring.avail->idx = 1;
+
+	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
+	if (err != -ELOOP)
+		errx(1, "self-referential indirect: %i not -ELOOP", err);
+
+	vringh_iov_cleanup(&riov);
+	vringh_iov_cleanup(&wiov);
+
 	/* Don't leak memory... */
 	vring_del_virtqueue(vq);
 	free(__user_addr_min);
-- 
2.50.1

