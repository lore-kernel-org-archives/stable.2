Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403AC3B27D4
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257553; cv=none; b=dpF96XitnzaXKGde00Axbw2TKNVDZd6xGWJPNbdaL1IniLdLvyM493JUmBYweYukk5699em7ANG81wdQMGR0w4/mLp1zHXHubsTZZTCvD590yRmLdvPHIsBTKx8rviYNX6iMUpmo8dM51j0MnVmTbCrZvOqWFQe1rds41tVeSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257553; c=relaxed/simple;
	bh=ntpplDcF+FslIX1ddbZSXGjVaEffYQG3VQ0+0G8CC/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OB1qb16WSl4gVKMcbWz6Ga1HgrFNKdwpNRdOo+0PT8i9PNLPP83fQKP/QRMe77dggeEOZq+aRnEZ1I+cR9zgv1jQW5Q9/AEE/XGXD4+d9s/eRoe5SFJio4EjmLPS4v5EHHH9y235P5krC/kNcbl/DFBHtrvreqApLJSIT4zTGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adR0YNOH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adR0YNOH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f96c5b722so203376f8f.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787257550; x=1787862350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ii76HjEkopbbT6Ldx/oR8y34K/ojZGJXj9TiNldisUY=;
        b=adR0YNOH6uSFRPapzgs7Ep3rcipQAMvjUCmOsZnmhlQK135nCvF2joLRDnGTqwGTEf
         v6qDR79bLxj2ExbqjzPdOAmTO1hdfYOHeDgeb9JXGFErt5yrVizMhCVBXoM0Ph2WY7S/
         jEi58G5vHUbb8UQupqDqMs1sF3TqkETFLm5179LuhL+mmITOshSv7K5RMHplqiGJTTh3
         7gkHdcTvGt/EzoRTAm6qvE+JW0UvM/n2Le1taQ4u/i+gIm1r3t9IBQjjEg1Ustcq0JJW
         H63/z6Uw96iql1W5qeE0Q8miyPv0rY0WItlh/XxbwOiQ4oslNl2vfcKXNKE18ifCpYj+
         EHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787257550; x=1787862350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ii76HjEkopbbT6Ldx/oR8y34K/ojZGJXj9TiNldisUY=;
        b=gUzpiUj2KQll7/jx4V7WLf6AjD00sa/W6ISnL+ahvp3mkQXXUP43IlCA0OK/gNoepJ
         /QyOIDsWF2irNXFnaG8skuKlNIhWanbXMXU1a2YdaFNp25aj6jTJoEMuzJIDtoxDyr71
         x5IDdtXpGbczoShwhzUWL9SmqsJicobAQs4BMRfQFFawUBuAK0wlfYMIzxA2KOaFCEsN
         VYGjsjQd4cksjik7GBLi33uwz6kA9rFS8byo3dTa8Vw4xbG7iEGW4RJ4KaMCgD5ttrcG
         OpBgX1D8vwvrVGqHmjrV0+HkAVm6WQYxYhO15NqHCfmhk2BiEjJMQQJtxmZRNX+jgsVq
         vYgw==
X-Forwarded-Encrypted: i=1; AHgh+RrJ9cChg/Vi4NP1P6hIb5tGIytyJW25a1JAbNDzA/X8W7K7+Q2Pu6dhfLeOn4bPNeccevgL8h0=@vger.kernel.org
X-Gm-Message-State: AFuF++l7FFnbrG6jSYw8XcWqEzvw6OrI/uO0pb5gHoe76gt5mP6IN/Rq
	fKUybVBwgVQ3Dor4EUBCCtQhVDsLg54ncsPFoGC44E0TPJfFZq7RnQRN
