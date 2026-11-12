Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466577;
	b=WDoJosBSe2hVtkZ3ikdMOq1tcn+oHJkYfJAWdgHyuBR9ZBCH+pMPDTvCXK4eCqBaLH7y
	 exN5+oK6YgDojyyBTZNPqy2pp0ezyGS+PNzNkLaSHUrQqbTK4RgNBAWDQMM6qa4uoIJhe
	 DfVXQvAEWldmhq3lbcYIR3ezWBcQrYKAzhVQAJHpVrXPTzY1vrgDQ/6JnsLsORdus+DlK
	 MaF+YcCPx2s7K0MWTQCwgl7K24kU6aGOUHCxc7kq4+Pj2NYvfn2elmxCXeIM0ur18fFRE
	 Rl+idz6ThrLAuD9hXshBljyDOnE35wgjU4vQhN4gP3QTI/CqHrB9nlL0BM6BlUQWXtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R8u1ixJmi7TH1leov+iud2pI+lutflCpqRALV1qurqM=;
	b=Exm7Tj5ubLceCGLUcZUHCemFfTOaJ4SF06pk8sgnHnGBTwALD08HT6P4rsEbQ0iYVZmS
	 VDWtVqO2XV6wPemaiSBfO1TLUiCCfZ4G1bHRKkjaqiFlh+S6a/x4goVDsb0KSMFPSbLLM
	 WkxenYDXJuhcVooK9LwPniUtdHhQvRUoSURixyWFezPZJqLtnVZOum9qlxId9Hh0VZ+qN
	 CL5QfLbKdMCcEZG4cHqCVuyE+TCh+dyFH+My0XAI7+Pe+OuT6Z5PfmrXxSlzemsTwsjKk
	 rAEEfK4iPojrO2cgkUIeySV9Z4SmRqmMJ6aVu2+Abq6kXao7CTKwQSVJ31n451pHfJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cE219Tvo;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D23606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D23606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cE219Tvo
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91f0c4f7a8fso10495766d6.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466576; x=1795071376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R8u1ixJmi7TH1leov+iud2pI+lutflCpqRALV1qurqM=;
        b=cE219TvoeGWM7xjel8oXWWtPj89dTmLMtC0qCaJuJjc37uvQVOl/km/Hpzd3Yuo9Vs
         tUcXKSAAefqN7AyG2gUALa6hoEtNTg8+LiW/m7O1+u/mPPyhOKTkd5xYDgmNdzNgmjBO
         VjG0vVQCgznEB0gWSwHQSUv/ijROn1tGO39PBupfW8QjbrviCn5vxLg7QEhrhi8xIXII
         K+UTEGkKjJZyP3S3MZQG7HlD5or5Wc6nCoeSDb4OlKd6EMtcIETigZc/h1O6ODEeGFIY
         DWmTRwrxAJuFcZzwQuT2y+Ij3pCOZr5+iQ5z5jKgM1W35j+xupY3VTqEwzcGtwccm4oU
         UgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466576; x=1795071376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R8u1ixJmi7TH1leov+iud2pI+lutflCpqRALV1qurqM=;
        b=0Nse3PlSsdM8qK4ytCjyLDRSh+1dWq2MGN0ojg3iVPfIxaPJlD4LOS8KTlU5TVXWn3
         ZO9AKmyensxTj+2xo4wrhXMBvMVDIjdm1d5GgcJoj7awuf1Q95u4Ut2BuXsDxTHLG0Cn
         abgMbjVBRRpkuG51jtxlWvOrxoCl35H0UudcAsFOOP8gEi4qli90nM4MH9SwowiAdSsh
         jkPNDX7w+bY8/vdS1NFTM8EplLxdrVXa8eER9FG/gQXfIBgRluUrJzC3c5a7Tskoh3V4
         JUU4MV/bQXSEDpYeQqzlzb5/C/51A8+4bRDEjjoa/RtAfMSmvz/EECvNdy10eqyfD5jh
         yUqQ==
