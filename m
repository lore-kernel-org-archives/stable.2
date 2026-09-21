Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786E48F009
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983193; cv=none; b=WJ0ou8OJo1qMeHYv6H+RWbd2U2GN5YrcfobvSBmIlcp4za3GJd5GUVTXhLqbx3rx6elnJJA6whCEKr7FQu71Zls5YBO7g1PHwa2AlKzMS+oJJaHSn5qGQDuE2XqkZCNoV+MalZtPBST/B3vcGUG8/rrPuatEjrThngI38c4USLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983193; c=relaxed/simple;
	bh=WPJHYnrQrYYS/+gXuwPOGWMsKbPW/NqlsGM3UKpVqPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R694eCcbJQSWFqvFVOejUVzLN4oFYvIchg54YzKkOhhHEsnrDje3whWFcx5NZzpBhkteBVi0uSUMeVAXpGoV2jU7XVqlJ3IjwAt3OlYSZuUPYtC7FpMmKI1dTSGhwwltkS0LdJK38Fsor1GkWzkHc8fG+daK2np7bkuStYOdgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=sY7PgeOC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="sY7PgeOC"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260921093259ae8cc1154c0002071a
        for <stable@vger.kernel.org>;
        Mon, 21 Sep 2026 11:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L2tNSuNj50Qwkw6ouG81VT0DerK7MEmUivw5GyG01+M=;
 b=sY7PgeOCewMuZ6A416pnAewJFx+4t2xBzq2XBWMG+JTqHrBIBOnxued9E2s6mmAapDJTm5
 sy0vPEjak8FJwog0sQN5RXKKwxAFLrj02bvo5HUzE84/0aYAiuoYmZmwdBv0byOd/lzN3Gss
 heFcdeke7oigQ0p1Br+JS+PDapyO1gn/9qGNpe188ObKSza83N0TtIzwE8fdSL+AZvyUyjsU
 i1sW9dKa/oqyhgioOE7TKiObXZNPuNszNktLwQuLtLdszzrxp4rtWFp5r9bLTFxAHBpuZ3Cf
 LUEQs5LytUpNl9CJO8zyqs1UuOdsk+rCuSj18IwBPFVE+nqlfe5AV9sg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] leds: trigger: netdev: Put netdev on activate error path
Date: Mon, 21 Sep 2026 11:32:43 +0200
Message-ID: <20260921093249.3481413-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

When hw control is active, set_device_name() takes a reference on the
netdev via dev_get_by_name(). The register_netdevice_notifier() failure
path frees trigger_data without dropping it, leaking the netdev.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20260914140045.B8F4C1F000FF@smtp.kernel.org/
Fixes: 0316cc5629d1 ("leds: trigger: netdev: init mode if hw control already active")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- new patch

 drivers/leds/trigger/ledtrig-netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 5b4e92c14dbb4..c65df91c4f6dc 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -779,8 +779,10 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	led_set_trigger_data(led_cdev, trigger_data);
 
 	rc = register_netdevice_notifier(&trigger_data->notifier);
-	if (rc)
+	if (rc) {
+		dev_put(trigger_data->net_dev);
 		kfree(trigger_data);
+	}
 
 	return rc;
 }
-- 
2.55.0

