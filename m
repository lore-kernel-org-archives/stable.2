Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415614;
	b=4XvRPp+BpO9SVlXFHVDjQcxklka0orvLVyakKeaRLMmq1oskHojrjA/kJA9APdOFLp08
	 y+uyrKuYh2HavgExMWxoUu44FSSvjnky2nAclBoR8EIVAlP1C5xvmCw0nY15tywQgpqc8
	 VeTWq9J7S0s08958tOQDgzQF/mXVB+O2ahTj0zARMgl3tly7PKysUcZ6dq6x1wrGoiUil
	 syibFA6zF8Jau9Gzi4UtqROtP6zxBzFI+AuW6wnPZ15UFPeA5ZnF8Rj9Gc9LemUdMcGQa
	 KunsLNsb2aFB31bYlJDuiQhdLx51f57FkKeb5JmRgyaEsda7oxxW/vkQHloiLq0LATQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XIcwCQ6rFgjGDhkQ2dSkFu407opQAQ0iOtmYLdaiic8=;
	b=b2Shr1jYSyclF3eKsg0558GZZx/6iYIEg0eHn8xrOrUEfF0u9uJfPCyoUwimnw+uwWRk
	 pvz71ap3bvH0RweoW2A6FK6BAFH8v1b9nLiQa791vaNuHauqg3IFB9Hw4Yg7ns3t/YD/l
	 COH1aLwTqQYIcok+7P+v8b43iFSjLmfDpbfppnL8bimpGBpz8Jjz6JkNuuU3PVdcAkWj3
	 +3ARoBfdOBj9TWpErGCeWsHPgMPDZM+wYizsn0v40gsxnT5VG1hMqirGJw+zt3IedPql+
	 jzfODJQC+WmfZpQm/r+nYpciyPGCMIpc5gXc8SMvs7Fn9ype1yo3DKLG4xTIEmvhawQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/EtOMUy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/EtOMUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4753F1F00A06;
	Wed, 11 Nov 2026 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415613;
	bh=XIcwCQ6rFgjGDhkQ2dSkFu407opQAQ0iOtmYLdaiic8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K/EtOMUy91UsAtp4Ia6xZscmede9hBK0PRYhvWsDPGoCMGAK11Zbdi8u1GS2BzU0G
	 I1Gskli/Pc2D+yJwhoSJhCXaBNR8FgP6/lkLQOh6UeSqRGJi1V71RMp5yPf8lW3JkA
	 fXblRSgADi2cbDMZuj2iQkfsweifXS9YP8BFkZrb5+a4DlNw0vKKgNfq2dtclHD2Nt
	 cRtr2OljOHEoMXKjh2aor5cSnUMFupG8M4pEq8IdraYigi0oYSPPa2eEB0wRAnaUuV
	 w1ms0ayaDzCrBt/Q9OY2zrGuoHqCurMDDzcR08HwTMXdjf3UOSLt9gdG3h09jLQzcd
	 w6whbghxDLaDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] nvme-auth: fail when the controller does not authenticate itself
Date: Wed, 11 Nov 2026 11:46:49 -0500
Message-ID: <20261111164614.3321142-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164614.3321142-1-sashal@kernel.org>
References: <20261107054808-failed-6.1-f9e43d924bc7@kernel.org>
 <20261111164614.3321142-1-sashal@kernel.org>
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
index 5bac8a34a9a43..a6dd41057737e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -369,8 +369,21 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
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
 	if (memcmp(chap->response, data->rval, data->hl)) {
-- 
2.53.0

