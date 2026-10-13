Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FB3F20EC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899950; cv=none; b=qb/P5PKvfQLthkuBKKSOcConX11UszvZ2z4m2lgdBU/KLEwhJlJ4aXdLHVfkqwy4ninTEvbFelp3BNe3w4MhkVF5wu6+pjsJZjkoesZQLiGCUEo3vDytBpKhtZHCUd9a1yACRLJ+Yiyz1ZLCyICvoEaz/T3gNORx8wW8Y+T5wOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899950; c=relaxed/simple;
	bh=WOrWvfr8F/bc8103YaEPQIOAyJt2G1/CvZJxsN2jIPc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Bzq3NIB+zYrItw+pImoWYQz0B9pQQOOrmNa6kiazJp035Q8AkpR+2V0YTMZglUhwVv1UQKoYAYNi9B1tgfuXH7Qe01w2apZasWD8BxiM3fcyfWf/pYK1CDAuhKGjLb4OEY1RlthPfeZ6Wtf2L3dt0MB2IeOYLjIOZvpUmRt39fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=D0NqAaQZ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="D0NqAaQZ"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35834f72d94so5316116eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791899947; x=1792504747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W3Zs8m3fHqsUTXsByCg8ZGVAnu50R9yC5vTB3RIMVjI=;
        b=D0NqAaQZWd+Chv7qbkWZQutvAnrBiaFn34WloDuUlwx8xcJO/0UvtHga9HjPGmJ2rQ
         wbkAZBmbP5xbRoisSvTX0pTLvQX4fGGG6C1RwumyJ5JrUyHkbLCXowfFox/na2qAEvSt
         g7JR6hVekryY2zsJlq3zSEJNgsrLWGyaekrcpvIhd21LlpKbT2lbNPnD23QZUtcwldhc
         w0iPD26wYiCiaweZ7BCeRrynNz3wK0cP2DJyo+Wm/rSliaPspz1wofmWBlL8YRs3Tqb5
         MpufsAd6t7SjIcuLjp6x/oW13WS5zXZrNM2zcIOJE7LQfiMb0/V1yF9AJiXUOwP7sKxp
         A0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899947; x=1792504747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3Zs8m3fHqsUTXsByCg8ZGVAnu50R9yC5vTB3RIMVjI=;
        b=LBmlRnxJH3p0r3MYFFvYQ91VgYUg99TiM3nXtdV9K+15S4GKsz2urSQpKQkPCCiIZS
         kLMH6oXFLUGxHK6z9kA9Llyq60SeEVGNubNtd1At5emE0VyIbJ8xzRiLH3gcYAHSel6C
         g5JhDMIHBNSxGorVJ+I/VVyT+wM/VDSQXw8SD3Pfvhlv868QOuaC716Q3aR4ZKnho6Te
         iRvZJauAkL2ZJOmLbwZUkllrdgvFc+uGj7wPQ226qxQ5mWIPOdrHKSZLWI6QcTmY8/yR
         uGEmMPwOxffk11Mlpc4b5ZgTp/Q3dQgQe1QS9v1EbvRsi+BSlp2FSZR6JZS2i0fHpz6f
         KK5Q==
X-Gm-Message-State: AFq9FYIy5kpOl3J6mD22kmxu4F4NaMC7SXAwaNMVTNFYsgwlZMUC+l6m
	RU+WjfiB/AOvNxdyXr3o27HriwJD6n7YcXoQBQrA3xuLlab61Jx2RIi47G3pve8RlKEZ8s7d7Ps
	Z83+r
X-Gm-Gg: AYBFou0t/I7lvCi8ZTt4EQCsUlYs/2NxBBL4hSNvRW5a7LrCfyOzZRNMC/MNInlbfYL
	k5z0rXM80rgd4jTy1A4zBlEYJN4QM5ruDJNyfoO0mv+0UFVeC/Z15sCY90YaEv+08VtGh7szzI6
	DyRJVcKqDv1pczbTy01v15Hpu0dLKAGMpRrs32oQzL83MIMtRkDUckMRKa1SCFbb8vqFWf1+BHQ
	sLjUNe3i0Q1k/3FgNkxqlk/mS6NAAXKYyybCkZyZh25VeJHYKsZAoUxFfD+rt+JSkFwleatRPyo
	pCysQ/2cyz1uRKoGk+NcwY4TYlfx2fx3vxEDYPePrB6q2CehJ61YbnmNgDbSrfXQtZ7w+nZNEvJ
	Vl+AbAwJp1suXI455qEBWDdRirVR25UO9krkj8Ilyl7KaGSJaHxUgUK86vQuzBVy1gcgwLnIqeZ
	tL1ZMPt5QNW79ueK9CUXvE54Qm18QzkM90ZqDzrtOvULbo/7HnFlKirWs8nRU6P+4=
X-Received: by 2002:a05:7300:e60b:b0:34e:e8e3:6469 with SMTP id 5a478bee46e88-3537db99095mr21941443eec.0.1791899946941;
        Tue, 13 Oct 2026 06:59:06 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm25052382eec.19.2026.10.13.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)undefined reference to
 `crypto_krb5_encrypt' in vmlinux.unstripped ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 13:59:06 -0000
Message-ID: <179189994604.261652.8424341821406313937@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
undefined reference to `crypto_krb5_encrypt' in vmlinux.unstripped (net/sunrpc/auth_gss/gss_krb5_crypto.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
  LD      .tmp_vmlinux1
arc-elf32-ld: net/sunrpc/auth_gss/gss_krb5_crypto.o: in function `gss_krb5_aead_encrypt':
gss_krb5_crypto.c:(.text+0x1016): undefined reference to `crypto_krb5_encrypt'
arc-elf32-ld: gss_krb5_crypto.c:(.text+0x1016): undefined reference to `crypto_krb5_encrypt'
arc-elf32-ld: net/sunrpc/auth_gss/gss_krb5_crypto.o: in function `gss_krb5_aead_decrypt':
gss_krb5_crypto.c:(.text+0x10ec): undefined reference to `crypto_krb5_decrypt'
arc-elf32-ld: gss_krb5_crypto.c:(.text+0x10ec): undefined reference to `crypto_krb5_decrypt'
arc-elf32-ld: net/sunrpc/auth_gss/gss_krb5_seal.o: in function `gss_krb5_get_mic_v2':
gss_krb5_seal.c:(.text+0xd0): undefined reference to `crypto_krb5_get_mic'
arc-elf32-ld: gss_krb5_seal.c:(.text+0xd0): undefined reference to `crypto_krb5_get_mic'
arc-elf32-ld: net/sunrpc/auth_gss/gss_krb5_unseal.o: in function `gss_krb5_verify_mic_v2':
gss_krb5_unseal.c:(.text+0xd4): undefined reference to `crypto_krb5_verify_mic'
arc-elf32-ld: gss_krb5_unseal.c:(.text+0xd4): undefined reference to `crypto_krb5_verify_mic'

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f00781b90a8f76c2e8daaffc165a2f16e1b157d3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b12a02dd090ec1b0b00fc16d1be95e7b53677ceb

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6ace28bfa3f195e1aa757dcb/.config
- dashboard: https://d.kernelci.org/build/maestro:6ace28bfa3f195e1aa757dcb

#kernelci issue maestro:f00781b90a8f76c2e8daaffc165a2f16e1b157d3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
