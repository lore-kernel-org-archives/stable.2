Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D759B692
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892131; cv=none; b=SzRDZz80nNbVK2T9SnYBDP7A48xlE2gL0zICDZsi912c9t4Y1zZztdBfnAo97+dCxUk0xddrherGaNRCJL68BNjNlO/Tx8m247LF9M1UsMP8jnPpKhN7pqkSdqBubiXdT4xzmsr6A/7dyl6DzIAmvPQ/7ZIJBCsuP4w5tBYtWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892131; c=relaxed/simple;
	bh=Aorujg5WaE8rRUwURWiEUaJwQ1Get9k+kq/cGByO1o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA9JhxTA1Uc08M1o6avvgZiRVA0hLhYe6K1FXOgul00jBZg9nQlkpS7Brz4gK48lCUnPieICYUeXV1VHlk265985ZZnN6FZ/KNRR+n8VVRwxCOGRIi+7JNhyDtE8UrBy5N5WgHYOQlBTFJNJkVfeFBcJIC8tL6ybUP6AG9Z008A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQF7lO3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQF7lO3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBDD1F00A3A;
	Tue,  8 Sep 2026 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892127;
	bh=n2sCIQOK+oInYCWoPVMmF6fTedkpetFmW1/O78WHqGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQF7lO3OrZHZ0tc2/BeqNk3Cid7eMhai0OpBnjtXXkg8saPYoC/+fuHW5XR2uOuR5
	 Xb3ppnZ2qfyH1d+WTI0SOIQ8drKbV7nBsRFmWpWhqaflFO+ytl9AVTU8HrFqyBbPSC
	 8kLaE00gwGFJ17LZpjrIU9t+nZbfUqFDlDDJ/PP9J0Qjewis4Q+hSc6FJEAxvAtW5H
	 LAo2t29t2D5SdwBVEOpdc5VEDxkgAeWTyktsYWNS/oVyd3X1jo1sg1HwWxHQx0oRjm
	 5Ll6erxbr97gsIcDLj4+y/+dL7GXMxYVkirp9D2tLnATCFL5tN2NdsFzJ72Mpw4fRA
	 SLKKIdw+B/+zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Miroslav Benes <mbenes@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/6] kernel/params.c: Use kstrtobool() instead of strtobool()
Date: Tue,  8 Sep 2026 14:28:40 -0400
Message-ID: <20260908182845.219246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-barista-diagnosis-cdab@gregkh>
References: <2026090333-barista-diagnosis-cdab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit def7b92efd868a6c78da86770704c1a03506016e ]

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index 0df4a315760d5..9f0f059571a0a 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -4,6 +4,7 @@
 
 */
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -310,7 +311,7 @@ int param_set_bool(const char *val, const struct kernel_param *kp)
 	if (!val) val = "1";
 
 	/* One of =[yYnN01] */
-	return strtobool(val, kp->arg);
+	return kstrtobool(val, kp->arg);
 }
 EXPORT_SYMBOL(param_set_bool);
 
-- 
2.53.0

