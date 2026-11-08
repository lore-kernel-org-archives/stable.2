Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169463;
	b=3odUOoBqFnJPJ0RWF+r7twOVnJ7LgJ0KiezKosyWelj7jujpUoWWQNIRkRCSAuTIqqti
	 0RvMn+IujjJ0tUc7bOOMuBOqff0/K6EcU+mhhK8SSgOUOUpmAWyXtOfzToeZDimoUPZxp
	 ZUEv/250tZg1ijjQd6Prug7ZImjYoMPtgWQ4U9zUHAZqOIxxXCZd91VCK/6AB/zqcQxXA
	 9YJAByfo72gACoPEY4I2wO0LtRrEhRNDxKlVuj9gMsLYi52yZQ/HVOvDm4VYM+wiOQGmg
	 i99xWXs/9Lp89zkDMW83ud5U1HkaUcUg1uRbFyRpj7lvZVU3JczwH6+MpTrpPOq/BBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=U6Ai3RX3XOfep+2NZPYc+asEVycV3qACLtEG8MfT9tU=;
	b=vLF5repsq+lxmRjhKh7PeVN9fgGNtucSzPPK9kSBgJ8a5LJsf7Ev3FhkuWQMY152aPfb
	 ovdUk0GFalX1+Jph18klz/X74lbygBuxBuXgd/q9IFtagRZRCU8SvyajzsmQZmg2YDWze
	 mrtSAcxfpkccy3FPpTbCxkT/5MOm9bKQqzb7PLIGLfcy2iDaBkPRSDfY1TV9aUdEfJrlQ
	 A5QbUeeg2Nm8Uk3DOkxnMsaoRGT2ZNTg6BfHBuahu5Yz8MuABvvlkK7WM3q/AeiQ4wGnK
	 l5Q9J9SU36+XlHRIRHXql09c3NfT1zCXHRVAMHIn6rjTpsr2LnDwn8WDq919yZF8Lgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHTLLd4f;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B86079D81
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727B86079D81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHTLLd4f
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso1163415e9.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169462; x=1794774262; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U6Ai3RX3XOfep+2NZPYc+asEVycV3qACLtEG8MfT9tU=;
        b=jHTLLd4fpz/icE7NfXAZClbnA8xkbQscrSmCRQpuELsK3h2USWg26Q3W6X8Vavja/L
         YLuhSHHIG97DX4Vku+lKQ2EJXlBPD/S7j+2GLvRFfD2GgzMkrv7scQDmx7PLk6QJ1GgM
         PWl/PkvzVNw4VyKwJyFRKazgq68h2GJlW7EhU+GrXvvPro56OQPXNhQqGpeX/40ymLxj
         7tR/YLUgNyo8tuk6Uk9aJHZSZmUdSOHYHEUPJLAjhJgoaJmYUBqB+4vV+axs4J55hgKr
         2hbYZSc1NAORavxZXXtqrACfeAFj/iDoiX+nZltzr1sjsdOsP5t3BHwzH8Yqt/vVBiRs
         Ej9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169462; x=1794774262;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U6Ai3RX3XOfep+2NZPYc+asEVycV3qACLtEG8MfT9tU=;
        b=Lqinv6Ogvdv1Laaa0GLnpB2hq0raujplFbblJXs629yIy4b1Q/8mxo53GzHBZ5do/l
         4I5UuW+Ry92XZ/OPAjDUinrsBGRo+rwOEQJKkR6KGhIW36S/v4dlJvb9msAU7vKeKkve
         pVNKTdu0j8nInj+MWtRPa1a37z4snux/ciADhCNjxB+JcrC7mrK7KF/NRh6bGJJQi2I9
         Ttn5vR0OtGgQZA/Eh+jSY6HEAigwrXx48TVAKHSiVGHRhQl/XasjI+pIfZ7rji6YP3ya
         rGyWDzGduGb6eqEYcbawlrpGaGe+114Qsa11cSsOBwnTKVXWRZpgeN1zmCOCb3DgpQhl
         fvaA==
X-Forwarded-Encrypted: i=1; AL+hErFcIhNHacVf5CwsZj0Zc2/6zmskv+3dydBbeHA3REVOQUdRD4ZtPVBgS3QEzayutRhHdfddQfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z2D04VNFJxmpljXqbqUC9S7YdDYnJ+5RjIWQjiFU4qWxej41+
	q262E1oz3GDsmMzWkfLTG0Kh9S9QRRMzaWkhXS5C09psHMNVYf8nz5AH
