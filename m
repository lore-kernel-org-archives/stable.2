Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681000;
	b=rHaw5WEBnH7jfeTRFk5LdlT37mgwswGalYqScacezF+jDHoNq2IzWwC4mqC4QOVyo3je
	 cX0pp1aFHJaksr9iWHakj2/EllKd1Lr9ecJu/NgEN41oU2PftE1cctLqOfmyVX1hHFFS8
	 /GXUgeYEe+htkm2283usH5F1bTd7/nCe6be7PnSflWzP7zhWvH6cyy/PQOMd4+mvpRhJ5
	 iLDsynmm8tDtDL2thpHyVyE4FJIscynodyITiObQrFFPn1DpOuXWJBktiOfX3OdiJqWz6
	 GbwD3C/I1NTs6rGBDsbO64JH0GoEPKy/T5MUI1IyYE7IqOgTSHvgOTz2bjOxjnXJjrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CBSIDCKro4GDs12iDpbveHASbLjhtJ1zWAB1w2J4Ssg=;
	b=Zh0DhpqO6TO963J99BHiqYIZVeRv6IPl1Qi3Rn6DqFlBRgZ80Zn4ovN2b35Vg44/BYc6
	 AV6UfabG4GqIFv2COAlHPXyW+hh7NDqRzqdxUYV4qLTetv7MffuL+dZwLw39Om1bc0ist
	 XyWIAU9B9eGfVIX5X3o0FElbCklHvm5XQqNotvgNTCqi7Lzaq/mHppspjAQH3Qb58sCUT
	 /wHDvnIC71VxU1BgagEDgPsXiu9ry46bc6AY+eeggskrNjwN95XFG0VMC0+OhpAdOKj1D
	 5wIEl/yxd0T7N+uo7n5JtXfYKQJycvm7fsuzPWDEk1ZrQ8+cSIypCc7YpDjXWOUHcFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQa1AFXI;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A4606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQa1AFXI
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so41577545e9.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795680998; x=1796285798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CBSIDCKro4GDs12iDpbveHASbLjhtJ1zWAB1w2J4Ssg=;
        b=PQa1AFXIZS40/OkHRWSeK9C0cJH4iXrwvZSbqalNLtcMObluAt2ryBFq+7UwnlrGtk
         Rpbe2zlplBYfObUSV+nJJDjWG678OAAU2fzBxTF8TZlvuYYdU/GZtHr7hSj8Q1IpBCmc
         8yQFV7mvXIKXGc+W+jn0ycgK+gI1vzpJ3l2H4s629XIWdwtdjEcRdVSHbORecbNpHt3i
         5mR5Xd+Jz+7wusXeD3RH9hRRtV0w7xy8BY04bYAHjHPdkXq43OacZwmVYeQZETI6dHcE
         +SCTpHV7CYu1AjQYSuSBFHoaFIFiSg29kxlBkHG1eOXjWNMT72xh4kU38MjsOXLOYTpd
         S2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680998; x=1796285798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBSIDCKro4GDs12iDpbveHASbLjhtJ1zWAB1w2J4Ssg=;
        b=F7H59CJ7wzSLB43HeG7xj9PksQ/mKZz3F3luj0NfdhZJEj81Epob+8Enlxzibn+AxX
         W+B4X8HRyqtqzMzYLYqRAiX9vbtH7ou3QK8dFGf3Od45V1t7jGFwjQUZAIgDWZUXaGQZ
         KTEeUfrYir7c7TnmVrij4z/ta/6N3zl7qbxcj+F1GlAXrqHVktPoQmjCVReq1XF+Y3tq
         /zGg6qFv9eA9gwthbA6ktMjGn62Zem0Nidno1uFit3GuuVqcL2xupOE9Ca7UmwVS61bK
         04EyCBRMp5PnRelSc4sQ+V92jQyo9KHYO2baTjFg0XygEoRvWmZEq5whajSenp3QooAN
         FFXw==
X-Gm-Message-State: APuU4Z/mNpTNHwp5fQZV3FR9B2McKijscnvFyWFUjxNPIro8KBQdviTC
	2j6hnSwO5tp5+bUUPYI/nB4Hqq8SyiXqrbfx6ZXMAnBLTZ6ztXft+xv/bac+vper
X-Gm-Gg: AZFdTZd2xZ6/g+HDM0Mp5lt+vWaql68wSDFh49RNGi0YDToYMgDQBdKdopO2GDbySxd
	ivlVtCDcAD25kDg627999TOlErESd3lZmH17Y/GqrF6BK3cTUJI5KVGHSSQgGSJxJVjomX1K7iW
	RIuhCaNPunnOyvzXVNcyjsLiRFN3I89X8fE6Ki5MPGd4grHh9t0JjgREvg8FV/13iFKcvkgVHHg
	8NYyOfvTHaUSt04QPTKxj0xlC02ieWW/BV+gXQbhGBq7j3k+XaNpDcSQ6vGgBUYcU1P4bYmO/cb
	7FrgLx2Cb9RJh6SywAJMFns3BKbYfiJjeYPEQLUoNyzY/eZUbZpvl9d0JfEi8980/N2ynolhOBk
	4NHEy5pC0h6IPKloj8g2pelgT7c+EQo7vka3ULMPfPjOAEZWb79J6DdMIobbw7R1Fq2eL4jfW9r
	9L7C/6md8PxqPvOlHbRlsDnLKatc6kD5a4TJodeq9yZOWq82j9dDWWHsKgA1tw1nsW5hl+wP9uH
	YY/g+MFfnT+BpCshwnisttmzJdwiAdLUe/uoW3v5Vr3P142I86C+QYej5MOi5nVaYxQY8EQT5Lv
	AZ5lW3JzsD0xvoyAq/TwbmXczSew6CYLRApjyvHo2TqyV6WA+oS7JChg5+q91WML0ccaeiRjTA=
	=
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr407967675e9.1.1795680997558;
        Thu, 26 Nov 2026 00:16:37 -0800 (PST)
Received: from grower.termidesk.ru (ppp91-78-19-165.pppoe.mtu-net.ru. [91.78.19.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm40320996f8f.11.2026.11.26.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:16:37 -0800 (PST)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Antonios Motakis <a.motakis@virtualopensystems.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 5.10/5.15] vfio/platform: prevent read-only region mappings from becoming writable
Date: Thu, 26 Nov 2026 11:16:30 +0300
Message-ID: <20261126081631.45468-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Abdifatah Suruur <suruurism@gmail.com>

commit 420bed9131dbbe37abe9d6b32af51219875811e0 upstream.

vfio_platform_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: no in-tree platform driver currently
publishes a region without the WRITE flag.  The guard costs nothing and
keeps the mmap() interface honest if a read-only region ever appears.

Fixes: fad4d5b1f042 ("vfio/platform: support MMAP of MMIO regions")
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Link: https://lore.kernel.org/r/20260929094848.7439-2-suruurism@gmail.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-99809, adapted for 5.10.y/5.15.y: vm_flags_clear() appeared only in 6.3,
use the classic vm_flags assignment so the file builds on these stable branches.
 drivers/vfio/platform/vfio_platform_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index ce67ed9510cc..64c4291592f1 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -617,9 +617,13 @@ static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
 			&& (vma->vm_flags & VM_READ))
 		return -EINVAL;
 
-	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
-			&& (vma->vm_flags & VM_WRITE))
-		return -EINVAL;
+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EINVAL;
+
+		vma->vm_flags &= ~VM_MAYWRITE;
+	}
 
 	vma->vm_private_data = vdev;
 
-- 
2.43.0
