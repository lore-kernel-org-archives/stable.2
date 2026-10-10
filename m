Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA03F787F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642363; cv=none; b=IH21eZwI4AzUruvhAe3PKErpZUZhD9fueyiN+fZVQ3+LxgrdpnlkLOUCWbtatrF1FPC4lK6fwB2GZoLiTKh5UL9eRHu1oGamK+lezbLgL3/0YyP0/R1Q5ep/DOyJcS+Cjkww/rxXaONsALFux/xiYzRsvu7soBMADEPWTv7/RzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642363; c=relaxed/simple;
	bh=mw0uQktkLnEmrtN0ERsFxWHjWYRwLcVyb7ARzOK5ubE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzAVDvJW4GUGm9ZSBGWJEbx9da9Yt/O7U5x2LKlEGE9NrR+HU0FQ3VPJmg4269LNiobK2yXUcmoYJDwrlJ6Na074uxF+vX0PhS/HixBlxFnxETYRqSpMUhwLbJywAA6ybHXvmdodbqeT6IBlMxBAsRRIYS1pMQPI4tdcU0VzDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSAWu7TE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSAWu7TE"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b16824c0fcso728046a12.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642360; x=1792247160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b88sjkJ/RqBf+LyWYx8z8VDQ3/sowwhU6O/+Md+JWNs=;
        b=CSAWu7TEoIKwzGgU1AlAAj1YqP1UrzMzHpodzbIzfOmm4quml4b0d4S3gIVbI1X92n
         A6zE93ssYVRqr8ALcTL5yIRnthLHUsweAZ7vuaZKBWei3Id0C1qYZNixW4wKuuWxZjGx
         794DbKVvw4P9r948UX2vYW1nPdx2+t7jDc+orj4PaUMt/RRl2JjgTJKHsNwtA2bSK31K
         j+E0UqT9y20plkNPyjnvTVRWGD6bjHDr//hs/eQqg5I7qiKg1Q+IpqZtBl5avTci6cY9
         v2pV7PN7aTK7rKHhMl8m/w0WScjjCmBp7hBZGLJIRdEMTJEHSDHXn9R9A6Gy0iONhaow
         sX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642360; x=1792247160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b88sjkJ/RqBf+LyWYx8z8VDQ3/sowwhU6O/+Md+JWNs=;
        b=TEDIvZOxViNP6qbds9pJA7c2VYep5cZ/W+9eZVEn1NwpST1WVLH3rmM+Kn39X76rtY
         UcYXqrQRtdEGfniauzSlCkScScPtKQ667fSd3OAlwZci3Xtq0d1+wR4TxZlmDArZPKW7
         cwnmapn4+TlMXTN3qL75gd6iNVUBM+9d9HP/Z9aCfhwaFTNYG2Gn0Hu7tfK1oODGuXGD
         bG7nfbPzNic40vPDi7mCigPwTKZ5VPI1UQ3cW/Q94OzyGfQf4kJDJDGHfmxDTuaRVqa2
         TadIvuVhfwi0zFDsFPUj20ecT5pw9R7aRuxjloL+Hyo1uaplAEnzsGTTtFd30QM23/RR
         xwaw==
X-Forwarded-Encrypted: i=1; AKwUvBxKPY5MP1Qk811Us6ooTLDGW6CHzSUseFW7e/edrQE0OtVk/oyJmWnJsm4qmPUM9sCnlDQCIvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4KIII/L35WHitjjPCiwFvOkNT/eRKB/OvAcrEawsVlejsY8rw
	+g7bop3U7ZWqlMir+vULqXAmi3pGJU9x++30fiU5Y8NgR1FduPskfz+b
X-Gm-Gg: AYBFou1TejFVHxKBVgM02pb0iEUvga3/7O7IZKT2gUBfTGyeMH5FXgF45QYf18kMpnm
	fXjFtMGNlrbkk7VQXy2NWbCUs6Qie6vSXvpeUleCBI31MsDh7NIYdNfNCh7O71mBwx+4lG+/Wxy
	sNvBINuaHb9ZBezXC4rFQgbu0OC5E2WbcuhywCM6ZS0p7PgJgnVGuiXCszOAR3luMVgMuGDeyfQ
	6/2l1RPLsuHPQ4Nbc0aJknhPlZEbsklMrViCcNUlFxbbkHOd5fNSfKa1TvA0wwBQiZmQ5aZ9vfH
	S/cL6Cix50sJCgeJpQ5DKDAlQiviQSrGIiuZ4dvrUiULpNZdXrTrJfC2xayTOH8NovVqeJXtU8h
	TnIKhsvYkVijLQh5Y2jkyF0FILFCtOjo2CAlf3WqLLUA7Lbn7vjcTwAsarDsfvstuu/ssL7y16t
	ewrYT6sFC1/aauq08lLLPNiZILhWMAGeLivC4WourY5SVhLYxBMgSdGNpoDKa5QBs0BFM/eO9+L
	wlCiDi1itxHPnmYcudj8/evO3PKnPVfARSJQiWOwNI2uHUwqOQ=
X-Received: by 2002:a05:6402:11cc:b0:6af:82b2:90a with SMTP id 4fb4d7f45d1cf-6b17c291040mr4765042a12.43.1791642359841;
        Sat, 10 Oct 2026 07:25:59 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:25:58 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 7/8] alpha: invalidate the local context in flush_tlb_mm()
Date: Sat, 10 Oct 2026 16:24:33 +0200
Message-ID: <20261010142533.974797-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010142533.974797-1-linmag7@gmail.com>
References: <20261010142533.974797-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_tlb_mm() has the same caller-CPU omission that was fixed in
flush_tlb_page(): when the target mm is not the calling CPU's active_mm
nothing happens locally, and smp_call_function() handles only the other
CPUs, so this CPU may later reuse the old ASN together with the
translations it still holds.

The active_mm test itself is left alone here. That path calls
flush_tlb_current(), which loads a fresh context through
__load_new_mm_context() rather than issuing a targeted tbi() against
whatever ASN happens to be loaded, so it does not depend on which context
is current.

The uniprocessor implementation in asm/tlbflush.h already has the missing
branch. Counted over a fork-heavy run, flush_tlb_mm() was entered with the
mm not this CPU's active_mm 2934 times, and 632 times while otherwise idle.

The proposed Alpha hugetlb support routes hugetlb invalidations through
flush_tlb_range(), which calls this function. Unmapping or migrating a
hugetlb folio from another context will also need this local invalidate.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index a5a42ae4a7d8..988e397b0b8a 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -649,6 +649,9 @@ flush_tlb_mm(struct mm_struct *mm)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_tlb_mm, mm, 1);
-- 
2.43.0

