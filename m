Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BD36C0C8
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069377; cv=none; b=TVqPHZ8Uw7lbUolrRirJUXSGOBVeqdvZLBSLSjzJnJJRs5q3Q+K2sgFZZBv7jIT/tOijGDscEDSnpwNuu6KtVyn/77ivhR+11vdUqidzjfe8ffAtg321CwJgt7odMwsf3zERpus5amMkKdRMB/8FQ49fn+UO4NYN3ugPfQKnXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069377; c=relaxed/simple;
	bh=7iPxu6cn6ZIxTrdko/lxchLJG7g0iq4eN66BaMZSCSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enN1v9x6pAMGkElqVshw/BWmYDI113lU92yAo97gxJVQAAITSfhioZcjHgeIWgYJwPobwchSlw/B1H7FDhXqTbkzBIihJxyeXU/gprJ74PxB6QSixo/p13vWbRDW8/wzCw3ylu2w48PRyY+MsgqVVdPSNn8dIRd+453a3vV5VFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awzr8H+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awzr8H+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0911F000E9;
	Sun, 26 Jul 2026 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069375;
	bh=+OSxEKtd4JbGSPa75TmnpBpdtS9pq+VpFjktITXbH6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Awzr8H+BUOXTqu9QbtJoM30T0p5QmMYLt3d2RPlRPPOntV7EqH1/1ug8bL+41/LYz
	 Ii14jOb7rFiK1tXMPg4PPYjPQpQV57szbSHxugYotx//yESaqSRyvI7WAY1yrrG0xl
	 4TI+x5eo+l835dazvJIUyW+cSjifsxvANzGyBkyRibUuSzyFgw7szMGP+ci2SUwTfW
	 91diKe0vY1LFybRB/tjOOQHEnUmRhYwY4vQw7i5P2Etw0FJ56RiEFxCMnU1KiYy3Fv
	 gX7fesWliAIL+lOLPNwNyHFDJkjNVQFQnhZSnKepXnm5KjKuNvChnTCSdR53UUd0lQ
	 3TTHtCFrl/sUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] thunderbolt: Keep XDomain reference during the lifetime of a service
Date: Sun, 26 Jul 2026 08:36:10 -0400
Message-ID: <20260726123613.37376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072000-monoxide-trickster-c965@gregkh>
References: <2026072000-monoxide-trickster-c965@gregkh>
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
index 06357073f4ab84..fa26d750dfe5dd 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1008,6 +1008,7 @@ static void tb_service_release(struct device *dev)
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 const struct device_type tb_service_type = {
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

