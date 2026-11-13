Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601437;
	b=ZndSsau7ep/+Y8G/sqg5No0uMsojfUSqS/Bae81rTamzcn2+TfVdDN5d1PEJkAo6n59H
	 5cTSfeVfntkd29GTlYvenvTHKlkU5t+ffYs6pcxOm3UkI77tBfMKjGWvoxD+szbL7Hk3E
	 Bab8C7y/vzsFe1nVNigYhdW54CD/4Mza0mNpd2QnezWKAHYt7Qh3XhdLe+Xe/TReSeaX2
	 BIa+SuKd5mTOeeInPHTniQxk8zvYDcqQsMUSP6Wc5vUf+tgdvmTMzHFQ4laAHbFKRVMEV
	 EI+rzBlFPnDh6YaUR0t+a5dSUCfVRVWu97KnfBfvpBHx+Iv3Br5uN1lsMW53BHdB1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xbWBgXkenSa9yRsymUcI7Wl4ur3mhX+FS+9uM+YkKCo=;
	b=JB5tHSThIOJZYdAfBbbDzIWhCQud+hM968RTLTsEhdEeyzwrjyqk220LK+wPkNfOyOXL
	 2UOs5Ebp+78YwXg+yiHWjPYQPi4Cw+27LFdDsnVVMUVBA5O8k4n3OgaiGdq5rxdtEoAha
	 TF1ez4aUD4gw4OvrL/g4qsBwrZRJta7YlaVGYZk4Ea1iUajsF4nmXNBzCrQCVT+3Nte5q
	 wKT/0eoor6h8P+ZS9uNgRX3vZ6YgX5+bn0l0TAHhiHQpPv5mgs7MFkNAs+UBXPRNyjHRE
	 nOa4zqb79+uJ6e2eU4qqECEyMEYKqnYTD4YqJUdWSZ2uy/NVm+aoI1MiEMhTD0UIQKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbXb6Toi;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB8606A882
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24BB8606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbXb6Toi
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4910b863b84so1465198f8f.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601435; x=1795206235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbWBgXkenSa9yRsymUcI7Wl4ur3mhX+FS+9uM+YkKCo=;
        b=ZbXb6ToiEor+Fks4PY5+zaOANffpyCUalvAA3FTNQCzl3dIT67JiJK/lFT+LibVv1R
         +gcfdwZ0t//pP1PP3y3RGJhyRZvOW0btRS7B7Ama9LRWK+Dj7UOoi+mOAyHnQfo459SQ
         RKDQe0OsTaJ+THPvQppDwb5gv8aYVMq85S1f5b4S4aO91vVMDOJd5AADEH8eE4bN9CXP
         vWTeg3GtQGcWyxouqrVH2W7SlfZp/05TwfTyHyG4zXw5VW4RD/UFMak6Spk0oOmTFywY
         JaW4xxvQBR6Eo6iZ7smq63zHqsHc1jFxGGk3ajq2CbTtiNX0d7NzGzzraRjbQBjTMMbo
         unoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601435; x=1795206235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbWBgXkenSa9yRsymUcI7Wl4ur3mhX+FS+9uM+YkKCo=;
        b=XMtcd3CU58YhvL0n7mtRzXqB1LtV6kbmY8n5kPPeb8zx4d6gSO7NR2NtdiGKoLn0UP
         5jYkl+Bbxr1ChW3alDa2ESOfcrGEuEb6fcDaWxMAyXESDE0ERDQXUgVwvmbUZdD/wiKc
         Wqzu+NZDANruCt2/Ca6GrEK2WGxBYWTrWzijlUCJk62uKq/H9frA4nVmMSMP6kdKfKkB
         rVjambeSJ7S+GkoA88tyXjTRCJUriuVk/YakX33a1AOarz0nb/OA1mWGF4taXsidTxvK
         vbIqQDpYmSsNILrCkmal0lXGgLuUgvQGcq1H3e6nKS/a0TFxH/cF918pA4ZW6EZ+kyDa
         wH2Q==
X-Forwarded-Encrypted: i=1; AL+hErEDeBdD5QqwrputMp8nhG68oQAysFkQnPjGvstUqAxTohr8KO2cd1XHPkUTa5R9NwHFt9gipFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EV3kdJr81WW62m3aAhyN0ENaBAlrGhw+TOnky4jjEpeDPPA+F
	fDutIbHv6tasdaHPIB+oONZFyPNC2jR7hOjQ/+FQpLOTjbznjibc02n0
