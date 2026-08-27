Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912238BF62
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853436; cv=none; b=ZWY12Yu1jmxgeMlNsxGB68s0HCSkD/6pao1BxbyDZ3po835Jju2t8DRzSVWnC+f5csFEY7mn1/3uZS34h3W1L7ryY0nMwRPhrM6ryYoxkwfEEHwFYrp6NPAIySSp9r/KW2fSEjEVYHgMcxHxcoq2t6zomAfZYjxdgT49aLvSTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853436; c=relaxed/simple;
	bh=ErDkx2iyQEuZbMjHNFnxMQebJBQaigVzsGOKEKGfRwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJpzus0BTkKt6kjNWvIzXjTq0ezfg6hlpzs+vq3MPEjt9svHeGKJ3oXqUdkV/jlX2o3KYRAKqe1jyVUx1MvA7qiUwiMQOhNQeZPI7Of5O1WuwvM/5RnNMhnem+iTdsoB/D0U4iDzUeZQsNYPQMaj5tQfQGN/iXk0kQzj7jG47lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRhbs2Kx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRhbs2Kx"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47db714766aso971668f8f.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787853433; x=1788458233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNXzX2LjDvZcxZQqc0tIk0RIG7mCEmpN4a6lNUWarzw=;
        b=HRhbs2KxlbQGfZ+miGEUrNeZwkvH1zykLsar0c7OnUaWfVff+BN2lrXf/col5Dcocn
         xbzfhDA+Oqdat1Ylyck6VdZ4QtxO7EZJa4Ca8FF+v7EeJpFlqw0icEEPSWgFz33n4Qo2
         GJY4R7prpqwam4S+bskUWxWUubz0kcuB5cc6ojmnj27MDMsQ0FjmlQjVvS10o7dlF57X
         gl6nXagfM4mVhdbuiM6+PqyxVdHcQTlBTX60QZgLM/OAxkoF9SKnaaIYl87ahIdm31yh
         XBxupiQfxxHYiKsCL8NDqZohkIBVvgWWonrrR6/cT6IMebgyWf7QhAFiy8pBh/EydKFo
         9hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853433; x=1788458233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNXzX2LjDvZcxZQqc0tIk0RIG7mCEmpN4a6lNUWarzw=;
        b=VomZuFI6H6j6Zfx4n245kml6iWkIWD3ORXWvuqWheu7mVT5XX0x7qZQJPwy+dCPlmH
         xeotVGgZSHCd+P7nuR5QusojEsfPGZBdbDo/pHSemRqn40t00kLRBFVH5HHe8iMnDe0G
         3+Ba4Xelw8/xxwST18EFwFiVzh9T1J6EPRyGbX0vvGY1fjSgQY0yz/OwCcm962VuTrKS
         WRpuupDH9fTmGERxWrkm8opUV4or8zENlTqWbAbUxCsn1pV9EowbQ27mL9KP+fqcYwvh
         gnKrL3oGrEEqVaFYNkQ5/saH6Az+pJrjaNSoJPDkALamvOro8SBOutsWiZGQek+qmghv
         dL1w==
X-Forwarded-Encrypted: i=1; AHgh+RrHDYSQ4fJXhgYWc/P580+Pi/y9Ip9KXC4hQb9Yv0lHJUA7jQZFnEeXkGdgh54Plf5sEnoAwvk=@vger.kernel.org
X-Gm-Message-State: AFuF++nMN1EKBcyOexpxSzPMyhGLMwywQBnIEy4+hvvG+lyAQmq2ZPCL
	rx0cEYZjcHaHU+0Hhlbe0rNHcDOBJR+buFV7hYXMsLT0tOaa4CRylei8fTtzwQ==
X-Gm-Gg: AR+sD13MxYUV7EuZPSOazVXAr6KhUFsZF7FrvjtANCLgGOfH0ilO4bTXI7h7asME4zV
	9Y94m/DCUiCeJD9Z8D2tZPCCbWxcsLl8PYvb3ZCUfeEZgfyOeqPTjoaYBVknzCabM/KhX2Z/VIx
	AHpSvLbquOV5WCmeA56MFo8hjbY72gv4/59mzWnNhqz/Xqd22uCrE6MKCQORiA9gg3BEkFXjw8g
	ReFsfCiuk0q2QH8e4A6J6+Q5Sqyb1wLANlrvloXDTQ/EBN5+LX54JKCrY2MelRUs7rIssGhm5Oy
	AVA4sID+UILdF7sqj1qGhFUbE5fuEwjecBE6/eWItHH9UgKFSar5AT5q8wPuWIzCLblQhZGqaeW
	7v4SANudwEw2fkGvZlcsEU6P8IfVSGZtDc6KF5jXhEaOfY+ghDb6t2cYpiAjnW3hJt4kA25YPvu
	qMc/kYSPXTIgPfW0oJXH6tqTLGms53trcpZQQKYCMhQgIvTxyxtB/nZNag/IJRhb//A4JIKTXxl
	TlC2UCNgjlcOUwD2ZollHbXr91TkLrFTb3r8v1xd6y5
X-Received: by 2002:a05:600c:1c28:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49b91a5899fmr16419615e9.3.1787853432548;
        Thu, 27 Aug 2026 10:57:12 -0700 (PDT)
Received: from il-orgads-lp.corp.audiocodes.com ([134.231.187.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4961004bsm82921295e9.4.2026.08.27.10.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:57:10 -0700 (PDT)
From: Orgad Shaneh <orgads@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Orgad Shaneh <orgads@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] usb: octeon-hcd: fix the FIFO-flush timeout computation
Date: Thu, 27 Aug 2026 20:57:00 +0300
Message-ID: <20260827175703.1549-1-orgads@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cvmx_wait_tx_rx() computes its 100us deadline from
(u64)octeon_get_clock_rate - the address of the function, not its
return value; the parentheses have been missing since the
CVMX_WAIT_FOR_FIELD32 macro became a function. The cast makes it
compile silently, and the resulting deadline is effectively infinite.

On a healthy controller the flush bit clears on the first read and
nothing is noticed. On a controller whose PHY did not come up (for
example when the reference-clock configuration is wrong for the board),
txfflsh/rxfflsh never clear and probe spins forever in __delay() -
observed as a hard hang with a soft-lockup splat on a CN5020 board,
where the board watchdog then resets the system with no console output.

Call the function, restoring the 100us timeout the code always
intended.

Fixes: 3e195a80e096 ("Staging: octeon-usb: Replaces CVMX_WAIT_FOR_FIELD32 macro with a function")
Cc: stable@vger.kernel.org
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---

diff --git a/drivers/usb/host/octeon-hcd.c b/drivers/usb/host/octeon-hcd.c
--- a/drivers/usb/host/octeon-hcd.c
+++ b/drivers/usb/host/octeon-hcd.c
@@ -578,7 +578,7 @@
 	int result;
 	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
 	u64 done = cvmx_get_cycle() + 100 *
-		   (u64)octeon_get_clock_rate / 1000000;
+		   (u64)octeon_get_clock_rate() / 1000000;
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {
-- 
2.47.0
