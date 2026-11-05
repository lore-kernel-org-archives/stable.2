Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920360;
	b=0iOpN4e13EnGWAz//SoZebyD84KVby8JrAkj4pw1NgLdFhPCNGdP/zf2OELSVtMOhyai
	 /dptc9WOhjYOEMkJ3sVSj8DtQT96xguA25hLyz37U1iEAilRS14IXiIDT5o4s5nt0xGcH
	 YvrBrabZvpGbmhE51MPaKOi6JZFL3ioi3n1o48u8uCBRpeTgjFwZ8OPw+lIpXZpwNn0ep
	 9GoHvXjXBXrTBwCrgqLGAxxxgBPswJgP/bfYQwPUSqeNEUsGRpUiiR5TQS17e7pGNwHYQ
	 wVtt4Ks+nIKwe9qAeDxggKVhvO94Z93vy8FCLYNY/EyyZYT94X2szmKptBsIycZX2tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FZlN4iHbDXpMMqj+PQLfEInqStv2KX2ANmZPpiwXjEg=;
	b=WjWnKngrxO/0JnaCGoS6mswKJwil5Vgznigb3+izXC2bcXVKPM+Izix1e7ZRG7jp/wOV
	 EV5e7SGTGhltvykCMimhEgLfM8Rwl8XC3O1vMtOK071a3fGakljWq3m3uJRZL/iGUM6wH
	 GQAVFkJtoDEyK6omgNgqOJejxXCJ4t82vu2cvjHc2JGBck88uE51rlsuKsrxga9fh9Bg0
	 kFtwVvlwacgSn0NL0ZQe/vd8JikNsCpFS8B/sHOUh6NYPjof1BDlqqiiUoWZQ0zruJB9w
	 QYW1ALvZt4faPJ5sS+YXITWu2DEJsISaxT0HOdHHvA3bDKsPOZaHF91v5qatyINZrPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GPyWKVmX;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19291606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19291606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GPyWKVmX
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so191030c88.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793920358; x=1794525158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZlN4iHbDXpMMqj+PQLfEInqStv2KX2ANmZPpiwXjEg=;
        b=GPyWKVmXbRnHFHyAlQNZfvqo0xBU3poeqVkh6j0bhZztW1KrN3eCJPerMSo1gDtO8c
         6JpfreadEoFpRXdnLzNopzlCLOHXCQN3whZcr9fISD2NsgfstmVO1YWJrPvV3g+TutE0
         VtHd5nvVbO8rWPla6m0WZpDaMDYdRk68NSnk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920358; x=1794525158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZlN4iHbDXpMMqj+PQLfEInqStv2KX2ANmZPpiwXjEg=;
        b=UZNfHtKgubvAsbmAakegq9X2Peb8kFKxs5Ah2kA+IGjkUcF5A6kVpaDd9uAB5Ut8tp
         6kA3MiC//wBlsc5xmPcD9sZicfkYh0n9EiWVpb0LJF1rOdulIiZpRI2abOLP+cwzcLFn
         uaAocWjtl3d520DS8PX9laFvbzyKv8FQYEC7QjSOTd+RaSMEjq2P1LOvebUi8UeFnODb
         u7/Tq0xRTOGzV4vIh+Fms9BEGP+Y+XMm+UgwgUIbbMXqOYTBjg2Ku+lkrnzpJ0gggZkv
         Rc4C+lse6Ze5bdSTkuI5bGYBYNIgosllArFJS3M+OxxdzcQAq43Odkywr5pLyAv6gyLe
         rGyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwG2Q08z2LeARGZLLQHteBpSorSiV+AEXcjvNSufMUaR+5n1IFdE4rGpXrgY0klNvzuvKPcIXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IgcOtIuB0oo9h8A+v1fHQ4TM3zWqFc/chIAD/gc6oTVQMIQ0X
	7O77LulnoWeyDhW89u9AFHoMPvm8VRAiduPDG9RHqaPT5l+UrEvqMLFPnoUVXL/hug==
