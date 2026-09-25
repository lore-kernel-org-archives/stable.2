Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551B4E06C1
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352726; cv=none; b=kE52hJYCIOKXjDSgBpR8nb7J2Byje1Ve38k71XKu8VFR9YD+eE0aaA+ef5RDAfL2wTRzsSSAJFX3SMDJVJyVc/Ugr69w8TbudCNksOAWY9uU2eASW4/M0W0AOq4XKzeJW+zoBHqWOyVOyNYvRrRs8AT6eQlvAwOl5jRcnV5I6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352726; c=relaxed/simple;
	bh=Wfze54LtPMmI0xqKGIBHk5HpMn0us4cGASNlC9vZDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiquVDE3kcQAdDRS31lTYHfP/TLPBn3y7JiO94tLWni9Bo1oS43rlCry/eR5lFeYfJ/2BNdEkF6h57JrNcBdl6KPsLoh+RnTPmwmvOzUQbJ6iqwgnKR90lxc9Xw5LkXaWRkUyukc1e8qSjXr+5RG8vIgApou/+51oypf9Esmuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNgjUbZI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNgjUbZI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so6258435e9.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352722; x=1790957522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEfLZw+SZ9l3bCU1EQAdMa/xVIANZgIsiXamG4UPSuY=;
        b=sNgjUbZIhygAZIkzzXLeekEyzPl1Zbb/HGIyvknQLWjo7H/n9l/TphO1K4oMsUNBrO
         oYzvxfN++4dbmQNRTdbkMq63Q1omdMItldekZ+by82xNOU1g81F2xKQNgm+YWYhrz+QE
         xR812hSyZWmXRPSJG77v8F4MFP/n8E6HVeDJcrXE8v7TIjlRG47R24EZ8jyDiYo1Fsz9
         UMsy/25BUx2gs4fIFv4oF8Id/yxOu5x1OCQrDCQBh0iyKlHUawwrrwouFs+MyVnwDDW5
         noTNODFwNmPFNl4fF0CXChlKNhYTuQgBdq2/KyP1pSx6fo/poLsQoQ4NVmALl04Tv1Cr
         QEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352722; x=1790957522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gEfLZw+SZ9l3bCU1EQAdMa/xVIANZgIsiXamG4UPSuY=;
        b=yVeEgUX9g0Mfxvkr4Dc6f2crNCIunS3zm9YKI7PJMv6vlcUstoZsIuDbf/7tZlYmM2
         KLvIoNfuqAERv8LeAsrCLbR5ZU8+qOUP+QScorMeOQbxqH4g4ruaR5KwZ5MYNJx5H3/u
         o30rdcvWtDn5zcG8jo6YCSZWvYwZH63heHh2C/xUX/vUaIR6qSwzfgUicV9FASfVuLjJ
         D0dnJTJD/q6sjeocOaAtZ0s219eSfhd89l3WVCvtPBjiPIz1O0HTETJ0ZohduZEEjEA4
         Gjnj3cieqgCWi4rHyY+DH3ZnMc4nIGaM3joLgEmAQ/5NxD9dp2cTXUEgEhB1HxxRZ/Dp
         AJHA==
X-Forwarded-Encrypted: i=1; AKwUvBy9KuUBDpRqamSqMh+km++nB2Q5sQKsOLe46slbG4Tcy2SekAyOpAmzRhs3LNFsLPb6dcF+Xf4=@vger.kernel.org
X-Gm-Message-State: AFuF++kRFzKzBrY6LOSOff3Qq2HqDpAFybAjCGOQK7Vl9rQmGkJJZRog
	V9mCNkL41NouR26FSze98rYKCxcJMsj+6xPU+FA4VtE1pwrIMLJUoPPNiixEObV6M3c=
