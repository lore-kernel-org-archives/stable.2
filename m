Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519A3D332B
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085030; cv=none; b=tWz3fW07Fs+iORHLdPERytWvsRZA6ELBuRYDRZ1PQl4eh5dEs0tF1k7yC3g6zwMuGJkMvIEAVq3vVxtgzAiaU5+C35aFTnv6I8w6uAn++ZAomadu/fNeG5ykK26WV2pxIfh7qxwKrME8iRaIRAOwXLYvUZRSgu0GMmipiEwM6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085030; c=relaxed/simple;
	bh=pLkkTArpTLAY3F43SmP0Nh2iqCl+C27QU4KzE676GZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNFTYuLRnhAgUMMeTJXoUGYAKxJBH/MXhHlYoAAUfJzQlsYK7a7pSrpYRlrVqClHWG1zaNY0kNFHWj6A6zQCPBiIhuG63QVNfkSGnkQIm8yRch4bymHNE0B6Xxx/C02XgLpHOeNt1mhDPaJCug++X0qmpD1EbG/Q4oEa+Er3thU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgQ7GUkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgQ7GUkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA5D1F000E9;
	Fri,  3 Jul 2026 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085028;
	bh=QVP/r2BWw4KjSSA/6kTlBmvoQeuFVk2p3BvRVH9ExsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DgQ7GUkfVhg6kUHD8HWyHO1cFQmUBv17poaQ5qvEOiuLLvny7wEnFvLdUKfsz4C8l
	 F7aE++eVpxsSirS/RoiSN5QR5VArPh/HbgxRqN1cFMoikJ33XHOSPn/2cSTpzAcsEp
	 hyA8GM8J1NEwXByThIielOqdvpq1Qdv9XsCoLvsvYDTW6rNX3ZcO7ix8an5LZfO5S2
	 laI5FdIqmm3FXEYE40j4ZN61dpumkAxXosfednrQzqXfp0GLj/xZrsmTOeiuQssEpH
	 1Be/UuFKVMz+j8LcZ5H49heaEjZc441XHx2bBLJPygQQQXBdTiYdGY5u4T322Zw4vW
	 xQCN7SFFL4PDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Fri,  3 Jul 2026 09:23:46 -0400
Message-ID: <20260703132346.4102227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070220-sandbar-discourse-8d8e@gregkh>
References: <2026070220-sandbar-discourse-8d8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 7eba000621fff223dd7bab484d48918c7c77a307 ]

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitialized memory which likely
will be neither NULL nor IS_ERR() and so may end up being dereferenced
(for example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization. While at it: initialize the remaining fields of struct
fwnode_handle too just to be sure.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com
[ Fix typo in commit message. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fwnode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index e5aac0825804ec..22be90f0031dd7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -174,8 +174,10 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 {
 	fwnode->secondary = NULL;
 	fwnode->ops = ops;
+	fwnode->dev = NULL;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
+	fwnode->flags = 0;
 }
 
 static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
-- 
2.53.0

