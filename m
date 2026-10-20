Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533549;
	b=1Cn4bfKPbpHXpbyQOCPqrlaltts+CTEdrt40ejxsy9PL8EYgSjbW/z0/dKs4R+bi2SQP
	 3x1eBRgFUqHh0Bwq+MRFyJMBkBm61wnK9HVhymynUvLwBIim+1fggemJGevTdSm3LEB7f
	 fwn1i931gIP0q7hGYLa76cjHHjQNYBBWNoMG65FElO2Mx2NC2iyPs8IFY6fVKeByRDIFm
	 WUjimhklWdPpoPrbosjA6d0I5tgjI3dQsZ9FYKkiycnihxj3qbXiv1iJVrClLaU05+wvR
	 lhDuPdxDA307paXyhnjWuXgn6biSvNa0+SjIHcnWA6YtRJQfelyCCKtrb6Gg6oytOQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OFRf0ceigKCMfSem0YJiHH5DCGenKyglDuxNlTimA90=;
	b=0VqJV/JzpUeUnd4Pc2PggGYUkUdeJdDq+jHNnl/bbI7YDXPXTCfLlmZoASnrNKTsnDo3
	 NJfQiGL5rApxwxUGGKGKU4nrPBEEGLEoB5/VxF9/E4JwXvE2nIfGYh2BpkKioM1VaIa1n
	 wGfDoezNgZPfmRXuDxTnBw0jZze4pDIIKL+bmdgTD1kXNJbv3G1O0bMvJYvnG+Bi8JU++
	 4zKF2tiK3uDWOYEb7CGAW7tkEP7ceML5Dml89kmmlTdXfGqFlOT3QSzXaVZ1UrTx4J+x8
	 Pvw868PhKblHmEH69dOM6ulDBgQOW/ZtlRpgyc/80YnOucjeD5WO2XPHRhwYr+bt/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I+BHn+Xq;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522E606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1522E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I+BHn+Xq
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1fa22006cso629705e9.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792533547; x=1793138347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OFRf0ceigKCMfSem0YJiHH5DCGenKyglDuxNlTimA90=;
        b=I+BHn+XqQ9eQyTyJTSf9be+goHH54CA/u8sthwgc8PYOryJTEmeLCHXJp8UiiQDkuF
         2bZCdyIpbisgqT10hnlN3K9N0dsQMSGwZxPzQJLWMxSeLgk7OuOc+whZXF5WSu+HgvNN
         NT2v76pQoZcZka1GP5jh+pnfcwUWPZAk8a0yA/ipYAZakhz/pgN1BP1Mre+cqvhzRKBw
         otRiKNjzFMSHvfMMng17olqamENMvvnY5AaRoXGgJnB6J1kz+2nzdXlGQhTK7GYN8IaR
         NuA18p8yjc940Fqv0/SKztrPHIytdFbM5+petY4vl90LEv8v880By42TKLqSqmjBQbls
         0c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533547; x=1793138347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OFRf0ceigKCMfSem0YJiHH5DCGenKyglDuxNlTimA90=;
        b=KRl3Jo7D/XLEWlV1/q3fjZdXqX26B6uqABHx+KIa+2VjxlQkHiT5TC+gL8a62xGRrO
         fNroPBhzCXb3GbaP+BVxpLKmimkp2aRUgFPP9QzgjMZpHxWqSGpkyKR2OFfU2OlXelje
         YzdVm4Ftl0Xz8MF6IEWFRPuNX6TnWSnRgVVI1XIlknlYihwafk6SKLcyeEIQpHlLJ6qH
         Cich4zh+bJ3gJ0eExO1Rpf29LTft7nPStonBQsK/+TW3xP0cqtlTpq6VsAUqP4CKQ8s+
         NaNeML+h4mwoXyEz+8hEP1FDXJBHxnvjLaadryu5Lmz7rIEwJVnCQuZ6usxRr5Z9+on3
         Rqrw==
X-Forwarded-Encrypted: i=1; AKwUvBx9j/CbifWPq8JnGbsZQfazbpaIRgVPlUbC/iOr7uNiQBT8zNjs6f23pVSngASKpGVqyHora0A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwb7UMSzXCXy3zo6p6yROMiutnihVv6UFkXFUeSkBGwXqXrBtM
	4h1CNLuIKO8ftlCDKU6GK6B47aXqNHcHp2W2ClQfq8/HBPNX/OdARpE=
