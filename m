Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180717;
	b=sF6xu+ojRV78J0TnMfeDfZAEkn8zeikJEwLXICOzO38TkRdP3taDTcbcCV814zA9a7VK
	 nd0tKn9awvMekFjXNFswc18pFR6ec4WgVocSskGuKK1kCFASS4Q1XZFLW96F2LBQ3FPGb
	 YKEav5iXgj2RUJNuPl8iBdqrDFYKzsksO8dRbjZW2vypLCqmU9Wum7k/7CQVq60XrZ3v/
	 Qfay6uHZpdhPHz9MoT+FNcJzrCglFF3LcakZzgNXAsVQC5s92rXc4guVOVb8bXfasudj2
	 5leJYBLcIOl0LMFKjgNPzKNTrSZKFFAqZZtHad7/DgQpaYIGK9Z/FET3yKylvLKmpXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=THmtNWKGdSUGvlI+rK4tvt1qtBtoY6Lh6AheMCt1Uxs=;
	b=NAcuqMoUnsN91Pr2ifPwX2IFaPQWLhQQ/YholVBbosX4iA2JKPDigNGVkZtoIt1VpKqA
	 vY0yuNQnI4R55Qxt7AsxjEj135GL0r9Pkj/LW0sxzDfPMT+4SDFHtgvam0sim5OEkI5Oz
	 /SZDNY5MtiJq8IMKl8StkBeqwWW2VNSbet5RxTnvzFRFJckt1gUIbuv4WorWrM4iRT4bV
	 CPM6hjgLqIb5RIl4IWcc6ofuu60qpianIHAeaFlN/2w0YctgYJMhhoGDN6TK8wvxWrGR8
	 Yg4AKTbwbEL8yPB+0ldMwiburxBHT7UGtvrgRgPPdD5mhy1iAIoddYfk/jLo/OrhGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iZi2yk0X;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFF606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FFF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iZi2yk0X
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso4160695e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795180715; x=1795785515; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THmtNWKGdSUGvlI+rK4tvt1qtBtoY6Lh6AheMCt1Uxs=;
        b=iZi2yk0XZTLvBAAb36l3OOZd7FRkvOfdyolXV2KA/5IbeZ2hS4C+n7F+6wA8YAx2cC
         uRrcT0o3rpY0CgZoHpLnD0MYHDxVQENGwVgmR8QZ6hV6VOAO1CLLIPRcJDqi0lSE12F3
         zMdoIbDjtTNlCKPA/ycJVR0cfBLdGxl3l6GKdq06i3BXmw3DH4J3yXWStB+7o0JRgdRM
         WfUhFBBO4nm52u+5wvIPUZRcdPTWE3CVi/H59846CfGmcwIfV7AJhGOEKlLkKXFo6e/y
         kXne8FuEYneQ7on93PtmIJEmAinUCQdpKhfKAzAGcr2j5lRjMTpVgqJ80Dzkn4Cm95Sd
         nW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795180715; x=1795785515;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THmtNWKGdSUGvlI+rK4tvt1qtBtoY6Lh6AheMCt1Uxs=;
        b=U+n30lexvBolpLVnxcPfHRZOVko3eaYjtRvsQVfzadgRDE6Ba3XJoLYhUK9t5dQsdZ
         AhjwhqXP8JQUAza8BlqlsQajFh3RvxzsrZQyPkyunEkWdv6EX9n6PUTaMbymQ+2kOg5I
         HmBnKSyomu6brFXVwklVTpgVihT8RVA6+6q3UHOIdjiAsGzhx6srCXTtK6HvtoRY7c6o
         +gKqkcwqVZh+3sZjP1yg6UF8n43FvRdzlk241TMYSe/pkR/RaPEL+ilO3Z9K9P9fLNOd
         s7FJ/9SBGNY7BvIFnZRmy0ktaeADmCTh2bfyZzLCVCkXccZnQLLGFctQfpku0uzOiMEz
         +EvQ==
X-Forwarded-Encrypted: i=1; AL+hErEVAn0fWeYNI14YyADlJepO6ButQx8RdcQbRj9g66RDtz2pIV18diYdNZ2OdWszdMOVpAkaxZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FWsuCnqYmjF1PIFlJHUuqIlrRs6YZzD4vKRsQetKR7Nr+v/LE
	So/D5Imj94gaTfCmecTFlpBW0Dhd+M76QexyJgyJ/424UvuJmXY8FaPXJbKvzM6K7M47P1OU9Q=
	=
