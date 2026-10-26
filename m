Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021823;
	b=OJWDbYUjUXPKbPdqRVGngh+y8GVGSnZU8ZA7n5T/AVaiiJPdgHCq7h88qS2Yyfjd8uWf
	 AHgaaoI91cISEaetcFumpGuG5ZUzaewfUv39MJB6Wwu2dQcQTBjn6H03hD6ZeTGBOrawY
	 gD19OG+k+1FmOXhi44wXK6Fo74/U9aMVv6KosqiAGtIhGEKj1nBFF4yZVuVIatAC3w/ia
	 fjTeOdPUpVylBAEiMDSsGd4H0jfJPHQeQ15kSk96PXYaq5uqYFqTaMBH/8ogqlXjLgmV1
	 TIukOdpJv5pdTMrI0m5qm0Tyryexp/eZdBwNBNmbVI18WQgz9MDCbnoNjTsr2sQAGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=u8dEoOvFyttOe/BrdbS9Lckh8vPBq/eJHO5XvvUziD0=;
	b=C31wgdLVYv6xUbifjt1Me+rKgWEkhACScUYVseYL79ESWYBltMaeAkEx6OEZH5o48tPg
	 XE8JytUSE3LFRJYv8wd31bZkcY3QG2CDS3ymfvbkFKXn6e7N9bRtRwRtiO0lUEhNGFgWN
	 80WKIL9MHyGK+4DiiD2BqM2XCM1sINNOMWwuVxZjO98H+jMzyxxV8YddEW6ixda4JsiU1
	 BtxxMqT0tr31Jukx5Xp/XkXtN6IC7LrT8/1wwC7xykPl8KCvdcGZOecHwCH76jOWzg3VW
	 NpJ1J4oEdi3I6oQrArfR7lkJnzO2fZye8xYQHG0j5oWLucblgOTID4rJgw+A+rs/ggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=snu.ac.kr;
	spf=pass smtp.mailfrom=snu.ac.kr;
	dkim=pass header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=r1D23Vnb;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD475606A32D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD475606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=r1D23Vnb
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-19305bcb72cso2068722c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1793021820; x=1793626620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8dEoOvFyttOe/BrdbS9Lckh8vPBq/eJHO5XvvUziD0=;
        b=r1D23VnbbDdUGzSg9SzRtXtenXM4+aoiMq/RQ8WNr8Erl4gTu4vpizT/KD0/4ssWoE
         b8Rxheen0/j5U7l9cDhnKB89i5xz+pTwAeo5EUUFauyW9yNUpjtTDUlItXx/z+st4TRh
         XXsF5A1YA6ljV/pkPIwIj8qpDO7MtAOnFAb4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021820; x=1793626620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8dEoOvFyttOe/BrdbS9Lckh8vPBq/eJHO5XvvUziD0=;
        b=aKXo2Z3c688CW0vOKpaSf+vNiheiuoRiNBDL1nwyWtrElvWOJKM5NR8v6zWqn9sykx
         SnR6S/eZ3izgy93SeZn72W7SYUhnxCKBc/HGhRRe7tSxQTsePJ6/bpOtiGNQFK781VBJ
         qaK8ZrZBGDqQ3z+3SiE9F4mls8rl3T1TVcPfL1DzljzN4RpQOiVhm11TF8a6xZ7hyCd+
         EOYY6gLLrE9gdOM7prWUILE1/RXNcSgIXIj4NOpBZ2V1vmmS7zRdciO9mIAO/tqMjn4H
         Uh04+M5hKF9dT67Wb0dOyNWr3f1D1VRvNEaU2oZgzwVWWSLy93W7D290jbrvoVg4zLjj
         9G1Q==
X-Forwarded-Encrypted: i=1; AKwUvBywEq6GwJZdA9pXgSgG97Y4hXvAIgCPUXk6XJtuJj9Hh5rWqucA/IK3ZigoCa0/ct3WTI8X2xc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeMNezPsGBEPqzWkH6f0FYnDN44XF7f4Wm36p3xcVk2BgBEzkk
	GSxnjvm4jJN2JUJravj4pdLuOpmpR6+4ZPdI87+L2tIe0PDvdiRz3qhfSzE+k1+cZkU=
X-Gm-Gg: AYBFou1Bk1+8fwX/Uvso5bvGWLhJlX69UFQSSQwkRmeo/jxVAQWKIhRbv6q8DiiCzJt
	/zwgzcg0it3znaH9R+HkfngXCuJyuVkws7pTAhL2Kqj9kB7gYUCNFoDbHMM3VOk5ug25FwG0pat
	mIXPkZEXkYYBkwQH2HdHdwznYLK5/eAAzqgMloDJ/+XabHkH8nGZFtTj0NMjw2hQZEMvEtdxNXj
	Umg8r/aNN4aOV8AaM/4WhaxhmjLgMFJuNcfQEwuOoVsg3kqFnNZZ4DazhloZYGGsv1y0L3fos7X
	/HCNT7WGidzZjwr6IZ0piWziJmxOPfQs18nYMzWL1uJ0G3Kglh8d9sCdfkWazi/W6jOEL82u1ng
	kvI369jWwt3FvXiBd0jTXm6RhCkyNpVqVo8e8Mx3Vmxj9nFIZ+TeJlymQOwBtKWtNpRyHggf3QL
	23dscrsxbA5wZ3i1jnqt1/tAiqgVCsCu6VdaQtYtFsbr6WzRdMSZjthrvY0EAuc4Z9eX2FETBYV
	tzI3qECaptaYI/e/D9Ci/xO3v/9nLZrkKGT7i3yMU2lNUNxGw==
X-Received: by 2002:a05:7022:150c:b0:191:ac4:55a7 with SMTP id a92af1059eb24-19934a96e58mr10119771c88.23.1793021819831;
        Mon, 26 Oct 2026 06:36:59 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm22432520c88.8.2026.10.26.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:36:59 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Mon, 26 Oct 2026 13:36:43 +0000
Subject: [PATCH 1/2] iommu/io-pgtable-arm: align next walk address to large
 page size
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-iommu-arm-fix-missing-dirty-pages-v1-1-115b6b1cc0f5@snu.ac.kr>
References: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
In-Reply-To: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Align down walk_data->addr before the increment by page size to prevent
the missing dirty pages on IOMMU_HWPT_GET_DIRTY_BITMAP ioctl.

As Commit e21952d72b47 ("iommufd/iova_bitmap: Ensure that iova_bitmap_set()
handles the full IOVA") mentioned, the requested iova range can begin in
the middle of the large page (e.g., 2MB page block). So incrementing walk
address by large page size (e.g., 2M) could bypass next dirty'd small pages.

Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
Cc: stable@vger.kernel.org
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/iommu/io-pgtable-arm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 476c0e25631a..01c3f9cd5d9c 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -821,7 +821,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return ret;
 
 	if (iopte_leaf(pte, lvl, iop->fmt)) {
-		walk_data->addr += size;
+		walk_data->addr = ALIGN_DOWN(walk_data->addr, size) + size;
 		return 0;
 	}
 
@@ -868,7 +868,9 @@ static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
 		return 0;
 
 	if (iopte_writeable_dirty(*ptep)) {
-		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
+		u64 iova = ALIGN_DOWN(walk_data->addr, size);
+
+		iommu_dirty_bitmap_record(dirty, iova, size);
 		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
 			iopte_set_writeable_clean(ptep);
 	}

-- 
2.43.0

