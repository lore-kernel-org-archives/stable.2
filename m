Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B74A13BE
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002600; cv=none; b=nZ7Jmf0BVoy+EPBlTtETLE9NobMciLIjyGEY1LcO6+bNYHW8hRQaZaHrzov6BGg5IiZt0s9JvtmxF3DGIDB6QEEhSkCz1x+Q68lfU/WRl0tTKucGZJDXOIKY4qOuo2tEwksmD8jMB7fr7vM0wShikIjToblZvx+UVfWh1EeHKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002600; c=relaxed/simple;
	bh=53sPHnwpkreTFShy5p/gTur9r20dojxSjM1K78gPIjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3UG0jeSVqcKMB3ao/rGy8XXKpAuWh3iYB42aTDWkRHeDk4JEnqj6Q7hUpUIgo/z59j3vhB0pn0QVn2qyhAiz/sZ6blhBMpBqe66aabe4XuxCM1dC/nMrzfSUWAVbKh+1dm8phYE3flAQpuB6zWMT3E8NhyNJhRGfQwZfIx1tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7BZS4IL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7BZS4IL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1C1F000E9;
	Thu,  2 Jul 2026 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783002599;
	bh=s/FdiL7BjjunV1IUfIICk/PLhjAywNQpi+jdfUhPwXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7BZS4ILyfHrH+nguikFuK+40WQkQN5xWN+INLfvNSeEDaFKFUn/aCuUHtDg+tROz
	 dgLUwNl5kpzv1/mT+y7qC4+yit3JR3da7Hd/APBeD0iURJKe2RQyjSIx05Gp1pVjF8
	 S8m6LWSpv+sDTnzfiWfnjxH8EFbYvJlPcAAu1mgn+wkegvKWN2adBTR/B4S/J69c4g
	 oBJ8Hsne+O50tbYhzVcCOQ04NmifHTgHReej4o7IyRaODiQ90cOcYwydRPycXbbYY7
	 D8/3gp9A0i0DjMmQesxfSV38JBATORPX/uIld+sWbF/hV12PsOaCiQ7k2raa9zcOUQ
	 ofQRiRKoqERtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Thu,  2 Jul 2026 10:29:56 -0400
Message-ID: <20260702142956.3485868-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070219-kangaroo-washed-a6e0@gregkh>
References: <2026070219-kangaroo-washed-a6e0@gregkh>
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
index 31df7608737e70..c30a9baafc0d99 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -210,8 +210,10 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
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

