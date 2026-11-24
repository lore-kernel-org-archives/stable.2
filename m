Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484408;
	b=j58Aq8w/qe+8G84ZKA5M/KRGMxxHc53dBMZx9P0YUcUBWck/PGT4j5NeXCQlsFobnftN
	 pJealS852vLlu/OJB4lO7RtS+ANdbR9HbVqmJUKUtJI1CyKDavvjfMkKX+EMX3pZ7CKhy
	 xib0V89dOFflKwmwpbFzvyVhheOH58ogZsJr2XnnecKqCGRp2T9WYXw8tZg9RlYpR8qp0
	 lOeA7dlVqH4HFU3ESjK4kihd+T8Ggl0IYMQVvqElTZj/Dc28Va6erVB/N4JcLvMoaOfqd
	 RMYm6IU6LaASaV/+god7zQaUO1WmlRuVaGFpvwpyQ+obh6GZERKuzQxnakAXRyKv7vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484408;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=FhNSJyAl8M2ftrmL501v23K9HFYihd0BQJIUzsZGTic=;
	b=aNI+RzCZBmkosUDw+XYMhzUw5hnKTdCfqw3TYep6JAe4KyZJDdM/4HLFZrGtOLeEGAVQ
	 KbIjCldJGs2bIpjhbGn8EVSFWFoRTOKTeWvokQssjmkflc28ORVgf9z3IaEh4qPNQ/Lbw
	 jEFvZyM6oyRKwyb3FAk1CGGCyFVNgTahxzcI8dE63Izdrf8Ng/uEKb0gpei0iKv8ic9cM
	 SBheG+zxSni21j6h0BaCIS9kylC5C18lCFMe9vF9sCC7BQyQ3Lqk4uVU/BdYZeikTNQbS
	 R1TO08PZNNpk+aGaevCnUDJEDk08jRRt0lCvuHG4NHvCqRZRuE2sHroRKl5hldDKJGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=D1cJO60x;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8FRfdyVd;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBD606A32C;
	Tue, 24 Nov 2026 01:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DBD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=D1cJO60x;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8FRfdyVd
Date: Tue, 24 Nov 2026 01:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795484399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhNSJyAl8M2ftrmL501v23K9HFYihd0BQJIUzsZGTic=;
	b=D1cJO60x2YSc5s1FfRbmjsWxteqsjoWV/wRtHIXF5A/x1ICqycX+dXhLBWgugTOFgA0bfh
	gus9P9Z5zCCxLCFcauADb/QNkDQhYQMizWoem4u6T2aQMTYn9L+xZ4YMWuBgqgmqc0CEom
	oV9irV7El1JDPueaTWr7yOanH/aIccXPrB5OTM5uW9ImZwmIbogAxt1Cq3zttgxhg7VtoW
	SUE7E/4CQxNaAQPtec13lhTSVFpvpzo251TP2JmH0aD4YlrcN1//i/3mgQEVfuZPoDYwEZ
	iBLuFpHTov1fbB7HLOgcu0SnSi+5zX4mIB5HuvKOFM3mdF/TiuhTdQnESolffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795484399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhNSJyAl8M2ftrmL501v23K9HFYihd0BQJIUzsZGTic=;
	b=8FRfdyVdvlHQ2/h3vlHlHkobdxadFa9l7Cz3gUcauMtEyzpAsY0nHMRbVFza+Ig+COsFR4
	4QfFwazM0kvzQcBg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mce/amd: Fix bank lookup in amd_mce_usable_address()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261123232701.1923094-2-yazen.ghannam@amd.com>
References: <20261123232701.1923094-2-yazen.ghannam@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179548439725.92412.1492758991101428916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d734667216e3fe13f0d81231f0e5691816ec42f4
Gitweb:        https://git.kernel.org/tip/d734667216e3fe13f0d81231f0e5691816e=
c42f4
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 23 Nov 2026 17:26:59 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Nov 2026 16:35:45 -08:00

x86/mce/amd: Fix bank lookup in amd_mce_usable_address()

amd_mce_usable_address() reads the per-CPU smca_banks array at index m->bank
on the running CPU. The index is not checked, and the bank belongs to
m->extcpu, not to whichever CPU is decoding.

m->bank is unbounded here. apei_mce_report_mem_error() sets it to -1, which is
255 in the u8 field, and apei_smca_report_x86_error() takes it from a firmware
CPER record (BERT or GHES). Both reach this function through the decoder
chain, which runs from a workqueue on any CPU. Bank counts can differ per CPU
on SMCA systems. So the read can land past the end of the array, or on a CPU
where that bank means something else.

Use m->extcpu for both the bound and the lookup. A bank number outside that
CPU's range makes the record inconsistent. Don't act on such a record: report
its address as not usable.

Fixes: 821f5fe4dbcb ("x86/mce: Add support for physical address valid bit")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261123232701.1923094-2-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1cc20b8..255d09c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -837,7 +837,10 @@ bool amd_mce_usable_address(struct mce *m)
 			return false;
 	}
=20
-	if (this_cpu_ptr(smca_banks)[m->bank].paddrv)
+	if (m->bank >=3D per_cpu(mce_num_banks, m->extcpu))
+		return false;
+
+	if (per_cpu(smca_banks, m->extcpu)[m->bank].paddrv)
 		return m->status & MCI_STATUS_PADDRV;
=20
 	/* Check poison bit for all other bank types. */
