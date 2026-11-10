Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273401;
	b=b+bXY3JUimwVAPy6PVHTI2FKM9fH2Zs/h9BbzH//Cy59Jp3k0N04OG8YVpobY8LZzQ+0
	 wcj5mRVkBdF6/hBfZa44WUoNbgtaWSkpbyv0Zcg599y8w9cxY9vqtelfcadunVQTg3u6X
	 in0waYrgwA3Ycvmf4M72epDgmqEfpQYQQl35pgIDZnpNcfWvs9FHNVCG1d11lXtMDX0fM
	 car78yAQD9b2yb3Wa1CYJ9TF933ZW5gdzbgAkVoaXiWvo5fA4aEReRP8e70Nar+kB/MXe
	 WIxNaJAJwImKLLEKspBUgt9ZyoPppDeWUNxn3T96uSFDP0MNKHFZfooF4n+6VMz3ngA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T5KNRnZDHgXJ0BsuWrEUE1PK7Dm50/VQybZHs0zcy7c=;
	b=AzCu9qMeI7efLtOjBT0Er2rKLVa93h4C4m2Ou374KLKUXItmt1uG6FGfLncNDwZ8ZSQM
	 DS1jA/+nshOjSrN+KIYvZ6subb3Frmh0ktLpN4Nyh6o99BHgz0h58cXfG81KaJAus83tW
	 IckNeSbpUOfosr2dmyLiIOtM1P3azcrbd4l07cybGPs8YHBhC+mvaM3nXFNYX71v8vR4P
	 csGBwoQ5gAPovW+wKCPBy0KT/zncBMTruQoGYlmULSjpWzz2QHj9uas0ozrAM3F34Ypya
	 nRXTKFovMZxOwif+CZmJVE5aTzJ0yG3jbqxVHspPXBODb5+hrqekQ3jncO4QGHiLIQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZXIK9UD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E2606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZXIK9UD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713EE1F0089F;
	Tue, 10 Nov 2026 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273401;
	bh=T5KNRnZDHgXJ0BsuWrEUE1PK7Dm50/VQybZHs0zcy7c=;
	h=From:To:Cc:Subject:Date;
	b=iZXIK9UDz7WEbcocIhJwlwiEWPiqmGO2gM/4AlLY7x/CXnhwxLJ/Ujmr0Wvgjj6nY
	 y7h9eB4OQJVfNSxGOvbr+AitP7BNUFF7QDgfYTK9mMK/XmJJULFa7UO7ybxHSYK4WD
	 qBYrhxBBcP6xLXMgVDqNwwemoIlj4qtb+o+0ZVtlW4xM1bHxyYZLwls/77t+N68tr5
	 VPTZt5hh7opQ7tRYL0db11C19JYut2ojPV6AGy+mh/qOPYXMBWgi0dUOe1+jra0Mu2
	 9D7fjM6I2sKzy7bxNJnQm0CMcThPCeDXSB6AyQsNH8jzPPKLNX2H/oDFSU2LZ2JqYU
	 kgWwGXZcXbv2A==
From: Sasha Levin <sashal@kernel.org>
To: mohit.sharma@oss.qualcomm.com,
	ajay.nandam@oss.qualcomm.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: qcom: q6apm: Guard callbacks until probe data is ready" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:39 -0500
Message-ID: <20261109201639-failed-6.1-ef7062864c05@kernel.org>
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
git cherry-pick -x ef7062864c0511bba52775d0eb3aa72d886b5f3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201639-failed-6.1-ef7062864c05@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ef7062864c0511bba52775d0eb3aa72d886b5f3a Mon Sep 17 00:00:00 2001
From: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 20:11:29 +0530
Subject: [PATCH] ASoC: qcom: q6apm: Guard callbacks until probe data is ready

The GPR bus needs to make response callbacks available before invoking a
client probe because clients can issue synchronous commands from probe.
This creates a short interval where a callback can run before the client
has published its private data.

Make q6apm publish its driver data only after all callback-visible state
has been initialized. Have the q6apm and q6prm callbacks ignore packets
received before driver data is available.

Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
Cc: stable@vger.kernel.org
Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
Link: https://patch.msgid.link/20261022144130.2443667-2-mohit.sharma@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 6 ++++--
 sound/soc/qcom/qdsp6/q6prm.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index bed3b64e83102..8e3314a2738c0 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -890,8 +890,6 @@ static int apm_probe(gpr_device_t *gdev)
 	if (!apm)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, apm);
-
 	mutex_init(&apm->lock);
 	apm->dev = dev;
 	apm->gdev = gdev;
@@ -905,6 +903,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 	idr_init(&apm->modules_idr);
 
+	dev_set_drvdata(dev, apm);
 	g_apm = apm;
 
 	q6apm_get_apm_state(apm);
@@ -949,6 +948,9 @@ static int apm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 	const struct gpr_hdr *hdr = &data->hdr;
 	int graph_id, is_pos_buf;
 
+	if (!apm)
+		return 0;
+
 	result = data->payload;
 
 	switch (hdr->opcode) {
diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index 2042ff1e8ff1b..5c927ebd81f41 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -194,6 +194,9 @@ static int prm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 	const struct gpr_ibasic_rsp_result_t *result;
 	const struct gpr_hdr *hdr = &data->hdr;
 
+	if (!prm)
+		return 0;
+
 	switch (hdr->opcode) {
 	case PRM_CMD_RSP_REQUEST_HW_RSC:
 	case PRM_CMD_RSP_RELEASE_HW_RSC:
-- 
2.53.0




