Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F7448BB4
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879360; cv=none; b=kvnWRje7is4jJIChGMKkZQiw5zBaOI02SMDNwCWcMhie/Cc+E+SEoWutfRsbOXUXOvwavnpXIMP+dSI46rA8vAG22nv4WPev/SYXPA9tuxDE3FE49xT64T0PYd/gZOZNZuOb2XTUXmpBh4h8M7JNLRz/mGc4dFBvq5lpXbuGrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879360; c=relaxed/simple;
	bh=tEcMDoHS6/C19lkFbIVxAgB2kcG2kHidnTH70KxDhC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLTOMhOeWeQbAjRsAw1i8zbii4HkmOOFFSWNjvx8INL+Vmzib7nfSN2d5mrfW8r6XujuDdcZc/sOxjsZGK87irDjY0roszFeGxerF+SEhg1TSzkG5rShmFEQsFAsn17h/ZS33mnkTu3fMagtMi+nas9YZYX0cm/FgpiQkOZ8MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfZuIDSR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfZuIDSR"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca913a601fbso205478a12.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879358; x=1786484158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QH2K5FogbEg2Pu5YlCvSeafRigFtD0Kz01lkbZ2ZcwI=;
        b=FfZuIDSR70WeRoFn/4JXgvTeMfL3yjKqiklVlObWEBtylPr2TytptTv1ZZlyZdpPcY
         KaH+JrLDEDcenLGpcLz6MJdCmRMxLtu9/6ZWPGQ+Wd2gA1+suLazDH3Mkz9PYrWtPcvR
         IwffqK4Lu9lo/N/VahYObHkD+Pivo+fEghO7S9UJ5yqm1ql7CVGksA0C2lMedgr/M5GH
         eJy9+7uw5vJR6CIbThNvDcNotzV+0pgRE0yl4ftwqpiim2sTwLOdN0qWWUrUOrP6bgw3
         vxPulotlbKPO6Ru7DhR7RmmPgR3jxEW1NkGV0ouIUCStV3qa4XenjRY/XpDIOowffzr3
         C4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879358; x=1786484158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH2K5FogbEg2Pu5YlCvSeafRigFtD0Kz01lkbZ2ZcwI=;
        b=WOQaG0SMFhUY8EYhqjo7RPIgMJwdxS8dtJdxEUJgQGqrlZmQ9h+nRW1XzEHCTb+kjD
         jb8CUt6lUiyj2Va4zyCsazGKr/y9t2hpkDsrnoouWTBdaAsqLC8jZERQBMRC4Rh92lAu
         dS9DuzM88s1wTXhNmYTpGcl90QHHJewB0DJM/WSd5jV85QGlOCGjIFmNkLvbGp8loimV
         45bsEmo9wqp7nsclAgXkYQl40WS28D7IjXzkVyIejE0XacdbAxJJb29xjwDtn+uEttjJ
         hjBidJZnNJmkUx9KeidCerjGeCkPHzPmw/bkLU/tfBAcOYyzRnT9TK0ZPKCYJR/jczEn
         kSBQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6rlfopNr6K7mkRtCmiUo+FlG3yK5xz+7ajBn+JUU/m6ZsB1Y1rj3JuMoEgptfAT7suO9Ww/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFMuiDoiv49+GJrnVYXDDZHfzvEj9Sfh/T/FYTCwxSzsmxG4F
	VbFtCnCOuNal1YVd2rLZrDh+XIbmY33iAlD2fb15ABlTgSoOZmGz/Grw
X-Gm-Gg: AR+sD12Hj4F+MyEFQwp6YT8sjGUzklEU7CAQpHkoo+F72XjFmeM5RPttlkqy5HDs9GS
	gqZy2hcoRRdb+SJxJ+URhIeJ5Ap3d/F93e6C0OhOcaRfzLnLncrscy1Jhq8N9V5WduLvtArQDml
	WBrqDydOWWLvQ48gDdRzIrCswb3OIDVUuZTmDAaCNF8G5wxbCIPnFA/4bbER/rK2IT2oBBu7bqX
	jqAE/JWZxTf5X1lP3sSqhrMTkIO6zD63voqI8BR+jfW3MfYorAbbufoOOWOLyRWr4Oa1dcUUcyS
	28gDH8U3VSVs1xrEF6mrkl9QhfpdmCMLaobVOWhetadyEtQwckdC1wdUBlYZyCjcCefujyilfi2
	mgOdbFYOYVIZMWo4Iaej4Gym0d87YL59st5oXmYF82g+gbeEx8hHN16dWrSvtCIvy2+USgvXBKk
	Aj0d+w2zTz4hMgRkFgJD0UIQwFNAoEaG9i//PgTmqp/f6+8nIbwKgO+/xsP7y4DHcZKQP8zK9ws
	25ph1+Ues1oIaaumLJw0wjsMck3EbFszjKU7JExQIM=
X-Received: by 2002:a05:6a21:50b:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3cb85efb72bmr1956240637.27.1785879358555;
        Tue, 04 Aug 2026 14:35:58 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586447d52sm7628775eec.12.2026.08.04.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:35:58 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	v9fs@lists.linux.dev
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag
Date: Tue,  4 Aug 2026 21:35:49 +0000
Message-ID: <20260804213550.3409638-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9_xen_response() looks up the request for an incoming reply with
p9_tag_lookup(), which takes a reference on the returned p9_req_t. When
the tag does not resolve to a request in REQ_STATUS_SENT, the function
warns and continues the loop without dropping that reference, permanently
leaking the p9_req_t and its msize buffers. The reply header, including
the tag, is supplied by the backend, so a malicious or buggy 9P backend
can leak kernel memory on every crafted response.

Drop the reference before continuing, mirroring the equivalent path in
trans_fd.c.

Fixes: f66c72bea129 ("xen/9pfs: receive responses")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 net/9p/trans_xen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a066..8eea0da8797f 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -203,6 +203,8 @@ static void p9_xen_response(struct work_struct *work)
 		req = p9_tag_lookup(priv->client, h.tag);
 		if (!req || req->status != REQ_STATUS_SENT) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
+			if (req)
+				p9_req_put(priv->client, req);
 			cons += h.size;
 			virt_mb();
 			ring->intf->in_cons = cons;
-- 
2.43.0

