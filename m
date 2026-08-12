Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581B46C82B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545975; cv=none; b=BrZ7zJZpQ0rpWaEAhhXC2b+OPj5lLNYytX7n4b/KtH3uCSp4SbZtT5/NR6P8DHpOW75A4om9kXpk4izsVQKt2KGFL+31BoJWqzE+r3SI0vNBeXVa5VgUlNHduTESvqCGDrE2KFv0RBZ6lNCQyJCXcRATIalkEQtuCLtfv3fqPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545975; c=relaxed/simple;
	bh=VE6/4+wtxNi0ZPDi4uacK+Q/OM0pxFhuOwyVobM559M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHQm5hLGVyyA932/in2dMKM7XbYI40KyglBT5k27YDkFaCwIep1C3KszepU6lh7Vrl4olncxoen561FntG1lmNLSrpCD5kP6mEoBSXJwuM2RJb4LQum+zq345tBCxP2bgqPeFZDyKqnkGt9jCulynXS2OLBOlKJh0UEvA6tbAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnVRYNaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnVRYNaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC55C1F000E9;
	Wed, 12 Aug 2026 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786545974;
	bh=+o0SZvBsZ5E8WyaX5/T5lAd8Afx9FKi1nxoIVtukCio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnVRYNaEVbUTNQu+WuPEWG8DCTEDnK238sDzp1WMy0EgD0nDF0JVD+r3T0+COu6bc
	 uXduKnsN6yK+qcxlH8WkhkzPjpLoA4pw11QEtn95uc+EVq247sAkrzd5iXslM9of0s
	 xT4O34Wz4vXmi8/jyBG2aal583AfWfgHZ1teP89aSQZGwr0Sx2cU+YoB6iRC7k6Jnh
	 x9oFc8FFZHbrwcw+um3qvnxZl9CykXr9R9O3R05xWveA4eXm1d3bVBF5nKfNgSyWlt
	 eGethBImhCKyFAq7gXdiE1e2Xzi7WZBZ1lxGiMU4OIJtTBf814jTDUU0sR6GzdMlgN
	 rzhtddXlCyRLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure
Date: Wed, 12 Aug 2026 10:46:11 -0400
Message-ID: <20260812144611.2226489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-remold-hacking-bd71@gregkh>
References: <2026080559-remold-hacking-bd71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 68c5724ecd159992f76edb7b57dc508a44c8b7da ]

If the allocation of the SKB in gs_usb_receive_bulk_callback() fails, the
driver returns from the callback without resubmitting the URB in order to
receive further USB in URBs.

This results in a silent performance degradation which, if it occurs
repeatedly, results in starvation of USB in traffic.

Instead of returning immediately, try to resend the URB. If this also
fails, this is logged as an info message.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Link: https://patch.msgid.link/20260709-gs_usb-resubmit-urb-v1-1-4dd40030cc84@pengutronix.de
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ce5676845f284..87322bbd13253 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -332,7 +332,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == -1) { /* normal rx */
 		skb = alloc_can_skb(dev->netdev, &cf);
 		if (!skb)
-			return;
+			goto resubmit_urb;
 
 		cf->can_id = le32_to_cpu(hf->can_id);
 
-- 
2.53.0

