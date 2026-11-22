Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348511;
	b=D8y/viHOFA8NXn0nxy5b3sWoZknYfg9sPGBKrocE4pP7bhtleRGaQOcZE+oJI1AIiQXC
	 mTnlMgzHlF9aYf/UlA1FUgoEzSFGlLZgVBs09hsn1dI7XrTQooEGeVDYUJjq4iLHC3SIM
	 Y76PwV4ww6nQ0CQUAUfqy5uC76xemLAAinDvYUofReFqhgA4I529YxKTTE2F9pjnYx8S3
	 w1xR59JhrCD4vjMJ+RuvuDzzCFLgPVri4VDE/2aJBIM5c+IkehhdLHOyuLde34ZtHEcb5
	 JJa1got+6t0d9ETJY2y/QE1gxwMfzyBSe7MGnVW57SPHGDdi+6auo6ECVgH2+sZX7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RZ0O0POJrr0conSKv7mDqlSwmUjcS392Zlp+KvMCf14=;
	b=MWeHpFkKdRVN0TLJmxqyvsze+7SRSo/rCUT7zF0nTQ6NLH9E+WgErIFeAH0r656xSWKk
	 zeIBvLh8eltdRl+zVrV/ZNLDJudQSKrUyuDgYmxHlWgNsncro1oJ9zvqe0sxqpFlRAVTZ
	 ucMKyQQxb1Mz6Tbj/yGz4M5bj7bhwlXDnAF/w80oq2FlDn6a+mZveJO9Iqj8Mmp5djxu0
	 iPa6ttpCEgnx8BQHRgP1l1L63SPNGmauykK3l8k12V2DA/E4AMGXg/CvlvPkLiFjpx7re
	 4LxCJX+I7a6fl9A2h4GWSVMBhLPFHU6gJoETCa+ex6sMKrODI2CMUrSlhNyaW7SwhqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZN2r74KI;
	arc=none smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AE606A332
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 984AE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZN2r74KI
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c50564a92bbso142744566b.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348510; x=1795953310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZ0O0POJrr0conSKv7mDqlSwmUjcS392Zlp+KvMCf14=;
        b=ZN2r74KIziq21AkKRBZLDJ7DvPxD7SBxD19TzD7BUqNDbo2zoEoww15mGDen6YvL1h
         zwLAajjPeQcRT/hPlTmh/eQGAn5KKB2wx2KYWpQ3FWE6CV5UpyHuWeDQI8+xswW4UFpG
         p4hWKBucX9xkypVNyEG/2rgeTSej6yYeOlCCnD0rT0C+ya5haMNRyHZMhU/QrGjQGH7/
         Sb44uYB9E9sjmlNdWR2oLooBJzHv5YmquQi+5sgywXCS+a9FvJdk5cgK3nHYl+Er/8BK
         RpqUoIcLBNxfp8ZxfKUHaYdZIl4AMtR6xIZGE6v9KWJrDzyBy1H6aE0RQ6b1BxqpXhyG
         u47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348510; x=1795953310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZ0O0POJrr0conSKv7mDqlSwmUjcS392Zlp+KvMCf14=;
        b=MeDXC9GCVD+5KQW3dDIXmCdTAUjZO0zdykHLpWbcX7gx04wIji2okGPAGsuEu4bMQT
         2DTg8rHAfoLSiVvH9S3snqBH1MeiUF9ta/YI2o82Q5I6NyDW8XVavICQ2mBOC/Gr3Q2p
         WTy0z7lZdL5TY4HltBLazVGc9uJ/zgB8bCYcxuff4vM4LAXRpCEiksSayV9P1xaLsYWd
         NZNjhEOFXuEblUZ36iN/qr+torJBiydByo6lR67ysu+yO5sNgdCE9H90/dRs2tt4GlFC
         m5HHvaRtIdUPHSPFNpI/A8vKIGUHEbtQEuxjv/kIqp6kRjqRxVje9lSHKNZaHatfW5GN
         fIaQ==
