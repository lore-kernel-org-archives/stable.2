Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583390;
	b=s2tWm8oeVgSfvoiPBjJehmzR0CSlwdgZi6YJfW2ksGxAua2t34nCT3A4A00Y6O6UCMOx
	 EZO3zOekI0ntQOOtt6GbC+iwNYdqI5dUDGizj7jhM2dO38dQKXurg42T1Au12CfIqG/iJ
	 6UmHrbrdwP3K9OCD3sGE/0shQG2bitbd92CzrNfSlCtBOiD9NhLvIl9tiUYiykjR2agWz
	 53RcN9RbSGJ5fwhVV3FgQxFu4Qx8gN3mmLcu3A/0C59KA6Ax3MKdaJr9z2oWkI2zMvZBr
	 XqHJqlubFzmvVMzZH5bXQg9xFIH/lPvjqoKJo0KhStrEtBXJRgwDhTpnGsFydG3sh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nJkc4Eg2iKm1ywBindOsMaZNtPl9hT8ESCn/EKIVbTo=;
	b=bp8svF+5O3YuPcA+GM4Txp6nCylIUpQ9hg8bhLGaiLFhiim/21q9qYQzzQYL05WdXc3+
	 e4uXaFqFBLnUM4JlvwPNtteyndWsrHlJTKFUKVeONscdrbqSOs/OVxRGlPouJz7fDNXSU
	 WlEt9k+0KrN6yM+5JU888I/W+/bZ3Cm2vjjKykCvJ97lLGpVFvV4nFvo9wZRtyhb35haM
	 JNbHzkbBmktc99j3WP1rMEcuEV9aaYcCZUTjNPtlMM4YZHuFY+vG9eQ9wO3dozl7vylOK
	 24m497It6A2KEs4RXCnTre306TEgPPtA0RAd2t+Yqja4L6XixUqAp+RWXn4axZp9ETw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BkXDiVYP;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D372606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D372606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BkXDiVYP
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd76b1361dso4363375ad.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792583390; x=1793188190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJkc4Eg2iKm1ywBindOsMaZNtPl9hT8ESCn/EKIVbTo=;
        b=BkXDiVYPZX3UTgGhN4ubLafLf37lPMOkH4+6qtYXfmXErob1g6lIiYOOWz1PN7gWJO
         vB1Tr60E16RaPDtGltlJ+juiJoHDtnbGwWFCFExxY8CIldh/Y2K9duuZKN5tqS8x01WQ
         snuXH3T46f0CqCYxbRJaDeBOD/nQoUPpjDnMxr9gtGFrhSsNKANHzS+PfJjmkGHkyi9S
         NZKJ2tGRjg4C55VpFuOm5pqn0Cd8et0320WvXGQYemhgaZFv/2pMFS14fEHNRoEqFsI7
         +pqeAV/VV6Dhe9y2u5PR5ZRscSCWK0vwxjpIejl6vxZxUL/DMeH5k5iQWxnhXG0BWjSv
         4NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792583390; x=1793188190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJkc4Eg2iKm1ywBindOsMaZNtPl9hT8ESCn/EKIVbTo=;
        b=FmLGjvLate9b0MAyNKissBxBCDbHBuFth6vKjZLJMjnoW4Q4MU6IY1px962CZAKFGY
         slN9HQkyt2fFflMDMeA9WCWa171miMSDSdaJ1hJNrqhkPSHPsLIEB4rXZYM3+dGpDaIJ
         sLVbiDqgYX2kHGqxoFvLKDmt74Siox3+f+Zm5GTdlRcWOMEylQHKpC5ftuRWW6nnzkDi
         1I/qt+ZStpAOlSuBAFKSPTuXKbV5mFwLwwO+EHOtzzsV/x+rmh8BZY7A/U0lUoOs5ARS
         o9A+yo9Ky3AStvnLN/YbYSqqzu4WmmEEb/kG6Q40TRD/7pOVJwo209G9tg9b++nU3zlm
         /zBQ==
X-Forwarded-Encrypted: i=1; AKwUvByFoUbvytRdijl4XBEhh0100JlLuZmZXyKn/XdfphbwMJrbMdzSD3tOWl0nKX9tfZ5n6aATV4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3EYiUJEVtlSFWHVHXuo2fPVgNoMGyhongftIry6rb8/EqlFLE
	czUSop8Eg8EShwPRVcmoJnezlaE3qkBGnsL+/gWem9/LdmmgY+JphJ1i
