Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B01A9FBD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782502427; cv=none; b=k66WxvMHCNY77emiUJkxpsP5WAe7XOcXf++E7rvbmSgEWiTyXFq4G9m7yDVTZlOY0VOURtHPR5RNZ+vpTBNP+VkuTn+HfOf7SLGemDqshvCBfPDR3mQmA2r0YDsh3t+BaZx1XKckw5botnnh83bRvKKaTe3nRe8rFiWLvlWCk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782502427; c=relaxed/simple;
	bh=552UA4vwGyUtKg7zScaAYy3rBzcRVGRqzpw6YnTrj0U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bh5w2R0cxoFDDRyPMa1TAtn7y9gpUUpotOuYYUO5uadm6uI6kYaPST3zeuAf7T02RMT/pWEpeh2IF49TzLBaRt4FxQROFksevnSrRFjDQ7CuEf9akDjaN06Cx1BZyjkLfpXwv81fUYRrCHFjQukRepIM+FYndcUolEbXqJbO6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HQ4I6TC2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HQ4I6TC2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46cf4fd951aso111728f8f.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782502424; x=1783107224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nMj8z3jji93qoBO0mfwl6Cbwzm0blfMLgKc4TIafoG0=;
        b=HQ4I6TC2b6z71O5g1iQWumymSTTKUNwMmA106JjtkZZBBTRjbjnFXWTY/ahbVDj3gS
         kavUQv9lapyLhyCxHVXHT9EdKw1iSK/9gNpLEFLWPPn6sfDStk1dy+GLR/KaOrCTEuSe
         d23TaHWGN7K4YEtHEROHWr8QwtO+/FINC4rGHtIkWUHwNdWMx8RR03NaKSbP4df6Dd/f
         lnYr0m+hFCZUltEp6jPprReK9TIKsXfdgVjfBVBIIAwiqPtcU++DMRSMahRpQxTiJ6bZ
         IrcYtMthjapP7JiAyHyjCee+24wtGNS4EiIM29Zg7KRL45IqxTm/xcCqtQWKH+QdTcgI
         15PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782502424; x=1783107224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nMj8z3jji93qoBO0mfwl6Cbwzm0blfMLgKc4TIafoG0=;
        b=R+vULOrTqmuqLm98vCr2rtSkOauP86/Ua+ro0GyKA4/s4elqebbhATnCemZccvKmDp
         sHaG31VG1r4Uy4uXxH8nf75Oqv8A6vZhCLaowLvvyWVNYpIBhVi4ZbHjGCKauNJ4oBFK
         koS4oCN6fQtdblm4ddhyX2vS4HlyFzEMSeanRH45o+ZY1RfntzLm0WDNdfmDHqT+5AAZ
         2GGx8G9TancCofRFLCuFEL/6IcuIJ1GG97ngMPU1DLpGRRsdxdBufwGHRyHh6ZFl/J0k
         zcU7mXibbupJCTm+qLtxO/D1Es+hXSFdc1j84WKTJuQp7ytv7tL+tIk4cb7SCcmyMyVw
         pSbA==
X-Forwarded-Encrypted: i=1; AFNElJ+VJsdXWEVmbwqB59xYI3ogRErKLJOTD2aL0s0Mca5fzrSS2Xo2boBiKZqCLQ2+25LcXqVZl6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ElzRTkHU6XrkKLatf/dcf3emUPB/fzFmi/rRb4D37VOQ94ME
	VyJ7zAiQQratjXhk8gJtC+/Nc9QT+5aKUf8HZfYmItqXOSIXBNrbtzK5scpUN5mjHQM=
X-Gm-Gg: AfdE7cmn9OY+zbKAPNotYCax4ir0Xd/M4mvRGEnInFd0CSse97LGAjD0TyFwNtfNh51
	bBMLzVbaRM2OD9UYwW4+4qmXDIPIs75C+AK17N0UzIp4Lw90uIQ7WhM2rNLlPfJ2B7x2K5ERqEz
	XzIE9cEqsu2XT5/G05rpLgNrX0oSzFX6lj1HxokjDMSA8cuqUAZWNKkQVreDj+CIIG4H22hGXBZ
	b4P3UTiFv7C0dmjTtjYYT9Wfu7W/6P/s5rrKRAHkf4TbFYk+Z+nsKKG2TzhF2hoc8QmLGTps+77
	tmc7mvASIgpqMTeF6Ny3jVIa5p8ydi0ySYZw5iehbZ1zvcfX8RTZq6sV5w99gri3YLJVOdZvp4g
	0qnrTkRyQQ7uUGt4ZwK6XIcs6NOgQEubbDBHqNu/xrUFPbnl7QOnhEs/kHw2GTCHMij3VZXRZii
	2MbA0zx5oBQGGo5tR4e6reqmK3tq2lL2Xln7HTLG9vicPc
X-Received: by 2002:a05:600c:e54a:10b0:492:713f:37d5 with SMTP id 5b1f17b1804b1-492713f37e0mr3552205e9.4.1782502424272;
        Fri, 26 Jun 2026 12:33:44 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm108291345e9.6.2026.06.26.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:33:44 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [stable-6.12 v2 0/3] 3 SEV fixes backport
Date: Fri, 26 Jun 2026 21:28:53 +0200
Message-ID: <20260626193343.256956-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, hi Sasha,

Please consider to apply these 3 fixes failed to apply to stable-6.12,
I've tested it on EPYC Turin/Milan with kvm-unit-tests and basic Confidential VM
functional test.

Regards!
Jack Wang @ IONOS Cloud

v2->v1: fix the bugs noticed by Tom for first 2 patches

Sean Christopherson (3):
  KVM: SEV: Ignore MMIO requests of length '0'
  KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
  KVM: SEV: Ignore Port I/O requests of length '0'

 arch/x86/kvm/svm/sev.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.43.0

