Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com [74.125.227.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1643DEC8
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200174; cv=none; b=Vs4/jnfNAmBLK5FPytaFDMtTEN0aN0k3YksRjFqhBwgCjQn2i91yBOed5z9SPjSMYVoIaK6hHhHFo6iwMa0KkUkgGYLpTd3jwYsyCbP4tlYCr5M0QEavnMfbwa6fowiSWwZH1wGRb/GdM2tA5BbX+ptD/BkRtC/Z+6atEdkmb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200174; c=relaxed/simple;
	bh=JOJ4U2NvrHCHZvl2EogMln8s1KY7WSnW7NWuBNK9vpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzKjDCM4aPdQEpf4i94hnSdXoN0n6pko3IJcznHeOuD6GJ9TkRdrqAhvwtgtc9X0F/0iJL6vzcoV4C+aZlQJw+YixEZFOjql5lkeThH9YJeNBiPzGuKWn/Or0Du9WxV8jDqFwV6XLoV6c1oRSzB9xarrtiXz3VJRIbotPWe0S2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL3zq3A3; arc=none smtp.client-ip=74.125.227.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL3zq3A3"
Received: by mail-pj2-f19.google.com with SMTP id d9443c01a7336-2db18fe433fso7285145ad.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200172; x=1790804972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G9+ztk9gxVfDskwhHVcYGlmWT89TWU1u4/wudZe1Mmo=;
        b=IL3zq3A3/86U6m0juQaiExr8DAZ09028r1/AUxjSCvcJMKnbVw/Up3OLqaG6vu/4Sx
         rh+3us+a+YfCxobJ6dvbGl6QtGTc8aDMOU8+BnTV86xHFDWI/y44gxNzY/g/y69eejRk
         rSUIGL6ps+IYzJ0MfD1dVOKxxl8gYiYb4HvCpcYCCqxosIhtOugZPfL/UTZLvIpsgh0s
         K0nqMHH6m4OAggCbNSZ/nievfsMKPuFIOPqEbKzkqwgZ3XpCp8ROFe9DHCNr/2v+KEqV
         KlWU5dRBPD52PQ8w0xR0WRopOhbZvoPap2cx2aWGpf6SRuv+hOOSREVkiQYObIIGzfzp
         z3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200172; x=1790804972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9+ztk9gxVfDskwhHVcYGlmWT89TWU1u4/wudZe1Mmo=;
        b=Oer8E47ORVGulSVqJkXpAG6QIW1hkYtHCBpWJVfMBsPv3FmLNivNYbNwXglwFZOqkn
         WOXd0SBQZT9MYxa85S9DGBKnOqLkYRX1bvj0iRU1Eg6hOsGwp8gHlyJ6k1dvJQa4ji+d
         ygQKGlK7y1kF49fiZMP+JRpEIj+tVk0RE8QTCuqO/GlF+7men0lKq/VGKdHw0nkMvbnU
         bwNLO0SdUSg+skA67Nzbn/hqnd6HLIrsN5pyuBaLGJs6fLU/3TGSMLUOBRz7rfooi0UW
         uZ+WyPbOESL4UviWJ3AunJzCE/zpAIQxsM6AdmAvGP3S8PdJ1O2xozv5FGLSikzf54mS
         fZOA==
X-Gm-Message-State: AFuF++mzUa+WyuccK9483w2X63MSWPzr09tmHGzzDTuWRz/RP76vpkUx
	3aZKLe7hLkRm1NIZLy5415pq7zEV9opUIfUCJ4FkVwObXaCo8NX2uFZn
X-Gm-Gg: AYBFou20ut5gg4ynIS4QrQJ5x6u40liFBZObbE3N7Uo/XFF0xXahro4o+3yiQmKPqw2
	Gw2D+tnTTQ34LVve91WDbZP4HUg3HKLqlKKLxurQmEZfwVc+PIcqQvpyvBEMt+FPPcZS7jRzgYR
	OefgiZp4DXTL6eBOWm1LiflJroMeCNt0k/gcbOEYtZkSDL8Q+IbUzojm9lsRaA1XjXdVzUbGiFG
	GTsKYxoiq6QX6vmiu4WSNNSaqzWmnWd2QSz6wgxG/VVU8bi5/AiuCM09y6LzaEoMba/kS1ALYCT
	RNtwxQ0Ef0lCoOt30UDwCx2xOu/T8iDKjbdpBxjTG9dtawVG4P7In6pnK1GeonTrym1Nbp8GQhF
	Ulwhsqc2FGBTejBGncWXZguQf8KNDfm4ejsCsHNllM6jiron9zigSWS8wgdfDZdEs0VIyxwj6cY
	dJknolu9ialOlSzqeOXxXzoyO2lMBCmQmWDV7uplwm2AiBFO71tAepYTbkL66q56t3NCwAB13hN
	GKE8T0=
X-Received: by 2002:a17:903:230f:b0:2db:56da:6a0e with SMTP id d9443c01a7336-2df7da4290bmr3982015ad.9.1790200172500;
        Wed, 23 Sep 2026 14:49:32 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:b51c:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5f0a56sm16493405ad.66.2026.09.23.14.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:49:32 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 2/2] Setup touch switch for different order of input registration
Date: Wed, 23 Sep 2026 14:49:28 -0700
Message-ID: <20260923214928.18760-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refactored SW_MUTE_DEVICE code assumed that stylus will be the
first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq 13 and 16.

This patch covers both touch-first and stylus-first cases.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..9520296cb349 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3977,10 +3977,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/* setup touch switch for those devices that report pen interface first
+		 * can only be done here since we only call this routine once
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4403,7 +4405,21 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * setup touch switch capability can only be done here
+			 * for those devices that have touch input registered
+			 * before stylus and pad inputs.
+			 */
+			if (wacom_wac->has_mute_touch_switch &&
+			    wacom_wac->shared->touch_input) {
+				input_set_capability(wacom_wac->shared->touch_input,
+				    EV_SW, SW_MUTE_DEVICE);
+			}
+		}
 		break;
 
 	default:
-- 
2.55.0

