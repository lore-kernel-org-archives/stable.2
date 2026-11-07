Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065829;
	b=c9gEUDJX/NKnbfSUHAYUzqcevshT6NWCap8QfaYzFmHdlFv28EruqNS8da3SpmWQ8wKP
	 z6G/QPwGbGDy+daTxTP/1r4ojH3KxAAQID5yimpNskcgz49703EKdOqkA2PnBtqD/V/Ok
	 jZfmpHqlujTIdArBHsDqPnIeHiexoo8IpnrHOAUDZ7MXeIXcgznIX4pE0h4OrEHmlndVj
	 VUNec9fKG46S+GZ3f6WiTyHqLcsqI06uxGrFq9oMwDNPxMCJKhtbaEzeKS/mDeH5q/8rl
	 tLY11O3fa5ZstPIKtoLyKMy5ktK7b3YVq6dryGgkC301T11QqyPK8Mkg63LgA6wxp1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QyPiotEtbjmbAknxSU0jdiIPb/Ej3HeKpoXn1Xbs3Mw=;
	b=0KS2sJYQFsDW4KQ7UnW35XvFk8ZOlIIjqxYrJ+V6iXp9a59HljkK7T1WtA1eCuQHCb4F
	 YzHGYvG5VENIUzXOH7/8AzYrFUSrOswhQZreQo4xrKnAielXkMPDf8OBVLKTausw7PAh7
	 BEYnvXjCmThkDZksiWutlzW7AM1s6SygqlxHfIfcO5ue30X+bSptdZNwUuViasBynCDnm
	 6+f8oGmRRriZi2uSVVXbjUyGJoOPkS8kKoN/hwAnN/EWZ0Zz79FC8dsoQH/jBaAE+CX0H
	 xdzfbvzf9aAhnwaU4u44se3Rg9zgQOtLCUYs8WfCLtsLraiXS20dvXjWMUO3IeZZMBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ptosi.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIAb29vk;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434F606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9434F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ptosi.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LIAb29vk
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c41b03cd1dcso155936966b.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794065827; x=1794670627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QyPiotEtbjmbAknxSU0jdiIPb/Ej3HeKpoXn1Xbs3Mw=;
        b=LIAb29vkIJQJ2Ba1LhWhDSuBDjZgZjv7bWSdJeifU/eLM+5c2CM+e3DVE//jukFgQO
         eHbQg0zkcecY1aP91HD/VC79DSx8aU8JZ1IVHb7j2sDKwhTKXZPFJT0oBbBPrEioXMCk
         ukFKjKXyeJT1tltrPRV9wSNGtnXHIFc1ouxGKDVSnITnBm+wx4VB5YpdjsFo7ugwNH/B
         HulEpjQhewXS2Bq8/VkbvYVQKkwVpeoMidajAi7Vxrn77UlkWGTZryNsFCn9ehjBO5uJ
         mTVsBmSonJhh8SDNv+8IxeBak38QN+cuXmYnfuHI9ePwQsCfWPZbBOI+nPXuOqhiQ46p
         urCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065827; x=1794670627;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QyPiotEtbjmbAknxSU0jdiIPb/Ej3HeKpoXn1Xbs3Mw=;
        b=JXvwMNx61z0rN2WfeVY7KdClVSGtKwGCwDPaw3peXwB+4lDShAZNV9xth29RJq38nk
         5gzRKzg0kF4+8GR5bLGmEypfaZHZkguNfv65mq0EevR9ZnFq7dGdAdE6EJOSCHQYWT6G
         3jHApCIWK/iE6O07IvFka5P4PPznMt5zaM8pINVWMD3D7iPS4+Vqsby9TXde0CIv1eeA
         CCDPAAJHmmQdQGNf//WBfAcHykl5VP4ccybeJpc117ZXsKamL4VwBxpOaxUbIlxe8k1v
         FgYbAn2GqxMdhWNMyVUKtLhQNUYWstwKIWhRW4oSSlDqDkVudcxGMPTDYLYUe6nMJYxr
         jPlA==
