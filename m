Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F53F39E9
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998493; cv=none; b=rq4kWNJUIYZmJsMrzOj8LTbWx8lqh2YitM+tcsU6puphNZxCyo0WdtbMrX4bXI4q0d4JMdJ51gjmoySvAnqMQpLw2TLsdU/IDqh3qy1TjOO7tsc5sShmwLFM13x1ojMhveACWy1cKaGzWYvt4D3svXZUMZxORC4YAjAUSng1gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998493; c=relaxed/simple;
	bh=nf+bv50ZTCGwHFRoWKNmDyjE14ZfVlKrdOLd0jY9iLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fA2WUP7nGjl0ODKLPlYFZrzGVTRPw0XdHbWMQ+IWosQXFrFZXZZXx76nT8tMa8KF3AqhoatTkou+oWucuAWgZy4MBM4RxMSKK0xapFnBjYCuivzVlXZ0Vtu1rPMkcyZSy37IzWNt6B/Ww28hqRC76THPU6/baApU10+CRK1QuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9aPCgEw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9aPCgEw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2475939b3a.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998491; x=1781603291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DosgBZmXYSZS8jfaq+CIJFpHfXVEKxjsm0nvwVPCvo=;
        b=F9aPCgEwZ2Gyow9MpPjBF+nQm/pk7apKPlo4Rl9VasQfbRI/uaSMlQL2+5TE82Itqn
         7ghxxLSeADwbVw0t0wb2e216oH8PewRN4zBtNk0f/RYJywPw5NmmnH2eGvWBSRdYotT5
         JYDar+QgEWPQQiZUddMf8WKn8Vn9MXfKZSXUYRWRjNKXeqg9bD2dE0bnEFnbXgMT3f1V
         KWrdxGT1iBvMCxPW4EiAYXOMGvcM0Me2QRQBDF005LThk7X7hLuBSBrcmMwUJ6dtdUk2
         C3YqAnsNqcBaLqxNTCe7n7fCaAC+sAXidehnJRWzpG43jdsyareFAEHPfGPwZO14NPKb
         8RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998491; x=1781603291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DosgBZmXYSZS8jfaq+CIJFpHfXVEKxjsm0nvwVPCvo=;
        b=plQvOvxTTPP7oaCeOwhcRkOQ+Xf0KTSwiVcbGzqFTQNXuan8kFCwxFjClrzxFZ0hEB
         8L4YdsBsx0SOKCASBHtFGcCFllJtlD/fh2tXF7f1OsxNX/a5xCpBq7pqOPEjPx4vOCVG
         jvtMP8f5xH/N2nwo2kPghnOIjekGGm9p3esE5y0kfOVIUbyNfkO2dvIoyUkFWSQ1uM8U
         AgmHyjzH6+rmI182+FlOiSx2bCVbT3MNrOBGjfaTspDsCK6fPRAsbt2kYmJ8CKZ02j3d
         tj6t0YawfkH3hP0bw8LjYmknKaM2pX9A+9Me35FyAau6jWQHOiSWjlI3eDu7SXuPl6oK
         oJkQ==
X-Gm-Message-State: AOJu0YwZEzx5QSUKaz+N6fAG5OnEs5KYtW0UiD7Rb3cWY5vbkyf5/Adf
	MMB3s1FqW6N/tHCAB/rMX6ZZcmqBYWvUkZBb8KvnBhZsCfHjCp6+onWI
X-Gm-Gg: Acq92OE9qtp4UAABlh3A/nKug2eAEF+yPE9XRaFZ1ws1UsaST6gGbzmz0fRlFFMHzlU
	NgZfNTEIG9RyM2bpVt1c0r5n5RF9kx9OtQq6V7xs9rNvvxqzLUfCxwpWCUS3xEFq3zj7jWt9ir8
	QvX4R3gAZGocR1Hemj3C6GXlfDOfmuzbZpYASDlbjLAu7APS9ozDt167KgYlCkQO0k8J4cmPgd1
	29E7xzYN9hHzDPCUar9evo/RNJRZzOhB43AVED/ENO+mmvmfwO1xGhrqMSLVbmWYCnH5+D09kPx
	HaURo33SCL7GfeYPSauE71Gkjj/WW8+/WoPlR/ylTN2xu85iEudEyMvnGG9cp/fjTUgNHlsFKiy
	EIzCYaufid3T2hC6MEk2+FeCrzMb2682RWcZMThtal8Gb6jkrYIHoO6WoUSQ2WqYo8DV+riROrE
	mcAk3vRq5UG0rt4iXTq0PC7dzTX0MeqOGbHkhHls/tGH3nwYm0l6EaNWlILgl8hoiv
X-Received: by 2002:a05:6a00:9086:b0:842:4982:82a with SMTP id d2e1a72fcca58-842b10fd562mr20964396b3a.45.1780998491402;
        Tue, 09 Jun 2026 02:48:11 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282883647sm24254665b3a.36.2026.06.09.02.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:48:10 -0700 (PDT)
Date: Tue, 9 Jun 2026 18:48:08 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, maz@kernel.org, oupton@kernel.org,
	imv4bel@gmail.com
Subject: [PATCH 6.18.y] KVM: arm64: Take the SRCU lock for page table walks
 in fault injection and AT emulation
Message-ID: <aifhWIyS3A0Bdmnv@v4bel>
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
[ Hyunwoo Kim: __kvm_at_s12() still returns void in 6.18.y, so the
  surrounding context differs from upstream (return; instead of
  return ret;); the added scoped_guard() is unchanged. ]
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/arm64/kvm/at.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index be26d5aa668c..e6de6aac6ede 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1528,7 +1528,8 @@ void __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return;
 
@@ -1623,7 +1624,8 @@ int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa, int *level)
 	}
 
 	/* Walk the guest's PT, looking for a match along the way */
-	ret = walk_s1(vcpu, &wi, &wr, va);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = walk_s1(vcpu, &wi, &wr, va);
 	switch (ret) {
 	case -EINTR:
 		/* We interrupted the walk on a match, return the level */
-- 
2.43.0

