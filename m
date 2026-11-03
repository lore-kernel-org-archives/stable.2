Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672222;
	b=4skixsJZqaq1qQNFmYxq8Td+0O/QnF/pnzzwIPuUC8rdUSXuDyWAH54T8UQoexv3eRF+
	 3esTLkEiTkCspQY7qhts/1A4+rGxDO3rm87hKtLtLUrVCKchLc8jm85v6I+WuVqJt8MrB
	 o5TI3TZ9SVmieLk+HIPSZy8xGjcttKF/42e99LYfLoQ39ywV+32kB7VPcPphInGlZc5tZ
	 NZe/eXF/aK9V86ieL8IBgadyOheZEOl13QofNg4S+EkV+AhqFsQKLrLX1oWD3WIgTo5C/
	 /6b1zBsBq8Sw8gWnHe//qBR4yIxJl8EUr82SXsTDaKDKdSOZK8xyU3hZmyF/a/GLblA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IOGgt4lAkAMwt4N6sT0llhti/KNul9J7tc5dogJ2lwc=;
	b=YCxgvVZBlcLmPgvoYHGaAqs/j3YTk7NQu+R39tAc3cek3XE/6LpbLBI/5TKLkr1bikx5
	 E/6+2pxNC3aKwocSlMwFai9KYTinvGFyDx2XTP516bSwWgaEIMIiQQbdX7VzXfwImh5LD
	 ORH+NkjqtMa4kLcpFO4++bnnZ0wIWg2lGJecbWzfIUc+Mg2FZ4EKUpb8vt9vn9A4s+X2f
	 SRPd7LJ/smDJE3wmfnzOCvif8VtO+hVpfnCdmutYx0wlN0JSTF7O6XZRxitCP+F1s/0vJ
	 GCKKYz42/Gpiye5MgaerJ9GcZZUKwM/xshxikz9vQuWqyAOQLhdHepsektn0sr2ItfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFeGi6oK;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F1606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 02:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8F1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFeGi6oK
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so1553289b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 18:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672221; x=1794277021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOGgt4lAkAMwt4N6sT0llhti/KNul9J7tc5dogJ2lwc=;
        b=xFeGi6oKTGL99bE6SUlm0Mom52pPJKiBe5UZEoYi7l9ccEdN2Bz6NpeweBzDsGuWsA
         SZOmR5SwuDI5YXvjLMiHEZszX7RJ9i3D6Gumrg6kkHP3aNH1oLtxI6nw6dOkY6q2Tn0G
         oRhB7RrweZcmspQuF6ZWJmXlAjGru4eUEWXSfutDspaqzyWdsg7YwKu0UJYECUeyixYm
         3ZyF78/chjzNXBaSnLpa8hM+u9tyA3m6zEB4CCHnwkUlGjBpcwIQx1znQB7Gkfu6ICrF
         BUY7NwMTOg/viqnq93m2jXCqCYiUGlt2kYDVC3PK3hOnLp4kp5CnzZ06NYzX/kZdir+B
         dSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672221; x=1794277021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IOGgt4lAkAMwt4N6sT0llhti/KNul9J7tc5dogJ2lwc=;
        b=XtS2CcaovLQEMrj27ECuLEq+MShkkrFXAISFjYhJwvmqJGSWoop14NMqtpavEcpwzr
         Ji2xdu+9aEouUwSDcmZNFU/YiI/6y0w8kdxEgW+wQM1l3KYtpWkMPEJk1Kj7U/G//MhJ
         HSuk9n5HRUG7OwrO3YU3vzDZ/+sAEPck/87PjKiiPVjtORO2Myo4VmXatC8OgGGED4D3
         GFNU5Hnwr+U/ynoUuI/tL13iJHLGNgNO92hxTYaDFEn024hEEUKgsCrUiKD42HuYVgJD
         VFZA6q1hFPYa2jOoA12PZFBH4AHwIQlYfzU6CCMOJncz3kG4DDzuFgoRnhL35wIDBhO2
         EOhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdeQCFnDcdHQPW2rObrmkaJOVw9XcGhjwhCkKNW4J+hkLylyAALvDS5o7StJAPanMdEXjRCsc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b2kBqES0l8VqrB8UPoiUMA7V3WQOKivloJOsp1FEVYdmM/1T9
	bSAldFc6K5PKHuKCvtP9ap73gu9VuYOoJw54DfqrFaEVny7PcbpGVM57
