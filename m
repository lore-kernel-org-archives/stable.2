Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067151;
	b=ZAycMZDxa0JuTndvoo6lyv4wzFwQ71lcvDLWmr3VaQHfw3izC/gCyk40gKSaLB3UAy0v
	 SY92OKSDpzBzeofjolotRHBPn84zZ4Ucjj97WkJmpQ1aqxIlG/HIM7ORCsrE4vaoq3oYq
	 q+HDQTV0Ubfic6eb7VsoJDbtxWsjnkIbg6kMgzkAYPl3dQiFZqaQoYgrjmrGxBoZnEtP2
	 Q4NXdt5RxWemCOSX3bx7TmV93I/w7rU4dwthugnt8zGLlyU9+Ja100qT0ILhb9LNnYeuX
	 M1svu4+k67vgFVMbixZBuAJ6SCvyVPNTE6CQdPuopMBtVYN/T/IT88aXBvSN+Ni0wIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=22HCACthy43SeMq8+l//m0m1TIC7T8Xegp6mXuW2GI4=;
	b=Caiiegnlfck7D1EH+nl3DmS2v3Hjk456lUnVntxsU4+zDXRV0GH84KhOUgO2Iyp9ylVW
	 PJEKdgAC2AQHJLLhPf1stY+Xxo0isZlXz5i2nDQ4vTR4r+/pCvlhpq5VsInutXQnHxaKy
	 2OpzkTpNGPA54w4GFagcyOWhW0tZQOu4qGy1jNlYIMTX4SpgX3B8oud4c6gLoOgfZzR6z
	 umcee+9JDKX+SgW3wKHuW1l3bgZvacQ+tXM9aXF0qo5t+MQSlqhxTI2AhBKoT0Jb554Ud
	 FfHIW0Tvc2KA+kcITvL0VmIiLadlgXS0whh6rN0IDOHBzIzio3kEF0mIx7nx82JxEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YefQdyDx;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=YefQdyDx
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a315ed211so663573eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067150; x=1794671950; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=22HCACthy43SeMq8+l//m0m1TIC7T8Xegp6mXuW2GI4=;
        b=YefQdyDx/cobXbnlIwm/D6oULyJZgGFC29MluXlx6qAr1SjY+nv6Ppr7pzkbPIAxeE
         itICnM6f0Zv7ekZ4QDWJ7IS9idSdIoIMe2mim6AT3qKh2zLJ41Xf5oNVceCYf3EJBq/f
         gzAC3MToKlu9l3TxJPRFq8ROi/aC6WswYOyhejm5rvpK8Kmujow5kQOoQb151FS0yHEd
         72x1J1s9YI0hamCRCmkz10fSs2ZSPyf5qlAy3iWzem5rXilSQtbqOK17oDaSDP7nkWZl
         rHPZ4yQUJAHmObhRFHQQia8sLMViTzhdp0f/GsINJcGzbGEO/JjQuiplyfyVCjTt7E5X
         g3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067150; x=1794671950;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22HCACthy43SeMq8+l//m0m1TIC7T8Xegp6mXuW2GI4=;
        b=d/jSYgfdLL0Hpa9KYMe6U5YIzX54DlIff86FmdWZkQ+t2Sofofqfhhmwo+QLA/I15z
         uFRqgjLt/z6y8xsPrETGpqiJuog3+9a7xjZVJjl+QnAiI107WtzJ3kY4DuOYB9SWzuJ3
         gxl1nceAF+7k7VBz5tFHxN5xlX9dlzaBv9aP9mJuVvjWo0wEB6lMJ7PMSOHxx1D7CXwJ
         OLi1y3fbXKcwcxvPWo/3Rfudk+af+jqWndjCc561MAf5z+YPsGJ5TmeWvk0aE9qYKtdp
         c6oFDlFL6p9q78poxfln7RTiGzmiCSvdBQPiyLcufJjatXGbIjhQsC56SjjW5UeAPpZ1
         XIjw==
X-Gm-Message-State: APuU4Z/NL5vHCHYLtKmQkGmOJHYovXUJviRqGUoO89rZo8XZxno573B1
	Ep/9WNXpm1oTEuU+FnaSji5T6dm5BLrB92GQ3zRYT83AkN6Rcn1wJJLNtpDxXBVcW2Y=
X-Gm-Gg: AYBFou3adZCqepl2TWITmuFzHCEASgWLS8H3i2OGZ4RWq1umPmPfxQ3qMbHU5R/HaLV
	LzrwRcPS86E/we7nJV2TGXUyYl6nsALPMJM+S0KDi1WgjsT/UpzFuWU6RPzH+zgeRS414dGEdIS
	APlqhmCMB42vf8NdyPwonIT/ijyHP9SnPKOKF+hJyVN872IaOqII/dyQ2pqXaRtY/SHCXT4awPC
	xD+et0Tshr/DUcO+fSJ55bT3bxdnP/L9r1w+eEELkveeJZgIgkMJQOoD+gfDEchM/5UsAERRP3v
	0ysP3Gx6LRZsIf6QF+OH8fcpCJjpu+YSaB7lzNXTTWspsy89kXHNDiek/LUg+/UQnrQ4OVq9voB
	ltSYPS41SLzXHMDzKIqr6/FHF1ctWKSdBMHYdBEs3L0ippqhNdhNP3LEVYbHPXT4dbBNwDdJao5
	ED6f3hl43twyGaKvX2HaZrgnvYcv4rlr+UrFRKyO7Z7Tm1p4rPHbRtxhziuzT/nTpfvRMtHrOpe
	qxd6y3YfmiLqrt7A+OCzZ/gFUec0I8nTYF+ft6QID55esHiIMb+6bE5l3FN3xmZkaTvuKYsRmF0
	bBCcsVuDU9RutXZJRfyUqg==
X-Received: by 2002:a05:693c:808f:b0:36e:ca05:8c3c with SMTP id 5a478bee46e88-370f418a6aemr4187522eec.2.1794067149881;
        Sat, 07 Nov 2026 07:59:09 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8d44a5fsm15925397eec.7.2026.11.07.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:09 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)'linux/cfi_types.h' file
 not found
 in arch/arm/mach-imx/suspend-imx...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:09 -0000
Message-ID: <179406714889.479450.15372800726014561999@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
'linux/cfi_types.h' file not found in arch/arm/mach-imx/suspend-imx6.o (arch/arm/mach-imx/suspend-imx6.S) [logspec:kbuild,kbuild.compiler.fatal error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-imx/suspend-imx6.S:6:10: fatal error: 'linux/cfi_types.h' file not found
    6 | #include <linux/cfi_types.h>
      |          ^~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:afd9da9f560bb3db7b04129db18d5680c9f8a956
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  59e2b400009b8e4dddb59189d3ce116e3c0fb6f7

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef39535b429d354e114f88

#kernelci issue maestro:afd9da9f560bb3db7b04129db18d5680c9f8a956

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
