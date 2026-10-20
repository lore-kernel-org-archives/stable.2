Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506306;
	b=RvkHWZpl6HSTJGDV6JwKlUnXGmEh0pt9lXioRzj/Lu366XNmxw1+jVYh1rjiYV4YI0Ud
	 E/5MS5pzPX//OGWQcmZcm4w7y9JlJz+zhW8CmPYzyKuTI0MamTux1NcaEjbt0S3heOAq6
	 Wpo+rMJxqfXzRjjJKFxiBoIWFqACFKaYKljPKaByCmc8lC4ocQagHQb1W6AgTBf7K/vFo
	 woVtiSTvT0abCqA9MiJapiCYnq23islDMYT5/BFatmV1Cvcpo5GeHMKzSgnGPTOZoNdhr
	 bvt2Y+7S1319lixe23PIXCA5eIIPyh3kwa+BQyd483enZ+SFopnEkmrvPrSObkGkHJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B4KgMKGJExw2NIRAFHLCe3T3gCFWPlSlhOpBnCMSFXI=;
	b=rpT6YF0kRr9e3wqjxWABOvaGvQbCmGkw0qMGTh5mvuQ5Ze4uqiy6L3kCXDoVp2zmDxuQ
	 Mh0ixfk2BFf0GfbPy+TAq6lyIHZpcTka5vRltpVnjBAFRMxtAuwro0pctbVdG5AjLW8ig
	 4NAEcXSnad8/P/pJkthPHAMpbvTwq385Ve/ZTgESa7M5li+Tkz4wP+IMJHIno8fg7NMdt
	 HmlnB69oLvR7Z1BA+f8/11Vk2nHKhvmOIX+EvM58gStYEKJzsf9WhLdbfCrVxa/a4eodM
	 /8TL0lAISDovZGJ0qkG6KBOdvc/VseCOxiGxhZa5i5URAZ/UBYiawSd1+DU18Q5Eukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bS6KFzwa;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A63606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A63606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bS6KFzwa
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab866b377aso362195a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792506304; x=1793111104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4KgMKGJExw2NIRAFHLCe3T3gCFWPlSlhOpBnCMSFXI=;
        b=bS6KFzwavUcNiOSPpe77g0j447VzmfSCy8X4mBurYxhyqxMySHXpqozViwljV5Ux0g
         JvNpNyJRFL/e3+E8khJl7JoFei8hhyYlAOobKEoz0dnKEKEpHVR1HDSCb/VvsB1gXx3e
         /LsZD28O4H/xRVd+Pt8+f0rMcifNs0wvYFJJf+GjqByZp/VS7nIChdyOVWf2s4jpwe9/
         woD+T7v4tHGQuhcLopEnTaKE3Zvr+GAUW9a9pfKDXUTJQJ8rcACNpxFGx4uF9ZNaTyzT
         uucJWA54e7ASvAvTLGuuemp5iC2yukK0YSea6ZkZSki3jgdbVOP3cn7T2aPTM+Zi8tD3
         ROZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506304; x=1793111104;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B4KgMKGJExw2NIRAFHLCe3T3gCFWPlSlhOpBnCMSFXI=;
        b=W7/V+a1gYeFATtZM/o786MOiiNaRyGIp90c57UC/QT9md7w4Hd5EP/+3Rj42kBs9bj
         tM0Mp5yhkv/EIB7jSPTomyzIfnGxEzajFbMNTCa8L4Xmw9AtsChDQBnsbxFojy/BLo77
         3pODSH5FJ2Tg/phkivKm+2JUIo7ln0amfPUkvnimDl36DiELFDplRmf8MpkMBt/cVsCM
         0isJ9NrimAn/Wkt7Fz3L6Lu1u0CG3xuhQHHCGRrNKY5FCzvTGMlLFkl5yS1cciM8QTFS
         yLRKCZLQX9RW1plISxn30hCU/swZfTesd9enhSce/8QkgC3ruzg44Zn+pQEs9wfnatmi
         n+sw==
