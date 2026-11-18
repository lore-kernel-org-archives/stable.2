Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006756;
	b=wzGxphm3YlkiX15to58ftzb6TIz+fBD3Jz9XRIeR7hDJM13Xb0rjHizR/DwfLbmqRTqf
	 K5fu0Sv4RBGjTDj0Sm9pX64PVhoxqxxozkblMXf7UtATRhuQWb7wlh52o4Wkcc31C1ZBB
	 FW+Q9RfQNgtQe4/0WJVVDtoZMocgD32fVksKGPLVHYPNo/BpyGSatIDFSDcwkhX+1dnhn
	 DuTjLMYXmwCveDZkFOW0Izw+DmsqNHAuZPly5rlRxwXV8bfvJde4z7yeiO+OpQ6tSd//s
	 s5f6xoEHaJU0xLgrhE54HOzSK0+5AMGNRfLs9Y9CJ8Ki9xvUuiCrIfs2xR4UY/keuYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=P2gsSzTP0M+z6DVozcyhK7p5Em33xfk0F2ygHRRRaRo=;
	b=NpYvMUoJoYn96E0H62A+WnAra6UVKr6TxJA9dvRjDcKAPNKhaWqQmpfJs8coAXEsWnN9
	 q5BQ2jFVJmf2xeVLGj3kuAkxebmOCvIOaoecK6WPSxja9WIzUjg+Qr1AKehhKxc7HGe7v
	 gcZSnugCBzfXLRq97A1WF8hDwz2PQDJEB7dhUG4zVB07ti4M43zsadlvNi5EA4paSlJ9y
	 Y1vbLtacL1jCyrVgk0n2Ncd74h7MsEYeSHihRByGlNo5pRcS1YXN86iNRWloezIJ1xhV3
	 OqINC4LyImCN07QMqguOpLtAJpelLSsyz9Y7oq7DQBncF5DStTb4vhui89R+DHBdMoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PlpnYoqo;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726B606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D726B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=PlpnYoqo
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-381f65e4e4bso1553857eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795006755; x=1795611555; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P2gsSzTP0M+z6DVozcyhK7p5Em33xfk0F2ygHRRRaRo=;
        b=PlpnYoqo9XkyXXPt25QgMXV/+Zp4KksJgeTq5wydiwP7vUxRGHAmbBrjBBSheExlnL
         +R7czU0wfL/L5ee7TEparUZPCmDZUZ0toFSdgBNcwI7oI91Ul99t8aZYIHGFBcM/ghHE
         dwtZKAcsI/XCNZg++1ZaA2ztR4xmmVFi9CzhfFmg5P7kOM0rNuDdLUYvmfxoxIwX3UbH
         eAhkzudsw3j71z4bBVN9074eHNHJn6gWzyrr4AZxImIpzcVCOJOPEk55prdn6sm1lEUk
         sQgPzBvm8XpTduNLD8aobO2apZ5auOYa6EfA+3KarctpnA4e+tAP5vmzPd1c1yeVo5jS
         8h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006755; x=1795611555;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2gsSzTP0M+z6DVozcyhK7p5Em33xfk0F2ygHRRRaRo=;
        b=Ie1+uvDPqSCj6mK/NfmwJEghdVLej87mAP4gAw9cZDqBqDcBnCCAFS3vzcM2tTDBWw
         kiqUkHpRpBf1rWc8Ebprioqxr1etz0XLcf1nlaGJcYmcjkepSLnVycXVA8goP10Mw/nW
         48LEVgkEgK3kVggzkEqevGGCDNm7tH/eN6N0u6rUpiy2Ehzg2j32v6qxA5sQXXZjvyGq
         371XXA4Rn1O0jzpEPg7oek2Nek2OR3T8tIrpSVQAfpu8dArQDMkTln5cNzJu0gckY7Sc
         F5UMbNNyt9e46jVCkTRdNgZ5TFZV03G0WDvwJIOJK9u8ww+5rml3VihTtxl5wpKuJIcp
         9AWA==
X-Gm-Message-State: APuU4Z9ImhR6TqD3LwTFEvwwdPu9ZffQlSpvWEX0tN4IAUWbf7sLduDH
	35zR3DBOsNJ8bwWF5rWKmKy8Bt07CVQYnCx6gnzgDtzZTEUig8ldJPuZqawWx7kCSj0=
X-Gm-Gg: AZFdTZepcGYQiUOemsr0f2XHTaHmOtVPiJqzSAL6JDQG0vquUKH9ht2Kn2BTGZDNXTi
	3YYh3YCVZwLy6PWqgf2itrhirk0UadnyzlqWUXYm8Er01Q6a9bcMYYyRZQKysMClLLUOYfqL7o6
	Z/AoMDWtqs+PCK7Yn48DK6qDRoiMbpsDz/m1Nrx46HpsKlnxIDlAg1HFL/tHfEdP9QphxWRl+2b
	6BNs2/iYDm1ySx4bnW8GUPh28oYsWxfikHGe7UH8/UlYekR9FI46cXANemYML6PrX2SXsoy2ihG
	gAyYf5dfR3+oybF4VBGVXtyOYm6U4A849j/e9pPoHAnGuZQZtPVXBMuhmtRgsq2IZiHZOSEgOqC
	XBRi3EJT1FFpodnKzTGC9eyTKeYzhh5vi7eSHTN3SrVaOJdeO7PHR6tEaxuJu3eMxi+PhDLdTcv
	PXIfuuT+OnGjswlalcWDPEIcy7x+ApchcNpXIqJelnRQ8myjp78n/atVN0dj5OCPN4mYV3l857W
	L/6LUtZULIr+7OgpfybY/usOWT5UE+pswt/NiFAvMBGwuRDSMmu4KS9DWrL7ZgUmCtgntI+hWwW
	fsmffOKy4QhkHgsHuLeu1A==
X-Received: by 2002:a05:7301:6184:20b0:36c:a44c:1763 with SMTP id 5a478bee46e88-38281813f4emr2402311eec.32.1795006754619;
        Wed, 18 Nov 2026 04:59:14 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a80bc19bsm8000194eec.29.2026.11.18.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:59:14 -0800 (PST)
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
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29too_few_?=
 =?utf-8?q?arguments_to_function_=E2=80=98pm=5Fruntime=5Fget=5Fif=5Factive?=
 =?utf-8?q?=E2=80=99=3B_expected_=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 12:59:14 -0000
Message-ID: <179500675375.301701.14361608225648550407@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1681:15: error: too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1
 1681 |         ret = pm_runtime_get_if_active(base->dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/kci/linux/drivers/dma/ste_dma40.c:19:
/tmp/kci/linux/include/linux/pm_runtime.h:56:12: note: declared here
   56 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c: In function ‘d40_hw_detect_init’:
/tmp/kci/linux/drivers/dma/ste_dma40.c:3292:32: error: returning ‘int’ from a function with return type ‘struct d40_base *’ makes pointer from integer without a cast [-Wint-conversion]
 3292 |                         return -EINVAL;
      |                                ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5b534abc7eeadf259c2832224cebbbe21bd79523
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4bb8d342a2c791584ece3d8430e5c03eecf3b3bb

# Builds where the incident occurred:

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd909999c74e1a997d36e0

#kernelci issue maestro:5b534abc7eeadf259c2832224cebbbe21bd79523

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
