Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793507;
	b=YlnUVd2kHLrjKZKTfqTV8AD5/J2hn1xcctu7S4iI9T9hvhfHcnAd9J2gGbI6Xl4jG54+
	 wwWqqaXDmfbK/ppzTrNufqc45rRqZEgH2rU5AE9vtYtdc3siUt3VXVlK4w9zGX9QTJkp8
	 rQjb5PNMKJAJ+1XUIbrmBkmfjSm70ZJVxFdQk8r97f9qQmvfjOrilEHRm7XgxOzFwwuUS
	 En7fP0yGSrMF2uV2E6yHVzoa0DIB4V2La1Fe7d3ff5PQOfsgyZyNDIrahNHuNEueD/e6j
	 CTUAClq7104AX1qkfd3ADtfvY+S26Jr+/1YZZ6ca7kYk6Yxs37s/lRqXRB0UQDpa8Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Dshu9qpsSYZT8eeZu5f7BohnpZTCm94WxOmlyxYqBw4=;
	b=I8Bur+r0sUgDbB7RFavcKQBXDWV0Yz26UCXdUr/q6ov8DmHcbJ2e7mZZ4FZyz3QOIw5y
	 HrQ60Bzx9Se1/7NfOf56NeEcv1xd3ibHPJ++K3ZBRpTjeK6Y7KLDuDIsd3BhxwVyGHRsJ
	 +JBJ/0Q8wgniKqr1u78U+WqT2u+or2C+9sdVCgDMkd0gekwH+vgF4lojKqH9D/Gb61ux/
	 o8pK1+tJJOeWmdiXL3B7K4b38GKStN9/WJcEGk6B1imTmeIG+FpcpUtcp7zHOFFlufgow
	 jCl2laKErUIuGC7eb7YvGZeOGwYuXWtx1KH4B1v2mYK7ljkk5tGgF/efK5twE6ptf6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=F6ZnNRVq;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DD606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4DD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=F6ZnNRVq
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so1317480666b.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795793505; x=1796398305; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dshu9qpsSYZT8eeZu5f7BohnpZTCm94WxOmlyxYqBw4=;
        b=F6ZnNRVqDGTECciKiDCDIAWMxXi1N4hcgxPuymBaA/ONudxEZG9zZIDTL7R0QWvI+u
         RYjUFrhj61yzRH/IY2rcalkEERkppdmZGI1v/bUBdvjkNKOcsTfMwz254d1ngYAN0h94
         nghXJiJdIRfwa6/R6Gko8RZGPVP+I9dOp0uHD6EwdfBlNw0H9komWaHm4wQO8ZfwEnwB
         EhAO0esOgXV0AChigTknixTxZdKXj1qtpwTZKUkrHpzgTeep1FrhUg8afq8Rk+JtBvCA
         Y+F8vm7JrTAehXtdtzDEUvBAcudvUsYxuUOZqgp36VCuljAzCpxo3yuEqiW0u+z7oGmn
         UIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793505; x=1796398305;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dshu9qpsSYZT8eeZu5f7BohnpZTCm94WxOmlyxYqBw4=;
        b=bIsdF6Q5l0d6hpIkOWKlFu9PufuJqjo/+KkF0wxgOWateLfFOzx/6CynpTyrgFclzP
         YFW5wCvdu0sPZTLuhwecsL022KTNnULuqT823XOvK1D+TxYyv73AT4mPt5c35sDwJ9XQ
         LhEiaJUlZY4h7ZI3lH/oQNy1gpdt5kmGNHlCPqlBXSP8LsTOhh+MeEYsxDaQycPjB7Nk
         uQTnWdtRFZaHVam70A3fTei/Qva1P3lKFRDVVhW/L1KyjTToo/t2YfUFEU/oGq0kh6Cc
         1kCCKmRxuIQmu6vosnrkcvwEWPV9XwfBNU6XwsFNXt5KCXxnD+YqN0OnLlnbwwP4aNu+
         MhUA==
X-Forwarded-Encrypted: i=1; AL+hErGUPQYQqeyS3ZiPsg7A6+9NTFUO2d0jM1GMYe3AYnWU2eeAToHZOuaSKLIYelohTFE4KYRVnJw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IpTx2F3LJqJyN5kdGD0iqmCzI8ymMdrPZOGY3R3Dr4H9BtQyC
	QNn6c/jxxOFvM8hX/+h6xlZoR15iN70661SNX2hQNhQAEiRbCzRyvcITonnDBk1L1NU=