X-Gm-Gg: AYBFou2eYkJBKfYtUiPZtUlQjMHFz5WduOVeq/3Hg9m1EJSVG512VmT3YVs1z2iTbfG
	GHkNmqb4owrOR5uh4B5gOWjcLfEq1PIuwKHyBpVZpoS9TeWRJ46vpbvxEhJ2fSsiE5+1SbjHoDU
	W9vgEEEp5295/CB5sgT2JEKwvUumUMfXJRa6+lPcqwgS6U5oxjKYDofPIxcnQUJlAqYA+w89dQD
	iy+pp5StsFJAOZ2VxJJrdZg36EWf+RFFR9V9uloBq5uypnEI/DTKAD8yNHYry7Hqm91mziB1irs
	y9LNPG/0CCfArdzy3SmIeBtcKIerCHnuirUqmQmiz08YpvexK/IZObVcDukPs08MN0B8akbZBK8
	PuCgMBM25Uvo7ab2knZeYG/Ca8vMuR3GXkvzBXcffVMIF2xMKIN39qX/AS1/3/1jQajCSEioqxn
	rfTQBBu8KgeBkQuU9XNcyFl2+/zsR7UmHi8opsblSrtWUnRjEC8ekYx2igZhxQZkUVbozg3GIh/
	CXfAJaVIKN+cAlIbWwuxFj6+OAxC+1RsvJXYQnknpCqSW5oNSPAfACUzsybP+ZVNoh3yVlHCpQF
	s9bIe9VuyBWggPINmU9EBXMrldfoR5OCvGEq+g6oCJ6vpvh+/QSKuw==
X-Received: by 2002:a05:600c:4504:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb559f044amr74646205e9.2.1794601435369;
        Fri, 13 Nov 2026 12:23:55 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f976esm40414575e9.3.2026.11.13.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:55 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:23 +0100
Subject: [PATCH v3 1/5] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
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
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-1-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

In landlock_get_fs_access_mask(), only add the
LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
handled at all.  This prevents us from accidentally treating
non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.

landlock_get_fs_access_mask() is used when initializing the layer
masks for doing access right checks, so this bug meant that we
unintentionally denied "refer" (e.g., link, rename) operations in
layered cases, where the same operation would have been accepted if
only either one of the two layers had been enforced.  If the rulesets
individually allow an operation, the composition of these rulesets
should also allow it.

The bug only manifests as soon as one other layer handles filesystem
access rights.  Otherwise, Landlock filesystem path walk is guarded by
an early exit for the case that no filesystem-enforcing layer exists.

Reported-by: Dwi Siswanto <me@dw1.io>
Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h       | 13 ++++++++++---
 security/landlock/errata/abi-4.h | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12b3c..d9ebf4857fce 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,9 +262,16 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->layers[layer_level].handled.fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->layers[layer_level].handled.fs;
+
+	/*
+	 * Handles all initially denied by default access rights, but only for
+	 * layers handling filesystem accesses.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t
diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
index fe11ec7d7ddf..9784ca645073 100644
--- a/security/landlock/errata/abi-4.h
+++ b/security/landlock/errata/abi-4.h
@@ -20,3 +20,24 @@
  * that rely on these protocols while using Landlock network restrictions.
  */
 LANDLOCK_ERRATUM(1)
+
+/**
+ * DOC: erratum_5
+ *
+ * Erratum 5: Denial of ``LANDLOCK_ACCESS_FS_REFER`` in layered domains
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue where ``LANDLOCK_ACCESS_FS_REFER`` was implicitly
+ * handled in domain layers that handle no filesystem access rights.
+ *
+ * With this fix, a reparenting operation is allowed in a layered Landlock
+ * domain if and only if each layer, enforced on its own, would allow it.
+ *
+ * Impact:
+ *
+ * In kernels without this fix, if a domain combined a layer that handles
+ * filesystem access rights with a layer that doesn't, the resulting layered
+ * domain would deny all ``LANDLOCK_ACCESS_FS_REFER`` operations, even when the
+ * filesystem layer granted these operations with a rule.
+ */
+LANDLOCK_ERRATUM(5)

-- 
2.56.1

