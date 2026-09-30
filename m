Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B536B90D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735665; cv=none; b=IYz3pnrZ2eUiPPv6l2nvYTut3KPu/qy8vMWupGv6LBjSJSsF4949d78oo4I9nk9sGCUTpDExkhjU43sBkmQ+jdniwZfhntdlr+VgNp3S7lLhgFba8jtJdWJiZli1kizdSdmCYH40nxRAM7NCHQcfN6ACdbBzflFDTTX4ES9BhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735665; c=relaxed/simple;
	bh=Cw/urw1AylpLE/HmOflDc8K+61IRGdaGVpoAO/a4P8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwEoIV0kOiWrgAVpgq3/tvUVwQji7m3j1mECL+q20sxQ/Kl3cyYRQBkXVYzV46pt8WgO/BUz3nwdZ9Q9XtxZOsWFjVj85PveLK0ANBYiMNSSSMPbQHojnD5krtvAK4D8GBJNbYdEU3AmXpr4t7vwNemFqRb0BvP1P0zXlmoxAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lif1iMtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lif1iMtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40961F0089F;
	Wed, 30 Sep 2026 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735650;
	bh=2wIYlIVFCRW/HwFZjfLl3Lptgf5jrcxXkxpcnwjKeF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lif1iMtbM577zgCqM4er9nzGHTGqoLw811xZMzgtocNm/yUTOEZDL5A/58CBN6l45
	 GIfiXhSGAcaGIh1i9fwQFKUd0vcFILVD4j8jql5GZsMiMhEjgUkXX8eAoSE06wgTIP
	 jpdSZ4vd4b9oO+CxOgVko1hq/yg/CZXt0GNt5cPyotxAjkknX1gZiMaxue+JQ2cSuS
	 p8iHPNM5ZR2BZbur3YMd9Owis5nrcDs3DLrwXw11H4G6pk98BHrmfH2Ykk0YKLWGra
	 URr/+mVt+C7vg96fxMV+hFQODN+gvt96eFdM7yRHjdIo4/wu1AdmUOLIOcVaJqxEL+
	 wGxUocCDXvgvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] HID: hid-alps: use default remove for hid device
Date: Tue, 29 Sep 2026 22:34:06 -0400
Message-ID: <20260930023408.3421577-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092958-confirm-underfed-6c0b@gregkh>
References: <2026092958-confirm-underfed-6c0b@gregkh>
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

