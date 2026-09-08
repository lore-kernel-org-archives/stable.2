Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C3262D0B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829579; cv=none; b=KFOmtmdjyEEqcVxH0BtylvMA32/0ybPhw0XN4bHVjGbXszEBr/SZ32d1poy+SFptaBvNa6PW2AA99rEXWZw6U+IwAp6vyKJhh+FaQVDrXmD4pcQ75RSV2QBqNOmyPC8a/y9I/vG789TBt2XfoL/UvqMPDmfrq6KvYtkOKhquiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829579; c=relaxed/simple;
	bh=b9PFBF82i2GhOQaPUbnfcuExoOPvsbsd9CIusyPGXgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbRp7iDwsXkORfCB59s0S4BTboa8k4Ev9ujiPyc4RhyCAENqTaW2Gw4CewWQN2iTndekdNNageGQGLP11HTQyo+pNJjrX0IFLXJpaVGMkduRgPlznCErhRlgQXaRk+Cx0X4oQAE6NZCkKgvJaojLpFBV2eQ/AHpvS6dHLVNw1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa8G2pwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa8G2pwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA84C1F00A3D;
	Tue,  8 Sep 2026 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829578;
	bh=bIoesK2wserVRqdKqDmU9C3MowjWP1gjfRwlN/pXptM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oa8G2pwdMYRlrNU7dfaDNv8oE6wurD4suvd4SuzPazcnGxH6LBkX9zV0uxzWST8Gb
	 xbuaOuJ8Z3xSe57l3mHmHm1fcso1YFCIfziCmTaiOJekEe/xYc14FxErPPx3VqMXkZ
	 Cj9o5u8XmRqIVTfkalSA0fcy99x/TqR7VCw84IrbGR1i1WeAGX9O3MkfysH37pRIiM
	 wXxGADQ2ab+VSLGal4NWjrGWS8o1erYmp1b2oPoZcAeEwTwlRbV0XmsaXhVcCwdn9u
	 4Ks26hKZhioKe9qHAa3ou/Le9omtyd7569YEISdWXfPw0Pa9Tl1xNMBv1E7SEAtJTP
	 eaZk9ofWMUHLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] erofs: skip sufficiently large global buffers when resizing
Date: Mon,  7 Sep 2026 21:06:16 -0400
Message-ID: <20260908010616.1677334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090346-situated-earthly-b396@gregkh>
References: <2026090346-situated-earthly-b396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>

[ Upstream commit a7d097cf01301c5da37927c8f26123d006f0fd8a ]

z_erofs_gbuf_nrpages is advanced only after every global buffer has been
grown. If a resize fails after some buffers were enlarged, a retry
revisits those enlarged buffers.

Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
has no pages to add and the unchanged return value is treated as a
failure. Retrying an intermediate size allocates a temporary pointer
array smaller than gbuf->nrpages and copies more existing pointers than
the array can hold.

Skip buffers that already satisfy the request. Once all remaining
buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
the guaranteed minimum size across the pool.

Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
[ preserved the existing kcalloc() allocation instead of upstream kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zutil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 0dd65cefce33e..af485617fd5ff 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -79,6 +79,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
 	for (i = 0; i < z_erofs_gbuf_count; ++i) {
 		gbuf = &z_erofs_gbufpool[i];
+		if (gbuf->nrpages >= nrpages)
+			continue;
 		tmp_pages = kcalloc(nrpages, sizeof(*tmp_pages), GFP_KERNEL);
 		if (!tmp_pages)
 			goto out;
-- 
2.53.0

