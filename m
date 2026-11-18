Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006747;
	b=bIOMZCaNQye4KoefzCTsEQWwZE9mPCLd57ixwvcwer30DTtxMCKveDulEI5lEZmj2hB/
	 4QuWYWmWi3Q42gGVnTkj+IiqPwbvyxKvOROs7R7bvfFDs1Ml4EtACgwlKTgZiiPyiUJjg
	 lZZFL1vuu74yYhMZR+BBRtZCbbnAumYeY+jjev3shY6nq1JjTmSiXAae6BBVtc97DOBvO
	 1cMxu3msy3+eOLXS9rVr7oLkPJLYwlXoY2u2Ty5sq/umSwxkLNefYJjBgiVneiWMxNYDY
	 q62mGupsvC3n84UKdQt4WywPQmNXj60DGTz1ZduURmoNQs49ND2d73YvKlqDJnZr28g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=El/VOljsF2+reviuUtI5R9/x67W8cZrHrfGcB+6rInY=;
	b=3HPWP9YR9lfOqbckapOF9auOAIW7AKTISw1equhB0uagllL0v9MyH5jnusydX5MSPIdx
	 jCZZo8XkvJUJOKvw5dDis/LQuKhG3KosSeyXkJ6PayniMznqo4R+kKUOT3JFk0wmpUfDi
	 H2PqQyahHUw+EYs9U8jxpwvHPupPk04QZOL8SLkYOlsy+sByelaphfwqq73ETl13rl7E0
	 zi7epu19m528ReKxLfEz4YwYaTLZRHZn8THsOB8MYKLM+lfTUqlURGWHdaLx3QdAdniuZ
	 yY+OJWrt8hN7qVycVVMnfM4kvak4o84Caxe/kZceo5iAUup5989p21Ui2XX3/ZgGd7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=iygFO5AX;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5187606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5187606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=iygFO5AX
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3704d30b84fso1428694eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006746; x=1795611546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=El/VOljsF2+reviuUtI5R9/x67W8cZrHrfGcB+6rInY=;
        b=iygFO5AXBNJGNugOuAOoBPTKWcjnVC1CPcXjKsiAnuusE22YWmlEuuNcDFrdbDEjW1
         o3jviqDv5XX9D9x5UbQkoeXA4S7gAI7ZonZcqHewlGqHQ66CgYQPzIXio2tdtaygGMSx
         ymvB53p4YzHWcnpvowrZsVX4rXuNwZ2l0tZH9S5pRDtTpAWO34uoAb1Wds81jxw7QCnx
         q6JMFkob/xN/eHjlZd4xLKgrFd4TRNXBkyFAwzAkYphXYrE8i8hKGdR83WANMXgrNnAv
         hJYzXZOrV9qpb1+xS6bmYkykAEh2zHsMiVaf5MghqQdGFmxTPC4USBK7d6FZmSRLDeGg
         HL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006746; x=1795611546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=El/VOljsF2+reviuUtI5R9/x67W8cZrHrfGcB+6rInY=;
        b=qZfq0BYm2DcTm3D2tX2NPfnr01XKVDBSXv/tbq9Jc6jHv2HFVG1V4+df0DJiptT7UF
         27Cpw8Q15CxcF0jMLDYGZmJfVU5jfuQjOoa3DEt5Y9QtTT33rhILkIFMJiL5eJonwKhZ
         xWYXtUp6doiGk2WC836bYJ84Eu3E5U/5EWwa2977Uji0ZMWVMwacPev4yhCQwgKmk+mL
         BxquS5yjGTZ7ivbMd0TJ0b7ed1GJ+ew1VPWVNuwCW71VXzE3RnZTfOL4bQ14OO6XzJBZ
         5UfhP/I932ferqI7Q2IILq+m8gHWhxGOLo3tKzJKPb9KoAIZLIpNCu2qXH+h9IWcfeyo
         Ux+A==
X-Gm-Message-State: APuU4Z81Ul/jWXJ3Qrn6rEaZb//kR/jLXkn5W4JFq1RlI2gKIfm0AnOs
	npS7wu4oC/zKJNDGuinhXVAxYfQanfy6cAxgQl7FFtQkCWso8EJoGgFSs0q6SVuWQGJ7npkL2x/
	HPlrV
X-Gm-Gg: AYBFou2qcKyW/s5553+MOA2/AnUDiMBdmk3KudarhD2AMreCnfJ/iy/GGLVNF+sfdRW
	fnW1L7vGPJYmORga7Jr+Fnh/J5p3SnoFXv9opTU3ZYtI+3I7gAhy5Jr+ZYoeVuCM4F/KkDJNTPT
	Nxuo5w37Oiy+scShOqTIY+7vnllJ4866TZxxL5SRJba5D6OKq0yL1KVPAJrtFLN7LMfGABfa6gp
	b5vuzgmR7+PWmPBXtYWJEyJZXLL0B092SGH+4kf58V3dWeRTBPq8BfqCUAxTlPiESzG9aVt+E+B
	JGejFgEngT5cmWCnnNCHBIhv1b8NTJ+1jKl3LUXNHyUmMFgxf+vOhLj1llssqlzybaKHJH2LH2G
	dsm11U7JF3oLHuGtyVPOKFlM+xI7tGHdGNFj2pLte565tGyEHLgcYK7dqgj62x5GK+2JddBF9Xm
	+TM5GsAxplGTqBQ+cTkuHFLQCzMpaIawc51Cx1OdvFFYaprcHm2CYXJTE/bMz19fwqxxksYPSdQ
	OKfjXT1h3KXX4By8TLXYtFzfR2fuhirQuaT1EoO6WQ5fgf4dUJ1YWlPyGPb+eKITdtEBDO5vWqY
	q6Gd4c9j5b9qlnvfJ9BGmQ==
X-Received: by 2002:a05:7301:18aa:b0:36f:2e77:93e2 with SMTP id 5a478bee46e88-38281523ed6mr2547748eec.28.1795006745789;
        Wed, 18 Nov 2026 04:59:05 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm8391222eec.26.2026.11.18.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:05 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)call to undeclared
 function
 '__pud_trans_huge_lock'; ISO C99 and la...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:05 -0000
Message-ID: <179500674480.301701.16006047430964497620@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
call to undeclared function '__pud_trans_huge_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in mm/mremap.o (mm/mremap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/mm/mremap.c:363:12: error: call to undeclared function '__pud_trans_huge_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  363 |         old_ptl = __pud_trans_huge_lock(old_pud, vma);
      |                   ^
/tmp/kci/linux/mm/mremap.c:363:12: note: did you mean 'pud_trans_huge_lock'?
/tmp/kci/linux/include/linux/huge_mm.h:438:27: note: 'pud_trans_huge_lock' declared here
  438 | static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
      |                           ^
/tmp/kci/linux/mm/mremap.c:363:10: error: incompatible integer to pointer conversion assigning to 'spinlock_t *' (aka 'struct spinlock *') from 'int' [-Wint-conversion]
  363 |         old_ptl = __pud_trans_huge_lock(old_pud, vma);
      |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:f677a268f84a47eb49c916bb1562bfd66ef61f00
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4bb8d342a2c791584ece3d8430e5c03eecf3b3bb

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd907c99c74e1a997d36c5

#kernelci issue maestro:f677a268f84a47eb49c916bb1562bfd66ef61f00

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
