Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA836F90F;
	Mon,  5 Oct 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228310; cv=none; b=qDmdHgCcBJbO20Td0m2S3bJURecpIdvPwo6XyQl4MF56Uoqv4ob3x36La/7aioV/16MANBWZgLNRyp2StYboqIcinKey+tDpY9EwBb7zY74Bo/F4BU+Yu4Zv829rL1lz+j/76XLADav4hayLIB00g/dJOFHoZWgommunZVLGiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228310; c=relaxed/simple;
	bh=IcMCy1BpxxzOLPSJoQpWWKhGobFTWL8y9Z7+zF3Py+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+gCUhShGxMK6btlNMOi2A6ujUfBcZwpVeTVFrYitPJvUZ6qJLyL/WAXBGvqKBRomn8oBIcCKo3AS9Y1PFfCj8jiN/7U4jvey71QtW1b2IezIaG38nVHbnafByP+nsw1+9+YJZo3YTO7yFmGtLhimmwjIoNWGlJifdiETx2wlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=kbP//JLU; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="kbP//JLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791228309; x=1822764309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pBzhWTQqV7vxLHqMhs5QguBarICwF2gQlMnNLRLjn1M=;
  b=kbP//JLUHtpTiYIoKtJvWtKsxl/wtnPrnh5V0pU7Yn/LVYK44GrdBHdn
   BY1p6JxA6oK+QT2VQN1+4DCwbM1zFzxrtaPtHSNOXrfYc4RqJ/vAhul4q
   IPvOPXiZe3j1uUXvzOrdtZMxcpDd7pLXB4LMI0IWLYF00qSwOnMB+vodI
   mYmL8afEVfoorwUs9bnt1ClsZad8uGMzvmGFFJw0xpSrxzUKuihiGEAE7
   jzq8nMazWqgu0VV0YBT5HTczINZQOhmYuZ+mayiV2tHMb3mRF1dBtJEcz
   pbmx0xIsaEq5YfA+vEQrmiQwBcseXYg0OScJMZW5d+RS1wL0dXFipRwsK
   A==;
X-CSE-ConnectionGUID: bAFl5INlQm28wY2iD8ZLtw==
X-CSE-MsgGUID: V0dp0rMxRlmsPSEHQEiKFg==
X-IronPort-AV: E=Sophos;i="6.27,142,1787011200"; 
   d="scan'208";a="30274200"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:25:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:13135]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.224:2525] with esmtp (Farcaster)
 id a8061274-541d-4b4d-b928-1db1c1454e98; Mon, 5 Oct 2026 19:25:05 +0000 (UTC)
X-Farcaster-Flow-ID: a8061274-541d-4b4d-b928-1db1c1454e98
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 5 Oct 2026 19:25:05 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Mon, 5 Oct 2026
 19:25:03 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>,
	<mushi.shar@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
Date: Mon, 5 Oct 2026 19:24:29 +0000
Message-ID: <20261005192431.87317-2-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005192431.87317-1-hmushi@amazon.co.uk>
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

free_nested() frees vmcs02 but leaves need_sync_vmcs02_to_vmcs12_rare
set. The flag means that the rare guest fields of vmcs12 are valid
only in vmcs02. After vmcs02 is freed the flag is wrong.

L1 then executes VMXON and loads a vmcs12 with VMPTRLD. The flag is
still set, so the first sync copies the rare fields from the new,
never launched vmcs02 into vmcs12. This sets TR, LDTR, GDTR, IDTR,
the segment registers and the FS/GS bases to zero in guest memory.
set_current_vmptr() re-arms the other lazy flags at VMPTRLD. This
flag has no such point, so VMXOFF is the place to clear it.

A nested Hyper-V follows this sequence when it resumes from
hibernation. It executes VMXOFF before hibernation. On resume, it
reloads the VMCS images that winresume restored from the hiberfile.
VM-entry fails with exit reason 0x80000021 (invalid guest state) and
the guest hypervisor resets the machine. vmx_leave_nested() also goes
through free_nested(), so KVM_SET_NESTED_STATE takes the same path.

Clear the flag together with the other nested state.

Fixes: 7952d769c29c ("KVM: nVMX: Sync rarely accessed guest fields only when needed")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5.1
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854cf..6c3723ddd40b8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -350,6 +350,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
+	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = INVALID_GPA;
-- 
2.47.3