X-Received: from wmbd9.prod.google.com ([2002:a05:600c:58c9:b0:4a1:810f:3937])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6708:b0:4ba:7e6:53d6
 with SMTP id 5b1f17b1804b1-4bb88940848mr59000965e9.33.1795180714601; Fri, 20
 Nov 2026 05:18:34 -0800 (PST)
Date: Fri, 20 Nov 2026 14:18:29 +0100
In-Reply-To: <20261120131827.480055-4-ardb+git@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120131827.480055-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3707; i=ardb@kernel.org;
 h=from:subject; bh=eJW5Q1BjY1re402No/fJ4Z/93XbGNr/CeguCf/4k6EA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZvBY+n2iP4dT7Xj2/olXz3M5fJ7negfnj3v6+H1z/v7F
 7068fpYRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIqT/DXyHNwt8ntDhtFgj4
 mrJc3vRopa3Ru3pundyZEnpW8iFPrRj+V4htY8jr2izp6Wx7NHrxhGW7prJtWHHodGWulbSz1dp 9LAA=
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120131827.480055-5-ardb+git@google.com>
Subject: [PATCH 1/2] efi: pstore: Make pstore_disable parameter read-only again
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit a28655c330ab ("efi: pstore: Allow dynamic initialization based on
module parameter") wired up a kernel_param_ops::set callback for
pstore_disable that invokes efivars_pstore_init() directly.

Because parse_args() runs before module initialization (and before
mm_core_init() during early boot when built-in), calling
efivars_pstore_init() from the parameter setter is fundamentally broken:

 - Loading efi-pstore as a module with pstore_disable=N initializes and
   registers efi_pstore_info during parse_args(), and then runs
   efivars_pstore_init() a second time from do_init_module(), leaking
   the first buffer, failing pstore_register() with -EBUSY, and zeroing
   efi_pstore_info.buf/bufsize while leaving efi_pstore_info registered
   with pstore.
 - If load_module() fails after parse_args() (e.g., due to a subsequent
   unknown parameter), the module is freed without calling module_exit,
   leaving pstore with a dangling backend pointer.
 - Passing pstore_disable=N before record_size=<N> initializes the
   buffer using the default record_size before record_size is parsed.

Module parameters are meant for boot/load-time configuration rather than
runtime driver state control via sysfs. Revert the dynamic parameter
callback changes and tighten the sysfs permissions of pstore_disable from
0644 to 0444 (matching record_size) so it is no longer misleadingly
writable at runtime.

Fixes: a28655c330ab ("efi: pstore: Allow dynamic initialization based on module parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c | 39 +++-----------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index a5db3534f0a6..19a7e4fe5b52 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -19,37 +19,10 @@ MODULE_PARM_DESC(record_size, "size of each pstore UEFI var (in bytes, min/defau
 	 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
-static bool pstore_disable = IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
+static bool efivars_pstore_disable =
+	IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
 
-static int efivars_pstore_init(void);
-static void efivars_pstore_exit(void);
-
-static int efi_pstore_disable_set(const char *val, const struct kernel_param *kp)
-{
-	int err;
-	bool old_pstore_disable = pstore_disable;
-
-	err = param_set_bool(val, kp);
-	if (err)
-		return err;
-
-	if (old_pstore_disable != pstore_disable) {
-		if (pstore_disable)
-			efivars_pstore_exit();
-		else
-			efivars_pstore_init();
-	}
-
-	return 0;
-}
-
-static const struct kernel_param_ops pstore_disable_ops = {
-	.set	= efi_pstore_disable_set,
-	.get	= param_get_bool,
-};
-
-module_param_cb(pstore_disable, &pstore_disable_ops, &pstore_disable, 0644);
-__MODULE_PARM_TYPE(pstore_disable, "bool");
+module_param_named(pstore_disable, efivars_pstore_disable, bool, 0444);
 
 static int efi_pstore_open(struct pstore_info *psi)
 {
@@ -255,12 +228,12 @@ static struct pstore_info efi_pstore_info = {
 	.erase		= efi_pstore_erase,
 };
 
-static int efivars_pstore_init(void)
+static __init int efivars_pstore_init(void)
 {
 	if (!efivar_supports_writes())
 		return 0;
 
-	if (pstore_disable)
+	if (efivars_pstore_disable)
 		return 0;
 
 	/*
@@ -287,7 +260,7 @@ static int efivars_pstore_init(void)
 	return 0;
 }
 
-static void efivars_pstore_exit(void)
+static __exit void efivars_pstore_exit(void)
 {
 	if (!efi_pstore_info.bufsize)
 		return;
-- 
2.56.1.750.gf70dc682cf-goog

