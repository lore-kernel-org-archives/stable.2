Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E768463B96
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462981; cv=none; b=CNckdDNpThzSArZHtJ8wj2JmAiHw+Spn9//r0mIdC2MR76+Brg0sM+4+3J+w4W/EVk/f7vTwC66/LYhLCdFERAGbaS6tLrAJa24JgU0ZQYd3Pk5lMOYFJjBYx8Lju1DiTyayB8qySy8BsUtoaHP00BSDXX1GdGdc8ssA0tlLBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462981; c=relaxed/simple;
	bh=NZRchLVy5n31XYbiS5i8BQVcxRXCGTbKv1t0C+lcWuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZqmPrgGG2G6uPqHLeWNOsnVXmrzqVB0/EZg8OnSKk2HjkpPmUN2JHKq3n7+3vYqFqoMMV3kP4aTYOspJcsVDoyd3uMzvEDuUVyyWRLxhrUMZTtmzwS95WlirwSo9I7bbnc/HXGSGimSFjkcFVhfm6kk2T6uMkb2mbmlfjKs/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r63vqtep; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r63vqtep"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso4628521a12.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462978; x=1790067778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qexTWbdmW8eEb6vSlsUiXVjBfkjIzpmrkaoJ6YlOyks=;
        b=r63vqtepd53cEOx6fnhk2GMJuUhErH34LrZgVUhSFTY3r/1oS1as8t+bfGQGzn+8C1
         o36ZjLZU2UjIuUY+cnOoyM07KzBFh7MEkjxh0COVLMZqnxQNjYwfK3TM0vyRXP/wtr4+
         hKneX4S1r9gzPwWKH1/3YvrpFcbso9eXvkKosoUWeeIZUaq4xzGrSqW1pkG+J/uuzPTo
         7710zKIKrjBN+1vSG4GG3a03iBYKjHK4uPtLkvYvkEJfaefnDBDX8uSSJIHaXo38Doos
         BxsBnKQ1XlvXxaBjRZChqAtZoeOpcWH+lXIMFBx54m4frT9qF+achk+4U8I+TPuffqPn
         EXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462978; x=1790067778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qexTWbdmW8eEb6vSlsUiXVjBfkjIzpmrkaoJ6YlOyks=;
        b=PLonL38WEQpv2bLH1XjsRCTZkECLMMfA3rbhVjdqdQFC2lo1ZdiuzMbLjIpPk/c9aM
         3ba/7/+hnD+O2sXRv93kFBGPzXSqpHIDbgkfbBaQ6tS1ScAxDWsyN/v3y7NznVt0DXtj
         /+KsNK/GDeZIXyTVvtlgZOEu8vDn1sMAsLC727z08KHUYBM17z4pcbywEEjf14SgcZvN
         8vtKQ5DrRfOliBm5cIC4yPllSg9jCBRQ4HKHtimBclxRWIrSWAk9nthrl5iU7dg+fnjr
         oesc0eIvtbFGW9g26ENJb/HOJr4jL8vqYwta55p5kOk7WakSIZddgZquQUGBd4JXcCxZ
         iBmA==
X-Forwarded-Encrypted: i=1; AKwUvBwX8i6wD8nCLKk1THdee/znabaTkfp9h+tDBZdq51YI9GaC0WSLQXba9SBdKmpXaGUEEYuJdns=@vger.kernel.org
X-Gm-Message-State: AFuF++nP4GyYlhzLTIk6pfV+yk/mCbSoljrqytxy0DD/xR9qBbhQ0lR1
	vISumWBSx7CQ/6Pu/dsSTrM1lUx3KYQdlU4+PORdUqgCeTubsVcQSFZn
X-Gm-Gg: AYBFou2q3XO9ZLmLL8FnKCjoOiXsR62R7Uipuy7H+JY0DoclB5mJgfOYIS4jEViebFv
	WSNVwugNEUBeUuLrQ+kG/sGaltiiqEMWLR0pTGtfQGwmheFKEzxvAmlMhRO1fVzEykSLUyuR+Ym
	pN80wAM4+sKm8nOCyMe0XxoYILftiQPK+jL+3yErNbHTZmXDhatXivmNyRr/fXAMRAaQ0X60IAv
	ktgZpt2WTzrpdRVK7Fd561+YKJhBw36vgQZDSrim04aIrnkwnwbMzjVnWUUr8pXByzhLVcC1xdy
	Kj2xJ1hSzTWTBe6UThNeqWQD6Bkcg+9rMarekhMTz13KozD8CUjpiXujSiyuLL+urSUWHu5BlrA
	ASh0jhFVmbPPQjtu+PIlqhalICD4BCsMpcINSz9VYbCF0QzF0OkDtSU5lrKuJgO0YTjOfYB2A4c
	2XiKHLjZBP3DwZWt0DbetyRrupXiHhSy6b9gTloggM18bkhuq08Mt6JrMoRJqpl5wXbf3+sSEsx
	6nttEzKB94uIU3ICk8WaqsxcwOYzQQrkQztfxVxi+LQtS5DZtKCpHRIjcRePQ+xHwfW4iUP5sFd
	oaptkalVsosdHB55hoYqRhl28fgF4uvgjDS8iXkhmmm93PdrWEs6Wnb7fmp0BCbJTpBRLoDJ83l
	/xvvWewQjKQEoCFSu2XDNTiuBM8ETD5DiMyLIzIXMedxmUuKT1RMbL+SlZpSG4edpTLHHxYu5VC
	1lQFydTKEQclNoanX5CbKwb9WANsmo9p5L5zE14f6ibL3wMMm79Zmq+27jynbxYdSNUoHJfOM3O
	WZemVO6mDE=
X-Received: by 2002:a17:906:f597:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c29b84c7106mr395967466b.9.1789462977606;
        Tue, 15 Sep 2026 02:02:57 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (88.71.12.34.bc.googleusercontent.com. [34.12.71.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm546369266b.1.2026.09.15.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:02:56 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 4/6] usb: typec: ucsi: ccg: add missing pm_runtime_dont_use_autosuspend() call
Date: Tue, 15 Sep 2026 09:02:21 +0000
Message-ID: <20260915090223.1346-5-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915090223.1346-1-joshua.crofts1@gmail.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucsi_ccg_remove() disables PM runtime on teardown, but doesn't call
pm_runtime_dont_use_autosuspend(), causing resource leaks.

Add the missing pm_runtime_dont_use_autosuspend() call.

Found using Coccinelle.

Fixes: a94ecde41f7e ("usb: typec: ucsi: ccg: enable runtime pm support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 91c2958a708c..9d3ebb255de7 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1519,6 +1519,7 @@ static void ucsi_ccg_remove(struct i2c_client *client)
 
 	cancel_work_sync(&uc->pm_work);
 	cancel_work_sync(&uc->work);
+	pm_runtime_dont_use_autosuspend(uc->dev);
 	pm_runtime_disable(uc->dev);
 	ucsi_unregister(uc->ucsi);
 	free_irq(uc->irq, uc);
-- 
2.47.3

