Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778357;
	b=PeQmL1WMNpKLLO0g149f44r7uFcjAA5lJHtupiu7Td4DaryCUbtZiFvs32MKzP8zTQXm
	 EzxbFamt/kJaj1X0r8drVsov3tR8jnnC/nx3DBYZ+DXAVVpG1wJt6mU7JmtTKK/dEaVTb
	 uLlxH7DczqYtbooX1CVP4/luJY185+80K0I53ManAIsGDeqknrhr8vDoGx5bD2u2Xbw/+
	 i4XJBLWB3ve1b98HZ3yd6l79N6liuw5sG4vP/ZfofM24aeRPoaw+Xntt34bbfn5EPrXRQ
	 5YBU7G3QseM7s95bx/Q5BbjSNMZVnDT2MM/3kwzwFEj4G/LZSXHYVXtY3VofXMy23FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=bd4ugjmENOyTcW3WYaRAEqoCVOetS2ZHEk++XfzrrNg=;
	b=DmmVe8/RfWa12272u0AtArHLTSnT3TyiGyOwlus+OjyBsV6SUpbXVonuSnGZEG7NudYj
	 jHVzFcvnfz4AL5npWP8fTgXOQkCKMts3Ggm9hP5J11ZDkVynRVhF35bCBBT5UmSm+kHfk
	 NMPi+JVACmABZpU0ierpOZj/M/b4jsFOthBtme9d18PVtO2Fp/4xztAHuMHBx9j8OqiUI
	 sutNIyc26s3RCjYt8aZEHVfdKSnO8N4l6nCtJyf+v8x/eEnZmQBDJa/UJo+0E1Qisgdjg
	 XLz7ECSEh6hNigbj+5yPR08k6ow2ibrWJpONLg/rMgPkr2LU7y5+VPJjuTzI1diVVkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=FKa1y6EC;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569A606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9569A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=FKa1y6EC
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59524so706063c88.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792778355; x=1793383155; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bd4ugjmENOyTcW3WYaRAEqoCVOetS2ZHEk++XfzrrNg=;
        b=FKa1y6EC4OFf86M3xxfJ2wZ7dk3rIArUNrXU/6Hh2ksnlmmT/+nAifyfk6qVljwEP+
         Gpee6SXigECaWLgZzkKJyHpDaXuII3KuZqN2FIGjJLBp3gDNtgQRFs0AA4opmQEbJ4mN
         C0909444iFHGhz7dyTMzK381XX9niURfEH6jHvVNhSaIqI40l4YQzaxiylj8tfp8uH8l
         xDMO/qkbV4tbyq0TmDJmvZSwXxezwIMafU927sD+4lnhegv6+uB1aWwepCQkh/7f0yeN
         Ay8OEkP+4XLqKlybsNDHu1f3B40Ct8SQxTtKfmxU0pdxnGdT8qsPxvvH7W3RIQuBxIbL
         Gfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778355; x=1793383155;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bd4ugjmENOyTcW3WYaRAEqoCVOetS2ZHEk++XfzrrNg=;
        b=ZwVEnpIxiy6kakMARL+lNHqKLAL4l5OcbWS5Hqcd5xpWV9vxYayM+39YKHbNMrOlDY
         1D1g2jDqlK9dBgEwX7yf1eI0V3Um+ZdN1K70ttypDVW+us8EId/YXodroGXRgD8Pqser
         v/w0uxrFQ3PrGmx7QwleUCaJKGdnDc9MKLWhX4fVrurbheBZ8w05LXE3zQw8zEdk5Ltu
         NqKdLD1aeLHvS4/S/tAXlBe1vaPQH+cBXeWvvBexSOhuYn9ZpjS9m53ffixLdmEypP/8
         +goa/zv7WQIvs+7SRtBBkBYgiAWSHR0Psv3/vqrjg7LA1w7v/RhzluH0WMHbu3v8WMTg
         ndwQ==
X-Gm-Message-State: AFq9FYIHyNGm8MOMHkMl/O6u5idtkR6j3zqN6o/uLtB5wnqb22QIuvau
	Q6BWjvBzfrzMyZqNj1/A+l37TB3+8qAWV18KQKtxejurLx9CFcaF2vwMR9T+s0RaxdQ79SNYyVx
	/eEZR
X-Gm-Gg: AYBFou0Xm0cdpU747Pze2LDk4muovUN9X6tWkp6ythVObXz9iI7dikQj8+aKKNWg1QA
	AHSzlhbCYX0nsD0kjcABpLZK86wLzLq22+dk08MWbC0s798AoI0hzZEn7yw3NkeW/5S5RAGf9bc
	DRj+i4cCzD4LiIutCwWvXIHtwBd1XcEtFabQlGFVNf/Y6WKhA4KYQYHfls6qQ/2eyvzUhWrW2ET
	rGG7ZgY3vHje6CUfcJZhYH7fM8YZL0lW/iPlDnUPKwEzNTCB7wfkdmxm+W2m4Cu0T+WQt2w4eEo
	sEcT2jyCMmEE+TC+0qJAAm0xzqo4fY2trkRYjJIWzUkna5sIgldTYZkiom3cO/dAhVhNZgJJtYg
	uGqLaj0sSNdG+AeUXt8SkopwNWUVXMHTwL8StViTdB8q9Ub7d/9ZOZkvaP3ZnrLQuj3g1HwyOGv
	H7mk5i3Xsdtb+oyUfbql2RGO7I17Y9HpoH8+8eh0LqzEiDtdfr0jd9VRpkvpqHqnRw6uarIn5sc
	FW+81AbonJKlqau+QK+DFr+5HiT5SnQya/LYhTt/7xHMdNs
X-Received: by 2002:a05:7022:b056:10b0:151:ece6:b171 with SMTP id a92af1059eb24-195c5f9ac18mr4176314c88.14.1792778355304;
        Fri, 23 Oct 2026 10:59:15 -0700 (PDT)
Received: from 6e52bff8000c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a277b26csm129733c88.18.2026.10.23.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:06 -0700 (PDT)
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
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)call to undeclared
 function
 '__resource_contains_unbound'; ISO C99 ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 23 Oct 2026 17:59:06 -0000
Message-ID: <179277834510.362500.8436103034256439420@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
call to undeclared function '__resource_contains_unbound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/acpi/acpi_platform.o (drivers/acpi/acpi_platform.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/acpi/acpi_platform.c:92:7: error: call to undeclared function '__resource_contains_unbound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   92 |                 if (__resource_contains_unbound(res, new_res) ||
      |                     ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c5609e2d835fd7d740afce78b6bf9f016fd13125
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  df222b43007251fa44d69b6294830e4a3f9289c2

# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6adb8f5355fda507607446be

#kernelci issue maestro:c5609e2d835fd7d740afce78b6bf9f016fd13125

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
