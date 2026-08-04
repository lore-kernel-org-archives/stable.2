Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11E3B3C01
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847366; cv=none; b=t8l6XMYFZJKudNbxCiygnthU/LnDKF5oBYRWnn+YXG+8hCYf/oMeL7HwJBHPyE+DP48kyYYFVvyNXof3bvCRTOuqBasJIMaX/XR2dHfxmwvrcbfE7ZAEdxi/1DX0apvWV+4e00KBKNETMjsSnNajKQdOAO9dWJXANTBh3wnzbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847366; c=relaxed/simple;
	bh=e5NCBpTGzYfybAUMyMG4nXF2dd7JkrM1nwrRD60g2+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rahRU8TsjkinCTgVuyIXfdyhgOt8cutOka9L5xfMTYeANzV2ePFPbUB68sZ8ogoNwUrWjmGmpH2yGU03xKrG0443oQ+8161sbdm4btitBxQ4CdvFB5sxDpV80Yvsnwu9uPcC1A7a7weslZcz3wagVWUlm6D7c7Wgnr8etaHdrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnUxdVTT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=re05HYlp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnUxdVTT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="re05HYlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785847364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TQH/JjUvcOWyxPKiyYjT1Ot442Ew27xIkCxVhNUrEBI=;
	b=VnUxdVTTW1YsXAHFu/V4ktBqAVxU83Zx5fnV84eqevsSnCAWjZAXSqkyxDOS5sZAEYKoo6
	XlIzaKmQeJPYmjOoWb55NkFa0ASWxLgAhlXN0QkTqvSpQU7d0mU9bJEU8eM9raEMBpXTi6
	JiKfIKTBbzjYp/OG7yDu3I/GvLQrazY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-vFpuQf5lNlap1_FlaHNwTg-1; Tue, 04 Aug 2026 08:42:37 -0400
X-MC-Unique: vFpuQf5lNlap1_FlaHNwTg-1
X-Mimecast-MFC-AGG-ID: vFpuQf5lNlap1_FlaHNwTg_1785847357
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83999cceso4121712f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785847356; x=1786452156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQH/JjUvcOWyxPKiyYjT1Ot442Ew27xIkCxVhNUrEBI=;
        b=re05HYlp4WNzsb2GSoUnOYw2BBFDz3YTJnktfkKCholajSI1QdIdkrVXj4dTXzWUgW
         43FcEhWfTPT4utg5X+XyJF3zznpNOOX540dCYTsTbteiUh5TPm1TqCdrJfmF5NJ/IQ77
         bxlu72hoREHaH09CIvwoung4FcTekI19yqrpltW3zrdtPDOd5/qyk3V/QnhhnhGFgUND
         lQWjKVheG6tEA+A4AcmLK4yMkmuH+bCZs6L9apd1Z2TsCffuf9HNuJds0y1dKN8/b0kw
         ZaTd2yr/TJgvRHBD3ZDdoPjptuZ2h7nhpH3ozvN0qsv0lFuw7Yh8WldTyTxb0ocmxkTe
         X7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847356; x=1786452156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQH/JjUvcOWyxPKiyYjT1Ot442Ew27xIkCxVhNUrEBI=;
        b=WTjrZDMKaLlfUTyuIDbreiJ7GvcF/qIChWE1syCxPsQlfAESenO3t2DTAfIWgXrxR7
         vOK4SJ2mc3Vk7P4VyXbA0SXT9TmB0xzgO5FMP8vFbUK9aVrbaGOshRgfKBLiJ/DKa2yV
         EhPRoq1mBvgXy1gblWGWA42Wdf4zOMVybiQ6mgtouemw/E4DT0wOB3NwXjHmRSK/gfNd
         zqW3HtPcFpou91GaoVqejHl1TAygBsa8lmEdjRZv6joOZasCNOHRyAbFjLEzBAceC/to
         /7xFWdE76nHkwovyJkwpJkyUn5Uml+GfMew/WnjN8XZ+vflWD9QT1BahhZz/Dz3+pbmm
         CQHQ==
