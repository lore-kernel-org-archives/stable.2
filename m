Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF63AFD17
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347735; cv=none; b=Qq0u/3XWlDRSqACR+2BcGTi799INBTBkM5ZuojKYryRCDBXn2yO2TFTRVnu59ZHXS6SX2ais/amEh4N+v1jEai4UhZ6SfQkEwIqhaAPx4hpHfYq3I8ffcGpKhW/MukyOfwCKL1P3QwZQKh35uDgErUaQ9Db3W2mg43LvTFcUIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347735; c=relaxed/simple;
	bh=iW5v4cPa+jY4BUhIVqaq+GenRgtpAr+S8n1Qt7BhIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuwjAqU7i27MdIymAkGoN5SEzP6W1kA2pf+FtZ9BEvpOODrd4Eckhh1fx+4nbFCs770ie5rjrIWla5VWcyDJEki0WZFou0fz0959cemtAOagLvJ+OSCvxoY76hdw9sxvufkQZsPYGFlamjTk09PffLbvVvLb4FjrPvWORWS0zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8fwmwSs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8fwmwSs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495437bb891so8715895e9.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787347732; x=1787952532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cUXEtXgpHp+az+q2AbTUR3kHFspQTU4Js/4VE5CWhoE=;
        b=j8fwmwSspKKgt+d3r4IEs8E/CFFqDFvzQR1bnvW3n1rsYqkDF1SlBtGWPcsJhS3wBu
         P0AniAV+9t4I0O0PO14t9uLx7Gd6LNhG4le3rFJwiExaAuOEKitnw1PYrt/yOTXB4mRP
         I+oD8Q0TEutYKU3Ehsvraie8YUbkDfhO8oCdKSWgmZR0hcKHkYoloNvUtvVhBwd7YkG0
         dJJnie2J+qwrgo3mwK9OA76ISRQa/BKX0O69RwWEnLo39zfJAK1HS2PJQdAI5iejO6Lm
         aXBQ6AVrlTqyck/vUgFC2SAPKNz4Q7TzWFL6YK4gHP3brJuoaUZhuMv1FcidoE+Ji9Ss
         tA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787347732; x=1787952532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cUXEtXgpHp+az+q2AbTUR3kHFspQTU4Js/4VE5CWhoE=;
        b=lOwY0qdxzxsHyFO6IaLz7bwJabnJ4ALZbHESvbiHoBvDtVDsy6xpP1GJWPhlUAVW+r
         yLFw8f99BxzqRfcfPB7g8gmeDMsw0T2T16KdJXQOMsS7ahfejviO9heQsXqqxKtx2NgK
         ON/Jn9+DWsd6/uyJRDtCiBsZf2JFa7Nk2go9VO1CWLsWgHgMD0YTeAd21EIran9O9UuE
         xQuXGikoTHrZG8GeEVA0SGnOLdzi/XirzcCSTJekVC4kfJ5LZ5TE8ode+3mIJQGWG5TJ
         jALOIVvqNpZWrHqJfZBNu2Lt0jeFD+bNyASCekNgq0aDtUhngZEAbl1dtX+RUJyy9NUq
         akGw==
X-Forwarded-Encrypted: i=1; AHgh+RpK+HnTqsozf5VudAHfcmSwyB+0yUXPsYAMGHy5ZvkHgx/qvd1bqsrBZAfjkSFnSmI4NedhvAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mQkD6QULhRn0ODBeC2X5sHXIgCOCyL4m5hgvRGsWSNQAFIIlf1
	YyYsj25ZZb0JimgnHkY7NO6ABZh4qqY7hmYxL6iPyeepaGp0TyXkPXa7
X-Gm-Gg: AR+sD10NWjeAjr0hnk8oCbxXjzhAU0VGS6sAYA5t91mzmDENMhpoVRWR+l/ms4MWVck
	dLLAfZMHvpeOdcJ/MDfvJFlS31hsWI7MEo1vX9Zpq9rVSMwhG3vkptCiSLt0OmzJs0cL19KaHgx
	ub4XtrD4tx1zVyL7iqI/yJz5Bgfhxf0o0QogIjIizBpBbcG3eSrAEAXIipUmJQM2bSoNZ3ZQLgb
	173wz6xHGP9svqwz6DCPoSvTP3GSd3Oaz7KzM0YbqRtq/ahP9o/kYsyd9+U3hqcWo9RYfGfZSmx
	jPc79SjHLgQPFdYjfAQGcwWLhPaRj0raZSu1D7BIOMQm0aDo4t6lXVpFCDapH8WksDVtc+xhOO3
	RUVWa+1wGf+6whMoyOW6Bs+o3aQbxkSxJK2G/2vSq1S5a/geocajIKQiXdxx7g/AYa4zs6m+nBb
	EtX4VrLQXQ4dB+Un0eSyNYjt36vThoOCAdeGWNlrt2qfoLT644GA/CsKcb7cwO61Oa5oFwG4jw4
	k+kbsskGmfCzpo+S2BeYlb0mAeP1IXKnsoaMAMQivi8WAHYdsjaV4HiBvM=
X-Received: by 2002:a05:600c:78f:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499b071ce49mr167339025e9.9.1787347732215;
        Fri, 21 Aug 2026 14:28:52 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm147415f8f.12.2026.08.21.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:28:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Keke Li <keke.li@amlogic.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: amlogic-c3: Fix out-of-bounds read of metering zone coordinates
Date: Fri, 21 Aug 2026 22:28:48 +0100
Message-ID: <20260821212848.214982-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AWB, AE and AF coordinate loops bound themselves by
max(horiz_zones_num, vert_zones_num) + 1. Both counts are u8 values
taken verbatim from userspace, so the bound reaches 256 while the
coordinate arrays hold 18 entries (AE, AF) or 33 (AWB). An AF block
placed last in a full payload reads 474 bytes past the parameters
buffer.

Clamp the point count to the array size, as the zone weight loops
already do.

Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/amlogic/c3/isp/c3-isp-params.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
index ae0777a20bda..f2396e2c6640 100644
--- a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
+++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
@@ -139,7 +139,8 @@ static void c3_isp_params_awb_cood(struct c3_isp_device *isp,
 	unsigned int max_point_num;
 
 	/* The number of points is one more than the number of edges */
-	max_point_num = max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1;
+	max_point_num = min(max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1,
+			    C3_ISP_AWB_MAX_PT_NUM);
 
 	/* Set the index address to 0 position */
 	c3_isp_write(isp, ISP_AWB_IDX_ADDR, 0);
@@ -258,7 +259,8 @@ static void c3_isp_params_ae_cood(struct c3_isp_device *isp,
 	unsigned int max_point_num;
 
 	/* The number of points is one more than the number of edges */
-	max_point_num = max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1;
+	max_point_num = min(max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1,
+			    C3_ISP_AE_MAX_PT_NUM);
 
 	/* Set the index address to 0 position */
 	c3_isp_write(isp, ISP_AE_IDX_ADDR, 0);
@@ -316,7 +318,8 @@ static void c3_isp_params_af_cood(struct c3_isp_device *isp,
 	unsigned int max_point_num;
 
 	/* The number of points is one more than the number of edges */
-	max_point_num = max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1;
+	max_point_num = min(max(cfg->horiz_zones_num, cfg->vert_zones_num) + 1,
+			    C3_ISP_AF_MAX_PT_NUM);
 
 	/* Set the index address to 0 position */
 	c3_isp_write(isp, ISP_AF_IDX_ADDR, 0);
-- 
2.55.0

