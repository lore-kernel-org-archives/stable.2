Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07B47AF5C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030021; cv=none; b=e2zOqtc+BgKat96kxIluhUOZazUwcugh83lMDt63mubv8X4aL/Bro45824cnt1ecw3nB3ktBiYO7s8NvUjaYH+C4A+PHqYVrwAYQy+ugCujLkPOaaqCjAUWPZcJ3Os6k8GxYQouY0FGlzutYCHBMWSY2z1WGT6X5P9Gvb+ctR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030021; c=relaxed/simple;
	bh=R1E/w+AxsfP4UPOWvTWTrQQ9pq/bK7zQxikSG96an4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y8SR++0uS1k1tFqb65cMmYlV1N/N4l2vthB+XI3HbxqDmJ7NQOgV5+iwFbQWCNw3BcbQE7doxGlnfsy8pzVcMQL697MAtDOvImVEwiU5uGwS47Acewh+x7Huym7zLeamuTDe2DSSOwuDWK4Rbm5lo9wDAqhVebndJCrOzK0mvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXb3cw0p; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXb3cw0p"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so1625590f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786030016; x=1786634816; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+S1QP0FhvyNfqeqWumDjuFSyxYhfuXzC6OVTs+0PE4=;
        b=YXb3cw0piNylFShcrGbbnBgmuQTPKplvpK8YodMBiBryZWrwdfY8vEFcCy80SjbWtE
         /SlJTXpxCWcDtof77lmZl5F5E3B+fGXbg73pSQGcxStMD1BIgqTe9r3hyaLfhW/bs1t/
         oCfqy3zi+OIgJAOFiGg6RbrimUinkmCFu8YbiAoozqW1MEmrKHANjbwxh4+eMredOSG5
         Ko92h0RqKqZDBb7YbyxKp6gZZokjZw40Ox8yOQn9tZl/H3plYgE5i0yYKqZu9yL/DKOq
         /QDwvWj+Jv2DETV5lymbFCXp5FiwfT0+IH8wE+xt+npr/L934ctguH6NpluGOEwTewod
         ySjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030016; x=1786634816;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+S1QP0FhvyNfqeqWumDjuFSyxYhfuXzC6OVTs+0PE4=;
        b=aQStX7N0cOjQwv+t8L5ws3t4UHtzWA81YXLERZKUheNKbZgezZD7zxrYeEYJqFwyv9
         RrJy6v6Y5zfi311r6WbvGNen5WK/CS4qqhPJuCfjWPFlEtWqNCC2XaFtHgTqrc9JLRka
         /cORdWN5USAXRw1rMRVwjqJuSmeIPj23PhHrs9p6BLDCRPejfdrDoQF7SsTX4XZu0ICa
         8w3VffLndGxRQ51Or1DZ4VbUWwRprerxhtSE0j2hFFihuSDYpNp29OOtyD8Mrc8z63Om
         P2IfPDoHyI8+IngtqXPVGgbGcuUPXVQtkhXSD7Sk7+nFOUWCl9vvvHbot8/iJigWOBS5
         CYYg==
X-Forwarded-Encrypted: i=1; AHgh+Rqy4wF+66V5/QCs2/z/wwYSP58cgcqagwe5/3UcanzRfA6UyaoRPJsmMt8wHAn/VkpFaNocC3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5b1vCwnGaN/tet/BIRfPZTvjN77qaisrkCYFUd3UUElZ88na
	32WC1w0xwXH6jEix3ikjY60f4EJpw9bwbIWlb2UE5qLBEGif9zI7wL1c1rZPWEiJcVFgaIVoH5e
	ygxyFbA==
X-Received: from wrmj16.prod.google.com ([2002:adf:e510:0:b0:45e:9abb:86db])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4021:b0:47f:f828:9f35
 with SMTP id ffacd0b85a97d-47ff828a369mr8592226f8f.17.1786030016055; Thu, 06
 Aug 2026 08:26:56 -0700 (PDT)
Date: Thu,  6 Aug 2026 15:26:51 +0000
In-Reply-To: <2026080322-obsessed-daringly-e6df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026080322-obsessed-daringly-e6df@gregkh>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806152651.2370795-1-nogikh@google.com>
Subject: [PATCH v3] usb: usbtest: disable dynamic ID support
From: Aleksandr Nogikh <nogikh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, syzbot@lists.linux.dev, 
	syzbot+7e1e5911f9eac50bedc7@syzkaller.appspotmail.com, 
	Aleksandr Nogikh <nogikh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The usbtest driver relies on the driver_info field of struct usb_device_id
to point to a valid struct usbtest_info descriptor. This structure contains
essential test configurations, such as endpoint addresses and test modes,
which are required during probe.

When a user dynamically adds a new device ID via the sysfs new_id
interface without specifying a reference device, the USB core initializes
driver_info to 0 (NULL). When a matching device is subsequently probed,
usbtest_probe() unconditionally casts driver_info to a struct usbtest_info
pointer and dereferences it, leading to a NULL pointer dereference crash:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:usbtest_probe+0x3b9/0x1280 drivers/usb/misc/usbtest.c:2822

Because usbtest strictly requires pre-defined usbtest_info descriptors
to function, dynamic ID binding via sysfs is fundamentally unsupported
for this driver.

Fix this by setting .no_dynamic_id = 1 on usbtest_driver. This instructs
the USB core to skip creating the new_id and remove_id sysfs interfaces
for usbtest, preventing invalid dynamic ID entries from being created.

Cc: stable@vger.kernel.org
Reported-by: syzbot+7e1e5911f9eac50bedc7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7e1e5911f9eac50bedc7
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
Changes in v3:
- Cc stable.
- Link to v2: https://lore.kernel.org/r/20260806142511.2337081-1-nogikh@google.com

Changes in v2:
- Disable dynamic IDs via .no_dynamic_id = 1 instead of adding a runtime NULL
  check in probe().
- Link to v1: https://lore.kernel.org/r/2650cf0f-26f9-48b5-b198-e4cb67c59cf0@mail.kernel.org

 drivers/usb/misc/usbtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 98071b25ac076..8759df49be287 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -3054,6 +3054,7 @@ static struct usb_driver usbtest_driver = {
 	.disconnect =	usbtest_disconnect,
 	.suspend =	usbtest_suspend,
 	.resume =	usbtest_resume,
+	.no_dynamic_id = 1,
 };
 
 /*-------------------------------------------------------------------------*/
-- 
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
-- 
2.55.0.654.g21b8a5bc05-goog
