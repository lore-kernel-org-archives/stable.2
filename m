Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252032;
	b=Pv5sH/0QdzvvzKRHbR5Enxinp39D/2kLyQBNXwIu2pBp0Pi5QrdQ57+6tX+GJta5a33i
	 l81PFMho9Ez2asGjFA/jz8azvITATyLEZ2VyM4YTivgvjquoBoUTTqr3NyMAiphUxPNqQ
	 g22QURxabV/9vh8zfzeNgGwdTyOc2F/KDq00OMSLM3L9Ev1rbtMb4xqY/BssTPsHEIJ/X
	 MtGuXqYYLqgKSYiauqrrFt9wEtZp/SARlx1Rjs+3E8IabEbSx34KJvtsS0AJRRtr88W0W
	 DpkftmXaVpnRelpAAoPlHZFbrYmHqi+a9xA8sn0ZuwY8N04h8M5CIqrZ9r8d9xWRWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252032;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Rvcjc6PqYVgkvvfwOJd4GAtJx7r2l+4o4rkGqARQJHE=;
	b=sxpwxKlGuNJAwCd/Gcy5UIYWGigwXefN37d8A04AuPXFnxlddSI8beSfHK1ojHCMhafT
	 d2okRPDefkWeDicUi1RR/P+D5p6deL51l50lHsDhru5oe4GaVfXhlVzyXB/bflkg4/OaV
	 R4kc7eU5y4Gc53f6RgZ22lYRj67yiXfo4I4fYAhxx3w0/fAJcW3ModFLOpfgtL/b+1WXQ
	 2QGooe+RNTEfmineOLZhMHZUhRz+B6AFxXj0U8yH2lDMjrjMQDz1QCqSuK57Ot/ysmel8
	 /HPt7I8hE5qg7p3GGFe4YTLXbFI1E8+1ng+bOGmCkJvO8k5e12nHbadkFgOBIxISqDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rCDDp9cB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=P0hjlzfG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F99606A33D;
	Mon,  9 Nov 2026 19:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F99606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rCDDp9cB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=P0hjlzfG
Date: Mon, 09 Nov 2026 19:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794252029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rvcjc6PqYVgkvvfwOJd4GAtJx7r2l+4o4rkGqARQJHE=;
	b=rCDDp9cBykavpr7fBJBE8QoqairmUx+xeLjZJ5HgzF3e8APqkYaaexmFBUc0CoNdGEENbT
	FNCh6FnFqe0BpBNHjkZd1hFNadfm16UQQj8h7DxUkK2S2g7VZ0DXLp0jD6xSsM8B6ImaL9
	l+E9pxOR9kOUK7VcYLHMbuYRwXq+acln+Mu2c0C3GZDKhE+q4C+jMfoVX8VnEs9XssEFSw
	IKEwQCZ2rhC3WQ1wzUDDyBVUTO8D7jyxKOVFpL3kW+haQJvkl+NfZjWzK9X/PT4i/qNv9/
	RZPXU2TlrbTVE9pVuNINqH9cpYh9e6+TNDKx7+KhZNpNog4z4R71w2bGc2rQPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794252029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rvcjc6PqYVgkvvfwOJd4GAtJx7r2l+4o4rkGqARQJHE=;
	b=P0hjlzfG0W8ld4H9pWuAmpjTo8mfpkat2luY4bEZdfTxMDxaYcDfFVHnxCTV65Kl6RkC9S
	50SXEdUuqfR7ncAw==
From: "tip-bot2 for Hungyu Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Read getboottime64() offsets under
 the sequence counter
Cc: Hungyu Lin <dennylin0707@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 John Stultz <jstultz@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261030054227.35453-2-dennylin0707@gmail.com>
References: <20261030054227.35453-2-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179425202812.2093942.1394999067957654911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     385b5ec1f31dd39297578eed42be74b07ae74017
Gitweb:        https://git.kernel.org/tip/385b5ec1f31dd39297578eed42be74b07ae=
74017
Author:        Hungyu Lin <dennylin0707@gmail.com>
AuthorDate:    Fri, 30 Oct 2026 05:42:26=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 20:15:58 +01:00

timekeeping: Read getboottime64() offsets under the sequence counter

getboottime64() computes the wall-clock boot timestamp from offs_real
minus offs_boot without checking tk_core.seq. A concurrent timekeeping
update can leave the reader with an inconsistent pair of offsets or,
on 32-bit systems, a torn 64-bit offset, producing an incorrect boot
timestamp.

Read both offsets under tk_core.seq and retry if an update overlaps
the sample. Convert the resulting local value to a timespec64 afterward.

Fixes: 7c3f1a573237 ("Introduce boot based time")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261030054227.35453-2-dennylin0707@gmail.com
---
 kernel/time/timekeeping.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcf47f1..7d7a737 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2700,7 +2700,13 @@ void update_wall_time(void)
 void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
-	ktime_t t =3D ktime_sub(tk->offs_real, tk->offs_boot);
+	unsigned int seq;
+	ktime_t t;
+
+	do {
+		seq =3D read_seqcount_begin(&tk_core.seq);
+		t =3D ktime_sub(tk->offs_real, tk->offs_boot);
+	} while (read_seqcount_retry(&tk_core.seq, seq));
=20
 	*ts =3D ktime_to_timespec64(t);
 }
