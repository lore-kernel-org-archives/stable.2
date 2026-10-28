Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210349;
	b=M9DJ2T/Tymd967h3OA+kea6Zne3K40B1EaIaR9mRuou5sYCqU5xZAXNUcsxU9txINlxD
	 mVCvKzhWOixk5P2dGvA4FGhQv2ODmOmM5gjRnVxVsHo+t8Za8DMvROl1aEvfJe1IlNlMj
	 0oSuQ4HAwoOi9AYDjCQDcbD3KjRrbciEx32QV/yzUq9Eg3eR8Ev5Y0sGNe0MMsKw2Pjwd
	 6+ErZ3xISQL7TJQ5HOQHi6AG55wagNR3IWnJI2533bSCTbf+9n82DHggG/q8Wab9L/sWt
	 +wDyMRnUuEc8RMr+wzejGSU/kK3hdGOzcCHEW9/poGp9IEfOp0yOLFcVLfK/p3gSEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=W8+kl4R7GcAtXcbiDkG+m54Y2A/fK/8ZLERRk6cLoo8=;
	b=YOBrPvXT9iErHJZO45LY5k+v9oZeqSeQGolHQKpx8i1NOay/Kc54JZkl9b4IZ1VnEvIx
	 wPo9K+ICqsbimcmGud2hT4sj05BCjWRL9Nc7Xup8MsSLeApMX4MPIid0jixpoAqovKPiU
	 o4AgYmvQtTE8iO2Al++i5wOrUH6vOHR0saYdqSDhquzZAg8UMIWW5CQBnvgteBvMfNwdG
	 96gl7SdeUVTusfFiQeqG4AIRwmgzS2yCMZhnf2GZR8P86RX9FobXFc07FKeFONNlmtS+j
	 nPmGFw764cEA/gEicTaMxpHk5DBN2/V+Qg4wUm1a6zEOp6nj5dofqkA8BbqZcD07Rlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NLANMLTb;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F94606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NLANMLTb
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-369f33df08eso2379602eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210348; x=1793815148; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W8+kl4R7GcAtXcbiDkG+m54Y2A/fK/8ZLERRk6cLoo8=;
        b=NLANMLTbI0RAQjqlZQInan/qsPqM9+PY9lML0rwvKlI7sA7rdK/fZ29FS2JrAfdtBg
         a9G7aUfLdNKrasvKP1j4ELCBsb8VqWUSn/4fTWQTAluQQM7kCTFI+j30p+w/bleHPEW+
         Tw6M6DuqW2MJLhmwnTcPAI7d/X6HWIF6MhN7J4f8sPi156QAa9kKnlxJ8DeitXXKKt4I
         9ELUVUfPWFnlJuTUhoWJgIQ9u6LgrJcrtJQTZS/2PUtTN3ZfCpibm5DXXcP3C2MBuytx
         DhzBiY2iraCF6Eyk13aOAiCgXPS2x/oYLBizIhi2Imv4EQogWgiTtBl/vfbyPudcPCac
         2H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210348; x=1793815148;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8+kl4R7GcAtXcbiDkG+m54Y2A/fK/8ZLERRk6cLoo8=;
        b=wfqQCd87oEX/Y4Wy5T2pTb5dJzOsbXzQ1ylLphZuEEtDCymHVdcvGJ5wtqf9JI5ZVo
         uGjIt5hMhIh4HHpnu9ipGGs//QIsalMohTuJT4iVuZeUX6UYVcbJFUf1xmbSzWOUJtYE
         +HOQq4cccON2/Dm+ypCw5jR1Lg4ryXaxDMJaqs90azHpkWsHIyOd+qSkzyzLhJAJ68Ya
         zgtflO3RCUBxQr5FB2USzmgpMULn5U+A7jsfO9cKLlB+l2rlmOvjpc97JJqdIJOQZmP6
         W7wEL6cwcaP4DBnqEOSTADcF7ovKTvzmYCF+8lPIv1ZSglK57uagcNCti4duhzTfRRil
         VLSw==
