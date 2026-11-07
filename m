Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049842;
	b=DdeF5wsh6bZkic+3EwMKB55LDypLbBCqBWfXRFNfMMS0CkqesAXGw1fXiYj14Bmc0GSr
	 wpjPD7ex7UsQRQhLFAaqT8HqG7W2kmasbni9Eq7wFTAAJrIR+YGm3kQ6Ze8SqYBRbpKAZ
	 eeyEPFDsX/qnIp5LhwKCQObKmKhvZQYzIOQALHBeU51kSG7PLPRta/hNJVk0zjLxiwDYm
	 +mcdfDjAFBHVIiJr44tQ6dnHOGBit9szJAWOOAYDP7VF0AUa4jC4Q7mgAKjzam6n2wz8+
	 r72YA+1orgIEKlKvzBbqZ0RuiWIy9ZEVFT/tcfN00ZG2BKuv1EBksbm192pawvlAHaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vLXotQ3F33qfC3IvtWIIPpMohP45Rw0jShDsSjR2xTo=;
	b=Eaoj85KzmEUP4NslnVYSfeNP8pHLKtI8bYIAW/6+CAcnitbyfw7I+6A4Op78uvZbGILG
	 hll9fcmOTHv7KlmwrbJEu7X8oerFgTxT2/gfEsqKO06inGhz8GDIjgxY6wU1GxKmgGI7a
	 oNEnRVg+wvsUJFa0bRPKwV9HwWFvppeBD+9fIj0ahvwPsyD+/+0hzik0HgucO0RYC1BPf
	 GfBPem3jfUAxx5W+lXv96ercWXLLKTGDwtmCPPeI/X6VFOQxDFid1i27EaxmyCOIFbLse
	 pNG65CzsWL7QS58tN7KBwf+AtGxjebk7TqFK6GIFCBFRTDE+hVOFVo6ae9LdOunPZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTNtnm0Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTNtnm0Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E31F008A1;
	Sat,  7 Nov 2026 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049842;
	bh=vLXotQ3F33qfC3IvtWIIPpMohP45Rw0jShDsSjR2xTo=;
	h=From:To:Cc:Subject:Date;
	b=KTNtnm0QNwk+/jZRhBSaMFWVfHuWwVkh/lVJbcmtWKHaD6YRP2XBDjEBcNE0r8aqp
	 hYq6a6zUyTteslz0SMWvE85B5YgmMMwfGc60WUzsiR1HaQAKHjXJECe0MOmoinZj3H
	 kaDApbLKUdk/nSz+Pe4wvx5SnJhYvwHtFbDQ/gkqlQJcgO99ZSVe23TXrldbken99o
	 24uJCmNuxCbm+3uR4zTgF5esBhpMXOxzOEed9RuwBZB24hi0/FcyJvQjgOKSLIM/UT
	 nLFN/Tl0ho7trF9ThXABYKb0nvuOISgsh5ZpUl2xhiZgm4TTtShG7SNm2X/ywHcK/f
	 ju4uHX/Wy3lFg==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	rick.p.edgecombe@intel.com,
	bp@alien8.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/cpuid: Mark CPUID function 0x23 as being indexed" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:40 -0500
Message-ID: <20261107061040-failed-5.15-108775fa28fe@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 108775fa28fe04a16f19a828a779689f3d0ea9f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061040-failed-5.15-108775fa28fe@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 108775fa28fe04a16f19a828a779689f3d0ea9f0 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 14:01:32 -0700
Subject: [PATCH] x86/cpuid: Mark CPUID function 0x23 as being indexed

Add function 0x23 to the set of CPUID functions that are indexed, as per
the SDM and the many sub-leafs defined in leaf_types.h.

Closes: https://lore.kernel.org/all/213d614fe73e183a230c8f4e0c8fa1cc3d45df39.camel@intel.com
Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261022210134.612848-2-seanjc@google.com
---
 arch/x86/include/asm/cpuid/api.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 2d9f3d4d63de6..759b12d94bbfe 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -181,6 +181,7 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x23:
 	case 0x24:
 	case 0x8000001d:
 		return true;
-- 
2.53.0




