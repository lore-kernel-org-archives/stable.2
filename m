Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEC59C967
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891670; cv=none; b=moj8V4hbJoGVhbhzrVmWP2mlNa8ClaXqSmEOEEL0clYQ3qtZAOaPkUzMCW56AxNdKjjPG0DzIW33IfLFWEy97PCvktrWDgCuaCsDnce35VMdCk8nvGMRXvXpErkGWphViGpsA+Rvx5TxSUKpjS8pb9M40OAjPedvCEbI+iZ6K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891670; c=relaxed/simple;
	bh=vSOEqTqWy4Q6/OjHjuUjSwxhFX7AIII3bumaXlD/+9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfjT3ndAjB2czh7PQvdJH1t9CQjPNQ1bEhbtlXFN3E2bYZs5AIq1M2m0IbuSJX5zToIcA0Zv5cDZF6HUghFCrN2M81eHJeK/qAeBZpvwS9FoCwXMzQPT14q8GMX95kVxskr1GLzifCgqH1DqffEX4pvLzxKf+P8xZKfjp/oKFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtCSYcP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtCSYcP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C411F00A3A;
	Tue,  8 Sep 2026 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891668;
	bh=Gw1jzCqTfG056Al7Zk9zwR34y5CWbtc3GRG++bSIqs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VtCSYcP2cQatphJuPOVwTYwEXpS0CjeiwoLF3ESVUe/A40OGjeHBhci5y7O2PdYuH
	 9jUlxpjaangbry46pefBhTJ17YfaHOipJNOGj3RulzfymDtHteqJm8MGVxaGk1yugc
	 asjCwYnhBMBkDVLDU6wVx1VELL9nYZv/4C01V7M7/9/4ZYa9ycirM0EPtammOKyaoW
	 3d7yPcNpcqQa6G4E95ftjye6DEG8FYC6ptFWsRKkpNod91YHd2E8zswZaBrh8HdNvP
	 YcRWDKwmReKCQ3l2LIHBKlKfdx8IXqFgK2fRudUaL4w28wrb681lPd0T5CRkhrKL0L
	 uJRmrOKyxqzLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Miroslav Benes <mbenes@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] kernel/params.c: Use kstrtobool() instead of strtobool()
Date: Tue,  8 Sep 2026 14:21:01 -0400
Message-ID: <20260908182106.202353-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-lankiness-same-e48c@gregkh>
References: <2026090332-lankiness-same-e48c@gregkh>
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
index 1233673b42ecc..b904bd98dd01b 100644
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

