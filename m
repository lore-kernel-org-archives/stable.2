Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354165;
	b=1twu273Nahr004ekTQd10vSfa9RoOk+a23109p9bJ6toSkv8WwglTLi+6Fy9Zp0JH93q
	 ekYMATe+f8cHNYjR1F0yoy/QkuppvZZU+Q0UHEQ8krrPlC5Tnl8+6jRYFgZd1oBBfoO1h
	 8uvEJQM7HDxES+mWAXVQkGBRLU4jZExR75Qmg9hBvR5ZKwfQRCesLf6Tyjy2OF1oPKKls
	 db/aA1l9QlS6UuYN53k+rZhV4cA0ln+CxGbStdRcdjFd+XN+5yOzIsjCUlX2antt2BXay
	 PYnDPidMbPRJNYrwL3FwA23Q+oforjuzgmLPXPv6TxkvB0Oawv5cJ/+wOcV5BE3iUJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3nGEek8g2CZHIc0G3LoLtkmR46Nf0n+WieD6W1QGbQo=;
	b=pEUtuDcpgmAyE4rmrHRclSvdskPlskxD9RTIMvKkvQgZUYKpmZG7kefv+zt68NvQKivg
	 4JFXGm15u+nhgtIFjMhi4hRFg9wKxj19cyn7Ji9LwxmqbMgPTcOK/ouooIuYz0tL5Ax5W
	 Py+RXWxjPooNi6YPecfhPLinGclrDYUQ+SC9n2ld2T2dRNmDXv2QxN+rG9IuD0MIfADbn
	 9okc9+F0+tgX+HiHJ650TbMyHHjn2wyIbaI/ULOSbzwjBzDOtSb9EBaTttjzteVdup4AQ
	 0n2+NyfdPUkabjHsaD2tCwsmad5OgJCwnvJVS43ryKF5qDZ9bfn6csRoiYxfcNHLbyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lc5LA7IM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lc5LA7IM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3501F0093D;
	Tue, 10 Nov 2026 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354165;
	bh=3nGEek8g2CZHIc0G3LoLtkmR46Nf0n+WieD6W1QGbQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lc5LA7IMw2FKmglEg5KVpn5zuqAm5YljRNj+fTjKTbr7tsoWicf8azv8kTkr6JZjV
	 06YjhLbbVssNKQm+3UIZpACCpJEVZsjWzrFekvmC54mXTYv8aEI5+Y0iikM5JDbI2J
	 Gc2L4PEnRQIkLxScNxHb5YM/3LoyWgigdIS4lLu4vzldKwAxW7QIhEilg8ncXu6z2b
	 bXMNTXjrlzXNO43lMIy/UYIlZYXhg5s5dT/72cCrLoizRiEdNWkI0UmJkfvwLK7nzO
	 YGQWY35NHQY/MvN4vK3/fH7WFjOmhbVsYIOPh+SIbbgZN1v4toHstY28HsIED52F80
	 NXNdKY3Yn0QZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rong Zhang <i@rong.moe>,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier chain on error
Date: Tue, 10 Nov 2026 18:42:42 -0500
Message-ID: <20261110234203.175636-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110234203.175636-1-sashal@kernel.org>
References: <20261107051305-failed-6.18-3b53e691e907@kernel.org>
 <20261110234203.175636-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rong Zhang <i@rong.moe>

[ Upstream commit 3b53e691e907086672b72d0544e4bf27efd4250d ]

Returning NOTIFY_BAD to the AC notifier chain stops it by preventing
later notifier blocks from being called, but our error is non-fatal for
other AC notifier blocks, which should continue to consume the event.

Return NOTIFY_DONE and add a dev_warn() on error, so that the AC
notifier chain continues. This also aligns with hp-wmi.

The function documentation was copied from elsewhere and makes no sense
here, so correct it as well.

Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")
Cc: stable@vger.kernel.org
Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261019-lwmi-wmi-new-api-v5-2-71557d28d058@rong.moe
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo/wmi-capdata.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
index ba843b6604b06..c7fa1c2969561 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -188,13 +188,11 @@ static int lwmi_cd_setup(struct lwmi_cd_priv *priv)
 
 /**
  * lwmi_cd01_notifier_call() - Call method for cd01 notifier.
- * block call chain.
- * @nb: The notifier_block registered to lenovo-wmi-events driver.
+ * @nb: The cd01 ACPI notifier_block.
  * @action: Unused.
  * @data: The ACPI event.
  *
- * For LWMI_EVENT_THERMAL_MODE, set current_mode and notify platform_profile
- * of a change.
+ * Refresh cached capdata on AC status change.
  *
  * Return: notifier_block status.
  */
@@ -213,8 +211,16 @@ static int lwmi_cd01_notifier_call(struct notifier_block *nb, unsigned long acti
 	switch (event->type) {
 	case ACPI_AC_NOTIFY_STATUS:
 		ret = lwmi_cd_cache(priv);
-		if (ret)
-			return NOTIFY_BAD;
+		if (ret) {
+			dev_warn(&priv->wdev->dev,
+				 "failed to refresh capdata on AC change: %d\n", ret);
+
+			/*
+			 * Our error is non-fatal for others, and we still want
+			 * the other event consumers to process it.
+			 */
+			return NOTIFY_DONE;
+		}
 
 		return NOTIFY_OK;
 	default:
-- 
2.53.0

