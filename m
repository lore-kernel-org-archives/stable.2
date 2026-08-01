Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB326056C;
	Sat,  1 Aug 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609032; cv=pass; b=YMY50aWbpUFV2eKAOcSUKELv0tBMDjhtHgOUCR5IxC44xBrrtv3ZFOfcBulxhUUiqPADkYGvGSqnbFthLqLuyWt7rQpcioJDkIHtWjBjFhWU34fr3eNnMHakFV3PFHtMIXcVtvAZips7qNGZjfI/F1ioUipF+PTCAc3n2YoeYN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609032; c=relaxed/simple;
	bh=LsLocPztgc0MIEvQ+cd2LUVytDQYlNNR5kx3yB2tALY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtKaObSLaq/XE4eNAHT/Sx6vA9QW1no6wovU4IwdhufsIefWGJbZp0hYKBIbk3f9GxZ37wMl4FRbIhZ+ufljx3HOPn7Stmc7ceb++Ag4Vljz2e3fZxm/mHWjxLAlQiemD2EpLuhrEVOJpEDeSUmplZLokKu5CmpVux0h3R9tX2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=I0bfAgbR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="I0bfAgbR"
ARC-Seal: i=1; a=rsa-sha256; t=1785609003; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IutjnJ0eKwPlwye5dSJLG6343UF/Xh3tOHQ9KGAu+/1JwDVpO7zdEuTfRc4A/+rzxI0WXSrsVxUVleUyo+wOnFUZ9W1YnIKHpUNxzw28WP0q83VpccXYZC1Yj/SNNPG8CepVHoI7btZxZIxQlUiAd75K7agLmsfw++WGDzYSbUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785609003; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mCppxZrojOm46wdBTGTzBj3o6Vvdx98OHQ45neCAuH0=; 
	b=GV5t60dLo0FARDPQQHcNQlkTVlwoyB+JHtBx+PCkK6tiYpvY+gnUOKuYnPsiuFKaotrHxoAicPG2FO1bxKzVGur4F1xILJN1We0KO7vB9RoKZ9SdQ7HDXztEvSzIKfxiKu11QelYGXHIem8VyJ2z471yTozD9LF6s/Zo0jiiiFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785609003;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mCppxZrojOm46wdBTGTzBj3o6Vvdx98OHQ45neCAuH0=;
	b=I0bfAgbReKZq8ieSkMwQI5NUqzRGW2zB5frfowg3WdCZsTEFUaqaM9ON/lelvCf4
	vcN0H1oSQr/okAwtyZDfMD0BR188HuibJssUH1zHKyA2Ghb5FGDqkiWDVNEGUKpy1J+
	In5+u9CR3K/Bj50NhHR8K70dq8JMpxCNT6QCHjCE=
Received: by mx.zohomail.com with SMTPS id 1785609001608693.425839747884;
	Sat, 1 Aug 2026 11:30:01 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <me@ziyao.cc>,
	stable@vger.kernel.org
Subject: [PATCH] x86/locking: Use sfence for wmb() if SSE is available
Date: Sat,  1 Aug 2026 18:29:53 +0000
Message-ID: <20260801182953.15069-1-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When adding cc clobber to wmb()'s definition, the alternative()
condition to use sfence was incorrectly raised from X86_FEATURE_XMM to
X86_FEATURE_XMM2.

Restore the correct constraint for potential better performance on
machines without SSE2.

Fixes: bd922477d935 ("locking/x86: Add cc clobber for ADDL")
Signed-off-by: Yao Zi <me@ziyao.cc>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index b0096b5645a9..e0e59da15748 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -17,7 +17,7 @@
 #define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+				       X86_FEATURE_XMM) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
 #define __rmb()	asm volatile("lfence":::"memory")
-- 
2.54.0

