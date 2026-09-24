Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74361FB1;
	Thu, 24 Sep 2026 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219201; cv=none; b=kXWrysJVo5PEPfFVF0mtS+DmEsewIwlk+fNAPmHp6GnMfRjVzZbisikbzlSW02+dRxZH+J93jn5oVNTfok/z2pyb5x/Jxdzqt2AAVuoz+dx69GXDn+yPjRzNlOlgRC9LpA4DnCAa3KfgUHvSa/BeyfNY0f31gpW7i2N6WKSNAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219201; c=relaxed/simple;
	bh=bkhYpMcrAiICTVt+GNfTLJqStsMAKAtfAZSF0zLbZgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPGyLCUs+qZR4D2sBbgRzh9t6av90B5Il4+v4xTw4CHxnTmeQJTWKuyp6ms+ZaUQj37dkfu5DC/dXiSmsntxye1jWzhC091vUFFI0mPXfujPauTvjpJTsGUl9JNGezkerToLm/W8d4kir6xExJhKQZJP7v0oIBMyAcGfgFljj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Bq5v7cXg; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Bq5v7cXg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790219189; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=e9NnjNC3yj4jUQFmf6bV/aw5OleziQIh8AoZok0FKXA=;
	b=Bq5v7cXgwdgX4oR0qAbupunS0svDIt2/N6HZ7KlaDYZJ7G0TasO/X19h0zS2wt08ggyyC34XfSB2Ls4WZ8xVEKsO5CW0wV+eiH5cmxI9YF0wqy5jnvtNmE6HssICPz8gTVm7GXm3rp7dEN9Dd1/+/MitJ/9vFN3i1rur9ZwTkJ0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04495044|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0204653-0.000953312-0.978581;FP=12604583687347453685|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jLi.gVo_1790219188;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jLi.gVo_1790219188 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 11:06:29 +0800
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
Subject: [PATCH] vringh: reject empty / undersized indirect descriptor tables
Date: Thu, 24 Sep 2026 11:06:27 +0800
Message-ID: <20260924030627.13287-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move_to_indirect() rejects an indirect descriptor table only when its
length is not an exact multiple of sizeof(struct vring_desc).  A guest
descriptor with VRING_DESC_F_INDIRECT and len == 0 passes that check, so
*desc_max becomes 0, yet __vringh_iov() keeps walking the (empty) table
and aborts with -ELOOP only after reading one full descriptor past its
end -- leaking 16 bytes of memory adjacent to the table into a kernel
stack variable.

Reject any len smaller than one descriptor, before the existing stride
check, so no descriptor is ever fetched from an empty table.

Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/vhost/vringh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Leak path: once move_to_indirect() sets *desc_max = 0 and points *descs
at the (empty) table, the next __vringh_iov() iteration first runs

	err = copy(vrh, &desc, &descs[i], sizeof(desc));

i.e. a 16-byte read from descs[0] -- one full struct vring_desc past the
end of the table -- *before* the "indirect_count > desc_max" test fires.
When the guest page backing the table sits just before a sensitive host
page, those 16 bytes are attacker-influenced adjacent memory.

The multiple-of-16 stride check is kept for defense in depth.

Userspace reproducer (move_to_indirect()/__vringh_iov() extracted verbatim,
2048-byte region followed by a guarded red zone):

    [VULNERABLE] return=-62 (-ELOOP)  OOB-read=YES  bytes-past-region=16
    [PATCHED   ] return=-22 (-EINVAL) OOB-read=no   bytes-past-region=0

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

