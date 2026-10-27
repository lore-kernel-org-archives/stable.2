Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097989;
	b=ay2+cg8w98lpDTNHIP94ChnrNNCc65gadQUtbAWEyhFiRZ3xfHJFZlT0dbuBVPrijK6O
	 ztFvQUAZ1eER8E5waCx0C9NiQeTqUZS5IBxrXZvZ0Yg62hRFXErrUqXKOb/0lUICJv8Fc
	 +kCheRE232LTjB0I3SnPb62R2kDiODJEOSp3FVk1P31YC9nv0JaojvtNlByyXYoZk6Jmu
	 a+vLEMhtaBenu3TAMJpTg77urWZSQhbasyAFrR+liWcKI6hA5AdnAd6Si7dpaf5TxffYT
	 0xwRUwlzttaniiZkQtGUwOED9N4qELuoTGJbPSRj67T7BOXuOtRI/DALprl7JSbiwRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097989;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=5Vs5ndS2ROIItVTRiDUX3nUYZx63qxUzwdl+W5kNnhI=;
	b=2CMt+ory8TV/DReW048Hcd9t40Rg3pxXATk1/LDY+qvD17+gZnRAliSS7bVJZw9/pFk5
	 ACdMxg61bTDQ8PHWZQp4pa3FQq4OJEse2S0RGW0BKI0AvymPMHKVoVCZ5MuM5Vaof3dz3
	 FaTIsKMpHjAKY2OAUgAZYy1Z/BpjjoTlgpZsKeHdcqxCK6hxc+VSOEw7KXGAG7PCXNMQS
	 eOUOHswrdzn6sMakVkBlLEPzR/d+xrW9vD85x9QWI0gE7o741hT7fz/MhsurUMwA86ScQ
	 GbT2dQk7gzWqlRRFrRm21XOdI46wkoR0E5IFq022qmGi1URo9WlNV8CLxcPxp4lcoHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pDRFcNvi;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43222606A31A;
	Tue, 27 Oct 2026 10:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43222606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pDRFcNvi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=5Vs5ndS2ROIItVTRiDUX3nUYZx63qxUzwdl+W5kNnhI=; b=pDRFcNvizUZNwBNHBQDf4cT86I
	bSWg2dh0Zii3ieQuGvFrWZX+fOgrN6KfwSkoyKp7shsF+v3+MOLZAkhziSSknBlapM4Ve/2n3C6Du
	oBSS37Q9OzG4OCAlbWO6Iwj+yZkLn1f9cmVTdvTrvtrfYdXmtKiEdYI/+JUi8VOsfNjDZ767nWpx4
	oQcN2ciLVX5RZ3AXZVn8JKOptJQheEGAtCSQPfgXNhIc6msR6+etpr7SV/loz3RboHHqo7Mhos/gf
	/Vlzah4okFQ1ChReBUYuaabraIVFTFip52XbBtfY5nMLfF+uoB1cnGpT35Xm9UPVYm9+qgtFC+1O/
	TyzYbx+A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLehB-001P1Z-1K;
	Tue, 27 Oct 2026 10:46:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 27 Oct 2026 03:43:51 -0700
Subject: [PATCH] x86/nmi: Ignore negative NMI handler durations
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
X-B4-Tracking: v=1; b=H4sIAGmA4GoC/x3MUQqAIBAFwKss7zshJTK8SkRUrrUfWWhIEN09a
 A4wDzIn4QxHDxIXyXJEONIVYdmmuLISD0cwtWl1bayKu4yR1+mSwqqz7aIbz8HYGRXhTBzk/rt
 +eN8PulRcPl4AAAA=
