Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607111;
	b=kW1I6Kwxwx0YsLPtVhZ8Dcafe+ylOcOzpiR4VZMsKef53jAFkWSRxQjlsxz2nntgiJz5
	 PDwiDngPeoPqOflM6hfsJbd9+3xDzCYH6OEneD/dAiuQ65mawMvJF1BIrG8I6yRSVB0o6
	 8DkFsQcWfydP48MedaXGr6tmVm6yX1mbtYBHWcuxx4qIp2t5W6T6zyk8ZeM7k1ItgfaJi
	 QBXkqMD29BdIc3ayVrdWjh0Mapc6sWysuAa7WWHGLyCdK9bsV5T3wyg1YmDyWMRZvq+J5
	 SNsEfrJqouOJm1Q4Jr0n9ONXj8yWnof12/gRH6UuOrk6HF8UJnjxo156wu6Gyr3drtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FAyyYwHdR5Ch5uO/F1MiXirGDsn56GrI3GAO8iDRceA=;
	b=sPSn5rEdA7A+M5MYUKOZe7uSAFTRWlC0RE33MMqfnnpPyjEuxuf+/dMLSVTkvtCMn2XM
	 JecrQ/fK3Wmm8l0nV2n0E1oohhYSs6RzKSIWIN5tPvaO5XTku3eNSrqHz9a6FKRDiqRgn
	 oebrHFwNKymhF5drWhLgAu0nKIyBxRrtvy3etF9Gn0tT9ehWupfFJAQOW4idUnl6J/xBc
	 lZ+I7ZnbXv1cxTmyyNhgzDkS4Y3z7vcVx6Ma7/EnU7ga0qtqUZsluw7mJXLUvu5AMKkFM
	 IxZ0PJ96qriSu16WnrEmj+mEITb+n8hhuk2MF+FA2t6SYZbkW2a+JF9SCqMzXgrRjXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YStxYhS2;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B7606A32E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 08:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4B7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YStxYhS2
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so15369345e9.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793607108; x=1794211908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAyyYwHdR5Ch5uO/F1MiXirGDsn56GrI3GAO8iDRceA=;
        b=YStxYhS2u0SmwT7c0BAO3eh23j05Vsv0xbEu/kN1OVblWYq9Lj6EC9f+W+RuyafvaW
         jDYRmFK2XFgD850Vh2O9J+HJ1uWuVgITD3z0D7S8Xb74iG8k+jScmYN5ap8X/oV4xYkP
         XK++OAjpueHON5AlXSh70ofRtiil9xZF8dligA3Z0P9KitQ0n76P61ugapBc7RCOoMew
         3j6+fLkm4kqdrmrKGWOZKw6+KAsTP+FQW+hzLea/S0/2GhUKWYxfkCWdDL0TzNzQqme6
         7epabvsLqV01UUxAJeQ3ZRCXuPUiXynx11JzazCmGNOOlTL0ZSxpQ8mC64M9YF/BjEyc
         pfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793607108; x=1794211908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAyyYwHdR5Ch5uO/F1MiXirGDsn56GrI3GAO8iDRceA=;
        b=bpEDElSJ+l13KF7DpQyWkm11lCT5WfDX9WsMc0KyKUEzAZXike2DEPL3jAaPX+T3Fb
         sN5OwKLvEuxlNhP1DxT2MBp+wWUofWqJEG/D6atYJB0Z4pkaoVamnRm0+PyJ4TGe1edm
         K9mQvsK/X53CT316E7+ZYaJWtopU/MBcy7GO7iVjqNg/8cf7hZjVlMa4KxWAiWevFkir
         yJV70eCke54fKE3+lKyr27A9dJz+Wl5ftcBeU04cqq5qq3e20pJucj8x0owAZl0cxOR3
         ed9uEOZLHUuFYv5SKMtU+wcnbLydX0rr0ruBTsKnLK1nnWSPCeKXKXKR91Q+tnFH2DKm
         FEsA==
