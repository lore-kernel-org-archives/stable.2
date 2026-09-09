Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43055408F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973147; cv=none; b=p34Hf9I+qYIAnxrvRqsjyE2qSRxMMJcKg11PrtG/Efk83KQegAkdkF07RtB0BIrkqsElMaOl6EtJb0rlEGc3QN+6xlsOtMRMP246GRKkZw43hM62BQ+nhgYowngP78zcpHnkMNregZlG0gWK11y5J9UP9cxMDMAHj4SP/SopPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973147; c=relaxed/simple;
	bh=0Z6Xlaaq4ZiDtKkUpisX4k5uQ2EZ2bMl8ywBYfaqal8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=mpVtd79YobGo6P/IRNdHP6TGzNo8RTDdaCzVxjwwLtKcEdEtldnH+hD76Yfq9tbpVwlM+udTGmK1TEPUGTa56QQ2iwdrbSfIzp4O8fYcFO47JhwWsH3HPBA+rFv7HtHL1eOfvUBV6/4cNFp6fRwrWWuYxaQ89g7glZU2/WLIgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fe1Sz8NN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fe1Sz8NN"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79fbso3916755ad.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788973145; x=1789577945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WKUu2xhgk4wjamvBsgrAI4pXiuoFl8smuJuOuCUnXcM=;
        b=fe1Sz8NNnhFlrBEIGQtPR7y/XZyADBWqrYXdia66E3Ya5Wqo3LSF8Ty5xoump8fSiJ
         dwq23QmqjXD6NK7rVuYYIXfQdHSdauJMnR4YVIPLaDp0ecCdujERnQ5uLvXE6Lt5UuIQ
         3bU6HhvSDgpfkXMETRY2op7YrtK0m1SDlc0IbkjDk/UFosi2N6HKGPAn05Xq1sS2q/RZ
         T37f8g/XVeesXPFV0LoobEy+RSQfOJDKcnMvHqg5TKp0mBbgNgosu3c8Zf/RD0vfNQkd
         UXK6jJ1Vm8+9Xgc8apMxpgZk34QQF/qXaLKAMxhXXb4tH50PaDfWhnDV7I4qD7kn4LrR
         nF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973145; x=1789577945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKUu2xhgk4wjamvBsgrAI4pXiuoFl8smuJuOuCUnXcM=;
        b=W0VakNIDtcdLb4lwNBiT990N12HHuG16+lUEeYZd7HStuL7VuDAxx2rew207N6dlhi
         zE5sz5WINB5+DCTmBeEa3EOwwmjkFcJ1zZOs44+L3j2p3J3aJayZziwADGmMqqO+eWQz
         9fnSCDJzSz1qufVzdR3exn9u3YjM+0w37g4FBXrbQXPMTfCIukxhLeBK5BfP7E1m5FV+
         8ghj+xs5QIKldCdgDwfaIcni3vMrFCEl9jhEb/1hHdZ7alqHS7IBSssNo5KdPoVsO1wI
         WG+nnLHV4qdusxfST+I7PXRkuTErY2X23LDYNo/3pXSUhBVO739Y1S1lZb3REk15Y0Ve
         uVlQ==
X-Gm-Message-State: AFuF++lV0Uxtf5cNdntHCFOt2xGc73lpeTPEivqDBPoHN5Xz15wVbvII
	EKGmJemUBqJU9fAU4eZ51l0DFDe3vmfUfp2Z+6Me9bCElM1Xe46AGIsmuH18wtaUIRF1lgNd8h4
	ltRCj
X-Gm-Gg: AYBFou2BRZGPYnZRrcKWtHxEeBL28htGBU0KNewkUhLMLd0Se6iwV4C+zM25TrJOWcF
	ENZyLzsERO10SCY6/r3CVvWCA76/YhmJNdCjbSPSz2+778BGDueqicPz3d5gTYyiTD7oULKwTtF
	3sncOJbJv3TNwkIi5zwxHs7vBefP5YiKKTtoT4LICFddWgEfXGdIsAkIxS/gvpa2POMiOaFCXb8
	rZ4WGncZ/RulM+kT9BRGkpmXxIBmTeC2pFC133V1evlgndIjPnscR/b6YNn+e3bFqBv/4XBHXES
	ukiOhD2PoU2ukkyjsnkbmC+R43Fav5xWMWSCIdkc0dxbxKUsrDadRN0SC25Y9Yoy7LZ25q2p0h0
	encoItj9WG3EHd5LCt1ne53U1qexS91KsJkpcYbaZBPGRMxcuLwhcCUK6RKFFpOVUBgC0u4g9TB
	99LHhpwX2fbzQBSQ5ogULBmJaf8QNuGCVFlCHLQSBGwgf7tyNLaWTxHwwSkS14BNOt
X-Received: by 2002:a17:90b:390d:b0:399:149a:3f27 with SMTP id 98e67ed59e1d1-39d70a4f874mr2770429a91.9.1788973144932;
        Wed, 09 Sep 2026 09:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51846639eec.21.2026.09.09.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)incompatible pointer to
 integer
 conversion passing 'struct its_ite ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 16:59:04 -0000
Message-ID: <178897314336.3498.218614880532448145@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
incompatible pointer to integer conversion passing 'struct its_ite *' to parameter of type 'unsigned long' [-Wint-conversion] in arch/arm64/kvm/vgic/vgic-its.o (arch/arm64/kvm/vgic/vgic-its.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-its.c:2227:52: error: incompatible pointer to integer conversion passing 'struct its_ite *' to parameter of type 'unsigned long' [-Wint-conversion]
 2227 |                 return vgic_its_write_entry_lock(its, gpa, 0ULL, ite);
      |                                                                  ^~~
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:148:34: note: passing argument to parameter 'esize' here
  148 |                                             u64 eval, unsigned long esize)
      |                                                                     ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c7c0ca701d1cde76ff97ce6ab8747c456e20a722
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  73c3a49cbd7ef9a5fb689a3625b01178f041fe17

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa16af4e41d7f97d61b2155

#kernelci issue maestro:c7c0ca701d1cde76ff97ce6ab8747c456e20a722

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
