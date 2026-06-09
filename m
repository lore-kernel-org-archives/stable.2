Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3084C77CE
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031546; cv=none; b=q6K/ed9ZkaUbkZiG96LRk38Kll7rl5Rv2gdAvSVrj4w70uA8AqUzIhho2j36hr71VPje7NdSlUFmluy3gxwNrbuYfgd/M3DgLazv2F6cy6n2kc8gR+uFd/PcfhOUFlRNnP4i9WbjQK0cXWOuNF4Vua8UfDkAEmJcx0jp6g9Vcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031546; c=relaxed/simple;
	bh=9MJWuozdm95EQu+UdMbbiS1uILcVXROUk9VCGV1xUzY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gPt8He/qB/VzyuJf6ceDlHJcj67Pybae+TPcglUhymnDG0/4tMTLXIOO5aCFMBUhLEaXSM1d7WFS9R0ZMgjw1RxCsZgmtvu5ZSpBepihLJSqaqZ3hhNH+hXUnRAJN/lN9VY7N1bIokzq86KzOXAyLT+VTBvvNCUN7QEEGysxaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=gtCAR8IP; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="gtCAR8IP"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30759632453so8858639eec.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1781031544; x=1781636344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGTZliU9gkAnALUh0jIcNW64H2tlEeP5jiXiV2gI+3E=;
        b=gtCAR8IPRT4hfFcnN75XUqvFAD1V2guydUJttgjKnv6ohVetCHbrhSvcLo8tRILmQb
         /HRiSs3kA9IBOmRz+3C73GNuvphmOyjsZC+qBQ1RbAw0eUmjwSRdtrSp6eqSx0mLXj35
         C2HvZLb7DMnw5krIyDWV+b/+/WTpeZE0R5etSKWuya8sdEUDBqOUr9OQJQCHf3Xjx7xY
         AmDU6WAhS+BYwHBivbArNcoWN7NfVM7akadVIXtjOAqKCG7uK/N+go/UO2iuXI1czYi9
         YcO1CBojqSTeCks0XUY9BjEbr85TFvveCYdG8LybcQEydxymzkZeu2xbhUCNua8wYUNU
         q4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031544; x=1781636344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGTZliU9gkAnALUh0jIcNW64H2tlEeP5jiXiV2gI+3E=;
        b=I2r0HorbnMI72EVvBSjYQg/rdsy0KIsSicYjK1ouzaXuEl8CaHPMyGKoSi8HTv+C9O
         K5+43ShGFb5vu/HAdztfhbPRHLnTOC5MJWDQ9NIeao9+3ut7vALzi5zlqZ+wAizW5bJO
         3DEli0vMVfacZcQVnMQsdc1INZjyYrXRBtjEQPCfF73khhRZEcAoJoMGS7J/YivmtP+3
         sVe3NzOaPq6ewZ8wUygLAMb6G6Z599kv+f6fPmoYkidTsn+FiRe9jPIVvZG38YD6oyDM
         5BCnfKNPDpnAqyCY/N9svvfw2pvTJb/PVSbxjz6h0bVNUuXpRJWug/DCESso9LuFCFsD
         xb3g==
X-Forwarded-Encrypted: i=1; AFNElJ94TnB1RICx+t1raBlJgbhkYPlxhR2ip/F74LphENLaGkMtm7PPSabLs1DVIC2m23Cce6bd3qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXFgKjytSZS4iMiORiUrevVW+Tg9oMHT+Sd8EnJDvh5BqzLkU
	1h1H/QtR10OxnE9JYmokyxK3ic5kMddwcLGnuseUTV31P1BP6rL+6YaFc6dD/XzsLmEcQKsvJ8Z
	As+Q0
X-Gm-Gg: Acq92OH0Qfu9q6bH/+FAJtuEdMUoTvoGVQJrctSH+ozixrR+xdp0nhi1DdNT8zdkLhR
	oAjwmVUocIpkAxD5rbswVQhmLa/KGPh/BlHorxFxDXUlJDN0u9RU5FxTcpdP1E0ccb1PCukivw0
	8BjHZrm5WNFTWFjrAb7tNSK+aKTa5ha+YWUPojpO/FQ1K70t8PEwzGOPjGjczeb9tH/DkabtEkv
	JHc52ejMvqxOMGOW5E8jp20laew+ueuYXyM3+8dXAEfVYlbdHJEd5q3wuS3KYjqJuQe2WPITYDw
	PKTA2mWmL0tef0LA7+3wcnOhj4ICCOkI5Da9TQeCICwMVdVof8pD6VZsTBrKEGZK0KkDk02HN8H
	fhqKNmer7M8oSxaBagdXZn4I5eFGNMSPsLrXngB1+ZDz+JIejGtv6SdBlbXIQW147ElpAudnFBE
	c97iFtnTJHEU+c4P/6iS5GQAO+CdY=
X-Received: by 2002:a05:7300:7253:b0:2f5:2556:5acd with SMTP id 5a478bee46e88-3077af4f7b2mr12867395eec.13.1781031544243;
        Tue, 09 Jun 2026 11:59:04 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df64eb9sm19991809eec.25.2026.06.09.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build) use of undeclared
 identifier
 'resx' in arch/arm64/kvm/nested.o (ar...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 09 Jun 2026 18:59:03 -0000
Message-ID: <178103154332.12577.8012590683092427560@330cfa3079ca>





Hello,

New build issue found on stable-rc/linux-6.18.y:

---
 use of undeclared identifier 'resx' in arch/arm64/kvm/nested.o (arch/arm64/kvm/nested.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d6d5826b04e3338fb9fd28c78f0896152defd8fc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cf0f6b6b43955d204de7f88900d8348276296140


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm64/kvm/nested.c:1776:2: error: use of undeclared identifier 'resx'
 1776 |         resx.res0 = ZCR_ELx_RES0 | GENMASK_ULL(8, 4);
      |         ^~~~
/tmp/kci/linux/arch/arm64/kvm/nested.c:1777:2: error: use of undeclared identifier 'resx'
 1777 |         resx.res1 = ZCR_ELx_RES1;
      |         ^~~~
/tmp/kci/linux/arch/arm64/kvm/nested.c:1778:33: error: use of undeclared identifier 'resx'
 1778 |         set_sysreg_masks(kvm, ZCR_EL2, resx);
      |                                        ^~~~
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a252df246e71b76f9fe438c

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a252df746e71b76f9fe438f


#kernelci issue maestro:d6d5826b04e3338fb9fd28c78f0896152defd8fc

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
