Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71D3019C3
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572969; cv=none; b=e+eG5F8hCIUSqCdc3A7uF/wMd5Tt22WlyZ++yCRUDabNqzB5qyZyokVFXy3DB/2JIyydCCLBCKCGULrpLGrxCtAFy6GGZbiJ+D9X0DIVRet4yjNfV+Xs+nND76MyxNVkOEJlW6ISBXU4gY4KOkOVR6VjQF4NfGxMafzsXzxvBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572969; c=relaxed/simple;
	bh=Xg/ZVWJu5SHTCV2UtojhxPC9NTEnwJ819NPQcAqkhwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brfSVD1O+6z6faDNNcggbDz1Ej4/bj4OlnBRDuWh4TTCWky6S32ujwuJoOFD9oUIKyeZ2AalPFvQlF8MQDgwgKyzIFZ5OZwRkRQnGRtlgSo3gxZnNm3IlstT9zSYXfxtawo4kLF4Eb9Dk2HKAruE7oesdGvQXngqRWUPFoiRuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vd86fPR4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vd86fPR4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1384860f8f.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786572965; x=1787177765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fgBN8P4tceUSpvKSwr7G8MgQI97K6qSQbnm76IzBHM=;
        b=Vd86fPR4EnIwEwoX9tt6XGeXM2G5DlPMJ9um9m9PmHIJMdMRg3brl8r9Yl5reaOd5R
         K3uHZp56i+Qfixl1dvIYl6gkZYtvmSdiTTVfLjVi25jsXXMHqWVFrbX66r7hvJHlYZMU
         eeg8pizgzVQ8Sj0IT+NGJFKcG1st/4W0Y5jiNXmCD2g2afJGx1SSRvB+3FvfAUOuGiS/
         Wz6nHOy4REmwJcQjmDhaemolgWJpwX9sA6gBRmGeti0i2LXvjsI6REf1n/gU86SfcGOD
         gvhpkqqdkV0RrsmZ+Yn/kFSFEvJl2ykStsznT0BVQBheFlCwtrfJ8Pwq+ZtlfHplyT+G
         EGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572965; x=1787177765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fgBN8P4tceUSpvKSwr7G8MgQI97K6qSQbnm76IzBHM=;
        b=sI+YB5/QdcSL/U3H/6J4kEakkza3flOiz7vggScTJ1i5YNBxCw+9vNCfb05E+kZ4rq
         +z4I4W3cwvMFWnyjJh3kuA0j8N3LbNkcN1poa/1bWv7bs2O5rWF9xL0sqeA6wU/JAsVX
         PMisqsB0+cD5hRgoZ35Ibha26VuMhggQ9LXRQx3xHeNSnoYSdvO6/7O61/Q4muQ34qLJ
         OTSrCZvVhmpWefL+PIDDPnuUNiNUy6aq8OJLkcZq1QpUDRzYgvVfkIPkS5ZQjmvq4/WZ
         0t2ogT2JYYEB/zvFGWRxbVHEE+djygR5kiJj3NektDRS+tu9rmAZ74s/0/sltLHthSPx
         0Wpg==
X-Forwarded-Encrypted: i=1; AHgh+Rpq9Ro8g8Pen0bKLwt8AeWBuaEi5K4YhxtPnJjm/HEIAkPp7N4WjnEVIX4oSMluIDzox5PGj7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ykf1BUXlMpFOcgDuvbFhPVvcn1I2HMvyZ5NP5N6T84P9c7Az
	VwOiWKZkBxcoLn3lzTdo05o9jSW78zHLr420Qz8pFj3r3uxsSrFtY+D8sd1CMXSGTqw=
X-Gm-Gg: AR+sD11Ab+Y2iA+XvpO+pRGwmYPl88+q6swVQGAXrCnUj8Xt/Ac0hWmHNAsK/g6NMyZ
	nexq7YxvBwj5uEVKkSrW5IbBLa+DqWuCsqrZOona9XqRK6QTymJ/cgPs3PFWFDjz5Q0MnIOaCQs
	B/a0JQYNajfZT2UOkiGHkY2PttOCsDq9AsvOaPUJ0N7f1HQaK39B6kZryoHPSsE4w8eLxHGb/Yb
	K3esnLMpzDr5F1YblcZsbWuYlyAlg9fPGO2uT8Su6M5RhEjcSpF775jnGwBQl6eDsDptt+jcT+J
	hCycFUa1vKF/mT5FiXYAua4nZ3vwYUeN/edANnVpfUtIFz3DI3iQ7CJKyZwyETZihMjwYlAkCV/
	dWqlRp11bgwlVqGlR3LvRGxcyt9DdNvFDRFkcBDdqjrMveEd5sbLQnyo71pf1AF4xtooVCW5SLc
	yr37sUg/06kofaQxvnNUum4DIjtzqn1kA6GZYq9orKG2ySZhQNEbSHqS22yIFpO7D+JJ8yWpoof
	mWSsts7IpuSM/A=
X-Received: by 2002:a05:6000:25f0:b0:47f:f3f9:ae37 with SMTP id ffacd0b85a97d-48159ca949amr1645090f8f.7.1786572965632;
        Wed, 12 Aug 2026 15:16:05 -0700 (PDT)
Received: from dev-jrangi.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm933792f8f.11.2026.08.12.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:16:05 -0700 (PDT)
From: Jasjeet Rangi <jrangi@purestorage.com>
To: x86@kernel.org
Cc: jrangi@purestorage.com,
	tony.luck@intel.com,
	bp@alien8.de,
	tglx@kernel.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-edac@vger.kernel.org,
	stable@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	yazen.ghannam@amd.com,
	msaggi@purestorage.com,
	rjethwani@purestorage.com,
	rhan@purestorage.com,
	dgiani@purestorage.com
Subject: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement during storm handling
Date: Wed, 12 Aug 2026 16:15:13 -0600
Message-ID: <20260812221514.598842-2-jrangi@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812221514.598842-1-jrangi@purestorage.com>
References: <20260812221514.598842-1-jrangi@purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mce_amd_handle_storm() currently does the opposite of what storm
handling needs: it enables threshold interrupts when a storm is detected
and disables them when the storm subsides.

In addition, machine_check_poll() -> clear_bank() -> amd_clear_bank() ->
amd_reset_thr_limit() will unconditionally enable threshold interrupts,
which undoes storm mode behavior.

Fix this by disabling interrupts when storm mode is entered and enabling
interrupts when storm mode is cleared. Also make amd_reset_thr_limit()
enable interrupts when the bank is not in storm mode and disable
interrupts when the bank is in storm mode.

Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold interrupt storms")
Cc: stable@vger.kernel.org
Signed-off-by: Jasjeet Rangi <jrangi@purestorage.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 36e0df4d1342..04accdee6aab 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -864,12 +864,15 @@ static void amd_deferred_error_interrupt(void)
 
 void mce_amd_handle_storm(unsigned int bank, bool on)
 {
-	threshold_restart_bank(bank, on);
+	threshold_restart_bank(bank, !on);
 }
 
 static void amd_reset_thr_limit(unsigned int bank)
 {
-	threshold_restart_bank(bank, true);
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+	bool intr_en = !storm->banks[bank].in_storm_mode;
+
+	threshold_restart_bank(bank, intr_en);
 }
 
 /*
-- 
2.50.1

