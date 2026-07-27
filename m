Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91B3B47C4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166880; cv=none; b=jMDZjKsGrQHL5QTLI+gYhlyMdyaimdPwRlVzWH6FnPLoc00IYfTwaSoAJg3HfxR3Ute5oJpoYQ0asiBwFbNF+nxVWbT5zdv9rmJFgSEUkn8P2GGD/vTa+2j6M5Y1i6mm3Gg6JAbaAzz5x7MFq3hiol6/YK0KoUtBWEd1H6XuM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166880; c=relaxed/simple;
	bh=5VSOmYMvKU9VBjzljX4vSYbMv6LOrPp0U+qfCSlswAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE1QHBtNKfHembUbQELGJDq9H5Ju6kCoX9B3hoJ8ja5l0IZgPZIl9ipIatx4Luo49zh/JYwNEb9z2IL+eGTVBdOA1BIqgsw7u7l8BjdVBcjYW5TKK+MhqOPZjoAvQyCcJXcphwiQJx8ERXa35boGdUvowQ3qNyXAc1EsGFmzXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7aqKkYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7aqKkYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687041F00A3D;
	Mon, 27 Jul 2026 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166878;
	bh=61gaSU1vsnbt+mjSt+WZsRaWfd/qgJwcICZnUk4Dbwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7aqKkYKHrzvYDPK/ukyygPSncnOMr/lwvubGWG83DPw4HgyePU2UipECstePIMGc
	 2s3V3qrU1KW5MSs+qFXrspcnb5GURbfQE/Ll6eZOK1Wffmw6f9IYk4CqCIVoEvVz++
	 UApBap8KUapA9zNl9KDzajWUphv53neC+sFdU+eyopI6OiEwy6LOtr5/3GZVWgKLl0
	 MNpMatSGrrLO6ZAkpHE3rYWuyNwovpmGBuEjpzQzdWTUZsnpuVaD3vFb6GezdZ/f8v
	 fUuPDQ9NPz3xlkGs5a15Stj59UCSSeGxHf/O5dsjTUHJuXeYD+CrOwaTD02pdeDWuA
	 mPXcG7N4gEvew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] thunderbolt: Keep XDomain reference during the lifetime of a service
Date: Mon, 27 Jul 2026 11:41:12 -0400
Message-ID: <20260727154115.1516559-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727154115.1516559-1-sashal@kernel.org>
References: <2026072001-numeric-suffice-a245@gregkh>
 <20260727154115.1516559-1-sashal@kernel.org>
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
index 6d178e70e2b1dd..b137d69d00b010 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -811,6 +811,7 @@ static void tb_service_release(struct device *dev)
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 struct device_type tb_service_type = {
@@ -919,7 +920,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		tb_service_debugfs_init(svc);
-- 
2.53.0

