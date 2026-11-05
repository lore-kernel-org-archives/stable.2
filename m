Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886478;
	b=lXdYQkjGHPF0Yk/nkwurL8apqVeVn3b+hHV2BA8E61H7lqhcPcvcFiYRLzzfYVGZbNhc
	 8lPdZYNWL1mPR7b7BTweywhQx7l1Mk4R4ALzMQSTe2myOrBmrwNCt1MZQyE+/Y0PBFOTJ
	 COVT5JO2kfX7h2cVWxqX9W+BF/vM37MYZoXA3eIhTwcWseAFCsITwT2I+8RQ7W8/gOc0t
	 2TUxhs8vV6CReKorkrZiV63jjZF6uxGU/HevPjh+VHX7pbtlxuWJcGYzQkSF07cQCcOIW
	 BtXJBhkpwRiWDHaik3nYoah099/OSJgawb5lREVdxVS9TPQevcYdzPqL6rOOJsM/+vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886478;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=uWmr2ZKtpH5h2OBV51HqQXW86BPRnxbtgCLgC9kQTMc=;
	b=sjzN0Tbg2lUQRxOaimybqWqTJ86maC200QUsNmqFfk8Htqgl08Qgk5bjEjjnSng2G0sB
	 N/UrnE/zGr9fK+mp/punu3vE4sb/ruYCckzqt87+RsG2uRaNPT7j31Em4GjFaB3Y5kOX9
	 9Irea1kiUxvhu2e+wWRxq3K4Jr6UC7N/P4TEctbAAXmRjhdGBs6qBF23AHPO0HXo16Mr/
	 u8lGfU8Ib3gIilWywRasvmlkgDbCVkwRR356R8j1spTIhZDEZK+fH1DGH+xVskeu6ztrW
	 jAG1gdN7BCYJlWVhAXEZxyS6H9phfQMWlaOv3s3ura0/JMyICTKZ9b25KzCa7/Y5cuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ugreen.com;
	spf=pass smtp.mailfrom=ugreen.com;
	dkim=pass header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=Ztw2RQCn;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413A606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4413A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=Ztw2RQCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1793886434;
	bh=uWmr2ZKtpH5h2OBV51HqQXW86BPRnxbtgCLgC9kQTMc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Ztw2RQCnLQfcR4U9kakqB6V0UjyhhVSYoAq45CNr2gudtBf33qcluXLmHfd6zuopb
	 ZEZvLTwWq6jBMWDP89qV/Y4hZJ3+MYYhyhJuS0tLQjDX2/bMNGg9JF4cjvgYpslcC9
	 Mq7+/z8h+ZjqHnZ1VdeMhSgg9z1apA/Slqw05Iq0=
