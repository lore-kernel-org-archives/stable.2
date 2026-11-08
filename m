Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169465;
	b=QkDyK/vRC1Lh9ym7NhkSEGaVg4wjzHzEPQwAvPGLzZyZyNY/+LF0vEKeWv7HpHxjxojV
	 SjUkwiEsJ9JdniPJgxSW3kiAm1Xbu6TJPOQirwOPBLFNDmlKlUH+MnRJzSKRfhjjJLcFU
	 7cHNERnFgVYyGxKvsuglQoT9jkdjlIO3Lb51SgjPRcDxOB0gAso0WrKWWR0m1K8SqXsVy
	 4n+LiQS80aYM6mZMm8eMEoh+E1SGkH+V5cpUvxKhzi5bufXmKzO2Y6B9wyGUhTOy/HcvD
	 Qr8xljVNOSzV9RG4YgCmRmX8dRLvSGBvtKr3+PiXZx6ZhYjMuWFpGzkcVE3ukbjFJxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=LVXPEVlyVhyUrhrzslMzMs3XMd5k7yY1+/ztFUw4sp0=;
	b=gMyA+hluZKCX2i1Pcy3/qZCEXP6uTfdkm+lWUeGRpH0MIKOE3MZXoBh1WdjFE9EW/ZMs
	 yjj+TWid1+yvAHsi+f7GD+nEdSjs0Un0WBZ+ZlWCkaWWCrwl1GKp2nmyDMwOtK6IyhAHP
	 8eonJpFGw43eEk9K1JN3o65ZMg4poYw0xGG3znWOF9AI3IWh4EbVS741kk7S5J3rlib8x
	 l73vtJxiAiZCc1QpdOwefo0zxeRrVYiiNWTIWxGuXx8ZMpXK+yU9Jt/Twbt3E9CJk7NR0
	 wFt+nv9lw9xfHHuvzxzVD9ZUt7jNUGq5o5Q1TZB0uYPPE4AP7GoktvcMLRB6v/gE+XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hRiL58/C";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644060A5BE1
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6644060A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRiL58/C
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so2220895e9.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169464; x=1794774264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVXPEVlyVhyUrhrzslMzMs3XMd5k7yY1+/ztFUw4sp0=;
        b=hRiL58/C+yEOjBcUCIMc4lrMyeaY3yRbL5vApL5nAobdmxS7c6/W8bhLRKoH51w17s
         iSdfLvaRR2EE4/PYFxX3MzoPef/OExTG/rX9WeGaV77qJeusrE7ZlaML/f8nghZVZQNz
         ZpwhUMXEjxc/6lMJ1Z6zrCTcSN3ssP4p9fOO1jZ1et+YmgEb7YQELg8tWFZHSNO8KOZ8
         QALJHTS8mqg9tHpUgCYle1S7va8g2yW4OSQYEP6cnum6tXtzaEZJAgbvTguwDZkcZzCh
         hZfOk6Bv03aF58fjMhgpT9Mx+h7JU8sxpk6Ht2rhHOALGZ+Q8M6RwoHHBJuU+BcXn0sr
         GZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169464; x=1794774264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVXPEVlyVhyUrhrzslMzMs3XMd5k7yY1+/ztFUw4sp0=;
        b=nlzhi556FgVOglC1WTFGVfIf1+63HbuaWyaL275+lfTp/TLonX1RhPeCYe7KXIujnS
         rXfoAR0hguEfNLr1lQFsxg+VTKFSXBZko482s8+gONzQHoNWeDZb8l4gtOZb9lkIwMas
         GQUQlTQ3qYkMvbUg0k6I6CND6Ajo1put2iFslUgJhgSyVXnZ7bZdLcP9Plegc58PePUP
         8n5z3kW2jYVQ3mkslkOw4ifeoAHHR8v4ALWaF/hBYgPulGtp1B2/jUSFDd4Ki+/ffTrQ
         5JlfivPAj8NtTKsMSpDapHxW7jZKa5dd9MAE8bs6atIitELePVvfceUr1fMhHmPZsTW1
         IExA==
X-Forwarded-Encrypted: i=1; AL+hErGLm6rUgWipOI/BhSEjHe9kNRZDu1IG1UXvFgcdZhWAGxpsbEZ5UTdADHBhrpGiaaOVv/SVF/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IwuZ6MmQSrFId85VnNchyx2YhAg3TAlRCIA4T8a+L2bXI6nX6
	dB/bCKBvjF3JlVunzzJjjzLK8dpvK7sauPmkmgvdo0sXLeAPc0YvCjjb
X-Gm-Gg: AYBFou2dXx22Il5kQ0mGpqwprH6Dq1GN4VuQtGLLI9TBbWV00W/BRN0iUQEvHNbe/3n
	wwmmmPsQ3dLE0oH9U/+HogxWepd5q0ru441zhWJydDfnoATjAAXRHbyo5dAo0096yvYE3B+0D3Q
	RPNM/Y4mEVQ79CLpt8zPTG2Hn1YBJxm/9qUQD4lChX2dGI0fojdSh8crImzpjzyLXw6OWbjBKsq
	ytKzFDhI3jtAdKdlst+gC5/arz6kP6MPCLCtPbls/1wyQB1f6INXMNhstmxD4VVRanX7316bmi7
	3xPAVownC4PrJscRSTcw43jgXW+RJ56Rr57i4TLQX+TNJq78dFaVBL0ljRqrDMzawynPUknrzac
	M67wzkcAD3yYsgJqDvlSqE2I76bQxgaf4pQPuwsPbbvLumHD8Xn0+gJGWDhVOAc7CbUgCjFYsG8
	7XfcEEs3LM+bgPFdI2kNF/pcQL/2zp4T0upYEf13H2TzOJfA3zRcdUCgwy8bM8MnG4R/nPdGWL2
	eUMGp2/+sHvhZNosRNcMm9Q15E5VRbYNbKaPh7rHwRQdJJzM+SYoc6nZZNA+W5OhYNOBLjknR4R
	Lv7GgKz1hR6qoIeIE5wLjrh6szVhxG4mg3kLRvcOxlp65xDjSwNuMg==
X-Received: by 2002:a05:600c:3113:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4b963c91d7fmr43603045e9.24.1794169463555;
        Sun, 08 Nov 2026 12:24:23 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597748acbsm5733788f8f.44.2026.11.08.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:24:23 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Sun, 08 Nov 2026 21:23:48 +0100
Subject: [PATCH v2 1/4] landlock: Fix layer composition of
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
Message-Id: <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
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
 security/landlock/domain.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

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

-- 
2.56.0

