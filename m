Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785528;
	b=c66xMvrVyBO/lqabwPkre4rmK1o/xZE/kL3tX1IBRrjTjzVcdBl9+vTc3FblIqky0Gw3
	 gWR9FgA1fPugwoHMI/OIb0nS8Tw8JHHkb3Jd1mfvVkrNDE2irqa1lIlTBsRk6yn6yD8CB
	 Va1njkv83eCTCAdZ3EAH74vYHL016DJFW5awoUAi4frLyzfJTASmc5UzHx+PIyzMG/mne
	 txDCHihvikCDU4zpgpyt6cOxSSTaZExygr1I6j2ysLT4/zs9oG8MEuDJRHd4lwaBKUrzP
	 yam20h910uJMK3/tRIz8WDc6SZVEtHW3fSZLGEB3g2BipyV27FkTXDaoa2F/5vLS+uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785528;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=pmodxiY3Ppb7NKigYhr0+ChfTh+MmQ9h/TkH4AwrA1w=;
	b=syrJf2Q9shOxlkr2hnoFfv7s5Zg2BMcFlCuF1jCNfn3LqS4LlHnjMm3+PCiuDeBIjyl+
	 7f3JmIUtAQ7k8RrYNkY6FmqTmVv8sw7vH1pDk+sa1osqRLaFFP2ji4GoHMQ/9B5VoL+5i
	 CJyNl5rf7VjNScuS7ikMOiMLRAKm3FSEWgmvaASuwzXX1U0Iq5Qk3gK+wXFQvRC53/Okh
	 RU+tlEe+9Yo9D2MC49HAVnrUNQySrzcjGGfZA3nXRAdveYxRLeLfHIdBz1YorC/rzMHww
	 NbvQoYTwIwnwAnfdynj55RVHQ1ySY740Q/KL/a/qpWuyFUgzIdOmxlvyom+bqyR+Jdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LjG0An3f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cujhghZW;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578B606A32E;
	Fri, 23 Oct 2026 19:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6578B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LjG0An3f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cujhghZW
Date: Fri, 23 Oct 2026 19:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792785526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmodxiY3Ppb7NKigYhr0+ChfTh+MmQ9h/TkH4AwrA1w=;
	b=LjG0An3f+zfoR+n/kzT2v9UdOUl+JkExQ5s5XohwCd/tpj7jkKeeyywQIL/SMjH0bsDKuk
	+9cmoFIL7oEJJ9FPv8l3DDgkCtNb3XGW65Sm0ij1sFvXlTxeUZn1fAt+w+PXYprVN6+bcw
	tb74+od85Y7JU1Q+RHWjjE74Y1UGiUictnQs3QRxV2VP6nWuUHTwcmj/7QYnpJTm4gDQKr
	nxGxntr9G92AIlujtFHfWlPTn0a2/KlqBuEbPkngAyacRhWZHHXshkKVDCN1HZypqZwDXU
	PEX67HrHOZ2fwJ8mdvvWpUf5PASEKlJEsvGsIyuUAxrGNbH1/s5K6oXzk6Dtyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792785526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmodxiY3Ppb7NKigYhr0+ChfTh+MmQ9h/TkH4AwrA1w=;
	b=cujhghZWLf/jG/oYeSDadTEzY/sKUy4Y8ikqveTo57eutwdACdo1yoAEbUKHdIU9LVfY8W
	/k0Pk0qztCHlryAw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh_=28Schneider_Electric=29?=
 <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Update offsets on sequence counter
 retry in ktime_get_update_offsets_now()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20261023-timekeeping-clock_was_set_seq-v1-1-61c4c53d031c@linutronix.de>
References:
 <20261023-timekeeping-clock_was_set_seq-v1-1-61c4c53d031c@linutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179278552435.3012171.14073030617954581648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     6541fbc942f3b63bb8bd44e34eee6223e0abe719
Gitweb:        https://git.kernel.org/tip/6541fbc942f3b63bb8bd44e34eee6223e0a=
be719
Author:        Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weissschuh@=
linutronix.de>
AuthorDate:    Fri, 23 Oct 2026 13:49:17 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 23 Oct 2026 21:52:01 +02:00

timekeeping: Update offsets on sequence counter retry in ktime_get_update_off=
sets_now()

The sequence counter of the cwsseq target is modified during the
sequence counter loop. If the loop retries, cwsseq will now match
but the offsets contain the values from the previous loop iteration.
These are not guaranteed to be consistent in themselves or with the
current loops "now.

Save the target's original sequence counter value so that the update
also happens on loop retries.

Fixes: 868a3e915f7f ("hrtimer: Make offset update smarter")
Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weissschuh@=
linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261023-timekeeping-clock_was_set_seq-v1-1-61=
c4c53d031c@linutronix.de
---
 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1b34282..cae3e51 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2849,6 +2849,7 @@ ktime_t ktime_get_update_offsets_now(u32 *cwsseq, ktime=
_t *offs_real,
 				     ktime_t *offs_boot, ktime_t *offs_tai)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
+	u32 cwsseq_orig =3D *cwsseq;
 	unsigned int seq;
 	ktime_t base;
 	u64 nsecs;
@@ -2860,7 +2861,7 @@ ktime_t ktime_get_update_offsets_now(u32 *cwsseq, ktime=
_t *offs_real,
 		nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
 		base =3D ktime_add_ns(base, nsecs);
=20
-		if (*cwsseq !=3D tk->clock_was_set_seq) {
+		if (cwsseq_orig !=3D tk->clock_was_set_seq) {
 			*cwsseq =3D tk->clock_was_set_seq;
 			*offs_real =3D tk->offs_real;
 			*offs_boot =3D tk->offs_boot;