X-Forwarded-Encrypted: i=1; AL+hErGlzxFweznjP7HIJ0BOs0/08d60Idirx/sGHDxbeINFu1AoPUyQOLjp7urJHDjToPD5fkOCVLU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BC+OAAYLUPrS5tSPCGXUPEEQxR8Tx8FUqQR0B/HVc9hGUuQoR
	7Wlx3V2AttmFt09xl7ZY4gFoNKG7la71e1r/n2B/d2N1aIXXzVsuAqE=
X-Gm-Gg: AYBFou2RpMqVNIJOtTd//wXWUz/PYonZ1E5MiY/84W1h6+rbZYqfqx3gv09lFQyA/tm
	ANiWBD5aG4fnEJbxmPteim7C3A+C5+VC1Nzo21qv+T5LWbtxcAsY8Ndj26lLEBcOhNuIPpSQ67L
	Qx/ecZGio7NB70bXSv3UdtTMYF0M7NXAJE+DynTKoRyMH9xQlog2k8aKVHtM5qECyZAO0yOnvvk
	lISTwaZkGCFvwOKsT8ASIglVuFZ6iZHs+tEiG8FbXf2hFS2TLuRyZAuw3Wm1LwM0JF6Xpw0WztJ
	NJSh7EtG65ENV6wsCxFaTP/j/li6dzMG/yboMMMWI0xTPocbl3HdO6DJozc4CmLlYZq12qbGmZg
	ytyhiaxP9AEzISkyzcOJlwHoaC0rRoGCdBsGk0Lkz0xvCaM04Y/YRho8iASomEoL7/gWLdiSeov
	rimGL97/Jj6Kz/2xcenLozU9YiWkhIlAYflc/UZGusR93V5rUZ8OKxcD60c0WfwmZo0ME25bMRc
	UhVzER5bYQD5klZTF9rST29nQXf4t2ouMHCJOjLgHkCBKIcc3fyZmYZtnyDSiD4Rhcc5rywPTdj
	/dv1ZllkfZjz8IEKG6DrXjleg49IWImdMGzueg0jZ2EAcJFO1kZNWil8JHwv4O2YT8c4hW41u0L
	MLBX/s239JLQkuHZAcow08UE+8SGZEy9/qiXkFkwsICEf7UfLVsT8u19F/Gne68/Ewbxu7S3jNQ
	BMmdhBKpOkGOKf0wJC2C3jtJrT/madu/pP
X-Received: by 2002:a05:620a:1a26:b0:946:f22d:1efc with SMTP id af79cd13be357-947b0049770mr887965685a.67.1794466576048;
        Wed, 11 Nov 2026 22:56:16 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e76b1c3sm663813885a.16.2026.11.11.22.56.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:56:14 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: hd3ss3220: disable the interrupt before unregistering the port
Date: Thu, 12 Nov 2026 01:56:13 -0500
Message-ID: <20261112065613.34182-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

The devm-managed IRQ remains active while hd3ss3220_remove() unregisters
the Type-C port and releases the role switch. A cable event during unbind
can make hd3ss3220_set_role() access either resource after release.

Disable and synchronize the IRQ before teardown, matching the existing
polling-work cancellation. The ID pin IRQ needs no change: its GPIO and
regulator are acquired before it, so devres releases that IRQ first.

Found by a static analysis tool under development.
Not tested on hardware.

Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/usb/typec/hd3ss3220.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 60d6de9ba339..19c5dbdc97a1 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -554,6 +554,8 @@ static void hd3ss3220_remove(struct i2c_client *client)
 
 	if (hd3ss3220->poll)
 		cancel_delayed_work_sync(&hd3ss3220->output_poll_work);
+	else
+		disable_irq(client->irq);
 
 	typec_unregister_port(hd3ss3220->port);
 	usb_role_switch_put(hd3ss3220->role_sw);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

