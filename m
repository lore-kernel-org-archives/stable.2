Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0B37B40A;
	Fri,  7 Aug 2026 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133305; cv=none; b=bANWbbePJZQBhbuPDvsENhOtmDWk6hphs9jDNEBlE5s4HEyTg39eC/pyN5W0plqRBYI9WleQCzQ5/T+e+id5WtqNLHSOdZNwFIJM9Q/+gB90/pnoGDf/HpIzeMMP+DDmu+mGxwYdn31muxFOjYWKPGjmknJezxc9ySStqc8WQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133305; c=relaxed/simple;
	bh=JJoz9b+25zs0CTckMM3pQ6vON1rL9PpgufWv/bAwr+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b2LqNT92eCdXBOhPiDHXh2WTqGnGJBK+53VcCMg9tjy+7Wwjla4XEgh/ZMn1GH8aZLvgbdzna1d//in8ShvJldLG059u4CEkaWADRCx/wmAcZgLM9I/yuI6qWdvhjBr6XlBtUDD32aCSvH4p5obFUHltdODo1+7KfvH71u7nC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37AV17LJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/TpF0GSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37AV17LJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/TpF0GSj"
Date: Fri, 07 Aug 2026 20:08:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786133302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDAqAfy+eFLtnS1IaCBfJczI+vhKXmYfkLdh1rcnO4c=;
	b=37AV17LJI6DBYGklM4Argl/h3DjnBEgkXl7bkRlIzVB3mhzIzGiUO/8hOpylBYY0LckM/i
	AcP7rDYlA3EXs8qexcyIniw2j+/hTWuCFVOhMK/lblyuP220lYbdLzJGK1mz83ok7f8F+V
	AT+cYo+4tnsiyQN+rHXu1MlYV+Z7Uat180tLqroDTWCjXBl8S8yanuD50JTXMfOybUKERg
	ZxBKxQSfnPBw9HXJaac5G5o4g9uHCzK7WulZr2LM6E12DDaFxCodot7fUIifecFjlizIiR
	ArXp50sFOggzWgEITNzuxZx8p8ZuwbzWidVdLeaIXIuJ/4TwnqcgANBEH+L7gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786133302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDAqAfy+eFLtnS1IaCBfJczI+vhKXmYfkLdh1rcnO4c=;
	b=/TpF0GSjLphtpoBRqly52ANWdxmQNOGsixVj1pySubtMtCfs8PcZXQDuZPmjMAKCv3T8qF
	sSGsWqizgpZwdYBg==
From: "tip-bot2 for Yao Zi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/locking: Use sfence for wmb() if SSE is available
Cc: Yao Zi <me@ziyao.cc>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260801182953.15069-1-me@ziyao.cc>
References: <20260801182953.15069-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178613330035.708.8011102097397557138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d824ed1307680dd482f607b0e707c575f70668c4
Gitweb:        https://git.kernel.org/tip/d824ed1307680dd482f607b0e707c575f70=
668c4
Author:        Yao Zi <me@ziyao.cc>
AuthorDate:    Sat, 01 Aug 2026 18:29:53=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Aug 2026 18:27:07 +02:00

x86/locking: Use sfence for wmb() if SSE is available

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
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index db70832..3e78bb7 100644
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
