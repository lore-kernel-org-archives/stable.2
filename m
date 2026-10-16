Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F13290BD
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119250; cv=none; b=f6yi6+J6wf4UWz9p/XdLcDeE6KirRFCi/1+BN+Bk9az+eI3sH8fPpafFcZzOqky+yuRGLyPAZtQR1VCPJ5EedappYYiHlN1Iqp6fY2cx7OyxPID7ep+2cUbO/3BAFKyqetX/X3gGCMmi3co4hym1GPFd8bQMIKVNIkQRMb1ASao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119250; c=relaxed/simple;
	bh=Ht/sdt0Xg3nIv22FnH9XXQfkg9UkhWoR7tnim7fk8CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K6baTNSt7h4ASC/r+huxdHk5wVR2w3evLBu6tezW/D+YdVGemASApwv5N5Y0W2WlVyysPQaaBZEP+PGe2e5ony2PBaZrK7bbzdDEF1IeEr5sRAUz/1DoIa2b17HqpzpF914jimLDgQIZLDJ3TyvcPfqA6f7YFElGXA31Th/hsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqX/ySFp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqX/ySFp"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-487049569b6so4090085f8f.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119248; x=1792724048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMUiVCJk6662ECKbtVsXltYgL8clVA2PMrxyPMJzO04=;
        b=XqX/ySFpTzRSBTt1mV4sD6PLe1aalmffvIhZyzQ853fZjU6SYGYvA7Ef/JTpP0ljwx
         7Q2odnqBhpNffRuyVyr2Sl9QQDTjpJKhL9187KYQs/I8t2aYyRqDBo88f/Q4aN33Kpqg
         J8fnfNoG/P6bs+7qHBBEjrLmR4B79YhVb+FUXZqe7yCDhonM4o39teFEreE6gRGn7QBu
         MSnoGWvaN0kq/NjKgVZZAaj/kdfCqTeeAN/zksfM/kl07C3UIBXcNfM27VUnPtOK/yR1
         aJ2PhB7kNGcPJjiwbvMYMoCH3gUALs085/JSH8CwYMhXFqmUSE8kDN3xe/dQBqGPgcTE
         xrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119248; x=1792724048;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XMUiVCJk6662ECKbtVsXltYgL8clVA2PMrxyPMJzO04=;
        b=bBIfLyri3NS2PJ2as2OjLBAxYNfTZNApz/DDC8cOEpIi5K5fH1R88hoTLgHFvVGSNz
         +vh1QTuXG/ftfbS8oNmUnlNS9B4mHCPndM8Z+LzPayjluQsWdW95j9IIPUjUNGkQUZZf
         vaq5kxXATjh4Od+ASgFZbBMAlr7AbN3E8AADUB4nQH1NbhgssedWxHYdAL5F5qXb1chc
         6DrbcpG7L891TUpGc0pjL6YpBImx3IOTaK7DkcxUxjI2NazcDhRHa1q6wZbFK1KlX0Hq
         +R+pVycwkrhtfLy2jBberDbaC16AdEx6Nciex2/beaxGH0gbVwZFyotZfzkbuP/gR04C
         v1FA==
X-Forwarded-Encrypted: i=1; AKwUvBxl7+dAiwE1NzzHPkAYpD+CRE28I8Qv5c0Edo9nV8YWyO0M63IPOqsA+hsoxO72OZfbhnf2Yjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh5OqER1y2dEu6LVYRrbaW2ZTPNfURr4Gx935kfc+GUTFxp98Q
	1zp0foERsLcWarMaC605KGlcUTc7zaANXKdosQYKTxQUt/WyfLLmjzqA
X-Gm-Gg: AYBFou1ArUZxoWUzV/detfbi5NPqey1IoGp99FmqXoiFbJo5TPuvePhszo2sFaVphns
	/skHpcSQMmmc+Y3BpUAL2f7rIf9/Hmi+lVW7xOtlVHtXiUI24QzAJ/f2+IZfC3yxoPgDDaVTrok
	x0qM60lcunCzi7+Ld2SryRXbdnoSf9+xpe+fiL5AXMgHdjz4n4wJszGxeY7mA9Ut+Elqok2Zicv
	tQ15B3B4M+Rn0/x8DuZ9o/b6CL8P12fzevr0A9lY6oqkA2A255kURnVc0V7Ay+szV6ZYPOH2fAC
	Y3xeXd2lOnuhvLKjJJdIHYG5FQZ2dxUQZxvx495++sKX5WApoUowIEW1bLgmqdgPSCmI7vpA0+c
	iy1wDCXlaQH0VB0tptRLj81XOGyNcnz5VSBZXMfhB04CT0ke+BYMQVSqcKi5yLKhtSlaUBtsZdb
	X5waZCZUvl3ERWr3NRn+8F67BcO7m4rKWs0B+Axal9X9MkzEmjYRfS7EoOiHLuwqj0+nsrOpjAb
	JMDF1eeUXh+dZU0cvHv9yoOFJToSZUa2CVQhwbnhKkE9MksHBTeSVmzySY+jJE=
X-Received: by 2002:a05:6000:299c:10b0:48a:fb3e:d93c with SMTP id ffacd0b85a97d-48dba784b80mr29887033f8f.5.1792119247573;
        Thu, 15 Oct 2026 19:54:07 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50aafbsm1954775f8f.52.2026.10.15.19.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:54:06 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
Date: Fri, 16 Oct 2026 07:53:52 +0500
Message-ID: <20261016025352.230535-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The input is copied with kstrdup(), which stops at the first NUL, but
the full write size is passed to hp_enforce_single_line_input(). With
an embedded NUL the helper reads, and can write one byte, past the
copy. Return -EINVAL if the input contains a NUL.
 
Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
followed by 4093 bytes of "B" to current_password 100 times returns
-EINVAL every time, without reading into the heap.
 
Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v6:
 - Return -EINVAL on embedded NUL instead of limiting the scan (Ilpo)
 
v5: https://lore.kernel.org/all/20261007134711.473857-1-meatuni001@gmail.com/
 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 876fc35d035b..e306bd8b1e72 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -162,6 +162,10 @@ int hp_enforce_single_line_input(char *buf, size_t count)
 {
 	char *p;
 
+	/* buf is a string, so a NUL before count is invalid input */
+	if (strnlen(buf, count) < count)
+		return -EINVAL;
+
 	p = memchr(buf, '\n', count);
 
 	if (p == buf + count - 1)

base-commit: 8667bd30fd033295b3038ce374c551d1059538ba
-- 
2.56.0

