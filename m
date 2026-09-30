Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B47367282
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735126; cv=none; b=CBHQ62wPejKmP8zv9P1zXgabBFS4qqcYKbkR2jtKg2x037TncC1zWoca94YS5q7mdusUqeTXFKqTAIdbeJNodPBUIhVK3M8rTBne11HeVQDmtTkuR1JERgzMjTO6wEiGNCUNLKjJDiYpbKWvQ2jdDHiQi+/SZss2DKHCaBZdyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735126; c=relaxed/simple;
	bh=Cw/urw1AylpLE/HmOflDc8K+61IRGdaGVpoAO/a4P8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHf1nNKDPS82e2C8FADrFucAIzgQomEKNt+kRLU2lPV2ih2LsvVPVlViWkk5TzW+epeDf/KCK8LJ6JYF4fxAy68PWXU0TvM536aLJHFfMPhfFg+DjaUc9R1Y/D90GpP1u1tjfLF+yuNBvP1B87/3SN7uDPRa6qzspmWIshFTbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ8yppxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ8yppxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED81F00893;
	Wed, 30 Sep 2026 02:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735124;
	bh=2wIYlIVFCRW/HwFZjfLl3Lptgf5jrcxXkxpcnwjKeF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJ8yppxIkPcmJ4VgnPQQKMZK/Wn3wC47/4PhG06RlVfrvUduF23wmtp7x8E33Fd6G
	 Jh7hG5QRgzF2xYxZmTSZRdw2GSDj9HTn+bjoB3rhieg3a+G+D3qFAwoygpIHtjShnb
	 4wpbeKPJSOTg+jT0m9uXLrDiG1Kk4hTVZ3/anggxV15x/I6hV6FgNymiTgZynBoH76
	 quafwkER6eI7sPkaSwiMjivbTu5JTBBZusisLFRhx0/ZUpQTly1+Y/fQmxHPmj5AjG
	 Atn76dhOdGmNc0RqZs7qtyyP+VWBxNMAjGdoXkzFwOUU//RySxZ19b4XQklOG/5RB+
	 kusNqFU1Xcybg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] HID: hid-alps: use default remove for hid device
Date: Tue, 29 Sep 2026 22:25:20 -0400
Message-ID: <20260930022522.3389463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092957-hanky-stipend-aaa1@gregkh>
References: <2026092957-hanky-stipend-aaa1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Folkesson <marcus.folkesson@gmail.com>

[ Upstream commit 989f7cc94f1174269282a4a46bb735c7f11527de ]

hid_device_remove() will call hid_hw_stop() as default .remove function
if no function is specified.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: aa9dde93e05a ("HID: alps: unregister DualPoint Stick input device on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index cd60a52b9beb9..d4fb5ca6bf73e 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -823,11 +823,6 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
-static void alps_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
@@ -845,7 +840,6 @@ static struct hid_driver alps_driver = {
 	.name = "hid-alps",
 	.id_table		= alps_id,
 	.probe			= alps_probe,
-	.remove			= alps_remove,
 	.raw_event		= alps_raw_event,
 	.input_mapping		= alps_input_mapping,
 	.input_configured	= alps_input_configured,
-- 
2.53.0