X-Gm-Gg: AYBFou2l+3CS/pcF7s1MrDRsFyfW+5zlLxuLnn+AB9kDXccyNhsPvwgIGIfkaajmaZb
	69puASAK+bVveiFmcurMQQr/5aQMth/tR39gx+qR2lu7/ejnb34CgJZ0B+PYUCZ/SAO4ZB9hTJx
	x3f93EdodYLCZTPs5yM6GQVxJnJDD+IluvsmwECVizTzWoslt1nWGODAPpuj+Zn5Ybra7aLIQNj
	FlujHrn5zj0uYvktGo0BQpPG1xCQkeJ9kW12cEQ3POmXWTYjaubGP72d6er485/01yFOjgp8yzo
	FfdzpTjkhFGGtWEmbb05WZs3KAYv6Duy8dS5JnpM1NY2eUiAPORPc45Iykl3HhPCPJmEAzN7fB8
	MWzg1WyenFF3R61Q9yt5sGk/AHJDcLpeeGpmSXfd2Ouxi9AWVvbv8VF48eX6tw8NpKF2/knpSSR
	7wegeRGL2ALXZfbcaUzgp88bTplkvpH/Pq5rjv+yvMgoB2RMkgVxs+NtC/r5tTfhe6lUB8U3kRA
	7//cPdNrlRZMcvRez6BBr9Z7SkdmmSkfkkiTkd6HMkExyc3Ivmh99Ewd1x1LD/rIu03aQJ199dW
	/fMfxhSSc8XAgBdEGg==
X-Received: by 2002:a05:600d:82c6:b0:4a1:96a5:366e with SMTP id 5b1f17b1804b1-4a1fdb1d212mr726455e9.7.1792533547325;
        Tue, 20 Oct 2026 14:59:07 -0700 (PDT)
Received: from Ubuntu-2604-resolute-amd64-base ([2a01:4f8:13b:86d::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm1095988f8f.22.2026.10.20.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:59:06 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: lance.yang@linux.dev
Cc: david@kernel.org,
	samarth.colleges@gmail.com,
	akpm@linux-foundation.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a page
Date: Tue, 20 Oct 2026 23:58:49 +0200
Message-ID: <20261020215849.730615-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020055518.36087-1-lance.yang@linux.dev>
References: <20261020055518.36087-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This works for me, on b306deee4cba (mm-testing), x86_64,
CONFIG_KSM=y, CONFIG_USERFAULTFD=y, CONFIG_DEBUG_VM=y, KASAN enabled,
THP disabled.

Reproducer: merge 64 identical anon pages via KSM, arm synchronous
userfaultfd-wp on one page, then MADV_UNMERGEABLE it without touching
it. The page should come out private with WP semantics intact.

On the same commit, before applying your wp_page_copy()/handle_pte_fault()
fix:

  UNMERGE ret=0 errno=0
  AFTER_UNMERGE target_pfn=1153393 peer_pfn=1153393 target_KPF_KSM=1
  FAIL: MADV_UNMERGEABLE returned success but target remains shared/KSM

and every run also hits this in dmesg:

  FAULT_FLAG_ALLOW_RETRY missing c80
  Call Trace:
   handle_userfault.cold+0x30/0x3f
   __handle_mm_fault+0xde9/0x1c30
   handle_mm_fault+0x13b/0x440
   break_ksm+0x8a/0x100
   ksm_madvise+0x467/0x780
   madvise_vma_behavior+0x1d1/0x1e40
   madvise_do_behavior+0x431/0x14b0
   do_madvise+0x162/0x210

break_ksm()'s internal fault-in to unshare the page is landing in the
uffd-wp fault handler, which isn't expecting it. 8/8 runs across two
boots, same trace every time.

After applying the fix:

  AFTER_UNMERGE target_pfn=1063999 peer_pfn=1064929 target_KPF_KSM=0
  PASS: target is private and no longer KSM-backed
  FAULT event=18 flags=0x8 address=0x7f3dcb727000
  PASS: read generated RWP fault and remained blocked

No warnings or call traces in dmesg. 8/8 runs across two boots.

Tested-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
