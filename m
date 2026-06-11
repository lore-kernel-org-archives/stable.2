Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E53F8237
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181141; cv=none; b=EyS4IwYHeNrYWHRweZPdenwl3f/PC0xLp8VH3evkInHQNAoVo+Xbkna5EafovASUhp2skqiXdoCuoTdNfVGQPq+SM74svXWaQ8EnCnRKEvE5pnGf6JbpkycuOSrOT7hUo543ZA+BmcgGWRUL+pKShZ7GWpfq1fky5d69aioDgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181141; c=relaxed/simple;
	bh=+g3UoGJSQBMIJWfE4I1WQriSnOqWfRW0HPDuB75fY0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBzD8FajYnVzAhGMoD0H3LyRbW1cs/Mxg08um4gJBmpTWhX0Q7LTctwSa/fHgMu4kHQMp56cIbPjJGGBQSu6q1gGTnp9LfHBrNKmuwYU3LveqsohiiAwkwWWt/WQDkTmM6OBq8a6fBxuWbZsgzlPNsQN4eMkhSeSjiF2hvU5i0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVQN5Lzz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVQN5Lzz"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91574384cc2so913929185a.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181138; x=1781785938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGR23VQQ0KIak7ZD7YLq3Alex+Q6WU/vJpcU1WhhyY0=;
        b=AVQN5LzzLDR6l4zmuedj4Kj76oucvGfD7HqTkq4tGb18BXNO3Sj+YvVqF1GKv030m+
         JlImv9Eyfv0eKC0hfNukxTwO241dNX0vERIXnj2SlDOSqNTafdJbDKN6YH3Zzusk6Rdw
         Fz4VAOjJjHISNW+ol7QjZ46yq/MDbOptcdaL8uxBeh0QMuB8gj/lc6Fz5k5b0W4wSc5L
         dsnRLO7XJN7gYHgNapC/oM8Nm/7aZtvaIbczFeKUMZzIX58xyJ/Wu+MMPGFBnsXaSrSf
         8jJ+DYORCHRqYHnBPpblAIihk8wzUpFfWJpYLdHzLBPrPqOtZL/4SoMF9oHCJq/L/nCg
         lSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181138; x=1781785938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGR23VQQ0KIak7ZD7YLq3Alex+Q6WU/vJpcU1WhhyY0=;
        b=LwcfTpBosboeN+wTfeTJ/Jp61LptcurxvQDH5mku9ykYUGdk/4RC7biEeuPZRc9o4Y
         nP6P8Z4DWEUjzEEOxTo7iiQdid9xWKax910L7oa9RYXJLFAXJ2XVbU7N5ZesibT8vWjq
         5hp/UtygzzFm6PYXQjnf4hTuwyYQu47U2pxpN7Su2q4TXbvavhGLYvvszQGz9/IhwiiA
         aofHOAAYuEY+XrmP94HTDPyWwOnv6I0i+rWH9Ehq0M5FF3d+KgK2EITIV7wpoLMXL3EC
         gMLlBop9SKMIN9fB35jagW6NNiLS/MaK2C7+tu7vRPiCnjZzJkjxlGIjsQdNHDIs4WkA
         fhvw==
X-Forwarded-Encrypted: i=1; AFNElJ8zQp0DYnUhVmzdlyEjbP3oRnd3vj9XhPJleudWFc9w86lVVqpymLARFoN2rmHzYzAWOp1G2zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpjsTEvG8c3F/+8O6KxtiUliNdJmo3kYV8Kg1TLt4cqiBFupM
	AEtm2k1dU92Q/oa8l5jY6yYbiSUbaoGl3DMKV76Ta4pLBFS1qracUgJM
X-Gm-Gg: Acq92OG8rDnxDRmSCrD0jXQe4AWggPt2h9E/2BNYgKBXhQls9FhNO6SZqt0mc+9ulNe
	RCv22z/MQ6UMhy9tva+ZAEsyv3b56CQxNwxtCqQiXfuAeFvmzPH5MtfLPI6qYvW7X8nfLmsOCle
	IbHfg3zGh5miMNZqF9tFIow5jGN21dCVgJ8uRKtiWH+P5WsFJMoeScpDhGWAEGPoyzLTpsZQzrG
	hN179HVNtKQ+z7DMTcKI8aARowkrmH/NchyJ+9oJnvSAWfdE7MlzDNg0lUcv8hSja0dKc32bPUC
	WszrrPQyPsXMiUPhn6Ca7lFHNFtyt55Vx7i7Tx3aY/TRzioQXvD/KnXohUcwqu9O01v88ffuRu/
	GaQRBAWRBTXhU08iHsytFVP2RjaCN31goTcqsSdEk3XTk16ugpQZITpLCMm0SnQ87FPa8De9XmY
	ox8R773UTWlidI6gHVCHu+hSKziSjzeLvZOamCN8UvVuWlcZ0JnyUYunFKtDAyQ4lVkI473JXfH
	tGTygCJHt2iSl+B4ZI0nEWpI8P7Kqc=
X-Received: by 2002:a05:620a:17a2:b0:915:3542:ff72 with SMTP id af79cd13be357-9160acc37e6mr365473885a.22.1781181138395;
        Thu, 11 Jun 2026 05:32:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160b02f758sm171220685a.36.2026.06.11.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:32:17 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] xen/scsiback: free the command tag on the TMR submit-failure path
Date: Thu, 11 Jun 2026 08:30:46 -0400
Message-ID: <20260611123046.2323342-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611123046.2323342-1-michael.bommarito@gmail.com>
References: <20260611123046.2323342-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

scsiback_device_action() obtains a command tag in
scsiback_get_pend_req() and submits a task-management request with
target_submit_tmr(). When target_submit_tmr() fails it returns < 0
and scsiback jumps to the err: label, which sends a response but
frees nothing, leaking the tag.

Impact: a pvSCSI guest can leak the command tags of a LUN's
session, stopping the LUN, by issuing VSCSIIF_ACT_SCSI_ABORT or
RESET requests whenever target_submit_tmr() fails.

transport_generic_free_cmd() cannot be used here. By the time
target_submit_tmr() returns an error it has already run
__target_init_cmd() (so se_cmd->cmd_kref is one, not zero), and on
its target_get_sess_cmd() error path it has freed se_cmd->se_tmr_req
via core_tmr_release_req() while leaving SCF_SCSI_TMR_CDB set and
the pointer dangling. Letting the command release run
target_free_cmd_mem() would then double-free se_tmr_req.

Use the same helper, which returns just the tag, on this path too.

Fixes: 2dbcdf33dbf6 ("xen-scsiback: Convert to percpu_ida tag allocation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/xen/xen-scsiback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index f324732eba7f8..c7036e0e41bda 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -658,7 +658,7 @@ static void scsiback_device_action(struct vscsibk_pend *pending_req,
 	return;
 
 err:
-	scsiback_do_resp_with_sense(NULL, err, 0, pending_req);
+	scsiback_resp_and_free(pending_req, err);
 }
 
 /*
-- 
2.53.0

