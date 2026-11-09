Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226906;
	b=rrtG5/f0dCAhLXGFX9STS4pqSuI/mxJudJS8uhGVQw6kUWtv9XMOhoV+/RYoVemLQFJv
	 8b9ilOEN+vvZAZwfpXTtBRkAayeuYn6cfd+RhxKaRb2ZnaHAvM/CkTr78lpvmkUq62TZv
	 3H3iYnNLDfXm7kNKcKsh+kqfjI4cqaeSgTVqBu/ZBElGj8T8JQQAhcn3VG8VFErWoH8gg
	 C+ZIDVrpMhDgZJNTmvbmBtWv+1Ex6dQhKAJ2UAcaT5HDxwflxh6Nj6syT3oA/x0CcabrN
	 a/XRvyZEMifeI5OVyg2JWbhcvWYYXqS73dTm1iz91EMum+jvcVG8Sr/WkZdWjXZmFAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dh8J4WIzy/Sl92ybMwtL5Uf6n1C8v5ZRxzClxO+l8mI=;
	b=OmnYYfvEpSN4yEjZ4iBQUFiUeQ/CvNndg9zrZpvlHJWmO0Hm4CoB1gT6J4EOatxf9Wxa
	 7lfqsZxwjZyxt+aK4nwPsgVjjcumP/LNg9EoggDpw8GUsAIcsXDQhxqWXX1RYXxchNLkT
	 RJ/pOx4xc+1gkjEMuzRoPs8ibs3VRxlmaXZSFm6gz+Lw8AhFrfg2Vlqoo8iw0a0FCZcQX
	 kAhn0xFrobEM0yK3Xrfl9SGHr9tpmBYuVwWGM59KIylAi0LR5Tcb280zWDuTnHrTSvFKX
	 9PIImJ3b4i5HL7v+dyGxdk8koEdqojU2/OHS9XcHyzdNv9Ej9E9BiCc76eiVEe/v7Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cyondodg;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E1606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cyondodg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso5730365e9.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794226904; x=1794831704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dh8J4WIzy/Sl92ybMwtL5Uf6n1C8v5ZRxzClxO+l8mI=;
        b=cyondodglzYVSXdMVm67DKsysVmpLxXgwFwy1ps39y09WZ3aN2Y0qLnb5AWeNKzM89
         nz6b8pefY3YOcsuiby1hNe469WUPmqPaLeGYBS0XQcM57UUDVMPYkJAIod5ybpGi80V/
         EkMBHtl6a3vonzuBhPKsvi0DWc8gjjvj6rp0EFob++xdQr2gyjUqH0qCfVWWcx62kgQL
         O/0o29Hb6Eh1RKr/+zzym1mRHwKGiJIdHhApieBnPSYjB39s1t7cppPwfAWWCAZ8QJUa
         aZq+Ru5H4mETYhmSmMqZErgw18IIeLGXzNKGzKdJiVuDuLGeb4QfQswIdYpKczaEpOlN
         ns7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794226904; x=1794831704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dh8J4WIzy/Sl92ybMwtL5Uf6n1C8v5ZRxzClxO+l8mI=;
        b=A0pM0FbAyVTBzvbjDhDuOcNSz9DD9qiKdTQQRxPm2TIeAt3nSPbYasiRYOX7Kc5+Tl
         jxLjZhdVz5kvEzbNFO4jD2cacLETFTTcp7XDHc58JgdWlb03ns2/EOz/gdgEK0GjTP7O
         euGJj5qz9tJZSenWZRFevTIA9O8X9oVKf7fIoTi++VoKG05qLf8Dyy0IJc8QnzrigEyG
         16EXYKVLuXZBrmfMuHdCI+uUXsCrw/nQlyz5vgQQFcsGIEYRKGhoh25kRZ8KmigBvjRD
         Wis+5q4MkgttxDuYR5+Ie+zfA97W0qFOLMDrYU5755BV8tCLYebsoK2gDaPT0C5tIjfu
         pzVQ==
X-Gm-Message-State: APuU4Z9zCINeqlEGcFxHMpPm9hGfrle0Ic8Zq0V1kKt8xLxMN3kUAQYE
	gC03YAOxQ70EEKQjWwwW5eaXTSmsbUylJHbAWxCoCgiuGuF8Wl5X84WkhiqMFkFny1RCiuVLDX4
	i9QACnvXdr/IU8PZvHI7ucmV+lLS6aknu/h30jTMA6kh+WF0E3b5VgwfGVshBNnyJ65hFiO/7cF
	6qUf/9nhSuwZrajzYn+PyrjOGJgQ==
X-Received: from wrrn17.prod.google.com ([2002:adf:fe11:0:b0:48d:ed12:7c4c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e0a:b0:4b7:6aac:7406
 with SMTP id 5b1f17b1804b1-4b94d762f58mr73006055e9.3.1794226903857; Mon, 09
 Nov 2026 04:21:43 -0800 (PST)
Date: Mon,  9 Nov 2026 13:21:30 +0100
In-Reply-To: <20261107052256-failed-6.12-4c86b5f3fa78@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107052256-failed-6.12-4c86b5f3fa78@kernel.org>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261109122129.1396402-2-ardb+git@google.com>
Subject: [PATCH -stable] efi/libstub: arm64: Don't use the platform register x18
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

commit 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397 upstream

The UEFI specification designates x18, the platform register, as "do not
use" on AArch64, so that UEFI code is compatible both with an OS that
assigns a fixed role to x18, and with one that uses it as a temporary
register.

The arm64 EFI stub and the EFI zboot decompressor only avoid x18 if the
kernel is built with shadow call stacks, as that is the only case where
-ffixed-x18 is added to KBUILD_CFLAGS, which the stub inherits.
Otherwise, the compiler is free to use x18 as a temporary register, and
it does so.

So pass -ffixed-x18 unconditionally when building the stub for arm64,
so that the image can be run by loaders that rely on x18 being left
alone, such as a kernel that uses it for its shadow call stack.

Cc: <stable@vger.kernel.org> # 6.12.y and older
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 1141cd06011f..d33c02e58717 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,7 +22,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) -ffixed-x18 \
 				   -fno-unwind-tables -fno-asynchronous-unwind-tables
 cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
-- 
2.56.0.455.g6c5a503b38-goog

