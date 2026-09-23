Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A15616D5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177401; cv=none; b=Pt+Os+ekNqxCa2XMXljphyFz9ffd03DkQ4LxIigy2tA6tXSZ7cUqqrKZeivkLizghPopaJNvgZ/K0mAEP2gRDdXhsr1WPehf1qhd415uzZlLMfgZ34eDyk96rdB7gr7jE3d3LEIcSUQS0PvGwB7DHubZSP+TuLlpeLDyf9h4n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177401; c=relaxed/simple;
	bh=H4k5SAbBBJbY1C36iAKTOOR5kopY6N9+yLJh32pB/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTfjWXpt4lUflwk8zPORPEbouYXYyAKYkLPaZVG07s940qfQ1sDp6eubZEpQWgNmQpAe+a3hy7uwkiTS9DvywslRmPTIQIH1cOn2WyChe/qweOfWr0BDGJvtqenmBgbtHxuAMOrD1MCEbM+vIxry1Z/qlF3mho6JqdrhGGQc5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG5H5rz/; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG5H5rz/"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so654404eec.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177394; x=1790782194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PN2f2r94Ra//aycP2t8ADfFvH0BcKZKW2u5vtKT3Aco=;
        b=EG5H5rz/i5Yv0G1nMpJQzotsTIlJNRfLHYNnO4nEbIKWYPh8ZGPIL7iN/4E3asb0el
         u/OorD2qMuIRkZisfL1B8tQUSFLSVLx+quYkcRodnyM9bh3EVHEC2/gJt/Vkb6Jt6xi0
         JTTI6gDj8BWHCBFNIofaOnDBkBsevEDlQ6pSP/UOQHyX1RJ5I2NQkOxSmFg+S4n2yRyz
         vdXEbpnU4qDFV4FgZFPWTzmBwlUgpfiEwNb2IOgJXb/FcryyuzoA9lQtIe6tQzqcorNi
         ++DKrMigoeYXNFXMJqs0+Zlbu23RWF/jb5SW4rHSFRpL0EHHamtIHDn4v9r3fKYoXZOb
         gi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177394; x=1790782194;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PN2f2r94Ra//aycP2t8ADfFvH0BcKZKW2u5vtKT3Aco=;
        b=SiJIXetbQC2SLo/NACWo4vcz5Id6pLUNi+GopTa5ydCZo2Q7J1Hv1WDy27wgdt3d1X
         v2dC9onWd6NgWHbEtE0yrcn5v83GHdpbeAZVk05insoLQOz8eqiDfamd9jxYAJa4G5c1
         iQlC0JgVvG3+Z2WhLAWN0dDtORcMAX7aZmV6UE4uXaDbM+t7jU7e8PN6IBC2bsxSplRu
         nfLyie76lru3H45a4cB/MAMFuIsQCs57xUNkIpF4wCLW5lRQav5dE91yPwz6MmXqAnrD
         WgwGorW1lhh2oe07s2zVX+6cKEJT/G0RDxUgnt7/kU6kYL/prO5DP9JpPnSAiA0q5HNo
         6Cbw==
X-Forwarded-Encrypted: i=1; AKwUvBz0gYfb5YRLQFUtLk3cn0vjhSDNOHUhEAgfNdRebv5H0903CF7AADajUp5nC+A9/BFcJscTDsY=@vger.kernel.org
X-Gm-Message-State: AFuF++k+jdOBHCOWWJCadv2cx6lLCerk6Fo6kineJJRfINuPvLGisH1q
	8W58kNJH/MXinojYH3bcdW0j0TfbG/dJ9O7hwo5ZXgwc8AgJ1H7cSbr3
X-Gm-Gg: AYBFou2KxoHucJ3BUmSYPcoCaZOPVFEHA+M6zITgRlS7nlxh+nbBSaxGNcrMlgSqOCM
	QSq796dk8wz3c2yApOwgOkTwoKep2Oc9sj3xz4aA9btW02i3P/CPhiOEdBATojygVx68SciRfKY
	2jsp6t0P05DUFRAtswoGOdcUeQKVtECZRrOpTCduUSGfBLAlIIkB0d0Po+yj2ELRx7iybc9sTsG
	wLhYkS+4aKpZktldc7KkhTATXYEad6JMkEzgvl4M3WsYW11+lv5peKgKn+UvkbiIIrX2RWcfnwa
	P9d53PKA3no4efYVPzw9aUqtCi+ZVihNaShRTuh2dgjFFzdjmpyyIzS2HhQh63vLu2jOoihOWrU
	fpxi3QQsyheikYXYjHZwfmYzemXqr9e+t90IzJnv6f57JT1TUsniJ8FZwaHy3MYPDUxztn5X/+I
	qpcyJEFC3Aubx11LfZ8iH1QgJ/V2RletiLdTukynlawaHmnQANGZM9/IafZzmFXA0=
X-Received: by 2002:a05:7301:6187:10b0:33e:c164:b5d7 with SMTP id 5a478bee46e88-33ec164b694mr2165164eec.3.1790177393626;
        Wed, 23 Sep 2026 08:29:53 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d46f48sm14049750eec.23.2026.09.23.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:29:53 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/qxl: use correct offset when stamping drawable mm_time
Date: Wed, 23 Sep 2026 12:29:37 -0300
Message-ID: <20260923152941.1297199-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923145018.1244740-1-qwe.aldo@gmail.com>
References: <20260923145018.1244740-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

qxl_process_single_command() maps the page containing the current
release slot and copies the userspace command into it at the
release_offset within the page:

    fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo,
                (release->release_offset & PAGE_MASK));
    copy_from_user(..., fb_cmd + sizeof(union qxl_release_info) +
                   (release->release_offset & ~PAGE_MASK), ...);

However, the subsequent mm_time stamp casts the page-start pointer
directly:

    struct qxl_drawable *draw = fb_cmd;

This writes mm_time at the page start rather than into the drawable
that was just copied. The drawable begins at the page-relative
release_offset (struct qxl_drawable embeds the release_info header
as its first member, so no additional sizeof skip is needed for the
struct pointer).

Apply the page-relative offset so mm_time lands in the right place.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: drop the sizeof(union qxl_release_info) term — qxl_drawable
    embeds release_info as its first member, so the struct pointer
    only needs the page-relative offset (found by Sashiko AI review).

 drivers/gpu/drm/qxl/qxl_ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026..65e9bfd 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -188,7 +188,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
 	{
-		struct qxl_drawable *draw = fb_cmd;
+		struct qxl_drawable *draw = (void *)fb_cmd +
+			(release->release_offset & ~PAGE_MASK);
 
 		draw->mm_time = qdev->rom->mm_clock;
 	}
-- 
2.43.0
