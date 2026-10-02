Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C834E75D;
	Fri,  2 Oct 2026 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933589; cv=none; b=ZaPBSxVhV8BQwhb5S/WpxFKUlk8eiXvtk9u7gSMmMDxv89RBffxL8dGf40mnk/DyFzsQvnmO8ETH+/FDup3rMrWiSsX/44SfJD/Za5n4a8XR66SN06NV3VqcDvx1el+WojxGmxHDmYaG7Ar19fbThpizfgqllgSkKEYFhoeXT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933589; c=relaxed/simple;
	bh=rD0ibicO+ZGKxVRbQcH4VLprHwAYnnqZ0hB5jrxNhqc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cz3n0hio8/YMWAGIjSaVubUl/DH5nrWjQ5pzrVNYf9t+beQMc3r1CucDiFwuhm7ekJWGZ2FYf4k1wmBUwhvhoz0jkYonflEQOAKpHJ0wnOlCOt0MFPR0aNTWOMFCjZbexS68HeBrZS/Lwz5BanZxWIwsvh7CE0nwYHJ1XE86D6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ve4TexgJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rxCG1SUM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ve4TexgJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rxCG1SUM"
Date: Fri, 02 Oct 2026 09:33:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790933585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky6kJGcV7xn4d0c9B7dr34Sh+HBwwOBcZhOLNJbBog8=;
	b=ve4TexgJ1G+BMQOyerIt4GUQW8/Q2P8h03hbxzZhsPtoG0DH3FsuGKZsay7YVKNNTMnrxI
	DU0pV04ZkMn1EDnu2U9WFHmiUF2OdfvqDIF5qAYcelbFcYw/JzwHUSv8yhiva1YPrU7F4T
	UsJC9K5fSI2MyAT0B1kMVpubk6P6DWCH/yrCcTvt3NkhjIPE3vP1ShvvK67DvDqQFtCVI+
	C06MoKfZk3mXjZXYC+7HvFYAmfURNaJJD/vKcxvAqMjWFbGCjayXUcxac1dKgqDcaBat9p
	8hHDFZ3UNXlkRusU1IxxltHs+o4BHOXgeuRd1NQpsoMfMFb5SzuH9ZdO8WQe6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790933585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky6kJGcV7xn4d0c9B7dr34Sh+HBwwOBcZhOLNJbBog8=;
	b=rxCG1SUMa1NuIv7OS/fuwo9LyDUr5ryfVKV6s0eBCnkr+KtxwRHQTvja9SyrtFUofkFigC
	TyWBG5B/t8T7C9Bg==
From: "tip-bot2 for Zhengchuan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Require kernel access for text poke events
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
References:
 <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179093358384.3910103.10789552994247841308.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     357e8a77a501d96c9517f01f4a211eed5e9c9184
Gitweb:        https://git.kernel.org/tip/357e8a77a501d96c9517f01f4a211eed5e9=
c9184
Author:        Zhengchuan Liang <zcliangcn@gmail.com>
AuthorDate:    Mon, 28 Sep 2026 10:59:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Oct 2026 14:02:06 +02:00

perf: Require kernel access for text poke events

Perf events with exclude_kernel=3D1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=3D1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/99131354c41e23188f778b92f90363775b482395.17905=
73390.git.zcliangcn@gmail.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3aa2235..7846d70 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13906,7 +13906,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
=20
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err =3D perf_allow_kernel();
