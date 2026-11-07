Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067150;
	b=qpNYHv1++XuFRXp/5on9LJeMyUSvX4DKhFiO3bSTv8/8eOZAcHzSrzMTIuZVPAq/otJp
	 FHZm8zkJQfSWPWXi8BcJQ+20R1BAOOYdlaIP+B7DFeq1wJ/8xR/JIofwYmqf4oXF42yeC
	 7u3cf/rnJOj+g5PCZgODToiIBogVWT1aw9/KuhxSVhrWzrkjauYb5krUj8TnxGI8NdTeg
	 /kdJv2rJaueFHh61OOJj8TdYH+E4vd3lLEYmzEdG6fhFlRACZ46VcvbkozM/GIcq6vz0t
	 JcV9exvwCpWVr1BAto0c4T9F0kU/ENnbax0yyh7WZmNKsOgbvRbZ+ELjNScHs8y0qGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=cey6nfLCOdKAnZaJDONKhcmCNTeUeG6VMMuNtbwqhoc=;
	b=ahR/yp/wf7hCG+QpgYyCPfXYYyY47MXmUr7oud39eYWzjdIypVy5lHSOhX5ufC5cbCmO
	 l9vGjGPe6viQVUG4XXWgTX9MHiBjLREqDQ+pN6zdGnIQOgsq4pYIsGLt/BGzfNaZ28vaI
	 7jiZqrXJBuKvdWvTiiDsAWt9J+0l1s8eAlIhK8D4QeKiwiWFsgxYGfunZjSWgtzmklW19
	 DjTQtUBTrprBcmm0zI4kMq6bvGf6l9aOzRKm9Ypj0/Vz2UejGE8J154u2ElHR9EPofE0Y
	 CA0O+5nU4JNwEn9frbhqyCYXq9wgOkQwDtHAzx4sSnIJgZ2379wxaQVcA+0Lnd+yhwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=XSG43CXK;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE92E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=XSG43CXK
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1aefd1bf74aso503749c88.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067149; x=1794671949; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cey6nfLCOdKAnZaJDONKhcmCNTeUeG6VMMuNtbwqhoc=;
        b=XSG43CXKLcO6WpifBB9uxGyJx+rzS+P4BsaeCN+zUZDoOUY+VvZSsFAID+aHb156tv
         4ZDA/Us7MxNFBd/RY7eTX4Z/POiiaf/qMun8xQN81YFkvYqnF3RR2lQmWl+rp9SBoCcH
         WkYBtzondMSrk+MY0UFbxqe2Cw6zTPVB1Kew5jP2vZ9aD92rJkOa9zbv9U5jnue6UE9l
         4kV6JMHxtpgLEwtCVh2HnS8+cb4k4v+PwiGJ31tgLUaw0gGcRZR6cIwANBSnkvnMwFxM
         wgBJU4n0gE/HeDnR84UlitUf7kbnqLL9BtPD4Rm+ZSDtYbUwkOwR8mDBI0/lgQ+hRs3g
         wrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067149; x=1794671949;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cey6nfLCOdKAnZaJDONKhcmCNTeUeG6VMMuNtbwqhoc=;
        b=WWgQr1udplduuw/6My1gjGobw+ZBethTuv+kP0Mm9dWwt4E/uGU2f8dCLZzNYHlx0x
         zpDBMxpnTAbyflIdL+KfphIb2aDgu+EzkmjUSGbE6qCy/idyPnIOwX0PZB6pZf6YpbnI
         8VbFcwO1WKPqEsHL1RZEBxgi3powWDGzbzqOPNIZJmrOEGcPqmSYr4+wsmdHesHR5rVc
         1sAvj2Mag2O+sw9nKzQ++lxKkLtFlpk5Fc3kra5IZjjQI4KmZJjUCE4T0JtYakDBU6PG
         QbhZZdN87XTSrZZ+SfzOz/EYIcQnxlZ9nusqHfQAOvZjoY68ZO9Ss+hJFe3MM0KWDKDu
         qnCQ==
X-Gm-Message-State: APuU4Z/gOBVSGvZ0nGoOO4dsUbPVlgFb/EUzKFa9VUtanM1muTeIvuR+
	Sy1l4kFzz8J0NWqr22C0G1lK0UnmzQKkdXx9o858NmBGbOMZ3nRipIonciXxJBULk4GmqII45HR
	RCc8B
X-Gm-Gg: AYBFou3JXt/8lZ+wUtPwd0+lukYcQqzoldJvLZvt9WhSaa2yq28Fn30JhbfxVF5Z4NK
	yza0IqjRQL/G89FBGOLZZxCJkKEGOHeWxvMXQVyqIJ3YIEtzzO3phYtVsZPyRpxCfkQQYX7IZkp
	TSMXYOWwW6HXt3uC53j99YdJDg1Hois9VVi1En3tzl8tDDaDaF6z9nehMX8sgz7x5MbeKaakavb
	v54Sy65Vf3ctwyDJtrWsQKL8xn7Y/0XeFs+zIvnK9df3WfYsSd/V2sxROZCNwclgn2ehH9bEtsz
	QO/lDXtU0GamjBrywyGzD+gbfNAdjtm9WNLhWaaIY0caOmEUAsByRJN+d2hjCKOM0u0BFnMKbRQ
	rsqfBcXHW/Rn8mOgd5K3BHwIOak8visgudwfnLOWwTpPigzuLr6qGEAkVdUQBGaUwcU0BK1i5+D
	11QYa7atpA5intfx5E9CouJAfnlQQgzsMI9keerNe8zGTc48NLz/spLM8Wez1ScIvCZ4Iyb+PIi
	9m6wGAAk1RGmqlz45IsKwIL/QOFAqRfmY7F/7AzWitDqrrmPJPhuOjtqzZrYCK9NWkJk83lkzCb
	qGGJo0NfE7OetG5hBCRMAA==
X-Received: by 2002:a05:7022:295:10b0:1a7:4c5f:57e9 with SMTP id a92af1059eb24-1b269b4baf2mr3133956c88.27.1794067148576;
        Sat, 07 Nov 2026 07:59:08 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4fad14sm13856369c88.22.2026.11.07.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:08 -0800 (PST)
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
 'cfi_get_func_hash'; ISO C99 and later ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:08 -0000
Message-ID: <179406714756.479450.16119286321608414940@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
call to undeclared function 'cfi_get_func_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in arch/arm/mach-imx/pm-imx6.o (arch/arm/mach-imx/pm-imx6.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-imx/pm-imx6.c:589:3: error: call to undeclared function 'cfi_get_func_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  589 |                 cfi_get_func_hash((void *)((uintptr_t)&imx6_suspend & ~1UL));
      |                 ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:3705bc07d5867903c50543a12387dc245e41d68a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  28fb23348c6d391618c8f69ffebd953abd36ea09

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3b755b429d354e117b9d

#kernelci issue maestro:3705bc07d5867903c50543a12387dc245e41d68a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
