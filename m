Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210358;
	b=PjhzxZeCccfKAImx/g146w20WJKJ1SbbLmV5rIJrx9HWPfOvh4uBMBgV99y3Tm8tfLX8
	 KFY3OAVU+VBc4nMMtYTU1YIjqHKgcPCwloKP8ePzVKvdTJEDn1VE2XOFmxdlCIP5qCz2P
	 KKrLePuDz909jWFkAhEPYSct6b5GuzsHn/A9rLskS7qMSrod63dE+UBZdqSJPux+UskiL
	 Am3yuGLWuZuCs3BzCtZlWTaa5Oj6ttO6vlsCqb7TPwnQQNJz7vtMPT6jGr5cMssfpB1J/
	 Hy8g/e+n6KGWGIKBxqOJ9F5RFkUrF1bQ1HP0IXRxFbyO8+ETKfsk/7TIyzNzgMdGF+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Eh9GwoLVMgmNZ62WNytvVSU9PhVgHMPUUYHuzX/DhFs=;
	b=i+tf4kkJgRXg9W1zvG2QJYS/51lpLCFW7IPnMih3s8728IygXsxKAJRw5LFL3oa9YUDI
	 8hPx1Rgr5TSFx8g+jEo1/kaQjvnOAF6fzKxx3yzaB9DKV6bpXtIijAzzBe2dNwI8OH5+h
	 XS6KGrIqHL45ESN3dJ7ONA1UJyuc3IBnDyEzI6V5LCT0BylDKYZZAJ3qv68lCQtLCErEq
	 8R6pT1ufyvKLoKOOAJY5YXG8OVuG0g0oC25CXKPPXd1uRvZy5Qdmn9q6Z4TNoySDKHqAb
	 VSmssoTBA2WTeSuV4v9DACzw92Sy4BLN45T0DwxAFKkARxq6aMiYeXiRyQKppdbWm7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hGa1Vj7h;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47486606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47486606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hGa1Vj7h
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1789828eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210357; x=1793815157; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eh9GwoLVMgmNZ62WNytvVSU9PhVgHMPUUYHuzX/DhFs=;
        b=hGa1Vj7hR9r4F/qhRM6dR47k4qUEF/WrrFO74syjl2qbie1CNeNWfdzKaj6Qe97wEe
         ctcUdGBZkqM/jkbDlCqX8sKigtNMsQfy/D2JMGzryQtuKRWWMHCJ8lprsolMCQSx0W5E
         qBxOqCQQKLwrxkNiRor8MreviVH3W+kSws9zYZF/ZWIcSfNXm/sLFOl8wtqazDc5GEOp
         YMY/Qrbjg0d1K5KvRG5+bdjQVs5+s8ljCFoy5o7bEh/0/GpmLfEEdzPS93mspdo+9NKr
         cGdiSODncL9Mf+HBEfRwSBEMmBh8xqsu/N6rzBdr/XUeuwqCv6mfaulQqXExg799v5HJ
         jZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210357; x=1793815157;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eh9GwoLVMgmNZ62WNytvVSU9PhVgHMPUUYHuzX/DhFs=;
        b=rtISnHe9/xKkMNE7JteWNpXlHe0c4xQhCjbYZgQuilX3LI8ZJmWW6J6vH6ZbxjUW5Y
         9R7739Fbp4eFtC4gqnZQX9G5mj7apIK2rJ1IGY/APPV6tOkWVm3CpTWAu2aVw4SB/0N/
         bEzF+HcnVsoHTQzwNXbKsI2ZNciy6AvCgJjlZYxvgBjwRhpgL2roXdlt7fKRtn19yHkb
         5UFJFukFBrOWqJ0h5Gjb0FX37vEIh6iILOsfCSLdDUc6WFGbbtOyHJLsLfWk5lyOpwSc
         uFuJJp9yUtSvOSdHmBvNIp65lISMNZYwSMeRyOYp7UnmPPWo7jE/gkBHmuPhG8yhMTka
         6KYQ==
X-Gm-Message-State: AFq9FYInSKFU2p1JB9mYACs6CkC/fatRnrTMednAl8/XH4RJS8gli3dD
	nGhEMPMgnInQavVwLaa3yARxTSk73oTPwd9/wp2ctpuEYL48rEUMWjz2eR64sKGfXsFBqkcpp7c
	7I8nz
X-Gm-Gg: AYBFou0sJWRfR0vFxyHgyccGGqxT2mSRNoNeHOVhoGgVJovgvdbm3rWoU+OaqcNlP7R
	v6lu+2lzzKQi/4VA/YbgMcwmRdGL7Fglh+4GbVXBkaevwoczVPNe2bhROCDpgL8LheqlgmHhJ/v
	65kAW2qyjfBdEs/fS2kd8THA7Yo1A+Ds8FMS52YxGf6q+mvrkGUPOUQ3vZDnI1RyUmKPKXvtB2u
	LTK22WCfE3bN4H4IlTz1C+G2huSWvm6n0BtF39zcgoyIc/4337qK7bqJNIjZMdFfjXqsA1+dksZ
	BpiIf4zuAgcc0WiPRQGM/9yMluslE3gWfoFaUn4VRnSA4X3TSiGDFcWahyeuBRkq3NFbB5BjePC
	w94i9ZedGz6qKfBE1jcNgGWpYmQeFFZBVyoK7FKuUJQx6rM2UuX/H9v4duBul/IZpgKSdUvCt97
	IJbUHalgLjsVwiEuZHoTMz+EuijeCtsAK3G8dXZaPrhg1Xc/3HV2YQXnrJTVFSDPQnGIT57y090
	nXZ/ZTDn7Og+ixsvKelJvMqzku0FzXKhgMDTjmkugQZhZPut0kng9yBCvKPYYD93OS6imMQshFT
	mfv4jWDRxHWTHC13LMAgXw==
X-Received: by 2002:a05:7301:5401:b0:36a:1c46:2766 with SMTP id 5a478bee46e88-36a1ff47835mr4552507eec.3.1793210356913;
        Wed, 28 Oct 2026 10:59:16 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm8104848eec.15.2026.10.28.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:15 -0700 (PDT)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)./include/linux/highmem.h:427:7:
 error: call to undeclared function...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:15 -0000
Message-ID: <179321035478.43309.886260693125590668@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
./include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in arch/x86/kernel/asm-offsets.s (arch/x86/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from arch/x86/kernel/asm-offsets.c:13:
In file included from ./include/linux/suspend.h:5:
In file included from ./include/linux/swap.h:9:
In file included from ./include/linux/memcontrol.h:22:
In file included from ./include/linux/writeback.h:13:
In file included from ./include/linux/blk_types.h:10:
In file included from ./include/linux/bvec.h:10:
./include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^
./include/linux/highmem.h:448:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  448 |                 if (folio_test_highmem(folio) &&
      |                     ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:daaa02ead83cf5a16ca22ac85c78d08cd6a7f510
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6ae228b25c0836a8c2f04add/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae228b25c0836a8c2f04add

#kernelci issue maestro:daaa02ead83cf5a16ca22ac85c78d08cd6a7f510

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
