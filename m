Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330768;
	b=E1g6owxsRqfRbx2fUK/4sVvWqluF0kOHcRSnTRSMqicPRSfibXhgkGbzQsOZodZNWj2z
	 1t4Y1WMrTvv1BzSm3k3J4kDFRAp52Yw+F98cocpri6D3h/XWp76BGKHhBKyFUWbZrbJeY
	 ZT5qUDj7VUwvM0AU1dxculws27v2tFT+y2PkvQ1uqLtFi7hfBJXjKwnNvtTP5fIXFY5Yj
	 WM6e6MCQmuumqEhcThCqav2wbrNE8KmAwhXTeRUUJx0HLJI3flnmzx46uMQqVMa+x2tyG
	 RFwv6URBRWKjl2nqglvke0EGUXtBgaLLu2q4Jh0f+VP4tFNA+mDw/YYAVtd3aWZGZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1CIkePRTbQC1KwRVPlH4zGaG/q6Pu0AtRnPOvbQlJbY=;
	b=M08z525SeuSYWH+olhdKhfgqsjgCk7y9fkguHtFt9TxX1ChEDH9QSVRQQQ5BR7HUaR3o
	 tIl72OeolAmMvtNuW0wuE4ZKFEYomHHS0sCgK+Z3TxFcdGJN+AoQrqFH/bQcKxQeo9Dtk
	 VVYdGQn5csUWB0Hh6TEMwlDzUIV9VS9SGkQHL1VaK1FyHsfQYXxf55nGrW+YP2gx2Fwmm
	 XTuI9mRU0cNkDtkBqaKhkbdVRJJ64L1KTpZZ3DyQkkzO4sa2z1ZZvzqYyoopq8gKXqs6J
	 Hv97AZ6uVHlSOlqOpY9wjoUfibkK8gRRu1FO9xXsHFXtJVflifOJ807et/f0TiVE7TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oU/XdySO";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E658606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E658606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oU/XdySO
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so80633a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330768; x=1793935568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CIkePRTbQC1KwRVPlH4zGaG/q6Pu0AtRnPOvbQlJbY=;
        b=oU/XdySOCwPbv3bfsVe//QqDB8h1SMigDfZgK2/tVvPfypXX7C+ayZtN1UsDtAtRDz
         OF6R2ml+a+f/c2bkP+LtR0Di8ggbxeVcGy4vr4cvQlxIKBtF/u7SL1rDh1dnj6W701di
         3tlL/qP8dc/2EvuZsgDS4mRYkJvoi5mmPxdOit9u0bbIoavQx2YQ7NTRlryDDR0uzQxd
         vfgPgUw/CVO3P5DGvvo2HiM1YSrFMFOxasK6Vl+ubuADvZyLsnmRI78sYp4pIi6PUrII
         fH7h086EQH507ZrdAtJKzTc2v8w5L/zq1BUxaGosJ85/40svvJsRjcusv/YwMQu+pkc3
         RKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330768; x=1793935568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CIkePRTbQC1KwRVPlH4zGaG/q6Pu0AtRnPOvbQlJbY=;
        b=Q+i+qk8IP4ykuufxRWD6HcUwFmXr2R0RIf81jT4ZXI9bp+yWSBTRzuL9Wzjo4FIPRW
         bNTfn0DiRGOY4SKbE7eiHNuq6sK8xlk6ccb6pT7rbi2D16jZwqhedvHL4gSx+5ZPSvtl
         oX8q8uhw9iM63QOpN5IrkFYMASOjJrV3LeaFzIEslh4k+j0pzXOdL0VixN+yaGcCtw5J
         FsG84cgEG1oKD4G+n+woXhW4lSfEbCsU0TToS/+y16fD48g+u7jnD2Prtaj5BVofzcOO
         xJfUsjL/nUWjid5I3Qxyx7gmEtNfPwEL5Bx9uMhZq83u711hvDY+p5oINrQZyk/Bl+3p
         +uRA==
X-Gm-Message-State: AFq9FYL6LxOHuO/ebzOrFkcvmmBnNfX3WFsLupy0DQvng1kZHPsIMRej
	K1ZdjOC19ul5R7pGairakWB0H+iXbbb1OCBq9sP3shH3peOm0YZk1q4oHxF69A==
