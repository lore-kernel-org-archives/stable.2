Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA64E06FA
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352730; cv=none; b=DCO+QIrdG+cdfDcDq+4MdZhD5XmhCTUdS6gEz8w5JSCAM0aYFGOieKuoFqBIGvITG+Djh7mme+Zah83HAlEuOHRagSKnPyiWfRv0vItXmEZKTs/aQuJVCVrxrurEHvxSHQ7OJM2emid1cJJvv9TaWTlYGQQ+GEijqX5fk8vgkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352730; c=relaxed/simple;
	bh=HUOnEjhv9fKfLJ0A1Oqzk39EMDsr2o/axxVNv8d3j7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U56q3w5V/ajuyhexM0677S0dFHu89ISaaB2iVH+BJEEtHhw9ZrQUHzRuy1Kbpfz49JHmxoj4VBORfGc31zU05n0UsqWYWm6bgGq8ShkYdMGjnDOIeX2t5xeoezhu0Muwt+2WGENRn3Tu+jTeVj73BRTSwNz0QMznKE+6/sFnQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UViyKs86; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UViyKs86"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so11998215e9.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352726; x=1790957526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwRzATKx4Uz1l0MN7TD0eqrZoKpNRRbzLuIcmEq8eCI=;
        b=UViyKs86byAvX3X8cvTrCondGaaXUiI4M7tEgiAVTJxv60WiikuyjxRyhO2p9rc2i/
         6qprZ7GqPwTr3PuIJ6Wa4HyRQaMcHNWR5M4MHq3UiXE8rB0IXj6yUV7Kx09yNoVI0BRx
         tzOQE6fcWtlxgjdGqW17/5r6M4N3+izQslkCoiSdEZ1BjZUyj/LXfHfuIs3kxu77/lhY
         1jvu4v/34P7qoOyX/GkncXOKFBGi80NZ9R1zM8BUezgjvg86p+t6DIBKiHyEQUhs4qO4
         M1s/UGqzpCj+EZW+xajUKgkqTltCFdLSYqZjA76gmYNedicJ9z3RZZTIIaOiiE9mM7UP
         1TOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352726; x=1790957526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwRzATKx4Uz1l0MN7TD0eqrZoKpNRRbzLuIcmEq8eCI=;
        b=crVH6DyOrSSyy+9bLTFlouU3Z7lREn2uhRMVvpxDEMYVQHVLYwIuhSc1TmEpAc7zeC
         Q7dkfGiGHQHU3rUbqBbvOrTo+dX8Y+wTp4fnOr1GwitbzTZIHdad/Nu3fTGnPerXrEFU
         KGa+7o3KS5vb3wesyQ1fuTJZAcRAefL3kh7L2/d025651JoVhV/66pNoHUkj7Y54V6f/
         A56w4+e+zrTNGCKC07WPz3atgDYgr4nksiLm//x+cJX+1l37Y3Yku6YMZeooRIT0rkpd
         d1yY7PO/RUiA/92GzdG42W8QHeyhxrkZdHE0PgWJ+sMNDH1e/C6VXUGog+JH9gp+Hsal
         2r9w==
X-Forwarded-Encrypted: i=1; AKwUvByJu8EL7ySpBHopdMjPkegmdRe7b2r0tqpK6aa54CwsEwAFL67XJM/4BxInoVd86bOHoVIVg/s=@vger.kernel.org
X-Gm-Message-State: AFuF++kFMga34CA37ek7hEmPvTTm9fxeK3dfo5TCCv3jEXyiP1dNYPZC
	wwfhtHqLnTgc0VJbydTqXvWoJzJBzKjQgURuWGRoC2yGv6dTvvGBu+xB
X-Gm-Gg: AYBFou3d8llTTrQsP9mgSjUD/e/q+VQZ2L53GKbn30H4WR6MA/H3RlH8ColvCaq9kXC
	dP181Hhq5EePrw9N8KeszEvewuPJqoE7QMtFb/ivTvA+q0aIQ48drOstLA/VisKK2UEwPEZb3kJ
	BpZHrZ59CswQDXQNjxUjx8fHQKY26NzPHn82Uc9yVTbYkmzhLhYibFk2QhWUNxzKKtWgguFMX3D
	IMPtQpw7r1cz9wn44FK5auGr8WR8nT93zIQjubvKUOkMyXMech3wgaauG8aqRXK4R+uYCCwfXp9
	GzyWCsNQTC17CC3GolGeAgVE7peRe0pH2gXQCcm5FySm8qi1ZJzxE+EuEZzcy02ZS6HtxkfRh1+
	t8MDG2nBh3ML+exiamYpNsD8vVcysPSnnlHp28wPVnHHr+pi8NP4B66Gu6mX3lsUQ+yh3p3dhPo
	bE+K5CkoFMlEqptknkNfc0WyRC95Qd8fELpjpjDhv0/DV39vCRjyrdqdNefALDvuoTBc6o/ScNP
	UAbnO1uE+Y6GMSXr6xINSbP3T/EAipmGpzAHUKBtbOP
X-Received: by 2002:a05:600c:4f12:b0:49f:e194:a062 with SMTP id 5b1f17b1804b1-49fe66fc6b7mr130556485e9.32.1790352725963;
        Fri, 25 Sep 2026 09:12:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm81238665e9.1.2026.09.25.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:12:05 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] iommufd: Reject a zero-length dirty bitmap request
Date: Fri, 25 Sep 2026 18:11:39 +0200
Message-ID: <20260925161142.189813-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925161142.189813-1-parri.andrea@gmail.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_check_iova_range() subtracts one from bitmap->length before it
checks the length, so a zero-length request wraps to SIZE_MAX.  With
iova = 0 the wrapped value passes the overflow and alignment checks, and
the request reaches iova_bitmap_alloc() with length 0.

iova_bitmap_alloc() then sizes the bitmap from a length - 1 of SIZE_MAX,
so mapped_total_index is effectively unbounded.  The scan uses
last_iova = ULONG_MAX, which spans the whole IOAS when an area is mapped
at IOVA 0.  Reject a zero length before the subtraction.

Fixes: b9a60d6f850e ("iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74cf6c..283ab372e8da8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -605,6 +605,9 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 	size_t iommu_pgsize = iopt->iova_alignment;
 	u64 last_iova;
 
+	if (!bitmap->length)
+		return -EINVAL;
+
 	if (check_add_overflow(bitmap->iova, bitmap->length - 1, &last_iova))
 		return -EOVERFLOW;
 
-- 
2.53.0

