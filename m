Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D65243951
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782502428; cv=none; b=iUzTCgoHWOI/BH7FaZdEpbZvb4Ol/RxaoKhCeC5IMp0onaQl/tPH8BWWtoSAp6LdWXrdK+8iR+9l/75ZrzjfCAZViBquvzoAgTFM0TsfErQRkV85gGT1N0LptIelek6EoOXXxOUS9CrZvm4ZFtGF+gy6XA6TJ+duZ1G8GFOJEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782502428; c=relaxed/simple;
	bh=/YvyXJ5A3sKeOUosAl6n1HlSpe5rEv7/ucNj2qNC/lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkofjBzXAX3pNKgRm3zts+8zWWzUT1sd5vRCZBEA1swCR5fDaqf6etG5sbNvDvAipqgKwXdh0lcRSv2o5LwAlh5s9BB9/LrDC8oXj1VBm1/crGifEIgKWCrShVi/ToyXgFxb+ai17/uHjKLKATpfULtiTpJoKXw+0lBeBfJuCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ICACohDS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ICACohDS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46214219a18so164116f8f.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782502425; x=1783107225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsYmmpIP1J22yC8MvHPKNIueesSI+RnYOR2wKQmvmCM=;
        b=ICACohDSLyd7gBwYIa91H/zXlrTzqJ5h5BJ1wM3Xyzyi4W/5qUJwOTuXaqoX8sNOnn
         Z2z/LTKi9sHDZADcNkK54HvruutSB+v5cEkOxb45TPuTvBnCHqiVxStkMujdAmW21IIF
         YpC9RCi4doOUI7Grb1JB3VN1f8kHttE1s0KLDU79MxVh/n/Llc/NsDTp0HCKjz4wbnhs
         8MByA8ZdKvt1kdWlz/3XXnTWFUpbdGhXssUYCJ7KMa9phsoALd6wDy+/iV0JSKk/N2ia
         jY1SbRuJIvO1MJYLtgKyNaS8alc4C3TrlXYQ5amiJHNWWaESOLhUttddowCpY3PsNQzR
         6npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782502425; x=1783107225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FsYmmpIP1J22yC8MvHPKNIueesSI+RnYOR2wKQmvmCM=;
        b=ffzLN2c8F/hzlH94uMc7+5ihyHT0SJjGN1cFG4V1KlA1itvz3V6vITI0XSrVNYad76
         6VZbg2tpgBTw0SmBUJWFTrUq1IzqJblSvJsWN3wW4KowO90ARrF5mdQTpguTfJuIVAbP
         msLehECNGgOTBLquJas/bM8QVne543w4SOh2ADQcvHqnVxIMHIt75Nmf5aBEnqil0TZK
         Dr5pxplZsswDT1VZyb6EP8NfHMyHapDNZd8bg/AdM8VCz38stAkaxwVATqftSi9ezABe
         azvIXw4kf5C/12+ucgx9ntRKlVrOP7+/oOVZ083oBlA3Yxn7tMNi5zjn0i38sGDfvClS
         RRuA==
X-Forwarded-Encrypted: i=1; AFNElJ/z48+PeC68sptqp1LGWjbnS7lTNk0gLrq4IXGlVO46+7zs3/jG0uIOkXBrLWr0rgx6acBp3mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqW33r76CduzqqgvSaHVt8aghx++prhA3K/IxtuF7kclcw6fMY
	bmpQXzPNq5FfEZxRU3JskTlnBuJq/7ehMsE4boGlZMZXNAoZ+mo5rTtrWkjWNtSmLR8=
X-Gm-Gg: AfdE7cngSRKngYpX6F5tWKLwfPpoQgkgU/AXSpFTUek+ZzLHBYLd1g6bK4zmahG12iU
	iv2fDoZmB2pIj4E/pzLtJWfWs5qGftzR7Bmdgw6I1IVwZdJxAVvqIsjBQQGhNbGhVS8acrNRCQJ
	OGE4A6zXv3UXIxkwuhjnvBHWYQhz6NdVXIZQ1mW4BunzzYtG4RWkFRKbJ6GzEm8AN0xervpgNUT
	BK+SWVD8CTt12LqBmYbH2soeeef96Je1+ucFf5ONPjuCm9sjLUbXY+WdzgrCjdtnDOiE7Ni0flE
	NskQ3L56bob+6laz2x7UdGOlVynt4PxaGHwK7Qxtt87eVPNFQXyuxeaqsoY6OXnxyYxjB6r6Dd7
	G203rMsm9QIGbwhmlpYU0GslMrpX0kLfBBt6D6/TgPICP2fZihh0XN5Wqrs4j0UrUjkjRi1Cl8i
	Oo/sfiv0AeOswg0h4AUOMSaJDtJ7dV/da0jwPtyRY/hLOwf6ubd5mnmAo=
X-Received: by 2002:a05:600c:6385:b0:490:ade7:9ca4 with SMTP id 5b1f17b1804b1-4926686b3bfmr57582325e9.2.1782502425165;
        Fri, 26 Jun 2026 12:33:45 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm108291345e9.6.2026.06.26.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:33:44 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12 v2 1/3] KVM: SEV: Ignore MMIO requests of length '0'
Date: Fri, 26 Jun 2026 21:28:54 +0200
Message-ID: <20260626193343.256956-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626193343.256956-1-jinpu.wang@ionos.com>
References: <20260626193343.256956-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 upstream.

Explicitly ignore MMIO requests of length '0', so that setting up the
software scratch area (and other code) doesn't have to worry about
underflowing the length, and to allow for special casing '0' in the
future.

Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/kvm/svm/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 115c59c86f44..0a01971e33f0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4347,6 +4347,9 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	exit_code = kvm_ghcb_get_sw_exit_code(control);
 	switch (exit_code) {
 	case SVM_VMGEXIT_MMIO_READ:
+		if (!control->exit_info_2)
+			return 1;
+
 		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
 		if (ret)
 			break;
@@ -4357,6 +4360,9 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 					   svm->sev_es.ghcb_sa);
 		break;
 	case SVM_VMGEXIT_MMIO_WRITE:
+		if (!control->exit_info_2)
+			return 1;
+
 		ret = setup_vmgexit_scratch(svm, false, control->exit_info_2);
 		if (ret)
 			break;
-- 
2.43.0

