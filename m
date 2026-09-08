Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FF59C997
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891344; cv=none; b=FkrqVkhBsgJbIKi/ud8zGt5wRu+qVRdClqwKgqEn5H1E1ZGgvYykl0jz9n/0861xBalVryqEqs4RdZHUEGneTNaYBtOdnJga+6vH0pEVmSqVHGmm76DXfeM0V1j8Kqcd9AyKYyXK+29qEoQ3EqPo1uq3a8kCJb/uY8W2t1daOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891344; c=relaxed/simple;
	bh=jnO1X9D6Bl5SVRd8XXslCGaPq/ODAb622+x7gKXicLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDO/VZr2kT085Hmubpazegr/Rbm8xGrFVxxkb2ZWz+7ppmabiRBlt1GCU7jq/wYw31XnlATDVLJURpAa1ZoDiytjVQiQ5xtC/o/2aoYcggfUo1e41i43UEB8rgfIUD95JKAHNlW7sGAXv+Xx8KwHODE3x9NEkg5AInZg1172SJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFKw2DVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFKw2DVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F361F00A3A;
	Tue,  8 Sep 2026 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891342;
	bh=mFajH8W7GJi+RwZY0wM/yqeqr9loxzSXHM3FDau9dmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eFKw2DVqtqyHMZ34JkXtHg0D77jsO1jKpVSIHgAXxV6zi6oPsu/TXHi2Nt2I8XqnS
	 ucF87sCJf1gByIQzPNQDgC/htAXFF0+oV30d8L8sikaUPWmGRBRfV5vmOMi0zCOlqF
	 8Z3TMqV7mB82Vnk2jaFdHN9zrLa0ICRQZt/s80FmstJcIex44fyF838AOko8nbHou5
	 prdpLpJ13FKddZCZTB+dvG9AvLqhVlzeSaWlbZ12sIXEpaMveNBn3VQT5+u635dm/K
	 kd07n6Uzy0nmRxvOQRJPcHnGu+rFsVQRfdac3VRFQ8SL4g/ha9Of0YH201cBBbLbWK
	 qJoICgA4JKsAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Miroslav Benes <mbenes@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/6] kernel/params.c: Use kstrtobool() instead of strtobool()
Date: Tue,  8 Sep 2026 14:15:34 -0400
Message-ID: <20260908181539.191940-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-blazing-handcart-8248@gregkh>
References: <2026090332-blazing-handcart-8248@gregkh>
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
index 82109c0cf9918..e6df4c2ef097c 100644
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

