Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407661;
	b=aLh/eI/XbNDrorO2XUr+yhVp/EorhBD9pamwt5QT3X2VelPtmgo/Lxs23vedgIzXAPfE
	 Rl3ioUePpE5eA/ZC4LBRBB4fczdPHu+vgT4MvP62nTrhcnWekRKAcr44Xq/XDKNn/HsxY
	 du9/BFs3V+wsen0iZhet+1y6Jev0MDyij5rW5owsiyFCf56mksDTGlWK9P3xQ5eT/LXWA
	 tOllIIJjrKKyqd6tWtOFwZ2/fFP1YBQjJtycfpDY/9cpFtqJn/gI6IPMjGt9BtCly3qi9
	 W7XyROvnT/ucIfsvSVKnpuotpVZEs+oXyLdQ1ehrX3EP5GRnTQ+NYSHRyAWI6FNJdAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q4dRowGrQG38OV8LwpdsO4kyaPjuNUQ38aLzSjMk6aU=;
	b=uF1IjeP7H2eFJK+s0bD7/CzE97LA2JTTt3pupoRLbgDhdxteg8Lm3HI+YX90eLUopzw1
	 ZEYmCcjP6MqwlES/S6N1wFk0FoP43y0eASQuEPRS8HAWCQTXg4t87ZMsG/U/+vhI+lHIK
	 fW97qOO5bAOFSGyobhZs0k3MrOT/qB3lQfAKYhhHnUI/+jf1twvkiIExtn7sEENOQp/LU
	 qq2TnkSeXxGMFaegfTfyor+cIrUtsa+2DqvuLJ10qV1dltot5K3MziYrDR14sMGzmKTCd
	 BnhzC8KGBXSjhU7+h4VlCXlJ2nozeDx6TvFL6e1FhNOyIOgAXdCcUIrHB2E+x8+uolg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK4Uwpo3;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752C606A320
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0752C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK4Uwpo3
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so6033626eec.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407660; x=1796012460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4dRowGrQG38OV8LwpdsO4kyaPjuNUQ38aLzSjMk6aU=;
        b=eK4Uwpo3OKwscpby5O/wJ5Bh319RVVMB0zpKY4nFAgZAx03B21O7A3MiS2Rlzeh50n
         KOuE3NNZA3kT65dCRNR/B6YZIuTmX+PbA3vBkYSOdz4EsnZ9mN/GG5HFG1avcJSb7fDA
         rqE7qyzjkRFtbdiHg8okLo3qcAaP9zOcIqHlSO8jPJD4N7d5GqzjCDIM8Vjdeap2WLe7
         B4XbZ+jVWN018SGjCOpLeM6uO/7otJLCU6IyI6lmCSrsiBBnfPX2/oSpHkcx8y7wd7Yp
         tfciEHHKWsN6Kwz6z1AB0B+GVCsdiihgmHmQe+q842rOkZPAuSFYdFrjdKahyjJ6rdRV
         vYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407660; x=1796012460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4dRowGrQG38OV8LwpdsO4kyaPjuNUQ38aLzSjMk6aU=;
        b=i9gK+Ce2SZKmP7PV+DpFcSX+B4NkdWXHcByviYSRBi99GG3OPqQtuxKXz/mZO+Hc1t
         m6Dsy6YBtVf7AQNRfA4q+R5fwVeSKKPnRCSqsVoBYyCfcgXkqMuTZILl3bmTRVXyqNZq
         amZuERuGmGu40JjNnSH0jk26ySo+tUb0mPzSnLEY3BPlw28feFz+UqAz2oHrZ2C+KLjF
         Hd9N+cTSBB3+NUnSKmLZGaAx283OZz2yrdaUlpYYlgLQcXQGxhEZHLjzLgtJ+fVpnB/j
         uvIxJXr/ylStXAbkeZKANiS25G1dICpd0Df/bc4Bd0zLtZJLWVt0t9bvWDL/YapvEzTl
         dWpA==
