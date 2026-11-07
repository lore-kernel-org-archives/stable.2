Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047130;
	b=mPOjBsQGq3l5q7XQPbuJDUo3kNsB3uMr00mOm04ZZDo3clHuVU1foWXDE9HMoSNaxjdM
	 CnKS0TB8j/5Xux7XjU63yLDOCgl15AXEIVJc4ECYzVe+QwSU6Z5RQQCgSi4iamTyN0OW1
	 iZwXmrP/oWy/4e1y55GxCDvwR1UqScllKYYra2aZmcghYnZABdiQwgJQvqbuKgT3vptYU
	 G++zb9j3MAqJ2rCEKrlDpwzIcSCjHixfkuAtUpGLx9swKujfB/th5rk6SnNWZe7AZnvDd
	 xsqCjNb+X/HFs6puWFn2AfNwNv2dnRNKCcQujCrRQn/LOmjNpkHXOaLgIwZ2h9lPoiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047130;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wCym5EnxsPUUoiJPQg9bHMmCVzK9rTD6PndLbxWVLzU=;
	b=s5VGaRhHG3YU4nDsF6eRDtBexSphk56H33kYhTTr1fC+i0d1+HHldTesZyAzf7Pj8jU2
	 zYQTysYFIVf4nK3aauKLsIh0rY5uf93vSmkBRVe3HBK5ojBCaVpESq3MwSr6BLI9Ew/B9
	 0QnEEBzvfl+wXc+rYJGJhug9iLIxNPksxirxCLTo29cXQsn6Djfuu53ItAKgeOIBHGkJD
	 o9HbYMKWxTPRwObWGlBQ2n9FaNTx5Wx3TiRdOc2EsCLLAfHbTvBdioTXVfkcXifcCnA0O
	 eF8O2MKXAZzsuxT8S3Np1BAOnIafrLqqWAmhZJpiY3bdY3yOV4KIowABrCx7OpGdUgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDZXdOCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDZXdOCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121F31F0089F;
	Sat,  7 Nov 2026 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047129;
	bh=wCym5EnxsPUUoiJPQg9bHMmCVzK9rTD6PndLbxWVLzU=;
	h=From:To:Cc:Subject:Date;
	b=hDZXdOCgBdiDnyIE9L6YZ3odo8xqVb1m+UOBZB+6/8R2/AJbKa3F1OHRlx+p6FBBD
	 iXwy4NuJfTlOwi8uU4UuMqUM7749jKWocWYg2HGtH4WHdxMegKKR9YtrZly/VFX612
	 X0sK9u2NE+phqCohJ4sjw7rzQZ/4V0Ue6NdtOw/3QofWiR2VErNYKhM/n01ufiSGEg
	 AYVsOkeAx9xItvvfP80jOJVQnXKaeNM/2cEXnWpRvzfnsIKMOwRrMDqjHbz0dkw+YP
	 utV0jmKjGfmWldcQw/GVkzUPlAiJCqqo4hL5oKoH6bf4SBK65obsCiiFSyhyFtYUoU
	 9rDrnm2qR6zyQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	rick.p.edgecombe@intel.com,
	bp@alien8.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/cpuid: Mark CPUID function 0x23 as being indexed" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:27 -0500
Message-ID: <20261107052527-failed-6.12-108775fa28fe@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 108775fa28fe04a16f19a828a779689f3d0ea9f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052527-failed-6.12-108775fa28fe@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




