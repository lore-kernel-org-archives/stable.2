Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048816;
	b=k7/rOIni/zxiYm+2/okgtKnnTg2V+Ti3m1zlWjB89a4l/2cCkKyKcdzmWO+5GECjVrBm
	 WLp2DXltiH0dMC0IUYLJjko2weWLu50MjjydYHftz5lgPe7QRa6bFvE91lm7S2OGq4Bzb
	 e49jou7t8R2xIHHdCP0qnztojiyGdU304pLVxLSM+LJDikqrNPCaijz8JVc8EGMT0B0a5
	 Ln1pzJiFzZvDsWjUJI0599GF/A/26mcQ4lrk88NmKdNa8TuIUkmZN1HK43rAoKGMXDD6V
	 ybV/OW0GaZwJpeQbZlyJh3i2fSF3zJ5WBrG8n90lnc4frD3M2N4CqVTDN7x9cEl3BjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kswdsstPDDyJrKVhf6WPv5mFvH5Waa3xob1xABL2+os=;
	b=uDmnG+Z9hxMCxygNmaKHSQYFY/M3/VKA8thOf0Ak8LC78Q1EMtq3YIT4ZWv4S839GdXf
	 qYXtkFZs6+u3SzTJl/FZdwP3P3ChntaKqj9NyTQYNCgezicLxgc4vlxR4Ip2eFlSqZx8S
	 Ip4YZFcywuOq698SaYt+MKoBl6ywZd7AfWD0O+fR2MWmKc7c8Dl3wrWMaHKomE3l99cxa
	 2rYvxPzJD2OGdwelkA9E7JKdm20aUUeAPUVYQzhCu0S9lBYR/b8Bw5tvTm0hCbfCbRkhx
	 l7R7NT+vmbyIG2u6rok7InYz0U9z8dE7t/BAIPTf+xGC5b0mGzS9+1glJkxLgDrrotg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcXXmS1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D1606A335
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcXXmS1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECB21F008A7;
	Sat,  7 Nov 2026 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048816;
	bh=kswdsstPDDyJrKVhf6WPv5mFvH5Waa3xob1xABL2+os=;
	h=From:To:Cc:Subject:Date;
	b=bcXXmS1tXIAL0iJRh78zffCtIC5R5CEK2ZTXWjQdJOfmYVaGS7QHfeHsao4nS32dE
	 38/6P6KKROZbznMeAEOxv80DaUcIbxe0SBXxMWhkkcOM9zMxPHFhVmHZ9wU3WjdToj
	 q1gBnV8qczBXZbsmxJ1T2vWXG/0hR7OH0qQLAujVlUFbJ5wCGraTPM7Nr6xMM06udR
	 cwSZ+6cMxqk3XwCj1xyODptEEu+Wfarb2a+3IelrXglA/6N+dbP+DDxlugQSjvldvS
	 lcA+WH4Ovv+6dyjwBGPo6j0LLUhdNZr+hDJETSpVOF6vNOSpVOeVA/sF88/1Py6bjP
	 KCMXNgBwzb8Jg==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	rick.p.edgecombe@intel.com,
	bp@alien8.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/cpuid: Mark CPUID function 0x23 as being indexed" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:34 -0500
Message-ID: <20261107055334-failed-6.1-108775fa28fe@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 108775fa28fe04a16f19a828a779689f3d0ea9f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055334-failed-6.1-108775fa28fe@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