X-Gm-Gg: AYBFou1LAUKY5NXpJJ6oAt5hyhm3R0lMNsxcihq/8zoay8fDOQLU7qjpJFUxFeZItul
	Z3r4lnLwxO7YsCVCuBX72opmHOyzc5Y7kIx4sNA7iXVEsUgHtJr4lrGIpR08TreTRtzM5DDD9TU
	HSvHeVI4EVstnvXsihuP1+kAvETnXnCrDfIuX3VdzaJG3a278IXtTZ8+0djd+BruLfgd4KxMsDG
	E2yiMaH4R8lZT2kmABSkV6BwM+WJU2i6EgHIvm1975t4KIF5dUe7ZRqdbRSoJRGXwj5AukuaJxd
	a0iiwXtdMuC94sTX7KudE53JOWfQpaURxGFpYLjCncsiwMtaqPTW8DFNhNjSs/AWyrUwGYmR4Bb
	i/utQeSeHwPcH1IpgqNZStY8rmLVjxQWsQrVJi4bkQZaEyO8DeEqJ6j6VPHUG/BW62LZrCjT/zL
	z0Sd6YlRE63rN9iKpHkA3myf6GTWAPQ5x6ZFk0S/F45AcFR/r+l3kZaNBMzCnShKFOoOdRpdluL
	f129ejeIAHjV5EYGheAheVXl3bq/H/OxN/dBhZydydK
X-Received: by 2002:a05:600c:8518:b0:49f:d325:9912 with SMTP id 5b1f17b1804b1-49ff06bcd79mr47529705e9.10.1790352721951;
        Fri, 25 Sep 2026 09:12:01 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm81238665e9.1.2026.09.25.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:12:01 -0700 (PDT)
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
Subject: [PATCH 1/4] iommufd/iova_bitmap: Clip recorded ranges to the bitmap
Date: Fri, 25 Sep 2026 18:11:37 +0200
Message-ID: <20260925161142.189813-2-parri.andrea@gmail.com>
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

IOMMU_HWPT_GET_DIRTY_BITMAP can set bits in the caller's memory past the
end of the bitmap.  When the queried range ends inside a dirty huge
IOPTE, the generic page-table dirty code records the whole entry, and
iova_bitmap_set() then sets every bit up to the end of the pinned page.

iova_bitmap_mapped_range() checks a range only against the pages
currently pinned, and iova_bitmap_mapped_length() caps only the pinning
window, so neither limits the write.  A range that starts inside the
bitmap but ends past it passes iova_bitmap_advance_to() on its start,
and the write loop runs to the end of the last pinned page.

Clip the range to [bitmap->iova, bitmap->iova + bitmap->length - 1]
before computing cur_bit and last_bit.  A range that starts before the
bitmap now has its in-range part recorded; the unsigned underflow in
iova_bitmap_advance_to() previously rejected it whole.

The clip runs before any pinning or indexing, so for a validated query
range cur_bit and last_bit can no longer address outside the bitmap.  It
only narrows the requested range; the bitmap bounds are fixed at
allocation.

Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index dac3e657d498d..44826ae330c4b 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -388,6 +388,30 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, "IOMMUFD");
 
+/*
+ * Trim [@iova..@iova+@length-1] to the IOVA range covered by @bitmap.
+ * Dirty trackers may report more than was asked for, for instance a whole
+ * huge IOPTE of which only a part was queried.
+ */
+static bool iova_bitmap_clip(struct iova_bitmap *bitmap, unsigned long *iova,
+			     size_t *length)
+{
+	unsigned long first = max(*iova, bitmap->iova);
+	unsigned long last = bitmap->iova + bitmap->length - 1;
+	unsigned long end;
+
+	if (!*length)
+		return false;
+	if (!check_add_overflow(*iova, *length - 1, &end))
+		last = min(last, end);
+	if (first > last)
+		return false;
+
+	*iova = first;
+	*length = last - first + 1;
+	return true;
+}
+
 /**
  * iova_bitmap_set() - Records an IOVA range in bitmap
  * @bitmap: IOVA bitmap
@@ -404,6 +428,9 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 	struct iova_bitmap_map *mapped = &bitmap->mapped;
 	unsigned long cur_bit, last_bit, last_page_idx;
 
+	if (!iova_bitmap_clip(bitmap, &iova, &length))
+		return;
+
 update_indexes:
 	if (unlikely(!iova_bitmap_mapped_range(mapped, iova, length))) {
 		/*
-- 
2.53.0

