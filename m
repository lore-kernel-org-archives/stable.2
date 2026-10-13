Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC23D565A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887359; cv=none; b=JssfdgHKQ58D3wH2MIKHkfhIrTBSX1kssZLWoBJsXJb7j9s+ajJwog4IaKtI6oyvzBVlQZLo05rj9cKBTwjOkBjrmuKl30rxtYz6pa0wyi9YAJm6qlTG1GPntoYeM3MyKHXUZls14FalVMcXjElPaHxQ5I1d20NJsAB9VCaKm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887359; c=relaxed/simple;
	bh=kmAePwd9nsnoOabCLGY9o8lge3E+skfHNyPrmxQGpqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBDof8nB2N838KWiTGPzm3LhkuVeial1IjpMjuqMfyZdlFYfKuJsrL5foGRS9aMiDhIqVLK7cHCDnwGd97SgevqXVHSdJkN06YS3t9VZBJfuEvf9MS/uUqMQaXyb4FujpYF5+3czjvHyz6dqVrD5VW1XB41przsnNEw3uI6Lyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4JrDr3H; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4JrDr3H"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88b9d8c9e55so2130518b3a.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791887358; x=1792492158; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wj8sPa/W7DRBWpn4Q+ZBqiBNgP7B/Tx5yNZUO6m4T5M=;
        b=M4JrDr3HCdrVbj5srQcPVYLS8sqlXVJl04cc5obfthpivZdWWwaCcIFAk9kmDweEot
         MY/9BEbrMPUuuAxx+k99ukUcGuAT/Brjm+c1fpSGues+tXCXjiQx/pxJZBP3JT9PccMu
         szDLm1hTL/x/V12EGsrF3mz+PQA9U0UjFOt4gS7VOLWhFmC3nNrQpQeQ+cixbZoVGwuh
         6LUHfNEI3yBA/NFHCPGdLCgb13zQtifzc3A4u3tUjbwxtCqcOaU8fEplIvovmIS9TyV0
         ojtzY9CsHRUhbfy10O+PR/7tInI7yt30GZsP5wWU5iNWdLP52lGi4d3cjmjaugyvOgxV
         fgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887358; x=1792492158;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wj8sPa/W7DRBWpn4Q+ZBqiBNgP7B/Tx5yNZUO6m4T5M=;
        b=ds9xw901EKVLG/JwXFtcEGOSYGGkwS5+/Dg3yFvb1WXwyQfXebgfRpCr/o0WdLZURC
         DLDnSi6LKalC4Fixd4UqbJKgAXyfXiGn85d9e9mnCgtEcvqJJ2o7OcAKJJkfnPaSemtN
         yMqPoo3axFMtUfT9KAb5HWnHgI3DeENz9IlVG1Px4sBZtm16sPq6gXN2k/eLh15r7iHU
         zcj1lmb7CmWMAvf/7UHcPu0PbN0499a4YkU+vqEEyBahIHTbtG7dabGPx5xYoV2dMQjs
         V8+EkBI6Vca+KvWK6B+9D7dtqHWGwSr3+zpL2U8j935DVBrSKN431CJJI8+cm7PHFsu3
         8PJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx83uRALDbUDKQUAd6h1I0k/NNoPsQXhLnD1t8ojfBElaPsiJfTSC2DyropHugqym8j0pO6rPU=@vger.kernel.org
X-Gm-Message-State: AFq9FYImwPajM7hqkGoSH1W2fhuWWEmTFrwIQaPTWg3jgl5x8vgHVtlv
	+KpUIY6mUsVzarNJv9//RuBcQPtTweQv0d/SmquPM7CALEgCzL5PP7szfmWR74nBOb0shczD2ZP
	b1p3Y+LIj19OcIVTZLTq28w==
X-Received: from pfdi17.prod.google.com ([2002:aa7:8b51:0:b0:890:9454:a812])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:71c5:b0:881:e266:c3d8 with SMTP id d2e1a72fcca58-896a3f2a86emr6753824b3a.35.1791887357456;
 Tue, 13 Oct 2026 03:29:17 -0700 (PDT)
Date: Tue, 13 Oct 2026 18:29:11 +0800
In-Reply-To: <20261013102913.948718-1-stanleyjhu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013102913.948718-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013102913.948718-2-stanleyjhu@google.com>
Subject: [PATCH 1/3] scsi: ufs: bsg: Validate request_len before accessing request
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K. Petersen" <mkp@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: powenkao@google.com, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufs_bsg_request() and ufs_bsg_exec_advanced_rpmb_req() read the
request buffer without checking job->request_len, which userspace
controls. A short request causes an out-of-bounds read. Found by
syzkaller.

Reject requests shorter than the structure each path reads.

Fixes: 64d4864714c2 ("scsi: ufs: bsg: Remove unnecessary length checkup")
Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs_bsg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 7a66917b3fc0..dab1f05aff38 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -73,6 +73,9 @@ static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *j
 	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en)
 		return -EINVAL;
 
+	if (job->request_len < sizeof(*rpmb_request))
+		return -EINVAL;
+
 	if (rpmb_request->ehs_req.length != 2 || rpmb_request->ehs_req.ehs_type != 1)
 		return -EINVAL;
 
@@ -142,6 +145,11 @@ static int ufs_bsg_request(struct bsg_job *job)
 
 	bsg_reply->reply_payload_rcv_len = 0;
 
+	if (job->request_len < sizeof(*bsg_request)) {
+		bsg_reply->result = -EINVAL;
+		return -EINVAL;
+	}
+
 	ufshcd_rpm_get_sync(hba);
 
 	msgcode = bsg_request->msgcode;
-- 
2.56.0.385.gd3acb90ef8-goog

