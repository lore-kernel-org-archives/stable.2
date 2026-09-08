Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12659221D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891671; cv=none; b=PD5fxqsBf34H6MCu1UHyOXV9MuOynUbuRLUkAIF0ywnq3QJVQNRfcKgvq6PsR8bGOkq90IXpGjTKmqw9Ox7jT7elbpxhtiltHeRnrosiKWgjqEzmu+RqqZj7QJVVHKPjzRP7+PWXZreejn6chqlPbBdy0GdyenmXHJiAbOg48Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891671; c=relaxed/simple;
	bh=QHFBsv+9WF4MldaH/YVYNAP/7gI9+2RHj7PxmpVM2o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7efirfea2KWgMXAu96xXr0pk+aalNVE4fTyhqqFeGFlPHH1Ylii5vzl/R4vm4joTSU0hO+3lgDZeDNbaL6bAXTh8Fqi+6nDPTurC64Xm2tIq5Nwagct/HNOpgDnkVFulA324bLrMUJUynFlKKUg6zgUHfhhzJbGHgebJTsC5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udp37Q/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udp37Q/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269B31F00A3D;
	Tue,  8 Sep 2026 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891669;
	bh=gHaGb1103AEBHNfnu6YkKmm0GP3xNCktp81Z+rQ4kd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Udp37Q/ocTi7a0JTISmJT/Ty7eSbH1lcIhuFRqBpOtQCJyUXndccJh/lBAHRcT5Ol
	 AB7O/4dWf6Ix/Qs/Srv/rplQ2BBuCwQ5TwpVi8t5WhTe83H/3rNUt0s2EYAeVyhXSz
	 8rOiFAGSnBoeLlC6R2X51VW5ZDbJ44+16vZ/gJ9y+AGjzrzigCviW+k8+AEwi79Dic
	 Zuqk21ILWEXDOIApmnmrZ6MnRKv5CZGuHQAAgyVFTYCC9+LSSuEhZY+B8qsLLdIJKP
	 V6tj5IUfMphwHIhLKQkd3adEQgMTeyhSAcaEYTqV2TFJ5Y2xQmEYwKv2vU3+p7NS5h
	 0t9EzARhvWkNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] params: Use size_add() for kmalloc()
Date: Tue,  8 Sep 2026 14:21:03 -0400
Message-ID: <20260908182106.202353-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182106.202353-1-sashal@kernel.org>
References: <2026090332-lankiness-same-e48c@gregkh>
 <20260908182106.202353-1-sashal@kernel.org>
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
index 55541483d6d36..0139fe38d0b2a 100644
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

