Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F33B8D48
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027396; cv=none; b=P9SwH15yhSQuKCBUrWjyCkgLyVhMidAFh+ZDOMk+z+utP1LhiaklwDrjFIUPF+WqjJZOmTL/gGL0/xgi9lIK5UIZboZOdkE/+Gr5xKVV8zg6wjGqiYnJeL3dUWnpFYxZwZr2PZZqhZ79Q5uTEssQVSbxv8KjDTP/QVpQrdeL8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027396; c=relaxed/simple;
	bh=QXyumIIVVZEJjd14fJDOG6kk/TauhmZNZgQBcQSuUAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGkiC720o9eH6VwYkKggQzKMrglkdvEWGSH75yDN+b9HVvpQeeAd0Mrp39DkfI/rhJOt43zoiqzTv0ELTzqK+NkOcziqT8AUB/FXMpjJEb4yzaJp5WRVxQj1Icu0LDomeo/nTk7tpv5pH4nNX/W8qiV6DFo/jrMFF489EfGd7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mos+IApL; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mos+IApL"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e6c4a867cso153290085a.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786027394; x=1786632194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQCss4lFgE6Dwf1NizCh8ZHT2e94D2G9yvtYGo+Xll0=;
        b=mos+IApLee1IYoxyOW2it7UUx3EgZl2W7aPAdI2t/BhhLhgt+xJlp3U66SyCcGjdt0
         gLjsd0GfDhDikPTMboRjHgsdafc9VE9f/FjKvVTtVmGnvjmksCZ0GIKLmIEvL3xyE9TZ
         5rvtGztbiB+IW1zKLuVpSl/+a8RfdSN6PCXA3ZPbhOsQiVUTzG2XVQpZTkLEvxQM/J9w
         g1xNJ0SPTp+RkYBP9DFkXE4I0Kx/w/1Ifv0z6n4Y63SgoMKyYMQnFXf2Ug0GZbyBJntg
         H4VruX3I/PdPo7ncIJt3j+pQXDY0ucd0prNAR98SRaqVvrkM4e8VxGTrmll85y6cuKU1
         +Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027394; x=1786632194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQCss4lFgE6Dwf1NizCh8ZHT2e94D2G9yvtYGo+Xll0=;
        b=Cw9HplOHu69UslzMFwlCoTmE1wstmWHmTh+kqb0eFI6N356eHtiWE8QcTtac2TpsDA
         HlQh79HbIRZjJphcphJnqKccD1knn+FaNs+MFzMQHabYfILmiQ5CKSJNEAspoz1Lubbx
         +fzLsWvy2wpEBckhtkHXDMQUlLofhe05RsDYro29YhxFSdmnfW2jcKlJqxj5plT9Vxoo
         2jWgd5v8eI5Q1dCLJWPpNVWAvgu9c0HB9OWR5n6c0AH8TMs40evt1hl8VIbHnHUwuL+/
         8QrMDfCuBH4BC+H9w8RtRuiqm+KktkIw8tOn1MFhHkx6Ci1x4ENgw1+Hjx2wAo1biT2q
         dniQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfQ061TASWKZCq3praBghXMTL1bwWJlCaAtXCYnJjSy1Ah6SuCs/nEaAt6Qa1GdH89Ajqrwzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kOvL/eJ5Gh1kJtsixunH9nhfYTId/BaoqsjOeBb/82xf1F7J
	U+whoVWbXdMyyhQMevypK5y6/OXD0DAmbJyHfT6vddhgMRGmFJJ1dc1R
X-Gm-Gg: AR+sD10+HE0bNOzDGTQ0urLyAaMatmUeldDvcHDuf0ESQSX0lirXGz0CYmp7xrlZUN1
	E1qo8TCBlTvlH+rqkmkaf4qx2kDgq7yMRUGN6vj+OdDK0PWjUwPL7bsBG/IbIb9Rmm+424EB9he
	m96x3zBnsxdzm0ETZjux66Yavt5YiDwDcAqASBK1VY+dnwbePXXrdviuR0qrrMLRreu9/QIFWig
	X9nWp0pmGOP4jv75G4bSty/OKGtBOrRuVjBvc3ow2ZnZsbxVOk73mJIPYXYAAwbBXidaXo0eWfY
	BIsv5aXf9Oap921B/DNAttvrkVMFmKVbvRxmpbiD2kHj0kh9AZo7Sp5Uf1YeL9LKNyvSIR9rkIt
	l2Vf+/XndWdWcojbUx+HeLa63vwzkqKM0niBJ8gp9Ck6hovXomVb8uY6iroKdldmkmQwhMECTyQ
	WgvtD/IS1QOxM/OvSmN+wbh0nqAW4EBDB5cCBx99KfCCSNHc3L4n5FEOYFT2NKOqc8jY/8aQs4C
	fA4Qxg6XWPA93+yBbiH1QApn+n83eYk2FbmR9HL+1k=
X-Received: by 2002:ac8:5e08:0:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52ce5fa28acmr159831981cf.18.1786027393869;
        Thu, 06 Aug 2026 07:43:13 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9088a219ea8sm35070376d6.37.2026.08.06.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:43:13 -0700 (PDT)
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
	stable@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>
Subject: [PATCH v2] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag
Date: Thu,  6 Aug 2026 14:42:54 +0000
Message-ID: <20260806144255.4167019-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804213550.3409638-1-gyf161023@gmail.com>
References: <20260804213550.3409638-1-gyf161023@gmail.com>
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

Drop the reference before continuing.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
v2:
  - Fix Fixes: tag to reference the correct commit (728356dedeff).
  - Drop the inaccurate trans_fd.c comparison from the changelog.
  - Add Reviewed-by from Stefano.


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

