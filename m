Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566172;
	b=clheuX+dwFJ8J/aMTGIlpwnaG0S4JiH+ZOlEoK9DcRYSUp3pF/qfax7owLU1sV227eUU
	 nm9sJgLYJDYv3VTxF43C9lTKIyUQHGSpI1C1AhwM4hy+Ck8S0krZ+GthVW16Io0DXsX1e
	 zzlYqpeNB/1TJq/hscTXWnflnE8lqoKOvd769HZiHBel/lf3oHFk6rqDSyUvlkt51MZ9E
	 JoYcDqKoxzO2clqzk/+7yJU8pciXQe1livjEZAhV4KzCDhkg+go1iBsX/31/gvdiZcGDE
	 98VIYp1Jpy2LmD2Q4UouRb+ni+XwFicsSsQS0KT4OLRwliFzx4HYpEEsxm0Uio+Y4AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566172;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9ejJRb6pdg5woczfJr39UioN6agm7SyfQ7LOX7To5E0=;
	b=xNqS6mFaNLgzUxDlPLlxoC5TKeQD5cValzKQd9g74NeGqF4VeU8zSiGiUm79XdbZx1j8
	 7wulky19KINCUbNum7xQGeA8Bs+kK9NxkhPM+3DsR0U94EmdXbJwUzZnrLnxihnaQBX2U
	 lhcMrzvLG18wC2abvV250mhb4b7j3vkL6PGasFTatrf7eAkwD4RMS+izSZM7Q+XnWjXEn
	 sgDKLZtpAqyQ9pU/FHAU0e4MpQL3IVPsAIjeVIrJ8CBDnPL8k6UOMp0H4YonXYqmnqwIm
	 firKnz40LehrKaXgpkGatKJYRJT6kR591W+uIaln+/nbjqphORgLa9pwBdAhwFBK0kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=YwrEjJIt;
	arc=none smtp.remote-ip=115.124.28.219
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD70606A31E;
	Wed, 21 Oct 2026 07:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AD70606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=YwrEjJIt
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792566164; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9ejJRb6pdg5woczfJr39UioN6agm7SyfQ7LOX7To5E0=;
	b=YwrEjJIt4Qo2FdRuNOIoq0rWZzvczRVxu1ZDl9XYrMwmtZbAsx906yO1AsMaqHJ95+djlFgp/fasCxqckiJRM5wCxhabrr5zhRwRDkuLVG9P0hBLg3t+q45DdRCqsv3kRJYSwOhhzEettNz+mL2VQHSflKpnysf2MOD8xpkPArI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04958579|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00520256-0.00060955-0.994188;FP=10361852787305131134|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jmQmQl9_1792566162;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jmQmQl9_1792566162 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 21 Oct 2026 15:02:44 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH] vhost/vringh: reject zero-length indirect descriptor tables
Date: Wed, 21 Oct 2026 15:02:42 +0800
Message-ID: <20261021070242.75009-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

move_to_indirect() accepts an indirect descriptor with a zero length,
setting desc_max to 0. __vringh_iov() then reads descs[0] before
checking the descriptor bounds, resulting in an out-of-bounds read.

Reject a zero-length indirect table in move_to_indirect() so the
caller returns -EINVAL before dereferencing the table. Also use the
converted length in the warning to report invalid lengths correctly
when the vring byte order differs from the CPU byte order.

Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/vhost/vringh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..ce4f5a02c8d2 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -197,8 +197,8 @@ static int move_to_indirect(const struct vringh *vrh,
 	}
 
 	len = vringh32_to_cpu(vrh, desc->len);
-	if (unlikely(len % sizeof(struct vring_desc))) {
-		vringh_bad("Strange indirect len %u", desc->len);
+	if (unlikely(!len || len % sizeof(struct vring_desc))) {
+		vringh_bad("Strange indirect len %u", len);
 		return -EINVAL;
 	}
 
-- 
2.50.1

