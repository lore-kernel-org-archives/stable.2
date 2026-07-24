Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9C253B73
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900576; cv=none; b=FBkTbYyJZzyKAgrOgs4PrHkfe2570ppXjo39q2UnWv0Q0NXOz+y4g4JVd+EXWWenLCxyLVV8OlxmHKFNKY2Vz7HgF9T90sXD6sKWK4uVuZE83876x7Cu6pbKkhrctT0Q3ZFqKZQrtFAu/XXg3a4zBeGSY0grkjedx9BnmuzTPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900576; c=relaxed/simple;
	bh=nmS6H4FTGfwQIoCXwTuZi7xAO3R/0s18DSvjvFnlIn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbnP8ACM+hitBTyvPB49Na30BYAmJju5nFo7cAT42V7FPTNzlEJ/whl+wf73YtFg0Jc+RnlayKPcBEZ4eUqDt8S2l97tLCAUB10NxRL0tSH03lOotJSoePh0tI+qdSS7Aa/QISQDftC02Dl/ogpoOxOL21DdBubdrl6SLvHaLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TUoORDvp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="TUoORDvp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso3413805e9.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784900572; x=1785505372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzokFwbqCQcQa0BrIKwjqqwQpe6YFNwdchqjati0oWs=;
        b=TUoORDvpHUE7jt0UnLuCr3U1DxrW1G21GQgo3dKWkZcHd67wMIhjWYLOZpzrdyDPsu
         5YvUsIVX/PSk1ovTgm9VjNpZKxy9fk7UMdgzEvA+eoagaZM8kd2jZ3XTfjVe5YUE+lie
         3oM2VrJQ2O3B774l0Kq8vYrfIdrh9k8iR/6LfhWA6+W1ejXsVKsHwisfRujj3Z20yiwq
         P4hdRTJuuo9dTImnEgZi80LbsjPdAydRtnmrY9A2AoCBiJ7fTo4LFaBTEWOX4yNFQ/qL
         ncUnT5o629xMIGHgLeJ0x33MJ8H6js/4J3Dc0bd/b7RfzRWtI95UrXU1P9E0K7VeVwKL
         HZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900572; x=1785505372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzokFwbqCQcQa0BrIKwjqqwQpe6YFNwdchqjati0oWs=;
        b=RV/XM7bWEvRvqvOAvnzvniOBkXRkII6ksU1i+PzotjqPRBVndQx4I4VQ97mloBlXC6
         +0/O9uskrccL/6QMRPlwYovR9khVe7IWFKSm4/4Rcch/LeDdIl8xa9zNn5z2QoquKiu1
         iprLsmwYWvMUxo5pwY4CUACLQSmG7TRqZlIi2LdQqcgNG9FmkwaLTrFf+ibuLRUdrTJp
         dpBqVaZRpPEyJYfay87hO33pOHmd72Rw5BuVVrEnmuEoHVy0C5XR8B3aUsAx2tdm0La9
         3v70TDniO2Ah0cqTk7WLitjAOsS8LJkyB+4H92bvP9CnDxthqUxgAfeDTfIJ5fj0Z1oA
         QswA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6ao3KxZ1/vjyWS2bKO/L29gpbo4uPqHEXfVu9GLlQuPg4+u4oR3LbD1asjczml/9/MZvMl9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0lkTzbguH6QsIr0wPaphvqTnayeNjZRVZlIUfOBmZ1jUclur
	t+bWHWkVmlH+p5MvoDStZ9MgLKWoi4VcJQ79FYwVVqHxukTnRTh7DhLdliueT+lOdN5B
X-Gm-Gg: AR+sD11oqzFklpHsugXigJvBl4rVUshSXn35SMGQHa1hMHcgcPRBXs1HpwdTTAes6vQ
	e4RviT0lTPIckFgoERG8jczCQaiLY09ao2I1XO3LZ6xxzg8FIYqr8zpRcGKnSDQhVn3M4uX69my
	UKt7tQ96Omta4uLWT7O+EqUn8qh85ZFpEOZFIMphKqI0Q5ly2lq1R8VBrW18Tq2lMcYdrTBZc5G
	ZUQEVEeDEE4TbgK1frNuFa6YuIAS7oHVmpH+fGk9YOVQes6kvQmwckHmIUjUHyEqhh7gXJ/syqT
	zZVsBJfIRQdchcwRr5VVVvcfH1mb7paAdnfbbExQreyG4p3mSF4yMKllL0nD61Z3G1ghiOKQ08s
	8wCq+lHltCfofF+yjVS7wxjmOIzGr0L15Ek8CsUsbKVGpPc+3ZD4jlRgnlJSpv656D0ZqL3V2jV
	9RSDfQxjfZl3weW0rTOgGp2krvf/wjdH0k6k7zhxEN54W63xljOunI1qPsz9mxWrm55lHO+NvUL
	OHZ1M2G4rdlBy7CX+h0MRrGMA==
X-Received: by 2002:a05:600c:350a:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-49573cd8932mr92373025e9.21.1784900572398;
        Fri, 24 Jul 2026 06:42:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd850asm23982836f8f.15.2026.07.24.06.42.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 06:42:51 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Alexander Kappner <agk@godking.net>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: usb: ipheth: fix carrier_work UAF on disconnect
Date: Fri, 24 Jul 2026 15:42:50 +0200
Message-ID: <20260724134250.34360-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipheth_sndbulk_callback() re-arms the carrier-check work on any non-zero
URB status:

	else
		schedule_delayed_work(&dev->carrier_work, 0);

ipheth_disconnect() drains that work via unregister_netdev() ->
ipheth_close() -> cancel_delayed_work_sync(), and only then kills the URBs
with ipheth_kill_urbs(). usb_kill_urb() completes any in-flight TX URB
synchronously with -ENOENT, so ipheth_sndbulk_callback() runs after the
drain and re-arms carrier_work. free_netdev() then frees the netdev
whose private area embeds carrier_work, and the pending
ipheth_carrier_check_work() dereferences the freed device, a
use-after-free on unplug while a TX URB is in flight.

Drain carrier_work again after the URB source is stopped and before the
netdev is freed.

Found by 0sec (https://0sec.ai) using automated source analysis; not
runtime-reproduced.

Fixes: bb1b40c7cb86 ("usbnet: ipheth: prevent TX queue timeouts when device not ready")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/usb/ipheth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index bb1364f85bd1..fdddd761f83b 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -672,6 +672,15 @@ static void ipheth_disconnect(struct usb_interface *intf)
 	if (dev != NULL) {
 		unregister_netdev(dev->net);
 		ipheth_kill_urbs(dev);
+		/*
+		 * ipheth_sndbulk_callback() re-arms carrier_work on the
+		 * -ENOENT completion delivered by the usb_kill_urb() in
+		 * ipheth_kill_urbs(), after ipheth_close() (via
+		 * unregister_netdev()) already drained it.  Drain it again
+		 * once the URB source is stopped, before free_netdev() frees
+		 * the netdev whose private area embeds carrier_work.
+		 */
+		cancel_delayed_work_sync(&dev->carrier_work);
 		ipheth_free_urbs(dev);
 		kfree(dev->ctrl_buf);
 		free_netdev(dev->net);
-- 
2.43.0

