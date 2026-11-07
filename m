Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046034;
	b=pH5ZTHCXs6r48uipCocoeSRPncRkYSXB6Br4W4473YCLm+04rKX55SLHg531g3RGYeE+
	 yVBplP6J/X4xv2wGmTOflOHZnRDBI90CC1ruMya7hVGForwyVgelJ9gORlLMOp1hREe2g
	 9eM7mzOqRrYlkrp7GuKiq2M7zuKb3896jZJK10rOFl/XgJ3k3RQcWxnvjwTCi/IvuyZda
	 YqC8bE+8LC8MjjVmNuFY0DVcDmebbKyLKwi++pUYfhNpVCRUzyPoB49c5UmCpgzvHJvxJ
	 Ot5MOfpjQMW4vnCdCpbWG6h2o26CRlAvqWw0Tu5J84dJrlzx7rUrAT6WaBfwGkgvV/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CDmBRsehVDAA39SKA4G2gr6AVQd38yME0jNdLO29WwE=;
	b=sJTINOn5Ftu1WfOEiyaT7NAR8mnJ4suAbzWiz5oD64QIHsaTpl3PwmVUBFV9pCJnNE8e
	 4PwEeCaPwkWqaNk1zncZI5Dg124HIX+fK7rhRkuJvYYZewI3tz5ufNe46Y12QFRbeFo2r
	 235Izf5vIOUsUG9JyVnPLu2BPHFKkmRt3f1AaW0LT05ls/+d+ZCmYosSlC6QmlEAJLAhV
	 YC4Ov5/gDJ5ad/xQyZVO1I0g+KZOaJ/yARa/WEghVTPKe1xWZhU8p3N5XaLyWYhdFG8dc
	 zvBYBeYlgEC8PjD5ia7N9NmiJIrGsda+fcF9CDB+QyZ6c2mWLERGix9WIbbHM5Skcpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXRcvDkf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F457606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXRcvDkf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF68A1F0089F;
	Sat,  7 Nov 2026 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046034;
	bh=CDmBRsehVDAA39SKA4G2gr6AVQd38yME0jNdLO29WwE=;
	h=From:To:Cc:Subject:Date;
	b=cXRcvDkfkZVevetmpZesIZBe1l6BnjDJawkvUMN8N95ANH3mRvFJozYQz8SOZCxv8
	 q41ipB5emHDrgFvwX0FX5H2/mHXhbr1bxBA5z84eWhyHSMNfbd/bXuobgtdhDVC02X
	 YPaxw8Fs66d9sf4fouPcJPSrTTD5UDew+ZcVdwF+SWizuvpWztKfDOy5hM2DCRHvKf
	 uq0aAPE9CWJncdaiCSMqiEthoOEx551bJHWujwUYfpvW0+ykl0d7040h2/4eri7mUy
	 UPF7pb6BublPSH0T6/wtQC52ccXv3laC4yrRNFXYhWLgfJ8cSwL202h5/8WctLFnhh
	 GAkUxM3acKTow==
From: Sasha Levin <sashal@kernel.org>
To: ruoyuw560@gmail.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: adv748x: Fix endpoint reference leaks on probe failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:12 -0500
Message-ID: <20261107050712-failed-6.18-359db09cf055@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 359db09cf055497075a668b192f4578a0ed00955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050712-failed-6.18-359db09cf055@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




