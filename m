Received: from mail-dy2-f32.google.com (mail-dy2-f32.google.com [74.125.229.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E538B14C
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404655; cv=none; b=S6ZsMTMj3XSoBoqRIgoYROERk3rBcw+7/0XU6Gd3mePoufuwXlpqY9ijvRUREhMaMPDGz5mAQllx93CeP8/qZrWDr7Aoi7Jp6SyVEq8eEeJJ0w/c7u2HhuHoX8ZcsdkyBLhCFVh6hYlhw3Gx8k89VLeZF/9Rh4g+jrav4koZt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404655; c=relaxed/simple;
	bh=4uMF+Zyheka+eW7kDUK3k8FRqJGU0Etmiqlk+J0Llxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMVKWnXgwxWn62YSirU9D76trrJMHEb8d8RDf1otBMfjjeiBmHNkF/HAcYaCtKgj8Wd6KjpW3li0eHFLDlrSpWHFPoFLI3BNyyh1fdSgZSzWXWtiEu+tzJ//x4uu8PN7SXt2csqJjo54XxLGy9MgwDcuEOEkE7YbzTK58OrPI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThY8gsz6; arc=none smtp.client-ip=74.125.229.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThY8gsz6"
Received: by mail-dy2-f32.google.com with SMTP id 5a478bee46e88-33b9e805130so1102222eec.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790404653; x=1791009453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtzEc8ALe2Ni0U200YE53lUimcTmcbv5pev4EjEWMTg=;
        b=ThY8gsz6vsuo9tV08Gq/VdQm2h6L00V22bSKLP37LYHAMtsY55eSV31DsV1s92+iZQ
         fM8ZOGMjjcjw1crB5n4QGlVANdPzls8UNwx4Po6D2QZEMYqVJhJ756T42WYL2ucZo5Wp
         QbgAgAHWmHaCnjctr5jN/AmvXS25RquQk/GSnGclhPZUOuArJpEXXZOSlpv6NlHIYXnZ
         blLx7LttXt5SHf1eOT7RjjCnZDeSgJ2Qb+IZsTjFWBklq5W3bLmOOouz03OjNbQJHkmZ
         VsaGzfwvRHNGgUUADCkPHoF6MsTMvpbO3f23MV0F03QGMkhIOV2Jal8hiz+zNyxdUn8y
         m6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404653; x=1791009453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtzEc8ALe2Ni0U200YE53lUimcTmcbv5pev4EjEWMTg=;
        b=Xzognmz/jutPdKHxkRPttraagSyw/9IeQIBzq/mlrs1DHIF2gV+3EXUZTIVg2cfvTB
         B8AHnauJ43sbzSiwaFCWseeLCGdcz2+PGekEYs526+KT9UBoFn0vzqgxSiX+jCFprPgc
         j2KGMMiaBnWqn8xmCz96Y3HZPaQ904VotxhjNTp7goc374RzPJf192TpxFyE1up1c4a8
         q1/iPr2UvOOHeM2zAfFi3gwr2XGhaz8qT1vMIpDcjU+s/Vqrxy3eA8Vuu3i5nN1ICfhy
         JX8uIwyUjHP3zDlyzSRl5HZKMlDfnHVqlj0nx66iwr3ai/3bw0M/kKpmxFQnEgTVOux9
         DtfA==
X-Forwarded-Encrypted: i=1; AKwUvBxNxlyUhP1jET9AcMNIIZKiWZGuhGRaXwDbLJPYfmxfnUQapmgWSh97nKGVg+iD+LhGs3RZfWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kdazuilG1nfQbe7LZpCRSxrosGGLmfGNkwTqCZnSHa7DaeQDwM
	CJkgnFxXIBnNbFiHERn3t70m9zb82Jdyw+OPCb2EaweQSsu+l2EF4PFL
X-Gm-Gg: AYBFou3NqQWspCdOqiVehynVd9I8Satz/KlJHHMw1aF4l8ysg3GHp2bsY5ElvEZv5+N
	endONlM58uaV0EoxovqutW6huB4gWzbFUpN12wEwughD/J7hJOSPbOrNvy2gXmJRvRYwWnFIVr/
	bUcpSqcDHyieJwx1kFrlNHCj6Bg5+mUH2QojF+M/vALQyZEGyuokxP9A3CUOGfj5fJ/6zU9SCK2
	Ks801IfrGPwWHBEHjU+JUIi9HcyxtpHV20XR228r5sN9ABzcf7yCj2VApCTVfESGMtpcBH1A/3+
	/IcLFVW/AJQ4YUEoKzyk3mVBTcAtFb9F2GeqdrMUbmwPTehBKbJ0vqJMEQWyBV0dYgfOX3O5G9P
	OrcbcZg6Xk1qnQD4frte8c1xmfJ6WW+eToyecxo+sPn/sS2sLdL750EN0LtcDh8A2aRU8I8QyOE
	mohQMavi1W3b/WL9SlGV3TNseiObHFVA/LJHlygB5fbjjXJyJbcvakjfHOefe67IHAMdrDXcmXG
	ls9/7E3gUvm/cAJYaFTOMYV3b7BdTO4
X-Received: by 2002:a05:701b:2618:b0:141:5281:8a41 with SMTP id a92af1059eb24-146cdfbbbf1mr1748789c88.9.1790404652850;
        Fri, 25 Sep 2026 23:37:32 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm11239841c88.13.2026.09.25.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:37:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Rebuild MSR bitmap after eVMCS control changes
Date: Sat, 26 Sep 2026 14:37:21 +0800
Message-ID: <20260926063721.1471741-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Enlightened MSR Bitmap shortcut reuses vmcs02's bitmap when L1 marks
MSR_BITMAP clean, but the bitmap also depends on execution controls in
CONTROL_GRP1 and CONTROL_PROC.  L1 can change either group while leaving
MSR_BITMAP clean, preserving stale APIC_TASKPRI passthrough for L2.

Reusing the bitmap after a failed rebuild is unsafe too.  The failed entry
disables hardware MSR bitmaps, but KVM subsequently marks the eVMCS clean,
allowing the next entry to reactivate the old vmcs02 bitmap.

Require both control groups to be clean before reusing the bitmap, and keep
force_msr_bitmap_recalc set until a rebuild succeeds.

Fixes: 502d2bf5f2fd ("KVM: nVMX: Implement Enlightened MSR Bitmap feature")
Cc: stable@vger.kernel.org
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd3..0f0e677d99482 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -755,13 +755,17 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 		struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
 
 		if (evmcs && evmcs->hv_enlightenments_control.msr_bitmap &&
-		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP)
+		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP &&
+		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1 &&
+		    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC)
 			return true;
 	}
 
 	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitmap));
-	if (m.ret)
+	if (m.ret) {
+		vmx->nested.force_msr_bitmap_recalc = true;
 		return false;
+	}
 
 	msr_bitmap_l1 = (unsigned long *)m.map.hva;
 
-- 
2.55.0

