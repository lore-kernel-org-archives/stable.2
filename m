Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257727;
	b=TDDsZKhBdlpR3vPbP+0HjYkdAKFqhDBvVK7tv+AShZuco4Z+DiAiRYLT4rZ1TDT2Nxtz
	 F3L8xsEY0W88EzUn/2F85WMqPgOsKi0j9ccQ4JxVP4XtqKBgazHF3fHgdYjh3JKBJ4DcR
	 vN2QAz9biolOw1gQnzNNg9r1YwaU98rhlwkab8xLfNrNvFIXzE1rDCmeNuUKqB+5Dl+4n
	 XEPBKHrbPKRxvKqhLomKU5WxcS3I4STSFr++ZT9bnLtyPWAk7aAaYMc8pjn8T96fIsmm3
	 I8a4qRxnYGjMyPZOZJUXN1t4ujABb9neL+Rgb2XbdVWwtdvqYwJM6MYSEW+DfgZAIlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tB6IjSLw2lUt3GzsVlpUFA64RG4Q0LkTtEgr3PkQCgQ=;
	b=P95e4fbPGzEEt9yyZt+Yr4P7XSJ67GJQ71OIQiYYYOJdp1y3BJToyB5g//fkZy4qUZct
	 aGnogwBsHy/dPM1jE3UMWCj/PTfFOP/m+1LyqY7zUfLmoTQK29Vfx275Io3deSrPxgJpW
	 LjI2CSrS7QN2rC8nh4YiTrKEQ0CQCCSrlaqRgNWydPdNURoIvmGHpeFK+kHztMPI/sj6J
	 OGcm2QQVZ+Fiq2nCkLSz9kpnbQcJZDxtMqEmPfiMLilQIL+WOLmg169HoYhwXhlWFbIST
	 4E62zShjmYx8vdUBP2Cio7vJBXraiXJIN/NhCKL0nKZFlZR3Enr3zRS1fbTb9xaJJ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B67WZZNT;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE160A2610
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65DE160A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B67WZZNT
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso2124003a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257727; x=1793862527; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tB6IjSLw2lUt3GzsVlpUFA64RG4Q0LkTtEgr3PkQCgQ=;
        b=B67WZZNTv7crYkEp8JPhJqUJMTGUqFZnVcGJpCvxrQYEaEOj3b44Oyix/eAk5aiF8P
         x/gHXErxb107EaoVt3F8mDf/tGXjnSPX/2Eb41UeKouCWIt/9MYCmv+IKkdBVB9XXruj
         rXCkLoBU5NnTTutz8bbHNm3Txx+mvrqFabKsybROvaRgTo0hl8qHVGWH0JiZZ4iiFKJZ
         4x/soqeYqUuEKmPFXc+q2p7jha4q+wWl44kkSPAd0ux+EDKvulBeRHUz2At1CwJ/Cg/g
         4eL8Dw4InjerS11JHwTYaHLfqwPOQ1onsWPkjzkCXZFQ3AImjWEo2J08N+zqFt9ceeWk
         9eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257727; x=1793862527;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tB6IjSLw2lUt3GzsVlpUFA64RG4Q0LkTtEgr3PkQCgQ=;
        b=A1iP19Wd3ethsxafkkS4Rk2KBcyJidTOn6lXSC4FaPKRlO1dR38wfAXQu1QJKKFaa0
         1i3uR4l2DeSMyAP+oBbcAc7FTf7YKH3XT4SxzSgVJdLXFWzIeFPg8SNNHw+lEmD//Izc
         O6Y0uufzbCBtkAdAaKJkdsM7dp6ZMoZYlbovbFPcd0sx5Io4E9DEFk9QUPhwxrmXn2tZ
         VHzJyhsRx2YbQyLipDqZ+cEo2R2+6q1xx3DJVFun/t0vxh/sV9bY/YMbHaPAXg5LQ6Xv
         mhKsBzPrylgw2st4Yi/0j4DAaaOzj8PSzH5u9dtPTNNyHZzIQ/WJd0blpMbWCxtV5EHR
         vKkw==
