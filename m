Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F953D0DB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952698; cv=none; b=H7Ty1RXDsqkYGEZ8VdOf6PYBHpU3ahWljUkkXp1e8Z+lm6b+TmBqk7/9aUbCAH3hz4s2UC9TL7wYmOO9LTSnh+6n5eA9/SGhmU5A7uZJnhkmumIyCcpbgB9I8/rRr5C0tglZPuRbHXNS8VauNxEv3h8Ah63khuLPxVzpxRUoot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952698; c=relaxed/simple;
	bh=UkxE5NmzZrpNCPvoYsUVLXSFFne7WnZrF3v/x5CdDmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn75iUxkZwKCdMkxXeIY8gzfO5oXGEuo6NV6d/jJBNxU+a/1wOaLx9TRCxcT4BvMXJc2DtiHFrZrttS6rcCIe7XQ41eZNiJ/zsihORcmoBura4RS3bO+YcchqKpMJIDakZWxVCx3vvvdQuJPa/59ISMvq7jrjv9r+5kLcVZ+QaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5XkZ6iz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5XkZ6iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45221F00ACA;
	Wed,  9 Sep 2026 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952690;
	bh=9M+i5fhA0ly2d/FkV6EhhqTuaWmsmeGpxvP9NkBU0HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5XkZ6izxtuA8DSY+fC8+Z5VJUGyFZVsy/kzKA7u+10luzeCi7hr1yuotw3obK0Nu
	 pnR4c0w84riu//s/YVjJ9LeNaD/6Pio0nZWnAH5GanVdLZC+/f5g6Usn/utkXTy0UJ
	 JPiQ3p4uzNK5l5fTchNe9pgYgzBFL7FiJqAKgtIVatLOThqUH/75hlfb7oR1LuiwfX
	 nih8Y5KJGZ2rh0v0UscBODFznwjwgBZ7f4s1loYYxyICiW9McUTb49b9TSlwLvk5xD
	 46RNGjrPv/OTaQUAc9RWdZdfboePVzi5U26hGDfAKqwQ2EOC1W6LnLbp9B4RJhebuN
	 mJWbYE+DVPkxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] driver core: platform: Emit a warning if a remove callback returned non-zero
Date: Wed,  9 Sep 2026 07:18:02 -0400
Message-ID: <20260909111805.1804682-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909111805.1804682-1-sashal@kernel.org>
References: <2026090322-humbling-ninth-d3ad@gregkh>
 <20260909111805.1804682-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <uwe@kleine-koenig.org>

[ Upstream commit e5e1c209788138f33ca6558bf9f572f6904f486d ]

The driver core ignores the return value of a bus' remove callback. However
a driver returning an error code is a hint that there is a problem,
probably a driver author who expects that returning e.g. -EBUSY has any
effect.

The right thing to do would be to make struct platform_driver::remove()
return void. With the immense number of platform drivers this is however a
big quest and I hope to prevent at least a few new drivers that return an
error code here.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Link: https://lore.kernel.org/r/20210207211537.19992-1-uwe@kleine-koenig.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 90166535a5c05..d0b15cbab0ff0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1305,13 +1305,16 @@ static int platform_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
 
-	if (drv->remove)
-		ret = drv->remove(dev);
+	if (drv->remove) {
+		int ret = drv->remove(dev);
+
+		if (ret)
+			dev_warn(_dev, "remove callback returned a non-zero value. This will be ignored.\n");
+	}
 	dev_pm_domain_detach(_dev, true);
 
-	return ret;
+	return 0;
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.53.0

