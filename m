Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433D436361
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752028; cv=none; b=HDafVYghEbQoTOYcY13gbWvGgRHGP1KVxipZdgZuNeSPvrCjJKfwXG1FhY0KjqeSprYrEGBVWHtMuzR85ywRCLukgmmAy0MCpK+CPqjLR26wx0mZ39FfRHnBr811HoxLmC2L+7+tzI6xAqpjxRy85W2seX9l7Hks8EOuyapthbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752028; c=relaxed/simple;
	bh=ztCja3qIh9gKMcH01OXsYgLG6gJ68vFAxym/SX4wQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZE9ttbZUwM2fluojxdcX6p/MZfGFDnUuKqf9pX+x+krZ7tNIDHr9chQlI+34oIUD0bs3zH+IoGlsQZ4rmzJwYthTVR3lc3uAOXb1cvEzbqL5vxlIpRcQpOCkF4641J1msMM5BID8X1dufhRtZoSfwadUAwcRTcvT7YoGd/Gg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELrTD+FX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELrTD+FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85311F00A3A;
	Wed, 26 Aug 2026 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752025;
	bh=knV9yxTvgn6N+elzgJGaqlj5AWID1SzRI3X6DG0C190=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELrTD+FXIvKtdDluVa+BmUz6GN0chdw6wdocZIaWPI8Pm29DGCHlA+J0cL//jNeQj
	 Zep/MeSetiUsvtPSXZ/vVsaBVDe66sCCi/qvkzxdDAsTWwSqwON/mdFNOgBbOpIUlT
	 QZ7UM3dRjVnrSGxZiPTpwDZZvz6hhIJThWAE82ERw0TDMkt+BQl5W7pR70PcEt0eSt
	 yuDAIfc9REiJeiX/zZgLYX3+sQ0LuK2Dn6NAb4mgiV0S7HHaUv5xwX1VInBXT9KC/M
	 CUf/t6cGRRCKTOxMq1BaQHI9BqBPvt0V0PGFKjdOOtd3YyD2eD5bN636gihwOlUS4g
	 F/WiOM6Bgwu6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] HID: magicmouse: do not keep a stale msc->input if no input is claimed
Date: Wed, 26 Aug 2026 09:47:02 -0400
Message-ID: <20260826134702.3959044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082503-contort-glorified-efe1@gregkh>
References: <2026082503-contort-glorified-efe1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jose Villaseñor Montfort <pepemontfort@gmail.com>

[ Upstream commit 0af3b89705688af01aa06025b84fa7a1e06ba6cc ]

magicmouse_input_mapping() caches the first hid_input's input_dev in
msc->input while the report descriptor is parsed, and the rest of the
driver treats a non-NULL msc->input as proof that an input device was
registered.

That does not hold on the hid-input error path. If hidinput_connect()
fails -- for instance because input_register_device() returns an error --
it unwinds through hidinput_disconnect(), which frees every input_dev it
created, including the one cached in msc->input.

The failure does not abort the probe. hid_connect() only skips the claim:

	if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
				connect_mask & HID_CONNECT_HIDINPUT_FORCE))
		hdev->claimed |= HID_CLAIMED_INPUT;

and the "device has no listeners" bailout below it does not fire for this
driver, which sets ->raw_event; on the USB Magic Mouse 2 / Magic Trackpad
2 paths hidraw and hiddev are claimed as well. hid_hw_start() therefore
returns 0 and magicmouse_probe() continues with msc->input pointing at
freed memory. Being non-NULL, it passes the "input not registered" check
in probe and the NULL checks in ->raw_event and ->event, so the next
input report dereferences freed memory.

Clear msc->input when the HID core did not claim an input device, so the
existing NULL checks cover this case as well.

Fixes: f1a9a149abc8 ("HID: magicmouse: fix race between input_register() and probe()")
Link: https://lore.kernel.org/linux-input/20260728185542.65F091F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
Reviewed-by: Alec Hall <signshop.alec@gmail.com>
Tested-by: Alec Hall <signshop.alec@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index afde78319b996..e39e32680feee 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -627,6 +627,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
+	/*
+	 * When hidinput_connect() fails it frees every input device it
+	 * created, but that does not fail hid_hw_start(): the core simply
+	 * does not claim an input. msc->input, cached in ->input_mapping
+	 * while the report descriptor was parsed, would then be a dangling
+	 * pointer that passes every NULL check. Trust the core's claim.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		msc->input = NULL;
+
 	if (!msc->input) {
 		hid_err(hdev, "magicmouse input not registered\n");
 		ret = -ENOMEM;
-- 
2.53.0

