Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4839185C;
	Thu,  6 Aug 2026 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996451; cv=none; b=IifyXfcA9PdWnjjXwEhTwEXJK0lCActuLtK6WvzDng3dSq+FBEfJA3uAFtSpPwTpMYJVNqw1MXFeL5HinE/ynvOPBcLUozyjUOwpRXB5bxnkhp+goUqxdMqncCDtJyj8zbzO1Zkw3+9MODZQVsyJr4IcM9fpNd8MgPTqVIftGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996451; c=relaxed/simple;
	bh=T/0eNK0JuQs223MOM1MbcJzihIIJoVEglb7Jyd2nkRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQwCk2c/YIvGTgwhOOJGtMWsS8RdQkozA7azDdRT/WpcobuiyvherNvWYGdQsJeOZoFcWR0nGXEcyMVDBK6SMxQ9NxKCsjoa48JVLGMILB1HRfS+H3LzBijLaAOF7oSHVP3Bm6NstKe2MXx/fGyKpcYtkbP1FHDEWGlpi/2SZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=JrzqkiaQ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="JrzqkiaQ"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a3c;
	Thu, 6 Aug 2026 14:07:24 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] usb: typec: thunderbolt: cancel work on driver removal
Date: Thu,  6 Aug 2026 14:07:12 +0800
Message-ID: <20260806060713.863-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5aef79d03a1kunm84a4b0302893d2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSx1OVhhISE1PSkkdTR9KQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JrzqkiaQ1WXdxJqRds+kzTV+w3DU1HDwKWOZ9Mm+bI2s3itIb1wFwOOkRTjjyZi8r2OTiKdmdcqcU4PY+tDMG7fTw5TnTnYbD83igiNZE5c1URPQpQPzx4f9HU2G/DXWI+Q4HYV+3BKbU6GD0s275APxV2XY3E9e64u/Mld92PM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=poCRxqYRD4y+B16vv+2kFsGk1yGM0xIHldIoWTIc7CY=;
	h=date:mime-version:subject:message-id:from;

The probe and alternate mode callbacks can schedule tbt->work. The remove
callback drops the cable and plug references without canceling that work,
and the devres core then frees tbt. A pending or running work item can
therefore dereference both released objects and the freed tbt allocation.

Cancel the work synchronously before dropping the referenced Type-C
objects.

Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
index 32250b94262a..57c8dff0c51f 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *alt)
 {
 	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
 
+	cancel_work_sync(&tbt->work);
+
 	for (int i = TYPEC_PLUG_SOP_PP; i >= 0; --i) {
 		if (tbt->plug[i])
 			typec_altmode_put_plug(tbt->plug[i]);
-- 
2.50.1.windows.1

