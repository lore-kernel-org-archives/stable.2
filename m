Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924D37C0FC
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789275016; cv=none; b=OJ1ypfp6iBXSZOeBDjEfHmew3d83qjlhIS1izFzuge3v+AcGZpNIAOFKzaxtouRfNwopOv58MI5dtaNOOaZG4at0lZ+ZDhHFvtF1sHy2X9j4Xfpd3auzLOrwySjyIlyIHRO5WhjxFYEy2CuHDN8wdC5a1jflYHlr0uaC0hU7HZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789275016; c=relaxed/simple;
	bh=jiBek9fBBVmga54FLaDSIboQGEfdZWeiLHQR6tbPb3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLuoYWItku/j682JLCLwmUn1K/RfxLmkLNWzPfuZaLLR9pMfUUzuwuRl6dQRQRBpcPxMxiXIXLLUrmKMMNhUahXa450fn5Ifgivcp9wKT/nOZiP0bJdl5p9kOm/IF3I7dIDoclKMO3U1cEp/AhLYMA2zZ0XnkP+UZq5hALJHKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krRxM2B3; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krRxM2B3"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso11487715ad.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789275013; x=1789879813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IcspykAp8b/TAa5Da1Y1EJbB5NATcWKA3cjbFzlW/ok=;
        b=krRxM2B3d7h8nG+kxu9QxzOMG/updkTHgHw/0T1IeNsoHQDLUsmZENNnTBruGjO7JF
         +DjgwdKTZv6HmD/QON8Cmb7OSPO1ad5F/bIO43j9/tyo5/q10Y+6EEo61RVdrQi4LoJr
         dgIhZ5R5R6J7YdswZIcRKzG2Ke2FB+2p1nunApljq4yWlTRZnzetEukodBvDLrekdLPd
         cHM/glQTAxMDIDp7GIyqUU4TLyfJTn6kxH0K1WG6+ba5hfXUEQzzL3F+4albtyUnwaQV
         2mWziu0eH7nJzB6jS+xO42XeF2ad4hVvR1yg9m1nYZ2ohws/QgDUk6FctUjUPDYD1fag
         cczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789275013; x=1789879813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IcspykAp8b/TAa5Da1Y1EJbB5NATcWKA3cjbFzlW/ok=;
        b=W2bRTz4vfxBPVTF7h+4DWZVdGaycP6w8HHobypO/+WeaMinPcdbIPl5DY0J6TRW3Bx
         YQzU4OECc16Q4tf0LC+G9VAaSpYvoILtZTqIdDLwVXkGh691bcqzAQepXak+SeL87Y2B
         S4AugzN1quhGLY+puMomp6irxEwwcyaDtZb3yLrgPj2jXmP7wn5Gb0Y82IuKpnFR6d24
         1f7uSNM7vscVJvVRqGdGfs2z4Unj0LjaeTtgf4cz8/MA3dNwgfvBFIUr0OtJ1YgT5rSr
         HQqX1MYrddoe/stNyVW5FUCbwmlzc2euEIhqIOyyD0ZB/jIZ5VUy5Sq9m6wChNGaE/At
         EpAw==
X-Gm-Message-State: AFuF++naEgL3V0GDtoiFt6YNmnDd9Emjol6W0KT13mb5fQVWR6Lv+ujr
	GOTTej1IPl5zXtd6Zon0bpH+Niie3JLy8o13W2Kh3p9CQ98oYonCAoYz
X-Gm-Gg: AYBFou0rHVPXT3MvHl0wxsm/i930g4r5iWk2A/tyns02bdDlBeWhm7epzilXgG5yBR7
	ockvT97RqgHl2IdisIVucsjkwj2ZE/tsCztWyeH5KOEKyfxjlTTO7hydYGyZs8Ecsl6RVB4MxmY
	LBQWcou7yZzRaeWNvpiQGgWU3Fn0AEnLsvJOqYWIvzTYaHTYqcRAnEUQCj/P3sM6xZUxLAdtGjF
	j+WDys2wAaOn8MDmwXn5lHWr2/eX+JRVFhk1yD6a6hjHwKXqZbMwwphWts8/4W0PKEVQOhTKPUh
	hO0YcxRC6NLp70Hs+s6ZOXF+pyW7ZybKIrD2II2iObyqWCMhdbZrWeHKAX+MB6cM5H3J0MzpgDz
	3lcRcTUIgnzYBkanRULuDOwOpYv5ENIYVnOZm9tyH+x0dhXM/el6UHjRYbmhhIa2TzyblooLQ+9
	sEqOE0ckr9SBuN0qe1bpUsTsI+h8M4Zt6vNSrIJHH3hHaRbpKDeRAKLYg=
X-Received: by 2002:a17:902:d549:b0:2db:56da:6a0b with SMTP id d9443c01a7336-2dd2a34638bmr217738655ad.13.1789275013002;
        Sat, 12 Sep 2026 21:50:13 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb1c94sm29276815ad.31.2026.09.12.21.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 21:50:12 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Peng Ma <peng.ma@nxp.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: fix ppriv memory leaks
Date: Sun, 13 Sep 2026 12:50:01 +0800
Message-ID: <20260913045001.1126563-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpaa2_qdma_setup() allocates priv->ppriv separately from priv, but the
allocation is not released on all teardown paths.

If dpdmai_get_rx_queue() or dpdmai_get_tx_queue() fails after
priv->ppriv has been allocated, dpaa2_qdma_setup() returns through the
error path without freeing it.

The normal remove path has the same issue. dpaa2_qdma_remove() frees
priv without first releasing priv->ppriv, losing the only reference to
the separately allocated array.

Free priv->ppriv on setup failures that occur after its allocation and
during normal driver removal before freeing priv.

This issue was found by manual code inspection.

Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index bf771251264d..0f0fe0291a06 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -365,7 +365,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 					  i, 0, &priv->rx_queue_attr[i]);
 		if (err) {
 			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
-			goto exit;
+			goto err_free_ppriv;
 		}
 		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
 
@@ -373,7 +373,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 					  i, 0, &priv->tx_queue_attr[i]);
 		if (err) {
 			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
-			goto exit;
+			goto err_free_ppriv;
 		}
 		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
 		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
@@ -382,6 +382,9 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 	}
 
 	return 0;
+
+err_free_ppriv:
+	kfree(priv->ppriv);
 exit:
 	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
 	return err;
@@ -787,6 +790,7 @@ static void dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
 	dpaa2_dpdmai_free_channels(dpaa2_qdma);
 
 	dma_async_device_unregister(&dpaa2_qdma->dma_dev);
+	kfree(priv->ppriv);
 	kfree(priv);
 	kfree(dpaa2_qdma);
 }
-- 
2.43.0

