Received: from mta0.migadu.com (out-242.mta0.migadu.com [91.218.175.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F464302FC
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240617; cv=none; b=eGDIVFgdsNcIoIfOVBS4OjvLKWiOcvhBnuIutNColmgqZBNIa0EMvyr/htHqg3jHbg495aUeYQw58Mq2QPI0yIDkOtxYcO/05MwLFdw4+OBIJOV+NzyzUK2rfx10rxe2Y0PzjpQW0QVXyIY6WjcGePNpK5G8g/6HDkTZGVhSazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240617; c=relaxed/simple;
	bh=4zWi4SS9GGmWv54W/CgvN7ukLy9avKj8s60KReUEOoU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=uixVmIxnl6YbfrB31QLfmc1xC+BLRuTK8SJ+uc+LFGdpspuQfVI+J5LZrmqULjDgnUxfMO+5beIAzNPl1mA2BZw2vFk7LH1NsinXwBAwxhdKKo1WMGYWX4UX6Wipn4bdqiGymN2uU1jd2d/q6Z7dPpe91xmN4AcD4KnAO7kxwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aF0oN3Bd; arc=none smtp.client-ip=91.218.175.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aF0oN3Bd"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4zWi4SS9GGmWv54W/CgvN7ukLy9avKj8s60KReUEOoU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790240612; v=1; x=1790845412;
 b=aF0oN3BdKNRXDZ6GnFdXp3D5OYJY4HB5DDtfsxzvGV/7n+qFa/GmGlKYATkp4hC3vOcsubDV
 4VojAfCyHjWq8WELuzFWK29v/A5hLMOcwywPSQfx+HyBWfpBrO5Yt6ln4IoGnTT4fGp3lOSC/DQ
 tdu1ijmlGhVJGellI8x/wrjM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ada7dab963a9372c;
	Thu, 24 Sep 2026 09:03:32 +0000
X-Mizu-Trace-ID: ada7dab963a9372c
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 09:03:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <969ee752d023e7431481605c320fa0636cc6f20c@linux.dev>
TLS-Required: No
Subject: [PATCH] wifi: cw1200: fix link_id_db OOB access via
 device-controlled link ID
To: linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org

From: Tianchu Chen <flynnnchen@tencent.com>

cw1200_rx_cb() stores the link ID from the device-supplied WSM
header (a 4-bit field, range 0-15) into priv->action_linkid for P2P
public action frames without an upper bound check.  The work handler
cw1200_link_id_reset() then uses it to index link_id_db[], which has
only CW1200_MAX_STA_IN_AP_MODE (5) entries, so a device reporting a
link ID of 6-15 makes the driver read and write cw1200_common fields
past the array (a status copy and a constant store onto adjacent
work/lock/timer fields), corrupting driver state.

The first link ID check in the same function (used for timestamp
tracking) already validates against CW1200_MAX_STA_IN_AP_MODE and
degrades out-of-range IDs to untracked handling, so out-of-range
link IDs on the RX path are anticipated; the P2P remap branch was
missed.

Add the same bound to the remap branch.  This is expected to keep
driver behavior unchanged in most cases: the driver itself only
assigns link IDs 1..5, and a P2P public action frame carrying any
other ID now degrades to the same untracked handling the first
branch already applies, instead of corrupting memory.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLA=
N chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/net/wireless/st/cw1200/txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless=
/st/cw1200/txrx.c
index e13695667a00b..33b02e562b79e 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1050,7 +1050,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 		schedule_work(&priv->linkid_reset_work);
 	}
=20
-=09if (link_id && p2p &&
+	if (link_id && link_id <=3D CW1200_MAX_STA_IN_AP_MODE && p2p &&
 	    ieee80211_is_action(frame->frame_control) &&
 	    (mgmt->u.action.category =3D=3D WLAN_CATEGORY_PUBLIC)) {
 		/* Link ID already exists for the ACTION frame.
--=20
2.51.0
