Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.68.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584527;
	b=G5HyRhnVPYpftr4mjY4acVgzhfNlyb7dn9m7zkzlI7hMzPQZ1cI8E2jepXkDD7iCHTcC
	 dgcw+saZwCsWkSdxmig617PdzXTf9MwyEoI3FZIbvO0WAavx6mICZ0dOzwLQIqZa+YX0c
	 Z/vffCge3tggGsaZYbCYeOH1BZ6Mq1+RBE/2SMSXTPI6Q99MKKcYQgGyHjNU8LhODgyY/
	 bjnaf7oGSXpYy8ETFWzEgm51D9XtpkDGBmlPuq9PFJJRNpaQMoaQ2Hjq3WuH7IOyTT08T
	 3LK/hIfoniWmWfcN8JoQ9/OIK5RH6y89XJ+1nS31xthl5zw4fQPCr6gRK+b9RdCJa4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584527;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=QJXz6Gn2K1VN9nepLWRw3UZWWzN19sWrO7Tu6FlLAeI=;
	b=2XhU8XMhBRGWlN4XJ5eP+MHt8byh2yfeBzzepHYDsvNZ5wB+xsNzo2Sdhbp1pk+Dy6KH
	 bkPh2NqRvlTIvvkHNQLyl6R62I5UB1x/sjNeTuRp/ppsf1JnlfuZOcYqBoT/2tcOr2v3W
	 1u5PYYjfywPv25X88QrUfuAiPXdcJJcHn8HfMwpB3vJJb6WGCT3tYuRPM5BrCFXXxIA4t
	 1j9KYyuIMX+K/skKDrf584OLGj++US03PHA+SNuilf2Aq1ahrLtV6D3TBYGWzv58iIWIX
	 4w39ojKVB8RfhG/7mxbP0DwXF+b7ar3iRE8YEwVRo1n7zJ5wP+knIeZuIOFg5NuP6hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=GyvF7QJs;
	arc=none smtp.remote-ip=34.2.68.31