X-Gm-Gg: AYBFou342S4Y9/B1vd36SHN5oqUVGJMDjdzr77QbAuyn7KCwVg1riHUEIRMr49Oc9VW
	1oXGtt+vc/lLiM9WRQCX1Gh3zElj82QeUB3HLsgxAuzyXFZR7xAz53HEQxIm2+sskj/snIHso23
	Ev0pobWurcn3kSlVwDGB/WK/I5wBR1qZCb9qA/sU+GAmL1ttsfRVSy16QSZM0zSlNrmT6D28/+i
	MyQBRz6kmJehqZ5YMRUVIGqMjZUYp/lACkRLjulGPuLYdUOG/zFjOFW7CyNhHi20IKfP1+EJ5jk
	1QHF/OrBYASFd3uc6Tm3+xKULODudizBaGTeTbHZKEIWR90ud3RglgTaP2S891mTpMuaMQBEQSL
	Nd79DbeSZwhyEsKRsjb1L3rcnfXq3/zYNwegKGnRa8wJHhR6aiBHWC2+FY29zR0Tsd1nEHWGCyO
	RsGE+xKH/UzduiS26/SqOCQuYlb1IOT0BFJPIGBqlIMgUitffQaVUxeh/bh9/dOtiDZld/w+p0V
	DP0dKYAY3alzkbsH53MFLiLhXV9i9zUEunreDPQ0f8OnXd/EvpyAQQoTCWolbrfS/WU8UeR9cK7
	2xb3f6Q/toVH439Ew/hmeWI34lR41fP9c4OGYpFbDug77rHkPfPf8AUNNoosuo1zVgJKzAFAngV
	5FNmICFg4Oq2rRw==
X-Received: by 2002:a05:701b:2905:b0:151:2e62:fe4b with SMTP id a92af1059eb24-1b25d338dddmr562194c88.23.1793920358113;
        Thu, 05 Nov 2026 15:12:38 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:57b2:a393:143e:afa7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa5afffasm312961eec.25.2026.11.05.15.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:12:37 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: llvm@lists.linux.dev,
	linux-kbuild@vger.kernel.org,
	Rong Xu <xur@google.com>,
	Han Shen <shenhan@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Cc: Han Wang <nesthanwang@google.com>,
	Snehasish Kumar <snehasishk@google.com>,
	Nilanjana Basu <nilanjana.basu87@gmail.com>,
	Yabin Cui <yabinc@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
Date: Thu,  5 Nov 2026 15:12:00 -0800
Message-ID: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
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

Starting in Clang 21 (LLVM commit 2fc4a4a9d3a8 ("[Driver][SamplePGO]
Enable -fsample-profile-use-profi (#146795)") [1]), the Clang driver
automatically passes -mllvm -sample-profile-use-profi whenever
-fprofile-sample-use is specified, enabling LLVM's flow-based profile
inference algorithm (Profi) by default.

However, as Rong Xu noted [2], the kernel's AutoFDO implementation uses
flow-sensitive discriminators (FS-AFDO), and Profi has known issues with
FS-AFDO that degrade runtime performance compared to LLVM's original
profile propagation algorithm. In addition, Profi's min-cost max-flow
solver (applyFlowInference) can hit pathological compile times (30+
minutes or hangs) on certain kernel control-flow graphs when profiles
drift slightly or when combined with GCOV [3].

Pass -fno-sample-profile-use-profi to disable Profi and restore the
original profile propagation behavior that kernel AutoFDO was tested
with. Guard the flag with clang-min-version 210000 since it was
introduced in Clang 21 alongside the default change, whereas
CONFIG_AUTOFDO_CLANG supports Clang 17+. Note that cc-option cannot be
used to probe for the flag because cc-option invokes Clang with -Werror
but without -fprofile-sample-use, causing Clang to fail the probe with
-Werror,-Wunused-command-line-argument.

RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes because
SampleProfileUseProfi remains false by default in the LLVM backend and
is only enabled by the Clang driver.

Cc: stable@vger.kernel.org
Fixes: 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
Suggested-by: Rong Xu <xur@google.com>
Link: https://github.com/llvm/llvm-project/commit/2fc4a4a9d3a87a9e11c48ef25522aa17c2a71003 [1]
Link: https://lore.kernel.org/r/CAF1bQ=S52KWHopqxksctbBirFEr5Mz1dKKMAoWh-dqLHii3Nig@mail.gmail.com [2]
Link: https://github.com/ClangBuiltLinux/linux/issues/2188 [3]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 scripts/Makefile.autofdo | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 57a3aba6ffc2..8754b60ad2ab 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -13,6 +13,7 @@ endif
 ifdef CLANG_AUTOFDO_PROFILE
   CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
   CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
+  CFLAGS_AUTOFDO_CLANG += $(if $(call clang-min-version,210000),-fno-sample-profile-use-profi)
   RUSTFLAGS_AUTOFDO_CLANG += -Zprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -Zfunction-sections=y
   RUSTFLAGS_AUTOFDO_CLANG += -Cllvm-args=-split-machine-functions
 endif
-- 
2.56.0.455.g6c5a503b38-goog