X-Forwarded-Encrypted: i=1; AL+hErH10q1OVSwkq5lv505/g9+7oSAcNo0aZxLvgTKlaChsNyZdklLaIGxGDB6KnEK3oPFccmnXli8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2e8loV3xk1I2T/W3uNFymm44fFF7T0zrtVwQYNkpOHHn5vShJ
	g2+VuiQInGZqrT4d40Cpuj+JBbLtfAaf4FVSRHDptbNOgj4vb/ZoS1o=
X-Gm-Gg: AZFdTZc/qYSu8HPkVy5dBi6xw8cBPGHlzLIGNzNG9KI7unHUqhkn/4bOXRcx/fJFOJg
	fMZ4epoEaAcZLP+i5BJhsTgrqhM6b9G9Q1oBDfNsYqo0crhcZZFwTILYNvKZRl7Ar7WEzRPu+6A
	2gm2hW+g79XUhV/iZJ9KL1I77bjn+AY5d0244lB4ZkJp7kEq2l21tEphN4Y8MLIJIZmjsz/4cUb
	zER4p17Mk6orD/UesMpgy3Xdoelp26sG050GPgQ6JNdq920IfHCWQnLSzPub8SW4LzT8n/nSpJ7
	EeeUrCoxctb3XLZIJ3eFBt0FQBa7NOyeNSU3MfT+rI4RTRqAlPbL+SyYRYtYkL3B/D9R9oQ7FQ6
	Xz+AOLYpLsGr72kJkqcl18nMMI8O0N7IxJ1mJKOmBKH+Xswfm6KALzXSreRSvfw9OMbdd4GedWk
	iDbzF4vPlMlan8K4C79p2oMeuBs5JRbV/gChaBTC7MvR44Oo+sH/PlWAt7FNbuMiEPE7Oc3hQ8+
	NP046NpwW2pARHBrpst+ly/I8d8/TA7/omdhpiUFDZCpatkEUGExcqqB4SjTVHXnowkmtpXDqiE
	57nFZdjXEGQ4YzRLu2WSly/POfjys5PJ7Jy7OKezxeic
X-Received: by 2002:a17:907:6ea8:b0:c4d:4d5b:849b with SMTP id a640c23a62f3a-c513a8069bcmr771965866b.19.1795348509787;
        Sun, 22 Nov 2026 03:55:09 -0800 (PST)
Received: from llm-01.drunkbatya.int ([80.251.127.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae67bd3sm299486666b.27.2026.11.22.03.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:55:09 -0800 (PST)
From: Max Andreev <drunkbatya.js@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>
Cc: Max Andreev <drunkbatya.js@gmail.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tcpm: fix missed frs_sourcing_vbus() call during FRS
Date: Sun, 22 Nov 2026 11:54:53 +0000
Message-ID: <20261122115454.2912448-1-drunkbatya.js@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026112206-lapped-unvalued-8696@gregkh>
References: <2026112206-lapped-unvalued-8696@gregkh>
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

Since commit 0908c5aca31e ("usb: typec: tcpm: AMS and Collision
Avoidance") the TCPC reports sourcing vbus while the port is still in
AMS_START with FR_SWAP_SEND as the upcoming state. Because of
_tcpm_pd_vbus_on() ignores this state, frs_sourcing_vbus() is never called
during FRS.

On Pixel 11 Pro XL after an FRS from sink to source the phone keeps
showing the charging indicator, and about 20 seconds later VBUS drops
and the attached device reboots.

Call frs_sourcing_vbus() from AMS_START when the upcoming state is
FR_SWAP_SEND.

---
I'm not test theese changes on mainline, but tested on Pixel 11 Pro XL
vendor kernel 6.1 with the same _tcpm_pd_vbus_on() code, as i see
mainline tcpm.c is identical in this area.

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Cc: stable@vger.kernel.org
Signed-off-by: Max Andreev <drunkbatya.js@gmail.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 51e5c72799f2..5caa649a92f1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6889,6 +6889,11 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 			port->tcpc->frs_sourcing_vbus(port->tcpc);
 		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
 		break;
+	case AMS_START:
+		if (port->upcoming_state == FR_SWAP_SEND &&
+		    port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
+		break;
 
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:
-- 
2.47.3