Received: from sonic.asd.mail.yahoo.com (sonic-usea4-0032.asd.mail.yahoo.com [34.2.68.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E2606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008E2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=GyvF7QJs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792584525; bh=QJXz6Gn2K1VN9nepLWRw3UZWWzN19sWrO7Tu6FlLAeI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=GyvF7QJsAvuQB/+0Aik68auCnBVR5A65FnNMa4eJGPR7HDZ7l9Lc0qLEegEHLW2Ud7E7e3HuJb0/qSKszy7NM/T/9APa78awJ0Zv7KgyNko3Le4bZFRsW7BRzSv2ype7tu5GJcquoScswgpS/LDLUuEAApHJdbJle5X22dPxSQTgosxWwQK2wVMlBYaBBcmjU2M7ngSIZUjSEqVCY6eWLtqZmm1KjIIA5ljkme+x8RIXMoaoI6Pc/tQ8zAa1FdeWNLXz+CQX/fOIwN0Ye3ueUC8A003BZ6YtggkZzFfB9XXy0pRelBP1k3lvwtnkP/NKsV3rXuRQFU0lm8uWEsZquQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792584525; bh=3uVU5Zobt3tIje+iZ907gKHhOQXkitzTQZ86nCZOs8D=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=V611/611qOK5D4QIROtCmFR6j2Jt4w2Nu+CZc07xJw9sS2TYOBTtiliPOdxO7//MZw03fRD8CPgc1H+vSwj7FBMh3AS1+hTgxlJF5QsKdxVsd8IbvrsOUcqnyDojL9V6I/kpjb9uPYQGD3grtpiKW77PlhWT9yB4AtO18kiKQYOJFoAdKL3YOPA2C6880KuIQaRtzQFGkg0jXwMJsjqxOBftljATr425Mi+RSn7IZQhhCn+iZLTl8eqojjojeSRKM8ua+KtYUE5GVMidl92uEjIggzV/wGp9lBxQWW5U+3xqnpt0A94Ffe36C0WkrqpWr9X8Ze8takwv5cKXLQpxbA==
X-YMail-OSG: 79KxnzEVM1mkggOb3HCMHc.8o80TAxUPamxznvYCtlQ..iMi5gBGIEqfaYfDiLX
 BfmSZYoxruLV5fzeaJ_OrpZRxonybk3pfLZkk063gjlsJZqBT_1.f0CfXq5yb5ED805U3ksaOPCo
 HtWcMZmBrlfxtu9uYJ5P_ajlUMZ12z.jxC5_IXla6fpgZeU0ZssQ0Tk4hIQDVTAFUIvcGi2TnxSr
 l0JiMrCPsUuM2rpl5.CF7qTgAynj90KdIiem8BrjdIUARQd2Nd1_9FtB.K_.Q1SxBSv6p5rGDh1K
 G3FjHBpdGfSF64jFBeKExabrgdAIMEqgRyvPd5Z7moglf82EfffsHnHsD1RzM8dcXaERtMBToeUt
 eyZhmbye4jK1.Xd60olrvwmPOCar_Bn.I7NzC6fwdcvy3G_rJueJAfByx4_lTWvjEMf69P9DdOqG
 cq3UIVXFRAeOaTD1W2kMa8i3pk4BG.V6IksL8W7DHYU0_XeHjBSrL3EuSXV3pmWhd7oJ0C_RK_wA
 2FChy6akh37ShYqloI3l.drIqUBIsFukc8cBl55xUWm5Ii4RZCRwx64nHPFOYsGXN1qz16vcjD_S
 mqy26UGndRxCMRWkuq7m28_C2QLIxAk_5iipnp7Woh_gmmKBc0wFyBKg4tSIzCSEosn2ImtwrIZe
 RcnHAaG1lIhNMFmse3WoIFPMe2QK0ZY8xr.Op.LLwDTuUZ.IINcQoxRS.weCUMjcTUGwTmun0s7l
 xqbb6DqELB68wPLNIYI.IxrlgFH6wGwRKLMrS6XLQEmeE4UwxX9dUw7.HDj0rVjjt8DCzPdfrRrr
 7oVmNLuoeHVn6HvWj1qeg5d6HWnttnEi_lTDxec06od0gTNtYMiCeFXuJsQ0x2iVr13TrBQ_sHQ3
 UqdHVjjn3qgNizLX_Ic9yCdtrYYxc71_9xrR2oWzQKw5748ICeEX27CdIlmRl7TCUZO0NXS2sDoM
 5UljN7X6L5XfUB.3o6O6xFSVfDiPATwvVF.ryn3tf4MOxowjRhTMlwP2Qe2.4qxv.O9XB6MmEtTx
 Q6AT_Wth2w3cbStYm5xksurxEHpnHHJwazacfU1BeZeZjQl6HTnNKMri4yXQ2j.1coY7ywCQvur7
 ozDWgRdvFimJ_fqkHezoSQh_g632YiQ4W3HHnwfj54DElc8YrbJ4WgwFFX6AcmzTP1cLVQFGxbY0
 4Z0FoDrehzzijcmkW.W161VaWW4zFc6IKp9e1W8wbQ5aiXQQFk.mbDPdEaLd0uQDb_Tyt7PTGoFF
 ADwiwWCSki78xpwf0UzZGzMHkrCPObyh9KAocVEZ65nW6T2pqDbCTFgF_e8Nh..uUZEsm9AOeGud
 mm09eDRENeUNZenfu0yrFBDDj8IfnNFwXn_3gpg4oJeicvq.9sSN2Tal7forUASAsf9fQAU1rUkE
 onOvkNir787pRz_1Px3FcWlxyGeS0zuI394VKvYgQeq8dcyhSSbqC9JPkNluMHVndeJgVRDSG3PH
 QofvLSEmmQHbLc0shHUxRLL7GzlPEGj1CnNRFJND4FQ.VVRImWLD9ziSTL3aDyhnUDnYqy4WnHmW
 2lecuHKZ4VMrRNoBurpU7K3vwYBTnYXHFw9U3DjJWiJNvzAxKjh2Yd4eb2Ela7.RmUzqGiZipWKy
 B7CZiGUMzmTyUbEf_MXyKcflwrUPTL.DEMIf8eCxBcknW35IPed_wQoKloiltU1tbNezWAMweV0F
 _2PZQRJu7bPYw_s8rPIa9CCEHXGlAP06hbfqxPXNNKqgPuYNyd5W4o9xEKxV8g2sApc2OYGRCebu
 7SFtq.ZcHSP9EYDoSurC0DM5xMyUhHxRp4fJT28GgiZET2ISt3K1IJC0T2W2nGlXLS8aGZdjhmon
 ezbNspq4xMxs.yaF9AcpXcb_ALt_DGEWCbNzL7Mt8tX5G0UuSHfHYnc4bFAJfy6JRHhMfg6Ayfak
 FufikOE1tdVSAW8BxToEtoELbhdL2jWnFuR_ScHVFrswkqxUqqLJag2nV1StPsbbTYESHho9Y6_7
 kYPVuMzOCoMZ9anCt3AFVFWGIwRckyQQnwHby_0NfMA--
X-Sonic-MF: <stealth3m@yahoo.com>
X-Sonic-ID: 986a24d3-e741-429f-a948-95863a48940a
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea4-prod-sonicconsumer-svc-101 with HTTP; Wed, 21 Oct 2026 12:08:45 +0000
Received: from dip92.lsn.bf1.yahoo.com ([67.195.177.101])
          by hello (SMTP) with SMTP ID 9fecd6f92ffb24fd6c6c1aeaba8e0acc;
          Wed, 21 Oct 2026 12:08:41 +0000 (UTC)
From: Ext745 <stealth3m@yahoo.com>
To: linux-media@vger.kernel.org
Cc: isely@pobox.com,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	ribalda@chromium.org,
	Ext745 <stealth3m@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: pvrusb2: fix control enumeration with V4L2_CTRL_FLAG_NEXT_COMPOUND
Date: Wed, 21 Oct 2026 08:08:19 -0400
Message-ID: <20261021120819.1870511-1-stealth3m@yahoo.com>
X-Mailer: git-send-email 2.53.0
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
References: <20261021120819.1870511-1-stealth3m.ref@yahoo.com>

Since pvrusb2 implements vidioc_query_ext_ctrl, applications that
enumerate controls with VIDIOC_QUERY_EXT_CTRL and
V4L2_CTRL_FLAG_NEXT_CTRL | V4L2_CTRL_FLAG_NEXT_COMPOUND (v4l2-ctl,
qv4l2) reach it with both flags set.  Only NEXT_CTRL is cleared before
the lookup, so the search starts above 0x40000000, finds nothing and
the enumeration ends at once.  v4l2-ctl then falls back to probing the
user-class IDs one by one: the MPEG encoder controls are not listed and
"v4l2-ctl -C" can't find them by name.

Mask the ID with V4L2_CTRL_ID_MASK like v4l2_query_ext_ctrl() does.
pvrusb2 has no compound controls, so NEXT_COMPOUND needs no other
handling.

Tested on an HVR-1950, kernel 7.0: v4l2-ctl -l on the video node lists
9 controls before, the full set including the MPEG controls after.

Fixes: 8b5ebc688054 ("media: pvrusb2: Convert queryctrl to query_ext_ctrl")
Cc: stable@vger.kernel.org
Assisted-by: Claude Opus 5.5
Signed-off-by: Ext745 <stealth3m@yahoo.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 101b2e9fb..5c0117493 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -510,7 +510,7 @@ static int pvr2_query_ext_ctrl(struct file *file, void *priv,
 
 	if (vc->id & V4L2_CTRL_FLAG_NEXT_CTRL) {
 		cptr = pvr2_hdw_get_ctrl_nextv4l(
-				hdw, (vc->id & ~V4L2_CTRL_FLAG_NEXT_CTRL));
+				hdw, vc->id & V4L2_CTRL_ID_MASK);
 		if (cptr)
 			vc->id = pvr2_ctrl_get_v4lid(cptr);
 	} else {
-- 
2.53.0