X-Forwarded-Encrypted: i=1; AKwUvBzIoEuuoCYuut6Htz5qpPejUvH5/TkV7jf7c+B0VS1+PTKEs4ckYOUdl2H7wHs5jQIU2k06biA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtGxd+BUcMQsWXGIUI08ukCzlVOTAG22G9ldL6VETp58J9Oc3L
	29352ErNTNmkiFoww3ngkfV56m2FLWSQI7khD+I+E3A+ocCmZSrdW31V
X-Gm-Gg: AYBFou0xyuqiIVs0bBj6xtnlgakzVbcEqTHuxuGYTOZojT28W9SZLrI6Zi5vWOo33Jg
	GOmtinvlUlnoM+CwR3uyvfQR+C2kKtb2vW8llBqMh1Km0Vn7F5ypfF8F/KwTu3SnAfXH0SJQmHD
	m9ahqFz1N97dWrbNZsJTUSroa+lB4S/UGQ93Rc6KhZLkwRW2LsZSsH/KTpMaGIj4jEihWzcYJFO
	h3/qHk+85iMZT7uKkkxibMJOLSU9sBXLaklurnE+xjuGI3pqAKJdoB+BgPzy4I4aiPSXSWp/Wri
	lE1naacN2G4DvaWf/zY8+p8go9roynUnK6CIEa/JfwOKDOAGHHRzi/EsJ+FYECQmRO5u/0H54Np
	kVbqGBSBdO4tcaCBpbM5JTO+gy5wC+mLUQHSwVXU8qhqkdb0fP2pbQDExAfGCHgnQO3H6fDWYfO
	usg+djz+Vak1KEFKe+KrsgH/7CAoQS/kSnFFfzA4nRMb7KtEAYX+bZ/zRG95RVgN0IE4ccwC7uz
	RxBIxbP+cdngiVrgA57mDMYv3Xl3J5MDJlPHafoK8xdXNrYclxdP6pj0P4XmPbRJyNrSRaK6SP1
	bVwblnIAUn1a8g==
X-Received: by 2002:a05:600c:a00b:b0:4a2:180b:3153 with SMTP id 5b1f17b1804b1-4ac185bcc7dmr226206975e9.14.1793607108359;
        Mon, 02 Nov 2026 00:11:48 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm333331005e9.14.2026.11.02.00.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:11:47 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/userfaultfd: recheck WP registration in the hugetlb UFFDIO_COPY retry
Date: Mon,  2 Nov 2026 09:11:30 +0100
Message-ID: <20261102081140.201987-2-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102081140.201987-1-azpijr@gmail.com>
References: <20261102081140.201987-1-azpijr@gmail.com>
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

mfill_atomic_hugetlb() drops its locks to copy the source page with page
faults enabled and then looks the VMA up again. The retry doesn't check
that the VMA is still registered for WP, so if the range is re-registered
without WP in that window, a UFFDIO_COPY_MODE_WP copy installs a uffd-wp
PTE in a VMA without VM_UFFD_WP.

Recheck VM_UFFD_WP for UFFDIO_COPY_MODE_WP copies after looking the VMA
up again, and fail with -EINVAL if it is gone.

Fixes: 6041c6917903 ("mm/hugetlb: take care of UFFDIO_COPY_MODE_WP")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- drop the leftover sentence and the non-hugetlb reference from the
  commit message
- add Mike's Reviewed-by

v1: https://lore.kernel.org/20261029221129.89068-2-azpijr@gmail.com

 mm/userfaultfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f33ccedfecd2..6321bb82c1ef 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -810,6 +810,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
 			goto out_unlock_vma;
 
+		/* The range may have been re-registered without WP meanwhile. */
+		if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+			goto out_unlock_vma;
+
 		/*
 		 * If memory mappings are changing because of non-cooperative
 		 * operation (e.g. mremap) running in parallel, bail out and
-- 
2.56.0