X-Gm-Gg: AYBFou0vpYvh282yjTiSqcPGjYlLiOt43/pcC5d8iNj7PeL7ejj+4mtdELJFuGwXjXi
	CveCSrM5qq4GznNTZtg+oqRsiagwVp16HucLciKHPfLE9jr65GPD3A5AFMCHIKdNyU1LjCDA2BB
	/NAAefPmBlM/FiTQw38Msv6CkiRRArgUTIt8oc62dUd12Li2uYXYNlgIBIA/DIDwllOW40EYLWm
	wbxvvMmMJ9nzkcIObrMtXrftYIL0aXXIeV/LBY6+u/h2dtLhYn8wZHBPLbREW/RrQFw+ehZXy1Z
	DvaI2PsWggafePmVgwQTOOvaIFY6UkCgVTpIi+oZtUKSb4aeZZ2m6wkqn77MpVOp7ryiMF3Va9g
	ewbiuqTVZk1xDz5DLRv3Lfca7yDVpJu4uU4EN6wl+9Tvi29BBDUlsUOdF4As/Xn7Injt3TiXPsU
	JhpbaaOadwDbuWEwC9EjjttnlnIRXw6uc22cKrLAGW8StR9HRMn+9iAqYP0w7uC0FSSS7TvIUVL
	R6gxoruBTgXIXgl5OYna+F/KDPYEpKs8E31CVj3J/Vq595ux0KJAL0KgJh4GEjPmeVXFVook5XM
	RdtdzLCtOKyhL3ILD4Y1sxgNtxwF7jIPFk0KR2bIauRaCbFNdijZbA==
X-Received: by 2002:a05:600c:3e88:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b963c8809emr38276815e9.35.1794169461719;
        Sun, 08 Nov 2026 12:24:21 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fc31sm5714139f8f.48.2026.11.08.12.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:24:21 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 0/4] landlock: Fix REFER in layered domains
Date: Sun, 08 Nov 2026 21:23:47 +0100
Message-Id: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOwQ6DIAxAf8VwHqZFtrid9h+LB8CqTIUFnJkx/
 vtQb33Ny2tXFilYiuyRrSzQbKP1LoG4ZMx0yrXEbZ2YCRA3RCi5lnxQrh686XmghgJ33jUxLZc
 0N7UqtdEEWkqWGp+k2N/Rf1Unx69+k5n26G50Nk4+LMcDM+7eeQsKQBASMUdxL68ceeu8Mn0BA
 M92VHbIjR9ZtW3bH7NpTwjFAAAA
X-Change-ID: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

This patchset fixes a bug in Landlock layering,
reported by Dwi Siswanto in [1] and [2].  (Thanks!)

The bug
=======

When Landlock initializes layer masks for path walk based checks, it
unconditionally adds the LANDLOCK_ACCESS_FS_REFER access right to the
handled access rights.

This leads to a wrong layer composition, in cases where the following
layers are stacked:

1. A FS layer restricting REFER, but also allowing REFER in a rule
   (e.g., handle REFER, but allow REFER on /)
2. A non-FS layer (e.g., networking-only layer)

When these rulesets are enforced **individually**, there are REFER
operations that are allowed in both rulesets -- the ones that 1
allows.

When these rulesets are enforced **on top of each other**, the non-FS
layer starts enforcing REFER implicitly as well, and all REFER
operations are denied.

This patchset
=============

This patchset fixes the issue in three commits:

1) The fix, which should be backportable to older kernels
   and which is CC'd to stable@.
2) Regression selftests.
3) A more elegant fix for newer kernels,
   which is intentionally *not* CC'd to stable@,
   because it would break on older kernels.

   In newer kernels, we already add the "REFER" access right to the
   handled access rights when we merge the ruleset into the new
   domain, so there is no additional calculation to do for it.
4) A documentation update to clarify the situations where the *_REFER
   right is implicit.

Please let me know what you think!

–Günther

[1] https://github.com/landlock-lsm/go-landlock/issues/66
[2] https://github.com/landlock-lsm/linux/issues/67

---
Changes in v2:
- Rebase on master and resolve conflicts
- Fixed documentation as pointed out by Dwi Siswanto in
  https://lore.kernel.org/all/20261101125114.19009-1-me@dw1.io/
- Link to v1: https://patch.msgid.link/20261030102411.12985-1-gnoack3000@gmail.com

---
Günther Noack (4):
      landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
      selftests/landlock: Test that layering does not break refer
      landlock: Simplify landlock_get_fs_access_mask()
      landlock: Clarify implicit handling of LANDLOCK_ACCESS_FS_REFER

 include/uapi/linux/landlock.h              | 17 +++++++------
 security/landlock/access.h                 |  9 ++++---
 security/landlock/domain.h                 |  9 ++++---
 tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 15 deletions(-)
---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44

Best regards,
--  
Günther Noack <gnoack3000@gmail.com>

