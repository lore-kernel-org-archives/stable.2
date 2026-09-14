Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D943BB57
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359939; cv=none; b=kb+jgBG//JQe8tRbQbYzoO+oy8pJMMChzWHmbvnTjXxEaa3Dh2psZFxStO6Fukh2Not9YRO5DRTI39SOMIpxX5QxDXuqNyQlGQjjiC41EVwVSQ6okxEs7kmMqveRRZyHjJuAR2IVwdSWXZYl9bmh9Lwq6z234vOK0Xtq60MbUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359939; c=relaxed/simple;
	bh=IKYTEkRJA/yTXqJoVZoiN4hKi//+UQNf48N+jbQglYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkvsRsrodTUh5XHS4dctald5t9LMpO4ndwHDj8HMJDK07WM0NQ7OvjQfNCHbyUtdkLYvJawkhA1XP2cxNNomXEvP2xEvoh9IBKbibJe0rsSIMF23VBSmrder7Fh81bU6ohoEFLCE+cOfROuJHzy8V4ehJr1DKwoK/E/d6z8xKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iySuluh6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iySuluh6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-86309e1a213so1147985b3a.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789359937; x=1789964737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGYYwUXQBV/IktFqjUcwZn3BsoQtowX7trp9zvobBJ4=;
        b=iySuluh697TJX27bAKrtFKSI2mMg3lBKsEZt6tV/PxeeDOBy1DXMNezRaMMe/33QRa
         3uOF5VWaot7pGQ5MmEV/o9AQwI4T668xanvpwZS/jMFKc5bYH/AguL847vH1+mVh+uRj
         LPewDP6qpkwX5Kod3oTA6rcvclo1s3z36y8SXaE6YnFwCOhr8yWCVqDOrpkpUZSmrkee
         fHtuPagiCwfHcC72JtKLiaE2lJRm+XbQ7JnHqTC0VlCaTR5r/ThP2EsyGaHc9ZA8+AmX
         5BRRcCN7ZWI+52muPEsRMmEMwC/H5kcRha3fU44ji1SgJ/bFW16udg56BfqayA7wwHu7
         gOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789359937; x=1789964737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGYYwUXQBV/IktFqjUcwZn3BsoQtowX7trp9zvobBJ4=;
        b=mZ5APLnqD/xC5Ch/TLDtcwJt7gc+uojJo26W/NbZN2n99oOf+JOxnaAIVlVlVBs544
         i4BVySpFifGqiLu7UZ9Cc4919knI3hU3MYgf0FY4pZ+2HxCqjAdfWUOGxjlgaizynZjJ
         NTlolHt6Bc/JIzowCHXMnOkeK/0ZepAptX2ernsnnxTXXEfmIWQfW7EYgd2P5xXqZt3D
         FFLCEG2Mq8Fpez4Z9ypQynPSNBis0DHc76Ehx8ivc7ON4HBG8Vbyo0/hKkVcrLY/Ctls
         2maTPhoRkaK3XmWqVXHXvG2bz9ZgbMCfzkDsm4wOIiZ4H1nUd8ulyYLI0TrzYEWpgsPg
         Lh2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTUAD1fxg07x1g5UkcYK1E6O0LO62mZTC2orAwSS4vr7160ElTEIXp3G+4fi9CyHb4902dHHE=@vger.kernel.org
X-Gm-Message-State: AFuF++mkYrevfkYIBGpZb2VmWywHY0oxXGpr0aWrIyw+c1E9IlqOrTHK
	PHksmi4L//f+WoY4BZUti4j7B7Pk/SCPT9bMxt8cYNQgxhKrEZXWtemg
