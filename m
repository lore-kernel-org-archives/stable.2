Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D223BCD0A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464363; cv=none; b=o9aWSsTH2xd46Ag/Ee2xNsRg1T8/Rq41ofpNa4lPMsVfULVVY9GboRxFpJVAe7ae1pPTknLwGIwz0Bs7sqWz+kS9/UV87+JHVlUBHabqh832IK+ETWAq9rbap9DZNWtp4AsjDAcZ0yEy8SDEizf8YKjPPeeNX9IUYbXf9TzEe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464363; c=relaxed/simple;
	bh=3v4BhFVPmtY/4EGAVqwrMznFB+Ecyz61DzuAVdipuhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+GcZFPkeE7dfT7JhxHdExWTX1BFkFjEAkE+pTh2Mmz4/mSmihuw7OHSkDfkQqiCLj60/s0UJEn2JT9aWAARe0xZ4nj1/VgfmZHhiBP41HjdWvOh8MllpcV5FmyrYmVBkwj58WmZzxJ/jxYp9CN4fOrfFy7A9haj2cuG/VXulqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA2W2gFk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA2W2gFk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceaf8a1265so1266015ad.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786464361; x=1787069161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVGV0R5tdq0CzGSbWbNPeQqwE8jl6T9+ZKf8qCD85WY=;
        b=WA2W2gFkrQsu2rrnyJOCgVhxLj9vMqZtjYxYOHfLNT/ibHiiK62eLpfGh8OJLLO8Zl
         0HC8wSJcwCm8NVTt6jcbnrYCg5yIinaUCbtqAZNzgx8tVjC+2Nz0BKkAZwvzyoVbv0bT
         +K8xPww22mahwykJ22ZEE6uUj9B4Siy5+n3O/nb8knsXLLiEqGFVLxot2+ASa5v9Kas/
         +AlU3VxpJztP7zkRBONR6kyO6sYBIALONo1jL1p/VuBjOqtstPbV39rbJ/03G4ijeRXM
         2ZLkLbCuX3lYTr/XWhX7aFVKeq3q99jCQwqVxBKkGHHAr+gao6t/wG5BwRNhuaiq1H8A
         KYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464361; x=1787069161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVGV0R5tdq0CzGSbWbNPeQqwE8jl6T9+ZKf8qCD85WY=;
        b=J8bO9Z7qZvzTaIFFkEFnkltfMK9E555EZN64NIN0fRwrRFCmqNa4WCo9uRdDPctNkf
         7Ops8h8XTg7a4D6OkA+Q8ssjg6OqcBmJOZLngUu4tWyGUubvgRrpqUZ05O0WIcklpSqb
         8y83ikA5s+Mc3q3sExqmJHjkhLKZqLC5RPIe4VhhlJQXS8UbmM0rMlJ98GiUn+IBvViE
         lrZD+XeEvaJM6ZE9EgIJ0i9mAjn3bsE5GzhQCf9MUbqI/T6Y0UbgB41ZJrhyQhmgXma6
         ZFlBYBYErXmE8N2+V3wAIN+HhhVVB/ob2wtxQH4ffUYegnmWBe62gClU/bWcRwVMOZUb
         B2Jw==
X-Forwarded-Encrypted: i=1; AHgh+RoixgON2W7nENhwxVqsYGXOFrj0gTWZ5nYPeALZia8iTAUdevtxgHkGUDCgHtyEVjNvS3GYc6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVg39V6jsg1T1Ktjz5uD3KqB3sEadPhRXWqa6AZ0ujJGIKt7Sx
	4QIwXUN8TnvxaC4ns+VbvjL2g11sjzr5ix/GF1H67uXfwNenlylFZ5co
X-Gm-Gg: AR+sD109qQCgjzlufzXiA52+alUWg96WZTHC3AiHnh0+AXCQ06NUO69i7kiON4UlRHT
	nfDAu7fQvOvKYPM+HMdJf59npQDtPFIPT5H/ozeDdbr6TVb02CWfADzL9W4WuB+7B9c5CP/7huw
	fUvM4V6ueUCtTXJ2IqvYoTKhERrukPACL1ERteQIKIWgX6H2WQndsias63oZTEvd94CmLz1Xu5r
	zbE7aRb/5waYPv3BK7+IP57r3IUNdRSueCcHyGGSeqL138krDgUQvBA+Cn5BYGSLS9QeUD/jbxG
	08za7+vmwJClva/l5D4jJkEc7aVGtT0WvfDs46FBKZ7JZ9MFV2+n/sROfEWm14iA+K/121ToPjL
	/3WqHsEP6uhKBVCqkm24ak3Wj51sv4oKv/E4mBGUKEqt32z+vGlWL27vZWgMEJbx+8/OMyiOjMG
	6W7XKg+plRULgxWpp7mq9zO6uyITtSVb+9X2bWkuBN9fJB6EMK3xh0mmjy1vo7CKFVzg==
X-Received: by 2002:a05:6a21:2d8b:b0:3c3:a1e6:a626 with SMTP id adf61e73a8af0-3cc2bacd73emr6410918637.32.1786464360559;
        Tue, 11 Aug 2026 09:06:00 -0700 (PDT)
Received: from Default ([2409:40f4:1011:30f7:310c:32cf:5ea7:7043])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3624c08sm916149eec.5.2026.08.11.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:05:59 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	gregkh@linuxfoundation.org
Cc: i@zenithal.me,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	Jeffin Philip <jeffinphilip14@gmail.com>
Subject: [PATCH v3 0/2] usbip: usbip_host: remove legacy rebind_store in favor of drivers_probe
Date: Tue, 11 Aug 2026 21:35:39 +0530
Message-ID: <20260811160541.29461-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_rebind, which sleeps normally gets a mutex lock. However, it does not
or should I say, cannot check for null udev between spin lock dropped in
rebind_store and entering do_rebind. This is a potential race window
already. So, even if we check for null udev under spinlock, we cannot do
it outside. Regarding do_rebind, it is called during stub_device_rebind,
but that function is called during module exit when all files are removed.
So, do_rebind is not designed to work in a concurrent environment in the
first place.

We have a safer function that can already do what do_rebind does,
drivers_probe. So, we use drivers_probe to rebind the device rather than
use rebind_store.

usbip tool references this function immediately after the device is unbound,
which is safe for the tool itself but since we opted for drivers_probe, fix
it by using drivers_probe rather than rebind_store after unbinding device
which is more safer.

Tested and working in both userspace via the tool and manually echoing
the busid in the related nodes. rebind node is still left active with a
warning to use drivers_probe upon encountering rebind_store.

Thanks,
Jeffin.

Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changes in v3:
 - Removed rebind_store in favor of drivers_probe to eliminate race
   condition
Changes in v2:
 - Addressed concerns raised by the Greg KH in v1 discussion
   - Added usb_get_dev() to get a reference to udev preventing
     it from becoming null after the null check. Drop the reference
     after using it in do_rebind(). Did not fix the race.
v1:
 - Initial patch with a udev null check that returns -ENODEV if udev
   is null.
---

Jeffin Philip (2):
  usbip: usbip_host: fix null pointer dereference in rebind_store
  usbip: tools: replace faulty rebind_store with drivers_probe

 drivers/usb/usbip/stub_main.c      | 27 +--------------------------
 tools/usb/usbip/src/usbip_unbind.c |  7 +++----
 2 files changed, 4 insertions(+), 30 deletions(-)

--
2.55.0

