Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541879;
	b=tfL1im2FlugoWgD0LgNdFxBI71mk9njFBG0bUoOAPpQ6hZIIC/mSG+bCiWotHWlVV/pm
	 rAd8rStU1ekbsN4D2LmQWPt3pOFdtDzcW/su7A5h5rADABtc9yhqcpVyFa7Hv46i7xC/5
	 Jb+J+HpRBou+dW//XEtzfRctcBKczS5bI6dTMFGZkjrQBJwRkTBg8kbVuy5X8A/xuoYWI
	 95FNwPTLeNBKOX8BcmDzPPpsvco57xE2iqkISOCGzrF7/Ql7NLxKtR4q2nGNSdwHNljy0
	 Aaeir9WzCIIE3HkI49Ij1oxorFkffwgwIGlthRqxkHxwP5InzGD3iljBiLk45u9Tc9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wlJLIbvVcosGzM9lxx3HqjKGxylleodTsPDn21EHK6Q=;
	b=2Pd15370/KXpL91rurQNuqBIg5IhF03IzvTyc+7QpnPlsEJM0VEWhFP/dVHgGuB/vr2w
	 Ygs4QgC671FlaW01I5H4mwGaFDfz6W3dnzkOSXjNHFcPddP/gj/XbR/GOvWx2x79AnOSm
	 NY3gwESYCAW1dheDc2VIUxBn+uMHZB14MNGFvTvQxL1f5TbjuAWLs99ERkN5OmpRVVj5H
	 x783JB9pljS8MdSNCzSqXcOqjD9aVqJKR1ptIW/8r8AkjAC9TkS4OdGXBWOlnsit+zajR
	 NICKUGYhAd2x4wjpnDw4nrnVeT85R1jmHNaWSNCV9pkqvlGoDRkaFWyHaEg4a7wPOIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SKwWPlAo;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF54606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SKwWPlAo
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso2662544f8f.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795541877; x=1796146677; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlJLIbvVcosGzM9lxx3HqjKGxylleodTsPDn21EHK6Q=;
        b=SKwWPlAoPfyaRWQhlsYxiQwhYXjsCHN2RGs2pweae6d827b9sz/rBsu56DRsTKpz+h
         p3LjjrV0Vtl0kzgBoRMaZQ8M0wqw1JujdhLSGEkULa5WaCSIt4PJJnvSfUIWoLaP04CT
         lA6XQmnZPGLzE4rsLlxNpqW+cTSOsbGQLCDuht00oyWmXm3S6AJcDYRo4QI7p5HaeJBC
         f7R0mGVdDZ+WgsKprmGORgrzXL3ep4wo7iqc2LWYsr8zARhxSrNpCCupCyfrZF5cYkwv
         9rF2/aY67eGo0JI1sqWT78hD1+XpQyeZlARC1vOsVXpl0YBUu1m4tld7d3A7So2ainTz
         CQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541877; x=1796146677;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlJLIbvVcosGzM9lxx3HqjKGxylleodTsPDn21EHK6Q=;
        b=lS2fDh+yi7yId8BEzaRZtHB+Q78f3H8AG6QALSCK0ReQxB7L3REmuiJIqGOwJNLrWq
         1vYWEgm4vihu4ouE+iuoIw7OYumN1hK9n6SVSHD7zKLGYcxej/0M9HlLFjkb26zyVm2X
         JHC+BMY26eYAHIRV+M+mhbF9gaTOOBz3LwF/qtqYqd8tjclZk5UYiBcZ4wdrUyDl5m3c
         3b8sySK8myCV6yYW+k+EyXNa1LMl+cx1kG2EN2ZE0v5oERs/HmPlESnmA8klGDtHlixd
         6ymyFqoOdVR9SBvgshc21yqucIh8NOQPa7N0zscEvdukJBHF542DKNpwyrnIsOt2lAP+
         i2tA==
X-Forwarded-Encrypted: i=1; AL+hErHE21jrGb/c/zqJHu2lhdrB4V2/0mrUrZFAve8OaABYPPOziXNLXtiVCtkdzGZGrXiQWetCbdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d8+u1wR3rJwDik8USCTva5VMaby7rhSlnPysdIbbihaKmqrTf
	A/jfsL46/rzl7uR8yZRSJphehivEky82rhPat6VYzX0/r7X4XzsImkthZG3nLMIHd3Vwmex8rQ=
	=
X-Received: from wmbjj10.prod.google.com ([2002:a05:600c:6a0a:b0:4a1:8915:6ed2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1911:b0:4ba:38a9:85e3
 with SMTP id 5b1f17b1804b1-4bb8880eecbmr345896045e9.12.1795541876987; Tue, 24
 Nov 2026 09:37:56 -0800 (PST)
Date: Tue, 24 Nov 2026 18:28:12 +0100
In-Reply-To: <20261124172811.2580784-7-ardb+git@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124172811.2580784-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=ardb@kernel.org;
 h=from:subject; bh=D+Jviff9cT9FNqN1EwWc3W/lQSGks8VjCMt8OB9ThaI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZv1pL5iZ63SQ/3ODwHf5pZnNtT7uyYxu8Z9rr1rsbv7D
 ddT94COUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJEPfAz/AyXYPhrmsXwLSefa
 fy6decIcgRimlMLDam9+JRsw19yIZfhnavpo08PqxZOuPVE4uq23apMGr/SO799XKGi21Zb2619 mBQA=
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124172811.2580784-9-ardb+git@google.com>
Subject: [PATCH v2 2/5] efi: efivars: Don't dereference NULL __efivars in efivar_lock()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <u.kleine-koenig@baylibre.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

efivar_lock() and efivar_trylock() check __efivars->ops after taking
efivars_lock, but __efivars itself is NULL whenever no efivars
implementation is registered.

That happens at runtime, not only before efivars is set up. For example,
tee_stmm_efi_probe() unregisters the generic efivars ops before
registering its own, and qcom_uefisecapp_remove() and gsmi_exit()
unregister efivars outright. A concurrent or subsequent efivarfs
access, or a write from a pstore backend that is still registered, then
dereferences a NULL pointer instead of failing with -ENODEV.

Check __efivars itself as well as __efivars->ops.

Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 3700e9869767..f9c28fbdb26d 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -143,7 +143,7 @@ int efivar_lock(void)
 {
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
-	if (!__efivars->ops) {
+	if (!__efivars || !__efivars->ops) {
 		up(&efivars_lock);
 		return -ENODEV;
 	}
@@ -159,7 +159,7 @@ int efivar_trylock(void)
 {
 	if (down_trylock(&efivars_lock))
 		 return -EBUSY;
-	if (!__efivars->ops) {
+	if (!__efivars || !__efivars->ops) {
 		up(&efivars_lock);
 		return -ENODEV;
 	}
-- 
2.56.1.831.g720f3f5937-goog

