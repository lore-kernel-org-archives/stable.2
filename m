Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF30423A72
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032140; cv=none; b=CdM8dc+SmMoYbLb/+kO1paoriXkB4uulmBZWeBaHVFgH4sxVnQECS9vwoQ0woDHmgq7Vj5GWAKtGnDGzzxSIYSMPIGKoovIrYU9gpUyrMKyWCfWdYxCS+3uxXihKCIMQfYUOq47TcOVgt3xKGCzdBZ1Ikv8ARyt0xWvUt/2WaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032140; c=relaxed/simple;
	bh=kAvYqeh9lhIbm8YtKATUVDPt4SSV0dL/01lCzjcwo3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUGevKPkAV4VSUwUkZDmXNyEqWQWTlYjjJDZ8Cv+zUXizXhhE3BIf96kYAmiqu8U515eg3KrjlsGqrI4GgZLPq+/ObtZrFr4FoQBtxtHHHS4OfG1VkX+2BPQ6czgWbHY6gQP+EuffKf/MGRZ7uzeLL2ePkyfbOF3eSCR2dp+l9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyZUYmCF; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyZUYmCF"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2dea320fso347784385a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790032138; x=1790636938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81aKjimYrYOGXnfGd1vfh7o17MNAV+GZaQTkl+KjGW8=;
        b=QyZUYmCFqcGdPDyj4LBCoxHGM3l8H92abHSqBj5QZZpXopqZSyK2Q5bFOaguO9b/IO
         amUpJJWphzwIfhp3awJ0SEoCjqA2VbDlYzYpgOKHbPlesrGdT0qY/Jz84vj6s17+ua89
         1pvcqTcZo8KcPzZlN9W8Lll3MUCQd9md+Clz6fqwOISzSx+mRNW0oXxexnynFvql6sC2
         qzFI9M5TvlTf/k5I7pxJDKtj8xhEGw2i9ZuWQ0J2ou2tF06iXVDSsYTYvc+n+ZXCt/+F
         qVmrGJY8P+2Mk/JUgyJ7MOSeF0tn7BiBDUJCXiMgq2YE1awp3nDuFx5EDA2643Rb1U9w
         lR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790032138; x=1790636938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81aKjimYrYOGXnfGd1vfh7o17MNAV+GZaQTkl+KjGW8=;
        b=Zb0/+gGOvAl7exh6yliBm8ZL1hWtFRnO9yHDtnpyRiV/xQxx7O4CmDM+H/+z/FrvZa
         wGkBkFR4P6tV8BSw5sMIdG7PxAQ7Sr/3IQ0NeTJovZRnsAl5dTnllbxzsdpPY53ID2fA
         sDD7zpHyOi3k+NVHXf45MVJ7rskZCYgz7tOtY0OMWkPCT0anAQI74qyFYhnbs8znkp3d
         n7CnnCe+5tsWXPEBn/whk88VLZjcOIt6KYAchMzVFLdTijAKJ73KNdd3yWcTrYX5Iq/m
         uxzY1LAepsCe986mIbfr+qusPDKBApyo3ewo7rjtPbEnkdUvW0DS/Mht4Old+G+z67du
         s1+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwqpHnOx2iFtM7B5HHYfMQS1oGl9IP4h4F9aLQw39igrNqHXGJMBlEU1P5b9CSwYjOoP6OIYvo=@vger.kernel.org
X-Gm-Message-State: AFuF++kuABW8yYh5LNCYHjmm31VaceA0rC5oUzbYmLjMvtScVbeZ7EuC
	0khzlhV+PhVGGgG8zeKBCNY03hpu6C+Th50zrETabW5eEjRjYrDUS1Y=
X-Gm-Gg: AYBFou3iBO4zUDs7WU7THIcCcSLmvgezjc4u4LEkFSELzg91J9ks0FFKCnMO4dqzJGb
	/ybU8Tl6ps7gW4fKe12fCpgJ7zFzHZgu0lfgvairPJNU8vLqwuqkC1pkTXDQ5ziYBhTW4uRpeFK
	CJ+bax13x0TmOLA2Z0+AZ9IdX64xaYLKNCIEcodnNNdokcbgJ/OIbA1oxTvtU2uYBHn8xwjqJD0
	DEHduJqvlQMICbMWWbFhazCLXPljg4lOvYjHzUqg5cLrTtjHMS8WxRZ5/5Q59ghE7iBv3KJHVML
	us0OVuonbOVWfYC0M+/kH46nZvK+CNvRxncG6e3NB4gWpYDO09b6fMImrvNNep6h3drmhTAllkZ
	7mPYmQ0M9RITWtxrdujuFZixmiQNfxO7Qf/9f3NTJZDkWwu+4prQCXuamSy3RXQ45bOgc+nFrSE
	0fs4cASaBQJ8+OplJ8OFWw3lRRIDz4MzjHvjPMHQu8G4Z50RY+eX4uImTrgOfucgVQj+ypnA8X/
	uaELdmb+bou6zm3PB2wGyX6eeKhRIVTHMqcP3YhPdrZuyc/vWVwXPM8g8BuBGaLoG2hUGdG1l5c
	pYhDJoFCKj/nv8viY7XnBRvHejW0
X-Received: by 2002:a05:620a:6f0c:b0:939:feaa:949c with SMTP id af79cd13be357-93c15eed484mr268135185a.36.1790032137800;
        Mon, 21 Sep 2026 16:08:57 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19a7f592sm39933985a.17.2026.09.21.16.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:08:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: gadget: tegra-xudc: Disable reset delayed works
Date: Mon, 21 Sep 2026 19:08:48 -0400
Message-ID: <20260921230849.502492-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921230849.502492-1-mhun512@gmail.com>
References: <20260921230849.502492-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm port-status IRQ stays registered through remove() and can
queue port_reset_war_work and plc_reset_work after
cancel_delayed_work_sync() returns.  remove() never stops the first.

disable_delayed_work_sync() drains both and rejects a later queue.
usb_role_sw_work stays on cancel_work_sync().  The PHY notifier is its
producer and is unregistered before this cancel.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Keep the Fixes tag on one line. (Thierry Reding)
- Disable plc_reset_work too.  The port-status IRQ can requeue it.
  (Thierry Reding)

 drivers/usb/gadget/udc/tegra-xudc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index a0585a1f19f0..dd0a033b4a7f 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3932,7 +3932,8 @@ static void tegra_xudc_remove(struct platform_device *pdev)
 						&xudc->vbus_nb);
 	}
 
-	cancel_delayed_work_sync(&xudc->plc_reset_work);
+	disable_delayed_work_sync(&xudc->port_reset_war_work);
+	disable_delayed_work_sync(&xudc->plc_reset_work);
 	cancel_work_sync(&xudc->usb_role_sw_work);
 
 	usb_del_gadget_udc(&xudc->gadget);
-- 
2.53.0

