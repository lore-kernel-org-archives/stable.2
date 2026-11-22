Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349366;
	b=SU5k3d2CA4Y8kK40yHT1/V9qOgQVtGX8k2fZosnA1Fo2mQZwJGQpu3HIClLs8aWkr3K8
	 XVci0H57DBkVnxkPLkTvzHZeLYT6x1hneNAif8h52srhQNPZedrIbaXOxM4DPiRWVDCbJ
	 v+X5r8ufKLvRCSQMga+jCFXZCeymEyFf7hyJbkAXeyPoXbU+G/2ogQ4OqRjLHolHS6+At
	 P4chRNFzN0jcgCkre1l7rXHCo6I+UYciErEnAA4JhK1rTPDwnOecM1vOkkC7PqWuyL5ho
	 kZx9VEJzfNWBUuPG3QwyoBU82w4Km2e4bnzXAVnvoVzWuXWBY8v62n1TzFZ5Drxy87w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
	b=EkdX/0tfFrugEpNUC8pUkVFlxv+nAzmI7Ck2rzQB94j3/nh3Uw5na7P8Vw+Ihrcvxuwn
	 TBuFUWUf1/bN5RFdAnCOIiv/2IcwFNujvIxnIt+EA22ywU2hWBPct2+vDJF2QWTViOYON
	 8cKTKbtml1cPraQVVByWfk+teQweWl9RYH4oWFgEqkeRwjw0jtsvWsh3RUeuuFrLytbkl
	 JSdP1enY5pkH9+v1ruEIzuhRL9bs5n5bAZs9tjb6WzagtZzbAH/38TKFFLIDEfJBpUJSh
	 LS4xX941ZgZ5vy25D/u0J5X/1bGYjGUf7Vrc4wAKPckD4DFuLsWQSUDtvYe1o6qZ9fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Iv2edekw;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B6606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A6B6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Iv2edekw
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b503e2a87bso23313287b3.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795349364; x=1795954164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
        b=Iv2edekwCcVIQp9JIMsfLhk6KtoiV0WhRuD1FoDIRhUZsxLA2kgzsksYDDlnY5NdLj
         QTmbmISW8g0su/g5+BFFz+65uDTd6p7xZ4n5+iHa21Cf9mBL/0iwxOGqjUi2dR2vr9+O
         UyN8+2lSQ4KEgbwZTJIMOzO7HpzYQW1qneGMuVKZHYveD1XscsYYGBp1JauYkNyuMvpb
         DQ7lS29jTR8iypzv1awMBPRFuN0pyyKlUiDxvXF8n04RhcYHVGPSRlpXAdX1TW/U8O78
         8HbEkFnVxM2h4kREUrWn+N5bIMsV6ge5D3B59Kkdro3yg6DDF/VJptuL1Q4Aj+GXRvTl
         WGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795349364; x=1795954164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
        b=x8FqWOzZDQ0iPqEUnoxTpERKrnarLWZfXSscmXMqrhvqA+F+fwXUswe/a5UwHoLysh
         n2uwFEaLAlNwMPyrV2+hgIbpbO42GNkSgZGvwGqn+Lf3LwfVQNQaPBrhPHGJjUOOih/y
         Bh7hqu5AXKKkmwVPb0YN+mnsF1rO0brWulVYCbQgmIx0YfvWVKiqVUKr2gIxeU61s7Ki
         Qa9eq8T6y+YZ+80pUwrcUr/1sgT9s+Ja/Z9mMVHsM7RXNJSnWvGrFYGyYjLlSIQ5cAhA
         CScRccog7mgmMI9rqn23eDHROtS/yR79nL44RuhWavzwlMABurjoaq9BMwuQqSRH2C12
         pF6g==
X-Forwarded-Encrypted: i=1; AL+hErEyqChpWGp8f4lQXo5xD5tWt3wQ9TGJUoFjfAEW9HsRUKd0U9H0Mh4D7ljCKrjEhA8XRxF5tUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rqW0uaHGP8g3EP9xd94yzNiZlGDjPv/wRuuzRpyhVaYYbqgSY
	1BG8nFRRiN6lE4H5FFfSyKK747XPI0we2mkJS0pANI71XBZ+SP8mg4UISm9bWBCC+w==
