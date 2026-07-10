Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280436C9E5
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675437; cv=none; b=fRFdlLNxOeMu2m0cUpWhDt6hFiueLSr3FjA64qRBiKoWDVwEBA3/Wj4z9vFwon9T6e5aoXAXjOrgz+cd+TFDXyRrlNhdUkZUIRSBTpRxwTVxikUNRELdvnxJ5XncDeQHj2rtc8p/ua6gAXuJTnltDE0BVrbIOl535huhz9nlgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675437; c=relaxed/simple;
	bh=gk/Ly+VOdTlozILkyIXx25UNv6a0Ie7o/tS0LPDPWYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O736/mcEudRfEkVcFxMt5dgvlgVBnHDOs+HFqVgnS7AAvC1TWnOVVc65XV5QgjnxQm2PXgOkHxikMrpvtL4FiHpIXn9dwImBjhIvmilD4jFX8PtozOnkRSuMxHfvs2VjPwA/wE4raK3e6yL6xzlX+3nF3IOuH1PoD0wvmFDVD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b=U35mSrTJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b="U35mSrTJ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso964149a91.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20251104.gappssmtp.com; s=20251104; t=1783675435; x=1784280235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrSY6cgMwW3xQnZDAd/GUTYiSszR+F3mzsF9ozQGQpA=;
        b=U35mSrTJnAN3Un34g45ykzyzVKilPVOFcJDJ7MzgCwpLdfxx00LgVoQPhx9cdl6u4t
         rqAiZwEsgxp2l6GIrfCQwlg7Wikkw30rlazn9QJehaNOMr+nqJpPSaolOEk2LYHQHLX8
         oI3J88DkeY/eLfOYWKPOLSOb7kE4vR53fgSLS0zW9n6Cy3TmkCUa38pdhsE8OYLBO28A
         nHl3b7bvS6OlRIy1E+pqoHZaZpYzCumVE3kwZfsX5ppbgHPFit4gzuq51oUR9mmkdU/N
         hsf04xfYnvij9C71xoy0MjBbIW8GfqIQlaWrD+3sr0eb/MPzm7VcGb8w9XbAZEQPH6i9
         YrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675435; x=1784280235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrSY6cgMwW3xQnZDAd/GUTYiSszR+F3mzsF9ozQGQpA=;
        b=FxM9Dm9Y8eZhX2l1KIjkGXqdDeaIyFvnydzMv97ouNHhXtpRUtec97eUFJwr/I2b43
         GiqaPU1cNbmmGRtgeS3BXYJqMRa7CiRoXkkVejohcHPX4P4bg9RQW5kgctIkjJP6HiZk
         NMUScab0mEWXY+xQkD3PMzyGUTXNIAyNAAwhBhhfnkLQr0SqdmZO4bhkxKt1bZ3KbnxF
         uZapvMhebjCnUAVLfvPj09FcNdad2AnVuyujknAMJYpmKxAri4MUHiHkCxNFlKrtvOfX
         WgF5ZhmmvKPfd6Q1hDTk2Q+tEqHZxduDHS4jXg4N+HjHeBu9AjgJ4uIf1lQ5tvy4oMV5
         gebA==
X-Forwarded-Encrypted: i=1; AHgh+RpJ7FhKLnyhwRRX3csJ77ni+/EDxAMtl7oA5E9vQ9qMrAPFmeTyrNV4sejGfKlb4zgFzDyHWO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5BUAzeaGQcMpQv1S8ji4zhZLWZr7J7Pm8fFefLpoE1SZOLdt
	Pvt3EPLkKK7KoUJ1kiY3LZmIi9hxjJCYoD84sWtJpmNJ0wdPYHQx6zGwPCN33gnBLBzmsW796i9
	s30GW
X-Gm-Gg: AfdE7cldAoJqqVNrg++Yl+dotAUHJ9iUXNTKIRba8625q5kAduxCm63288GUmDSk6Y7
	+PwKNm2FlzVfgkzXlob3x1vCikGLq8bimbhKxijqRMZpaw3TcgZI/CTJCKD4evJxPLFu+iwB9su
	AGKyKk2vNcXiCkM0hxTXRXh6mrRo6a1c76vKzKYCKuPspCNtC/wtohhCB6al+9tdt5Iq7LMxeR5
	iR0Eda7QgPJX1mxbz+UY+A8Q1tBw0TiyCypgXkCySalyPaosBf+eJKi7FLLnfH+aNFVShhK7hR/
	8bYtJiuEf554ShMZLMdCKGqskAZHPJwF3+ugauZgDm/6uSF2y2u/fzAkPA2Ho53rvRDQfBKJdlo
	kMWjEkeDbGZPxo8K1e7FZgz1WnyA05tfSPqCdibR+wAyTZx9cnpqLqNAUE9Hj7WXqQu/9XHaN3M
	1ThCR73kUgMcPg
X-Received: by 2002:a17:90b:2f83:b0:37f:9ce3:ca97 with SMTP id 98e67ed59e1d1-38941cc858cmr9978425a91.32.1783675435286;
        Fri, 10 Jul 2026 02:23:55 -0700 (PDT)
Received: from localhost ([49.245.21.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm19826783eec.26.2026.07.10.02.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:23:54 -0700 (PDT)
From: Lee Jia Jie <jiajie.lee@starlabs.sg>
To: jiajie.lee@starlabs.sg
Cc: mkofdwu@gmail.com,
	mkofp.tfaw@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] perf/aux: Fix page UAF in map_range()
Date: Fri, 10 Jul 2026 17:23:48 +0800
Message-ID: <20260710092348.13207-1-jiajie.lee@starlabs.sg>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710091136.12003-1-jiajie.lee@starlabs.sg>
References: <20260710091136.12003-1-jiajie.lee@starlabs.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map_range() reads rb->aux_pages[], rb->aux_nr_pages and rb->aux_pgoff via
perf_mmap_to_page() while holding only event->mmap_mutex. Those fields are
serialized by rb->aux_mutex, and mmap_mutex is per event.

Thus, two events sharing one rb via PERF_EVENT_IOC_SET_OUTPUT can race
rb_alloc_aux() with map_range(), leading to a page-UAF scenario as follows:

CPU 0                           CPU 1
===============================================================
rb_alloc_aux()                  map_range()
[1]: allocate rb->aux_pages[0]
[2]: rb->aux_nr_pages++
                                [3]: perf_mmap_to_page()
                                       returns rb->aux_pages[0]
                                [4]: map it as VM_PFNMAP
[5]: rb->aux_pgoff = 1

munmap the page
[6]: free rb->aux_pages[0]
===============================================================

Pages mapped as VM_PFNMAP have no refcount protection, so CPU 1 holds a
mapping to a freed physical frame.

Fix this by taking rb->aux_mutex across the page walk in map_range().

Fixes: b709eb872e19 ("perf: map pages in advance")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jia Jie <jiajie.lee@starlabs.sg>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7f3e2c2ecb1..ba5bd6a78fe7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7150,6 +7150,8 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 	int err = 0;
 	unsigned long pagenum;

+	guard(mutex)(&rb->aux_mutex);
+
 	/*
 	 * We map this as a VM_PFNMAP VMA.
 	 *
