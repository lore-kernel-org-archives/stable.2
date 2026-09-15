Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0723321A1
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435231; cv=none; b=ckRXbj9H0+XKC49YieWvOTTL3QKaJnQY0sp9Aej0BjC6bDHuxeCpaievIjyiE6b6Qk2yD7qK2zdD87Dzlri2x3mgBLPr7RdGuHEnIstHhiZZIXTsrNtObICWWmVrPdiJygz1O1zJLAwvjVzRy2YC1n113A9P3OWAwxuP9LINP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435231; c=relaxed/simple;
	bh=WGU7/JMb3Apf6nVCL6jDk8mWhlmHbK7srTQ8Ag0GJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/RDGSvObFnHKSi0XCt4BvCiQpljbWqZR8+gDJ8CKfq5Mju+MPothIpTLkYm3d+Db+LF0dN/0knUNr7753EEQgmBszH+E3FFzIOSlvy0TSqXCx0v1QnuCqgSepW7oZZxeZ8eeBaYmFPAgF0RLvHVokpqa4Yb4NuhVas1FC35gAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJVI3IrV; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJVI3IrV"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9121fe38733so26836416d6.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435229; x=1790040029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bAgcAeT8h1GjhtSyhK4NU9n9kJiBEpb3mWf8LmEtbk=;
        b=SJVI3IrV1CLOy+CDZ9UVuyWmDnzzLMhQ2Y3vR8W1RGOoDM99LA5KNxW+TLCID4GnVr
         ll1RhGTKp/0/2e+Cd/P7+nq2S7w/33PXzrYUaXwf1buF1V9uJehQVgCwMi0QpIX5Y3BE
         y2i2MbplbOg01kCAf3l72Lb3iorfFUmqC6XoN1W11pyhxdF4wz+vInMfH8LQTG48fqNq
         oypEbB/aUY9rwGpPf/9t0/V9xXH2WSGKwJ1N0AseCgzqbrPaNacgUvuA+ql+hK8Imq7n
         PFKinp9ovPwWBMwMYaraQxBmzf7ND2/t8CC4b6gN+qzKZLjo6U5DAt7l1PWM7TqX1Cij
         2CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435229; x=1790040029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bAgcAeT8h1GjhtSyhK4NU9n9kJiBEpb3mWf8LmEtbk=;
        b=JbxDelpERPRdkqPlS0Bg43H6Nx6UoqiI4Mib8xkc1uaBnJdl+e7+sthNz4PbvO+R8G
         Xhb9FRcXqT5ZZbP1P0XYHahxEW1QDtxj4XVR0tGU+oAzBMcG5lV+hrU5Q4Ufpd1sixS4
         zmHwqbCRPe0gFExt6VXdXyhTktVTKy9EBFexmoqV41fxKat9xz6TLGu3Ou/TU4VBINJ9
         EhjYHXx7skZxoHs536DLxDuShJvTOYWDwdBR+LDDPX+3mskrYg8RpjgXxBXskeKS43mO
         RqE3Nr/sBd5RFxjb/6bgzpAhwR/s7snlMosmmKKyJCqN6rNOFvpZecpun40pNLJ4vpU7
         KzSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhMW9lwSP2VksIjc3j3j2km3GhDiCsDG/9a6OrkjfJ/erdJSnHFNfcfCnOg5rmmq1hPCIdH5E=@vger.kernel.org
X-Gm-Message-State: AFuF++luojW03MwEO4qo6fEEGxG3DL2KNficaIXd1Gv9zjuU3dHwZrl8
	Z+T3L2UTfMLyaAo0bITkqdcLwNr8BhF3mijZdyucICdY91QuZEZmU8g=
X-Gm-Gg: AYBFou0R28hDRXqJGBvT0Xm2CmM+29FiAz+Z/OupGOTwSVORk0jk+/fxPcbVpVIWcNr
	ihez7VcTegzl8mfm65kICPsrge16e4S2Y/3yzDfq7kdWBOBYwv5sOn9VZ5sw9r4zsfnJIcL2HXm
	AFCt/1BFdp2dH3IVLwVc9A/M1p7QUeV/7N0SbXxwAeRrnU1dHfeq3p0ztS4zvEV7IZ5GvZKTspR
	bZ45900xCNOu0dAxMq44/ZPY0ZASUDHTZ3865UK6Ym6PbZBKNXpuwaT0tAPltk5bk0v0p81F1SZ
	WXZpxybYr8GJG3q1ILYWATbqjo+FUvWNbsyTa7d4RAocevIZ6Fo1yiKB3jfLYSOHOJ3O0VerbD6
	zc25DhFp1V/m4S8KgUn2kf9L7KHksZE0OW0UjvqUJowVS0q/d9U8OFcDEgVP+EOfhCu8hLYw43N
	1lYqjzMYMxLo1eMdwagArf7WyB8sR0q1Uus5uhn8ImYfndgelMtgdZ5iXpqfyIFfiOJNbiuM3L6
	yH+HBUAQyHG6o3EnGkKFaK78vEg1Sy6W9U6H0DkdBDyVfXBfmkgOrlU+ZOCnp2slhQrICdZVOKd
	j7o4Lje154EQrpD/fN+DNwiQW6Nz1TsZUq3u1JIJILSsErLZBTfpmP3kFMq6vq9EusHzu4yxTVA
	JzHmTaw==
X-Received: by 2002:a05:6214:2f0a:b0:910:3453:9011 with SMTP id 6a1803df08f44-9122e66e23bmr95006006d6.35.1789435224176;
        Mon, 14 Sep 2026 18:20:24 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm91141946d6.23.2026.09.14.18.20.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:20:23 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] usb: ohci-s3c2410: disable controller wakeup on removal
Date: Mon, 14 Sep 2026 21:20:09 -0400
Message-ID: <20260915012011.61874-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915012011.61874-1-mhun512@gmail.com>
References: <20260915012011.61874-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/host/ohci-s3c2410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -335,6 +335,7 @@
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	s3c2410_stop_hc(dev);
 	usb_put_hcd(hcd);
 }