X-Gm-Gg: AZFdTZebhCSLM1425M6ypsQ1zi6/OFbNcOSBsj3L9FrC5gt34OD6a70qf4OG/ewJ5E4
	LgtLiVxQfhiaedNxYY2yOLwBOndyUjkLJMEhOrLuuSAyB60+MP9lpUhhgmAgoqTYeMTg7z0Vecx
	T1ZHhYcCDKB5ooibaNCFqb6a972sKBso0X9kbYIH/0FFtRfFTNBt+XLLNMNs9W0d1hJCV3iURES
	1NblKfxzU/lRTV1sPAnm7vXWsw910EhuPq+eTFxvkgwnkAFs/vxgUpHV24pWCjo6gYxopNf5tqq
	UANwfddIxnNCmgiAoH2vpdWXGXtUWDSRKvh0osWV+sBa9zRw1w5qbIzfmxY3D89/g+V2eI2axDN
	YoUNZ1yTqFJ4XiW+7yjifctIXh0XbJwROtSDS86f+AIAyuOd/0qnl6fo0v2km3WVJJrNz19M0Ss
	e0jH1TZbjlhXAPA3SFcKOWwoHvY225oybNW4uN/60qqZFGnGQiMlywFtU2QUmo0UBrTaejbL/85
	4he4hyFsnDdFVsDyS/bOBp7hAGbawxgIpGWxFS/JTW6dxJVdaXXv4O+O6FdVOLkpHkcEkE+HFBN
	Zaq99ureI6N8GDkRRPTHP60llh7Wt0LC4SMGmS92BhWKwHaycQZ0
X-Received: by 2002:a05:690c:6088:b0:8b4:d26a:aa7d with SMTP id 00721157ae682-8b5204ff21bmr37330077b3.56.1795349364614;
        Sun, 22 Nov 2026 04:09:24 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201ba5absm34801557b3.4.2026.11.22.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:09:24 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 07:09:19 -0500
Message-ID: <20261122120919.1718445-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 333c515d1896 ("vhost-net: allow configuring extended features")
added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
words from user space and checks that every word above the supported
ones is zero, one word at a time in a loop.

However, the loop has no upper bound and no scheduling point. As of now,
a caller can pass a count of U64_MAX and a pointer into a large
zero-filled mapping. The ioctl then stays in the kernel for as long as
the mapping is readable, and a fatal signal is not handled until it
ends. On a v6.18 debug kernel booted with preempt=none, two such calls
from a non-root user, each on a 4 GiB mapping, froze a 2-CPU VM for
56 s with soft lockup reports.

Interfaces that take an extensible structure from user space limit it
to one page (openat2, clone3, sched_setattr).

On a KASAN kernel with a 1 GiB mapping: before commit 333c515d1896
("vhost-net: allow configuring extended features"), the ioctl does not
exist and the call fails with EPERM at once. After that commit, it
fails with EFAULT after 26.0 s. With this patch, it fails with E2BIG at
once. A reproducer is available on request.

This patch will reject counts above one page of words (512 on a 4 KiB
page, or 32768 feature bits; 128 are defined today) before the walk
starts.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on the vhost tree at 44293796526f with KASAN and lockdep: counts
of 0, 2, 3 and 512 words still succeed, a nonzero word above the
supported ones still gives EOPNOTSUPP, and VHOST_GET_FEATURES_ARRAY is
unchanged.
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 631855064b3d..22e06b44d2ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1795,6 +1795,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 	case VHOST_SET_FEATURES_ARRAY:
 		if (copy_from_user(&count, featurep, sizeof(count)))
 			return -EFAULT;
+		if (count > PAGE_SIZE / sizeof(u64))
+			return -E2BIG;
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);

base-commit: 44293796526f4343639f87b2acc53811c78b5d54
-- 
2.53.0

