Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048164;
	b=FtyLxEgdaA2OwX1mPPoUwNPs7Fqpu6d/OJIuCqdAiBfikzwK6wPr0KpwH8TRwgZtPO5M
	 1SnQEWYM2dVV4maEZLJSktu0nUfwLRUZ9EW0yiF8R83KKg3uZb49BybVopBdAVl9oryTW
	 i7lV2chLIfDSMarFVj8lvYs9iROKZS4Rp3gyDBBLwQFprg4GY8VNHBaBWFfhl1UewHb3A
	 NbM3nUwHeGxyyAHkF3YRa2OwDMgwWuTbXQpWHsAZLNaNlihuOgVudcfA3sk446bI40Xi3
	 KNO0o0hU0wVpiLwLeJECvR36t/GYSw70RD6xYChNIO/hn0/6EKTamRN/JnufAOT8rXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048164;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/8FizENaIlICH5bhKVFVX05JLSzWxvmTad05r4D/+oc=;
	b=dJRamT+0vggKAq+2HeiGU/c/hgMFxkJm4nTx4zA+LMlYyZZXKXowt3PdSqeXS/HkPlwM
	 3aseejE4s/xriX1HRht21oh3cjHR8fZs28uelp9AIwWlh15bUxodSFJYDKWtML/E89tsC
	 M2TMSIGzv+JN5s6P5Uny6tonwUPnD40gksfRNNRGf3s+Vja7Sy5pIxpoZW6tuVW+W42n/
	 OkOflU8+Y0Ah4IUd/XGbc69KK+ZziHDXthAV0wRxf1ZhrfWs7mf2uB/9OWkTc/YoGe3Ax
	 cZOaDrYVQUUymAAUv2who2LVy89+zNhJ/pI6/vgsRMgQZEkd0/fDMBhNAHjmonqrNUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SV/8d8hD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SV/8d8hD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD01F0089F;
	Sat,  7 Nov 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048163;
	bh=/8FizENaIlICH5bhKVFVX05JLSzWxvmTad05r4D/+oc=;
	h=From:To:Cc:Subject:Date;
	b=SV/8d8hDwWGw6rHydztEz3NkzoqmDpi7KNoUlUORLYJiTV6dbvh0s7bMIjRyd5zCL
	 1G7QBcBM69sSUv4cs+Tok5NTmhpXYJpLKyh+zR/r+VL29xuMPIaUVF0ErlKDRw+ZJJ
	 OfLJndYres9F2srrJQY0vGVDbN9J7alquLBsoVLlIlk5kdrIM+xiBb2TwOOTdHutdW
	 TlHgXaRp4uR1WSQ7IdtOZEAkxBK6LAr3Fr+w9Jv/RLTQh9ojpxmGaJxRDuR5vdNHcK
	 1aeTuqIS064i1NskizEZcxo0sSbr3MWO9IeJeH3uUrPYoP5PArAeI4HUd2xYYM79Ff
	 Q7sLSnRQRqt7A==
From: Sasha Levin <sashal@kernel.org>
To: ruoyuw560@gmail.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: adv748x: Fix endpoint reference leaks on probe failure" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:42 -0500
Message-ID: <20261107054242-failed-6.1-359db09cf055@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 359db09cf055497075a668b192f4578a0ed00955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054242-failed-6.1-359db09cf055@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