X-Gm-Gg: AYBFou2rU7PtzO1beVPWoePHYjPsVESJx68Zr/Os1L5Ums4hAfHzI8Pd6mapACJMlAR
	079lXux9q/B+hSvWwwYXlVrd1yZ4sjk8qSpNx6mb8kAFB4W6sa/akgvdrbn5hWUKvrA7KjB9oym
	aFUh+h7Qs574UBdI17kyaorq5hTCgTl6AFtHhUzurA/CqXNhV5PzjSbSm+VODiqkcc74oyOv3zJ
	WDbewqs3SueAUXWDNcNUSSpiCgoCGnUdJtQsOUonTpLeoK0W4JuRCUjv+Ww/hkNmj1ihJakKpqd
	kIsHxv0iTPz9D8kvcUT2PoI9hfKe8M+lCqzRhju4REv0l+D9MJInuk5lW33AJqmcGDa9qeyzPZ1
	HhH2eBIcdE5P0jJoy/oWK1v1jr5c4A6zxvrir9N5bmr9Z/4dUh67Jqs3YzYd8PuCEnnejV8RJm+
	cFX+JKWsaXG+KuNZNsdMLjzrrIjI9AWGbVWU8bCyVWT/LBo0TRgIA4d9DYI0GlAfRrZ077CinG3
	hdOU9m/fl3br09VG6QNpjSvn6OA/CvYGUPM9wz9+lfL+tCgzrObNK++Fi2omQH4An3X05KVjuXK
	XzMIzABQMGRK0Q==
X-Received: by 2002:a17:90b:28c8:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ad86ed546amr1493685a91.25.1792583389514;
        Wed, 21 Oct 2026 04:49:49 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm4282086a91.7.2026.10.21.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:49:49 -0700 (PDT)
From: Jianping Liu <frankljpliu@gmail.com>
To: corey@minyard.net,
	rocky.craig@hp.com,
	akpm@osdl.org,
	openipmi-developer@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianping Liu <frankjpliu@tencent.com>
Subject: [PATCH] ipmi: bt: Stop the unbounded reset loop in error_recovery()
Date: Wed, 21 Oct 2026 19:49:34 +0800
Message-ID: <20261021114934.1340838-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
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

From: Jianping Liu <frankjpliu@tencent.com>

When a BT transaction times out and the retry budget is exhausted,
error_recovery() soft-resets the BMC instead of failing the request if
the status register has been non-zero and bt->seq is small.

The reset path ends in BT_STATE_RESTART, which deliberately keeps
bt->error_retries and bt->seq and restarts the same request.  If the BMC
still does not answer, the next timeout re-enters error_recovery() with
error_retries already past BT_CAP_retries and the same seq, so the reset
branch is taken again.  Nothing in the loop changes either condition,
so the request is never completed.

We hit this on a production machine whose BMC stopped responding while
leaving H2B_ATN set.  The same three lines repeat every 11 seconds (the
5 s request timeout plus the 6 s BT_RESET_DELAY), 27321 times over 3.5
days, without a single "retries left" line:

  ipmi_si dmi-ipmi-si.0: IPMI BT: timeout in XACTION [ H2B ]
  ipmi_si dmi-ipmi-si.0: failed 2 retries, sending error response
  ipmi_si dmi-ipmi-si.0: BT reset (takes 5 secs)

The state machine kept the same curr_msg throughout, with
bt->error_retries at 3086544 against a BT_CAP_retries of 2.

Because the transaction never completes, intf->curr_msg is never
released and every later request piles up on the xmit queue.  Each
queued request holds a reference on its ipmi_user, and neither closing
the device nor ipmi_timeout_handler() cancels locally queued messages,
so the users of exited processes are never freed.  On that machine (a
5.4-based kernel, where struct ipmi_user embeds a srcu_struct and is a
52 KiB vmalloc) this left 552291 ipmi_user objects behind, 27.4 GiB or
93.6% of all vmalloc'd pages, and the machine went into repeated OOM
kills.

Only take the reset branch once, at the moment the retry budget is
exhausted.  If the request still fails after the reset, error_recovery()
is entered with error_retries above BT_CAP_retries, skips the reset and
falls through to force_result(), so the request completes with an error
and the queue can move on.

Fixes: 4d7cbac7c870 ("[PATCH] IPMI: Fix BT long busy")
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
---
 drivers/char/ipmi/ipmi_bt_sm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index f41f78972b9c..a8c181196f71 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -419,7 +419,8 @@ static enum si_sm_result error_recovery(struct si_sm_data *bt,
 		dev_err(bt->io->dev, "stuck, try power cycle\n");
 
 	/* this is most likely during insmod */
-	else if (bt->seq <= (unsigned char)(bt->BT_CAP_retries & 0xFF)) {
+	else if (bt->error_retries == bt->BT_CAP_retries &&
+			bt->seq <= (unsigned char)(bt->BT_CAP_retries & 0xFF)) {
 		dev_warn(bt->io->dev, "BT reset (takes 5 secs)\n");
 		bt->state = BT_STATE_RESET1;
 		return SI_SM_CALL_WITHOUT_DELAY;
-- 
2.43.7

