Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013F3F9F47
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153149; cv=none; b=iU6rSiFgD2Kkq0k4+lDBbPF/GGCacdF3gRYNk/A0hDJFmfyhFYuMmk+QN+UoU+dToWbI7SvRbeXY1qkfZp+2CrxCqWIbIlEeXCgcMO6oH0VDK0FKcrG3PEJckY4xPB3GZ/g9AjmgudgxhmCxBjSdI9D540JS/47RyR3aozDz+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153149; c=relaxed/simple;
	bh=H2SJ8QSpW4+/hHyhWwrVs3Bb93MkRV5cDQ/ATmivOTE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=SGifm2k9jZZ1Htu2cqT/M1jMVHZW1KY8eUVcdrSV4bR0DntoKm/dTH7/mvrWL2JsaLHZxi8ngApn2B74nB8hNJi2LgVRlWEx77IR78G/dH09PTkh16+FY75+IQNFUjyxKS6jC5Z2OoWm/jR/XJY/zjxPa1eGxMOa5c6VOBDDkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QjKmtexZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QjKmtexZ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4d98911b9so35365a12.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789153147; x=1789757947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZW8/C4TNt5nzE/8radYi4McNWP3qB8AURpIHQZMIiiA=;
        b=QjKmtexZvJMrOG2dUK2TnEL0H8qs38In3KVUyeraiaLd5+E6sLDE8cTfxSk6Ia1e7r
         z4WQVIvIovGbMZXm/uvrzeLz8nERWbrMqgASVGaiY6nYqg2HsSUKznPdVHC52AUSoP7j
         0IMbI6O3y/dfqVl6rmF+FmJZtudzfTjLfOzXtRZbgn3FcVd7RuO6/BEKkCp2bMrSPQrD
         z2G14KVssqm+9l80n8rfF2iP4Nuf6oQbF3tJ2VdQ6gG061IBOQGyLPhJXvtqncS+mpe2
         lVx/R6Jeck7k8+FMtf37v/djCtt9z2YGXXVNyT6C2+Y/NPnMB5aJy8+WgBaD/Wo8ssGg
         iR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153147; x=1789757947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZW8/C4TNt5nzE/8radYi4McNWP3qB8AURpIHQZMIiiA=;
        b=IAIahMMdIeH/FIwZ65sguBKBBZ4ReFkKR58JtpFdnsHdlFGNaxth/Dw+qxAjidpSYQ
         W1/bNrDqe9Dfdsob/aZzFBGqpirznh+gLWKA+kJyOKlZCaXmNmnZVVhJW1ENOYtgp1Ko
         Xxyij9OG/V7aCN4uS49eWxrgVGu6ZHc9/Q80+PKGCRHDIZm5ueQ3XYSc4pju3aG+1qrT
         JQf36EOCicyzoRWt5X8aFVYhJXlu++D25Ne0RYApUFnmww92JS53ASmp3vjUMZdgrUYi
         eTp1d91p59PIWuoECqaVJ5RClO6wLAWcvzjqCujF8CPmi7XE1NOT+cOgXkiuB2iEorp4
         2fVw==
X-Gm-Message-State: AFuF++liRjYBxrzQqHH2rB7vGzrd9MLcLFKSM7/rFW5tvy4gbAkeGQE/
	Pcc8O7ZhbUqdskOo6KALKauhy7Hcvc13HJvRutBEAvmkwqtPeSb7/Rw7Tr4sZ9s3KykWmWaETNq
	j7JRf
X-Gm-Gg: AYBFou25E/Ner9gfV6TjwvolnOWofbj+RYa2E50f6+ARtoPkeMwSyt6pjROng0kDJ5H
	FcpqUeUhaq31h5hjk5+VeOqYYHdVUMfMKkviGBaLEaANL6a4hV2Ug5v+mLFdpsOAJUlNqLNvdSa
	lUdjq1rcMamhe3w8eg5DbiUPDXInwRlgcj2SrSdmH7MTDUcLpGmKiReWn3t7yNR4xIMC3KRfxJC
	9/rKSm6TbmbqOIS4GKQ5xL2nSmQO3vJVOSZoliPinbj0kWEtio9d/vasSBi5sD4Xve5evrOznXc
	npDw86qfH5UeK500W98spX06kOe3r9fDUIcrtQtl0zZ0Iq/GuyCjFjVb9cm0Go6hB4Cmr9UBaXD
	o7y3ApIcw7GyOvA1eI2jQcIIgV/eJ/xAevD3d4Vi3OX2B+5OVbp1sgZgKZFXtVRf7T0umnsO3Dc
	npuiRkG8jOE+sRpHjuvJTdY+Lt1OxpaaEAVk1VAN/2FGNv+mcA+i3dZM7i/j7DXS8=
X-Received: by 2002:a05:6a21:9087:b0:3d3:ae1f:d7f5 with SMTP id adf61e73a8af0-3daed617da0mr10960210637.21.1789153146954;
        Fri, 11 Sep 2026 11:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a8a9sm8288916eec.13.2026.09.11.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 18:59:06 -0000
Message-ID: <178915314563.4479.16966546598530255142@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x1d6): undefined reference to `crc32c'
ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x7e7): undefined reference to `crc32c'
ld: fs/ext4/extents.o:extents.c:(.text+0x1051): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:2eee1b2e6ee95368e1b44c17dbe7c28c007c2148
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6aa40d2420239ade9022b027/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40d2420239ade9022b027

#kernelci issue maestro:2eee1b2e6ee95368e1b44c17dbe7c28c007c2148

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
