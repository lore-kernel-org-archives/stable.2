Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036313CA481
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400349; cv=none; b=KHi2DAuAl/4KXGBigd87Seo13o4oGnvEpcDzwq+RX3WHDovKtWPPG4wU+kYyPIL8v1FjTugg/SqNKNI0EeoAVADw2wuC1ce4vZT/m3Vd5CklDeoRtjpwK0Smv8tZIeFeI9kVKuIe4RcFxp9wdmdes+CVGaqKrsLj3YRfJOfJ+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400349; c=relaxed/simple;
	bh=IcOFbQECrGsg+BWMAa4idv9EVssko8UWfTMGlMoCtaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3J68bmqV7mK0yGmGH3TjMWToB/UQmQ0MmfezFvuRFHLwtVpMITtshNn/vxe0ZgsRriGil/gTTx2mdYqob0kYbn/MeRhWminQWusZdZQ5DleZT1WHmRcw+zcGVE6RVo8dHCS7tbG/lHR22G6cSJEY048ZKs027L1dZuFRs39nIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nslRQb40; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nslRQb40"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664b1bab782so243009d50.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400347; x=1786005147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vgievnc30p13gh89t//6TkQGWNlUGXGtKcqogQzVYjU=;
        b=nslRQb40UlimLZ9ohhz7Qsj8lutt4mAyvPSEFUlFDuGGJJ1CKKkwABKRy02WsTX6Wg
         SXIxaT+iqSvTSJ2glCOyxqzgtPB1atXk8W36xeIzIeP7ZWMfdhc0LECLrmwDO1JBdqQH
         xVuoy0So6HczWzJQHnsfhpIWe4geG7sX3tvInBJpvt2rDiuGWahY8xE6NG+9v3PriWdm
         9lukEgr+og3ULBz53XD4pUT8MTuF6aiEEdZe+cPCzeiH7vDUgGe79rW7ZvGke5/+NwKG
         wSvJntC7wIOLf6/XgwYNz8gtPTtkRexhepa2EHs+O/jdyRFokQn6wt5cov+vvigMANzL
         Uebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400347; x=1786005147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vgievnc30p13gh89t//6TkQGWNlUGXGtKcqogQzVYjU=;
        b=l8J+XMxEbmH+M9qYxjRgR3rLSoVbh2En5GGw/wcK3bZPOEd10XfzRd5yVzhbqYEGsI
         d2w0bU92GmVSk7/lqnAAkbCt1d77jZmC0NZTy/OLEpdMa1okYwwbCjUiT6rBMCxkejL/
         kG9oEirG4HxSgGS4ESbbXZDADnoF3MqFOw/ibVEVgAEF3SS1VRpaEBBttL37jrzRWSf8
         Wov0vwaFcyRY6cL+MWpQ4GQp42j0h7Zl/TiPuYZHdqsrdAB+ewNRKNm3GbnKrxnxd/1B
         85PQb1zp+9KacVXl47yNJZB3zDXteNCvcHANx/pBMtTYJkIb4r2sg0LeQSZJTTSx5Z6+
         TZ8A==
X-Forwarded-Encrypted: i=1; AHgh+RoMtL2c6vq7DaaJS2298wfhl3VOO9V2H/0sA1gqGveVOFUrIXc2we45KNZjYWN9HHO4TtDISYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXq9PZLlBX3gxIzt/trhujNoHP+WB5z0tms7PkQqI4V7PKPsB
	+2U8qCOhCE9iI3ZmR22++DN0Tx2wXk+z6vvjqj3yGXpdkxK/2HSF65is
X-Gm-Gg: AR+sD11xeWerr1xm2Hu3QCIGnHk4SoVWkgysyQG1LfDlyevmvpO/7DXnIeThPeKwXLd
	WEBR3fifz9MjHOQTzcVaOtz7m04f3onK+DbsQZPihzyKzuG43UAU9UKxPePAXrtTjdXWxZgVaaJ
	esbOcPZnVpcdIh9psq8btiCdJPmMrfLvwU0g7gB2g6TlIXR7yn94tJlammslyjMn50c2a3CNFRX
	5gxVpq4gJUmHpP3o1mb2rmO3e1sNLVo7CsbvzxiEPODXkBk1ZXW6nj6JRO1vzZgjozanVTNv3yw
	xLnXvVZQnP8WyRevjM7x3UIM3HO3VnxTvQ0v7xEuBnTz+KEhhwa1eqBT1w6IjXBuGX8PcfAf+yf
	XBx17VkA3rPhLIzZiBg+IzT6T8doZIvdo3SBfBghtLl5rkYwYwyTXDmXi2qLz7PLKtHhzQH5X33
	QmRZhUEd32Ktr2MykrwdHXzTYziBZaX0ykOvUtVo1p9Q5/Tspj0pA5ANWw23nqeY7kRoDqPtd1f
	8RbEK5ZI9X/mOA/3QMrI8i1F8CLVoV4UIk3oj/l3y60X6RkVg0D8eE=
X-Received: by 2002:a05:690c:d8e:b0:81e:ba5b:97d2 with SMTP id 00721157ae682-81fb8a85be8mr18762137b3.2.1785400346780;
        Thu, 30 Jul 2026 01:32:26 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b2975csm6206277b3.48.2026.07.30.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:32:26 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	Ankit Navik <ankit.p.navik@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: fix LE list UAF on reset
Date: Thu, 30 Jul 2026 16:32:02 +0800
Message-ID: <20260730083202.2065336-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cc_reset() clears the LE accept and resolving lists without taking
hdev->lock. Other command-complete handlers serialize updates to these
lists with that lock, and the debugfs readers hold it while walking them.

This permits the reset completion and a debugfs read to interleave as
follows:

  hci_rx_work                 debugfs reader
  -----------                 --------------
                              lock hdev->lock
                              fetch current entry
  list_del(entry)
  kfree(entry)
                              read entry fields

The reader then dereferences a freed list entry and may follow its stale
next pointer.

KASAN reported:

  BUG: KASAN: slab-use-after-free in white_list_show+0x15f/0x180
  Read of size 1 at addr ffff8881015dab16 by task poc/95

  Call Trace:
   white_list_show+0x15f/0x180
   seq_read_iter+0x3ff/0x1190
   seq_read+0x267/0x3d0
   vfs_read+0x177/0xa20
   ksys_read+0xf7/0x1c0

  Allocated by task 91:
   hci_bdaddr_list_add+0x1a6/0x3a0
   hci_cc_le_add_to_accept_list+0xab/0x140
   hci_cmd_complete_evt+0x26c/0x9a0
   hci_event_packet+0x454/0xb20
   hci_rx_work+0x293/0x730

  Freed by task 90:
   kfree+0x131/0x3c0
   hci_bdaddr_list_clear+0xd8/0x160
   hci_cc_reset+0x28a/0x370
   hci_cmd_complete_evt+0x26c/0x9a0
   hci_event_packet+0x454/0xb20
   hci_rx_work+0x293/0x730

Take hdev->lock around both list clears. This matches the existing
mutation and traversal locking convention.

Fixes: a4d5504d5c39 ("Bluetooth: Clear LE white list when resetting controller")
Fixes: cfdb0c2d095a ("Bluetooth: Store Resolv list size")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9630..00e2683f99ed 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -294,8 +294,10 @@ static u8 hci_cc_reset(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 
 	hdev->ssp_debug_mode = 0;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->le_accept_list);
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
-- 
2.43.0

