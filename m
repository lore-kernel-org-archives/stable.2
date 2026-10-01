Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115035A38C;
	Thu,  1 Oct 2026 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820995; cv=none; b=Jy90DQQQ42xF97Z+xcM36Hdr3EToYHhYEmsoa+TLGWPo3bO4X8SOpwCCaQU2FGqVTtY13roTzTYZy9vKGqkpUNBIJAO1T8INYugsS/Dyc/F8YAdY6+b0tek0Ep8vNBIX3WeootefnaiJ0iVmuNCAyagLmvhXBZ7WLaXGCfN8IMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820995; c=relaxed/simple;
	bh=KgHMBYu/wBnHRRfL66hCBCt8gdwfkcxVNGW+zQ7v4F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iI8sA69YS2D3o3LJQ4TcsKKxwmBZLJrvaxRzaRRXGcRyWsssV5OLRIV5w1moUddZQ1pP5vUn4Uvv82bRdE4edjqyx0YPNxejD49LmXW0HVZZNQV2tRVG2JFzXPzcFTnqecNh83I7CBR8pUeDInVJuIhnNTGwowTNOG8nQbRtnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f48PeRUH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f48PeRUH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34830C4AF0B;
	Thu,  1 Oct 2026 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790820995;
	bh=KgHMBYu/wBnHRRfL66hCBCt8gdwfkcxVNGW+zQ7v4F8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=f48PeRUHTkp13keQYqPIJyIk0rWMHhXpSwQaI+rQA5+dRjpXxpn8UQWnmhUTwd5qR
	 EVX8xJcCC9O3MzxESpf8jOJhxY6gQc8hu4lZtNdRN30lwNTkRJiL7gGGaon2yMlljh
	 T5i4erzL2bdagjnuc4cDtKW/Uvv/C3HRbbEodJhIY/hV6D+GrmFyvCsoYJvpiFVMIi
	 VpMXyrNOtq8o1RHDSHl2JHohfIYvVabIHy/5bsql6DIdZp6i2h2QqOTK5A6Gkosd72
	 QRiUgYir55rade4FwNKjiwRFgGB449QiQNDB9PqI3goiBmZGKUMK45Px3045s+JgK5
	 ue9EqPXFFu30w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE8ACA5FC4;
	Thu,  1 Oct 2026 02:16:35 +0000 (UTC)
From: David Medina via B4 Relay <devnull+b2amedina.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 22:16:35 -0400
Subject: [PATCH] thunderbolt: Fix domain reference leak on DPRX work cancel
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-tb-dprx-fix-v1-1-da92659e491a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWZukbnV5FbHQdjAWSItIpO+uW
 H4nOf8NjiyTgya6wdLJjtclIIkj0FO/jIRsgiEVqRR1JnBXaDZ74cAX1loUJlNVlZcSwmOzFOa
 v1na/3aFm0vubAO8fECnXpG8AAAA=
X-Change-ID: 20260930-tb-dprx-fix-9c05d3b88476
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, David Medina <b2amedina@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790820994; l=2131;
 i=b2amedina@gmail.com; s=20261001; h=from:subject:message-id;
 bh=N8/YAAUcHuskyY/Gie1TL1XIy2476JrAqEJaOFmRRrU=;
 b=TCRFKCeg5ofWVYbk5OpAhIrcYrd5MK+qE+Z9h/7mQ9IZUVN9fq16lRw8CHqJDntHt+Df2S0yl
 Hey3r9Xz7eGBsuuCJvSzBd6qEVbXHzakZ5ak+V1YrqXboinMlHvP7OT
X-Developer-Key: i=b2amedina@gmail.com; a=ed25519;
 pk=6kajg3wsf4T4/+F2W+hj7g5W4lTch1OgfXS+6o1FsFY=
X-Endpoint-Received: by B4 Relay for b2amedina@gmail.com/20261001 with
 auth_id=1091
X-Original-From: David Medina <b2amedina@gmail.com>
Reply-To: b2amedina@gmail.com

From: David Medina <b2amedina@gmail.com>

tb_dp_dprx_start() takes an additional reference to the domain with
tb_domain_get() and passes it as callback_data to tb_tunnel_alloc_dp().
That reference is only released by the callback, tb_dp_tunnel_active(),
which tb_dp_dprx_work() invokes once the DPRX capabilities read completes
or times out.

If the tunnel is deactivated before the DPRX work runs to completion,
tb_dp_dprx_stop() cancels the still pending work. The callback is then
never called and the domain reference held in callback_data leaks. The
domain's reference count never reaches zero, so tb_domain_release() never
runs and a subsequent shutdown/reboot hangs waiting for the domain to be
released.

Release the callback_data domain reference in tb_dp_dprx_stop() when the
DPRX work is canceled, mirroring the release done by the callback.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: David Medina <b2amedina@gmail.com>
---
 drivers/thunderbolt/tunnel.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 7e8284575dff..971e9a5f8c5c 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1139,8 +1139,18 @@ static void tb_dp_dprx_stop(struct tb_tunnel *tunnel)
 	if (tunnel->dprx_started) {
 		tunnel->dprx_started = false;
 		tunnel->dprx_canceled = true;
-		if (cancel_delayed_work(&tunnel->dprx_work))
+		if (cancel_delayed_work(&tunnel->dprx_work)) {
+			/*
+			 * The DPRX work was canceled before it ran to
+			 * completion, so the callback (tb_dp_tunnel_active)
+			 * never got a chance to release the domain reference
+			 * passed in callback_data. Release it here to keep the
+			 * reference balanced.
+			 */
+			if (tunnel->callback_data)
+				tb_domain_put(tunnel->callback_data);
 			tb_tunnel_put(tunnel);
+		}
 	}
 }
 

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260930-tb-dprx-fix-9c05d3b88476

Best regards,
--  
David Medina <b2amedina@gmail.com>


