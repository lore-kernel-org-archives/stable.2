Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E11A9FBD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782502429; cv=none; b=Cj/h03M+Nnm4hokEI2U5Ts/fPRO6n+I0KvMAZvmBjTUhFcDDnyYHnr9iZkLudqSTENASDGLxXWnf5TQ2/MGGxvFSdWMzriDQW+QK6YMYmjfU8jMyc/DXOoSMSGjkrSgNKOV1kroqLJukcwuUOLJJZdsZTy+0kJCUQceleOsOwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782502429; c=relaxed/simple;
	bh=EgylDGt6REjrv2ohzExmpiUa1ZVDA+4pEPlQpsaDNN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeEyQAMU6AADcF7uA02OAyuXWNCzNFZU4shAaC0FKa8DVeaM+H0vG3cg/++6JkvoKxElvFa0dEfylDXaTdal8W83E8BJ487d74VsERL45shTu9r0MnuZ0kBTH1TpEIgjmj/gy4W1iMm17KPtFtXoAzJYH8qt44/POCS93Ac86OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bwFrO8Mq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bwFrO8Mq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46214219a18so164122f8f.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782502427; x=1783107227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alpDCrJ/uEx56epV6zIsJxCtfTLLRAHqL/mlvwslCeU=;
        b=bwFrO8MqMtnhp4Udag+9O/KiGX1B44Fg8T5c6brDs1QTjbV3wWxgER4brBa7+qM7np
         poZAvERR4TA97i2T/0MEOsh7REyAXgrDU2ZgXjMew+Y9I0msXQQieim+ZQv8a7bTcGV+
         szuITpw+0cuyNQbfRdKP7Ap1dBd/X/T6k6GDxc7vTFnvv48iO+GtQxYqY8rzDBe3eNjX
         GsRCLDaB6ZRwVSk33dPJgtwoe6IryZ4IVtyRtadofs6oZf8DzpWMrECnzOICsu+ewFHV
         c8G2OR/MNL0JI1PZcIlR2db90Qo2RdY6NBAjlyZWXyHi1/qwClU2/m6Bd1xPhjUJRboj
         WZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782502427; x=1783107227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=alpDCrJ/uEx56epV6zIsJxCtfTLLRAHqL/mlvwslCeU=;
        b=cnKUuo8vr4sbOJX4BI16rMsatQRgHCsOn0A8O+vUP8U6ikxcfOX2XaNRZniXHaBGNQ
         tCIPnY2qGl2Fm01PttTp6U5Ub+uzQqtU/H+AAbHILfrCRimCKJON2iyWig7CI4g1fw8R
         D+UFc8mWoJHW9KCBvwF5ScsUYw4yPJZqFIX8400YLngIA8SMvp674O0hdFB52YrrzBzT
         CfVjiGEiYPMxft18wZPIyoylclHAlJQso9RVq79SGvARR8Z2NmcYhfTcRdxzjjKCtqNL
         mET6kXz/NgDCFstvLAo0eS5QrYm6w1qDOP22uxlce1TLLtd9yPoWFhe+GsVdbVjgKX80
         u7eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Vug5ZZc7PkuhseOjqbNNAzeJRFIlruzKQ+6Da7eB6ahWinT7OYCo6UXYgrW7wLVE4gbsHaig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6B5xgG7vVGlew+0O+3YuE89yb+N1gUpqARuTIxbbXHTr7zux
	pbdqWC+2mPf63IrMZpD4JN4U4KtnGeSZM6j5L8/ci0T08Gb8QtY8HsmIm2kJbvTOwdA=
X-Gm-Gg: AfdE7cnW7IRIIxoL7SDQIp2EzNTbyEY4e+xWFQP7VepaPDipk9C+mnsWpbbXb3OkgRH
	4oQu74mLOuPvmmYCAyq9bkw2MzBoWLQXfO95ACqMIJNoVSbddeTl4gVo3KjXdPy+zffJxFEJT20
	dt+FLWl10qjdA1IGAQYRUW+Ua/wjIi6CpmLkrJtpfYoVA646MJqiWEoOi8iQG5XKtsnGo9Okd7M
	SZWW0h+otCy/X83NefLeUN36cPAct9RMPTHae1hWtWVGWZMJ0gvAWEiIVY//ruQVZcD2GZd4A0K
	hFd4nDA5tEftVQTaFWYYM1Vgx/fDM2fIn7wjgUydB2iEJloxOeqZXu/ATTSLK0Pqo26ADUG0QWX
	Pwn8sJ+wAOMPV9kptktUYs1+rLVeiuZ6FACr8c9vgX8XgDP9+R/HKQ9fjX2+wMKR2EWPdTipQI2
	5GErmRMhTHm9e4UFc3693scJU7Rzwx4Y1Pjk9ycfSw+ium
X-Received: by 2002:a05:600c:a208:b0:492:6a5f:7acb with SMTP id 5b1f17b1804b1-4926a5f7b07mr21890895e9.7.1782502426742;
        Fri, 26 Jun 2026 12:33:46 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm108291345e9.6.2026.06.26.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:33:46 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12 v2 3/3] KVM: SEV: Ignore Port I/O requests of length '0'
Date: Fri, 26 Jun 2026 21:28:56 +0200
Message-ID: <20260626193343.256956-4-jinpu.wang@ionos.com>
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
index 497a6e705135..73e493177351 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4459,6 +4459,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
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
@@ -4479,6 +4484,9 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
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