X-Gm-Gg: AYBFou0tfoPyq7Cw7r6Rpnvm4rMVphPRWhjN+27zAHbjY/nry7scNhpk/OtxJnfumXm
	FszI/EDvpI3dc8HrNdBjVgDAeKUUTRtdyGmh/OBkJl8Np0Gw3VmyJ4vW3aROUY8qHCapQE/0uyB
	WDVyUJGg/KRAup2LjGqxO6JhctrVYvJ84eUFTYNhI7/Ss5/L/Jqxoo0S8NDMKq6ty7D7ju+Tr5l
	qczxrrhDcFs2YJQkRYBleRcOc18sVfVMeNUvoB5HDO9tiTZMOAf5o5mJjTkZPz8fvVP+rNbH0MQ
	5tyca2SbaugNqcESwG5mJTyVuolfKtmr3m/1MaOaH5GArVTGCPE+qeCRHkecHWhCIzgRNvoc39+
	Dmdm4htvLkGrdPOdxKqwxlDeLbRHe/12W86oOeyOddzLhCHQaR/yI5gaVfy4F9cOf4XT+D/3s4K
	Kv7828B2IvujcnCeBzg0qgUijDQbQn25hbTk6iIJZDHj21n2Ff4wSiQVDsRl/GLtgV84170HAr9
	b1QJ7UhJLymm8dO+5QhlQeeJnvKItcMSTvu2kBFLAtnCJAnOgD1ssjfP9o8LjkEHYdfeedAGn9E
	Z8OClxaIDkjF4oarwhjUi8w=
X-Received: by 2002:a05:6a00:3c8f:b0:848:2c5e:305e with SMTP id d2e1a72fcca58-86f8393cc77mr2219156b3a.6.1789359936974;
        Sun, 13 Sep 2026 21:25:36 -0700 (PDT)
Received: from localhost.localdomain ([121.152.194.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b4c39ebfbsm3873038b3a.54.2026.09.13.21.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:25:36 -0700 (PDT)
From: James Kim <james010kim@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH] rapidio: mport_cdev: fix use-after-free in mport_mm_close()
Date: Mon, 14 Sep 2026 13:23:27 +0900
Message-ID: <20260914042327.49798-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A use-after-free vulnerability was identified in mport_mm_close() in
drivers/rapidio/devices/rio_mport_cdev.c, identical to the pattern
previously addressed in dma_req_free().

This is observable from userspace when an application creates an mmap
mapping via the RapidIO character device and subsequently unmaps it
(or terminates, triggering exit_mmap()). During munmap, mport_mm_close()
is invoked and drops the mapping reference via kref_put().

If kref_put() drops the last reference, mport_release_mapping() is called,
which frees the underlying rio_mport_mapping structure. The subsequent
mutex_unlock() then dereferences map->md to unlock buf_mutex, leading to
a use-after-free:

   mport_mm_close()
     -> mutex_lock(&map->md->buf_mutex);
     ...
     -> kref_put(&map->ref, mport_release_mapping); /* map is freed */
     -> mutex_unlock(&map->md->buf_mutex);          /* UAF: map used */

Fix this by caching map->md before kref_put() and using the cached
pointer for mutex unlocking, ensuring that freed memory is not accessed.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
---
Note for Andrew:
Following up on the Sashiko review results you shared in the dma_req_free()
thread (https://sashiko.dev/#/patchset/20260615070530.371640-1-james010kim@gmail.com),
I audited the reported pre-existing flaws and verified that this UAF in
mport_mm_close() is a genuine bug with the identical locking pattern.

 drivers/rapidio/devices/rio_mport_cdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index ad82c2108a56..47ba34b4afb2 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2167,11 +2167,12 @@ static void mport_mm_open(struct vm_area_struct *vma)
 static void mport_mm_close(struct vm_area_struct *vma)
 {
 	struct rio_mport_mapping *map = vma->vm_private_data;
+	struct mport_dev *md = map->md;
 
 	rmcd_debug(MMAP, "%pad", &map->phys_addr);
-	mutex_lock(&map->md->buf_mutex);
+	mutex_lock(&md->buf_mutex);
 	kref_put(&map->ref, mport_release_mapping);
-	mutex_unlock(&map->md->buf_mutex);
+	mutex_unlock(&md->buf_mutex);
 }
 
 static const struct vm_operations_struct vm_ops = {
-- 
2.43.0

