Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E43191CA
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215563; cv=none; b=h6OIRoLEKENqi94UfIsxa+Fcrhu0wdyPlCgaDVK3zCMCjHY2JV9PVEGagY+JMoL347uLGJvbejNFQHBoxGx2gr7tvf+FBobXje/GGGI8DkuWG3qxz0Fl8Zn6pEcHzdXM+kyEr//XSpDIGj+ZalyCRWoMCItPd0S/vR8SmcqvYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215563; c=relaxed/simple;
	bh=HahRdRZ7rEXECKhD0wf0GCLX8sapc833UetJWo8hm5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAYiBfSfu8phKBGhGlnW5bX0Yf8Mxo7VVOEo2zn2i86S8tatoZXjlKWl0dJo16P7knOZU4rygotBQxPbnbuPfD7cU7KtCPuvpmetzureB59GK5/jestoZspfVNyryK+4G4Sl4S6wTkCYyz2m2Q3zDB8ktI6gsAGRhIiE006/TaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxscBStO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxscBStO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso14696565ad.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 01:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787215562; x=1787820362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIptc2Pyic8RLfsRCuTURjR3M5LHBGZIonYSyw9G1vs=;
        b=gxscBStO1VpqlsASEoyBNHZiWVEQzI4+uSAnPWGQ5nPh7y/KKlw4bPG6/1mhrRsUD7
         HW9gY55Qy72+gnt+GZ+NMRtQd7jf0WJhs0skVsVu2qs5dCbdnYyIUrgmXhsDb1MhDWix
         oCpsUXXP+SCqMAdX5sckxzU+52z9Q2FHOlqSaYbSloD109Z4ey4hxCXcYp96PaeF6XCz
         xcplrmmLr+kmV5sY7gMeDirWgn+NG7oG0yjDffKbKbWUxvrI1rRAVbhVaTQ0A3QjOiH7
         xg+zc0GbyVnO4RoPqF2mAfl//Bp98bXjd69VoukhmpxZdHJ8XnzZZT3m5WT+v2mWtP46
         jKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787215562; x=1787820362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIptc2Pyic8RLfsRCuTURjR3M5LHBGZIonYSyw9G1vs=;
        b=rVl03NIzinscRzt8/oGtWE6RMc9hWSp30JzAs6J8qrdWBfnE6U0+1io5+DHtr6cvNi
         OC42WWbQ+XgtEeUlEXo+51CxbOkrqDjOl4fLecBQf7CCig/nqUNQKnlFifymXcDLcFjV
         nl54SAQaodayld8v8eOkyk3oNUK2+z3KQ4nqgZ5nd7vhklicxpc/IOE9oVZzJlVjBBu5
         7xfk6gIGMZuEkjgsTbpHjbTgunF841vdWiZA00oP9iqN+s/Bmg1Kdg9T0e2QD3hGyTxf
         99SQkzZK59ddN+oDnemfkuKpdiFbXZfh1WII/y1DL9Y0f+ScpFv3rzn4tGn+oGy2TWbN
         K7Ag==
X-Forwarded-Encrypted: i=1; AHgh+Rr0gFqiMkUCry/saotlqdFl+DDxx2tFPoFhCJzbOz4bPvkX098658mt7FcwsLIYlOqhe9byTU8=@vger.kernel.org
X-Gm-Message-State: AFuF++nlvU6peI3Wg5zb0TA9InJ7U/NkF9QlpjxbhZZJJaJn5VGvo8Ta
	H28FoTgUzukb8EJ86N9ceSJ+yOX/zHLF73723U7LzWk5ttC7EYRMdrptf0bhUMEO+V0=
X-Gm-Gg: AR+sD10ONU7vjrvLHNy5J11NqWXXESZOwb4t00ThM+TXJrfFkpbW5uCbzo76q4zvwRG
	xVa4I+NqO0rnS0eXA8Wq8RyrI0qGkYDFWzclj7U8q9ClFC1Ajx2zyJlxCN70AVw0FTWfj572vSv
	1AmwrgwCx6IfJoGLdo9M2kxWSTXIKsjN57vsh6XH8iFR2+XH5dYW+o24k1zYdk9aUlPo/Cw/LPm
	6WAgI4sUflyIOuaA2toxhT/tfeopcSbsvlKxD/EwQPl/YUO+KKIC3mEtozARtywYW3kC5cuE/w4
	beURbrvfVObrim4pZX6tdaRR9ycYtubj78ZtyPhIYuKcGcA+mpsHHE366TWvNEfKjZ3fdRq28+8
	TBeuL7C8UE1tuLwjP80orwcWSbSUcWWJLsOzTjQprSryfqTVEXDSRmHpCF7WecXIjYXimCKztaI
	GJ6tk30ay8s1nujta0mmF4AzjG9KmbnJ3J5+7wA3DwXTUQ21hQPEpr9C4xB/hQV46ECROrFnlRk
	ZNX6M5RI8f/8ar6uhGSdXog
X-Received: by 2002:a17:902:d4c6:b0:2c9:c517:d070 with SMTP id d9443c01a7336-2d5fd5b0008mr184056225ad.3.1787215561696;
        Thu, 20 Aug 2026 01:46:01 -0700 (PDT)
Received: from ML-GYSUBT565.ECARX.COM.CN ([101.47.164.95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf173b02sm14731169eec.27.2026.08.20.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:46:01 -0700 (PDT)
From: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>,
	syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4] driver core: avoid klist_remove() on unattached knode_driver
Date: Thu, 20 Aug 2026 16:45:57 +0800
Message-Id: <20260820084557.129908-1-khiemtranzo532001@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026082042-coma-moody-5b4e@gregkh>
References: <2026082042-coma-moody-5b4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_driver_claim_interface() sets dev->driver directly and skips
device_bind_driver() when the interface is not yet registered, so the
device can reach teardown with dev->driver set but knode_driver never
added to the driver's klist_devices. __device_release_driver() then
unconditionally calls klist_remove() on the unattached node, which
dereferences a NULL klist pointer in klist_put() and crashes.

Only remove the node if the device is actually bound. Use
device_is_bound() rather than klist_node_attached() directly: the
latter is a raw klist API and does not NULL-check dev->p, while
device_is_bound() is the standard bound-state check used throughout
driver core (driver_bound(), __device_attach()).

Fixes: 94e7b1c5ff20 ("[PATCH] Add a klist to struct device_driver for the devices bound to it.")
Reported-by: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87188222c77c0dbbdb4d
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
---
Changes in v4:
- add a changelog below the --- line, as required by submitting-patches.rst
- add Cc: stable@vger.kernel.org, Fixes: points to a released kernel

Changes in v3:
- document in the commit message why device_is_bound() is used instead
  of klist_node_attached()
- add Fixes: tag

Changes in v2:
- use device_is_bound() instead of klist_node_attached() as the bound
  check, per review
---
 drivers/base/dd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 60c005223..4154b4499 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1354,7 +1354,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		device_unbind_cleanup(dev);
 		device_links_driver_cleanup(dev);
 
-		klist_remove(&dev->p->knode_driver);
+		if (device_is_bound(dev))
+			klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 
 		bus_notify(dev, BUS_NOTIFY_UNBOUND_DRIVER);
-- 
2.34.1

