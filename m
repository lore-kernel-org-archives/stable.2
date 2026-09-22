Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F94C10D7;
	Tue, 22 Sep 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070396; cv=none; b=g/26FKgkdoO/Yi/q7sQdnlqjf8ppsBflgWYA+GK+Ef6SG9DBiOcti16+kue33bmVxJmBkOOiZJ9pAf0/kCZ0OMn+7XOK4j44k0htJnilrmKuZCYtugXuo5j+HkqsKFD977rW/W7ZXFR8SqQqWALndshO/uCjg7YgUIbhpcRZ8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070396; c=relaxed/simple;
	bh=j+Hb/TyisW3JUiZx+Vljm8qwHpvuQVfbEnx2RL71uvU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SUXgTxssaVxaBmkFJChVL5akP7Nd9+WKBfXgti5qKHPGvzYgWAVLIeoQcyKmnhe7SUW2FkUP34GgTXX2LTz3n1YojJ+2wjlIfgRDpCZB7xBGexX+0ha/uFVwJ/UcxPPP+H/cLy1sdXohq1sb44iMMXgMy/dQ9xlBmN7wUU2uGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7qf9/dT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rr1i4Lf/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7qf9/dT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rr1i4Lf/"
Date: Tue, 22 Sep 2026 09:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBDiMnLCG38ExfrTP1wBwecv2TxZY8Nj6c5TEeMvfxY=;
	b=T7qf9/dTV20CHa1UIoui22qbqH1kdXXAR3IXSOISLkDlI8K9mmxUJouS39oAAKW36hQ6mV
	LPleuWr/MuiNuIucLClcG3RV8fd0+7ykvGMlBvaYj6frFXnUgHkbB2CvYcmEJo4v9bM/CG
	+m32NzPAF4dSskJ27u7QPBv9Ya3yX5rS/BBlKa+6KkXRZi5AecEZrdDWPpgGW6TFk9Vdud
	DQogJx0oTx1ZI3+TneCPHksAXJcMGurP1gOqgQJ1BJaez4lcsfIMxZf/W2ff2KV071aqAu
	An4L3DasXxQvlnpdaq5qGU0fLDdQCDpHwGKHD3tcHB+7Xr9pTpjK5oB0u2pFAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBDiMnLCG38ExfrTP1wBwecv2TxZY8Nj6c5TEeMvfxY=;
	b=rr1i4Lf/I633Vg9vWEgVXKTIB+u5qiY/q4xRbGTMyCooNn/ZwXll213DAfr1hgiPSDgveO
	0K+25jBufBRlHCDw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix Panther Cove PEBS data-source
 snoop states
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-8-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007038953.2819794.4249095607827118271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0ac5d6ca2c3b7d047963b67dccef17902dc6c017
Gitweb:        https://git.kernel.org/tip/0ac5d6ca2c3b7d047963b67dccef17902dc=
6c017
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:33:06 +02:00

perf/x86/intel: Fix Panther Cove PEBS data-source snoop states

For Panther Cove, the snoop states for the data source encodings
"Prefetch Promotion" and "Cross Core Prefetch Promotion" should be
SNOOP_NONE instead of SNOOP_MISS.

Fix the incorrect snooping states for Panther Cove.

Fixes: d2bdcde9626c ("perf/x86/intel: Add support for PEBS memory auxiliary i=
nfo field in DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.0+
Link: https://patch.msgid.link/20260917015234.981153-8-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 72179bc..d0329a7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -277,8 +277,8 @@ static u64 pnc_pebs_l2_hit_data_source[PNC_PEBS_DATA_SOUR=
CE_MAX] =3D {
 	0,							/* 0x06: Reserved */
 	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HIT),	/* 0x07: L2 Hit Snoop HIT =
*/
 	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HITM),	/* 0x08: L2 Hit Snoop Hit=
 Modified */
-	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x09: Prefetch Promoti=
on */
-	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x0a: Cross Core Prefe=
tch Promotion */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x09: Prefetch Promoti=
on */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x0a: Cross Core Prefe=
tch Promotion */
 	0,							/* 0x0b: Reserved */
 	0,							/* 0x0c: Reserved */
 	0,							/* 0x0d: Reserved */
