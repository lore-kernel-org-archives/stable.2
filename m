Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709741;
	b=EJJLccsStDnAZKfXH1c+1qvcGherAksYE01FLzwCpl/HcQpDhMVZRUhhoClTP05yQFES
	 4Y+plqVhzB4mGcu9H0IivvgZofIx3I95xYRAesJOFShATQIgloYD44sFP22OfUiHQVboB
	 bEOD9jiSUF0Zx0zATNaF6VShc7vfabVKZ7f+0kvUd62zlMBMGYi53t63kfHNrdyMEpi+9
	 hb6oroT8rkPQ5lQeU4s5g3Nmesf3d+ttizFOSAuBToSdwpIaOltWKD9yHFxbMp1pcU4q+
	 VSluBV8IwK/SV8lp/Oh/2lnwoVw2Ja6jo8qsgsBWLsrXsW7h7YTktc/sFBMjIkoqFFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709741;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=UQkC8Tq1xe+vqF6ekMwTzZzbCpLMKq5QVP3VvlYU/kM=;
	b=Ln/KJgaugPph8fFheXqTcX3it6w/q7dlSdyfvT+vBPhmDwluxbV09HsEjddUs3d9A5x5
	 FqTGuJnPhCPDnfFJxWPLCIqIUC2MgANj278RALGnlfNer/Df8RRU/bDjqwc6FX1gxM8bd
	 Acbb0BRn1OMbvGJdgjqBYUUB2tEpc2BZbldYQSm6J7fvYC0LXce/ipKMNsgKFK9PQuiCu
	 mselEglCUa7/Grf9ENJSPTXK2CGMRXLeoEVA/9nplhJd0/pubw7aQYVx+tMnfJu7pQTu1
	 JeSS/RLfZPfYdm+Ex4SLT3SfgUzIyndvPpDzyWQ+13s/2GqoODuIv6sZSjyONLBk+Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JuP46dOs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90188606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90188606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JuP46dOs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795709740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQkC8Tq1xe+vqF6ekMwTzZzbCpLMKq5QVP3VvlYU/kM=;
	b=JuP46dOs1uiX38gRyqCy9t1SS6Wk7IQLjfRzk5o+1vpXKkW5Yc5cGpEI2B9iBFzD6663iM
	b3LyVzkHLsj8qoZDG34NccnQpWeO/gOoTW1FsB8FtA9fD2ggSX8XKXTIzDf0gX1NJC91ay
	U76cUW6s6+FFhxBFO3fyjfUe8cxNCtg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-pCsuPvD5MMOkSc40pWq5yw-1; Thu,
 26 Nov 2026 16:15:35 +0000
X-MC-Unique: pCsuPvD5MMOkSc40pWq5yw-1
X-Mimecast-MFC-AGG-ID: pCsuPvD5MMOkSc40pWq5yw_1795709734
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D4CD1955DE1;
	Thu, 26 Nov 2026 16:15:34 +0000 (UTC)
Received: from jhladky-thinkpadp1gen7.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CC401956045;
	Thu, 26 Nov 2026 16:15:30 +0000 (UTC)
From: Jirka Hladky <jhladky@redhat.com>
To: will@kernel.org
Cc: catalin.marinas@arm.com,
	kristina.martsenko@arm.com,
	luyang@redhat.com,
	dockseed@proton.me,
	jmario@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] arm64: clear_user: keep alignment padding out of the zeroing loop
Date: Thu, 26 Nov 2026 17:15:26 +0100
Message-ID: <20261126161526.1745191-1-jhladky@redhat.com>
In-Reply-To: <CAL2CeByu46f48j8O9=237fvhpPUCsKjOZkFuuHU3xrr3wVF5Eg@mail.gmail.com>
References: <CAL2CeByu46f48j8O9=237fvhpPUCsKjOZkFuuHU3xrr3wVF5Eg@mail.gmail.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit fe59e0358d9b ("arm64: lib: Use MOPS for usercopy routines")
restructured __arch_clear_user() and moved the loop alignment inside
the function. In doing so, the loop label ended up in front of its
own alignment directive:

	1:	.p2align 4
	USER(9f, sttr	xzr, [x0])
	add	x0, x0, #8
	subs	x1, x1, #8
	b.hi	1b

The backward branch at the bottom of the loop therefore lands in the
alignment padding, and every iteration of the 8-byte zeroing loop
needlessly executes the padding NOPs. The NOP count is fixed at
assembly time (the assembler aligns the .text section of clear_user.o
to 16 bytes), so the NOPs have been executed on every iteration since
the MOPS update. What link-time layout can change is the position of
the function, in 16-byte increments, and with it whether the NOPs and
the first sttr straddle a cache-line boundary: an irqbypass
reorganisation in 6.17 [1] moved the function, and the loop's cost
showed up as a ~30% /dev/zero read throughput regression on affected
builds.

Norman Herms diagnosed this and proposed moving the label below the
directive, so the padding is executed only once on the fall-through
path and the loop body starts 16-byte aligned as intended:

	.p2align 4
	1:
USER(9f, sttr	xzr, [x0])

Measured on Ampere Altra (Neoverse N1, no FEAT_MOPS), reading 4 GiB
from /dev/zero, two otherwise identical kernels built from the same
tree and toolchain, differing only in this change (two NOPs of
padding in the unpatched loop):

  kernel instructions per MiB:	797.5k -> 536.4k
  throughput:			11.6 GB/s -> 22.3 GB/s (+92%)

The instruction delta is exactly the two removed NOPs: 2 x 131072
instructions per MiB at 8 bytes per iteration.

[1] https://lore.kernel.org/all/20250516230734.2564775-6-seanjc@google.com/

Fixes: fe59e0358d9b ("arm64: lib: Use MOPS for usercopy routines")
Reported-by: Luke Yang <luyang@redhat.com>
Suggested-by: Norman Herms <dockseed@proton.me>
Reviewed-by: Kristina Martšenko <kristina.martsenko@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jirka Hladky <jhladky@redhat.com>
---
Changes since v3 (commit message only, no code change since v2):

- reworded the explanation per Catalin Marinas: the padding NOP
  count is fixed by the assembler rather than by link-time layout,
  and the NOPs have been in the loop since the MOPS update (the
  irqbypass rework only moved the function)
- dropped the Co-Authored-By trailer per Catalin; for the record,
  this patch and its verification were prepared with the help of an
  AI assistant
- added Cc: stable
---
 arch/arm64/lib/clear_user.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index de9a303..143d2f7 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -37,7 +37,8 @@ USER(6f, setet	[x0]!, x1!, xzr)
 	subs	x1, x1, #8
 	b.mi	2f
 
-1:	.p2align 4
+	.p2align 4
+1:
 USER(9f, sttr	xzr, [x0])
 	add	x0, x0, #8
 	subs	x1, x1, #8
-- 
2.56.1

