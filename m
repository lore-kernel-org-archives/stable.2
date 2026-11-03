Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704908;
	b=Y8lZfjBoL4CnSy+HRFhhWJPjwFI9pW/z9IDl8tNuKYpkJJKvw+fdAyawcKTYGk04t0tz
	 p508pvIw5Xi4FQDPXCxR7ISw9sCUNHDJaVM3WPU2jS1lAuW9EpXYX8qDPmxxiRUY90umn
	 I7ms3i6sxEeO3189en3s0yRFoXJ4hySdzZK13cbw5T8yOKfQx5shufLK9rkyTfsFva65/
	 cEPgFyIq4wJ2b+ZJU+xAuA+mSV0mu7bKum1qI9xFf2v3h+zTKdetVR/UmB0lAgINP83VG
	 NolMzNSLfHX3CA5KzRUN34PTe+cMD/KzundXq4b3ro4ZVdYSGAAazn0RcdHf1lsOM/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=mVXNNrUzL4JVfBqwkPb92DjVAJYfDjQQxq0TjJeAwMo=;
	b=0cqiAsw2LkBmm0yQjQtoNEkFjCfoLsz0/LPq4y/29qERcOPzXwmibXVzUflEF5BTLYSj
	 cgQS/yUxiffWnW2/F0hV3/2b7A8LdalZ6upIGORlhIWza67kIcYjhjxrRUYLRwq6prb1T
	 WQSiPI6FLh1xSWRf+hAXEZP92hDCnY0ABX3pgA/ovPYgvRLskiM1/eb2JNo9xP3f/3v4g
	 0bwAGkdNEayyHURNNezE3wt1vTTcw781XRqgmi9cjGAlmW0IfUg+8mu9n4BOekqPwP2lQ
	 kB9B9MVBVlWxbk4fZ6fJcKuYg+KDSsKKSJ/5og2NQl8bKqeeqVu2vH5XnwUSeMAhaSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=wwxYlM3t;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D1606B13C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 442D1606B13C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=wwxYlM3t
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso40668395e9.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1793704906; x=1794309706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVXNNrUzL4JVfBqwkPb92DjVAJYfDjQQxq0TjJeAwMo=;
        b=wwxYlM3tmou0xPIr+/99ZsG8KHCvZNc+dZ43jiU04HHBThPPhv1Ug8wwbA4nRfgVvQ
         RJrWUl7S2Tl4euGA0R1FZ2CM3jCEdRwfDOSeytdF7syYQcEYLCr/0JOIm7winvyonDRA
         g13vfFMYoiYVnlMOm+egPr6cg1n3MpK4BSiMXBM7XKKFr8UTI9H/QvpQTUOQsBN77gx3
         gMomt6i57p7Dg1Aba+HpsxN+gNjK2nKNbQDfyxhTFhrA5w0VUjRhmi0rYOGl86VvBuCe
         D5I+PLgsbIwzgsANRKjaKM/Y4nZ8FNVvFlELsKO78xrVN5M60vx+7kAbOBlTCXp4NnGp
         POuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704906; x=1794309706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVXNNrUzL4JVfBqwkPb92DjVAJYfDjQQxq0TjJeAwMo=;
        b=hlbrw1OPUPfWvtTQQ/jnRkb1HKRAnc5xJ6ET6ogomTH6PtJrlI1cEzwuATYLzsfsSA
         MCr4iow+f451+eiGPr2GOTAE/z7Ss438k/l8H/RUElc1vhP9AaLGpaQbv4xs/j/gM0s1
         rbzw9MLl4I54/rO4RvHuYHs/L7L7c1jD4GVhsoNlIcmTQCnzT6eupkYEf91YzauYSbiW
         vNVU2w9GY/TQG54DmS+Q6Y9O9WVgHxoCxY+gcxiuSE/iuFbdrkoRQHsmCaVHPRpiVeYD
         ZzWIVRjrO1Y0BoK/jMqpGciDVWFao53WF7S+im0xt3uKu8AlZEi1mAsdT4Ha/Rx09BiT
         jpRA==
X-Forwarded-Encrypted: i=1; AKwUvBxqO2gnKxwx1uq8nZEM0bRKGhvs6YUa8ZeXC5Q1Do9+96pXejeMaTI94zzg/8oUSuivx+JcoNw=@vger.kernel.org
X-Gm-Message-State: APuU4Z925yt0iUNUpMvlgcPZFGD1/YhEZG/263vstk/kEgNan2nqKAaE
	2wXvCVHIikYDsL+qiHjPMIFmovNBitehhgs+pzcYKOi430CGYkuWEOunhCzFbJjZ943ijFNft+T
	0jJ2k11I=
