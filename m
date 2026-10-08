Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDD361962
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486796; cv=none; b=FU6IRPRxc0HMvHD6SuqEloyrMorcwA1qmX7KRvOKddt04aqIXiQb76riowvJSyM1md4EmF+dqPCnnmgZNFWX4mMznGKFqLI1CdbKb16sBjIcvb6Lb+aBH5fXl47LoEZFsGJxEjpHSAfA49qBy0lyABD2/JTHaitfVkmr+pWOOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486796; c=relaxed/simple;
	bh=BJhZEjV13NfMfJ70FGMT/OSqJQFIXDnnD864pIvSPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3GPRUuSURwscyKGYG+fasKynAQHjQ8ysKMV/NweARbZ29jeP8idiXpBGwH1SSeS+wLLWnuh6OI2ddk7y0GxxpzskIONG9MlH3wGvQjNt5FGTMZYOo9/oYYMlxO/6Z87Lq+EGUW4kGmdMkmaKA618/Yko1cRI4Ua6R2kLWZUjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=GX9DUnyK; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="GX9DUnyK"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so1923503eec.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486794; x=1792091594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdYp5F0mgTxGu/EPWqlstTXyTWY/Kq4qdM3AvQLOhGc=;
        b=GX9DUnyK19tZHgmWnrk2ph/WMOxV7jIYuWcdWMFXeczyJgSuEnflyhQNVVxzLDkJ+k
         nBlNVwEIaHlaeNoEoc6Kd73w5FFbstzr1w7fEKO/auEL76pbVbRkVv3J0n17Sx8028Cf
         GotFzFXBaX9ZO6aKA1SoIfQplQstIJAOetwQRDBVCybAOnKoMsGx70pDkYFLWMYnRfzt
         Pu6lQYYaWqcx46ZyIZMg/sGyYgxHoURTaoipBEwJBTbWO5zzSdux5lkC3LAEc486qMbf
         sSRq3t0qlPmpJa5cAoWZmGrLt7jafiYjhq6UiUdCfrXcsOv7gQ3RHrxfmPqrHyGclRKQ
         cI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486794; x=1792091594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdYp5F0mgTxGu/EPWqlstTXyTWY/Kq4qdM3AvQLOhGc=;
        b=OvQAPIN0TklgY6PzZ6BhOaB8bxD/BxqzlvWRTgw4a/3MCzlNd4zCpUb30BiALzPgqf
         oFRFsDtitWLU9lyAaqM9SdoJ1qs2k29E1FBrS8xU1dBmjyRcy6KI7lGHHeeycyj8upBB
         cbIMLe7XsNqN/aJUaPrO0Y+nugXnUpB5EoqCLF9tcXnnq05iOjYY7bvRSZQNsORjxpsZ
         29oFgyTWbpf3Y7i4QN46E9ZVfHUgUqSSb8VfTtN4J3Y5hUTkEJN7lAeokVkuB9b0bLr5
         eGEbyqrGHJdrHWVOcdYKCvmwt+cunFeZYJpzKZ3ZdvbESnOfJsMCWfXVGz+cKgacON7N
         AkQg==
X-Gm-Message-State: AFq9FYKbQKwXuAhV6QHHZVAs3EJzU51TOueUMgQJ2ZPK1SP9TVEXTDJ/
	yYGq1efXyL2WmLgK30UDYip4FijAyqqRexUGR0BcfYm8MTKlE4vEwVEB5hmyRvogf6K2++JZjXI
	yQZZG3P+JoQ==
X-Gm-Gg: AYBFou0YCsCUiXlgzKnw0sY0BRS+z9IyxrgStOKXaT3rjwaCeyRfEMzQ9VUFeOqg95r
	upKtXGEdRwSKz2oLkkGVJHQRs0nKL3tyMVkIKTkJAcKNS9ucnEN6+eFu/mru01S6FrNUxtYMupn
	1usNT8FD/yupgUmEMNgY9vz+avLB3mG6Q1MmIkSZRyYx/Xm9YXmV2alpqWX9HmDikbok9CmA5UD
	rgQmCOhY+0AIrtZusg14Lad98Mfncu2GXuKHQuibN6awFD8pOVxVuVEGexQ1eRQNTgSipYVGri4
	gj3M3Q1Gk6Cb0RJH5eq0PWFGhUKAVuWs75qzGSJ+PJgeRCoSl7pnuBsSc5L1b0XrFz5kjKnPV2J
	W/bvt0I9wvrWW8sYBJ3zHo+B4lcbeXCC5rE7B13aDUGz24FdHdTJCMs2LaAo3QhEFe0YMjCrMK8
	fSrf54rBoJvpKJFEsui7WDH1/wL4UBhIsW/puw1tAPNPadPuGV6zbXGMcS4to7jMVuUXNTJcl8u
	VHuKm21QgjAdFh+j/mtm52oJnZadst5zKXJlgDOIfX3nHncKvCvaG+xqNG3OfdhIBicU0k=
X-Received: by 2002:a05:693c:414b:20b0:351:1cc6:995e with SMTP id 5a478bee46e88-3515dbea38fmr8630903eec.5.1791486794211;
        Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:13:13 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] fbdev: hyperv_fb: Simplify hvfb_putmem
Date: Thu,  8 Oct 2026 15:13:04 -0400
Message-ID: <20261008191309.98263-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit f5e728a50bb17336a20803dde488515b833ecd1d ]

The device object required in 'hvfb_release_phymem' function
for 'dma_free_coherent' can also be obtained from the 'info'
pointer, making 'hdev' parameter in 'hvfb_putmem' redundant.
Remove the unnecessary 'hdev' argument from 'hvfb_putmem'.

[ Backport to 6.6.y: Pass info->device through the target's
  hvfb_release_phymem() helper and remove the now-redundant hdev
  argument from each hvfb_putmem() call. ]

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This is the prerequisite needed for the CVE-2025-21976 backport. Makes
hvfb_putmem() derive the device from fb_info, which permits the following
fix to move framebuffer-memory release into fb_destroy() and honor
outstanding open references.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 drivers/video/fbdev/hyperv_fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 80e8ec36b7db..80e6d9682179 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -973,7 +973,7 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
 }
 
 /* Release contiguous physical memory */
-static void hvfb_release_phymem(struct hv_device *hdev,
+static void hvfb_release_phymem(struct device *device,
 				phys_addr_t paddr, unsigned int size)
 {
 	unsigned int order = get_order(size);
@@ -981,7 +981,7 @@ static void hvfb_release_phymem(struct hv_device *hdev,
 	if (order <= MAX_ORDER)
 		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
 	else
-		dma_free_coherent(&hdev->device,
+		dma_free_coherent(device,
 				  round_up(size, PAGE_SIZE),
 				  phys_to_virt(paddr),
 				  paddr);
@@ -1100,7 +1100,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 }
 
 /* Release the framebuffer */
-static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
+static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 
@@ -1109,7 +1109,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
-		hvfb_release_phymem(hdev, info->fix.smem_start,
+		hvfb_release_phymem(info->device, info->fix.smem_start,
 				    screen_fb_size);
 	}
 
@@ -1223,7 +1223,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1252,7 +1252,7 @@ static void hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 	framebuffer_release(info);
 }
 
-- 
2.39.5