X-Gm-Gg: AR+sD12BN/mxiu9Wb1E66GWdRvE+ZdNmaL/ISbaeUExhmrvez1jsgtcZYsghSIkFEPa
	zydQ29wHv+rqh9L8PtBlAhGCGNEcb4di66hrmLyEHraM8Hr/BYfX7DkXyzbhcll826aajBo6s5N
	EgIrk6/8yur4QTqGAzeiHulDsGgVp7Om3XzT575eoQtEZ8WtzwFjlpSVYbixQp+SziFDEZN9ua1
	Uq+Pz+GE7ooT0sVx48NyAaRTkHAk/o1TckaqONc8ZDkg2ApFHCN8y7HAzjVMwdtl1t0LsziRFQB
	7AOzjvc7onn1/DQDguXMG4m0M6JyqwBJTPaw6+sGH8DF0IqU35ZWHW4g4980cUdyKZyHqIShx6W
	3VJowQ1zUC04084oM+UKS1WlHlP4l+yqS5IB0LWrcq5/xorqjAGEvw/FlmVu6+tCy5265WQwqhY
	WuSkuSEX/UJAOdqLw3h1RZ1vP//P+DrBEMSlIo9H/lERGF+YSnLiFtaN+qOKbbPNWBXRXj5rhUE
	IBgBTn9YhsjdEn4eIx1ScKMTIOHJQ3E+ItDGqYYspragstdeGgH91/gfRU=
X-Received: by 2002:a05:6000:2582:b0:47f:80ee:744f with SMTP id ffacd0b85a97d-482c0b99a89mr2069279f8f.16.1787257550271;
        Thu, 20 Aug 2026 13:25:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441753sm16977694f8f.5.2026.08.20.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:25:49 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v4] media: v4l2-isp: reject zero-sized parameter blocks
Date: Thu, 20 Aug 2026 21:25:44 +0100
Message-ID: <20260820202544.1256265-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_isp_params_validate_buffer() walks the blocks of a parameters
buffer by adding block->size to the current offset. A block whose
type_info[] entry is an uninitialised hole passes every check on the
way there: a size of 0 is not caught by the block->size > buffer_size
test, and the match against the type info size compares 0 with the
hole's own 0 and passes as well. The walk then makes no forward
progress and loops forever.

Drivers build their type_info[] arrays with designated initialisers
indexed by their block type enumeration, so an enumerator left without
an entry leaves a zeroed hole rather than failing the build. Drivers
call the validator from vb2 .buf_prepare, so such a hole turns a
VIDIOC_QBUF on the parameters video device into an unkillable task
spinning with the queue mutex held.

Reject a block whose type info entry is empty. The driver does not
implement the type, so it cannot tell whether the block content is
meaningful, and accepting it silently would leave that content
unconstrained until a later kernel implements the type and starts
validating it. The size match then always runs against a non-zero
size, and no block can advance the walk by zero.

Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
Cc: stable@vger.kernel.org
Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v4:
- drop the block->size < sizeof(*block) check, redundant now that an
  empty type info entry is rejected before the size match (Jacopo)
- commit message reworked around the type info check

v3:
- reject a block whose type info entry is empty instead of skipping
  it, so a type the driver does not implement cannot become
  unconstrained uAPI (Jacopo)

v2:
- skip an empty type info entry instead of matching the block against
  a zeroed one
- reworded the commit message, which no longer leans on rppx1

 drivers/media/v4l2-core/v4l2-isp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
index 1eb46e080afa..8e6c2ef326aa 100644
--- a/drivers/media/v4l2-core/v4l2-isp.c
+++ b/drivers/media/v4l2-core/v4l2-isp.c
@@ -99,12 +99,25 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
 			return -EINVAL;
 		}
 
+		/*
+		 * An empty type info entry denotes a block type the driver
+		 * does not support. Reject the buffer instead of ignoring the
+		 * block: accepting it silently would let userspace fill it
+		 * with data that a later kernel, once it implements the type,
+		 * would validate and possibly reject.
+		 */
+		info = &type_info[block->type];
+		if (!info->size) {
+			dev_dbg(dev, "Unsupported block type %u at offset %zu\n",
+				block->type, block_offset);
+			return -EINVAL;
+		}
+
 		/*
 		 * Match the block reported size against the type info provided
 		 * one, but allow the block to only contain the header in
 		 * case it is going to be disabled.
 		 */
-		info = &type_info[block->type];
 		if (block->size != info->size &&
 		    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
 		    block->size != sizeof(*block))) {
-- 
2.55.0

