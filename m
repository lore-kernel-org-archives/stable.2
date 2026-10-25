Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892097;
	b=clejqkveVCHS2z6PqggD+nbsGaoxCOyNznyoBPQkbztbbj5nW/fk5OudAhdzbn+tfvRW
	 fo2lSVXCtxQ3nqFQ29ftaZuG4iIMCzpQeniQKCwyNgUuFXmifP4fie88aKdV8KaOj/IpL
	 SWBUcbbLmcSAu3qNApjf3itqSO5VDXla4qKupMIubA+xnAWN2b6pHOCk9SLeyJXTteDnK
	 JmOZ7Rd01BTioBLq37sROELy5SrHCzj9idtMWfmKM8acsRGOIf9j86EFzcf5g02QmQOCW
	 c7IFgQb9LOfq/9UwrGUcrmFiAbdyK+awTZ+/r6Rp6Ko51E0InJW+40S7ielY9gUBA1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AIvu/rqVnupfasFxvXjw2EGbKljTp1m69eUHoTTJV9I=;
	b=KIlk0SDWOyCCf67eMZQAoQp8IVvgjyeh10cECVHmQ6tOQNn48rz+bPrQXnHxWv/89hOH
	 2k1XXC012jbiQAthXwYM5LDg5fYYu082EPMvFUbiRzFrT4HyXk4rVv9syflv1XhCjIPzy
	 QXKT2K4bVrFDYDeR9eQ3fZxe5G1drBDsOpVfnIEWt0FbHNwfoYle+8sBwImm/IliLA8kB
	 9VJig/xVPzVzsiV1QB1pvoHrKu8ZaASEo7lhfNcMZx9zZmy+cvJ2+wH+2RmZ1gyJ5KZWD
	 yjRdl61sa/mclZaXDkW6fcq39Jg0eXUfshmce/Ey89SFcu8qS8aKGS+QgYlLdJa6ElA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=meRXun4M;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF261606A333
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF261606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=meRXun4M
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a064f294cbso1573178b3a.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792892096; x=1793496896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIvu/rqVnupfasFxvXjw2EGbKljTp1m69eUHoTTJV9I=;
        b=meRXun4Mmvu+G3QNS9CFBaKuexKED0W7tcQDwPMkKaA773VOQuFVheJ48D2loz/E2/
         htC8gwFFoBR5WElK9qWzOz+zWWdDZX9BUeRXxBOxKaIi1EbRjH31wlAjAmJRYV++5BD5
         uKl6P4gM03fe5S0HE2r+x3damWoopGd/rPAder1qxEvHvgjuSX76+xZuSkTHCovYEbh/
         RtHnqvYfQC5n+KbDVIvtFx37iE2Z3zGL94lsJGTAMvHZCdjoCvYyr/OnjmnqP7IL36oG
         P/XuSRvsxy7EmhVN75t1HNdviJaU+iYVSCQy2uZv08pCA1l484GcrAlWfJ6BDOq1fB/v
         aiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892096; x=1793496896;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIvu/rqVnupfasFxvXjw2EGbKljTp1m69eUHoTTJV9I=;
        b=vayd5J1N0h8nGdMywJT2rIMGBxo0KqgwxO8t3y2tyZLMU8ebLeF8lMbwTQ6c1WtQZm
         B5v12BvfGH0NWgxGXSmnFwaDMGkiitKjKx20mwj6Hs/J2t9R/zRq/15U2ToaRNVARlxw
         TpgTxBgTs5DNT8cmTe7GjjDt8jG3kp6x6F6rI6Uvgj5bKYHSRGLdTa03II1NiE8PL88S
         Y1NVtPoDH1ZxOO2pqdJniPIPVUyNMKEK1+6bJvMw+bZ+ieHoMcN5anSMFJ97GriogdCc
         wkBEpC0JTXoOQPauO0QP65T2/hXVnN99t7BNGLehGzCRqM4dqGnGyYeFQok0uRJvL4EB
         vnmw==
X-Forwarded-Encrypted: i=1; AKwUvBzf3x1csuzUO6sPDlyf9z3h8W6NGsN/Yo12+WgIJs97WcsXI1jaWaGGSq0uRRxHWcKMca64KtY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWuAK4bIJ5ARJD8uyNHJZZCEruhZilFU1FvdN0JhopYeeVhDh4
	1uR0u2k4/v7Nhw+m4o5l7ClXyWc0dhyAHxNAfB5svxKsVuPwHy5BHSvcosCFKm/287ROnbPqADV
	oL50I3DrHYynXYkYZSRyBMg==
X-Received: from pfbf9.prod.google.com ([2002:a05:6a00:ad89:b0:89d:e1ff:97f3])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cc6:b0:883:904e:da56 with SMTP id d2e1a72fcca58-8a366f68ae7mr2652022b3a.36.1792892095863;
 Sat, 24 Oct 2026 18:34:55 -0700 (PDT)
Date: Sun, 25 Oct 2026 09:34:45 +0800
In-Reply-To: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025013446.345974-5-stanleyjhu@google.com>
Subject: [PATCH 4/5] scsi: ufs: bsg: Abort ufs_bsg_request() when runtime
 resume fails
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In ufs_bsg_request(), the return value of ufshcd_rpm_get_sync() is
ignored:

1. A user-space BSG request arrives when W-LUN runtime resume fails,
   when power.runtime_error is latched, or when W-LUN runtime PM is
   disabled while not active.
2. ufshcd_rpm_get_sync() returns a negative errno without resuming the
   device.
3. ufs_bsg_request() still dispatches raw query, NOP OUT, task
   management, UIC, or advanced RPMB commands to the unresumed host.

Use ufshcd_rpm_resume_and_get() and jump to out_complete on error so the
BSG job is completed via bsg_job_done() with the failure code without
dropping an unacquired runtime PM reference.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: stable@vger.kernel.org # needs "scsi: ufs: core: Introduce ufshcd_rpm_resume_and_get() helper"
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs_bsg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index baf6ae917d36..8df1a2c6abf6 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -150,7 +150,9 @@ static int ufs_bsg_request(struct bsg_job *job)
 		goto out_complete;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret)
+		goto out_complete;
 
 	msgcode = bsg_request->msgcode;
 	switch (msgcode) {
-- 
2.56.0.307.g5fe7bd680c-goog

