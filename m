Received: from mail-ej2-f36.google.com (mail-ej2-f36.google.com [74.125.228.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CE45A28E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149781; cv=none; b=P/mL0D9j9PI+SMXDARnIFIZ4oh9GG6TBqjIGmjuKp7yEDAN6edtnwp75U5vqUQgJ3DV+oGegt3x+7L1c0lAE82l6zztp0oz4NixvYAQDBRCJcskL/TW54B+CDMq7/mbRUoCU5lUAIjrxs5hLuyK/bKLg3GdrhNP+xYr2m4tE10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149781; c=relaxed/simple;
	bh=EMwactETkXe8vSMhHk5uaUdqn2lrxvQM56NTZ34bIRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHurnls7zo1QLT58Bn7mOeJYnUTamVWx3kNNXJWcuKGkR158otHAh6M7e9ysgmKSkWBY4XwaW2Uos14mbXrg5ktHPyza4lQyhRXhY9F8fHlC3rNszk4IHdsrfWc+X3CydS1L6QKqO3cMKQHTkgnXuHjHYYvkAsXs+GY2vAHaThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syp5ykIp; arc=none smtp.client-ip=74.125.228.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syp5ykIp"
Received: by mail-ej2-f36.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso89693966b.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149775; x=1790754575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7gkSrqkOM7ln6wSKzbmSt+3Xyd+xuwsuurc3B4YbEg=;
        b=syp5ykIp1P5RwEZfZuEJrfw/7R6aSkybJWheEOX7MzkZ6b5EH/xSKgkhQMVrBtyLbL
         R9oECc9+HP/K6J8nqdXdxuAtuxe02+a7D3xtdb5Z6La5ik5PGY9L3dto1LwrQJn2bRYN
         QFGYjoVlkCuz/DeR6QbrtWSh5fj+UAtjtcoJ+UAZNkH35e2gmQogoJU/3tGNk0gmIhlh
         17Z85XlLcH219CQJpxjXeNAvGJl+vrHW5KT/bsiMmqUN5aPdHOBvtwtBzskhqnSh/gPq
         1VF5yMhXH6D+ZZdOKKBgeJq+kRxXGBh+XR9QF5nXgqm5s55UgTQxUWtYqstqHsYP1UHy
         oC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149775; x=1790754575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7gkSrqkOM7ln6wSKzbmSt+3Xyd+xuwsuurc3B4YbEg=;
        b=u16NgIuxOiAQmeQ902YBhQxrplIkUeESHWgmo/FZaBDBvWj5I6p0biP6oEtO9N9zNv
         HRn2qWJauIdst45QIaHLxKj/RMPUo0wzUEEd07+UhQbe/C6H77qcYZkwutUPnRZna59y
         1s3CpX7vJn3Kq2mpysc7j4Yy5sYMDlUnPCHWz3yZ0WJrNL/Xc2tmKSfrBT+zCXQr/kP3
         FSKz1tK+VUXIb3EzIZMiQOsomDr9dKnF4T5ji/kUXrgLVA0kp8LhETnfQYiDKLkbDS72
         HZt90Epj6js5oMc3mKqnpUU/zoS8CKuUHLzPMpY2Rp8l8GXeerEt67kcVVpG3YvVexvu
         k6bw==
X-Forwarded-Encrypted: i=1; AKwUvBwsOD0sbn/ckhmyUCGImLZw6zszUqNT0ieghZWvLcFvKWiYAS8cNEK4wep/gQieJRW9Bt87nM4=@vger.kernel.org
X-Gm-Message-State: AFuF++kuRW0kJWrvlPq/aQL89d9r3SXtT+DaSTDfcwEazClLawlj/9Eq
	SVJHYYvl7FVwsXNkcWE8ORQmAEjjsESMRLdynYgBc3ALzI37UA2OPqLZ
X-Gm-Gg: AYBFou3BUqop2Uvs/D2hoh0JN52vaJnbVJWU7UcWULvv98n2AfAPqvpwuV2f/SeY+u6
	Ai9R2Oohx1cnDPtA7zWmWuQSGWGIwBauBq0Zd/MeHSA2VvR//okLffEkHO2lFFX8cA9P3RSgSVy
	FPhfRHpjsGo+IpH+uCy+n57KwGkSoeoivSDMOzJh7rdmD0y/84J3NmOFrn2YHphx0dgqi16A4EG
	a9C1B1f/6XEUlITKRzvmEWTeBtn2s4Shc06FLgWsTzH7Nz6V93jurnBX2WQqpl1/BSuMWsjUeML
	QqBR/dLEzrNn5jzagM1Kuc8cQ+M7NVKkBrgxK2fmXRuA8XEizWND+pQAQt4tBg0TeK1WCrT2Eri
	GRpeDv4HaPl40jPiaDplWvYxLKnJb5oWlLiQe+HShTDGmrhrENA3pxQIcQZrn8/BdkOCXOXVbsH
	smaIxT7iBYuILfGOQHYEPp/WnJAwqprGVaQq8XY9tws2Ka3reuPysfT+/+tUm2NcMsoM4TntBqu
	6pkRNNaLLXtjLDB7TsdaNa6DlduiavryPe4VjyI3ddsfQvMx1Kci3Vbe8O8yA==
X-Received: by 2002:a17:906:dc8a:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c2aad863bd8mr138436266b.0.1790149775100;
        Wed, 23 Sep 2026 00:49:35 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm64951366b.15.2026.09.23.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:49:34 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 6/7] alpha: invalidate the local context in flush_tlb_mm()
Date: Wed, 23 Sep 2026 09:47:49 +0200
Message-ID: <20260923074903.862898-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074903.862898-1-linmag7@gmail.com>
References: <20260923074903.862898-1-linmag7@gmail.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
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

