Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656C231A21
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175531; cv=none; b=YHgb1/kYFP8Tlp1kQc6JtvfXN0yCjAlLgp2OgrD19wi20veS4qakV6zhobJXqyCshgcZT4PBYUWiNXspbRp7maYzBh/SISn/qozehFWosG7/lwTono7l7sbLz0S0myPVfQ1NTH7gO0Frm1xDw+wy5jG2SuNoUj+vG62QTIPBCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175531; c=relaxed/simple;
	bh=oQJSp7m/3WVfWF7qLMyTsguW6N1PnNGrU+fxXaJinEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThZM+kfYBP5jKUwspEb5kFouZFc/uo7oRh7AVpmmIBKR/FG9EJjwIkve5zs81hWHh7MDqG89sBxj0qzw/14oxn6M3grIk9VyocNiDCmw4dUUU0ypboVA/euxh3t+G0dF1gm/L621GhYobWP+0vwYqn7fUkMKoJXz455V7ZkB450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg9OJfdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg9OJfdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F7F1F00A3A;
	Mon, 27 Jul 2026 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175530;
	bh=WCJ/t/Sa1RNLSHBl6otNsuXWaW4MgNiEb52LSRak26M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jg9OJfdCAEKwN65SxDTci+hWOwt0HN7CSJGjJS7nkR41ifYQKnO30Yjy2pTkB5Sop
	 vtNDnd4pOF5ZChjhZ5PHOSytN/UDV9SATIGzeHR3PJZt/pRecNnCxJNa3AmQtWSCAv
	 yN/kFPrMuSYG+muYhdEI+46SxsTIJs0IktkuJKXBtSiABtqEB1xDtVxNoyz40qRPfW
	 +DNZ/bAvoe+QFI+G5fjhCaLyvRxnp092jaltcPaNunR7EJk1cvM1U3gpQrLyYkgcvc
	 xsaW7wQVGf18jwtdVoqJktJgWEVkDsuqufznXAMcRDQLpy98QQ9uhWoPDD5QRCKMo9
	 F/XvkBdy/7ExA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] thunderbolt: Keep XDomain reference during the lifetime of a service
Date: Mon, 27 Jul 2026 14:05:26 -0400
Message-ID: <20260727180528.1410603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072002-actress-oxidant-7a4d@gregkh>
References: <2026072002-actress-oxidant-7a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 8b4060998637f06975fceee9b73845d8672d411e ]

This is needed because we release the service ID in tb_service_release()
and the ID array is owned by the parent XDomain.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/xdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 8e79c20e480773..5b0f300380f5d8 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -784,6 +784,7 @@ static void tb_service_release(struct device *dev)
 	ida_simple_remove(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 struct device_type tb_service_type = {
@@ -892,7 +893,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		if (device_register(&svc->dev)) {
-- 
2.53.0

