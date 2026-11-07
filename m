Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050871;
	b=h4wACybYtlyQ0pnbgXRe7HrBWyJemylVSrprw0WbkK/eu6hM3Aj1kSaJOVeA6W0smYrM
	 hYuhy6fRMjZH+WPkoTNolZMje5aNCTsDShDH3oNJhxq+jk6PM45MIDP5GQJ+Nf1tLa85n
	 Eb3BGpgHrdSMLU27XH86BelrK95niU72v9qW1EZDviblMWQ0H2zdJEGOz0SbSjjGvD7ut
	 /1MDJCG5qA1nE0CTyPtFrqnzNfwz1bRfjimaJmHISYegzb83vxv29/q7/zMtplXOt2onB
	 VYGGuu07k5RywlHQRiYX/ceUa6uHxXy6+oBjW/wUY0fkg0hYCajZuA5nyixhnb1QCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o0gXqCNtbzCvju7Aqv4VCA2kETH6frAVZNud7QY4BKk=;
	b=COz6XJabCBlPlsqFJUDcQymhwbLOOxHEjKx3hIY6j1/Ga62B0iFr1x8KLuugUHRXzeV8
	 cbFVS8yvP2lsjhoQtBzzTi2yKjMB96ifL3lmtngD6BD3injtyGL/L6T+Cne3mAIqUlOkZ
	 jgyS74pv+eRNdhpccHOO/aq8/eCxubYryY0KvQW2xpz2+gDjKQTFE8bi5DEWRYdVubhWp
	 ocVPPDBLL0yu20oeWduz2RfHpECpfbhj+Lqat8Fq83jOHgWfzXjkaI3/baM93aaYVUoiC
	 cqJHe0sDumWrVDaRcq9cjl3RzwJVcqYuQDcbmH3DOydVWLSa1eM2UVk9g5bpt1iBDFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxVU8GLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D29606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxVU8GLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCFF1F0089F;
	Sat,  7 Nov 2026 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050871;
	bh=o0gXqCNtbzCvju7Aqv4VCA2kETH6frAVZNud7QY4BKk=;
	h=From:To:Cc:Subject:Date;
	b=hxVU8GLWinF5yRRGzBR4+OUi0gZVXLvZg9w9qbliiP3rFJvuvAVDYcBmm4jpcUJJT
	 Ae2EFqmuamBnxJQAOFRZWCrHmBz7EdW9eMqPnao+4aCzIsrbNKiKDYS7JodBwTeA7Q
	 UL7ZHankGQM/Z1EKrPk98l1/+L6iDzuWMpL2UzGWr5o+l6CaWR60gdK4bzbzYjvjtx
	 O5aSRipuyCvGAo+n1ZbahsfweTmrfownK9EJJEe4lP58RIMTcMsSghqvSOGoHIB7ZW
	 vy9Gyp3Omo6b21RPERdJXN31JRITq04ugp1Qqeyz4lYaDFG3pNxYJPupnj0tzAdjbG
	 G/bJiZFjfuTbg==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	rick.p.edgecombe@intel.com,
	bp@alien8.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/cpuid: Mark CPUID function 0x23 as being indexed" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:49 -0500
Message-ID: <20261107062749-failed-5.10-108775fa28fe@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 108775fa28fe04a16f19a828a779689f3d0ea9f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062749-failed-5.10-108775fa28fe@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




