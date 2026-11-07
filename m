Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049191;
	b=WpEWnB4m8RYeE7JjaM9ncZ5oJZA20Mx2VgwJIWThvpPvtH15Wnsm6BylVSql1Eoo9Adg
	 HeVcCuFY4JmiwjtsrbBnRIQjKXOoBR+bJsshZF0+z8r0YJIISQLBIkvDtUk0Mp+/CyX3a
	 UbjYNdXQILSumC9fYRPlEDz97PaN4XfWJhBXlB5ptBTXKSyhx6HzRlhMQjzaDUn77ET1w
	 ERukhHseFq1LEFBtWgtP6bMjrvHgvP7ihfneOwKE/i/vDAC46pAk/zRjqBZNQBl/ym3pO
	 tNy56mpRTVPGe66LKrYqHwtQVRPXFYttq96DUWZcxEJmeA07gipjW7JSNSHvde1T8nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HPYn/pAIEJ0O2AohKb4ZCX7UVkgT8UylrDQqBtpWMCU=;
	b=gHd6YLmwaJ1cJ7Buu1QRXLXSvKof/9khumXd/p9fto9GEg/0185mcP8L9wZzqeD6B9hr
	 WftsRzxtCN/YrKOo5CS7jJaS/Kjsrz+T85n19nTag8sn24NhYfvUwZXN/qgZGQaPGyjki
	 CRHeuQK210+Rdk/xJkRUkQI745ipkDgfsYv2AC9iRHzW3isMvQTmxIG94zjkZLfw+VS0H
	 QAl1CJbtxHbrTuR0h8hA3LaqMxggTUXCR7uj14ebr77TGTkBuitf2YpnJDYUzUHrognro
	 Tz9gMkmYfP3zmCZhfLCj5AHey9x7QFoGSqWKVLlqIu1dodfy5hncfrRlBP5eU4Y8mVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M9br/qIb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3F606A339
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9br/qIb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637A31F0089F;
	Sat,  7 Nov 2026 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049190;
	bh=HPYn/pAIEJ0O2AohKb4ZCX7UVkgT8UylrDQqBtpWMCU=;
	h=From:To:Cc:Subject:Date;
	b=M9br/qIbAsAlJ+yxACqpvU9ZufzmVtNcIV1PL3wvFW9uG4Hv3rZGIDTSHzv7ar/Rg
	 0YoG+YhxRwIKloZJqEEoybloIxTcGYvh+BoX7hcOQZ/9hty2PZZ9azzPeHf+VNH2bW
	 NDPDzCZOHdvum23bmFKspN0xkEwAP9p2u36xucuFFAaH4a4cxuXmmReJFE7t8cbE0F
	 IHgTpRrEdmJumkkX/g/+95oOSJcu7yHixTU+PSDrNVS8M+daPvn3/783QaP/sk2yFr
	 MKhJWS5zZRbsOkKnF/Fbs9AG3QAtTKa12u9DphNz0Kbya7gqN6E6IS77vgBDhZzC2T
	 ue/rG4GqEFsLA==
From: Sasha Levin <sashal@kernel.org>
To: ruoyuw560@gmail.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: adv748x: Fix endpoint reference leaks on probe failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:49 -0500
Message-ID: <20261107055949-failed-5.15-359db09cf055@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 359db09cf055497075a668b192f4578a0ed00955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055949-failed-5.15-359db09cf055@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 359db09cf055497075a668b192f4578a0ed00955 Mon Sep 17 00:00:00 2001
From: Ruoyu Wang <ruoyuw560@gmail.com>
Date: Fri, 11 Sep 2026 09:56:40 +0800
Subject: [PATCH] media: adv748x: Fix endpoint reference leaks on probe failure

adv748x_parse_dt() takes an extra reference for every endpoint saved in
state->endpoints. If parsing later fails, adv748x_probe() skips
adv748x_dt_cleanup(), so the saved references remain held. A CSI-2 lane
parsing error also returns from for_each_endpoint_of_node() without
dropping the iterator's reference.

Save the endpoint reference only after lane parsing succeeds. Drop the
iterator reference before returning a lane parsing error and route all
parse failures through the endpoint cleanup path to release any saved
references. This retains the endpoints only for a successful probe.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 6a18865da8e3 ("media: i2c: adv748x: store number of CSI-2 lanes described in device tree")
Fixes: eccf442ce156 ("media: i2c: adv748x: Support probing a single output")
Cc: stable@vger.kernel.org
Suggested-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/i2c/adv748x/adv748x-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index 3eb6d5e8f0826..70594d0018048 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -675,9 +675,6 @@ static int adv748x_parse_dt(struct adv748x_state *state)
 			continue;
 		}
 
-		of_node_get(ep_np);
-		state->endpoints[ep.port] = ep_np;
-
 		/*
 		 * At least one input endpoint and one output endpoint shall
 		 * be defined.
@@ -689,8 +686,13 @@ static int adv748x_parse_dt(struct adv748x_state *state)
 
 		/* Store number of CSI-2 lanes used for TXA and TXB. */
 		ret = adv748x_parse_csi2_lanes(state, ep.port, ep_np);
-		if (ret)
+		if (ret) {
+			of_node_put(ep_np);
 			return ret;
+		}
+
+		of_node_get(ep_np);
+		state->endpoints[ep.port] = ep_np;
 	}
 
 	return in_found && out_found ? 0 : -ENODEV;
@@ -739,7 +741,7 @@ static int adv748x_probe(struct i2c_client *client)
 	ret = adv748x_parse_dt(state);
 	if (ret) {
 		adv_err(state, "Failed to parse device tree");
-		goto err_free_mutex;
+		goto err_cleanup_dt;
 	}
 
 	/* Configure IO Regmap region */
@@ -809,7 +811,6 @@ static int adv748x_probe(struct i2c_client *client)
 	adv748x_unregister_clients(state);
 err_cleanup_dt:
 	adv748x_dt_cleanup(state);
-err_free_mutex:
 	mutex_destroy(&state->mutex);
 
 	return ret;
-- 
2.53.0




