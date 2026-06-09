Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3A3F20EF
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000021; cv=none; b=P5ngLnYdqZADj09i3E2kB/NwU/x6ySSAvfUxH6kINHzqRSm202tzGNsGLlO4kcFmZZukiynrzHESnjvmt04Tky/sSab/qXKKoocMM65CMDvhE4tRVDEf/biO88OSaYpSkKjfPrYFn9WLNxklZls6e59wE9wHNgunzzbii03zg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000021; c=relaxed/simple;
	bh=kr3DUCTPtp5nt8CjVQZXCiTPTdWqaW9QImGFXXAQ5aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C2/XRw5GHauDvxrHGC4uvRXlwyLCK3DhE52z/ffoGiiUjHSpHwnCvIlnydHRD6BPKNWPTUt7G8gvG4E8GRft0ZYf9ATvwgPPcaXY1nxh/N+vK/ZVjZ0+KWDhis8gKBlGN4A+0Hu3HJlEYn13Mxw3goT4x/Wku/417Jhl70QCD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZfqHELb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZfqHELb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso3780293a91.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000020; x=1781604820; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OyJoQPJnZjc8cOQQELg2M7N9W1zb8tWVVBbPM59vx0=;
        b=iZfqHELbHQLBrgs8AAs7nntFGJDmmnqSto3hXtdtjOGF0M13wOHCmkfk1fh3Sew7Ue
         hSBeyWWfXHYywv+81x25aphBFeCcBgYaelo/LAk8CR7/iznoSX5Rg/BzeJKq/O6CsZWS
         pIT1+UMTvV5Ho0YVwr9sqyKMEGW/nlQbCKSN9clbvbwNGJXOtqJJubDKKFBJyPGFyiRB
         qtqmlhr8l36fg+P6Clypz8yVAuD/2AdsILgqAUUseQy1ltS7dr3FgJcMvcTNtUdIY6QY
         szx4k5HAnLf30PQAnopzuWAghx1Pp7mOvnGcEvIGuVbUrMa7n2PPAOj6im/7eqqJuzH+
         ne1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000020; x=1781604820;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OyJoQPJnZjc8cOQQELg2M7N9W1zb8tWVVBbPM59vx0=;
        b=ijA6OytkfeB4RgvJ0hvmneAJySA64S81dshyem3VxB1VWNL8Rxg+nJRpabYtVEBVa0
         zRem8jSw49EJRdvjJGVkrY9U/M5Z3Tt3We3Y1u6zU5G/f6GnKOv+inQsM+BZlgUWtrN8
         oV1NEjLQuwIMyN2VAwB1LZnRXUAw04InmbrwPOcwHHUQrGAQGdtPJrUsd9g2ZZBWeQLU
         6XvI1j/GEq6i1v8cnlqDvdKvZMguBPRFk9TsJAyFRDFrUFNuRq5qEkOQOWztu/3YebIW
         9p2uurAIU4LPNaUIq26Wrcqahx/sF10ozu0IYQoGy8NOHoSMp6B8rDiFvNiyAKBHmL2n
         tXbg==
X-Gm-Message-State: AOJu0YxhV3Lar1zcf+qn9h1SGF4VZmZtrljasmnSav5m5Pt0CEgD5KXA
	sdFG/DzpSM2KdA0sxXJY67Z49Ztk7qz0OZBFdrDKRWsWEwVkOkU2iaJnQHB65g==
X-Gm-Gg: Acq92OG21zfjiEIs+UehYDkgh5+pWjDDOYkdaNoIPtO4hfpd7hdLP5DXjr8E7Yi7wZY
	Gxs39pa584gU26RIFxSKtqqFJmmaZFkBIURVSkQbCxxvvjlLFjTkCv9jVkR5GXMfYOAAeu2UYUj
	DtHPiqI5JdV3VYy8GVuzZY0OGsuZWAKV2++fKZjqZMGyUtIkGKZh07L9Rfg/fOqYIy8bU0r8P8+
	JteRZ9B19tDKbnUN8mp378vcvAqwhAR/XOHcU7T/GVlcHbTn7DRDo4FyMpe8sfrp8JZ8Cp4/Mul
	yn4SV8+XlPJ25sXJFfxt1nNtcAL3tgeqPe9CoGCcFdsAFPZ/UmRTenIBH3JVVrxZb1QAsdP5Ftx
	8xSBPC4tVRmUgUdzLUmtUgx036GV1d4wrfUlvy1gLu7GAl25rqJ9Bfn64QdzGAZDTrLPeM3Xj6p
	/ra9FjPhVszjrXUMoI4WFiKaBQJvnbLVD6cFDtq0EBYEgZVyYb1wj0qw==
X-Received: by 2002:a17:90b:3f86:b0:366:132:fda6 with SMTP id 98e67ed59e1d1-370ef0eae3amr21724808a91.11.1781000019685;
        Tue, 09 Jun 2026 03:13:39 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6e828eacsm18580222a91.16.2026.06.09.03.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:13:39 -0700 (PDT)
Date: Tue, 9 Jun 2026 19:13:36 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, maz@kernel.org, oupton@kernel.org,
	imv4bel@gmail.com
Subject: [PATCH 6.12.y] KVM: arm64: Take the SRCU lock for page table walks
 in fault injection and AT emulation
Message-ID: <aifnUC7gmeniiYPv@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Upstream commit f2ca45b50d4216c9cc7ffabf50d9ad1932209251 ]

walk_s1() and kvm_walk_nested_s2() expect to be called while holding
kvm->srcu to guard against memslot changes. While this is generally
the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
respective walkers without taking kvm->srcu.

Fix by acquiring kvm->srcu prior to the table walk in both instances.

Cc: stable@vger.kernel.org
Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/aiAZfdeyanIvP8SD@v4bel
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ Hyunwoo Kim: __kvm_at_s12() returns void in 6.12.y, so the context
  differs from upstream (return; instead of return ret;). The
  __kvm_find_s1_desc_level() hunk (Fixes: 50f77dc87f13) is dropped, as
  that function is v6.18+ and absent here; only the __kvm_at_s12() /
  kvm_walk_nested_s2() change (Fixes: be04cebf3e78) applies. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/arm64/kvm/at.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 39f0e87a340e..8192bc0bbc87 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1087,7 +1087,8 @@ void __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return;
 
-- 
2.43.0

