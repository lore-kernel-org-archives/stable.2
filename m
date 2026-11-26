Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681017;
	b=1HLgShFlMaTRicLrvrcs+7zThLk3RKe03FV4YiSomqtDRVnostjQgxoaT04rdMg7gF8z
	 yEqeC4KG6O3+ZGeRbHdPi4BRNcNhTGjORVtZC96CDhzjQ3Cd/bHJshFLC92KXZ8gr9MG8
	 bhFjelLRPgA4Vay5LpBa1/EievynOmhah490f5Vhg5/fhD8cJl/fpR87dSMwFDWdziryO
	 yzgxhgdlt0XyEImOssWRyxq09dxph5LO08LIzobuaDzPmePez7zAmtQmr261pbs0ruyVr
	 TNeQNCn1v3X4KVJFRui6d8q6CcEcV8T4r6yo6Br6ygT4YN1S3DFyK+nj//cHcY1OmWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=X0MsT9VS5PnQqjPZkQqcoPk4cS0Fvp5tQXMqwf/FufA=;
	b=5H2OyJqij+yqwT9BlB/Plx2lXhf2iM/6fiLoePcdmPoy4FsDvtpWb6R/BCl69Dv88oF/
	 0oE8T1m47Dd8efzfXC/fAR+lbRnV+k4PBII52QIe/cCknNqANLAQ5XnjgVJ1I2lLHbSDR
	 oo7pDQ/pm8KE+oP8XU41r4rLd2+j6FWMYhadPwhbHB/RXpxGAqv1GE0rtC2xvcGW6NAM7
	 ixdknIJUbEXc44eo2oeCi2/X0D25JtJqMd9RDsS7V4mGyV1JqoGsByVTH8zfWYzCjy9AP
	 sWFWhNbxFOZG0nr4CSoGpbF46OqkOoNKpgVDLwkGh8sEazORTM0tpUGZz8amFPymnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UO5xRehe;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B3606A330
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C77B3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UO5xRehe
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so13925145e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795681015; x=1796285815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0MsT9VS5PnQqjPZkQqcoPk4cS0Fvp5tQXMqwf/FufA=;
        b=UO5xReheEIak16+29fxeXdcAj9axaPoEALC8DGvMgH+cEGalZUyCvsBZLIx5WQYuzy
         M58afJUhAYulBqaJUEY7dhwLsKEEGiZ549487BsnzZulV6p8kDoL7QpVjsk9rdFvw0Wj
         kOj4wHqaz9kUMK6VDzW1xjR5iqOTPebZR4lWi6ZzNrRFA1o8Xj265+881iTS8Ye0fiWw
         PGcNdioqaJjd1DrXVjktp0w2V24BWAiQ4h9n9MZIhnZhXJ6EdjtWq876/8FocfUwtmXh
         83tT2zuEXx5wJ/TGrf6Uu44jhjv8DWlYxlTIvvsod8LrOhG0wFz9dbj65CrIrjzkSHMA
         K9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681015; x=1796285815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0MsT9VS5PnQqjPZkQqcoPk4cS0Fvp5tQXMqwf/FufA=;
        b=ISN5fwY5Z7R6Zfmf8OgdxxuBE2zWVB6d7rdF8GnCMmEUHCCa/MZW1GdotO11pk3ItQ
         L/2DqvZN34Q0CTWCGMINkM9JgXAhwiq5WycHmo85omd+GhlQFtyHzs1vBdIAS8QY31qD
         2Tml5T6BSa9R48KKPNvuum137JEUPGxBK8aaj14cq1LNwmDXF0xsFgVic2lT8+CidrB6
         F4b0eUXWUvJRcQura4vEnj7ZNDE5VKaC4TqWwVhl5OU4dsx1NPL22mHb0U4yFGN9qOQs
         z8dtZFX7RnLBa9HyT1sJu8Ccar08JU4Y+wCfEuIEHfhsMDS/jCIaX9BVI44Y6TUFXOhK
         M5vw==
X-Gm-Message-State: APuU4Z8Z2w9B9FWWwBrirpUw5CRJwBvoCoFF8Iyc49TMU7G4WStbV3c0
	+sUExWPCMvt1YdlGZuQaHOtgla9XirA6Uh6yJIFSaKavfYdsjDCRmur+LlHw6eWiJic=
X-Gm-Gg: AZFdTZdtAsQKrBVMsywjsIG3/JwMlvythWKQDD5fRM8e/G7+CqXDXiQIwku4G9I+3fK
	y3EClxdYZOmlf3ark4PUGMteoVd7wmFWpu3rh3AsBe3/Ls/bkMxj/04f/AepJ8QHImRKcUxeluh
	toU4v5FxioCGfrg7ob9oVwmPE2BB+LjlQKhhtKQG3/fQIUJZLxCFQh4ZSqNg8ZE9zBZM6fLMV2L
	eWYijz4Va8QvxDPDm/Jov3mLk9LgA4s9hY3oi9w9ruqjlXaoARchL8SiFUQQK7ZsDGvHqavXbrG
	B9uscCCGom96UakwYjrzqtpBq8/wBrqhgNSu+bR2Ynt5KJsTFiOj+D94JqZ99DfJlXzIPIHQbF3
	R7kqJ06BuJKHEq+5V+hZjwjFNU9077ERZ8He4I7+RGZ/+sjxBpcTjlDnxy7X0BV68eZsQ/cylIU
	Q3qUmr8MTYpKHZ6bi3JsEtBovdYugJqNykhiSGFzFrj/p+xN7ohvQ3Q89NVaNvWF8OU68+knD5/
	z1rS6bNGSRH7QUJDqr73eKoRk96KT0KQWEZyZ/mJPDTqy41cdGBgqT2tl8f4JICmB8UCkrbpCbN
	WHVw1gJcIG2QGARucjhveBjQmQPv8SuOmQ7NVSRrPE6XC8oZL7Mdhf4h9r8xWnKHWz20eoej2Q=
	=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb8882672fmr425501975e9.6.1795681011621;
        Thu, 26 Nov 2026 00:16:51 -0800 (PST)
Received: from grower.termidesk.ru (ppp91-78-19-165.pppoe.mtu-net.ru. [91.78.19.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm569559155e9.10.2026.11.26.00.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:16:51 -0800 (PST)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Bharat Bhushan <Bharat.Bhushan@nxp.com>,
	Eric Auger <eric.auger@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 5.10/5.15] vfio/fsl-mc: prevent read-only region mappings from becoming writable
Date: Thu, 26 Nov 2026 11:16:42 +0300
Message-ID: <20261126081644.45517-1-alexevgmart@gmail.com>
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

commit 25fd8b27ee8d4f59cc2ad99cf67aef4570b82096 upstream.

vfio_fsl_mc_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: the fsl-mc bus publishes all device
regions with the WRITE flag set, so no device can currently reach the
read-only path.  The guard costs nothing and keeps the mmap() interface
honest if a read-only region ever appears.

Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Link: https://lore.kernel.org/r/20260929094848.7439-3-suruurism@gmail.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-99810, adapted for 5.10.y/5.15.y: vm_flags_clear() appeared only in 6.3,
use the classic vm_flags assignment so the file builds on these stable branches.
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 8722f5effacd..e77062cf066a 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -494,9 +494,13 @@ static int vfio_fsl_mc_mmap(void *device_data, struct vm_area_struct *vma)
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
 
 	vma->vm_private_data = mc_dev;
 
-- 
2.43.0