X-Gm-Message-State: AFq9FYJY1OOymcjjTKh72DjqQNpkMPYRN06uEdqLRwl9KYhUg2fE1eJa
	YUkb3Vlr7CAi/dYJALbSvJEMw2FzGRjF+jzDj9r54WF8dhHZIwdF9/8ZHPO9LaLLtmUbynSYUrb
	nMan3
X-Gm-Gg: AYBFou0fREODooau3nh65gNMwqOGjz8aaVaENiCPJErv+mGHktyAuJIqWnz/fM6MOKV
	RqlNzyy20NJxDAjIMB0OMo/ER7k9sdruIAJiw9ilYKRVbwR4hx4795f03idXvoRrvEfIrxQ/Da5
	rg1XpMaSYPiPsMJsxuhzK3PpuqlO/7/dUBKO8NhHk8CaZ6cCaW8gDQh6LyDUbevxYfSrqlD43t0
	q4Sfg8ROlUwsoqlWDRifQbaKUahJUELcf6lyqBX+vj++ykYbk25tsyzr0DadTiXE3To6utlHupq
	OZsiH3me6jmp7rG4yNxv5+IknOCKHn+DvZK0XPYpJ1amUG2ocXmUJjLw8R4uEBtNWi4jeqqIxEc
	QCGsSr/HD/J0NvhmU8bpD36ytQDexL9ZIbQMXrDVXbY4gG+T3vYKMOtnFULQNh0r3gk8OtaHDql
	J36VwIDaTxQ/7/eLyOwOuS3fv3gZm4rhGNuipM+kwxlMQac+7v6SrzYDzZ5t1e02aZxw7JulCmc
	r2tbqekN20eCEH/CW5oyV6JicB/z3PKDiPxUaKSOImUekVFQ7gH0nh48oR3/9c7gKaq0osmNa7Y
	dK+3ikQK+o9lU7DLGg+iRogWMKb1nb9j/n/o8QPfwPc=
X-Received: by 2002:a05:7022:ed07:b0:182:6c6c:d876 with SMTP id a92af1059eb24-1a6ced9046fmr4349628c88.8.1793210347436;
        Wed, 28 Oct 2026 10:59:07 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm8103847eec.15.2026.10.28.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
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
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98=5F=5Fkvm=5Ffaultin=5Fpfn?=
 =?utf-8?q?=E2=80=99_=5B-Wimplicit-fu=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:06 -0000
Message-ID: <179321034574.43309.13193962355801801982@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
implicit declaration of function ‘__kvm_faultin_pfn’ [-Wimplicit-function-declaration] in arch/s390/kvm/kvm-s390.o (arch/s390/kvm/kvm-s390.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:4776:15: error: implicit declaration of function ‘__kvm_faultin_pfn’ [-Wimplicit-function-declaration]
 4776 |         pfn = __kvm_faultin_pfn(slot, gfn, foll, &writable, &page);
      |               ^~~~~~~~~~~~~~~~~
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:4786:20: error: ‘KVM_PFN_ERR_NEEDS_IO’ undeclared (first use in this function); did you mean ‘KVM_PFN_ERR_MASK’?
 4786 |         if (pfn == KVM_PFN_ERR_NEEDS_IO) {
      |                    ^~~~~~~~~~~~~~~~~~~~
      |                    KVM_PFN_ERR_MASK
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:4786:20: note: each undeclared identifier is reported only once for each function it appears in
/tmp/kci/linux/arch/s390/kvm/kvm-s390.c:4806:17: error: implicit declaration of function ‘kvm_release_faultin_page’ [-Wimplicit-function-declaration]
 4806 |                 kvm_release_faultin_page(vcpu->kvm, page, false, writable);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e00cca2d085f58c60391f2a3731299bd9ca730b1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  869c8553759e151ecf6208f8250d5ca6830beded

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae22a815c0836a8c2f05f55

#kernelci issue maestro:e00cca2d085f58c60391f2a3731299bd9ca730b1

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
