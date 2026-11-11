Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415545;
	b=NMu5CaHeoTZ0NPo3lbMtiM5PPKB4EcTG3i8eQ+mPXH0ARV/4nLKcYH/jx4i/WqH4r1GI
	 rS+k4ohi29p49g+p0GMLUWeeh+B3Uzx8IWQMPNjsr0R7jqg0pXzQlxBKkxeyBVe23ig6F
	 i3tK3Brheay8XVnJqnoZtizsTDZlEEhOdDrgjZKlk21hCOBJHZex3df2ZmG7kKkxU2D0q
	 LLR/Vakke8RDuI5ZVSzhy+Hreuf9O10/6xiv/aAu9LRDfllk4GQrsM3OcM1v7fd9NpnLZ
	 r/t53Ll0ztwBH0MtupZaxhYBEG0BRpfmSzi83TgvVum9FKtQ7fRgUrKz4WXnkYfHGxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mYHwXftYbkJsDgBHGvIYVUpJcxuYVbzq0v81NbV+HZk=;
	b=HGqiWZcFbFLO/Cvorir+i1uNGPLSFeMRzSyTvj18ojr/JTHr2Sqw8bRDyyfWEMQTzzA7
	 nAXONV0z4VFf9hf5ntmdwLzWQj230dS2bv7TqG4PlURqA99NjhruWZ32GoiK7DnNSXx13
	 PBB8ok0xcB+m4otGWSqKL2XW7TZHseAhktQI8b0iDvgsSpSHxBiQgHVLMmuZHeHqmgRIg
	 drvTK8YYdQsQbEhX38A5DRkOiyIUA+XZgr4TD2Q/stULO6JJYxAfRuOriB5umEHC60Rqe
	 hff/oQwcc4mu06jYqTs6q3LjS90oA7DyLEZ5sTqWMsdkejzEMaBhasJQe4M0UVDZc+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qy8fWg/N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573F606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qy8fWg/N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8031F00A06;
	Wed, 11 Nov 2026 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415545;
	bh=mYHwXftYbkJsDgBHGvIYVUpJcxuYVbzq0v81NbV+HZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qy8fWg/NNG7l52V+GgtSTc7bUPksgRvojWpg2Iu7KfYL3Sbs7fpYIOFlJnoK0PkZy
	 ePBdjpiFj3NE+PxVoYZZ07C8e8vUEwubcLzvTjViiXgUq3kCUJuLstdcBwItXekR3P
	 5GyCve9NTLcbLaOTBS2tvIeyuNonhGuhg6Q1kanSul1DdSrkB5VEadh8jThUCXWTPY
	 jJFhrKRu/esf8nX6JjVnlunDEAbgsJk62JjdpGFRGTlZNkKEh9aBNXnb+XanlDtERd
	 1NiYt+5hdyW66LySgiOX5cwNkhWeoU5IKnFlhKmM5q5DQzHPYOjWpjGXBAnDTONOXL
	 zr/9b5VEH2ZEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] nvme-auth: fail when the controller does not authenticate itself
Date: Wed, 11 Nov 2026 11:45:42 -0500
Message-ID: <20261111164516.3303260-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164516.3303260-1-sashal@kernel.org>
References: <20261107053428-failed-6.6-f9e43d924bc7@kernel.org>
 <20261111164516.3303260-1-sashal@kernel.org>
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

From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

[ Upstream commit f9e43d924bc74feeb56197de82b2845de2a4b85a ]

nvme_auth_process_dhchap_success1() returns success as soon as the
controller clears the rvalid flag in its DH-HMAC-CHAP success1 message,
without looking at whether the host had asked the controller to
authenticate.  A host configured with a controller secret sends a
challenge in its reply, computes the expected controller response, and
sets chap->bi_directional; if the controller then answers with
rvalid = 0 the response is never compared, the host still sends
success2, and the queue is marked as authenticated.

A malicious or man-in-the-middle controller therefore only has to clear
one flag to turn the configured bidirectional authentication into a
one-way one, without holding any secret of its own.  The target side
already treats the mirror image of this as fatal: when the host supplied
a challenge but no controller key is configured, nvmet_auth_success1()
fails the authentication rather than answering with rvalid = 0.

Refuse the connection if the controller returns no response although
bidirectional authentication was requested.  chap->bi_directional is the
right condition rather than ctrl->ctrl_key, because secure concatenation
sends a challenge only to derive the PSK and deliberately clears
bi_directional; a one-way setup without a controller secret keeps
returning success as before.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 6903c1a4e7692..03d05a71e6616 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -367,8 +367,21 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 nvme_auth_hmac_name(chap->hash_id),
 			 nvme_auth_dhgroup_name(chap->dhgroup_id));
 
-	if (!data->rvalid)
+	if (!data->rvalid) {
+		/*
+		 * The controller did not return a response.  If we asked it to
+		 * authenticate itself the session must not be used, otherwise
+		 * mutual authentication would silently degrade to one-way.
+		 */
+		if (chap->bi_directional) {
+			dev_warn(ctrl->device,
+				 "qid %d: controller did not authenticate\n",
+				 chap->qid);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+			return -ECONNREFUSED;
+		}
 		return 0;
+	}
 
 	/* Validate controller response */
 	if (crypto_memneq(chap->response, data->rval, data->hl)) {
-- 
2.53.0

