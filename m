Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB542E738E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477947; cv=none; b=J6sl4PsdwuzThBePQAObVXfOU3YixT7uR/QMUhjDMLSHWKs1DiN9jykb1vwCwVILG5o9IrXrPGrdvEBAfXD7J2XJBfBJexjCYfxyPIdNXQqRUT6fQHsV7jbCp+SwuQBPptpNbsJrTubWP2AbwNSgBN0KUQ37S/GDF0k6/fmtR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477947; c=relaxed/simple;
	bh=lfCsK7ke1HwaKiMi+Mmi7QkIFc+E+RHjC9IiY3iFes0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJy2v6ymGIK8pjknpCRc+wHu38vJksWCjrT9WwZJP36eT2WM1C9PPJdUutzx/pia3Vf/XTL6oAEtLHuVHvpwVkzlxxHB3up0fHR2yuFKzXTRysP5vpD89S/vXO78M7ej+J3N2tIQDLPE1jJEBJmu/LB81Yj5BkDIBSKEbhffqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FlGHj4nt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FlGHj4nt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46cea75d96cso83611f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782477944; x=1783082744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uISU591JVCgH1dSdw17ho6JpPc4Bt/zYx2LHpVhc06I=;
        b=FlGHj4ntk074qBsGbQxPERo1tQcu3oiPbkOq+BegiF1smr5Bo9sd2bSrckdkNiXe9z
         EiS889E9oRaQq012z6bQpKig1Jb/fpjLR8sntyl5N8N6nlSilhz5D44vscsGxMcGhAuZ
         rpXeDoKp6VhK6wqpeLDDCa45FoYQqHoj9IrLg0TiNutuJB8MKkx1DRbKhbxfg/eUewYe
         mbdiNqZa0VMjl3hCB0nuwupgq3tdTsbCbNRPmoBAcagmGIbjyye24aCvgARUWxJQTBFd
         nMZkbL0lh5/DaljQacqF47MyDYi0iwHIM5HgyPn/exNntNAxZi8iPOMfzv/5j4U97rmK
         udWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477944; x=1783082744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uISU591JVCgH1dSdw17ho6JpPc4Bt/zYx2LHpVhc06I=;
        b=n9GisN7y1jz3S252bMeNqTM3oHT2Fwn/v9Z2QF0e4O46Vj01I49VIZYtp8yklXqZBu
         7YQYUBnY1zkck5LmH4s93YJQbF/z9PpGQnIFzOVSx+l4jE4FfYJe5yf+eqN1/96PQ9yt
         dGMLoaltd5LmBmqCBFYMoxuMaJqbNYbwCeVJ0NU1vegLaGv8aKNHHyPJEC7dPh9bmbkb
         HB/mTjJefxaZN+reLczCHXj0HBYYsSd31jWIujCXlUsPC7V9tiYjNeBJJUU/pZsyM3Hj
         w0yGcHjHAHJ6DHAAYTBK+Qj02LAN1oabeGD5KhMfc/s1wrrqPSPoL12RPYRHaJjbyUTL
         GBuA==
X-Forwarded-Encrypted: i=1; AFNElJ8yUbRXyWKF0FDy3/+1C+ziVcTkYDhDmro8YPOf2VEl2OgXtouSX9xGohatAqnZ/GPSThEzDlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSu129AJddwCJlbAm0KTj50zf29MCT8IWmf5R6A5owZBoHKdEP
	wwjNyniB0kEHmNG7i0XRe8P7r53ig0aeMZ6aRDC+scl3x2PxhE6Dw/kJO0WTe0zT2fU=
X-Gm-Gg: AfdE7clQNa6IJA9zXCUQxYs2/NmC2RvzrOQfhtdzDDGLek/S9psGqXSRyGGPoB3Ansy
	2c5OEi1NT5C8GgH66Jrg6hBJqxT3PmNVHEFSQcHnTZuEJae5Ej5BM4p8wyKYwW7bybiLx04BHuu
	wj2ah/q5CpxR7rjRq+ek4WQB1+7imyijuS2E66n7H6nuhwTv8c60xTG8Us+J6rjZoClIdOtsnV6
	jDT894xJE4WWistvGGlC+bZ+t9bKkX0eIzU3xPimO3yPrBUTkuZCiDSWr2yxa5By8tspwiPDAXp
	pFGj51TcFlueGUVyxtvyJxBoEKNrUDC9PC0FbGxc2tkgjJHFEfeZhEJh/OfqvNGfcuHd8nZDzQU
	wUV5m+4CE9rhpf6hIRpc5edRNPCnt4FVSDTxSEbxDlxSlHDdsnuMbopjiCvS4B1hw5gdVuhUch2
	Pn5xZbFLtyOR6w+3hfW53aW5RJkAisie1/XIcDXKyWNtWp
X-Received: by 2002:a05:600c:4fc7:b0:490:846d:4edf with SMTP id 5b1f17b1804b1-4926686b3damr48747605e9.1.1782477943777;
        Fri, 26 Jun 2026 05:45:43 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269020266sm73981765e9.15.2026.06.26.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:45:43 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12 3/3] KVM: SEV: Ignore Port I/O requests of length '0'
Date: Fri, 26 Jun 2026 14:42:23 +0200
Message-ID: <20260626124539.201250-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626124539.201250-1-jinpu.wang@ionos.com>
References: <20260626124539.201250-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 3988bd2723de407ae90fa7a6f6029b4e60238c58 upstream.

Explicitly ignore Port I/O requests of length '0' (or count '0'), so that
setting up the software scratch area (and other code) doesn't have to
worry about underflowing the length, and to allow for WARNing on trying
to configure the scratch area with len==0.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 82b26899b9a4..7e8b5acc2133 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4451,6 +4451,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
 	default:
 		ret = svm_invoke_exit_handler(vcpu, exit_code);
 	}
@@ -4471,6 +4476,9 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
 	if (unlikely(check_mul_overflow(count, size, &bytes)))
 		return -EINVAL;
 
+	if (!bytes)
+		return 1;
+
 	r = setup_vmgexit_scratch(svm, in, bytes);
 	if (r)
 		return r;
-- 
2.43.0

