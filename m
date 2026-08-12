Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BD31A065
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541132; cv=none; b=okQ3Xu7OeGBroNGKh0FHGYtu00bKiw/L0Be1TjneubigUiFgZYy99/P28Ef9KtzTqjqnyxixSxPM1kpqAJtUcHlZ09qtXqW3hKCyZsY7srwI86H+T+eMgIDtqna/r0D0sVOpiHVdOucJmsb698DccnisaqyEODjHbeNUbZENpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541132; c=relaxed/simple;
	bh=jDQP9b1+ybTqBftBHGRbPmRkHk4Vm8XRYXPSIhjZejM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raOGvjvOiSS+d+SXCWofHMkEbGgF4GrnJsFfzSkJgxTydpE529VQqXUIcFm9AqW1W1o5hYNlpGNLeltkjlqwKMbVxp9ECH31AuPDedkO5voFA3Npl3P23gJwtZgtKTusrrpkOFZ5a2yW/jVNPM551S70zj9gqVrMMuNwTGiHn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN+zstyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN+zstyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6861F000E9;
	Wed, 12 Aug 2026 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541131;
	bh=Hu5tqW7z0aH4sEB5gcnrfyJqNr5bsOqi6dvTU04H/Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZN+zstylDR56OzYFbglXNa1OE7bCtAY5wYTtVcTWfhpETU2/TWpNrACvY4JWFjdV6
	 VyBQMQ6AXuMKZHArfjxam0b/TWzt9giFFju/5HA3h8QGzSwXr+9Z3bUwSGt1TIj4Q4
	 XVBNCGxpxNbz5LSjze+5MdcE6hCITPAujD0P56Y2NH/CXz4xj1rf9GUS5KyRI5xXAp
	 VPdXa6oY2RBw2V9Ff8eIwJmXT6H/PncAxE56gjsGiHRDm7hYF2zxNxKCb4mWbBLwsW
	 +0XbOYyEoVB4pW6l2Jca2vMggXxvv0T+wEFe2u0iZUGutlkQ9Bc/vmTjo7DhQMJd7k
	 FJ2Skz/Wvhraw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure
Date: Wed, 12 Aug 2026 09:25:28 -0400
Message-ID: <20260812132528.2185590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-surround-premium-b764@gregkh>
References: <2026080559-surround-premium-b764@gregkh>
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
index 17bf4cae7b2d1..eb4a209ba1363 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -333,7 +333,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == -1) { /* normal rx */
 		skb = alloc_can_skb(dev->netdev, &cf);
 		if (!skb)
-			return;
+			goto resubmit_urb;
 
 		cf->can_id = le32_to_cpu(hf->can_id);
 
-- 
2.53.0

