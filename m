Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E342A82
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780768638; cv=none; b=ZAKAFk2bVWX0Jfa5NE0euBHeKYRX5kR33x0bk5DkXGyueFDij0wK4rS7kvBVwWGJO03ulXOQjS173Ha5KHBUGR/X5jJhY228K176AJvjkh65ggHMO2GAfN8JLB/O8UlXkftsSxlv3W1dgBzD17CGmD+meGkEFYLjO3PBYG9FAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780768638; c=relaxed/simple;
	bh=6fmYE5D4pZ1hMhe2KPEF9CIGn+2+DUUFbJBJNxmOlNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLCQFRCcBwxlth3FbPu2wJObaWmiRVUOb8eMw+JQfd10jY3Zsft9aEdItTCPTn3Uhfj/cYja8tkzpLo1+x7ru8ZBtunCR0qqTeOqw9+CUlrX3WorFMk4BnVzTGKotEcZNwMwEvJ7PhjnnE6ZhKWVznziW+UHEK1Q9dEkktWtAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBhWH4Po; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBhWH4Po"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso20167665ad.1
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780768637; x=1781373437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtrLaj5ltFoAG/++WffsPSgWGaLrPwS8Itqpcy4i6xY=;
        b=rBhWH4PoB+e+wovObnPVubjtvLmgS0o+vDbE/TYfNowd+TZrehSX6bPVRDuAau1V3K
         SDBcSlafV2t6c/ZBgM6GR3wnDUOiK80IuXEp0KveGONtvvKawoxDgzcKi95sDqoJdMk/
         GXq46Q7KDxe1uxjX2pPWgb/o0i28x4uki9tshzrNtdk2ILoTkU2eZE8jFhUQz1lxpoCP
         VaeL/2c7xW8uMYdupwVeQSol4790XlwFjYZ8DgM412+gNTVk9P3PHf4cXFCCsNN3VJIZ
         F706gQb+O7kGSNrRy8U8h+X4rjDYN2bHp8533CFxq8S+hzHUj7YBUybn0olGlOG5CMci
         OvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780768637; x=1781373437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtrLaj5ltFoAG/++WffsPSgWGaLrPwS8Itqpcy4i6xY=;
        b=LCUlkfJsokG4BooSt6jup7rUBbHDgoIPi+4wpWq+YRrkBIXyqRn/teBXt52HmJHQ5D
         iNTQAPswWSSBUpNSuFI/cdfppj6IEDb+KKAN21at6MNCiDCZn9YBvr0R7w9+lwzuh1XI
         IKV4kji+n1pxOX165JxqDjmc8PucplKjnOz9Z2F4L2yNTEDewXRQokZBQ5DKIzVb5Eh4
         OisFCB86ZEbzJHwdEXB2MaWEUt0bWu4flO9LbB/ec+6/U1Z49j3h6OhPM8WzRmZ3o3pN
         VgYQkAF6MT4HPO/i+EpG/NB9qglBIitl/GTpa98f08fl4VOF4x1i/749/sI6ciPXFeNV
         hWJA==
X-Forwarded-Encrypted: i=1; AFNElJ98F90E2d54fKCnNo5RvBkcwZreLaRaxzL3QLkudHSdJOKoe5Gul1k0TRP2lLL0KWnpztIo8qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RjRt01mNr4+ERLEtAVnXQP0/QVPOjICUB0dnG8J1cJUL8Fxi
	+1nj/pNjUnERFgpnTGASaqe8MVqEDaZuY/I7+SLODzWgaofIVGtkSQmU
X-Gm-Gg: Acq92OHH4Fn0wqScJfKZ9GyuV4FR+vKCsqdFTRMzOxCrHkKn465WxmezO61S0bbwS6L
	LdjhzvMkpXy7WFqOZkBbvxuf9YeodfoQb7fqw4Bwe4F9RnUclEyhIgq/QBRUHKU2IGvcsSXKFcH
	gS/s3riK0ZHTELN7hY9ArP8rqJF2+iKBx9h2n342n1Mrtxw1SsesEHOTlCP23gPN+KQp3Oxmav1
	JJYKzHUQEJE8g74sH9VlIwgXiBQ1ZWSwXhjXeX4Tcr0Qie9hDzR9iBvwxSVmP85ERIIpQaZToF6
	xeUDN8trdW2AV4Fh1FRoK5NS0RP3wEanE91lQ6CdOYJ7kOuAevy1pdmlTH/TqAidAUvV6bWxVj+
	BvurBr1cBBUGkYgyK/siw2qsOO9VU6s174CML7NY8k15Msy1oA2iVcbAjh70oIsOJYYYw+oO/wq
	6OMtYevqPrWbDdi2IQjFHx0xHJTsaedA/+o7EehQu0PLSfvhuYh7fMAcu6
X-Received: by 2002:a17:902:c952:b0:2c0:fa4e:91ed with SMTP id d9443c01a7336-2c1e834699fmr108804645ad.18.1780768636898;
        Sat, 06 Jun 2026 10:57:16 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm129196425ad.2.2026.06.06.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:57:16 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: tabba@google.com,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 1/2] KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU
Date: Sun,  7 Jun 2026 02:56:10 +0900
Message-ID: <20260606175614.83273-2-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606175614.83273-1-imv4bel@gmail.com>
References: <20260606175614.83273-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_hyp_vcpu() copies the host vCPU context into the hyp's private
vCPU on every run. ctxt_to_vcpu() expects a guest context to have a
NULL __hyp_running_vcpu, which is only ever set on the host context, so
that it resolves the vCPU via container_of(). While this is generally
the case, flush_hyp_vcpu() copies the context verbatim and does not
enforce this, so a value provided by the host is dereferenced at EL2
(host -> EL2).

Fix by clearing __hyp_running_vcpu after the copy.

Cc: stable@vger.kernel.org
Fixes: be66e67f1750 ("KVM: arm64: Use the pKVM hyp vCPU structure in handle___kvm_vcpu_run()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 06db299c37a8..02c5d6e5abcb 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -128,6 +128,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
+	/* __hyp_running_vcpu must be NULL in a guest context. */
+	hyp_vcpu->vcpu.arch.ctxt.__hyp_running_vcpu = NULL;
+
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWI | HCR_TWE);
 	hyp_vcpu->vcpu.arch.hcr_el2 |= READ_ONCE(host_vcpu->arch.hcr_el2) &
-- 
2.43.0