X-Gm-Gg: AYBFou1UvexgdzLk45g2MY3ZpNUctVaqHTqiYaYy+jjHC3nozmQMl+xtqkqZHN/Xnqv
	xQPtVAVnbBgqVI9o20JHVZSO43SlWBFc50UmznKUZ9NMJn5DVdqwzdP+izsDEzsBFuSxIXxkICc
	UQ8gi8rE9wZgGioKttmUYPREIdG5livP/M67+STI9eKbFpDrhPetWBInNta0tacPlujLa2D3GBz
	rHMY96BL8TbQH6WMzGjNp0RNnTHnieFbZ1ORO/IsMrjZ9qIRzCYhqQk8dDG5klmZfEp2y3uonbO
	pAAJ/eZt3RMEh5zotWTLTVlWbjq/R5f6KvaHMAZFTJz78J/s7Q5VbDKOOEDNSblaqqBSQ5C6+VT
	R8ohCdsRAH68n1xIfkX1ere9oBLITwL1KIypxbgmlkTVz/s3QigxTt7Rk5Iw3xiqV45x4pkOPSp
	L0K2bn/mLPfgUZ4upPRDRiP3Xzd81VjTGzMwiU0XSG8ZOqShjXA3Hf1XUwtg8GQYnxzD8LmIipY
	nqCdZLehEsxWBWeuanbKIOS6ByLxP+hu6Wujag56lc8O+amV2hWQsiAakDc5CqdcW/XrZ8iCdX3
	bYeKmPyxNgBDC6wiYTuFB8OZovQGwx0nKag2DQOSYyMBL3Y0MlIFAc8e6snWXqn88Re1Xfvcfz2
	KhVa+MduxJZqx6pIPvovcg/SDCrtHWfs02uPjFHTE97DjChglNO4+1Qnyvk3d1rq2mf6XtmHOiP
	l6pkyfjEJ5P3cfFm+tXA==
X-Received: by 2002:a17:90b:2888:b0:3aa:fc22:8aa7 with SMTP id 98e67ed59e1d1-3ae89853f54mr785279a91.53.1793330767435;
        Thu, 29 Oct 2026 20:26:07 -0700 (PDT)
Received: from localhost.localdomain (S0106e0dbd1c8af8c.vc.shawcable.net. [24.85.96.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm2097782a91.10.2026.10.29.20.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:26:07 -0700 (PDT)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: ma.mandourr@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: nVMX: Propagate GUEST_LINEAR_ADDRESS to vmcs12 only
 if it's defined
Date: Thu, 29 Oct 2026 20:25:48 -0700
Message-Id: <20261030032548.2590-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.40.1.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Copy GUEST_LINEAR_ADDRESS from vmcs02 to vmcs12 only when reflecting a=0D
hardware VM-Exit for which the SDM defines the field, i.e. an EPT=0D
Violation that sets bit 7 of the exit qualification, INS/OUTS, or LMSW=0D
with a memory operand, instead of on every nested VM-Exit.=0D
=0D
For other VM-Exits the field is undefined, and in practice it holds a=0D
value that need not belong to L2.  On Cascade Lake and on both core=0D
types of Alder Lake, CPUID, HLT, VMCALL, RDMSR, INVD, #UD, MTF and=0D
VMX-preemption timer VM-Exits store the linear address of the most=0D
recent EPT Violation on the logical CPU into the current VMCS, even if=0D
that EPT Violation was taken with a different VMCS.  Because=0D
sync_vmcs02_to_vmcs12() copies the field unconditionally, an L1 that=0D
runs its L2 to a CPUID VM-Exit reads the guest-linear address of=0D
another VM's most recent EPT Violation on the same logical CPU, e.g. of=0D
that VM's first access to a page the host has not yet mapped.  Sampled=0D
continuously, this reveals the KASLR bases of a Linux VM that shares the=0D
logical CPU.=0D
=0D
EPT Violations that KVM synthesizes when an access it emulates for L2=0D
faults in L1's EPT leak the same way: KVM reports GVA_IS_VALID in the=0D
exit qualification, but propagates whatever vmcs02 holds.=0D
=0D
For VM-Exits that don't define the field, leave vmcs12's value as is,=0D
so that L1 reads the address of an earlier VM-Exit of the same vmcs12,=0D
or whatever L1 itself wrote.  The SDM also leaves the field undefined=0D
for INS/OUTS whose segment is unusable, which this keeps copying; there=0D
Cascade Lake stores the operand's own linear address.=0D
=0D
Fixes: 119a9c01a592 ("KVM: nVMX: pass valid guest linear-address to the L1"=
)=0D
Cc: stable@vger.kernel.org=0D
Assisted-by: LLM=0D
---=0D
 arch/x86/kvm/vmx/nested.c | 34 ++++++++++++++++++++++++++++++++--=0D
 1 file changed, 32 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c=0D
index 9b0bfa2f85..30a71f9398 100644=0D
--- a/arch/x86/kvm/vmx/nested.c=0D
+++ b/arch/x86/kvm/vmx/nested.c=0D
@@ -418,6 +418,28 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu=
 *vcpu, gpa_t eptp,=0D
 		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.ngpa_walk, addr, roots);=0D
 }=0D
 =0D
