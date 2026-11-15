Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729753;
	b=XucjFcU76YoiltYr2O7uc5JixJvOdY3uiWpGJEke0RKPyPruDLazKhwPTINpSe5j9gHp
	 1MRHs6ARELqvS2WBN7K77925YM9RZ/zHOq0LPby/SEQgVALAeEumJ/f3/bxDtCsiZ+ZaN
	 8oOpb11Gpz/qyCQrN2NGBe9PaqgNCzUpl0A05qPP0azZ8BdqMcRNZ56SoAimIh7Egt+wy
	 v4wgi2507zAg/bN8f/VIiCD9/MLWemab2xvt9yCa2PGIZgHDBxvRhiyeKy5zGknDjF8vK
	 AR1UZeCR10jIVIkBXHqLzgiO11+OCkgbR44a37fxJgRfWSv3hwTDb4PNueehIYGZ6pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729753;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1OO0lS3mKKeof2v18GumxH/mC7gZUca+/4y3VVU/5T8=;
	b=xFOVskshDB+3rWTCUCjCeUFXTRwmtQjuKjlT04aWuV134Z8rSXlCWQ+Gwg1EzFB7kOA8
	 r8Ue6+5733/yIDff32SdXxmG+yyZEEERB8eRGtvX219ax29UMlhB4ZsS94ZFOMYYiBQ7f
	 SQtYaqCwFI5IlVRwmBcIJwZeGiNJWJpq/pLrUgsSm4GNfpy2XxgeQEJ5+ig2//K/39v9T
	 WT1X3ZS72M0YIxPcFaTwYpJtuEvbGs32O7s6ZusiDLRxSk/HN0hkKcX6YDKO2nyh8yt99
	 SKX2oaR2syOYODioK9FLIzrUN+WVbA3slpZ+/uXW3KS9rcylbUtW/BZS7HvbdRl2Nkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I4iEycBq;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB989606A31E;
	Sun, 15 Nov 2026 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB989606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I4iEycBq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1O
	O0lS3mKKeof2v18GumxH/mC7gZUca+/4y3VVU/5T8=; b=I4iEycBqkHO4C11nrC
	WuREO39zmJgEbNU8PlJrHW2hcGmVLQajiqArpMAm42TAIL94vMxDdnMlTjc1Rk8+
	aZDh7F4eGaP29QE+5N+/IyZ/Tv925UfMkmAzFaLV8ZS3De0bK6N7N2Hwo1t3L9+2
	fUqi/j2/lCKG3hR9CwsXvswRo=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f3sMZ_lqt6_vHg--.43860S2;
	Sun, 15 Nov 2026 16:02:20 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: cougar: do not resurrect a zeroed shared object
Date: Sun, 15 Nov 2026 16:02:19 +0800
Message-ID: <20261115080219.910186-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD3f3sMZ_lqt6_vHg--.43860S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryxGrWDWw1fJw4xJw1rCrg_yoW5Ar18pF
	WFgrW3JrZ7Xwn7Arykur18WryrCrn5AFyY9Fy8G3s3Za93JF15Kr43tFZ0qa4j93yktrWq
	qwnFqr1qgFWqv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMlk3UUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7gz1Rmr5ZwyjRwAA3N

cougar_get_shared_data() calls kref_get() on any entry it finds on
cougar_udev_list.  The entry itself is removed only from the kref
release callback, which runs after the refcount has already reached
zero:

	cougar_remove_shared_data()
	    kref_put(&shared->kref, cougar_release_shared_data)
	        /* refcount is now 0, entry still linked */
	        cougar_release_shared_data()
	            mutex_lock(&cougar_udev_list_lock)
	            list_del(&shared->list)
	            kfree(shared)

A concurrent cougar_get_shared_data() that already holds
cougar_udev_list_lock still finds the entry and increments a zero
refcount.  refcount_t reports "addition on 0; use-after-free", the
release callback then frees the object, and the reviving probe's devres
action writes into freed memory.

This was triggered by binding and unbinding two interfaces of the same
emulated (uhid) device concurrently through
/sys/bus/hid/drivers/cougar/{bind,unbind}.  hid_bus_type does not set
bus_type.need_parent_lock, so the two sysfs writes run in parallel on
separate CPUs.  KASAN on v7.3.1:

	refcount_t: addition on 0; use-after-free.
	 cougar_bind_shared_data+0x53b <- cougar_probe <- __hid_device_probe

	BUG: KASAN: slab-use-after-free in cougar_remove_shared_data+0x5e
	Write of size 4 at addr ffff888013723550
	Allocated by task 534: cougar_bind_shared_data+0x2fb
	Freed by task 176: kfree <- cougar_remove_shared_data+0xba

Use kref_get_unless_zero() and skip an entry that is already being
released, as Documentation/core-api/kref.rst describes for lookups,
so the probing interface allocates a fresh shared object instead of
resurrecting the dying one.

Found by LLM-assisted static analysis, then reproduced with uhid as
described above. Not tested with a real Cougar device.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/hid/hid-cougar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index c8ae18f13..fa7bcb34a 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -122,10 +122,9 @@ static struct cougar_shared *cougar_get_shared_data(struct hid_device *hdev)
 
 	/* Try to find an already-probed interface from the same device */
 	list_for_each_entry(shared, &cougar_udev_list, list) {
-		if (hid_compare_device_paths(hdev, shared->dev, '/')) {
-			kref_get(&shared->kref);
+		if (hid_compare_device_paths(hdev, shared->dev, '/') &&
+		    kref_get_unless_zero(&shared->kref))
 			return shared;
-		}
 	}
 	return NULL;
 }

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

