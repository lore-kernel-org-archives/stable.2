Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A4416125
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363821; cv=none; b=CbFR5MX8qcJ5jCgbI5j94Qs5T/4zhADNcZgPgtAT97hLnRp57drwmB+Zx8nL3kUbuNA1hCzv7oKixJM/bJaerPh9zYoAbt30K6ql335HvtFo8u6FpsOisqrXNptsJM0p/ZB3AOz989wjq4dzoRcSFG6Od0NZJNJNfFI1CklRogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363821; c=relaxed/simple;
	bh=+96OmNdu52OLdp6PqNcnZbKt8nrAE4bnHJngCEEGTaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw3KFho8dJj6fELk9v6ZKkiAzLwfyf1DN6frda8+p10Z/MpThKVbCWtsUAzjcZe4GiTd7VPw+4mfx1PFfkWY6uVvBqHld6p7juim21WF3UiNNIYHXw+9T/QN+RWptSao32NP+6vhltuAHPt/JKzLlSxxxIpBPK2vBF/9TDw02hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruPTmgrk; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruPTmgrk"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ca5aa8so115551685a.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363819; x=1790968619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvpGMpsWr2y15kZYUKT28HeHCdI9j+YtoSYsRebbgn4=;
        b=ruPTmgrkZnuKH7sceS0e5xg0u0Ob7erHTEHHECzWYsDJmsfJ9WfHojMjTlMvfUak26
         8TtmeyjGbwa6x+q3ImVrgkXp1cZzq922hUaR1ftJops/zXaNOJ+lQZ6JiUGcN4iDfJSJ
         ujp/ziptN666wraCJf3zIPF2le9K8NWyusg0SjLwYgrFsXYlGlj37u6pig3oZO4SV7y+
         jwd/DTAaV68lRCBticIVsF98trlNgESmNEalLtdSm7iL5oFBwb5Ol2csVQLlYNKDtWC+
         jcZoT+OlLh/r6RcSRpNbqgfl4GhCGtwZPf/HQ8hBwbDRuu4NJKmAOyD6qSfWJYHnR+/8
         YvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363819; x=1790968619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvpGMpsWr2y15kZYUKT28HeHCdI9j+YtoSYsRebbgn4=;
        b=nBWoT+THE+SeUDg47GsHY3cuUtH71tHT6GMgGxPh5BVBBFuBvEumEWnoysb9b+P+5G
         vPXtlkIkD33RONzyMMYm7ylxBtBQrBphhKgNu0En9N99jobuIV1NEkdmdAqp39HiZZjq
         JOEG9r/dBxob7AzA1zI3Vh8D4QbPxPAC8WFASwql9ikXeq9xCkMGOj/Ova1BHu3We3LM
         3aYntfsZStM11hnmHCLrXxXcW/L1g1qCHcrXZuAYYQ0i/N2cY17LXXhQPzc7gzd/pIaN
         Ux4bmJDURmUsgLhaM1lrwbkDm+rXqifRCnMySHcnWvXDn2g+gjvk7v4u/zF5NYA/qvmE
         p8EQ==
X-Forwarded-Encrypted: i=1; AKwUvByEQ4+LQQNJmlh/MLPstrcQEl9UVrr8l8qwtx/OsqxQ6HyXDsq9UKDo/1zWIKAg1ptONCTdY4A=@vger.kernel.org
X-Gm-Message-State: AFuF++mJQH1qpGZGfKwh4yqeVavRqV8UwstkMSjL2qtTB7SfuE++CX5L
	LhUqrX4gumokT+m7Bm3PpuqDoQkIUmRWbBwkTNfaftJ0E00pkWzxiKk=
X-Gm-Gg: AYBFou0v5+Ul7OsiR51VVJQFVFsoK0lotHLL6hp7lnoeCFSqvx4DkHxZ4E81t5btDdN
	wztcZZki9uruFwBWGLzePmnFkeiXYlh6PdUIIHAgTPom1WpTKk2SeALLb7aGd5OxdtYMw29YZID
	5uahlqWXoGmJKkx2hLoYTF0TjZUsZBmKq2bfPoq1A1D/zbjtm1/UupGvl9DcjR+zBMLUsz6wdF0
	tZoyIQGj3Q37PmIdsE8TiGFa19PVCPkUIs5KrUYn/83XxZ9SBxUmfdafKBbFXGQ2RSJ0NBSHXdd
	QwJYYuhJxfrAdLQ9eh7AmE8r6TN3VVOG4/VttTCuGy9cCLfSJh5NC75PQRPdNMGiFfScAvpCzNG
	+SKHh7MvEBhld/O1z6hMd+zszlV7HxWmzkGKBt4OwyQfiJ989KYIJcY5Iqu8lZAU5JZhsMTlyHX
	vmynmO8fjl6wt+JzcQmuYuIIWM7BIehSFxEEn5DnNV+CznRMTKnXrU3KAYy/T310YT715K9FXQp
	1ZgIeLOc2RB8Qrj7Q41LA6ZIXruIuOz7pL3Y7Q3sEURwQzlaJD8v1fjNrNuhGAeb5MHhBVN4TYx
	5fao8FqnSeBIX/LK8plAl30Xklht
X-Received: by 2002:a05:620a:1a1b:b0:939:7c8:78a9 with SMTP id af79cd13be357-93c43b61a84mr653468985a.3.1790363818750;
        Fri, 25 Sep 2026 12:16:58 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914309a24c4sm24142666d6.6.2026.09.25.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:16:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v3 2/2] media: venus: disable recovery work before HFI teardown
Date: Fri, 25 Sep 2026 15:16:53 -0400
Message-ID: <20260925191653.3144006-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925191653.3144006-1-mhun512@gmail.com>
References: <20260925191653.3144006-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

venus_remove() cancels core->work before the IRQ is disabled. An IRQ
thread can queue the work again after cancellation. The work can then
access HFI state after venus_hfi_destroy() frees it. The work also
requeues itself when recovery fails, so cancelling an already running
instance alone does not close the race.

Disable and drain the work at the start of remove, before other resources
are dismantled. Do the same in venus_hfi_destroy() for paths that bypass
remove, including probe unwind. Disabling the work prevents both IRQ
handlers and the work itself from requeuing it. Drain the work before
disabling the IRQ so an active recovery can finish any IRQ based
completion waits. Then synchronize the IRQ before freeing HFI state.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/core.c      | 2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 243e342b0ae7..94d4b8688ac2 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -538,7 +538,7 @@ static void venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;
 
-	cancel_delayed_work_sync(&core->work);
+	disable_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index e7e4e78a186a..20b8ba1e62f1 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,6 +1689,7 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 
+	disable_delayed_work_sync(&core->work);
 	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
-- 
2.53.0