+/*=0D
+ * GUEST_LINEAR_ADDRESS is defined only for the VM-Exits below.  On others=
, the=0D
+ * CPU may store the linear address of an earlier VM-Exit on the same logi=
cal=0D
+ * CPU, including one taken with a different VMCS, e.g. by a different VM.=
=0D
+ */=0D
+static bool nested_vmx_exit_has_gla(union vmx_exit_reason exit_reason,=0D
+				    unsigned long exit_qual)=0D
+{=0D
+	switch (exit_reason.basic) {=0D
+	case EXIT_REASON_EPT_VIOLATION:=0D
+		return exit_qual & EPT_VIOLATION_GVA_IS_VALID;=0D
+	case EXIT_REASON_IO_INSTRUCTION:=0D
+		/* INS and OUTS. */=0D
+		return exit_qual & 16;=0D
+	case EXIT_REASON_CR_ACCESS:=0D
+		/* LMSW with a memory operand. */=0D
+		return ((exit_qual >> 4) & 3) =3D=3D 3 && (exit_qual & BIT(6));=0D
+	default:=0D
+		return false;=0D
+	}=0D
+}=0D
+=0D
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,=0D
 					 struct x86_exception *fault,=0D
 					 bool from_hardware)=0D
@@ -477,6 +499,12 @@ static void nested_ept_inject_page_fault(struct kvm_vc=
pu *vcpu,=0D
 				exit_qualification |=3D fault->exit_qualification & mask;=0D
 =0D
 			vm_exit_reason =3D EXIT_REASON_EPT_VIOLATION;=0D
+=0D
+			if (from_hardware &&=0D
+			    nested_vmx_exit_has_gla(vmx->vt.exit_reason,=0D
+						    vt_get_exit_qual(vcpu)))=0D
+				vmcs12->guest_linear_address =3D=0D
+					vmcs_readl(GUEST_LINEAR_ADDRESS);=0D
 		}=0D
 =0D
 		/*=0D
@@ -4705,8 +4733,6 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vc=
pu, struct vmcs12 *vmcs12)=0D
 		}=0D
 	}=0D
 =0D
-	vmcs12->guest_linear_address =3D vmcs_readl(GUEST_LINEAR_ADDRESS);=0D
-=0D
 	if (nested_cpu_has_vid(vmcs12))=0D
 		vmcs12->guest_intr_status =3D vmcs_read16(GUEST_INTR_STATUS);=0D
 =0D
@@ -6757,6 +6783,10 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu=
)=0D
 	}=0D
 	exit_qual =3D vt_get_exit_qual(vcpu);=0D
 =0D
+	if (nested_vmx_exit_has_gla(exit_reason, exit_qual))=0D
+		get_vmcs12(vcpu)->guest_linear_address =3D=0D
+			vmcs_readl(GUEST_LINEAR_ADDRESS);=0D
+=0D
 reflect_vmexit:=0D
 	nested_vmx_vmexit(vcpu, exit_reason.full, exit_intr_info, exit_qual);=0D
 	return true;=0D
-- =0D
2.25.1=0D
=0D
