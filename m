Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3A367B7B;
	Mon,  3 Aug 2026 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750501; cv=none; b=fbTP+C0SApLPHY2YowJcgDWa9EgBRX7L+axfSrE5N8wbfnNOgvcw3lY0fc3tibhX9wWrIM6TsMGGSOlYT/fjlP3opOj5k5OPpNpYdf2KOmH8N4giu1JQkWQ2n4OyfbLww1zSnccd679En7nMUPIzAi1uWChII6FPhw2U63r0J4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750501; c=relaxed/simple;
	bh=VtRcCBYFOpCxmbipGKu1tjyC0LEbheqd3X0s+e0JJYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MspIHc1QLYvM//Grl3F5XF/ST9JTg4f3Qy4aBcQsiIg1rRpkgyp07Uo1C+OWXYAAWEOwB1b+ueqaN/oRcLgekJyi3u20V5ZJU/ew8yVvMTTPSqNX119wnkfzlwop0BMjan4N/7gFxtOjd/ACLe6mwIGVH7V/zicxZr81Al0lZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Rwt6wypE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Rwt6wypE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=VPm2F0UXpev5LSmRv0dgVwfwkoR2kq/J1qPVrxHeh5k=; b=Rwt6wypEtEyaMvUfFnB3xhcPAU
	F22cricOqpY3qbzD8nSwqdsQ+0Wsqtz0kjBd5nOaS6J8MTfQsvSQkfO3lPXXFMmhu1tNcP3Qz+YGk
	qARKRtFKfdWX5d3Dc2L7cEQGlI45ItZk9A248qzos0AKDH5uL9oKGyP92Oaa7cf9110QIG2Km5m3W
	Odus4xCcsDmnyoZZiElH4TAciSN6MtfQooGLzDT0U6DyqJszj0+XY0kx4bBY++59ywW1JlkaVeBnF
	l6PIIACZLt9/kp1zL4kdxDECMyGU+ro8lD2rSaeQ84EaGQayUwQJ/zmgw4P9yYl36HxEQAIv5z1UA
	NjvpPQeA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqpGz-00CGwK-10;
	Mon, 03 Aug 2026 09:47:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 03 Aug 2026 02:47:40 -0700
Subject: [PATCH] x86/mce: Set up the polling timer before CMCI discovery
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mce_timer_init-v1-1-9539db424330@debian.org>
X-B4-Tracking: v=1; b=H4sIALtjcGoC/yXMQQqDMBAF0KsMf20gUbGaq4hITKftCKaSpEUQ7
 16sy7d5OxJH4QRLOyJ/Jck7wJIpCP7lwpOV3GEJpS4bfauMWjyPWRaOowTJyk2VqVun264xKAh
 r5Ids/7AfLqfPNLPP54Lj+AHUh2F9cgAAAA==
X-Change-ID: 20260731-mce_timer_init-ab3148a08961
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=leitao@debian.org;
 h=from:subject:message-id; bh=VtRcCBYFOpCxmbipGKu1tjyC0LEbheqd3X0s+e0JJYc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqcGPERUvGlhnLg8bUEwpioNXie0DexHi22BdNY
 6Y9c0LCvBiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanBjxAAKCRA1o5Of/Hh3
 bTRpD/4wd9GXM3thY0EbRrY3BjyC3luYtFuG1igHR3pEal4rlHgLYq/YgjKotzyoZ33Vg87mf6U
 jds0APFdbp02aKiVy9BjZsoNl0oQc/KSoseQ1AeT1VX3ZK7aiyqqjD9WnEv7uIC49YB3THrlu88
 Yg3V9x58JIRb8evkqcSjGceEiF+X9M7CgaoBC8VWY6Dq11xkvyVLJ8PnsEwAYTWJqFg+6Zmakx5
 slijkE7EFhYsth7an9GDlQXZ+aba9ZjcJe7yHhmpuAsVSauzrz1nh0tMi8yPfUfBySdEggeSc09
 HiQTSFx6txuT9qGErsX+ldXribkXJj82Q2MBIOKRPPIWPCb8JppRjR1yaYEhaSjjZVyKYb2XRce
 TqVdeIEPbObvyyOFkC3vJ8ZnAaygUYy75fkYlUb3t+JnomDmU9OcuEkOHrmrVGpcr4zYNYMSFbg
 59N30fSJZwYlfdpQtLidXtsxzr7crjQBlzftOj/QgKR7OMbGB8LC9U+AOd5VV3G5Tm+iGEaf7k8
 Ll6Q3KJi6whe0XOji7HyJnhzi9lsyoJ+99pjkEgacKE8h7KF+5TI4k5ESY6RclAq2w/O1cdL6Rr
 Y3LPK/bf5XPU9AtW3vmmAq+w02lgAS+VDLeBWx87fW2Zh9oF7IbglhPHezoWB/phvBAavtXQEnR
 59uXO85oN5VqtPQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

I hit the following on one of my machines:

  mce: CPU0 BANK15 CMCI inherited storm
  ------------[ cut here ]------------
  ODEBUG: assert_init not available (active state 0) object: (____ptrval____) object type: timer_list hint: 0x0
  WARNING: lib/debugobjects.c:632 at debug_object_assert_init+0x178/0x230, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5 #3 PREEMPTLAZY
  RIP: 0010:debug_object_assert_init+0x18f/0x230
  Call Trace:
   <TASK>
   __mod_timer
   mce_timer_kick
   cmci_discover
   intel_init_cmci
   mce_intel_feature_init
   mcheck_cpu_init
   identify_cpu
   identify_boot_cpu
   arch_cpu_finalize_init
   start_kernel

A second splat follows right after, from timer_setup() finding that same
timer already queued:

  ODEBUG: init active (active state 0) object: (____ptrval____) object type: timer_list hint: stub_timer+0x0/0x10

This is happening because we are trying to modify the timer before it
was properly setup'ed.

Set the timer up first. __mcheck_cpu_setup_timer() only calls
timer_setup(), and depends on neither the generic nor the vendor init.

Fixes: 1f68ce2a0272 ("x86/mce: Handle Intel threshold interrupt storms")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9bba1e2f03af7..cfb74be19994d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2266,10 +2266,10 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
+	__mcheck_cpu_setup_timer();
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
-	__mcheck_cpu_setup_timer();
 	cr4_set_bits(X86_CR4_MCE);
 }
 

---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-mce_timer_init-ab3148a08961

Best regards,
--  
Breno Leitao <leitao@debian.org>