X-Forwarded-Encrypted: i=1; AL+hErEmHGkEiT4eIWjOtBAWqauNsUoD3FlBvGWD6IOKHMoyIXJ3RD69D2dl+oXFqErP81e3CpJ4+x0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fXvDIHK4B3U9qx0kJBM09zJJIm3jcl4azLusS9IIU7t4zM5ET
	zmRdloalW3Sn3KriDK3dTxzx60KNfpb/hchqu9PmsxkIrq4krvjERtcTvfJ7c4H6tdXJ84+LY2o
	s5Q==
X-Received: from ejih2.prod.google.com ([2002:a17:906:2dc2:b0:c31:9613:6217])
 (user=ptosi job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:9f8a:b0:c40:d920:747c
 with SMTP id a640c23a62f3a-c4d3449c10dmr439396066b.7.1794065826487; Sat, 07
 Nov 2026 07:37:06 -0800 (PST)
Date: Sat, 07 Nov 2026 16:36:06 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGZF72oC/x3MQQqAIBBA0avIrBtQg9KuEi2kphoqCyciiO6et
 HyL/x8QSkwCjXog0cXCe8wwhYJ+DnEi5CEbrLaVMbrG7SRcgoSIcqx8YlmVlpxxo/c15OpINPL 9H9vufT8GvSV/YQAAAA==
X-Change-Id: 20261107-mte-kasan-split-3632e818f997
X-Mailer: b4 0.14.3
Message-ID: <20261107-mte-kasan-split-v1-0-d84ea5f30f94@google.com>
Subject: [PATCH 00/24] arm64: Decouple MTE code from KASAN support
From: "=?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?=" <ptosi@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peter Collingbourne <peter@pcc.me.uk>, stable@vger.kernel.org, 
	"=?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?=" <ptosi@google.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

MTE is a hardware feature, KASAN is software infrastructure.

The direction of the dependency should be clear: KASAN uses MTE.

However, the code does not reflect this split: many mte_*() functions
are actually only intended for HW_TAGS such that there is no way to make
use of in-kernel MTE functionality without enabling KASAN. Furthermore,
there is a lot of unnecessary indirection in those functions, causing
duplication, code that is harder to follow than it should be, and making
it easier for subtle inconsistencies to hide.

Instead, this series aims to untangle the two into a set of reusable,
arch-level MTE functions and a thin wrapper around them that KASAN
needs. For non-KASAN MTE-related code, instead of attempting to reuse
KASAN functions, break out individual MTE primitives into KASAN-agnostic
functions and use them where needed by aligning in style with how other
features are supported e.g. during kernel entry/exit.

The result of this rework made some bugs and inefficiencies obvious so
I ordered the patches into 3 sets: first, bug fixes, then, functional
improvements, and finally the refactor. Specifically:

- patch 1 fixes a bug in the support for userspace MTE, with a kselftest
  reproducer in patch 2
- patch 3 fixes an unsound inline asm statement
- patches 4-7 address inefficiencies in PSTATE.TCO-guarded sections, TCO
  lazy clearing, and harden TTBR1 address categorization
- patches 9-12 rework MTE-specific code in arch-agnostic KASAN, with an
  arch-level early refactor in patch 8 to keep those minimal
- patches 13-23 then proceed with the methodical untangling of MTE
  from KASAN, leaving only a thin KASAN_HW_TAGS wrapper in <asm/kasan.h>
- patch 24 introduces a hidden Kconfig flag ARM64_MTE_KERNEL, to better
  document in the code when logic is required for EL1 MTE, as opposed to
  KASAN

This was tested on v7.4-rc1 and applies cleanly to arm64 for-next/core
at commit f46be4da2cbb ("selftests/arm64: GCS must not leak on a failed
clone3").

The following checkpatch.pl errors are consciously ignored:

- "WARNING: ... does MAINTAINERS need updating?" on patch 2 for the
  new kselftest but selftests/arm64/ is already properly maintained
- "WARNING: Macros with flow control statements should be avoided" on
  patch 5 but the new __raw_{get,put}_mem_tco() macros are intentionally
  consistent in style with the pre-existing __raw_{get,put}_mem()

while the other warnings/error are false-positives I fix in [1] and [2].

[1]: https://lore.kernel.org/r/20261107-checkpatch-asm-complex_macro-v1-1-9=
a7b3c69fc28@google.com
[2]: https://lore.kernel.org/r/20261107-checkpatch-file_path_changes-v1-1-8=
b11814560d8@google.com

---
Pierre-Cl=C3=A9ment Tosi (24):
      arm64: Fix lazy TCO clear when enabling user MTE
      kselftest/arm64: Test lazy PSTATE.TCO handling
      arm64: Fix volatility of IRG inline assembly
      arm64: Skip TCO on privileged uaccess without kMTE
      arm64: Check MTE once per fault-handling section
      arm64: Harden is_ttbr1_addr() on tagged addresses
      arm64: Skip redundant TCO clear post-kernel entry
      arm64: Introduce mte_get_reset_tfsr() helpers
      kasan: rework hw_{force=3D>flush}_async_tag_fault()
      kasan: rework hw_{get=3D>set}_random_tag()
      kasan: provide empty stub for kasan_report_async()
      kasan: drop mte-kasan.h from arch-agnostic header
      arm64: Introduce set_pstate_tco() helper macro
      arm64: Add mte_{enter,exit}_*_{kernel,user}_mode()
      arm64: Refactor and remove mte_disable_tco_entry()
      arm64: Refactor KERNEL_GCR_EL1 out of <sysreg.h>
      arm64: Introduce MTE & KASAN tag handling helpers
      arm64: Inline and remove mte_check_tfsr_*()
      arm64: Rework static branches for kernel MTE
      arm64: Move MTE insn wrappers to <asm/mte-def.h>
      arm64: Introduce mte_tag[_and_zero]_range()
      arm64: Consolidate MTE-based KASAN in mte-kasan.h
      arm64: Fold <asm/mte-kasan.h> into <asm/kasan.h>
      arm64: Introduce CONFIG_ARM64_MTE_KERNEL

 MAINTAINERS                                        |   2 +-
 arch/arm64/Kconfig                                 |   8 +
 arch/arm64/include/asm/kasan.h                     | 103 +++++++-
 arch/arm64/include/asm/memory.h                    |  14 --
 arch/arm64/include/asm/mte-def.h                   |  65 +++++
 arch/arm64/include/asm/mte-kasan.h                 | 266 -----------------=
----
 arch/arm64/include/asm/mte.h                       | 189 ++++++++++-----
 arch/arm64/include/asm/processor.h                 |   6 +-
 arch/arm64/include/asm/sysreg.h                    |  17 +-
 arch/arm64/include/asm/uaccess.h                   | 106 +++++---
 arch/arm64/include/asm/word-at-a-time.h            |  22 +-
 arch/arm64/kernel/entry-common.c                   |  58 ++++-
 arch/arm64/kernel/entry.S                          |   3 +-
 arch/arm64/kernel/mte.c                            |  72 +++---
 arch/arm64/lib/strlen.S                            |   4 +-
 arch/arm64/mm/copypage.c                           |   1 +
 arch/arm64/mm/fault.c                              |   2 +-
 include/linux/kasan.h                              |   8 +-
 mm/kasan/hw_tags.c                                 |   3 +-
 mm/kasan/kasan.h                                   |  14 +-
 tools/testing/selftests/arm64/mte/.gitignore       |   1 +
 tools/testing/selftests/arm64/mte/check_lazy_tco.c | 152 ++++++++++++
 22 files changed, 649 insertions(+), 467 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-mte-kasan-split-3632e818f997

Best regards,
--=20
Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>

