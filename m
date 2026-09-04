Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226646DFF6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520389; cv=none; b=uLilrb+xJz8eYh9atewWfc5OWZTfNrffp46DmcT0EeH1JjhWmT6qliPb7bI1ow4CmqwdMX2Us6e/pwJRyK4+PZ+MSI94MlkXhXhIamZaQ7IQnDSvNhBJZUDSkcXKLnxJP+E9GkjbiMNXpvMSyLYkPLZdwQLo43IQocyTRH77q30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520389; c=relaxed/simple;
	bh=YP833iGXvqcy6jFqEpj0wczaZQhFcD0PoBd7XRHCXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VniBhuuGLjBwgbiZisggh7Ig0rqfETEWR87sfg3av2S1MNKh0yU0564hzNM3psdGwwBUTWtk4KUD50Pk/S/BLJjxPuq8yaPYjWG7AmORsjzhnHGjbGGtqNe7dJbB4b4yIiJMQmLTtv4npioA67gLOQeUUNuXr516eYmsaciWiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPIMAMjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPIMAMjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6B91F00A3D;
	Fri,  4 Sep 2026 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520387;
	bh=PFR2Ckvz56XoMfprsH1eZ/T8wvFsC+8ocp68y3Fr5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPIMAMjsA0RkVSUh1fM9uw04Zdsl+zibBZPH0zXqcN7+YhjEWB4/DZ9slfliO8bGz
	 MHCVITMZzJEdYq5YYox8nyyrNkYNyvCMPIRoVgq0mXnYnAnFFAFfJGNOGClAF7qIco
	 biHcFkoxwPzgh9NL1g7JnGOUWTDjfMx3cFtcH7ZGjDpWQbmkhPru22cv2e5QC2LLaV
	 SOnO50UX4BBlGSbfunU89IZKLxxpuDjZ5NPJDZNEDtODp+ECGyXskT1Cm2qU5rkI8/
	 T575BuxArwX9vk6grz8Xq1J374knCbV2UtSKZptaCm/MR4l2846G4uXs9AD4bds1AD
	 Zbfax5cvhfNHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Zi <me@ziyao.cc>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] x86/locking: Use sfence for wmb() if SSE is available
Date: Fri,  4 Sep 2026 07:13:04 -0400
Message-ID: <20260904111305.3208459-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-fanfare-undamaged-c63a@gregkh>
References: <2026090323-fanfare-undamaged-c63a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Zi <me@ziyao.cc>

[ Upstream commit d824ed1307680dd482f607b0e707c575f70668c4 ]

When adding cc clobber to wmb()'s definition, the alternative()
condition to use sfence was incorrectly raised from X86_FEATURE_XMM to
X86_FEATURE_XMM2.

Restore the correct constraint for potential better performance on
machines without SSE2.

Fixes: bd922477d935 ("locking/x86: Add cc clobber for ADDL")
Signed-off-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260801182953.15069-1-me@ziyao.cc
[ preserved the Linux 6.6 "lock; addl" syntax instead of upstream "lock addl" ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7f828fe497978..ea3f8943e914f 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -17,7 +17,7 @@
 #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+				       X86_FEATURE_XMM) ::: "memory", "cc")
 #else
 #define mb() 	asm volatile("mfence":::"memory")
 #define rmb()	asm volatile("lfence":::"memory")
-- 
2.53.0

