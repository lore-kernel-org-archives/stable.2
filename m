Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047901;
	b=S6j5N1bWju1JdZknymx998UrsLJynIuxlbE9lO2MoW1/uo/32a1nzAROkxXrQ2HpIdne
	 5PswoYqOgtGW5v8ov9T8ROofrE6WSKs4cAHgemYWCSTB3CznPM10arPvIjDNHEkif49i6
	 QqK7jbbl4JIfFQhxjguihwZlMIHaBLhXcwhxmgWCRirh0Jt2uc9V/U5H6TZOxPWW/pNrq
	 Uyl5rZEVp8dbVDCVNfMW6tasCvyqfAV/5urf3yIg+LtMTm2F2GnlGTVRqejHpxARWjjb1
	 ouPj9SCx8UiLS9ukjZjb6I8JX95JrWU6fkMN0F/s8s5NtIUdNMGdldJJl/B0d21fcSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jvb8u/76D09MMcgAtCv/Y6iS0zqmQuqUpyahSU2n/sU=;
	b=3K/RNW328F8P9o5TwHzfQOFw8GFsNQRFKb/oRaO34lJVH6skJ9oMEVmGrG7tDEcWtYb+
	 j0PsMRj9YLP3v9+SIS3WlcKMxrZON+18b2ur/50oA5j2kbUiTYLyakilsi+Wczw6GGPB/
	 XJK8vOG/nJVcFjESq8qOHPS2vpPDacKUNZ44qjnbBbhsTiKGLQilLNBSgvjGP/REeRmoC
	 XetxebVOasM7m5KWebijmBJAnyaCuALFZ3pvC5InAAY471CSA3qk2/5qhXanv5oBTfTcC
	 3jx6vqjZEPOum67Ww7KgjbcdIuQwVpMtvEZJqIaC0do6HmvqeEQLMkhOiIshjasFWBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kd77bLbs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kd77bLbs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118271F0089F;
	Sat,  7 Nov 2026 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047900;
	bh=Jvb8u/76D09MMcgAtCv/Y6iS0zqmQuqUpyahSU2n/sU=;
	h=From:To:Cc:Subject:Date;
	b=kd77bLbsMggBMkn+tkdztn4/Eav6jhCN5bHcunDILMSkLkByDFkRzYTZUT+6SCQrA
	 zCZ7/LRHqQ6iIzcdv5WgI/Kn8pS1uNIGn9QB7Nh+vKvuY9HKSgEBsX2fUMm3zqZLOQ
	 YfTKCAVO3kjaVAzqMFEpfVD08bHPMHnxx5bSpdWwIvNe/QHpUzGoOe6mFdP/lW/cZi
	 9SiCl1motHTFrlokTTuiTghLNQaG5au/jHlkk4ESSQVw/DwmuC6CGJbrO4RWoQ77Km
	 TimibWELGgoYns9rosYWbfmMW8Z919VLAy7xEcfKuvYflma03PWb6PMqlTMl+JUqbk
	 UQEJ9DtFVjbyQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	rick.p.edgecombe@intel.com,
	bp@alien8.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/cpuid: Mark CPUID function 0x23 as being indexed" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:18 -0500
Message-ID: <20261107053818-failed-6.6-108775fa28fe@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 108775fa28fe04a16f19a828a779689f3d0ea9f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053818-failed-6.6-108775fa28fe@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