X-Gm-Message-State: AOJu0YzqH0J+Ih/TzClu3v583sA9ZILMVOqycqu0y3wT+CDQZVG3Px7+
	ySr0UHtMh7sMHmXk2fWcbgB0yyRuP7dtR2eXeWNQdguTnkygECXBVyeP+4aeGaN6PSkghHWSLPD
	6p45B82iyML0HKRKckzfdAzUSBb1SG/+K2oMvuxcgjLR22CCGgFOrWbfVoMb7ytzByQ==
X-Gm-Gg: AR+sD10B04HYK2q64ZRE6vSjhZaSjwwx8lAqkoUHKj7SJyqjOhcscVXwLrgonHkDe7/
	PVAahHX+WztwkjD0Ff+eHcoTRhFLIRc6x8ONfkDTlQI+Yp1ielewc1HSE/oNQLQa6ljWImDUuXy
	gl5ltx5L/P3Z7D3qZnYpi7OA//rg7QpsWTkmulpTFBeurLyFJpz2OXUYkJErktcmhlP7INy5Hms
	EO8PDlRmMtsZw0qxHTiCHCCXsP5l6r4LbVFukua6610oVDkbs7KssBIPu0FNpJrZNN9R6hQb244
	V2w1KTnBDGiNbpo32FpIX0RXc6K//3Bl7w7i7CuW3JXaAQtxjTpeEwnD9mby/GqJ865G0gKLudZ
	a+eIUcqcXlXUT27ZfJGvPd7sArMsEnssl1cW37bhDuSBZnzh/DOuUJ2E/i1ckGa/Z97vL7Gof69
	gwbI8=
X-Received: by 2002:a5d:4c90:0:b0:47f:881f:74a8 with SMTP id ffacd0b85a97d-47fd72e179dmr30765548f8f.28.1785847356681;
        Tue, 04 Aug 2026 05:42:36 -0700 (PDT)
X-Received: by 2002:a5d:4c90:0:b0:47f:881f:74a8 with SMTP id ffacd0b85a97d-47fd72e179dmr30765483f8f.28.1785847356310;
        Tue, 04 Aug 2026 05:42:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cf404sm43069323f8f.1.2026.08.04.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:42:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/ttm: fix handling of errors on prefaulted pages
Date: Tue,  4 Aug 2026 14:42:34 +0200
Message-ID: <20260804124234.1742087-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fe662d846c95 ("drm/ttm: remove io_reserve_lru handling v3")
mechanically converted the goto out_io_unlock exits into return statements,
but it broke the promise that errors in speculative fault would not
be reported.

The old code was

		if (unlikely((ret & VM_FAULT_ERROR))) {
			if (i == 0)
				goto out_io_unlock;     /* return ret, i.e. the error */
			else
				break;                  /* return NOPAGE */
		}
		...
	}
	ret = VM_FAULT_NOPAGE;
out_io_unlock:
	...
	return ret;

while the new one does the opposite: it returns ret if i > 0 (previously it
would return VM_FAULT_NOPAGE), and VM_FAULT_NOPAGE if i == 0 (previously
it would return ret).

Fix the condition of the "if".

Cc: stable@vger.kernel.org
Fixes: fe662d846c95 ("drm/ttm: remove io_reserve_lru handling v3", 2020-09-03)
Cc: Christian Koenig <christian.koenig@amd.com> (maintainer:DRM TTM SUBSYSTEM)
Cc: Huang Rui <ray.huang@amd.com> (maintainer:DRM TTM SUBSYSTEM)
Cc: Matthew Auld <matthew.auld@intel.com> (reviewer:DRM TTM SUBSYSTEM)
Cc: Matthew Brost <matthew.brost@intel.com> (reviewer:DRM TTM SUBSYSTEM)
Cc: Thomas Zimmermann <tzimmermann@suse.de> (maintainer:DRM DRIVERS AND MISC GPU PATCHES)
Cc: dri-devel@lists.freedesktop.org (open list:DRM TTM SUBSYSTEM)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..6d59f3c0696c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -267,7 +267,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
-			if (i == 0)
+			if (i > 0)
 				return VM_FAULT_NOPAGE;
 			else
 				break;
-- 
2.55.0

