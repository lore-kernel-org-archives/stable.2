Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421773;
	b=f9e3e5mOCPdsBmHNTk1eRAhUEwc89OvW4iaPXQZOAFBvqXHtikO1+MKRvUetb6IrpWtF
	 BioA/QY3gtkXCabKfvFsCB8KAocWnzjAypYl0HLXf3xQonNriCfKIrQ32ecJEuhWoxYWW
	 7Kefa806/dTp2HcujjAvB1hjfGxhn4j2XmPQbURHuSGvqA5rARdP1+Pbm2+Rve5+s8mXy
	 dNLbFrukmiVMAmIoUiR8gdLULogenL96lM9IpblJRqf8cyD+42T2ZhD3HaEEIOHAYJta5
	 tNcZXngVipdJXHnVO29klgrN7PFhZHenKKfHbvlNtohvUhvO0BwDHX39pBkDDwgc7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qFyqNXuTVNy/G8IaFaS0CjR4p1czGG81M2sFbmZShI8=;
	b=BTWSjNrXoYJhZ4N2xJPBxqhOMtM7dL9XAx+EO9sCm50CNOlPmGs8r/qoisc7wlV0wrUw
	 t21mNsmDdqpHkKIkXQqh0CnYcvzRuj3ezZAoaLuY49Mcg9OQtqA2hPpbWn4NYIkTrRuMc
	 y8mlURhlczR3z2ph7BgO6FaW/4y0GJH2ySF2F0skSaIyvH2LUtzNvP10mTaCfib2D2PXo
	 MYX4T4MSSFcdsaX3Hi2ntmJit8qlpEfVc9L65HVRDp+LeUKy+UTcMSOBDl0xY14CIJSf1
	 xRVoQ2OsVazihgVOFQHVWuvg+5EE3Uu5veGl4fexjN7DTqI+KHPBvVwFggCeR6WyPGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHNF+DhA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006E606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHNF+DhA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C392A1F00A05;
	Wed, 11 Nov 2026 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421773;
	bh=qFyqNXuTVNy/G8IaFaS0CjR4p1czGG81M2sFbmZShI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QHNF+DhAgaW/9cTn8GR90O57/ZUAs4p18UrYu8XGdQQ8Owr6vPevUKnTsH7VhoH1x
	 yxPTKFjK2zuv1q0tsd/iKxdfRHqD92YS4pcZDv+2sFqdU+6QEniQSXTOkhX3BpQ0g9
	 hY0C21+5B8rGRJwnP4g0ni66fMvvlf+iLcDqSfPbS/e2jSqrIgFID4cgYoz5IrJYBI
	 1PG8nlpY8n5XHCic775/l+umGN8D6VQLjkZppYXtuODixQBT9wYX8sgBPJfO7itUIa
	 +aiPO+skD3KC48KA3xHr2ZJgEudmt8jMucZ0eXqxHIyFRom+zQfOS4T2ewqI/W017q
	 xqDFXsGsl5tkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA
Date: Wed, 11 Nov 2026 13:29:31 -0500
Message-ID: <20261111182908.3764467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053543-failed-6.6-e21952d72b47@kernel.org>
References: <20261107053543-failed-6.6-e21952d72b47@kernel.org>
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

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit e21952d72b4740f08a272d694cca223b6b0099ca ]

Generally userspace is going to step the dirty bitmap through the IOVA
space. However if the bitmap ends in the middle of a large PTE this is
problematic. The first step will clear the dirty bit and report dirty to
the end of its bitmap while the second step will see the clear'd dirty and
report clean for the start of the bitmap. If it happens this ends up
losing dirties.

Further this function is missing bounds checking so if this does happen
ther is a good chance it will write memory beyond what the userspace was
expecting.

Return an error code if this illegal condition happens.

Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://patch.msgid.link/20260925161142.189813-2-parri.andrea@gmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ sashal: Adapted the VFIO bitmap implementation by adding the missing error field and propagating it through the existing iterator. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/iova_bitmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/iova_bitmap.c b/drivers/vfio/iova_bitmap.c
index 3f48125e2b9f0..e78cb1b4e7364 100644
--- a/drivers/vfio/iova_bitmap.c
+++ b/drivers/vfio/iova_bitmap.c
@@ -113,6 +113,8 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	int err;
 };
 
 /*
@@ -381,11 +383,11 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 	     ret = iova_bitmap_advance(bitmap)) {
 		ret = fn(bitmap, iova_bitmap_mapped_iova(bitmap),
 			 iova_bitmap_mapped_length(bitmap), opaque);
-		if (ret)
+		if (ret || bitmap->err)
 			break;
 	}
 
-	return ret;
+	return ret ? ret : bitmap->err;
 }
 
 /**
@@ -408,6 +410,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 			mapped->pgshift) + mapped->pgoff * BITS_PER_BYTE;
 	unsigned long last_page_idx = mapped->npages - 1;
 
+	/*
+	 * If the range cannot be recorded then the system call returns failure.
+	 * This is to prevent loosing dirties if userspace is expecting to step
+	 * the bitmap through the IOVA space.
+	 */
+	if (!length || length > bitmap->length || iova < bitmap->iova ||
+	    iova - bitmap->iova > bitmap->length - length) {
+		if (!bitmap->err)
+			bitmap->err = -EPROTO;
+		return;
+	}
+
 	do {
 		unsigned int page_idx = cur_bit / BITS_PER_PAGE;
 		unsigned int offset = cur_bit % BITS_PER_PAGE;
-- 
2.53.0

