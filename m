Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164061;
	b=sAWkddbtl4v8UxFx6V+u4x97BFvmKsuCJ9VgX+MEwgyNDnk6jJpkSzb6now7qWhtoW/l
	 ztkP7lwUz9hkNH408jfUzbhrWqdLGT9fe0smKb+ZvVwl8+IoTcfIJEidCEfKhuNZgCqTZ
	 tTJJDYMKHVn5PX2YgbN03Tzxt0knkiPj+DIW10VCCAvdGlg6qPpfCyaFZrg8p4wgQ6LC0
	 IH0skW4JxC41puZU68X0P74jRs+qGJS3aQ9C//Dr/R7YCh4FOhxfHx+PLTLV4YIaYf83Z
	 uQULzCn+70QQbpj1RUS57xy6H5BINPbv0leFW8EaKvxErLrXS0f+RlwuM7g1RVS9nDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8fqgQ1PFUcTxqPkGPD9MBUjIl2fcMgF5433kwtmJbEc=;
	b=zvPYC4IJsDIkBufdC6fr0jOx/lqvwwR9Q/baWCzMwzoWZiYdF4FLB19MjGIwt67C2Rp2
	 xNec3GjrXdh98ha3ZIZ8VHx2n0zngPttb4nDtnI2XjYWNe1Ez4scj9h7AqmBTQIpQBnBc
	 pr9iihZrWk3PtFTa7adm7qvkpGGnADFlyFe0MqSwQ7c96InpDIfE+6emuQOzSySxLSJD1
	 sDrKhQnnJ1IjAwFcupJQ1OM6tXJcxE12TNX+StWesNVhlwf8/Nc+h07hPhtte7w6BAhnw
	 FB4Vwl6f9iBvn0ccoVMyo1NOJIgxRMtNj8awqBPGAClaXDmGCU63w88wVlSd7J6BMAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qe31VwVD;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBE60A2618
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CEBE60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qe31VwVD
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-382c3c9671fso873627eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164061; x=1795768861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fqgQ1PFUcTxqPkGPD9MBUjIl2fcMgF5433kwtmJbEc=;
        b=qe31VwVDp8c3pEPSPq/JYuCX2YmZfbdatj5jYB7hd1hWvLNkoUhMoxErK6dClYT5bl
         IA8waPcLiq8GtATzit7dSLxy5+u0ZTx2vajOATURkMy55sUThX8IDrdPat/1uUXGrZ05
         qdVgwRQj0xPSxfDwCu7E4vercKxHM4Xm2zOdnVhYvPfL6tMTeBs9PHy5LkPCLKOtysZc
         jumXAQ5HbgiqsuyZmfCQVBUPSZM+YAqLXyJp7cle7BUrM+XammIc0OG2TOh54MXntjn+
         fM21EVfO0YFP0CUvwdfDTRegAGNpvoT0HPvLQTYIiK0LiVGRbHl78A8LppjE8HlnY4iU
         zf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164061; x=1795768861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fqgQ1PFUcTxqPkGPD9MBUjIl2fcMgF5433kwtmJbEc=;
        b=rMTE/0Ad4wV3uSD2N1LJz3iO/ZtOsBC2nfqBDfqJHNr/bW/lmHy4/pl80MsrL3AoiG
         BrZBDZX9+/ooKFzFuwhYSOZ1qHYmG2YbabFSZ1iyXkhkMDsfvJpbC/QPfK1Qv0qBeRJp
         QON08wCJZFHRRJQpOCy4/UqL8LPFxgKcs3UgfmXJMO6906bB95+DDoRs8f+CqbdQGJc3
         W29IcA3gZJAhwoQvw+Cv+oGrPuRFbj07GlVuQcleuWxUhdx8GUZActx5eVJw4kPfLLf1
         IdofzEWI3kXSoZFYoyKLzpQWoOcYA7VcDlHrs7r1xIXfq/3pG5/my63/QNQ95yNINRHH
         Zuxw==
X-Forwarded-Encrypted: i=1; AL+hErGiXyZ4yj2CNrbn366dzLDFEvnpnIPf/ocorluacSSRYEuw3p6vRyE3S0U+K9ENEecxwSg5L1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pX0c+wMkkGM61k4WwyiE+UH8pAHhpPIqco6da9mABeVRsCn1D
	1pGCF6KkD59CQx/jX8DT+gT4/6vBEYynnvxZsjufiY4Y2AgmVzKr3E2d
X-Gm-Gg: AZFdTZfIUSiSv6dQ54rwDPQVgFwlWhs+WVhFha1W6iWHqUVoSbwPqmGBXDDs3CDVP7p
	qussQH859e/PW+GuFeQRHKFmNIyFLV62bpZXyg2X8upNTstJbA5cdPDpZaA5RQDJIHWwzq0tDWO
	rDrsSsf21XOSbzXC2X19dsAV2IYq0S0EmWd3dE382ESYr2F5bDmhqcRzmZzsAWAaixAziWlZmnV
	KQm02xtRZyOsKUOezOzQ4AteELcZ1+aXU92eXcADe7jq2+T9+2pWiHL6nuBg1tj53s2OSc/XVd9
	0mVYXQHMQlpfMVSFWm3klBverZyzoZcC9he3TcleWfgppSr5WgSySfkmkD0Qu0yMuEe/IqaFkt0
	Glbre2snXoxIdkz9MYWsHK5oEybT0YqOAhG0WkjiOzXx2/Yp7B9bcnUTNo7Oeo2eYGxSd2zRRrt
	hAXNyL4q2l4cQuBqtXzpwhKoBdGdWwqo5MhVSpJbGoQPEiLgFQPMShVX8B7j+ZmnaTRtwWMQaoB
	TgQZQML9WGKEV7gU7da2oNsVJ5ZEzZjHAZZWCxPanyJsafi0++AKtO588Q2vIzPlGll/As61JBJ
	eGmFDU0ERh459n7EW4V2LnUid2GYBw78b5oviQl0uf1g2TzsFYUTn5sT1re3XCSER574XpaAxqz
	kmwPk9bTJx5ST0gYYkA==
X-Received: by 2002:a05:7300:601e:b0:386:1e2e:ce0a with SMTP id 5a478bee46e88-3861e2ed1bcmr537091eec.27.1795164060701;
        Fri, 20 Nov 2026 00:41:00 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:00 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:50 -0800
Subject: [PATCH v3 02/14] HID: logitech-hidpp: use GFP_ATOMIC in
 hidpp_ff_queue_work()
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
Message-Id: <20261120-hid-logitech-hidpp-v3-2-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Force-feedback playback, gain, and autocenter updates are invoked by the
input force-feedback core while holding the input device event spinlock
with interrupts disabled. Allocating work items with GFP_KERNEL in
hidpp_ff_queue_work() can therefore sleep in atomic context.

Allocate work items with GFP_ATOMIC instead so force-feedback commands
can be queued safely while event locks are held.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 85d8d168ff15..d9342a3e8122 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2542,9 +2542,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 
 static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
 {
-	struct hidpp_ff_work_data *wd = kzalloc_obj(*wd);
+	struct hidpp_ff_work_data *wd;
 	int s;
 
+	wd = kzalloc_obj(*wd, GFP_ATOMIC);
 	if (!wd)
 		return -ENOMEM;
 

-- 
2.56.1.750.gf70dc682cf-goog