X-Forwarded-Encrypted: i=1; AL+hErHG0V4kgzT0/Jn0nSC50VQOz5Z6m9Xnw+1/Yrfc9WZviJWAPTkQPYcnvJq4FL01YWAEc+03bno=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PJhyZaQdsIW/N4fhCG+r5uQcqMeg60bZCFFmQp13f7ONLo+bN
	nk4qG40QGk0B676Z6XEgxhX8Z3JXdYWn+SkTtVgtPcM75l/Syp9UwpB9
X-Gm-Gg: AZFdTZeD/VFWg4zGafBtD7iz/VR3WDasYWqfsucr2Zk+QoUnV0l5elJESKF+4aaBgVm
	YcdfIeinhZws49RD9y1GFcx57vDD/3OBwdKg+p5JAfrdwkdewX6FNmag9zgggzcpu3GzxuSBl01
	ipcaz4e0oTYt2hgaUPmsugmTXyb2wV7oNfgdGnUS61nTtfnxy+q3wYMNSxr6aAleqKTibzFjpYd
	yqcz7teW7Raiz4w8tVCkYfF0Qarn++HXcG89dLxTReGPB/Mwx4fUIgzJhsQIi9LetuKPOKEda6R
	LVlyZRwdbkKZN55F6D5HspsquJSdI8zfdFPf9E9QEPy8lHU4IHlrt5zWn6G04LmPxaJKWI8NAWZ
	YeVZFCLqHKsPlVccdfBIR4rHC6EWG5ELGpzY5O+HFh3/w5vidy/8YGAUdv4+Srtb2wEFTXfRCUa
	1D5ZtlvMT7eREZaDLR5xrwgdCLgUORbSH8wHwayTWT4x1NVwWNFXaHKgFXOp+dzPQLFTdUgp5Rp
	Ymk0M7lKco8P/FNRRr2gkITgTqCjhhvyROugdQ0xoHAAFyraCWSF5ArzAnAqUar7GDCbuMHZDHQ
	gbwuoxuBuA0sT1TMxSa0zoSOXc2wjC6cBdXYwMNkDYBJxiBRMag+EdOBBI6yzkIm7FORcTgHTSO
	Yc8mKg6lUfsNB2C+Gm/1RAqVZFJHuxJkoT9xhIToBC3rznH4=
X-Received: by 2002:a05:7301:6188:10b0:386:9ba8:2864 with SMTP id 5a478bee46e88-3869ba82acfmr6273464eec.0.1795407660013;
        Sun, 22 Nov 2026 20:21:00 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:20:59 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/6] HID: wacom: check the input device in the shared report helpers
Date: Mon, 23 Nov 2026 04:20:10 +0000
Message-ID: <dcd2a9920a0f7a7da8b85e1b133d61e2585472c4.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
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

wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
reached from several report handlers and use the input device they are
given without checking it.

Both can see a NULL input device on a fully successful probe. The report
handler is selected by features.type from the id table, while the three
input devices are allocated from what the report descriptor declares.
When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input device, sets the pointer to NULL
and still returns 0 - the "no pen in use on this interface" case.
wacom_wac_irq() then still routes reports to a handler that passes the
NULL pointer down.

Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  BUG: KASAN: null-ptr-deref in range [0x290-0x297]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
   wacom_intuos_irq+0x29e/0x3300
   wacom_wac_irq+0x1b59/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check the pointer in both helpers, following the convention the driver
already uses in wacom_tpc_irq() and wacom_wac_pad_event(). Log a
warning on the first occurrence so the condition is not silently
swallowed.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ab89a11d6740..c7bf0e5988e5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,12 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (!touch_max)
 		return 0;
 
@@ -4254,9 +4260,16 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev) {
+		pr_warn_once("%s: input_dev is NULL\n", __func__);
+		return;
+	}
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.43.0

