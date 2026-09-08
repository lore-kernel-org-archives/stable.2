Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7F54B1C4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890146; cv=none; b=j/XjQDiR9/mVFFHG872JtfAGSyOg13q66aUAsxfc0EbRyJlQMuZ4GmdZUXsMsyTVLzBGa4C+cT5UOKRduVPpuf4VjGv/9X6KF461gkU/TCPIGCV3a/a7ap/2iy3pFgkeOeIsx3Q9ApSRZbMBHeA4vGdWpHqdf6asEwyw5GuUt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890146; c=relaxed/simple;
	bh=jM4L9wkNJ9amEbLY/cPypoyJuzpU5R314yYWAcO69qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+w91Z95jNYzzHVSx0xx5/9TXtl0HbNACXSQt7fZTeqGe6QypltItSnwUABTjkdKwNdaEllDdXB6AyOSkszhUpvVH1Ga2tmZLk3ag57c85+YWE64vKvzrHUloSFfmf5sL12M57ynwazXrADYtVdsZCakrxmfQ+dzWv6EKgk+K64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXh4I8xB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXh4I8xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2021F00A3F;
	Tue,  8 Sep 2026 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890144;
	bh=TznfJ1/H9cygOCn1JZJl+MdR5FnDMRYwWqAOYe3bNqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXh4I8xBekFusPwYDWLH8+0zXrLMxZFhPfvG3sAHuHs7UcroIyVm5pdrKgUPX9Axx
	 0zo5dKF9RJnewrFXURWENbMyOrjGm4q1YRiyqpxLMsjcuT1muIXT+643cnJPYxlhuD
	 AyO/mHklsgJC2YrEVW5gQ+DttQCmC3UGTWAo4MtXvb7x9etIXoTsvROyF74taUMGOZ
	 QSaCTJ57qbiMfCMt3qNzLxe7bo6Hkyv+nTxc0LJuX8LGb/C4ehPdnVEAugCeLQg7ZL
	 6HpuIo3xUTH5LNuhB+aFwqJHUGqRv4gE/KeFRKT6GZR4jfhjcN+CagDJAhq0QWnwbP
	 Cxm3cwuuyNr+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] params: Use size_add() for kmalloc()
Date: Tue,  8 Sep 2026 13:55:38 -0400
Message-ID: <20260908175541.151692-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908175541.151692-1-sashal@kernel.org>
References: <2026090331-stays-casually-f049@gregkh>
 <20260908175541.151692-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0fc79cbc937f2a754a302a710a94b68c61d0a89a ]

Prevent allocations from integer overflow by using size_add().

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120151419.1661807-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index 8992899996984..1efc083b651c9 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/security.h>
@@ -48,7 +49,7 @@ static void *kmalloc_parameter(unsigned int size)
 {
 	struct kmalloced_param *p;
 
-	p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kmalloc(size_add(sizeof(*p), size), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-- 
2.53.0

