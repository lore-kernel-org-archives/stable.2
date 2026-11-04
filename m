Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833147;
	b=pqyzh6P7eqJUmTNr3hGY8DGW9TKERS0GNFChAPLepxTO9DpS6tc1Pg41Oxi+i4B8cOTW
	 TwvP2BzYPwN9QI4KVi4nVChGKzwVyc9pfaowRKO3DuUNA+q4AiQWeUfghpm02NW2y9I1t
	 zCfpWr6KCIDb1a5ynIbIJkYNxrYYq++fNUVJgKzn7n8NRpVcLJQlbx4UH0gHjXJ/MGQGO
	 gBYAKV/bHalkW+00hw+HOi2nBgimaZBEE5cFm+1V/JuYkEbGcTypksMX9sTQn3CBFnKgm
	 iDRHXobRM1qXcDvv0TWQ9DAFtbKWiBscGYsvNXblacadIG2Lhe7zewPWhz8WS2dmGdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=6/7endb+8IggIil5UdE7Nqzs9svPgIf5YHVcFbhUv1o=;
	b=c5mgJGj7jl5ZVWo7eNKfrTtrEpWr7atLA0B+87Hu96bZbDcB/cYoMgt1UCR5bTIMvYxE
	 RJBoa1ifwkZ2GKCRGzuMvTxpxCSGw6JAmM9mmRgYGsG/dl2MLA0001m3WS7qPlQa44zNn
	 cq53LSL3GJ154W4n05QYIK62CEI1Ejhr4O86RwTxs1miRm/22gjTb5j63PiIMIf1Yts0H
	 LfeQ2RsdZn46n2oxvVpnv53xoHGzY5EuC81JZ17Bu3jt4w2RaKbCIcz07nUQgRURPd1uZ
	 pwXt3MM9buoAxVjKMv9u16yB1h2NmvZon+4gwLF3iWSNNMEYWuQqPDe9fblHNLMROZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=fKK4yvvI;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8C606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=fKK4yvvI
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b244fb7fffso1755661c88.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793833146; x=1794437946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6/7endb+8IggIil5UdE7Nqzs9svPgIf5YHVcFbhUv1o=;
        b=fKK4yvvIaPjTHLC4wdNOv2qwgpoiPVZpZJ1lz7xEgoDt/CUPCdHQxY8/jiJmycXIyS
         rOuDl8Pa/plv8ya6+/dryi7bJRKRDqF4i1RdH+eiwRFWKC5Mqx2HWvNH8+vvHk746Y+w
         gRvzfBPega5FrZJQyfEqphDBqDfJh3bEBxib08nE23cgYxzKh9Kz518pPB3log+LiBrm
         IXGcHtcs08O+RpnhTwMDMB2Io4RX70P52L6Oxp4vAT95hNhuE7+WtO5RAiN9oBU3vaBv
         YyG7VHdG7CGsiedmagEsRgmGHMDsv0p36GyQEriOHvI9u1hHH6p7N0ODyc/ZByVErc0e
         nFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833146; x=1794437946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/7endb+8IggIil5UdE7Nqzs9svPgIf5YHVcFbhUv1o=;
        b=ZjcQTHyZZIOFA107YwWLoOeaN3ogKBKgfaHbeKtsL7xIObcqBAjH6iG5rXbp90nC0w
         2ArFugPole88b7BRKBXW2CE6wGwrkZJc4F15ajpXgDPkjCX4NdosGGHe6Eu8whcM231j
         MP3nrf9A0f5BqTX8GVgoDNPkGO30mbPBNAlapm5NZoeja0C3k1fF2OXD2MyLDDvpOCI2
         cT+8BfXQp8fOQINhroJDocCBVmmhbVGfxLqW4Mz6OdGSQ90Unz4Wn1H35+pqMPVJO09/
         pXuxG+e8J6uvYrTorxytEzEFN9G8N1l+OhZV2xVAC1gJWOh9XNvpJ2YMITr3nAYG+SDl
         kMhQ==
X-Gm-Message-State: APuU4Z8pXVRqtM/fgKgrVNgA+6HIkCqUG5WfW10tZb9oz0X2kRT158Ut
	iKSAaMnV3BukX2PG+lUw6ZG5LNnccSZs+fG6BE/tU8DA/RytvpDS0VAtjtXX02t7eUbbR6MuPNF
	UFXqy
X-Gm-Gg: AYBFou3VP92OqFihghgNfUb/4pkIn4wZrz8nfDtZ/aXOAw73Cko5twhfX4fMjaudpoc
	fCekB4rxay1oyRjXbSIUiLsiefqGz+nEK/C4YhtYKKFUxmu5lJxcAUqeGZbSAvXWLfdknotLipg
	Zbj2SoLOfLQSCyw0HL1hujQ6gdY6l+u5ugttKgEWsX+/MQhQdUmjWDDXpnRv5ykXqaR/eVfid6s
	0d0UOWTtddLXJlZgjp7YMzkh/4RJcRIAHR/DPn0FpJMkJmoXl98UiFJlHw6irxup74n4IFGl5nk
	VjCwxHFvRCPetwMm31ka3H5tZ+f9oiQC6Ftctrc3m0bX7SvsQRYimYq3bvs2adqr2AMQ0V80WNl
	qE4rWvKi33jvO2osn4549aBBStS22vc7lpSHjoe7Mac3KiEuR6IQfWjSKSiQZmIxtbXsJORk/mT
	tcr9bja0u5GnYcskAxUWA+euxgqgPcbuae2fHDnjxtgF9wsw+udW7HZ6jQHkIzHcgxNSJClw6/x
	uXQ2iB84ma/c5wnYFpGpowVsg0rytdrtoBUsIUxibYOhB41kXUHZ49FiS1HEeUSh2/PXY0X39kl
	WqOQS5WT3Q3+mJqkrrd5Uw==
X-Received: by 2002:a05:7022:b053:10b0:184:19ee:1fdd with SMTP id a92af1059eb24-1ac56302618mr26406050c88.5.1793833145837;
        Wed, 04 Nov 2026 14:59:05 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245ac2f44sm11602661c88.0.2026.11.04.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:59:04 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)call to undeclared
 function
 'huge_page_mask_align'; ISO C99 and lat...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 22:59:04 -0000
Message-ID: <179383314366.333747.2380725177437581538@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
call to undeclared function 'huge_page_mask_align'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in arch/arm/mm/mmap.o (arch/arm/mm/mmap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mm/mmap.c:77:21: error: call to undeclared function 'huge_page_mask_align'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   77 |                 info.align_mask = huge_page_mask_align(filp);
      |                                   ^
/tmp/kci/linux/arch/arm/mm/mmap.c:77:21: note: did you mean 'huge_page_mask'?
/tmp/kci/linux/include/linux/hugetlb.h:1108:29: note: 'huge_page_mask' declared here
 1108 | static inline unsigned long huge_page_mask(struct hstate *h)
      |                             ^
/tmp/kci/linux/arch/arm/mm/mmap.c:131:21: error: call to undeclared function 'huge_page_mask_align'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  131 |                 info.align_mask = huge_page_mask_align(filp);
      |                                   ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c7de300ea4138aca11b83ceaae1f1143053a5e75
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7bb6899c97e42d33cd49ada817664841dc972f3d

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb1be5b429d354eef1cce

#kernelci issue maestro:c7de300ea4138aca11b83ceaae1f1143053a5e75

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