X-Gm-Gg: AYBFou2rVsCpbmL8UGwYbvUtDuLFu/2PHDaQA4liWIYA11Vr9zF/kTLrD6+Ia/Pjcgz
	OnfPjmr72L0FJVoK8lZBgK32Wm2GfF0PXY/yIMxdT9j+DlX1ZkLDqGjNP9HlVxMrbM7yn5Y26n+
	TzSpx1mFmoXDNcXCOghbcbnZBit+RQ6bvNeIlhq2UPTbVCZn5EySQKpzHjH6yF6tWDFJ5WNqVlD
	bvC2M9CpIhooLDTpfm30h4J6yhzt/TROUMI5vd405c4Vgb84CKx0bIZ7LIf+HED6kxTvUH1tfsL
	akmgCX2Ex/iPNNqxCkoQYZAlOxjadqBKYfbkSUj/z7k53PTTxaptdh8cDZare+dnFEOMgL0siKN
	o/9TbbIWDbQuRx664Q4FKAtfNuP7JYh3cmncEkaKCfukaORNW97MiorumA9c3kWJaj1/sLYfQNA
	ixR/sN9CeCpBhtBm+KU7+7ywh2YfXkbTYlu/wH0WrKqvW3mc53/XulltG7RL8DWFF2h0CKE0cp0
	u5mrJM/ahstKlXebhADrqpq6egNiDjp+SiWR3Kc034vOW2+qwZX5lF/1m6gqKEuLtQbaerG4ZRM
	BWpFAp4pHQamfYG0xwU5bVLqiarN7mMSe7d11PpyWB8=
X-Received: by 2002:a05:6a21:3b49:b0:3e1:d379:f3b3 with SMTP id adf61e73a8af0-3e928fe8569mr7948733637.77.1793672220726;
        Mon, 02 Nov 2026 18:17:00 -0800 (PST)
Received: from iZj6c0kydq3fvfrtx5kta5Z ([47.86.51.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb36448182sm490457a12.6.2026.11.02.18.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:17:00 -0800 (PST)
From: Challvy Tee <challvy.tee@gmail.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com,
	kai.huang@intel.com,
	seanjc@google.com
Subject: [PATCH v5] x86/virt/tdx: Gate TDH.SYS.DISABLE on X86_FEATURE_TDX_HOST_PLATFORM
Date: Tue,  3 Nov 2026 10:16:50 +0800
Message-ID: <20261103021650.924302-1-challvy.tee@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <09c311c6aae214c04a9a55ff6456d7abfe82c319.camel@intel.com>
References: <09c311c6aae214c04a9a55ff6456d7abfe82c319.camel@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and
kdump") made native_machine_crash_shutdown() call tdx_sys_disable(),
whose only gate is compile time (CONFIG_INTEL_TDX_HOST).  A kernel that
never initialized the TDX module therefore still issues
TDH.SYS.DISABLE.

In VMX non-root operation on a SEAM-capable host, SEAMCALL causes a VM
exit instead of a native #UD.  KVM injects #UD only since
commit 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute
SEAMCALL or TDCALL"), first released in v6.18.  On an older host the
VMM gets KVM_EXIT_INTERNAL_ERROR and the vCPU never resumes, so
machine_kexec() is never reached and no vmcore is written.  Kdump is
thus broken only in guests on SEAM-capable hosts whose hypervisor does
not handle the exit; plain kexec is unaffected because tdx_shutdown()
only runs as a syscore op, registered after init_tdx_module() succeeds.

Gate the SEAMCALL on X86_FEATURE_TDX_HOST_PLATFORM before issuing it,
the way paddr_is_tdx_private() already guards its own SEAMCALL in this
file.  Without that feature the module is never initialized, so there
is nothing to disable; on a TDX host the gate is a no-op.

It also decouples kdump from the host KVM version -- a guest cannot
require its host to inject the #UD.

Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Challvy Tee <challvy.tee@gmail.com>
---
v4 -> v5:
 - Update the subject to name the X86_FEATURE_TDX_HOST_PLATFORM check,
   as requested in review.  No code change.
 - Add the Reviewed-by tags collected on v4.

The reproduction data and the host-side KVM log are unchanged from v4:
https://lore.kernel.org/all/20261102073244.919864-1-challvy.tee@gmail.com/

 arch/x86/virt/vmx/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 96ced0494b68..9b01131f7b7b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2321,6 +2321,9 @@ void tdx_sys_disable(void)
 	struct tdx_module_args args = {};
 	u64 ret;
 
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return;
+
 	/*
 	 * Don't loop forever.
 	 *
-- 
2.52.0

