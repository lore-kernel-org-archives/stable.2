Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7113BB4A
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435238; cv=none; b=D1KILo75wC1G3yBg+yQIRZL1p1+HiYzgobC/ksoAAcSMdv00CdygatewkLAc8dphkmNolUboq9JLZpR75yK3RNsqYhSlWTS3DsHaw9l47coIMkNtqLrWoDZHXhH0UDRn7lQKB/wC0px0C1GCvIaglWiMeOp40xqK4jaVBnGb3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435238; c=relaxed/simple;
	bh=cSt7jQUGq64ZD/zrBvItYaOU0WRDoEfcG5mlUjJSbrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWG6ssGfI7V0aycxPffmvOF1sMK4EIOaR2Ub3T/LXUkp2qsZvygePAjyetclzOZDKqlX/ujZk+RmyYCgcOqgI+MIC2VKRRArxvTWxTzz/2abLMmxUWLVYcSXQigaSAZHzE0vdzq8gR3nGzCa6WVSkfttyl2SzmJoDMxpGXHLNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9xycnDi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9xycnDi"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cc64570deso4991786d6.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435232; x=1790040032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmgxL+YzDrrZHo0jFAYUF9npAPr+/wsk6K1vfZ01BB4=;
        b=i9xycnDiRp/WQJsCAXpcVklYYWg2L5AIK+AsS2yNczylEHawYr2OWQj8zqz4BP5fu1
         DxXgxhwQOaa9b858i0xJx03rQmsobIVv2K7n6gH9mjAWUl6gTZ56oWFBv0M4b8BwOO8I
         CQSHT3hKZ9fvJkDWx3VOUKHP35EAeRobOfgRwVFhFiJwd22o6eBvbQbB/Eg2Q9LdBvgj
         oKU4P9dZZHm1IBIV2qS7d6/TJNCyvRkXbIL4gbJ8lc8MNskC/FqtXeZcIu3wGlncwxds
         lRH1pCOrhy50djvSN9F/Ndvsr/YrfCOImlyBsLBo4pgr196vkaIr1uzvzxQRxxbUokJm
         ZqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435232; x=1790040032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OmgxL+YzDrrZHo0jFAYUF9npAPr+/wsk6K1vfZ01BB4=;
        b=BjN3LerxDap+JicWc1kHRbEsdSa8GRbc+O3j0Guc2dhcZVUKb+qx54Vuw06l/MqySc
         TmLSdtNCqGkoRXCKCbDmEeqjLrk0hjV99GUwEz4i+czHGXcAOT48rF144pGFR0OHAwCS
         VIUQBVu/CZQ2we8Xvnc8VTKAp6fC/2gBbzSWv0God9yHjZ/K/my9Y86ayyJPwxBnrMbP
         5n2PYVAG10YMEwBZrbl3PYUh59MzPj9XN/Af4oXvB8YbxdWnT3TmhlWSAbMuYIZznyNO
         m4kgoJMViiiMEX1rwqdqqsTRh5MvridVu0y6kYyCXYF58YmdmE9dzI8sxgLG6ZaK0ECG
         mnFg==
X-Forwarded-Encrypted: i=1; AKwUvBwiOdH1TqG2bLeXOQLDg3uKZQjzJ7sofCdBgZTPJ5m66UlDhdlCMcWoT5glNPsyhc0ViJvC7Uk=@vger.kernel.org
X-Gm-Message-State: AFuF++n5lt/h+wXzN6LPGF3+UtMf3Mro6jWKWQ9RDaUeBpfNzRhoCSVE
	iss3WbYCKjP0xI/Ucl+ZMrMhArCpVCE7BUMJkmwbEmBHH4yXb2bw+/o=
X-Gm-Gg: AYBFou2LTUfyJW5tZkll+FW1gQTV+hnJ0ZzoIzMdH+oQtKUV28fzXnD3EGeztid+5c1
	W+m2pd140FuIdQUpOi18ok2A/YDyaSH/AlQLDo1DmJyIUk7uj1wVWvtBkuu95nZO7IVBKD0/6ii
	gKQK0MfUbUJM6KquGSmX8f422htdVQLrQY9fT/mTWyvpBHO7FOVzyJYElmj6tmq32KrAdAV04Zf
	jlwA1Vjh6PNlm9JCjQNTmFuK0NfRm+/HFwKc/biru06g43+oCBt96GlR2G0F6mm+4HwW8CzHrmN
	gCOKtk4gssvo8LznLPr0r+lo2L+9wMWfXd8M0tqUY05qfZ4uz3sHf5+LKqdfVcjtsbkN5k0CJez
	xAHnst7BhT9wKrMgtplqG5G8B9gNTbYgsfKfCXJGOEJQMQ8T7EBONWiiJLGzZgf1OzMIp+9lyVZ
	r4QDoBk3CkARn6BH4MuR7BunC8ep78uGkCUqB/9rXz2gJFGzE1LZhIRhSVW/EPpaCe8783OqMr9
	T6jO45aZ/DqZcCpmAtD3qho+pUwgc3QhIwETPIIYaccF5qISoGmOPT4MsrrS3i6muiAT4i98W7a
	+/trGjAalqHnU4WW8aB+ZA4vXMAzQM9efn+qm4R0y52MPhjNHfQNFZcbD9F8DGOMLvhBwQ==
X-Received: by 2002:a05:6214:4383:b0:910:42f3:958e with SMTP id 6a1803df08f44-9123441de5dmr26302696d6.27.1789435232163;
        Mon, 14 Sep 2026 18:20:32 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm91141946d6.23.2026.09.14.18.20.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:20:30 -0700 (PDT)
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
Subject: [PATCH 4/4] usb: ohci-st: disable controller wakeup on removal
Date: Mon, 14 Sep 2026 21:20:11 -0400
Message-ID: <20260915012011.61874-5-mhun512@gmail.com>
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

Fixes: d115837259ad ("usb: host: ohci-st: Add OHCI driver support for ST STB devices")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/host/ohci-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -235,6 +235,7 @@
 	int clk;
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 
 	if (pdata->power_off)
 		pdata->power_off(dev);
