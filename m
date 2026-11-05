Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837789;
	b=rhdaUDSmJssKgFiZWsizml60QqMBk8QNVa4fRvI/sdjV4qjTOIeTwI9Ek1LdgISmHh0s
	 0SAqq3TKP1JcAQSubHfneuG1sfjPOqijafhYyj5j6EOGIwoLVZWsaR9U7gwbslQd61KRY
	 NkvkVwwSFI/QY1+Rof6IyjxRKFX/gGLw/4gK5AhWrYHy3cPE0PiM0Z0hFBQQQPeDZrWf2
	 R858fz3jgzm05b+Uqs2MUJqJgs9JLrblYkZWdfKNcisfGZsJ7cNSiYt+DzzVgxiUhDmSz
	 GhbWEEIFq/UYNQNNNGXjE9nNb7U97MO+jb7CTlcS8DreLt1En631BEqMT8FBgP/jYtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837789;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NTIdioslX0EozhiQe8usqpJ7oOMuux2Ok0kV7z1tdeQ=;
	b=5QOIowhsWqA7Mv4Z7Reyzg2Cu4RIxtn943GmfK6oEudH/b0vocC/FIMzA2rC52PB5MBK
	 4kuOOEp2W2blyCtC7AtnaLKWuNsC2lQe3t2Sp+lNvpRci7k8qc85n/gxluqGpQKpCQOsT
	 33hD+9I68Bp7fJS+91DkNJuD3N7qzltY9vxUnMD0MTpxtkXh31rjYto8JwyvctckaJUDp
	 6Rc5414N7hZrWinGRnaLJO2fbeaCMGAKG0AL+kHdQpALaNBcg8ZAss67wyCJ5KHgPwDyj
	 OrwE2c1McqAdFqOH1tlpDb4BVAysKs7pjqWsP8f4A93RSLWlK4g0clm7avjiiVeHAXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPaKDSXc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82315606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPaKDSXc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D441F000C1;
	Thu,  5 Nov 2026 00:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837789;
	bh=NTIdioslX0EozhiQe8usqpJ7oOMuux2Ok0kV7z1tdeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPaKDSXcMqTqNHfZvbhXqFTNzkzTnSEcVOaVOCXvVfxFptNuyAVsbDzdvaPQ2ovK0
	 b232ZyEOwEsJzqbW4mFvxJeseNoOgDvViorOX7j4TF11xqjIZR2cwxYAz/8tzOEoUf
	 sVKs/AalfVj0F6oMWWj4UhcKaHTE6ya09yR4kfFtOJ0tqj5zMcTVmiKuQZf1DTsTfL
	 UlMCJzgYO+74WaFj4ZfTyo4nbuLcsWRVVoGuVdhGnP+XhqZ6spNdCZrHL+qVwNh9Cs
	 9WC4zZEdlM49NxxKziEHfhFMOHsomZcu+82SCdIbqqRffdWFj0KnvNnnsyrgLKFSAk
	 zgbuI7VvUtSDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: microchip-isc: take a reference on the parsed endpoints
Date: Wed,  4 Nov 2026 19:16:27 -0500
Message-ID: <20261105001600.927668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-mummy-online-37cb@gregkh>
References: <2026110457-mummy-online-37cb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit f2eb2fd388bf3f1959556a326e797cacca341c86 ]

for_each_endpoint_of_node() drops the reference on the current node as
it advances. xisc_parse_dt() and isc_parse_dt() store the node in
subdev_entity->epn and release it later with of_node_put(), but never
took their own reference, so the stored pointer refers to an
already-released node. This underflows the refcount and can
use-after-free, reachable through the camera device tree overlay.

Take a reference with of_node_get() when storing the node, and drop it
in microchip_isc_subdev_cleanup() so the entities the bind loop never
reaches on an early exit do not leak it.

Fixes: c9aa973884a1 ("media: atmel: atmel-isc: add microchip-xisc driver")
Fixes: d6701f13bd07 ("media: atmel: Use v4l2_async_notifier_add_fwnode_remote_subdev")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adapted error cleanup to existing explicit endpoint loops using break exits instead of goto err_cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c    | 6 ++++++
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 5 ++++-
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 5 ++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index f768be3c40595..eeaf91d80acd7 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -2219,6 +2219,12 @@ void isc_subdev_cleanup(struct isc_device *isc)
 	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
 		v4l2_async_notifier_unregister(&subdev_entity->notifier);
 		v4l2_async_notifier_cleanup(&subdev_entity->notifier);
+		/*
+		 * Release the endpoint reference taken while parsing. It is
+		 * NULL for entities the bind loop already consumed, so this
+		 * only drops the ones left over on an early exit.
+		 */
+		of_node_put(subdev_entity->epn);
 	}
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 7421bc51709c4..cf96d40828ab5 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -354,7 +354,7 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 			ret = -ENOMEM;
 			break;
 		}
-		subdev_entity->epn = epn;
+		subdev_entity->epn = of_node_get(epn);
 
 		flags = v4l2_epn.bus.parallel.flags;
 
@@ -375,6 +375,9 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 	of_node_put(epn);
 
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+
 	return ret;
 }
 
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index a4defc30cf412..3183ab2345c8b 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -344,7 +344,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 			ret = -ENOMEM;
 			break;
 		}
-		subdev_entity->epn = epn;
+		subdev_entity->epn = of_node_get(epn);
 
 		flags = v4l2_epn.bus.parallel.flags;
 
@@ -368,6 +368,9 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 	of_node_put(epn);
 
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+
 	return ret;
 }
 
-- 
2.53.0

