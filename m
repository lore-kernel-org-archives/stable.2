Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794797188;
	b=k2HXbEHt+9i/HJ0YZ3AzxJD7c+ZcpTsSAPReYyySJp9u28aYssbxHEOk+X3kRfjrPYqk
	 kuU4K+zp1aAG1Q7u5+85zwHnb3FWULZTFK4PITwjkYGOQh8ZgWJl3IgvVlqOKLIr4a/MB
	 9pzH++MvhUS2QnmT6qcdwcOFR1nDs0HRM/HRG7+fDHfeA//v002FUW53SLu0yBRaHe4uM
	 qk39uclip98n6tsQ1oyhqPzi4xbzfzqb7XaikpsFXKGJpjC0c4CEX8axlJVZ9HZJ/ifoV
	 1byqetickZd7CXhhrOOmVOhRic+M4oQwo/MZLvayM9i59YMXNjkSqhiHPGrinahUwMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794797188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p8qwqp/ZAQ4Ykqwo3zNdhzaGx+nAJNcPK5iHkFNUfjQ=;
	b=EeriTj5gcmuZ8lqANEwxFv51KOXLz79tOyklsb5nBtSHRx9ztl/uEMTI8781oiZRw9fk
	 GilRsStE3F6IzKzb9Npnx+WrOAK5nJk315sjJYszZv4/W7gP3S9hY8JEugfrdQ7Y//lIB
	 x8WM/NLSdF9Wrlg1LZhb+ZNWfXmPWV52Cryww5A5xT4y6G3vlKbPTW2r06J10H0SeMyL1
	 Brc+Mol/LwcCxkv47lQngdgf/9qCXnY1F37N30q4Oe+GBl7zDDPZF0X9oweq4rCum4AqX
	 DXtMJJZyLlERuFPX9dxmj30BJYrPlNfaFv4Wkndh1FcjAC7BF3bNqs3Nu8HI46Puj/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oepEcAlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80912606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oepEcAlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9051F000C6;
	Mon, 16 Nov 2026 02:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794797188;
	bh=p8qwqp/ZAQ4Ykqwo3zNdhzaGx+nAJNcPK5iHkFNUfjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oepEcAlviw7nUM2VfVg33npl9qkv3Fg6jmXbWVg/OgE3B44kqnOvwx5/pkTO41/g0
	 uICrWKNP5aclC36mr/V6t2biwggIcuhGWZdxmwWygyPf0V5Pb9TJGL6X/vNsbvcWEo
	 pUrJ2Ddj5S+mIOqnv2j11VDltFy1C6LYWxCzQQrQiY+u/33G3SmJVq7+WpYUcNP7U8
	 UoU0zHncTAnqYwFP/qC7nfNRVpzWj7CZ19NIRFX75qBQ2L2wdxrKp+CzbojdIfJTHX
	 oXth7eAgHmMk8J2cSnBHBv1e3W1Gx2pZ/s+XIDt3kA4xRQFg0ArOomX6XqpeYBebY8
	 YpeGtas05PJNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yousef Alhouseen <alhouseenyousef@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] vhost/vdpa: reject overflowing PA map page counts on 32-bit
Date: Sun, 15 Nov 2026 21:46:24 -0500
Message-ID: <20261116024616.2408867-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116024616.2408867-1-sashal@kernel.org>
References: <20261109202626-failed-5.10-fd1462c96baf@kernel.org>
 <20261116024616.2408867-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yousef Alhouseen <alhouseenyousef@gmail.com>

[ Upstream commit 0619aaa34c0c2a2dcb07f0e9c8a34e7efb8c4cdf ]

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the unsigned long page-count calculation.

Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Stable-dep-of: fd1462c96baf ("vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 43e7528b8fa03..32dde456a181a 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -633,6 +633,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -645,7 +646,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
-- 
2.53.0