X-QQ-mid: esmtpsz16t1793886427t16ce7834
X-QQ-Originating-IP: KKWTrCpi6UQoea4zvr1hB8wuxKsh3btIMCG7n8Tta0I=
Received: from exmail.qq.com ( [113.89.160.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 21:47:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13853959520253082465
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Uma Shankar <uma.shankar@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dsb: Fill all padding before GOSUB
Date: Thu,  5 Nov 2026 21:46:58 +0800
Message-Id: <20261105134658.3724628-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N/QSj4NLaJeCQCnt9gDBf42r24NF7upe809LvtZkO6Vu6jdYBWKR5JTK
	GNX7BD2t/4oaqkKPfM9fhhvXLlLbFwGVSh9Y6Fw530tO2OBpJTbaYi7E61ukrFfxx4lhk3T
	TSlc1jRghB7Ieyr/Zzx2HeNIN/dClhO6Grycbn3A0TKCX82ICrofxs6UHOXukfnp0sAD4jS
	tR8YVuZmTfXZD9TDqGwePFEHt/qxvVSwYiIoSqQmOywl59RM+09e1w0tOnKDf25VrVv6CsV
	mttScFZG3IfMtjck8KhT7Mj84UaFKkF+6xRjYbMXRZ3gc9dhF5T5Lz87wLztfR1VhOIkIXJ
	+6RQtMhXT44r5bBBj5hPdRE7s8mt5wvc6CPKrrC/vvNLexdeCWSceRskLWb7i3MKDRcW5UJ
	o/Lu+Wv7lZ0nG5re5QeRTEg8cYvJI/HQcBtIO7xouEz+92PXx4Od1EkTyIGwp5cUCzvjAIT
	fGndpNA8uXuRGf36cTTpDUS32tSj/n9uzepurREp7vgPQr9Q9F/TDI+w2wNjYQIdLfBmRb5
	1hMWf0/Q8FC8EjQmHV2a5rCXl09FrBC1uraOH/o4RxQxwlgFzQh01+T71reoifSndIh3eh4
	oe1d8VcFr3xfMFW05QuqE9eV/G4cExtMF/0xQ6VaoctN/wzWanOnSYybz2DzDnB4NgcXrTT
	uPJjr/lPnh9VHX3A/44m7S0fM67pHuqlaBWiVmRHnKqvVW1gJ1THUS7jbwUWJRbtoHv6QmR
	HqmFBHIUNijzDKCA0CHODA7Bb7GcKwP8c0AJBkxoHXqczE5nFj15uJ8xCsyhChU3rwIZ1WO
	DOcKB5NyRC7DL2RKaMUpaqyUZoCe8N5IDuNFgA2NlW2owGGyt3xFCAbmdT+yuCYagQAOjuk
	75VlwNEzEnj4vQFSVYIymBUXDDMfBVnpYN/SgK00eRf65aRrMnXIO1TBBsuudGO4If+2PSO
	xB4hVASPOKKmJ4F0jMUKHXv/21xJ+PvPHikFjzYyT9PHaH0Vjm7dsASi5cSjXXm8b9xHdGC
	JLzYRAgnj78VKofsECyfuX7gf7Gto=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

intel_dsb_gosub_align() aligns free_pos to a cacheline boundary
before emitting GOSUB, but zeroes the skipped bytes only when at most
two QW slots remain. Any larger gap stays between head and tail and is
fetched as DSB instructions.

A Panther Lake dump taken from a DSB idle timeout shows that gap: the
tail is 0x58, GOSUB is at 0x80, and the 40 bytes between them are
nonzero instead of NOP (opcode 0).

Zero every byte skipped by the existing alignment. Preserve the GOSUB
placement, which avoids cacheline QW slots 6 and 7 as required by
Wa_16024917128.

Fixes: 2c41d62f6fb1 ("drm/i915/dsb: Implement intel_dsb_gosub()")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
Hardware: Intel Core Ultra 5 336H (Panther Lake), 6.18-based kernel
Reboots:  7/100 DSB idle timeouts before this fix, 0/200 after
Build:    6.18 backport; both xe and i915 intel_dsb.o
Upstream: not built or booted
Reproducer: upstream intel_dsb_gosub_align(), buffer prefilled with
            0xa5. 5/8 cacheline positions missed NOPs before; 32/32
            pass after, including the 0x58 -> 0x80 gap from the dump
Limit:    these results do not show that every DSB or flip_done
          timeout has the same cause

 drivers/gpu/drm/i915/display/intel_dsb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index d9a270362a82..b71e99ed8705 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -607,8 +607,13 @@ static void intel_dsb_gosub_align(struct intel_dsb *dsb)
 	/*
 	 * Wa_16024917128
 	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-7)"
+	 *
+	 * free_pos always advances to the next cacheline, so the skipped
+	 * bytes remain inside the programmed command range. Fill the whole
+	 * gap with NOPs; clearing only slots 6 and 7 leaves a larger gap
+	 * uninitialized.
 	 */
-	if (aligned_tail - tail <= 2 * 8)
+	if (aligned_tail > tail)
 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
 
 	dsb->free_pos = aligned_tail / 4;
-- 
2.34.1

