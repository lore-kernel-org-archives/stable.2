Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB23DB335
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477946; cv=none; b=OtYtVhXMZeb1K0b9hOZDiKxZycFPg7cM/Y77hX+DiPqrzBaRpAI3ZoIoK41C4yzrDBPD8LayIi5TyAk6QxvGt6CSjeLaV36f5f57Hu8YwCbXrvRliNCw1MaiAgaA17qBT3LONqMsw/MnhktBJuh+qltDPCQePAEpyyAzv+utRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477946; c=relaxed/simple;
	bh=FjEXsHK7qDjHgIvWppaHndfGta5CCw5KnjTEfIq7sIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGSbk0wFB1ZOfF+Sq4Txi4CCLd0XE2abLXxy5bjkORnRoSWkqlchUlVSTpjDvqT6KSuqYmrIh9fnO9oXATVaA2BeNjBp0DDOn+3/VLcNVB3fFyEYRndnLRcLfPeOzfqEHHOVbRnZmFxdCr7Q0/ncil1mC1O8vYvMPGwSlwjifrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PczSTtIn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PczSTtIn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4629324e267so76136f8f.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782477943; x=1783082743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be3nAigUdrHkT9ALFJYv/TSL2IlC3sbCzgwxmwOQFSw=;
        b=PczSTtInJK2KJmmX/kNuGrhFq3IsqcBYZiBBpnUD0dl6OkAaTrwx2h19+6oAYKz284
         WsuhQhWaxu8j1pWIissa5NuW07+WdT9D0sJDZIPH/wil4Sw2ly+BMddN+0uqmIaoX8V/
         l4NkFxzmtLV/4st2S+G039f7OvEwV3QpX6M1rqeVlwZnSHirUT2Fcm1xsHNxfQagA+Fw
         fDIK+vfinO1MzEGqfOFIay/91RYgFMYw15MwfrP9aeOVdypF64IsmqV8uiCcrzi2WAn6
         Re9npxzNF/72yWPcc7b+6pijaS81Kwq6CDfQRzVSO/4wYATC+8DTRWtIitk0+ux+Dn0f
         bJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477943; x=1783082743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=be3nAigUdrHkT9ALFJYv/TSL2IlC3sbCzgwxmwOQFSw=;
        b=pdnCHHvE5KATIEAaHgJP58ifNOx+7TCLN4Q6r33KYHXVlzKvBQCmZriYeUFjqQpI4x
         O07jS5uYO30QTQg7OHrBfVj4xe8AIdqNhLzdRFWzq+/HP2QeO06n9LCME5yTgq0jl2dU
         7FddCOyJQsd04AkoEzDYRf92exnf786ny7RK5S5oo4K4c/5SG3f4yaBcPR8LG1Y0Vn0a
         MeJ+oIBqYq/7g/FDLq/o6Kav5AcVSJrcjHuvCIfclqWq8FDX4WAHoqIlFtbF7R5vuOQv
         r4xtxbh/JZxtVfCiiae9ssha/ITWZAQswvzpu8gb0wzGUvxWB08/S2ruTai97fYml/GE
         lWOQ==
X-Forwarded-Encrypted: i=1; AFNElJ84bwrYrFNva7AEk//PfrgYtNZbkdGNeEAX/p3YQU1bzCULcwTu2YQPB64PQ9oP6O9Ljuzv28E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQd+2mVY4xNDahFnF+Z0wRXDCuIVlk3+JbTPsiaLSxtliulSzd
	cCRGZ+E8yLgqTtHdCCkr69TgSY3acQvv5MY8dkpXSehkTrbqMnapwAaC8DtN1SqRBoQ=
X-Gm-Gg: AfdE7cmjzcsjSziPDmWwr1H5mFtb1xX7J7wn1IxjPW/5JfJFaLv0mZ/aH7rm4BTj8Dy
	S3p5xTKvokeXdPiYsPkJ3+jLmEy6k89VXpRQvBlEZsQbC+sAtdTY0IFm68vp3jAXT9rArYABG5i
	kPlaieKnZukURQGTnwKz3GiDgdCpvmN+GTrgXijJTfKpXXTngh5Y/VWNeM64fclgSPsWLx+LbAj
	HlurAAx6bmW0PSf+Z7FDEQcSSy6gp7PsBII2DFujpG9S+6LDwK9WFwmAWeWv8JJHumyQrBdTv3w
	bl28Xb/J1VKQ72K2qa+5p1qjnrcsY/5hqQ4quacOrMQ0kZX0hy+XBBM7t5EB08FLHNyDY3h52xB
	RnuRLmDdtc6R+TPUiRQaIVpnXo6saxsF4Ek1Js1RFGrL3r9wzD73iGxIjStr9w/tWma/6H5//lh
	AxmkDDRwiuo958bLRgRrusWoB9mOYBU8EeXZ7JsgDxp1/w
X-Received: by 2002:a05:600c:4714:b0:490:e919:7bba with SMTP id 5b1f17b1804b1-492668b80a8mr47354625e9.8.1782477942897;
        Fri, 26 Jun 2026 05:45:42 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269020266sm73981765e9.15.2026.06.26.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:45:42 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12 2/3] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
Date: Fri, 26 Jun 2026 14:42:22 +0200
Message-ID: <20260626124539.201250-3-jinpu.wang@ionos.com>
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
 arch/x86/kvm/svm/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9374b1a93df8..82b26899b9a4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4364,6 +4364,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (!len)
 			return 1;
 
+		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >= 2 && len > 8) {
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
 		ret = setup_vmgexit_scratch(svm, false, len);
 		if (ret)
 			break;
-- 
2.43.0

