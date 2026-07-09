Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CAB391512
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636637; cv=none; b=X2V+H3V4IANJGD82/WvW8692K8g/hXilK8Vp1OigoRpjXvVlq8tg7OYeaYGChyTuWTGHUDhdZzYEjF4185WHkFmvae+6Rpc5IGZbCHf8Cj0PFzbR30mxBRGYKyjj93/Uv4ieqlc2jRpkCTMMM1xHzCxdUd5p1MMcXezBizOsbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636637; c=relaxed/simple;
	bh=AHjoK9vEXc/x2kH5t/vxAjKWX/gAycwwhcHLRoN8MY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njyBUP7XRabAZGQPdDp0Axbvn9L7HTJliCynHn5Yi9WzW/SqtZQuTpZgE7+eR2rJ2i6KEz+BttCc4Buh/dd3puU5Q2+NsxQpuV8ksCx2RD8SxAWiAfLH7dAk7bW5QNUI0fHuQdRmOT7rHFGEB6J0xQ9cI7ggDhAu7AQE0IxdZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZIWUIC5; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZIWUIC5"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-487059fb570so484519b6e.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783636635; x=1784241435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6N75Ip0e2UbcuvkSUVcoFLBJD3su3VCJTRAaxl2PPE=;
        b=tZIWUIC5trgTb2lN/m6c6/mPHDWBMOKNb1xuUBHCKlihog8EkvrlWsgpDAax5OYD4J
         ifnUGnpHSo2904u+VGrIkU8Ms0WgXtUOdYvFBAlw+cKfStbF0myKR3FukhoLzh22Z2Ch
         TMu/DTTpLFP9m5vBxH1Sc8AxBuGTqgrdwfgCXgl5O99kSDS/Knzvp6mJVV0hy3aq4V2p
         QIfQIKcqwTHkVi2IIXUe3an16N5sBpIpsXMJZEYoUgbzoFfwOQf+QrDPHIBwJF7FEtzP
         Hy21RkVMmR+2EbXJu07pj6YvxkIQFVek1TuEWEnLI20Oqm7ZwSPashHe/tMyvXP7oiYF
         SImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636635; x=1784241435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6N75Ip0e2UbcuvkSUVcoFLBJD3su3VCJTRAaxl2PPE=;
        b=lEZLOj7b82bG65GJdNb5L1Qx4D/2z24E9TBXgtPnkTyOLYH13wgW37a2PuPQ+OzJyQ
         L0OovLUAabGUS2KE9Zq7n1d7THrjRwC+5s5Np2xVSi2eyPkaReaBAm/HDWAElYkIfrW3
         /Jg6NdGGb3NxdOjSooU+T92s5MRXHvFT8MNe6q8TPEeIKEUzHepTn2k36U8QXhYI53Ng
         r3KgC/yIMnZQZXhN8LE3i0WVIRYqctJ5rG5BvcvlMfSSLNMPwd35X8eDKz0ObpGNC5vW
         BHfgUblDyXtn3u0Bnpknr5zBJfdGyReM5lGP6I6jgpNyc3riJU2uoWQCabS0Lj/Mi/7l
         wmTA==
X-Gm-Message-State: AOJu0Ywo2KMYMyNUcWoyLvDsZaji1EVqIv0ttKkqzvwJRa3QyceJeZuv
	sSM3DLDqO82sTreOBB2Oq1STXEROThwEP2bBSpCF+MtMKNbqKp85fiZWAEapuH9DScCDPcaKA5g
	w1PTiX5VLpi4B0Cd45OlwOD/9hdvc1dtPEbLz6fPaTfX+whMPhsD64rPwXDJ22WTHhHn1sAeeAi
	PUxyKo0wm29isIv9xG5vOTldl1TY7fcX5spmWWNjnJCDsG5kR+JPVqFxWZ8HEU7sg=
X-Received: from jadk1.prod.google.com ([2002:a05:6638:1401:b0:5e7:1c51:6f8b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1206:b0:495:e997:528d with SMTP id 5614622812f47-4a201bf3c63mr5975498b6e.3.1783636634820;
 Thu, 09 Jul 2026 15:37:14 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:35:58 +0000
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709223604.12934-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709223604.12934-2-coltonlewis@google.com>
Subject: [PATCH 6.6 v3 1/6] arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit cfc680bb04c54e61faa51a34d8383a0aa25b583f ]

ARMv9.5 has infroduced ID_AA64MMFR4_EL1 with a bunch of new features.
Add the corresponding layout.

This is extracted from the public ARM SysReg_xml_A_profile-2023-09
delivery, timestamped d55f5af8e09052abe92a02adf820deea2eaed717.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
Link: https://lore.kernel.org/r/20240122181344.258974-5-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/tools/sysreg | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 76ce150e7347e..f7180d391f829 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1669,6 +1669,43 @@ UnsignedEnum	3:0	TCRX
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64MMFR4_EL1	3	0	0	7	4
+Res0	63:40
+UnsignedEnum	39:36	E3DSE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	35:28
+SignedEnum	27:24	E2H0
+	0b0000	IMP
+	0b1110	NI_NV1
+	0b1111	NI
+EndEnum
+UnsignedEnum	23:20	NV_frac
+	0b0000	NV_NV2
+	0b0001	NV2_ONLY
+EndEnum
+UnsignedEnum	19:16	FGWTE3
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	15:12	HACDBS
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	11:8	ASID2
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+SignedEnum	7:4	EIESB
+	0b0000	NI
+	0b0001	ToEL3
+	0b0010	ToELx
+	0b1111	ANY
+EndEnum
+Res0	3:0
+EndSysreg
+
 Sysreg	SCTLR_EL1	3	0	1	0	0
 Field	63	TIDCP
 Field	62	SPINTMASK
-- 
2.55.0.795.g602f6c329a-goog

