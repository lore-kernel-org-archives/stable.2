Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539441A4E7
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445275; cv=none; b=nUIkAKUvbJ1TbvKC9giosbB/VAFkUZG4dlWaMTqaFySm1Z7TCeFbaPx62VyUn2mtUUOZ+fK74ycjnmJAxWxeGcMIke1MDc+cVFAmE7Imy6wUV9z3hK22+HI+B+zKZYn5z4Mtrl0CD4MJHg5cddOrUR8Bpwsq6NVMHsZ6QbxCfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445275; c=relaxed/simple;
	bh=cKIa06wIrW0ac3Zj9WiXKI6LjS+pD0AlCBrNRRwWLsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldUDrhYFZcCd/DWc69E/bhFTskuwHR1FWfuLlJQuq2tqFsHPMrNhk0avFPUt7cfflLz8m8Eg7UcygxkZYaURv7zoL4odsdU1xVdksuuRmrOfHVona/Hyf8WkERA+Y3o6uWr8nlnBIAie+FzNwxCwGRUas4mbjdtgNCSPXmI3EDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg15JcM5; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg15JcM5"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97e9c0da212so2965175241.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789445273; x=1790050073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xladwkSFDEGqZk+H5BcCxNk/qet3/6nEXAvoznyM27E=;
        b=fg15JcM5StdBi9FUhdKwvOxNXA3txpwL/qHwrCto3UcypGyJ8v3W3HAngvwEAGpZys
         7QMLLsrNc4UNtWIxtt84JbYpnySvZebegEewerS7t4/9umIUUcjDF5r24i97YHHjlOV3
         5fJbXlsjelwmt30bay/DpzbaPOuyLSryr3v4ogStCZoAhtCXi8FjM4PeD0XtvYIWOTXj
         LJGNv97+quNGrkTV7ohBGkBATy0iqKtK6gVITiFadRhoUVwlpYUrctK16nGUcJRB7sst
         2/noNAZh+2Um43el7aQ07jSYonkGYf+gE+oAjENgRPVfypspeaYtx1ummYOoO67K6fEZ
         rWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445273; x=1790050073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xladwkSFDEGqZk+H5BcCxNk/qet3/6nEXAvoznyM27E=;
        b=CghEQ0U+lpwvq0IiZF7Ppt52wa+5joAOhJKmYCOqtpAe4bcNpUNd9kA/aT3n4Mr6xT
         sIIG0nWIjtyxWKiWk+gc8Y8rcB5ap2UaRt13oAPvm7SuqQ7PrJPuU+H+OEufjDsjhK56
         vdP15k6igxs4Kl2UIV4EGlOJdPF2bg/DLH+cIR6Gs+blPNGS3rzDGNU6X3UjdA3asn9I
         5RNhfHsGStULKpOXm7AUUxxqmnrrdL7ZKUA18TjfELiBT2+F7zs4AB0ec1KIkughwCil
         1+21XMfBDyVqzxfigAsZbd9RGa6QwNZ3fF3BZFt/DgToQ5sL1ubLzHBs5qkUoYYlujar
         qFuA==
X-Forwarded-Encrypted: i=1; AKwUvBxEn0dK54xlH1uzvOAR7ArOVmDcRjrkXpuekFVvAlIcjLJ8/ApEb2di3xpaMHGSu7NP2Ihf0wE=@vger.kernel.org
X-Gm-Message-State: AFuF++mIGNuehgMAxC0skBOmHyE5/KuO3b++4xD3yjhiP9qVUCb5ydKM
	/7rsMIlKZVKHeCDGstIyeJhtoYjKq9ld5UWvFJdMN7+l3dMJMoYnf90/
X-Gm-Gg: AYBFou3KHW0SjdDCAb33nH7wuoGVkJW2mlZe0wZwZTGVvYgXKIfuEQ12Dlxc7sfVyFk
	kKsadS/zBJrELKy3UZwmpC+T9WEXTvUNnTwFdH9s655K8qxM7KFe6Bb82S0+d+vJV9jd+a/4YUv
	5q7Y0kAtHDyV+nrcQHaZWejSdvJZQ4XDrhEupVG6J3/r3oXMtFYGfl593Gybw4IUHEVyVLr+2ol
	KiviaOZxpKkjen8mp9hDr4fDb/2dfbatHcfvMUJ3mvtxM4u6Zv0sKUGZReETs8qfgPd100dIb4Q
	+cWkggLNjmD4j/GJvEVgNhHjVcYz5cDFnmxaH+HXXYHhfHOdPn5CHSbbVKuVYUT1/pOhCwwLtMO
	OL6lrCan0qpTqPv2inESjK+6jBL+WVM1Xc910DiY8VnsRyyFnMY6u8wam+BjtSGNsaJqHHZRh3b
	OuyhIQnCdwrH4MFrEK3Yi/XvKB21dHpChWFrVV4dUyzm8PEN3sBdMI6jnyokL+8plP
X-Received: by 2002:a05:6122:21a9:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c981adc33fmr6838000e0c.1.1789445268666;
        Mon, 14 Sep 2026 21:07:48 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470d78casm13754001e0c.7.2026.09.14.21.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:07:48 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Bingquan Chen <patzilla007@gmail.com>
Subject: [PATCH] usb: gadget: configfs: zero-terminate Unicode property data
Date: Tue, 15 Sep 2026 01:07:25 -0300
Message-ID: <20260915040725.2421387-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unicode extended properties account for a trailing UTF-16 NUL in
data_len.  The show and descriptor paths consequently consume one more
source byte than ext_prop_data_store() allocates, exposing the byte
immediately after the allocation.

Allocate an additional zeroed byte for the source string.  This preserves
the descriptor length, supplies the terminator expected by both consumers,
and prevents the one-byte out-of-bounds read.

Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descriptors support")
Reported-by: Bingquan Chen <patzilla007@gmail.com>
Link: https://lore.kernel.org/all/20260421141010.5607-1-patzilla007@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/usb/gadget/configfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 183a25f65a..2041b97ffd 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1351,9 +1351,10 @@ static ssize_t ext_prop_data_store(struct config_item *item,
 
 	if (page[len - 1] == '\n' || page[len - 1] == '\0')
 		--len;
-	new_data = kmemdup(page, len, GFP_KERNEL);
+	new_data = kzalloc(len + 1, GFP_KERNEL);
 	if (!new_data)
 		return -ENOMEM;
+	memcpy(new_data, page, len);
 
 	if (desc->opts_mutex)
 		mutex_lock(desc->opts_mutex);
-- 
2.43.0

