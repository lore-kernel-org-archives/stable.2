Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628423DE421
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636462; cv=none; b=PED4ZOJwhyU5uXtpjoOp0sYE82kWGXCfPB/paFbpV2mqMDm7JMZMKTHrqRdQ1RbYTXVoyb7cx+TSliNMHBGZx7Lg9/Q6rWf9RsiyLO2dhE1i+vXFol72/jJATMp5AzuARB8Q6Mqe8ZzviM25C46i9T/PtJpUhnatl09oqUUsiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636462; c=relaxed/simple;
	bh=WjUt4hH3swZK2c44WIneb4BziDglIot3E54EZa61uxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqW2YhLoHfZnnDHajurc8SYM1uh+I7900UoGv3z2KoebearyUD0+sC6G5Rq0JAleAqyncWNs5vuNHWDX1xQFG68pky22VM30XORFF83ht+qAzUeyFim27/GPiKmDXJ/jofGwhxeoqcRnzwnp9kcM+GXIjJxzzKzHB35aKjaXPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSppl8dO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSppl8dO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso11945e9.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781636458; x=1782241258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpoNZhDWdaXeWZj6gk2tZlrUtO5Ws5Z2EZsM2UJIeeU=;
        b=jSppl8dO1sT+PPY2HgyD1imWK1uKjn7fFoKj64QWsz6ZL5eNhKhbQIld7zpFmUS38B
         9evK7hNlCDjF715ROC+jEv4i7+J2ji8Vads0pnk/T1YNaK/9/jFHWRQPXCqF63MAqUky
         wKEabdSViBhGyDpFstpLsYSUKoD2CTX9UtvvoPYYpHUX0aHiZSCQg2kzGMiC5nPIxmpV
         6qHpsJ5FMYlE+SwfvQQy9Fu4PrR9ImfZZFtRnoum2R/JnrqlqZ53rrApWvle4vtMgHhq
         v4xqU0HSpa9PO/C7ni5h9hDQpY2BjgdZW6JCFIkdI+eSeddJ3F2kRBROenc+XvCH6wLh
         Scgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781636458; x=1782241258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PpoNZhDWdaXeWZj6gk2tZlrUtO5Ws5Z2EZsM2UJIeeU=;
        b=aNCQFRJdVWDBlxoVAGc2uZK1UKNPLK3XfWpV69AjFTpC/RCzloL8oa/hOeMzy7lgLF
         p8VfbTa2/2Qo8wOsONF4YvzIblS1arEw3O9K8TEJssY736tNjv4PB8bUBuDFMIU03GwR
         NMzHGpz28KyJ05fxP1rijna1SHMP2pU/Pw3KyN2SgQnRm/2CiqtTxD/FAjF67Q4e7Eiz
         a4einoOevqquzLeO9ghhJIW/9TOtfdFW9HikoSh4mEbdTeq9sE94eYQLuTC13lKZ/kti
         CXzEiEzWArvzM9ExC/FbRITZQJhMIfKXtuDsC9GDK0FaYAPjFkgvsv5/bLS/OAZTsKfy
         GMFQ==
X-Gm-Message-State: AOJu0Ywhk9v350kyCht8rj63at4umLovyHQovt/c5dnk7bgZPatdc690
	/HJf7Yyhh6BMH8WbSWpmmLpF7gr6jEOXns0yryhNLSOfUA1f+Y8GxYb7O927SrnPVyOxy+pkGlE
	JT3PRTGHc
X-Gm-Gg: Acq92OH8t/VfI02eb23JauEKA441uSuYZUvPucE/yqPixSSd1MdTDDOCh5ZtNxnkdc5
	3KSXn+bOjlzj09LKNc8z2wbhuDPe45RA6pUk1ekE14uefrhyjXpYaCo+XgVr+x4e1Ymln1n0ARX
	A8xpV8VT1x2Bvj9Kt50S/+yoGVdJwRRoqFSW81E+b9pmotNBbxE/l9rU8BIjaqhilQrfRIKK/UQ
	/oNBXTM3rTVf6TMxCmpTIeP8NZxG0DBN0DS7GsXdJeZ4Ew9w70GI5BaJnVoNIRcPWFekq8QBH/d
	ewyWs78PmV9YEpol6Z0r0dqGGyxy9/KYL5bTd9k8by10XMh5NVo7yaDfhOrUy7jXh3LVyOEM/ry
	FFDxkAIiUkETppjspTLa75hHxfHjq+a54Fm1ufZ9oKE2GCI8kM0RwflSHA6qZyc/S4RJTWc2Cfk
	bcMMGXgcMAvsHdIyT28KVCCs0mt/ovxGsAepDQIjKTl3s705kdvA==
X-Received: by 2002:a05:600c:68ce:b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-49233a4a4a5mr151415e9.6.1781636458074;
        Tue, 16 Jun 2026 12:00:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:b65:978d:d3ee:460b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b1083e3sm2809025f8f.20.2026.06.16.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:00:57 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Cc: brauner@kernel.org,
	mszeredi@redhat.com
Subject: [PATCH 5.10.y-6.12.y] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
Date: Tue, 16 Jun 2026 21:00:23 +0200
Message-ID: <20260616190023.956982-1-jannh@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <2026061523-blurt-traffic-e169@gregkh>
References: <2026061523-blurt-traffic-e169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE_NOTIFY_RETRIEVE must be limited to uptodate folios; !uptodate folios
can contain uninitialized data.
Since FUSE_NOTIFY_RETRIEVE is intended to only return data that is already
in the page cache and not wait for data from the FUSE daemon, treat
!uptodate folios as if they weren't present.

This only has security impact on systems that don't enable automatic
zero-initialization of all page allocations via
CONFIG_INIT_ON_ALLOC_DEFAULT_ON or init_on_alloc=1.

Cc: stable@kernel.org
Fixes: 2d45ba381a74 ("fuse: add retrieve request")
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260519-fuse-retrieve-uptodate-v1-1-a7a1912a37f9@google.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
(cherry picked from commit 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c)
[adjusted for stable: page instead of folio]
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/fuse/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a6efb7cd945..7480ea23aa64 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1765,6 +1765,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 		page = find_get_page(mapping, index);
 		if (!page)
 			break;
+		if (!PageUptodate(page)) {
+			put_page(page);
+			break;
+		}
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		ap->pages[ap->num_pages] = page;
-- 
2.54.0.1136.gdb2ca164c4-goog

