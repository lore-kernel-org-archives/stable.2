Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B942F9D85
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988746; cv=none; b=jyo3+H7L5j4O/CfTy9lBA3AKt7X3I1C9lTAjGrsZthGV+bn+diYmx0cRZWDZ/wfsQluhsTOYWwtOwUq3oTU+GfR1JFTGHUudr8VCMEd0mddqNiYt6BlpVSz7kYWx4G4Da/TmDCw0vjDO2G8pU+hyxLswKk9AuSNPBfAoA1yC0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988746; c=relaxed/simple;
	bh=ASo9k/M9b2yDXlCQS2QvLk0q8Ht2nkzkKhTOWIfwuc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJUPZQo7X+iwO/fxd+qEi/gqZ/q/oOXSDOoKu//OlJ7Os9FhUuLGSfgJ7HpriUmhYcaMnLpKe0Pac4yVOTvFD55cU+ODDmqz7Ih0S1fUHTF3IyrGrRBySE6nq3zVSCrat+HzwE2f3WqjFHgTpMFFwm6Og05wNPQW2GhRnCES/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5AJnR/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5AJnR/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9F31F000E9;
	Sat, 25 Jul 2026 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784988744;
	bh=hiOYstl7HxPGLG9bfUa3+5DZ2L84+rFTe8FaNC2kQSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5AJnR/aw2OZ60IftjcvHyKWI/ROZkAfk3lu8eb1PdPn4Bicg61605To20Uh4Vaty
	 JfM3Nayw8n5UCWUFNb4ahcsq2FjbCWdt3N4GAThUtDqbRaVtcVmoygMEU+f4ihY+uE
	 Qew3UpV+a4p38KDrjDfWVWLyfGRtm3Pzov6f7BThSf3gYvDtR+5WE9od6KKp35aC7e
	 mxa07hGcYXUHWtfqBC2VfOcrbQIMx+73eYssx73wVEHqhdqoP+YZI7i5m3BXUwxavd
	 g8TN3b14dhSEziebwhEEkmpcimHdRd6bjqjdPYFpOitt0nicUav0QGy5idFFI0G7+4
	 wNQ+qbS2UNidw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/4] thunderbolt: Keep XDomain reference during the lifetime of a service
Date: Sat, 25 Jul 2026 10:12:19 -0400
Message-ID: <20260725141222.3814514-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-tumbling-reflux-fc14@gregkh>
References: <2026072059-tumbling-reflux-fc14@gregkh>
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
index 1fd1cf4295a2a5..1276581ef02938 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1012,6 +1012,7 @@ static void tb_service_release(struct device *dev)
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 const struct device_type tb_service_type = {
@@ -1120,7 +1121,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		tb_service_debugfs_init(svc);
-- 
2.53.0

