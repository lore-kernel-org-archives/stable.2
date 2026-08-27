Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434D403E87;
	Thu, 27 Aug 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856380; cv=none; b=Hx5+Ba+aN6E+3OtsIQ1nc3T39p33K0+M2RN/KCiObYmQYjPi8dxAbm/SLdmFNEBG5LiSZcV8g7QMVx24ZR+ObTrztxMiXs86nxVVgiB7JdEcDAqAJg7HB2NalONZsALn48sFhRRPC2qAaD2djNTr2ovVafo6+WykMT+oK1+Qe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856380; c=relaxed/simple;
	bh=LJWpH/CgnzOK/t27Oavz+/Vp8FvRx+EU32B+FOPBfSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAp5K3iUbPOVGPwzOBisXg++bv9R1Evmd12ZWjoEd2kS6vl0cEeBcYddC2Z8pvlfcNG/5io8s+VIztw0izS9n4QhUEUQS/9uIdLMrfbzxFK74Pl3CWr0QAMotbd+yP5Bf6PVpNrX+CGHGcNfaFGbibSLtkD4ogixBYDhpQDxwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=iGrro2xz; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="iGrro2xz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WArSvg+AETs1hXdLSTJKNyQrLs3ixdhp5ELwXHGxzvY=; b=iGrro2xzDEC5bpPEB0cDBp6QvK
	AO9M+ACOLoTn3QQ05qeuDVYUCTtTyOkEKTfX+NIN6cxjX69RJ/OABM9CVS+IKTodqDB+elPVc/DcG
	UMPzLEuMBulZ2PyKdpCopZCkztNN7C0vli25G5HCgDh08qzqqJ66Bzlc9IwEOYt1BDcvGEMGsRt7K
	kDN+ESFAIT3X18J4cTRW+L6IYdpHmjm1SAbObsVJ4p11MzkQGgITdMd8pvAj6XGL/vpSL4VmDzvhr
	j2V3bXILN33lnUl5TISOQ6d+ueM31E/5L++FEopFPb9ZwdkiVaGcmpu2GHNC51cx4bNS4hKTqOI4b
	nEOWCiOQ==;
Received: from [151.115.150.205] (port=42710 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wzf7A-0000000DUzj-19d5;
	Thu, 27 Aug 2026 20:46:15 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v3] tracing/user_events: Clear copied tracing state before fork duplication
Date: Thu, 27 Aug 2026 18:43:22 +0000
Message-ID: <20260827184321.2964601-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

dup_task_struct() copies user_event_mm from the parent into the child,
without grabbing a reference to it. user_event_mm_dup() should
replace it, but it leaves that copied pointer unmodified if
user_event_mm_alloc() fails.

When the child exits, user_event_mm_remove() decrements a reference
the child never owned, which ultimately frees user_event_mm, while
the parent still as a stale pointer to it. This creates a UAF, which
KASAN reports as:

    BUG: KASAN: slab-use-after-free in
    current_user_event_mm+0x51/0x1d0 Write of size 4 at addr
    ffff888005010d30 by task init/44

    Call Trace:
     <TASK>
     kasan_report+0xce/0x100
     kasan_check_range+0x10f/0x1e0
     current_user_event_mm+0x51/0x1d0
     user_events_ioctl+0x82e/0x15c0
     __x64_sys_ioctl+0x139/0x1c0
     do_syscall_64+0xce/0x450
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Allocated by task 44:
     __kasan_kmalloc+0x8f/0xa0
     __kmalloc_cache_noprof+0x180/0x3a0
     user_event_mm_alloc+0x3c/0x1f0
     current_user_event_mm+0x88/0x1d0

    Freed by task 42:
     __kasan_slab_free+0x43/0x70
     kfree+0x13a/0x390
     process_one_work+0x696/0xf90
     worker_thread+0x420/0xba0

The fix simply clears the copied pointer before any possible failure.
In case of failure, the child then has nothing to free.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---

Change in v3:
 - Simplify the fix.
 - Add Reviewed-by: tag as requested. 

Change in v2:
 Move the pointer reset into user_event_mm_dup(), before the first
 allocation (suggestion by Steven Rostedt).

 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8c82ecb735f4..6b89d225b189 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -868,6 +868,9 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
 
+	/* On failure, do not free parent's copy */
+	t->user_event_mm = NULL;
+
 	if (!mm)
 		return;
 
-- 
2.47.3