X-Forwarded-Encrypted: i=1; AKwUvBzUkl9/l25hLP2kITIgKSxNsFYvNZ6kzDAlFIUoaaqAKKbnhR+6jiRoP454QO01Pre59a6hWpc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLxL/TjViQ2TFQN4/hWAcDcY+xKAaVurs0KeAzPQ//awiCmB3T
	oWC7yP/t7Mu+fZTjDU/aiZjjMzGWxYOxUSPtzoN/IJ84NdbvXyLfI6fsdQQYMhOrJ8F+IA==
X-Gm-Gg: AYBFou2UqAdU0vGidbLxthm9PXa6WvZlMmdLbSLbwsrUyq/9QKVOcp5f9kTFmumZtRR
	rgmoa6nJ9PRSqFIioCDn2voEeJHxoKffzy+61rxvh3yok/rbJ0J9PFp5bIZMCgF0NV5QcDkMUd8
	QIPu3q+DQG/wf47kYvVQ5/EmFuswZZoVJbMvNf04fOemKwz83BeSYpn1tctpo/e7CkSuIAR4Rc5
	vHpnK6qzPGYNIj4RdmGtiE+JTJdEFXE7g0d1/5x73UTgifgn29VWgXx17UYXEwdTCC00MROWJNE
	erkrD5TtVpo491m4EOEaHGXfNEhAEJhaJqdjD2utazbFQBBJJoC2DnQ2Pi7dnkVds+DeVcyTn7u
	+E9Usn4soJsvZHoqDji0gjmNxBKMVCWHqQm9rNBi/kCHTdKYWX70yYNaK5YDs8I/VXvBB1/VIf+
	ypywQrayE6m5xpNsm4mqn3yWIC8hpY5wFDG/9SATv+CXvLwfhvCLNAMtadvMiFjr8QTudMn2WOv
	uv5pA7ODdg3vKHgdlkiuglt50/NjQWNskvyU634ryGMAOIeL3OJMmjvIUXi+xh63cDPPc+bXl8d
	CeQV+2Jb
X-Received: by 2002:a17:90b:28c8:b0:3ac:77a2:18b1 with SMTP id 98e67ed59e1d1-3aceefbae48mr15921906a91.5.1792506303983;
        Tue, 20 Oct 2026 07:25:03 -0700 (PDT)
Received: from [192.168.31.234] ([183.193.19.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f90a6bsm3570784a91.13.2026.10.20.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:25:02 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, stable@vger.kernel.org
Subject: [PATCH] usb: musb: fix double put of gadget device on setup failure
Date: Tue, 20 Oct 2026 22:24:57 +0800
Message-ID: <179250629747.20696.17364135141613638741@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

musb_gadget_setup() calls usb_add_gadget_udc() and, when that fails,
calls device_unregister(&musb->g.dev).  But usb_add_gadget_udc() already
releases the gadget on failure: usb_add_gadget_udc_release() calls
usb_put_gadget(), i.e. put_device(&gadget->dev), in its error path.

The device model documents the same rule in the kerneldoc of
device_register() (drivers/base/core.c):

    NOTE: _Never_ directly free @dev after calling this function, even
    if it returned an error! Always use put_device() to give up the
    reference initialized in this function instead.

The extra device_unregister() therefore runs device_del() on a device
that was never added (or was already deleted) and drops the reference a
second time, causing a refcount underflow.

Drop the redundant cleanup and just return the error; the UDC core has
already released the gadget.

This issue was found by manual code inspection.

Fixes: 3301c215a2bb ("USB: UDC: Expand device model API interface")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 016d3f3fc1e0..4bc4270088bc 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1794,13 +1794,9 @@ int musb_gadget_setup(struct musb *musb)
 
 	status = usb_add_gadget_udc(musb->controller, &musb->g);
 	if (status)
-		goto err;
+		return status;
 
 	return 0;
-err:
-	musb->g.dev.parent = NULL;
-	device_unregister(&musb->g.dev);
-	return status;
 }
 
 void musb_gadget_cleanup(struct musb *musb)
-- 
2.54.0.windows.1

