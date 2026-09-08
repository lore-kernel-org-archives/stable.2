Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C359D60B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892133; cv=none; b=J5565dYTqtOiGvMnxiux4ngSWP0UCIKlLvF6XRm88/nUwv0yIbZrd3SMLVkP2uttpHws0JuAsUS2sxlfmPnPiUcxyxZL76aHMVotY118kihlO+f5aNUqwP9XD9O3eaqBjBpY09sTzkJZ6HUVTHoG5F8/rHLvHreR8BnZFOTrPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892133; c=relaxed/simple;
	bh=Iry6AKHxMGiV45C4Lq+MGr3jUST1bKTQ9ouzQQvWy6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fkn0gE1cfXS4aTQ5qtf6xP8M0Z7if0SOraJYvy/xlTpGzNeIOPGtRDKAWKF4nTm/ngdaX8rL4+SVxjP5N1BgGaBl8GZzAKB9ZFDa5ZRroHtHRJQVp7iKALfbrVb2Nbj34tARndLoM69cEIJHWpWHaH3t71mC8Mu//IZ3AlW2aqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXmcAgo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXmcAgo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676581F00A3D;
	Tue,  8 Sep 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892129;
	bh=sHcykWcrCv2hTjxyWm/iVaa4waG+kpi154SZT6ZIFiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXmcAgo8JbWieErwKS1QmJQgx45le9EwNHCodvlpIEzcszIFSSXsPdzqpo67RW+Mc
	 uPOX8Vg/6MAAxAiGIorvvtf9G3YA2k+CAuf0wcVi9Np4tvjPbPwZfAVctSpPOpXKU7
	 BKtBY4/cQ4djygdF+y2t+Lcwhb1lcL7Rviuaxh0b+Cs48AtFIjN0MQnSJSI9m62PO7
	 cEhZ2QbTjiaRsbjDkJT22xtX2qAifiQTQRre20o4yI8r0O8naYuaMAyXFgpK364Apo
	 xWZkmB14FYia5MHDeRIYGN+4/UFf7Jmw+HIhsE/IIVotYXOO07wi8Yo9R/ZAbMQ8OM
	 ifBapy0QuEVQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/6] params: Use size_add() for kmalloc()
Date: Tue,  8 Sep 2026 14:28:42 -0400
Message-ID: <20260908182845.219246-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182845.219246-1-sashal@kernel.org>
References: <2026090333-barista-diagnosis-cdab@gregkh>
 <20260908182845.219246-1-sashal@kernel.org>
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
index 30c0a7388024e..b930d3a4677cc 100644
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

