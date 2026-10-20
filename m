Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510885;
	b=RClOx08yQ23XCcA3y03Bidfe6pZs32cKLG9i2GriGtOrpIwr9JLGw5nn2L7mMGJiBXHS
	 OvcsNW89TqxiZ9nntEsrj6RVN/UVCdU3iLct1JdZUPB8n2U9NeD8sPUgCbA9kHn9wGxk+
	 U7cc8OGiTR3nUE1wpocJsECXPk2cY0c2FURCPENJO+6T0ZAVdJpJQa4aaxKE4Bp8ZnLvz
	 e/hxaTFg9OqXvxngOt26FIOSyp9cYbUSB2xzwpvelbSbbqWo9wf4qoUp4FefFwWLjIjyz
	 IGCGABliWKixyj1Zq9hFFP6acMqATmqscGyqwZOjbZ4fG6mCYhkEZFkayRQFpYAytcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ivM2a0ffySwRM4S5Ey5w/xRUKSjlg2d1AVy7Kzk1QBE=;
	b=Aj75V1yPybOwGQw/WfqqjuovQOty0frGM+x5AM8zDd+wsXuQuHR7APf6ZXCs3ypVdmHH
	 X8BEu1ezbx1WGM8n9UAFNjchvhJpEIsQ3e+Epwwv+xX15LVt/RHf9DR9HiHIXexJt86TU
	 cyV/QahuBL+Bvx9c45229qYljpKs1CKMeV9LIaZ+8eYi8SBFLP7W9sMy1SVOCY+Qc8rDy
	 8uE4qSbSzR4fw/HtI5FwP+glUXF3zRy6SgTa1MeOAkeTNqMjuYbnHB/x6Y+PZzUWWsQ+b
	 283ZUN+Mhcup03gh4hLsoO7TRgY7Me0UZdGnGIR3usl4CP6YoEJRRDHoAHYLajavC3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UT6dl+1U;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF2606A322
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08BF2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UT6dl+1U
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so5812025e9.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510883; x=1793115683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivM2a0ffySwRM4S5Ey5w/xRUKSjlg2d1AVy7Kzk1QBE=;
        b=UT6dl+1UKQIxCv+VgRp197jib9E4og5y0xRVppVAMtZt45kXyVtTVi3Cbsn4ohDWp/
         oRcwGMx4KEUFhkYh+MQKUl6vYIJpySvNp2bSW0BVeSSFL65MAJrELvfXYjaTPpBvCooZ
         7XxBXjIoVH68p2TK/bIShr4ySfe9CBfwwYHqi7+gFRDn2eXQnOleMzR85u0CyZRbOsdN
         yMerjxaTaJSJxRhTwMOj0EtkTLk/m09TpUfphSYGsYuKGR5/RArWLwDdiIh9OGk2YrzM
         iK/z0wDPZ0Ko0RpElpusIIQNVKuFXSh16Sgynaln74LUh8uBtduLGiqGfIcZXOvtr/mO
         j/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510883; x=1793115683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivM2a0ffySwRM4S5Ey5w/xRUKSjlg2d1AVy7Kzk1QBE=;
        b=dyDceAz+qyiSULfkx5j0q0EaoFFPUnpAYlAocnPuip4ZyN1I75GmCOmVajXvZXBM6h
         vLcgPvrJzsPoFYt65mnsVh+OEkbrbE6C/4Ailnyzu651PbQrgKUZVlAAjiT9mBchV12w
         0yduZ08sLVzUKKHBWD/gSW506ubOw+t9De1ONor2omEhv5/qSn6QNEolHItxCTbHUi4f
         PQGivEuJdY2v3oQkUAqQ6YvUK1sPuDxpPndc/XR848KOH9pCMj06mPQnpdyGOhEmr0Kg
         NJESnJN48Nn7L/k39xkIOmTVxUIq7rVVZuoH2HXChGpvfeOJi6XwkiNw2bNqGPQNlBLs
         s8Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwMrS/7dT7Rz6Iru/Ipxpm9v/O/gBHpGcOFVWugnyE0dDRMbfTvpc9t/S7phUT+51I8QipqJlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrNlGbTq+ohIZ0hI6US7FAKKkKpRUXsVZcAxml5SdiEaLHzGDF
	SeFHc0eHbvl2Np+ExNUWivU3rCA1e2QXTI51ZQUYrYFeB2VNlpmLVxAxJK3f
X-Gm-Gg: AYBFou3V3kvHjPW4asUt0wM6K+hNHyRhKxRds+sLdFug3zP9VC32NeKCjIckDbszgX/
	TuFZFCPeCqNbzUMZFueSG1tO9cSGm6jSBm57zeeLfulLO++vM9cu/MyVHPaxjaKNJruz29Doh8e
	mXoGFMIi3/eCf8Dm6SS2uUtZn9Uv/D2RldP/2Vt9uHrBfXWd4KiRdYF0u4uyoLkVT4gh7+0fTtT
	7DXh3x5oF+Os+S8UayMG7x3YmHB9n7qmUcFoFzwGJ2E+cveckqNJH9JAQK+3OMNPITaeOd/cg3z
	4UcEbyZwvl2zKBUKuPs0gdw1O0WgpY9+7VLhuQTX31O0yva4nU6x+aWtfyuRRGqvLGJfRqJ2GxD
	STelML+rz7xfdcFHX3i2RJ6ZYWqVP4WXi0HDSHON/nVHXptvPLCFAJtAiM+3WFjfpkkjLPQYzGN
	1zKUkYZw6oUu+J6CJigeValyLaHu/IN+EG0eFIBKQ=
X-Received: by 2002:a05:600c:350e:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4a1f4e8ae6bmr55223815e9.11.1792510883070;
        Tue, 20 Oct 2026 08:41:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm256606155e9.4.2026.10.20.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:41:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 1/5] extcon: max14577: cancel wq_detcable on driver unbind
Date: Tue, 20 Oct 2026 15:41:15 +0000
Message-ID: <20261020154119.2568395-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020154119.2568395-1-tristmd@gmail.com>
References: <20261020154119.2568395-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

The driver schedules wq_detcable as a delayed work during probe but
never cancels it.  If the device is unbound before the work fires, the
callback dereferences freed memory because the driver data is managed
by devm.

Use devm_delayed_work_autocancel() so the work is automatically
cancelled when the device is removed, matching the existing irq_work
conversion done in the same driver.

Fixes: 962e56bfcf0b ("extcon: max14577: Add extcon-max14577 driver to support MUIC device")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/extcon/extcon-max14577.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 5476f48ed74b9..905722ede7ab1 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -763,7 +763,10 @@ static int max14577_muic_probe(struct platform_device *pdev)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, max14577_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &info->wq_detcable,
+					   max14577_muic_detect_cable_wq);
+	if (ret)
+		return ret;
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			delay_jiffies);
 
-- 
2.47.3

