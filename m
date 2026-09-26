Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEF357CE9;
	Sat, 26 Sep 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438891; cv=none; b=X5+hdFtrwrKo9xT5CfES2J+6QWvpGPwkAdCriPRbX2XChJtDDijqnDrlH5E5DUXcIkVbe6+/cAZANIOxHvMv7zU7B5IS3ZJ77MMharDXihZFWFb/pRMDufCwTISsgGcy8ptGYcJf75tZb739SNuPF9bEv01oTekusgn3kBrCHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438891; c=relaxed/simple;
	bh=tqLckBEZHvSegR6zv+qVZBZSgGXz+gwBiExasXQX3fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWTv0XIoKfWPT/oNhztW9hTLq3Iy1/WBMS0vmBxZgC+ZvadQqw7s3vRv0f5h9av5y9nzg5g2Diobx/HM0uA5luei3JGugHP+gdY9ZjqJmj0NlEPizJhScNcLlBf5n7/e+o3+/DzLTYFFsoLX5fgumeyqAzelb4vjJyjaiXKz1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=pyPyB0br; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="pyPyB0br"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790438878; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vmew8F6cGoltC/zlxLQ/V2Ko/5hlJ0diq7QdLHv/b2g=;
	b=pyPyB0brJjkU6YAnShJGXKM0IIkWQV6CkkyiQwgYBV+8zTaTE+UOXwb2Rq/RtqMJHBUOnv6gcHy+vQ688j0/rgtzlsfW+V/qMqfSZd+m+Nva4H5U7ztHA5F8jfMba/p1QVMpYl8OBXo5u+fW4UdqqayrpUU9lLqd/ZHhOwgp64o=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0451441|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0306825-0.00118257-0.968135;FP=3451580394671390456|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jOPHQ-s_1790438876;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jOPHQ-s_1790438876 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 27 Sep 2026 00:07:57 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vringh: reject empty / undersized indirect descriptor tables
Date: Sun, 27 Sep 2026 00:07:55 +0800
Message-ID: <20260926160755.21485-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924030627.13287-1-fangxy@xiaopeng.com>
References: <20260924030627.13287-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move_to_indirect() validates an indirect descriptor table only with
"len % sizeof(struct vring_desc)".  A descriptor flagged
VRING_DESC_F_INDIRECT with len == 0 passes that test, so *desc_max is
set to 0 while *descs points at the empty table.  __vringh_iov() then
copies one struct vring_desc from descs[0] -- 16 bytes past the end of
the table -- before the "indirect_count > desc_max" loop detection
aborts the walk.  The over-read value is discarded when the walk aborts
and is never used to map anything, but the access itself is out of
bounds.

Reject any len smaller than one descriptor, alongside the existing
stride check, so an empty table is refused with -EINVAL and no
descriptor is ever fetched from it.

Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/vhost/vringh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Changes in v2:
  - Commit message rewritten per Michael's review: the over-read value
    is copied into a local struct vring_desc and never reaches the
    caller, so the security framing ("leak" etc.) is dropped and this
    is presented as the plain out-of-bounds read fix it is.
  - Code is unchanged; the diff is identical to v1.

Testing:
  Userspace reproducer carrying the move_to_indirect()/__vringh_iov()
  logic with an instrumented copy() (len == 0 indirect table, 2048-byte
  mapped region followed by 64 guard bytes):

    without the fix:  reads 16 bytes past the table end, returns -ELOOP
    with the fix:     returns -EINVAL, no read past the table end

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f..0767748 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -197,8 +197,9 @@ static int move_to_indirect(const struct vringh *vrh,
 	}
 
 	len = vringh32_to_cpu(vrh, desc->len);
-	if (unlikely(len % sizeof(struct vring_desc))) {
-		vringh_bad("Strange indirect len %u", desc->len);
+	if (unlikely(len < sizeof(struct vring_desc) ||
+		     len % sizeof(struct vring_desc))) {
+		vringh_bad("Invalid indirect len %u", desc->len);
 		return -EINVAL;
 	}
 
-- 
2.50.1

