Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0C4322FC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228283; cv=none; b=dpi/dCvZz8dTusb63JNxmdUDsq3kuLw3EHlUkOeSee1z7rbCPOdOmJ49RKoU+p9Sg+6qdxLNrAFvUCxVWhAebEGXuF3KWIxfy7pyGkmMU5/fqB9lPOZwPPZQQBv5gDqnKXJViKnhIu2xkFOB9vlMaeOKXokd8ecgTwxTt/tROW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228283; c=relaxed/simple;
	bh=kLMc6297bPuMZ/wzJjems2aWQXJ3M/GWe3VMiXhCFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVarzyiyjp6/9hn+kc/kCiZryVsnSt3RSMcnV72mR9obvifmb6ZRNO3kpQkjosvM3qXLrBH7qRjR9TgkH6EeXTZHEzCDwKOWcbZcaWTwKKiRp+DpiJc8tp48IIfN/zXBbWK9OEGf9AHx6S/Zzzqo/RCvXH5iyxweCZh/+EdMlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upr5aAly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upr5aAly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AFB1F000FF;
	Sat, 12 Sep 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228282;
	bh=4LnDrQOL0cEFaNUKVFM63Os93zGTbIpInhkS08VN/8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Upr5aAlyukSmA9KHRmVQT6Zox+ehvhGKoi1HmXWP+xUIUWVzqISne4cJzRikW/RAQ
	 mWohneU5z+IqE9Y19W7v0rvnMEqRzy0NfqGRTf/Guh6cK7Oapgq7uQBGcsRTskxn6d
	 m+7RmkF6oDcQGPstnD01qp2dGrGTllCJjQ4Un92b1L1G1vWT8OPcpexPIQBKbevP9G
	 ukssOpoUTTxckedR/l7Ee15yGWVJa5hHCkAQYeLX3WE/imViIQpdcPd0l7SSVwaCkB
	 DXInBR8N6fwtqERpQ+kw5APhSY+DMKSWLxArX7WReeQeJaNMyhQ1f5JeXeV3RMQxsi
	 vQ4ctlELVB8sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Sat, 12 Sep 2026 11:51:20 -0400
Message-ID: <20260912155120.3559750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-unstylish-evade-283b@gregkh>
References: <2026090919-unstylish-evade-283b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 03f1a3545b721fa7fdadd00080e237519a286a97 ]

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

v2:
- remove unused function simplefb_get_validated_int0() (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Link: https://patch.msgid.link/20260625094509.157581-2-tzimmermann@suse.de
[ adapted shared drm_sysfb validation changes to the existing local simplefb_get_validated_int0() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 18489779fb8aa..c32b328ff510a 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -50,7 +50,7 @@ static int
 simplefb_get_validated_int0(struct drm_device *dev, const char *name,
 			    uint32_t value)
 {
-	if (!value) {
+	if (!value || value > U16_MAX) {
 		drm_err(dev, "simplefb: invalid framebuffer %s of %u\n",
 			name, value);
 		return -EINVAL;
-- 
2.53.0

