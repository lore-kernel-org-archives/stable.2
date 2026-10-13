Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF644F053F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903548; cv=none; b=lwV0LmPATuxZn3jbCK3mC95TJq8eY9P+TkBsU28f+7Udi3StpZkbKIJf/KMEiGzHpe6G6MPZtD3Ti5emNfkt/TnwGXd9qJQ1yym1H2s6gIyPPvNjTaJJ1/R8vt2foA8PFWPolwfLtoE5uksHCDJ2l7ik6qnUmCy8OkSjN1Qvrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903548; c=relaxed/simple;
	bh=FBgzYtygj+qBMgJZ6O+PbokKBcrfSwh+KZYwnY+ci+k=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Cty0X6MAevxhuIF6hUzKWn+MKaBZ/hZXHi8NChPZOpHjaOTYV2R1PvtNjaabScdvn2B+vFR3NxEsxZLgpIdBGhKpOGxuo+MLe3Q+C428MeC5ba/uK6AH5PQlSN+KM1HUxBKvcCvxIMjkegcSzsfq4VqqpxtOYQkr3Q0q/TgfwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=IjZLeNjb; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="IjZLeNjb"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35943f55c06so12483eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791903546; x=1792508346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tb+WuTSFiypcv4f9/09o9s5eGsFZDDZen7eqFCE2z5I=;
        b=IjZLeNjbxzv7VqYrq+hH7uH0qTvxSHScemGyHq0XoE58jq8YnuQ7Old524Ap6IFiMz
         LVymGwOzYa/HRPJBdwgtnsKPQg5z9ag0yS3N+UU8CBmtf19YsW1uA/CR22GhMRDS0OkU
         1DNnE/z4tw9q6mDDJ0fT5F5BfW0EYHbZxTC8pFpSegFZqkccUSjydPlHApSWwDYjw4Py
         pFbHBt0bJNEfRLwpsaUOAkimSOL5BMmpf25PdHZ1itnNS9nVTWzXm7YFFHoK570/GVmd
         H82nTFRzPN2m2mU4NIGO/yO1IBUg5NFDx5JIaYPUDMUsA4N8tgRWCeVvlCPDjdOAB66z
         EiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903546; x=1792508346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tb+WuTSFiypcv4f9/09o9s5eGsFZDDZen7eqFCE2z5I=;
        b=B32z4vRrgHXvSEO5Rg2Ng4yQpIax8kZfVxUUm6aKvAALa/N8s644keIGB+86I+a31a
         v5l1rS1I2Do9VRhx+6IOurIwYKbSw9rHrYXnjrV3/AhDwIVNVQDQvwqULnPWNcm4CY8t
         +ugZ1cf84NU1495p+ClS/dE5k7Dkn++zZ4+WWOSIC4j/PJX4kqnbeKeXX0wcb9Ox2woH
         4hpB8wYr9hoThzJ7Wum8Hft7CKsXB82oBBscoZF+vklGBqu/yxVcEeoQJcEaM4DAQP03
         0TJ0azSjrYd7qGltILG3PNR2N8QnhwzpiBtHZG//b9khKEiNjRXfme6+Gfv3oHp/3Z/K
         82DQ==
X-Gm-Message-State: AFq9FYKVFoEoIoLCiGQPsWvuJQpEQz6Jxeph64XFLHVPexQq7DBWESun
	7eb4V+KPbCF6n5i4gIintPOAgVk0rACzrW1mTOfKEgZJKLB8FtMQ0carUBfutT8KhZQ=
X-Gm-Gg: AYBFou1oM97ZcC7caxSu5/bOO4tfNmsdnQ8XOb5XBSE1l5JEr/01NEi1fEh3akRPgrT
	xqkLbnyV1WHI0Gv/D+BcXD20cOais3FCspH3brNRx3o8kqf2Al1hXdiIXMleJFhyUCwlMmZ2SFn
	8ZOVaZqZ2h9NPYY9tctt37LNWLNSMeNbWINzvwvmOrcDKD5cLkY5G7Fj5QriOuvj9uRBd3bMWp1
	ghXYId+ae3J8eGSny81sAauUJOMHYjJdVxVcbufw235bjRkecds94AffyPMMjdbf4ZkbJBrnPfC
	SNRL+j29EpYJk0/+cZoIM35I+nY2AS7IN8q1OwLjRP3IkYmi19lHAV49tv/PVworWR+DF2Rstcz
	KfHTReGDthcokeX54nR/QkzoW+tkd2PZLe8CGhoKSfTlClkXTCALNHguqgIJ7ZVa16ubYyDLzfX
	gHh/huVVUbHSsAJTtwM0eW5ZQI1fj6TEb0jf6OOS5zFR6j7F6rdc0oe2WYTrRbtT0+
X-Received: by 2002:a05:7300:c8c5:b0:34c:6edc:f4d with SMTP id 5a478bee46e88-3537de061f1mr16985498eec.1.1791903546041;
        Tue, 13 Oct 2026 07:59:06 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm58619752eec.9.2026.10.13.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)undefined reference to
 `crypto_krb5_get_mic' in vmlinux.unstripped ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 14:59:04 -0000
Message-ID: <179190354372.263783.14998161750491767739@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
undefined reference to `crypto_krb5_get_mic' in vmlinux.unstripped (net/sunrpc/auth_gss/gss_krb5_seal.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
  LD      .tmp_vmlinux1
mips-linux-gnu-ld: net/sunrpc/auth_gss/gss_krb5_seal.o: in function `gss_krb5_get_mic_v2':
net/sunrpc/auth_gss/gss_krb5_seal.c:(.text+0x158): undefined reference to `crypto_krb5_get_mic'
mips-linux-gnu-ld: net/sunrpc/auth_gss/gss_krb5_unseal.o: in function `gss_krb5_verify_mic_v2':
net/sunrpc/auth_gss/gss_krb5_unseal.c:(.text+0x144): undefined reference to `crypto_krb5_verify_mic'
mips-linux-gnu-ld: net/sunrpc/auth_gss/gss_krb5_crypto.o: in function `gss_krb5_aead_encrypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:(.text+0x18fc): undefined reference to `crypto_krb5_encrypt'
mips-linux-gnu-ld: net/sunrpc/auth_gss/gss_krb5_crypto.o: in function `gss_krb5_aead_decrypt':
net/sunrpc/auth_gss/gss_krb5_crypto.c:(.text+0x1a5c): undefined reference to `crypto_krb5_decrypt'

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:da13e7f2741b8dd2bcc445d8c0bc85ecd613fa65
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b12a02dd090ec1b0b00fc16d1be95e7b53677ceb

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6ace2936a3f195e1aa7583b2/.config
- dashboard: https://d.kernelci.org/build/maestro:6ace2936a3f195e1aa7583b2

#kernelci issue maestro:da13e7f2741b8dd2bcc445d8c0bc85ecd613fa65

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