X-Gm-Gg: AYBFou38C8dTyNz0xUfe3ahbQFOXR8l6DisLHSYFncHyKMVqhWYs7AP7asBXpuzeoXt
	D8X4MNDBXwIzv8vLu/Y46uapQcIjOvX/dz1eqzQHa2cXcTqEkQ7AkxELGLJIW7MxjvlRHpSLLul
	RumES5Yf0zHTFTmkjsPxaR1sMfz8QmO8WDWpQmSlDqi6nVTJC1KRzi6f63Bq9z6xg3gLZOf0GI9
	J9GGZSN6sTi0IcR5T7H7JCtRqC+MX7ySJVa3oDB18gS5+Jf9SuOGeb8DBDqgXBX07622Cj3PUNF
	fZfuV0WAs1RbjJy2Htt33o06kra5vyk2DjGfIAgXzOLxuDpLQCJfxxQViES52J4u3jqLH+KZjrE
	8vyWRG2MA6ahlbGfMr0P8M1yghX9uAPEO5dW2WS5sP+OevHlGjIrIwd2ty0L6Oos+OZsylEXCqJ
	jvvqKgygZKC4e/20tD1sZOoephTnUDW4PhqZ33b4rCC/+CEqSjE7dFYy53AtpFOEXUvn3zGZoMI
	oxbrJSVbq13HJJ0zUiQeznXl2eCrDnBQnvHoegH6bCb91mNaRq4Vwk8DdtPlVkQLyJBFHuaKMse
	L2+kpPVukCnOjzf86qJZr/ftQsnKRcIvjPafMzZEtVmDO5Ncmno5ydxXzp8Stkn0JSMesF+9VeU
	T4Qb3ciNIpg==
X-Received: by 2002:a05:600d:e:b0:4ad:181a:4355 with SMTP id 5b1f17b1804b1-4ad181a44b6mr182386425e9.26.1793704906599;
        Tue, 03 Nov 2026 03:21:46 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm76135345e9.15.2026.11.03.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:21:46 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Nov 2026 15:21:22 +0400
Subject: [PATCH 1/5] usb: typec: tcpm: Stop a source from repeating a cable
 Soft_Reset
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-husb311-cable-comm-v1-1-6217dabc1a85@flipper.net>
References: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>
In-Reply-To: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=alchark@flipper.net;
 h=from:subject:message-id; bh=zxAJn44JdpWKi1AW3DIpb8Id8E278rpA6Y1UkZuFeVM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWS9PHzk5ekLpwPOcmq1frV7e2zam6pd0zas3av3uXMSj
 3vI6a2b7nRMZGEQ42KwFFNkmfttie1UI75Zuzw8vsLMYWUCGSIt0sAABCwMfLmJeaVGOkZ6ptqG
 eoZGOsY6RgxcnAIw1YIOjAwP9Ox4wsozXDKFyxY91tqiquoZILmmumXCpUXaJlaVV2Yz/LNdeUy
 UZ9F+rpyqNQGz3TPV3/c+2FVppb80cq6motCBZBYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

A soft reset AMS starts with upcoming_state set to SOFT_RESET_SEND and a
call to tcpm_ams_start(). A sink then enters SOFT_RESET_SEND through
upcoming_state, which consumes it. A source enters SOFT_RESET_SEND right
away and leaves upcoming_state set, for the next SRC_READY to replay.

After an SOP Soft_Reset that is harmless, as the Accept handler or a
hard reset replaces upcoming_state. The SOP' Soft_Reset sent after a
VCONN swap returns to SRC_READY instead, so a source resets the cable
plug a second time, outside of any AMS.

Clear upcoming_state when a source enters SOFT_RESET_SEND right away.

Cc: stable@vger.kernel.org
Fixes: 6bd181ba60e1 ("usb: typec: tcpm: add control message support to sop'")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d721baef5210..c0c54caf99d6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1914,6 +1914,8 @@ static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
 		} else if (ams == SOFT_RESET_AMS) {
 			if (!port->explicit_contract)
 				tcpm_set_cc(port, tcpm_rp_cc(port));
+			/* entered right away, so don't leave it to be replayed */
+			port->upcoming_state = INVALID_STATE;
 			tcpm_set_state(port, SOFT_RESET_SEND, 0);
 			return ret;
 		} else if (tcpm_vdm_ams(port)) {

-- 
2.56.0

