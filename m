Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047670;
	b=P5l4gpH2XCnhcGNTYoDjdCHykdasb4e85Hm3VjAGWsGgENgmrxvZpOA5YAYnJ6lDVIM6
	 P2utEijlGfgToquAldgDrzxl8H7zGanytK68HkcB6hNe3tV4AsV/WAR+K7x11Vk95M+VM
	 yxcwKjSOPPHjQ7ZDTexWvzn+jBNZIwnNoqnYWgsZZRpuXrOHPgH1xiEHGL5sO30vPnDUm
	 FHElPnrPfT3VtvvSAf9sF9rxHTdOcGNLWaGtqelv4S+21wO86HU8onhV3PwiZgulhuN6G
	 ZjMvpuJQylRgtGcfvN33cQTFOvEBTDZdrLQ+SkK0jeAhdqD7qeKZQb7UIXRtqQOaAPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5iytAk5ulRT5v+JCYVCmaYx/8wuopglsqPMzbuHPF1Y=;
	b=Kh6igZQf2WJZDwBN1TDf8/Prrj9nNKYTAB959WGwlNt0WNJdqp/b0HMHfi9VL3Lpxsn8
	 cOVeUS6dizGtd21cTtI9O7U9CB4yHUeOuFVbCmJm0KMEnTD27ZvnGFJ537SZ5QaD3P6oh
	 9dAzK8G2kbT6SnstLKUKjz1U7aciT05Tf1IRHojAEqd3TcfFEydUoqN/c+4wcZ3zMgLQW
	 Asch20F9asyGP2uSY3HdxRrs2yLYMaLXxZ3IilG8GOupzSO4wO+XFHWatA7SjYN2icoO5
	 uABG/7Sc+tempP7uhIuvm1+IBriwXDDpv4dF0vU5oYWJac71wF4KAZ0EuTijAOr0nDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnZLdir0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnZLdir0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4B61F0089F;
	Sat,  7 Nov 2026 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047669;
	bh=5iytAk5ulRT5v+JCYVCmaYx/8wuopglsqPMzbuHPF1Y=;
	h=From:To:Cc:Subject:Date;
	b=dnZLdir07qKDXdMrLuMbCdKPXZA0gfRaCsJHiuzCBhJpa0uj5FryfzIG8iVJI3G8g
	 TZZ1baMIrxWekYF6nRg3xtiWFdAsOp+e+Wiz9nL7ivzRjTArtBVpbJtWU9Tu52RBTq
	 EE+JhQ/M40URs9ogx55OHJLZVYMwEbaXYmAGR+Grn9kTRDvOlu/dpqmnD7cPjJec8o
	 yM1elKJR8bVphZ36u6q9OP5mIfHlPFiQLak1yihALjSe2E5itf6qTdvIntp2n+ND60
	 Wg1zIqWCclBwleDE9MBg23ohCCZnhaXcmzEY5/oOe9Qw4dB+bW0wdIZ206CWzvNZO1
	 QpwKcpfp/SkJw==
From: Sasha Levin <sashal@kernel.org>
To: yhlee@isslab.korea.ac.kr,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme-auth: fail when the controller does not authenticate itself" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:28 -0500
Message-ID: <20261107053428-failed-6.6-f9e43d924bc7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f9e43d924bc74feeb56197de82b2845de2a4b85a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053428-failed-6.6-f9e43d924bc7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f9e43d924bc74feeb56197de82b2845de2a4b85a Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Tue, 6 Oct 2026 22:48:05 +0900
Subject: [PATCH] nvme-auth: fail when the controller does not authenticate
 itself

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
---
 drivers/nvme/host/auth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e55920642f2c1..cbb38935fa227 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -358,8 +358,21 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
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




