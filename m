Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DC3D3CE2
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787175313; cv=none; b=UhqsTOe4L90hz5ml69KGgzlCnu2VTo0MQqmnMEjM/zhAqXjC3DJDbqzKpNyUmxiiebh+iCh1OcM64KT7zyWgGxNsTf9kmVu2r7rIVKsUwb+rBHFf6grvIiqDIo5FZamAjtLlkWZfNtcQKOBn1xqhDrUsMikiQrysx5iJHNxArH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787175313; c=relaxed/simple;
	bh=XCyWI21c6Ia4UYKaZMPJwr2tuL0rzz7GONunasW8keE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd7tGLP2Vt2Erkj0mjzqcS6o6kA13Vre3pjfHrk8u8pIGaNSgpJzaMH1MEHE8EW6DPXJTA6iAJlLPq43X/O/wDryrQLYGno9cu51fJsQrSRcW3t4e8qtOWXqh008AcPdby7JxjD3LQf8Ws4IpGaTlgK7ug40DNOGiGo1jtPP86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hkt2rffq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkt2rffq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49800c6a846so16032595e9.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787175303; x=1787780103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoBJmiYxKbOhM9EJaI6KrJ7+GoQWOfMWCpsZ2kanZl4=;
        b=Hkt2rffqbv+NASAbl+uxj2WE1L7qNfmhlq0C00DdEAk8t486A9L9M17dNbstMf9bm8
         UhG1jfiiz3dJbAFfiG6IJYBvg1y6poSnk2WafHZoTnXx6KvOUKesERfoHTYK7+zzU8Sc
         n+WN01NGHAPtzRxZyfOzSkV1u4zg/GVaHXhhqbJjacTDeXeFG+4owynBNAsB5ibp4CF+
         lpwjEdHXky132FYCkp8NM4C51kgSAJ1+mLyF3wFGlrKlup9Yf+1E/GgJPMgRIGlTQ/Ik
         AJ55Nl9uPDzRRMoKL8EReLga2Accp5yk2I+8Dq+4wCiD+LWOFjsbkCxNi4/B56z+su1G
         ptRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787175303; x=1787780103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XoBJmiYxKbOhM9EJaI6KrJ7+GoQWOfMWCpsZ2kanZl4=;
        b=Y8LD4ATNgCWZLrq+jejdK86nzi0unL+n6LQU0InGsrpRig61i5MOsO7daYkDUyAV/o
         to/bTBr10qn1Whsne88erZJ4BrqpUZ74T1duWpgdQfBOPDeecgOc1LbJdC9DAe+4txcV
         VTBnlJQnXi7noACB1kDG/B1O6vBPu06GG4kljJOBkPH3CnYR8kNf7yDYVwJxYKdDQ6Ef
         Hdzr2rQWOzPYzc1NVwVXWu5Y38DOb7bdJiAZ8fjh5EhCpZE91FgYjJ251UQsTbvUumZj
         8iJ0iY9/o+OkPCH3Hg6wLHJJp+NaqJ9/YIp5EEeIC4Q2CaMmPUlQGqm2HsUD5RYz7k/+
         qi6A==
X-Forwarded-Encrypted: i=1; AHgh+RqafwyPslv134aboiQ0sOOUO5cphYcdvmgcpL6UcibJ2gyzhAd/xnjHj8usJiveAcsj79CFybA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuQhqtctsIC2QrfG8HbMG9li0jd0+rsnQ393VCcpK06DMZaGa
	SNg698EekK4emT0Q1XJhigaaT6rIcAQTyUeBoeS2RZwkdNDnAHWroLkh
X-Gm-Gg: AR+sD115lcxc9UYbp9Hlt0TazhFXXOEcs8WJYqRhOrbTjj6kHMbUb3SBMxxIe4k/Zrm
	efXFcPlq6jY4O25Dbn+YMOAJn58xVkcef5ydeV5dQA69u8at25zoGRFYYxo213W3JOyzgl8v/Xv
	SehhAdKie/4F9apIcVN/UtgO8MeUQPY0R4BoaMX7bFDoymy5DS94KlwVX4RP9gnhJrCSjSAFaGU
	giU85cx1cl59sJzhY5XZ4cZ2cW8qgFEjvpUgjrlpqqi+A4i3ycie0VfodnBsKoq8bD80i39KODv
	NuffSswAYjqo6AWukvPPoaULm5KEK8xCBADxKwGnmKLTHdl1MBITV5AZkfpvMFBA0zr7DBmPwRH
	wfoyyboclwi5BaJ7gVYUtWZY8mJzzlvVQSIX6ajgKuPEgLobgPUIa4YKIMr08icdORfz5Ur+Rse
	pw5J7mSwDFyuowC9dLkJVDTj/+YKGopK7fxHH1JeYZKHOZqfo49VM3l8HdJSWnpJXN+IC3sXZNA
	RJqiPwoAKMmAYq8Va3TG2XONNs7t28LdR0h2T018+xZepwO
X-Received: by 2002:a05:600c:37c6:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-499aa1dbb12mr157441035e9.13.1787175302615;
        Wed, 19 Aug 2026 14:35:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b19dba34sm9633365e9.9.2026.08.19.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:35:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] media: v4l2-isp: reject zero-sized parameter blocks
Date: Wed, 19 Aug 2026 22:34:56 +0100
Message-ID: <20260819213459.1220894-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818105642.65381-1-devnexen@gmail.com>
References: <20260818105642.65381-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_isp_params_validate_buffer() walks the blocks of a parameters
buffer by adding block->size to the current offset, but never bounds
that size from below. A block with size 0 is not caught by the
block->size > buffer_size test, and the comparison against info->size
passes as well when the driver's type_info[] entry is an uninitialised
hole, both sizes being 0. The walk then makes no forward progress and
loops forever.

Drivers build their type_info[] arrays with designated initialisers
indexed by their block type enumeration, so an enumerator left without
an entry leaves a zeroed hole rather than failing the build. Drivers
call the validator from vb2 .buf_prepare, so such a hole turns a
VIDIOC_QBUF on the parameters video device into an unkillable task
spinning with the queue mutex held.

Reject a block smaller than its own header. A block's size includes its
header, so anything below that is malformed whatever the driver table
contains, and rejecting it is what keeps the walk moving. Blocks
carrying only a header to disable a block are exactly that size and
still pass.

An empty type info entry can then no longer stall the walk, but a block
matched against it is only constrained by that header size check. Reject
such a block explicitly: the driver does not implement the type and
cannot tell whether the block content is meaningful, and accepting it
silently would leave that content unconstrained until a later kernel
implements the type and starts validating it.

Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
Cc: stable@vger.kernel.org
Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/v4l2-core/v4l2-isp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
index 1eb46e080afa..efe994b4c4d7 100644
--- a/drivers/media/v4l2-core/v4l2-isp.c
+++ b/drivers/media/v4l2-core/v4l2-isp.c
@@ -84,6 +84,13 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
 			return -EINVAL;
 		}
 
+		if (block->size < sizeof(*block)) {
+			dev_dbg(dev,
+				"Invalid block size %u at offset %zu\n",
+				block->size, block_offset);
+			return -EINVAL;
+		}
+
 		if (block->size > buffer_size) {
 			dev_dbg(dev, "Premature end of parameters data\n");
 			return -EINVAL;
@@ -99,12 +106,25 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
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

