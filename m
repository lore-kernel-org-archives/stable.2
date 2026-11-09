Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229386;
	b=XZFrSv+V5F+/sm5Rbf20ZmRm8hJ5uEgV7gILpww09/yDXWiRCCV/aX57jP7is5TdYWZh
	 67egfyKd/+4tp6753Iy5+kLH+iy1nkIFjB9m6cR16VBvLYcjUSjM2u51aYBSMoJRIdcYT
	 nuGpu1SK1+JD1BK7+TrzPAvxfWvbby/dQnPxVgODyyJ5Q1Pmz7AazZicaaiRTpoc4Y4p0
	 z2Ne6XQ8/cbJSWv8NCkA5xwglIsHYsTelfEeDS67XuExD+gz9SBu2jufOQ8xQ7GYcNZWO
	 29R6x/CR7zQvPwj65GsGygVazfwBEygO2hL/1WfQjyygjJT3sdfC3QbEp/gH1L25Vfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6ntnRzRii7PMIM5kIwZkgOwUQcqbV6rzAaDPaRLXp24=;
	b=fRo3YQDo9kXTL0ozbrzMAFLkNXc+un4Q4qZXflFIZg5bhl7xMHGOqIcTbOrr0GLgzrKg
	 iq+U6Zxgha1npLpXTgkdlf5ZBBKFuvOzCoKpnnxQMWN3CKAwo+J/qTES+FJcrxg8en+Vf
	 ED2ZDijetyCK1MIiA7SG8956JdA8xTJwT0xuwfPSJ/+HkuoTeBdHAhJm91B6kQuNU2eI2
	 76UFBLaCXF8uO97JOEG6Q5oR+6UTE8ipdoZusZwNoDO3NP5sCTV65b8PYOFdF+/skxeR6
	 cuFBTBhFZNT0OQg857Nn1FT5kLnspk4gelF9NhaxEAfyaHkEMiTihJOPnpE3nTad+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNVYCWNR;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0AD606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D0AD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNVYCWNR
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c3f88d2ff28so69606166b.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794229384; x=1794834184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ntnRzRii7PMIM5kIwZkgOwUQcqbV6rzAaDPaRLXp24=;
        b=dNVYCWNR0f3EmehO2rJdjGGbvxaPGjlWeEvLT/iFsjRPlmRFk0r7Jp0DuWvC6RUcTO
         Efhaa0prZnzxDJJGlR+ymYcJeT2D2xRaWS/ktrc/DtQ8AyetusG2e6xNxqDTMbjIfuYM
         rCsOY+5S2ixT6uX8LCIcJ+NFLQi1e78c0ZkOg/Oc4h0HyEYIP6/6MbiMqAG+2EwImvfW
         Wu8sgei2zpUK936QKdX5l1T9EGkdINFKOWdmNFPehCHDG8GZ/x6smpF7WrvKsed5eEFO
         SbTXDVLCC50Dz6RrRLfa4RV0v+1HAeQaaXPErGcxpSOzMACspeZIAvM3ddm7iTZ2xz8y
         4sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229384; x=1794834184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ntnRzRii7PMIM5kIwZkgOwUQcqbV6rzAaDPaRLXp24=;
        b=2ZeJ6fp5qPIsq5uBZ5p1DUzA1AN29Wk2DUYcZ4wmVwthJCxMYKXts1n/7dLGqT4d4i
         8OzA1BaxjIZjjOycrBchBMYuihg2CTs5Qfeu57ouzzRvPckCRQNQnn7Oc9YZsKxQGmEQ
         WvEBD+vIST8FJBL9sYxif20viSG/c745TF+s9Qgk5YxMXcVhGmKP3KT2HrEp5vDRqByL
         qd1F0OQMtQcW38vcDsDXED0+bjK/OwePM1QSaTnWg9Nsk+cbb8bGB0I3QxlSAvFbCb9y
         uc197C6+rCmqZynmCI28hHJS0CScQqm39aJI+mitAE0UdoUsCDDFwmlOb5OfA7CEaw7r
         Cgsg==
X-Gm-Message-State: APuU4Z8k6xmBbvSSosWfxUZ0tCP/8p7cssdC5pphYnnMEFxCI+PWNKVw
	o6x12VQIOE0BECYCyniFV9AWwcREL3QHhUt3EgaHgxJ131zoTDCt4qH9GNRODBXpOWMMdzuS/O3
	Tm5PYLQy2n5i4UC5UO6RrfAdC58KFmoibOkPD0m+zqMHWKobePjO9G7FUo41PPI2EN5aOuIkDlh
	MDcHGtQbPYilVaz7NYnpTM9K+0AQ==
X-Received: from ejh14-n1.prod.google.com ([2002:a17:906:100e:10b0:c41:2f3c:50f9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7b91:b0:c46:645f:cee2
 with SMTP id a640c23a62f3a-c4d6d994688mr313182366b.4.1794229384107; Mon, 09
 Nov 2026 05:03:04 -0800 (PST)
Date: Mon,  9 Nov 2026 14:03:01 +0100
In-Reply-To: <20261107054932-failed-6.1-4c86b5f3fa78@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107054932-failed-6.1-4c86b5f3fa78@kernel.org>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261109130300.1484407-2-ardb+git@google.com>
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

Cc: <stable@vger.kernel.org> # 6.1.y and older
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 748781c25787..b85d3cae997e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -19,7 +19,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN) -ffixed-x18 \
 				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
-- 
2.56.0.455.g6c5a503b38-goog

