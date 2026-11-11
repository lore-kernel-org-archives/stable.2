Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421593;
	b=OWfOaPQD+QngGL20BqvPAK9mxNNqIpyEPCChh/deUZrl2dpfUkDKeYVVI/CEek1Hf1zw
	 UoiiLyfoP7qPRmTOxqluZxx3C3Wa1TB6R/IIHBPbins557dd/xh90VnqGrZ+Sj0STxzlP
	 YqdZ+Jdfmhhow5Hy8DJmnNdFoCLTI+96jcWpAgXhD9bWxl87qArPQx3ITHB0R40AUaG6k
	 JYumBNEiS/GXAlEvh6mGxy3+4FadCEEufnhLbXPtg5gw1+9my31IfR7atgZ+q+AwdEEpC
	 xRumNBZp9ozFM2pu6BmTbzG5ebApBlZEZqNdmDXwTPF8F3TfgOO7t8Gdhu/bQqGUWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QVABs7MHTuZPeYe8l8hgNIkP1NGpzfeUZtCQMMZ+2cQ=;
	b=nshGqwvw6FtFUWF4MphSqQ+hVDtxJkheoWeh0rN3lFZnurnS4XlRBWWBtXYzcOJLoJ1X
	 8Be2/n0GZOiQFZC2hHo1mns/6SHQsoi6LI39nuCANeX3maNrBEMLr7knlvO6DclSF+hbW
	 IiVzh9Y4F1kHf4AJVdfYi461dK54z8Cih3khxJt9l7RkKl5y8sQc+iXnhlRlRapyxntDf
	 N94/k5zRJEDNcLfiYos9czTvhqVXeiGoWE7om5Mt3F/EBVglfNWKyh1RXgoSXAbxLtg+m
	 XoNs2wc2vgD8cX+/+3iC3eMpU/3582ynDrX9CsqNWmfqDhE/go53AYq6AEyr72FHWJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnWsqoy9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BF606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnWsqoy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484121F00A05;
	Wed, 11 Nov 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421592;
	bh=QVABs7MHTuZPeYe8l8hgNIkP1NGpzfeUZtCQMMZ+2cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnWsqoy9qtF8csE84pgVWt0ikDbpcXLC8H54lnNEicQoulgetcDYbMwE+u8WqqoDM
	 efNBUDtlvHnuRA4dY1SFTuTQk7ACHy6j996g758wm+hxB70yg45DZ2VjMYX5s5ONX8
	 9XjFRwJ1qYvj7NUWSLZIpNwD+Fkm9LoI54a5qK/gtTf2PWW44cL9pbLXfW+yjfzQjk
	 D5xiTQAI7lO/B+KAc6FPLLGvS9WMdJolASQfZiaNaaauDL00jMJuzm086+6CAe+Wx/
	 TqSbgCS5iizZ0cvgqBoMwFvcSCcXeifUZO/EDZK/9MFVgpZLKxfiPmQ1FFv1X1nQrv
	 kjAM61dJn5uxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA
Date: Wed, 11 Nov 2026 13:26:31 -0500
Message-ID: <20261111182608.3821373-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054953-failed-6.1-e21952d72b47@kernel.org>
References: <20261107054953-failed-6.1-e21952d72b47@kernel.org>
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
[ sashal: adapted error propagation to the older VFIO window iterator using a newly added bitmap->err field ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/iova_bitmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/iova_bitmap.c b/drivers/vfio/iova_bitmap.c
index eab0de7799fa2..fc9d4ef74ddda 100644
--- a/drivers/vfio/iova_bitmap.c
+++ b/drivers/vfio/iova_bitmap.c
@@ -112,6 +112,8 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	int err;
 };
 
 /*
@@ -380,11 +382,11 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
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
@@ -407,6 +409,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
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

