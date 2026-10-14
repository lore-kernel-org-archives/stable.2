Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C040330328
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000748; cv=none; b=p/VtPGvLG1xYnYB+0dfqxMMYbE6J3JzTrUBHk5bQNqh52tpCvMzRZVKrDhMQvRaU8wWpMxUlRg3oOZmCI8DatJzkkUm/Wq9IpH05tYor+eVl7F0rB51URtDOloqCZIQsRLaN7vZ2lO29qWdi4tnRzjVYQFBaamYwgRhRi4Yl7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000748; c=relaxed/simple;
	bh=dDN8jp3qMLellO3g51VodaauD87XnJilLrJ9LJSfGRk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lEnMVPuZ+H7Ho9vqBqgV3cHO6pqzFNWT/Ijc8WWrm6AVlM07VgL0gvmntwwO6ej3ZwLT/5eNmL2fOjMqSmlMBr0PuP0iaTJu6BuvcUzjX+7qew2WXIecV9MvnPhZrDwXxF7j7IYZmF93WnAlUZhGMXCkqIV4MCElso1ujxBQgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=b2OU3nxm; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="b2OU3nxm"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-353804b591eso7797942eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792000745; x=1792605545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FZ1+52q+4pExk64UV5D2sSw64rfU+B+tKWJ5oqmR5lI=;
        b=b2OU3nxmT6n5izGWD0/AFddPIlmTlWsVZgcizMjFJX7/6tNvEcfr+WFTu2mxIHfKbp
         kCvYV6EHKq3iYtrSLgz7A09XHt8e0FFEBMbBaEaY3fLNjRErnwCQG1SlyI2agJMj4PkU
         32xNvgkOVeGbUhvD59eIxxVTwOcBbGwMm+TdbkPdcxwGqHPttIYEEahxmKBintP4FqMg
         M3lFKKMbiw+cOfM9tKit8STazY5n3++NzgkHrOmY0sffLsvxDNb83M7ZQrzSwWp/5O1Z
         1sekWzzGaPk3dYlCfAlAEVGNnUzRD+SqKFZYjVQd5dw/S8W4PPeIIL5aVRagoVWv3ehj
         olWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000745; x=1792605545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZ1+52q+4pExk64UV5D2sSw64rfU+B+tKWJ5oqmR5lI=;
        b=ubp+BrVCaE0rcBYRfXsBUcuosD6bGSR7jEfwY8ktWfUWFLJe0iDiB6Wc3wMRd/rz1j
         jbr7di3VYEgeqER+TJ//ZyL2nT4pqqTUuWdju2SUHr34AONzcCvWq9QDL5Lf6N0PHdy8
         kdZRhsxiACX+Y4tHpD3r5Qp4mX8siSSbwDQRhBo8a6d1Ewbrlcr+DZw0TkxHbIT/Bpul
         f01xOoNRbbN59QdwyoHiCbtr4KCMptOhyOEn7QlCJQfxSs1Wwvd8uziT1J+/TKEt9QWZ
         EiAYB5YY1qDCQ+rIn/Rh2nKmM253SGq+IxMCPgJzxhSkVZWEk56gk+3FeO7Wt5XBWXJb
         EpnA==
X-Gm-Message-State: AFq9FYI4rWNFfsK09+FnZY/eaoxHLkzJa9ERQ7hqsVppMPvNkm2f6iIB
	zskTPb3TQw+6MxIN7YIABgAcKdzi+NWw5Vkh1/BZhgp5rzDXOtM/71HmyQTYyAhNx7BeFiQCQfo
	WTlsM
X-Gm-Gg: AYBFou3ibEIpJbN4wliAPNL15J7cuhy1SfcCkYIWwbCkVg6XKEWu+wscPb32wuOH0zz
	X/vRa3B+hPZopqTyx1aQrUFbdA08EnAl9d17EverDM3j9ped6XVA5ZtSEXjp0KtHMCZGieHWq6h
	rVoxmj/ir5ANQaSE60XCj3uzsmzZZKMYLzKHSL/b6RiMObyvmiGxv4DCpgfJ0J8r3lCJQmGqy/2
	VRGI63SRZEA9GnDPak0s6aq2bE9BHQYQ8J1KQ2IKL3Cx8KAd44j74poZU5s8b8cEbMSpcE+L/+z
	VDlCsVmJGV/qi6XaGsBYM0muVLRjtGsU8oXZYTjg+OJ+1EjyeP7QrtIoayCaxGEnAW4xgIXNXU1
	ibHcoFrh9UYppxFoswct6I9u9PJ/FCTKMLNDFXTKZdqCX3gbEvR6UThogeQ1i0rufSP1mb9sS2+
	P53to4RjshT3dsQKrxbieJFbvpVlNGygYlVe73xcYuFxWyRA9lATjHktsejkS+pGk=
X-Received: by 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id 5a478bee46e88-3537e03ce72mr22149842eec.11.1792000744775;
        Wed, 14 Oct 2026 10:59:04 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm60033954eec.10.2026.10.14.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-7.2.y: (build) in
 /tmp/kci/kernel_build/kselftest/drivers/net/psp_responder (../....
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 14 Oct 2026 17:59:04 -0000
Message-ID: <179200074367.321461.11017636013861682093@kernelci.org>

New build issue found on stable-rc/linux-7.2.y:

---
 in /tmp/kci/kernel_build/kselftest/drivers/net/psp_responder (../../lib.mk:225) [logspec:kbuild,kbuild.other]
---

Log excerpt:
=====================================================
make[1]: *** [../../lib.mk:225: /tmp/kci/kernel_build/kselftest/drivers/net/psp_responder] Error 1

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7494089614164d42baca67817d864ba187c52b33
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  62eb344d00f7d30ea338b4a426f7c23a124befc0

# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-aws-ec2-6acf87dda3f195e1aa7fc694/.config
- dashboard: https://d.kernelci.org/build/maestro:6acf87dda3f195e1aa7fc694

#kernelci issue maestro:7494089614164d42baca67817d864ba187c52b33

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
