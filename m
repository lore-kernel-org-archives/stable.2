Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891E4A68AC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145968; cv=none; b=kRq48Oc3JZv+evHB20bJmmLFSEKg2iUk8lVFZhs3KtvzYMSt6qpfQjB2ZmFZwdfv31FtLeEvmsIn6X5mik1KENcj0RQOFvrWJRl5RI5asC9q1Zwvp84y9Q4MFW1cD36z9nGUjyACa6FK+UH5ljabSyhvGJG7/rK6n0oK19mUX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145968; c=relaxed/simple;
	bh=I2bKxYA16B9Jxv2KbPTyP2I3k2smMe0cL0l7GZLhfvU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ejoo2LySBN69BTKTRIoeOvLFZrQvbG2XcU6wSmWmQHZRx6ksszULM2JbZim+RUE06YY4sq09zj9B4DjRknpddHBFm+AQLljZpKYpNqJetUSk4iczfs7u/YBzOq16yboXpTeZx6khNJ8ORo/vt8AcnoeW57pGLsqAXRnp+9wYEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=G8RjOE1o; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="G8RjOE1o"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-801a52aa540so763362a34.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789145947; x=1789750747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JdM/q7Pwh0lmDEF5I1QfV9BS5h/OmnlJrfA959kkwi4=;
        b=G8RjOE1okEqwKI/cOE2M+EVit9zGaq4KH/oj27V3eXSu9V5bsoS9TDHRMwviRWaPDW
         +ICtlQMrGmmOYZyF5ffj2uKlkXLrcnubUo2VbMIY0iN2mI+nDz/A1j2yxkAcj8nezyfu
         NjslahRcRULTV6h42rfy+9kXSr14doY31iHAqONLxzQ2L//Yvz8XFW1DDnh/fzC6yPX8
         H2jvoH8Dk0I9Ty9MRHarkTxwXGTzi/yUxh1UJ6EqaPXJeds2hpNPwQVRiA77lxE5+6py
         egXOTNqpiH37Dwt08HSTRarukMCE/yiOezxKehQDhgELzGLSa2pEFOzb/m4+qPG5ahUT
         W4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145947; x=1789750747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JdM/q7Pwh0lmDEF5I1QfV9BS5h/OmnlJrfA959kkwi4=;
        b=cPq5B9pgEa6Lt5DBIm7EGUFSMMYFwjHK396QRqggjXM28F9UyeloqIZ4GWtuaTffVb
         A+dVdt1657T79XWWnH6+krUO2Jx1aKU7yNYHEyTP3rMkJNm5Brf2GtY29PvWQunJMOt0
         SVFRr8th4y0DeYHsdP2osppCKasilh7FXPKgaQ/UNxQJN44Cn21gNaUc1Oaa90s+63bA
         K0nkqINXf/4m/zD8CCAGjhDBZD1pC118NwUnh69CMbYLTY1rwME/d7Cf6O6NcqMUdHtX
         QCUcxHT2VaTZTqLtMZavpTUcrNQYOCoo5I9ln1eyWxGQ04hD8ktDMAq7VNgz9LmUxajf
         h/sA==
X-Gm-Message-State: AFuF++ki2OyFli7fhelvxr7+WdfhJ4+6zFxpCwr9KbVChg/JMuX6+4Z+
	fxynnVPIO7NYATYXRLOnbpZjnQoUFURTTGvJs0gaYsCoa5mq01Kh7nJ0ysuCGZeCAaw=
X-Gm-Gg: AYBFou3gS0F1o9/egBEhojaIPE5oBzKJqm6S23Uv4Mgrdk+b9ep6qYhu/7+OnWThIHn
	8ENyWpUugcQZG8mTlYql3Cc7InEsXbcJ201jP/O/sD4B481fid1w1ITaggEg3zHkRyYZnk0dvBA
	dsx6ogXSRAxQvO8TWKXupN6FoTd1FeZwWoh5VpPRvsHYilO1Vx9pzxyw1qYzH/U9M22NeVgJSkt
	ketoPHl/f9pyCo525SVsxwTadaZ1/l40iDjI0aRps1Txv5oP+BJ4s2OVa0hNEzemNBPYk226c95
	fSGZI+98R7a1jQ7HLUVgb6vCc3SgdI2mEv+zZZvABcg+FsQqhdNY0aXnMYte2v/vDvNdJVnqh0p
	scqrG9jgmVGTIsexfCuwO7okO/DAMsbrOiisRC5tQmtBuniYbCazunfGqSYKIvTgJ74bvy1Qetl
	WoNsQxSHJTql7kfJ3aY2LfbclbIFQ8W7RLkusk8bls6Mahiy6sPZrPiWcaP1zgpNo=
X-Received: by 2002:a05:6830:83b7:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-803fda8ecbcmr4002177a34.12.1789145947196;
        Fri, 11 Sep 2026 09:59:07 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f670eeccsm3018119a34.21.2026.09.11.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)Error in
 security/integrity/secure_boot.o (scripts/Makefile.build:2...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 16:59:06 -0000
Message-ID: <178914594609.4423.15632373316886328999@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
Error in security/integrity/secure_boot.o (scripts/Makefile.build:229) [logspec:kbuild,kbuild.compiler]
---

Log excerpt:
=====================================================
security/integrity/secure_boot.o: failed

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:d88fb4bb506aa7dccda71589c7bd17de4e935f0d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6aa40d2820239ade9022b02a/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40d2820239ade9022b02a

#kernelci issue maestro:d88fb4bb506aa7dccda71589c7bd17de4e935f0d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
