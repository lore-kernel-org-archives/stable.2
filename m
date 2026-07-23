Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59F4A2E19
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810693; cv=none; b=f4U+uSdSVFytZaCRAUKhBV6HltNt2rDysv5Kp5jD/91jLh4Mpl1JC94Wd+ZUL1NK24iN5yb48Wsw+V+mLaDUeUpD47HhccN/hdG2sONRRlUxkYHw61nEgF8zB8Ojn9dOnFNmXccYVkWBaVxmU19Y2jPm4R2MvkFzlGHWYQYVDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810693; c=relaxed/simple;
	bh=Xig7WGnnLktfSt85EJ7ZIzdmITHXE3yWx24ihdGcLcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PC0pjkoBE5KVjG/9dOBk4DPLRjAV5WGa9UXpyUaxNEXwMim2k3wo/d54t+GTlH9Qigkh/xShKjAOitmfNxXEtvcRZ4rXCQ+Zk/Ie66d+c+qroB5hSCNebUZu1h73RCImU8Okvr1MOOm0qDF3StXV0ES9wgqtYCWNsqelBCpU0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tU0wcZ9M; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tU0wcZ9M"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso463515a91.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784810690; x=1785415490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lN+WRJy/Gb9/DDf5BT/PAkv7b2aSSNr6Bp0UfhvwTgY=;
        b=tU0wcZ9MlmzZTb0tUzlIgVol25l0VBk3VuJH7HtsYs8t2J7xJDU15NJobjCk/NSfqu
         05LPKNQoy61y0eTlMOIF9CNXZDGaa9anG1oh8tDvr+FZ9PDBx0cLEBDYk/9j2op9zeQc
         E2XVodfMFl5oxMKhZtJOT46mStwpzn64WV3HcYz0LdaJ/iJk+YqQ8yLIlRbtmiM/wlRN
         ROA6qTV7f0r9FzNDWxbQ8V4I1krpO3MAf/LYK2t74Z0CIizuFULxPQn0OiXciL01+c4B
         AN+JOESBmd31dN049nQvWXH4+92sURc8sF3uijODtk/vz5NZjW8sxCZocjcdMGwczSA6
         xOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784810690; x=1785415490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lN+WRJy/Gb9/DDf5BT/PAkv7b2aSSNr6Bp0UfhvwTgY=;
        b=PxNE0bGIT3A0bus8VLP8vMJq0RuZt7+txRk469W714dYqSCc+UJWVBzoVjQCVUuN/z
         zUMMJSDCRN8/cCn58PR2TEbrVLB72GJ5mgswJbcQHKTDYISGiu+PrTc0d259v04ygQh5
         TtytRtnCN7xM/BnThqL1DGLoB0i41ifk1ujF8Y83a7EGzaU8qgrssM+qPOGbZBiNNw0V
         3aSnS3od58AGDliVJYbp5qw+WMm/TwFTPNBuhJWzZqETrhCCw2yLVc8UsbbYO+aBrysB
         Q97pxYnA3bqS5Q6QbHr//aJMYuDDLyNvyRwYcOKbiV674zLzq4+0t8BoOSjfjfuPxV/7
         mjxw==
X-Forwarded-Encrypted: i=1; AHgh+RqY+uAasbZOVkgMJlQT4uNqibVpz/lhOdUlctt2zGQOQ1yJ+Xe/vAehOwJyAymIJrAV6GeIdZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPENSf7ih/wsTb+5tzLOrE7+jeCxi9VDo+/6sQe6CVwXcvf/2
	aMAmrS9LpKO37MNu/yYKCPoIIQXjDpuwyDNmcxHWkDIlMRQK/plm2h5S2DOiU/7OGxm1VVI02/A
	2bgj3JCA=
X-Gm-Gg: AR+sD11Iaowm4iyhrm8hD/34McZpMCIXEjRRdRTAtaTupG5q2EzIQhaj5aQgBBMoeVU
	K5Oy22n0FEQlslvPie0a+4XBXyi5pjkKdxdzwDMgIJlAeA6oXncw1FcyCi7k4VfZnQ0uAZnr/YN
	WWEF8UPlruHNrk2O/DU3n5VJ8KvKx6VW+iPhbJvfyWqfykoCj+1pIv/h218AStIJ1DcuBiY7pHg
	dcPzWxhe82ByhQVI4vOOoJW7nh7CyFZeuSAcvNU+fCoE5v+/v/rdW/fCpRv/wjmIFS9vviFR0+X
	DRqT4+LyqeMxX+dg/ke/o0cIN7Uw8swro3pJH1dgxY8ATtPfx27C8KRuy1ve98bYxGWkD7o6HKN
	y2X9yVP7QeB7Ly9HihkTcOjWKsK2Ql1oYLddNgjhS/Su8cvEZRKLNKcQkPtdOv8eMt4vJJnylbE
	6xk+ftBhIoAP4/uISfbjjNdZA2/wg3z2MoFWUjG/qtB1zXQk+TLMKCvc2BMxCe7PQSDbGkbrB+Z
	My74VQOOd0lAiOs4P3IJrMP
X-Received: by 2002:a17:90b:5603:b0:38e:7eb:d07b with SMTP id 98e67ed59e1d1-38ec6622023mr3288256a91.34.1784810690513;
        Thu, 23 Jul 2026 05:44:50 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13d1300401fsm21663197c88.3.2026.07.23.05.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:44:50 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 23 Jul 2026 18:14:16 +0530
Subject: [PATCH v4 2/2] platform/x86: int1092: Fix info leak in
 parse_package()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-platx86-v4-2-93b4a178b595@cse.iitm.ac.in>
References: <20260723-platx86-v4-0-93b4a178b595@cse.iitm.ac.in>
In-Reply-To: <20260723-platx86-v4-0-93b4a178b595@cse.iitm.ac.in>
To: Shravan Sudhakar <s.shravan@intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.13.0

Sashiko reports a possible information leak that can occur as follows:
- In parse_package(), memory allocated for data->device_mode_info is not
  zeroized initially as it is allocated with devm_kmalloc_array()
- In the for loop after the allocation, a malformed ACPI package
  provided by firmware can cause some fields in data->device_mode_info
  to remain uninitialized
- Later in update_sar_data(), the uninitialized fields gets copied to
  the fields of context->sar_data, which can be exposed to userspace
  through sysfs attribute read (intc_data_show())

Fix the leak by switching to use devm_kcalloc() for allocation.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260710052806.100107-1-nihaal%40cse.iitm.ac.in
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Newly added in v3

v3->v4:
- Updated the commit message with the information leak path as suggested
  by Ilpo Järvinen.
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 7263114f0b3d..f506155f35d4 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -91,10 +91,10 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = devm_kmalloc_array(&context->sar_device->dev,
-						    data->total_dev_mode,
-						    sizeof(*data->device_mode_info),
-						    GFP_KERNEL);
+	data->device_mode_info = devm_kcalloc(&context->sar_device->dev,
+					      data->total_dev_mode,
+					      sizeof(*data->device_mode_info),
+					      GFP_KERNEL);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 

-- 
2.43.0