X-Forwarded-Encrypted: i=1; AKwUvBwhct0dZ6C0nSIgYp2zwZBOVbIIPbHA+0arngeijhsOtUmpxSCdiGNAgMqXLWuik0KbSTPFo2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5vNiGJq6c3Tr+qCprcwjBhktlZgZFRsaCWzLnbfnnFfdoGRYn
	Lv3geEat8v9e2pwrB3h4ZSZLtTaIlz4g8fqVF4ItNdTEiXJI9dxCIvTXrkbXQExbDmcxHZIV2AG
	Bqw4WdmMwxyZqdGehJ/4grQ==
X-Received: from pgbj17-n2.prod.google.com ([2002:a05:6a02:61d1:20b0:cca:d82:90fc])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4cc3:b0:3e1:885f:b49d with SMTP id adf61e73a8af0-3e9024159e0mr4092891637.52.1793257726442;
 Thu, 29 Oct 2026 00:08:46 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:37 +0800
In-Reply-To: <20261029040003.2100003-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029040003.2100003-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029040003.2100003-3-stanleyjhu@google.com>
Subject: [PATCH v2 2/5] scsi: ufs: core: Introduce ufshcd_rpm_resume_and_get() helper
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>
Cc: Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_clkscale_enable_store() and ufshcd_auto_hibern8_update() resume
the UFS device W-LUN with ufshcd_rpm_get_sync() and ignore its return
value.

For clkscale_enable:

1. The W-LUN is runtime suspended and clock scaling is disabled.
2. User space writes 1 to clkscale_enable.
3. ufshcd_clkscale_enable_store() calls ufshcd_rpm_get_sync().
4. The W-LUN runtime resume fails and the W-LUN stays suspended.
5. ufshcd_rpm_get_sync() returns a negative errno, which is ignored.
6. ufshcd_clkscale_enable_store() enables clock scaling and resumes
   devfreq while the W-LUN is still suspended.

For auto_hibern8:

1. The W-LUN starts a runtime suspend.
2. User space writes a new value to auto_hibern8.
3. ufshcd_auto_hibern8_update() sees that the W-LUN is not yet
   suspended and calls ufshcd_rpm_get_sync().
4. ufshcd_rpm_get_sync() waits for the runtime suspend to finish and
   then runs the W-LUN runtime resume.
5. The W-LUN runtime resume fails and the W-LUN stays suspended.
6. ufshcd_rpm_get_sync() returns a negative errno, which is ignored.
7. ufshcd_auto_hibern8_update() writes REG_AUTO_HIBERNATE_IDLE_TIMER
   while the W-LUN is still suspended.

Add ufshcd_rpm_resume_and_get() wrapping pm_runtime_resume_and_get() so
failed resumes drop the usage reference automatically, and return early
in ufshcd_clkscale_enable_store() and ufshcd_auto_hibern8_update() when
it fails.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd-priv.h | 5 +++++
 drivers/ufs/core/ufshcd.c      | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index e55c2a02c1f5..99f654b79035 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -388,6 +388,11 @@ static inline int ufshcd_rpm_get_sync(struct ufs_hba *hba)
 	return pm_runtime_get_sync(&hba->ufs_device_wlun->sdev_gendev);
 }
 
+static inline int ufshcd_rpm_resume_and_get(struct ufs_hba *hba)
+{
+	return pm_runtime_resume_and_get(&hba->ufs_device_wlun->sdev_gendev);
+}
+
 static inline int ufshcd_rpm_get_if_active(struct ufs_hba *hba)
 {
 	return pm_runtime_get_if_active(&hba->ufs_device_wlun->sdev_gendev);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 68a98cde5812..5972e85d279e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1864,7 +1864,9 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 	if (value == hba->clk_scaling.is_enabled)
 		goto out;
 
-	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_rpm_resume_and_get(hba);
+	if (err)
+		goto out;
 	ufshcd_hold(hba);
 
 	hba->clk_scaling.is_enabled = value;
@@ -4792,7 +4794,8 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 
 	WRITE_ONCE(hba->ahit, ahit);
 	if (!pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
-		ufshcd_rpm_get_sync(hba);
+		if (ufshcd_rpm_resume_and_get(hba))
+			return;
 		ufshcd_hold(hba);
 		/*
 		 * Serialize with the host driver's AHIT control. Skip the
-- 
2.56.0.313.g2479322e68-goog

