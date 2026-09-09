Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387356E072
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965953; cv=none; b=CPblFWTATaStx9HuaNsArPTpSrRbjfqzyKge2x+2uwbCofxTpL8JgNjT76zrSD7N8AzCQIjrFjethOjy3iXVOnnOB2zB3SKmnxST59L7f9H5KYFlnhYwoAnzWphKfPX/22P2zSYmi10DRl6szBtLx85UEX6CL601cQiHU9BCMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965953; c=relaxed/simple;
	bh=qGkQsi0VLOGh9gBOmLjnJ934E0UIJzOXza9sj2VVe/E=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Jr52KqqrjYC1tocDCdd+Z45aNQbuYUmi1YGQ33lbwsBvWt68cvXJYaW0CFyyJ6TiiUBsNVCJ7LRIJQVg8eFbmzu5VHIek0DqQiXlj43D+nWNIBZA/hjOe9MG2JO1wdy119KZSoMgNZA5oDxRfntExSIMPZESM30g+9T83x4V6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MGDFLbLV; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MGDFLbLV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f177cso327143a12.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788965950; x=1789570750; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wfgdjzif830X2hWeKAaR+tucdkX2njnJmPnMiusnDo0=;
        b=MGDFLbLVB+b5l+qYq9ZDPhiOkxxiSkEtwB8JYNDr07dOMsYKkWEPxTjC3yIdykpyAD
         3MpYZwUKxWP6fm4rfsuXVHt9Hi0wrQz6jA+7+s+iG/4npwdVSmM/4Q0U1zYlra+v34bx
         ozCgcIk7te2dR3ED+CovzKJS0eWQJa7ctCmsA7FvEOoWO2sIRPv9ugnyWjbRF/KTc8VI
         lcKr7agqJtEBlS8bzCJ4skAcGgKVk9zm53EsyfeZ9U0mQcwOoRDLtwF/alcj2qOUCe21
         TJjMIVx78S/vJQJSXVid7FUJfwRNsPwppnpBkbERRZuSq320ACQTTWcMlnNmlqhJOrVj
         gZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965950; x=1789570750;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wfgdjzif830X2hWeKAaR+tucdkX2njnJmPnMiusnDo0=;
        b=seo1giOl15iinLv0wL72kNbSeiXBFW0vzcMI4lYHuzbWHjGciXI7hAu+nTIcoxWlsP
         Ph7vdql/oU8xYhtoHNGiqht8VJT0dlskwCpzDCfqhcW2zfXUTpUbh5mSGVpgG1mycqCd
         Avi5azWcD+s+82arfx7mVunS3oY634iLT7aB/x4vWWP1pS/nUfbQZPKx9ZinD4VjPWRb
         Jendjpokxtmq1ZmFZKZbm9+xJuDv9GJyUASvTVq5pqQ9riwbpXEqbZ/2qJ0TcKYdpAux
         WvxP/XIfzAZXfFa9jcF872NwRZRADMt3cIuNePKRj0Un6t/UYW9TgFubIajpFAlJ6CuZ
         X3lA==
X-Gm-Message-State: AFuF++kWZETEggapkTg42RSDmNXMFLPaZUd4VqDLry7F17uWEQi6UFs+
	dkAgKPEMqKz9M4tnQj+wCPp7BZuulhxTZ0H+ou+/hHZqpXBuLyERw3VBJyIBfnk3IMemge0vQVJ
	TuVr6
X-Gm-Gg: AYBFou0Ha0MTUZYL5Mg1QsV7QAhd/5YDkeqe4ylt2HTX76zpsjqL2bYArM5vPyni7qn
	FVLi4pVWfAvlMFDJ29QWSPGGJWYlxiu1Lv5Qd+kQrAZ/v+oT/+r3Ls+C6GfPosOU5FLIkbZTyG5
	VZR1k/QsbM+ZTK9Msigfv9buOom7jy40hZmLeYwoCmOhXPECRA9XRoo4kDuNvPK77SXDR3sQ7Uv
	reYjG1Fppb9EDn4gr4T+EeaGFbtgKz3GPKPUYEtZe8NA98nq1LTcyrb4va6n7vqR+HdZ3ERj0U6
	rOI35u2ifgLl6W/fcVrniR4udk3GQMdjWMRsuvjLe1k7GXssVqC7Az+8lulYjfD1IRcTa248Kj5
	LaxvPj32i/+BJYV+cCGdlRai7z9bNoJVpq4aNMh1+ZnPR4Cgxr4hWjQ93gN0AfEKMXsMR2/C79O
	Qb+NKNt/XiXIwZcYC9oJgiJ3punz3XBC3SDp0/nNsB7IsxUs4lp/nRSWTT/hCGcknMLmtvMzQao
	eg=
X-Received: by 2002:a05:6a21:329a:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dacbef08d3mr2189985637.17.1788965950450;
        Wed, 09 Sep 2026 07:59:10 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm49929176eec.30.2026.09.09.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)incompatible pointer to
 integer
 conversion passing 'struct its_ite ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 14:59:09 -0000
Message-ID: <178896594844.3462.9963754743977574141@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
incompatible pointer to integer conversion passing 'struct its_ite *' to parameter of type 'unsigned long' [-Wint-conversion] in arch/arm64/kvm/vgic/vgic-its.o (arch/arm64/kvm/vgic/vgic-its.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic-its.c:2160:52: error: incompatible pointer to integer conversion passing 'struct its_ite *' to parameter of type 'unsigned long' [-Wint-conversion]
 2160 |                 return vgic_its_write_entry_lock(its, gpa, 0ULL, ite);
      |                                                                  ^~~
/tmp/kci/linux/arch/arm64/kvm/vgic/vgic.h:143:34: note: passing argument to parameter 'esize' here
  143 |                                             u64 eval, unsigned long esize)
      |                                                                     ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:ffb2b9424614328d7958d410b7e7e8207f985e79
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  38adf93fff4adacf792704fb2ad9df849b7a0ed0

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa169b9e41d7f97d61b1f55

#kernelci issue maestro:ffb2b9424614328d7958d410b7e7e8207f985e79

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
