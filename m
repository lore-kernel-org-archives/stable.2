Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170540DFB6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903549; cv=none; b=syvjNSUniU769zFaQWlNip8GM/Gk2/TPVTXYZ3Z43hNlHvJL+2v2WdBNWhmN43y+iYpTQ0kLMSL4KIoAlTRJNXwogjSY4UFbmlVd/K0o8jTlyY73fw+msLVmHKV512kuIN1EDyHI+3tSExjSVapXYTnMoLPxhxCouCRsDsGoavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903549; c=relaxed/simple;
	bh=FgkWTWbqcPdXr4jKYrYqdoWxmHIu+ljUEKnrHgHf4YU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=I8d6JYgrGlqZxHHAbQBQCmg68lxgT55Iw38jwBkL7kVtUT921OBNSFwpy29QyRKIisjX3s7oBcxkM8Rn7+sDE0WRZBfE79KkF/JKHOWVqqaH8eduo8A4UHl/tc82ebjsTyZ3osVYh9U7KHK+JZclHXDa8WhLhQiGn0Q8y6vduXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=YW01WO0K; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="YW01WO0K"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-16079d54c17so3823954c88.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791903547; x=1792508347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZyOz/1gESRgIynZV6sqj/cTvkKIFGO3QAjEEsEdvkU0=;
        b=YW01WO0KSzF6RS772M/ZsMxrcKHCPni9IPUuxQwQ1iIDD4L6E/tYRwES/4eYDk3SV2
         zYkSDyMLj2iD+2BfS0/ts7A5SF7+xbVfzW29EzISiqjMNiri0UdSCwEGrORQmA7WIixC
         hMvWW44IBFtvQBSwvxyshfREWl58lN482rjr/NaUpEuoRnxpl+1bWGVh+ghAFuEWMccv
         x0+WY2t3OwXS7agzCmmjRioF5ED61m9XbRILDNzh+Ehxcdiaz53IbdwrpKi28ZavgRzL
         hQJXO1CwElwXEfiWPJweA6nDMujqDesdmqFhNFTS/PfMwIUfRNX2pEhEDySTOLoXL9je
         h0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903547; x=1792508347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZyOz/1gESRgIynZV6sqj/cTvkKIFGO3QAjEEsEdvkU0=;
        b=MsWsG2P0JDyHSdHGmEo3frmrkIeifqfT3sXMTzKjw9r9NYsH7nQC3eeebbA/JAtXwr
         YU/JBOJhpcRYm4AqRX0U1d8T5j4pgi5lgWnKLJRD2tQr2BGN3YyOCvD6EhDL80SEYkfA
         jVonVSFWjdA9LODLX1Tww712tczi2get1BpX0ZyxZzFoyVht6m6JcrrBajWFxjqgkbD0
         f/THq/HtWtn6vhopP0wqWVKYhs6O8bnaHsHml6Qc1j+vHU4hn8afWnyz7TNbnMARcIw2
         oEg7MYsEVSNDfWslNPDjeyK8/T+lsj/SUO9mLjeIV2y17KKjGE8/puKLWbmqmgXRGE64
         zJiA==
X-Gm-Message-State: AFq9FYKKsXEreaJJmTPZwa9ISUPcOTC9RibnczGCQYUDfLbt0NT5prn8
	dMwKJPb/nmQOPW50yhGXrhdkSjy4aTNco5iqcd6CZEb7zBVg7+exhTjfFPag9lVqtT/AcPRFoHq
	kw6N8
X-Gm-Gg: AYBFou0oKvxMsUJRhNeSM8Ij3/yFe6QQR3IDY/g4X3zX1eOnIn0OFcmH6RJTRJf52Lu
	lK7oQILvTQLlKlFRr93WxBLgvGJjW8mpU08JGDUHFXFrLXuXn0jN0LcuheTASdnRYaNmb078q33
	l8GGolQCGxnJh4k0rPDcA1Wp574CIC4x7BJNtSc8oLLNYR7uoKHjJgR7WhSaQhZFJWcfBlwTH3q
	WP5j+wXIeXwSgfvSzCp24R2kU3Na6qjzOs2NJFKxuiZ0VLkLV0P7wQ9C+J9Eezvh1ujpgSupriE
	E1y5Jh/3LV6qaPXrB7dyC/EJiXPD9YPhbrDecw459RE2osRYMJUxgCuiA+vk8TIIWxKf8NPNZ3w
	YBBPJrTIuLzXjOAJx2NB+XfvpaxPXqKeg7hfY2Q5W9d5yCO5pZRMVlz8CLurdVqOChHvhY+ZTRv
	7Feo4ja5Y1awmWGajHXV/2e/vqtAYLP6L/SDpbqIt92BJBABGM9hIsbPtgkojmtfA=
X-Received: by 2002:a05:7022:1581:b0:149:50cb:216f with SMTP id a92af1059eb24-16a5ef287bemr23520577c88.33.1791903547233;
        Tue, 13 Oct 2026 07:59:07 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm60541057c88.18.2026.10.13.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)undefined reference to
 `crypto_krb5_get_mic' in vmlinux.unstripped ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 14:59:06 -0000
Message-ID: <179190354625.263783.217366201919821901@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
undefined reference to `crypto_krb5_get_mic' in vmlinux.unstripped (net/sunrpc/auth_gss/gss_krb5_seal.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
  LD      .tmp_vmlinux1
ld: net/sunrpc/auth_gss/gss_krb5_seal.o: in function `gss_krb5_get_mic_v2':
gss_krb5_seal.c:(.text+0x1cc): undefined reference to `crypto_krb5_get_mic'
ld: net/sunrpc/auth_gss/gss_krb5_unseal.o: in function `gss_krb5_verify_mic_v2':
gss_krb5_unseal.c:(.text+0x13f): undefined reference to `crypto_krb5_verify_mic'
ld: net/sunrpc/auth_gss/gss_krb5_crypto.o: in function `gss_krb5_aead_encrypt':
gss_krb5_crypto.c:(.text+0x18bb): undefined reference to `crypto_krb5_encrypt'
ld: net/sunrpc/auth_gss/gss_krb5_crypto.o: in function `gss_krb5_aead_decrypt':
gss_krb5_crypto.c:(.text+0x1a5c): undefined reference to `crypto_krb5_decrypt'

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:174c2fe239c0fc73d0c58b91a55db7ce48eefafa
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b12a02dd090ec1b0b00fc16d1be95e7b53677ceb

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6ace2919a3f195e1aa7582c9/.config
- dashboard: https://d.kernelci.org/build/maestro:6ace2919a3f195e1aa7582c9

#kernelci issue maestro:174c2fe239c0fc73d0c58b91a55db7ce48eefafa

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