X-Gm-Gg: AZFdTZewro54axsE1Va1ktzHBoS0Xn8xKjPcVPsnffwEhP9kObPpaoZXg4d1ieMCvjD
	GkSGRkq+ZJGXZF/MQLJMiIfYAozqGjiXThIpdNMS4UAxmtOiXbz3y/pqQdy25L4wlUFMFn206qw
	+/i48/nKUxEbxoU38gNNHYjSnu5pIchH01qau3aolZ+bQ6t6BCZRfCIjedqocTEVW+Y1uZxVvas
	z8aAR203TtJCKaG2VaImo8xC+x6d+xR55T7uYU5uv780OD3csmnTQhIHRYU2REanV7YvrPBaEm7
	4i3d30XdWv4rKJQtpMs//inSJbItdxO5oqkHlDWImKsAQYiKo7aSXiKQzywRVUgpkEY2H6OspX9
	KOWxQc1cs5IhpSDIHQRbUNHWZc3NKQvammHbqwj7pGxkMiN6Tyx1zSagy3R892+vP+SnH6ZIkXM
	amynm+1K71QRbr0uXBiN4TCXUxHmJcD47H235blNswHDJcgE6uB4Er+h1mvI0D67PEhJO/EuFl7
	4zPu83R8tYLIAzXSl19gJbeQWaecrzwZoJJ1zQKGZCZekAryr0rAspW9Xn65OvVZOfMDbGcHv9t
	P0DEv3zJ1lZSarogA5o=
X-Received: by 2002:a17:907:9584:b0:c34:e9fe:82ed with SMTP id a640c23a62f3a-c513a88223amr1963994966b.28.1795793505180;
        Fri, 27 Nov 2026 07:31:45 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3882sm47092498f8f.49.2026.11.27.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:31:44 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Subject: [PATCH 0/3] KVM: arm64: nv: Fix AT emulation for nested
 virtualization
Date: Fri, 27 Nov 2026 18:31:37 +0300
Message-Id: <20261127-nv-tcr2-v3-v1-0-9c15c1cabe01@pereq.eu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MTQ4CIQxGrzLp2hqhotGrGBdQq1MXaOhITCZzd
 0Fdvu/nzWBSVAyOwwxFqpo+cgO3GoDHmG+CemkMfuN3zvk95ooTF4+VMJBw2IYDEUVoh2eRq76
 /stP5x/ZKd+GpG/oiRRNMJWYee/R3rZurN7AsH6p+2A2QAAAA
X-Change-ID: 20261127-nv-tcr2-v3-53ec5459333a
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

This series fixes 3 issues found by our formal analysis at Pereq.

* VMs were potentially using the TCR2 bits which weren't intended for
  them.
* It turns out that guests could write to the TCR2 bits even when those
  bits are "hidden".
* The VMID wasn't handled correctly.  Roll over could happen before or
  during the AT execution leading to invalid results.

Changes in v3:
In v2 patches 2 and 3 added traps to prevent writes to hidden TCR2
bits.  Marc didn't like this approach and to be honest, the patch
had other issues as well.  Marc suggested that we load load
PIR/PIRE0/POR unconditionally instead and that's the approach here
in patch 2.

The other thing is that I have been trying to improve my review
process so I ended up fixing a bug handling POR_EL0 in __kvm_at_s1e01_fast().
That fix is now merged into patch 1 since it feels very related and
it gets backported to the same kernel.

Changes in v2:
1) Sashiko pointed out that we need to restore the original TCR2
   bits at the end of the AT command.
2) Clean up based on Marc's feedback.
3) Trap the writes to the TCR2 registers (normal and nested)

Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
Dan Carpenter (3):
      KVM: arm64: nv: Fix AT emulation for TCR2_EL1
      KVM: arm64: Load no-access permissions when S1PIE or S1POE is hidden
      KVM: arm64: nv: Update the shadow MMU's VMID for AT emulation

 arch/arm64/kvm/at.c                        | 61 ++++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 40 +++++++++++++++-----
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c         | 15 +++++---
 3 files changed, 97 insertions(+), 19 deletions(-)
---
base-commit: 5a7235e9adff42aa043ac9473dbeb0354dca0967
change-id: 20261127-nv-tcr2-v3-53ec5459333a

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

