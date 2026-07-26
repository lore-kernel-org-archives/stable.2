Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058D2868AB
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074401; cv=none; b=bLGTWX5cJOvIqh6MmtfnuBQr4QarkXI2HmDgBUvEi5BzlvMVVBwRqwQxh577RsvRq7j7WDTiYsNvygH8wXzWmUcMgTyOQKaxd4DDPJgRry1eL6shGwJLVufgYFY5ZMoAE1Q5TUMjSI2Qumz0hmqYKi17Yi+Yg9N0xtkixRIVwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074401; c=relaxed/simple;
	bh=5aNO+4WTSbnx5UkV6yBRJcT+D/JsHISbcjFYnowJBAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikYLlzFI76l2JpM0iPpD19ChZeX3v7+KLeVGqOujVaIwAywIZuJZrE6S6BvC+9ixgsxrdIGDBWw3N8EAu3ao2hGnQqurbdj1WNHGQiZ9oveiIaNILNTOGL9n+E790QfQHhxdJ0vhR9dQUrLLlxhhnfAUK2X4h3f6GZ58xSRwKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXUou8jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXUou8jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A21F000E9;
	Sun, 26 Jul 2026 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074400;
	bh=qrFdkNTb1WCUkG4LqgSZv1fqA6RlIP81PG5L9+gn1YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXUou8jvDIcV4zqY1VCCT/CPislQrUl6AEob59/Won5uImDr5c4yafx3pGIQLzuVH
	 eAeOaQJfzU4w5bZjNJuCfZy9p/RuRh4HdLKcjox2LRGirAt0MFUut5awLCLc2vrg7W
	 off9350GewzWSnk2G07KCVMyAVZ0HACuc3YIAl5+dVEeVNmV2R9p1uwm744q3DCOL0
	 tj9U7PdUXVB8fkRN/HnkPy5MaRjMaQeMC4PpX3wh0WtD+9uLCU7Y3OMZ5QA/k8PFSv
	 MIr4WFH6cH2b0LaunGUiC3qHq5mVNWsG23xAVXQ3QUKjjo3mRta9z1XVfOw/mPGFQ1
	 OShgVosoOdhaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] thunderbolt: Keep XDomain reference during the lifetime of a service
Date: Sun, 26 Jul 2026 09:59:52 -0400
Message-ID: <20260726135955.668115-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726135955.668115-1-sashal@kernel.org>
References: <2026072000-womb-upturned-7ecf@gregkh>
 <20260726135955.668115-1-sashal@kernel.org>
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
index 3df7d0c937c9e6..1dc202bff07c09 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1008,6 +1008,7 @@ static void tb_service_release(struct device *dev)
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 struct device_type tb_service_type = {
@@ -1116,7 +1117,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		tb_service_debugfs_init(svc);
-- 
2.53.0

