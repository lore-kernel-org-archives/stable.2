Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B73B1018
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782502429; cv=none; b=FhNTv5Zr2+Bue5e1qH8tt9w4dMK+bE+gLYihEdlyK0VrSb4v7A4wEXh7eS0iNIOfJjKlI60v52KoYulXdrJrYBo9rsXgA+l28CGe4KslsBSuhl0Rxkzu4/G64yLQC3rkusTa+fElIOp4fhTU5VP5MJ7DTLxV58BphTUJqO5SZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782502429; c=relaxed/simple;
	bh=1aF61pLVwkhyDmxu+y7Jvt4YnNuTW7YTT1kuX0MTdh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByJASUFtyA1dtuwzlJvg47AzFX1VmL0zMYlJroTowgHzhH4QGoAgihlu4mCJaYi2LpYYxYkdMjFkTXgG1C3s2iNJgE80NEpAayHqldh2yUHqx7YVunT+KhmEB31gre+cysTC4uweYReJMtIuaEICAItw50WezpxoXDcfwQUrexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZSLwGIRQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZSLwGIRQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490d6730461so1454995e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782502426; x=1783107226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tscyMXQH7lQBk6kT/SnymoBViyC3tILcGbLnRKrcFsM=;
        b=ZSLwGIRQeZF26pFZVm1+bXhuJntHudXqz9wSpZDXmM1jzuTluA6018EjdAbu8zQFWD
         n4V01WAZAGtVpacm/qA9stjZGbAeWSMmRBhhwbgL4m0OY7+HbUj1ZWneO0wDNhJ04oOm
         tzmK9ToifCs2gMIn1hvpOVlOxt3nFCSjACH9U9WHwktJkmRpGTnmIq+2rg7pL9fMhWvj
         MAspyLGZMvtmsZlsfjBD8J1ZLWMlhvyJ1aYa0cAITDaV84kvuLd7I2Pp6zaQd41+zTtH
         I8d93Lxh7D0oE1EFXDf/SeywtkUKEiF+/Wl6jhQwtRyM2e+P1SW3c3xUyvEd6EYdf/hW
         W+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782502426; x=1783107226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tscyMXQH7lQBk6kT/SnymoBViyC3tILcGbLnRKrcFsM=;
        b=YiSINtED3N8N9X4dE1BtnzoriUtC4GZrR694JmvRaL17lYi69zVGuO0Isi4/5v75ZT
         0EJyYS1fNWve2f+2hBr6yh6O7NEv3AO8X4M/gFVwse9kgLgjXeg6dFMn78MLq1p9kK5X
         sDehVM1m/rT9L+j1p0AYqQuDqw7jvGnpBFOC2vdAm6dectY2NWEovBBfm0Z4pHcCN7oK
         8WZKQb/2FfjwkmHf1moAYIm+/tLrYlaZuK+3Bkoe7s2ZYKbuBid2BRvAcDqIs4O0TM8+
         2fiA7tCluKXJwp7Sfrh8apNR3hqInKYqE1iUlyMbZJgS0Cfuqqyau3WGrSheDCFO/r+/
         /bug==
X-Forwarded-Encrypted: i=1; AFNElJ9yGho+3TODqjGMKio6XK/qOK82F1yySWqWdr9WZwaAbmhmQVr8uPsAZTV68J+vdnpT2kbNn/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkvHZ9yqVsEPv2fwMk1q7j5NfqetjwwGQyLHBf+Btx4k09g4h
	WdWUMBW7KtTMEW3EgLfrfNK1XH2UeRF/LWXq/yCkx3jHaS+Tus25x7LDJulX87LwkWE=
X-Gm-Gg: AfdE7clzFStgTwkF3H8HM/5Qw3U5XidC4ItqH9bT+KM9U3KNMYzHuG/knZFoGZqNgzo
	O91CIC3AC/xERga1sYYsc0nwqy1ADmAlwGfx3uQcsdhTYXLFLPk8YsAaSPT/0VbBzc5CzIK3ZR5
	95xEk6nenCeP42s0dUgQwE0ip7rzLRvi7PvNT11Xqo5VyG74DiqKExXrgJP6QhIEjmCyXs6ywlJ
	BIwElUJeQZlC6S97c0HFanTZb8B/x7UgWyP6UnIxPvMRhCpNtGkuQTYrHOq3YoKTdtHB9UFNF9n
	7sbcL2SHfO5RyOXAM7EPwdCoIn7DbOs+w2HlHXcNHpliMe8IgpEJWaRzaXo6uXnIYz9jYMsIFuf
	PZ1peVz6SO6bOPWAXKoabYQE3IRzviBGLyspJc1JD1rCX4IqDD/8TnBabJHa7c70oNsno54c8Qj
	Wr3x2n/dIHH7zBvecAPDAFdFRI+hbq35hGZ4SqdaE3Xezh
X-Received: by 2002:a05:600c:a00c:b0:492:6e72:eee with SMTP id 5b1f17b1804b1-4926e720f83mr25214315e9.3.1782502426090;
        Fri, 26 Jun 2026 12:33:46 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm108291345e9.6.2026.06.26.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:33:45 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12 v2 2/3] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
Date: Fri, 26 Jun 2026 21:28:55 +0200
Message-ID: <20260626193343.256956-3-jinpu.wang@ionos.com>
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

commit dcf1b2d4b0564a27e4ca7c654871aab4f9620046 upstream.

When using GHCB v2+, reject MMIO requests that are larger than 8 bytes.
Per the GHCB spec:

  SW_EXITINFO2 must be less than or equal to 0x7fffffff for version 1 and
  less than or equal to 0x8 for all other versions.

Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/kvm/svm/sev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0a01971e33f0..497a6e705135 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4350,6 +4350,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (!control->exit_info_2)
 			return 1;
 
+		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >= 2 &&
+		    control->exit_info_2 > 8) {
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
 		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
 		if (ret)
 			break;
@@ -4363,6 +4370,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (!control->exit_info_2)
 			return 1;
 
+		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >= 2 &&
+		    control->exit_info_2 > 8) {
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
 		ret = setup_vmgexit_scratch(svm, false, control->exit_info_2);
 		if (ret)
 			break;
-- 
2.43.0

