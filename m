Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17C3F65EF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899953; cv=none; b=JPEtWkCHCxLDbQaS5UjYYsxd/002KfRmX7MYG78QG1I0P5JEqyIP2F7J054FUGXvgb9SggD3uRvPnQ+haajcmRpOuApGGYCWiY6JXllr3oEx/sOWWXFJaDAGPvq7x3gXmhGTSNINxXSwPzKBsgI8ePiqTmPoW6vFNKGKrJHd84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899953; c=relaxed/simple;
	bh=OS+9o7cajN31qtJtAD7VhK0T1hmDYg5ktTxosUtqkWM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=a0XejDeCRtFipymbiRMNg0AVThbjzZHjDL/dyUPIgDEIlN5YPSgLFeooIZQu6oUGRVn/OFT+yiYZ87mbFlrf6wv6TgnohDv05FuEppQs8uhUXJoZcOiWdHGa0+JzDD66MdNhMnvSOaH1mlNSUVH8WeB4iAw9CNS7PsyI5ndXiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=HKzFvA2K; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="HKzFvA2K"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so6895273eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791899950; x=1792504750; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VBZnFTo1MJo1bOiX/PFdHOd7U1Z4m49j0rlPyP5kIA=;
        b=HKzFvA2KiBjw55M40GKpADx6N8QzF1uyJVMVVFckOGAZiinJ2vvqAc5vmQL/oPH/Fv
         k07/k+cgFKesJWHyWCrgQH3243F8nurRZmDT+S2l/R4lNKo+z0hUT0DVsVklKeiLJZM7
         Rn3++zm4HWq1L86w53OEdMFvdsJHg9sxJaZDr0AmZzXSnOd50cd+pE0WnM47PpDcCxpW
         JedrOcuy/TkIzmJ4YOwakv8V1dOtgfBigG4inet4YB2gVT/MWq9SOY6HE7VyAMV82G+H
         bh6b33X+EzcDbZ9V5ywubN2gDWCH9E+rob01wWS7i++rKz1ZC2vbE74+01uWxDW9Fyui
         7Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899950; x=1792504750;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VBZnFTo1MJo1bOiX/PFdHOd7U1Z4m49j0rlPyP5kIA=;
        b=a+4cSGhJdxkjZkex6/omOBoIClqq3e9kduD+I1R+TjvPuKMGrdrZBUbVCnVnFq0aYD
         iYx28UN53fKIdcpQd6CNmDgzohr6OGZf5kvsmB6zA8i3xVKVuxexjyXGPvwB/4EMxtr7
         bb+FLw3Sk8IEePQ5qAIaE/rWucYbM2w/3KkMH9izS1bAcLhg5nTUDNcbyVnYNsHETMlz
         21JlntXZa5ZCylFn3g2KVa79UBIZi6vZKfA4GM3Pmg6wKsOSoFmrcVWqrrEJURPHn08X
         MkMPyUlYNh7H7qFaon4HYVktH2oV0+OVX49GdQ853t6PmctauJK0wdOQQU6ZLRY1b81i
         UrKw==
X-Gm-Message-State: AFq9FYLwHKKey3hGo5+WVfY1pPR1BUhmc7Gmmw0nnwzKvW+qAniFVTkF
	zV4nRSpCh3agAbGVSdAo+fji+OHpyTBXWgK+NbGu+cQ2vApfkSODrXuDQv0Ldk8TXAs=
X-Gm-Gg: AYBFou059jIRh2of3ggI1vTxQ7EyEhAFUg8Qe/EqDsZn7e5f/70Uq7p1MisAS10skd/
	4BVsVGoa0gp5bgg7NPLqnmKOtHdSaJT9hLR1sSi3Bgk/a9C982fUVNA4yIQpq1NztTKyZNCvMai
	6n1pT27NgKIDaIPGBAwllQqXRaNqx7fLxR75gDgU3FIhWhKFsyiAJ2FiVf/QXIVi1uqJ2VoCVme
	s5q4RujYKipCEmsJSVDWCyEOe/TJW2X8ySSa5PUsBKKTUm3CDlv75VSbK0g1ifqQheHK3AaUE/W
	VjlLM36hV4bhWmGgYqemKU/J1wOrggSMeYiBBK1QMPnv+9gQut+JgZnZpbAA5yABk0w9oXph4Av
	vhDx63/kYviRsRN/sV7ZyU3+WVZFctCUFHUHlMuO0X+qn+7kGMr46jXZuLB+xIJSkT4rQr7geeB
	SZWJ3hCVDgUDtqPHjoazTpjOES7Uigypt8u0U2lRrxEHi+4jJRuH7zarZGhlcezQs=
X-Received: by 2002:a05:693c:6099:b0:35c:1f93:7f2f with SMTP id 5a478bee46e88-35c1f937f93mr4238940eec.41.1791899949233;
        Tue, 13 Oct 2026 06:59:09 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm42849770eec.28.2026.10.13.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:59:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC03LjIueTogKGJ1aWxkKeKAmFJJ?=
 =?utf-8?b?U0NWX0lTQV9FWFRfSOKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm?=
 =?utf-8?b?dW5jdGlvbik7IGRpZCB5b3UgLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 13:59:08 -0000
Message-ID: <179189994833.261652.14544733128918653493@kernelci.org>

New build issue found on stable-rc/linux-7.2.y:

---
‘RISCV_ISA_EXT_H’ undeclared (first use in this function); did you mean ‘RISCV_ISA_EXT_h’? in arch/riscv/kernel/cpufeature.o (arch/riscv/kernel/cpufeature.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/riscv/kernel/cpufeature.c:1189:43: error: ‘RISCV_ISA_EXT_H’ undeclared (first use in this function); did you mean ‘RISCV_ISA_EXT_h’?
 1189 |         if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_H))
      |                                           ^~~~~~~~~~~~~~~
      |                                           RISCV_ISA_EXT_h
/tmp/kci/linux/arch/riscv/kernel/cpufeature.c:1189:43: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:0b0fc58ce195e03bab917251a77ee51fa8cbe3e7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c24fcd821ad0c0616426111a4e512c08cc3c1aae

# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ace2a22a3f195e1aa75870a

## nommu_k210_defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ace2a27a3f195e1aa75870e

#kernelci issue maestro:0b0fc58ce195e03bab917251a77ee51fa8cbe3e7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