X-Change-ID: 20261027-nmi_negative-876c14def27b
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel-team@meta.com, stable@vger.kernel.org, 
 "Paul E. McKenney" <paulmck@kernel.org>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=leitao@debian.org;
 h=from:subject:message-id; bh=DfX9yGq/hRTEBVgaZ+1kGHTYBcKp/gGuPYxnhsGsefI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq4ID4OuYskGa3uP7bFJSNETdpI1SWXWw/4NvKR
 ZuBJ4zA8E6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauCA+AAKCRA1o5Of/Hh3
 bTQgD/4uuCcgkh9r8dn9dAH0g4VpyTZisz3MLhsa1sTfQLH2ZLQOT29YK0XaVCvoa6b21a5tAgW
 kG81kHkALqPXwVwzim5uVP4JNO8q9UQ+iwWUPP9kgmIIW1X/0LwjyKQdym4ilCssdvPwsBwiqEl
 FTljEgB8XFQm1VFwKaLz5xiL7ZAaxH3p2Vy11ChkelGsXG/8WEV6Rc20J3pURLrTsEEaP+netiN
 u9CeuBX4LZdX/2J5L/l6foSpLwKy6lBVziZ6p7mQ9o7cXKd+yx9p7ASjytKZTTtW3SHm3HCiJqt
 2qy2jE7e2wM2JIBub9g87YaG27tVJeHol0E3egms8pbHGuamlNuBPDchrx7vHxr9zdxB5Ba5xJN
 xMvSh1/7WHg/8AwsOD7aOp3dKR8AzwWxdOrcGVl+CuaVSWL5OZFMcrpGp014amYundGuhF9lAeD
 gBfJxkks+s8nHOkHCit4S2lfEzl+/koZrq9MsLNX76RObAAf2Eo/sGBqzItD+oLvER+jN0cr8jR
 pZ03fA3xDgKsxoXtczHslThq1+cAK+BeSp4ZtS81dZ/KLy/43rSPDKPjnviT2tUuWk497PRL/8c
 j6VqypM2yiH5zF1TRFKwsrRFCfc54NipYm2lQYXTTWhTtPg0Z+Fvw9Fn7ic4f0hSacOsw9J+rk5
 0ho3yB0HH/QQP/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

I am seeing NMI handlers in the Meta fleet reported as running for
about 584 years. Over 30 days, 11 AMD and Intel machines logged 637
such lines, for example:

  AMD EPYC 9D25 (family 0x1a, model 0x11, stepping 0x0):
  [ 1650.616627] INFO: NMI handler (nmi_cpu_backtrace_handler.llvm.9643156322683129580) took too long to run: 18446744073709.551 msecs

  Intel Xeon Platinum 8321HC (family 0x6, model 0x55, stepping 0xb):
  [360448.230129] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 18446744071018.936 msecs

  Intel Xeon D-2191A (family 0x6, model 0x55, stepping 0x4):
  [81787.188959] INFO: NMI handler (ghes_notify_nmi) took too long to run: 18446744073709.545 msecs

nmi_handle() times each handler with two sched_clock() reads. When the
second read is lower than the first, the u64 subtraction wraps, and
nmi_check_duration() treats the result as a duration. In the three
examples, the clock went back by less than 1 us, by 2.7 s and by about
6 us.

The wrapped value is also stored in action->max_duration. Every later
real duration is smaller, so the handler is never reported again until
the next boot.

Whatever makes the clock read lower, a negative difference is not a
duration, so return before it is stored or reported. A clock that steps
forward is not covered, since that cannot be told from a real stall.

A backwards clock is still worth knowing about, so print the size of
the step once per boot. This uses pr_warn_once() rather than WARN, as a
stack trace says nothing about the clock and panic_on_warn machines
should not go down for it.

Fixes: 2ab00456ea8a ("x86: Warn when NMI handlers take large amounts of time")
Cc: stable@vger.kernel.org
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/nmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index aae7254774680..57a0dab1ec7a9 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -130,6 +130,14 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration, struct pt
 {
 	int remainder_ns, decimal_msecs;
 
+	/* sched_clock() went backwards? */
+	if ((s64)duration < 0) {
+		pr_warn_once("NMI handler (%ps): sched_clock() went backwards by %lld ns on CPU%d\n",
+			     action->handler, -(s64)duration,
+			     smp_processor_id());
+		return;
+	}
+
 	if (duration < nmi_longest_ns || duration < action->max_duration)
 		return;
 

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261027-nmi_negative-876c14def27b

Best regards,
--  
Breno Leitao <leitao@debian.org>

