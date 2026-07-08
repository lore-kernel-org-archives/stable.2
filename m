Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A233E360
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524073; cv=none; b=LQ7fTx1+54Uck0oW//Feaj5nxKJ1wwmeoUtUPPgoNQCgKlYRhaImjpB8WLY8cWHkG2i3bWArXvG0CKhUpo5K6KRp2CkU4gVK1cGa0LhtEXGuaz9Agz9c4SagiSW0L/a5wzGrkc3eER6kXyyCIcp6Ba+BlMzcAbwiOxNfTpLIhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524073; c=relaxed/simple;
	bh=WKBcHTgaZtpNkKKi2sgsqXtCohviIlzQuMwKPXfIX68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITUdVb+O21bwS/Cjd5YI5sTU1dWv76PxUCvevU5Viw/hPS3fOAIay60wV+44e1cQGQU9OMDGAGtHl6N/sblJuaYGedMPE7DN8u3cDnONjHPG4WkkBHtJYkiPx3qq2qfw8/2xnPuHzSXyRt59Fa+HJJEeqzFSa/HABP+PMIMuZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs6Jod4N; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs6Jod4N"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca70925c25so11532395ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524072; x=1784128872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o36UxtuiqCAJdwEuwaBvvEJ+v2c/EEKhjYP437s9xVk=;
        b=Rs6Jod4Nzyh0EzlLOlKQs5kTJRy8RbX1dbYtradlIQFb3sOtyCSyjN2sFkn1IHY/Ao
         s3QnJLd/AaZHCL5tP+hVTpANuirRM+/lUl7BEkHr8POFqPL9EZqFcascOmcSmmC+Ozs5
         CAU7dNym0BIwFO/JvQ9F1m+sOOq+uvY9/GiJWHfVANxxKy0Cjj3I9JL35Ps/eh8dV+dl
         ffW3ySGLUW9RYgcqy/WmJzPcqe8CCNF5g+LwwU72CNhwBZTaHnGAp2StfzcZZ7D+LSJi
         ub2N89lRrz0hMfEVyHVjDrC9et8pzjrPhnSDdZIZNjuMnFXM/CaUyhal/osJjMCQ89os
         3ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524072; x=1784128872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o36UxtuiqCAJdwEuwaBvvEJ+v2c/EEKhjYP437s9xVk=;
        b=O/ejee+iTJXqXPiEwiLcxKOr4E9nkroV78NgMQCVyTFcf9ttkAEztLrCbJGQmycMx1
         9OUC+oys9TNy+IczY5h8oBoDwxQvdKODqfur25t+J7TB/sAmwIP2mpzGXc7e96Uzn5EK
         Y5R1gTNzEbA339qWU7K956m1JFHyUtsxC1tTda3Vk+4GJTx/qFuPDVE092e6aW1L9IkK
         zkrlW7igPghwSlRpk0voCq/iHEdewhQvqPl7c6TlOijPt/dgt8QnGfnkeBlHmRXVurOr
         Bbg/dBJ57V5Cdg7YaQGpiUzZO5BCH9T/knn46TD5hbHVnjdHYXqxMwD94MAy2mtqRmax
         ZW4g==
X-Forwarded-Encrypted: i=1; AHgh+RoY/zg92r2eOmmLDCqewFeq1svN3fk1dtQQ4XSQ8fRm/KC+BU1PeQ9C3hSJ0Ydu07nW8x1rOLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDCKyQDfXKrN0Fqqsyg9HggGhdk8spq4WRR7GyrotJWFZ4JWw
	BkhgcWNHGPgcTEeswCXmwDDK7Py1+OlfxSeZqC8lS5iteo7enN7GCL6r
X-Gm-Gg: AfdE7cl9vJFizrrWJvQGCpDBTgtsL7SqIF3gN2A3HstrMBynpNZYX7c1JlTtc6uP2Cv
	QjdCVEurg0bBqNbqv+c9ai0CeunsE4jScV0I+v8+DXZlvAFX5V3uKvbnG1pgdQRqYI5wOUKF3oX
	lhu7Pq0JZi4mIg5LCu06QHvm1y5GjK+NhebT+Wb+ZKzkPcJ+kwvNKTxBftwSwQ14EOHMaOF8bAo
	p8zGjawIYk92RMZAXyvZSl+2MCkPHMcKa8eWtxG0oR2WopKZkTGEyvN5TtRu04vXBKi+XXZDa2M
	14kl23DjvY+HD/BeG0baD3N29W8vOyvcp5knX/+/NpZl7PRjRjF4ShlJwi24/bjFGkKdqXqAAxZ
	Urf1fVnCQDo/Cgl9r/ncnNCCGrd534VxwMtP5SWLMzGBIa568ny/6/wCxLXZKXlP/y/eAZdpTxk
	BC6pp8o2If6n7GHDRZ6PFm13k3fcSqu7/oW4uGHtuNWXQ=
X-Received: by 2002:a05:6a21:62c6:b0:3bf:6237:b1b3 with SMTP id adf61e73a8af0-3c0bd1a827fmr3540218637.42.1783524071668;
        Wed, 08 Jul 2026 08:21:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm24544817c88.8.2026.07.08.08.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 08:21:10 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: v4l2-core: Fix memory leak in v4l2_fwnode_parse_link
Date: Wed,  8 Jul 2026 20:50:54 +0530
Message-ID: <20260708152103.49371-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In v4l2_fwnode_parse_link(), the remote endpoint fwnode reference is
acquired using fwnode_graph_get_remote_endpoint(). This reference is
properly released in the error paths, but it is leaked on the success
path. Add the missing fwnode_handle_put() before returning 0 to prevent
the reference leak.

Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 77f3298821b5c..93ef83c591ef2 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -633,6 +633,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 	if (!link->remote_node)
 		goto err_put_remote_endpoint;
 
+	fwnode_handle_put(fwnode);
 	return 0;
 
 err_put_remote_endpoint:
-- 
2.50.1 (Apple Git-155)

