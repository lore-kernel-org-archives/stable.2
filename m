Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A654DE703;
	Tue, 22 Sep 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070392; cv=none; b=IQy6wSiaebye+qYBldUYqaHE2HBA8Cur0iBLwnEFw6Zkjkh1kMTyC1rz38usrtF7YnE+0wifZdrl/VMnUZyU5p/YhzKYRXApdgwRAAF+9n3UaNEqX5b5NgJZAqoWd2JSKD57N1BgVAFdXNDxd038bWlJV8RmK00y8ZnIidhS1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070392; c=relaxed/simple;
	bh=Ohc+POuEZ8exh2NwTUCRxGX8iAG4TwM/bhruIJ1rcKE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=naYjpxJGdeEZugBI+zuYCJc6WRexqDTr7TZhBtPFx8BFMnO/0NakCSUC3P+05h4DAesj1BjdUFG+CZ+2r+++G4dlNqe7gCqn5NTDpAWAE8c80UboawBEFKQvXL8vCwIQ6IN4kbWQ+1IgvjOgYocOrrzkP0K6FkoLirkcupWCILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5l1LIei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6pp+xvU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5l1LIei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6pp+xvU"
Date: Tue, 22 Sep 2026 09:46:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBGP4XMjBG3iz6sjgiyQw55/b40qX6SuE5n8+2NrFsw=;
	b=S5l1LIei0kNn1zhVHub1KjzYP5JbfTByaRmMnJySmWQwYJ0snQrjSnw8Gk/PnqQTbu9aNU
	SzazC4B1+Ep8xEBqCrZcOOXtDzJ9SNzUNwNWNot6GDr/jvg/XpVjg84bcruFqxnAcfoPn7
	IfjZkVleg4mL5NsAzsnUpqEhw5l6a91UBJRiJa5Gilep/STJifimNXJb3QHWGTBOVYvYGn
	ojGIPvsf+b2z/0gScMweep4QRg4HEerJCFUgXHQaGk+L7sggUQK3i0dqBsHBk9WSgJJrNT
	l7OtV1i2eNPsa/fIvUMpOHQf5Y0cWbN0UA5tdUU9K83FdopF0v2i/D4MMidGUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBGP4XMjBG3iz6sjgiyQw55/b40qX6SuE5n8+2NrFsw=;
	b=h6pp+xvUW1ybr61WzIizaxj1SOaHidqospbAjMmrfbxGBzQbWff/VIx8LdHvKc33PUs1wQ
	rXs5YiEOWBIS0fCw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Constrain Panther Cove
 UOPS_DISPATCHED events to PMCs 0-3
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-10-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007038661.2819794.2643528060383889322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     04a7ef3b7aa3af34202285043e3423a2e3983595
Gitweb:        https://git.kernel.org/tip/04a7ef3b7aa3af34202285043e3423a2e39=
83595
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:31 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:35:40 +02:00

perf/x86/intel: Constrain Panther Cove UOPS_DISPATCHED events to PMCs 0-3

Per the latest Panther Cove event definitions, the following events are
only supported on PMCs 0-3:

- UOPS_DISPATCHED.INT_EU_ALL (0x1b2)
- UOPS_DISPATCHED.ALU (0x2b2)

Add explicit event constraints for these two events so scheduling does
not place them on unsupported counters.

Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.0+
Link: https://patch.msgid.link/20260917015234.981153-10-dapeng1.mi@linux.inte=
l.com
---
 arch/x86/events/intel/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a7dbbed..ecf6d63 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -506,6 +506,8 @@ static struct event_constraint intel_pnc_event_constraint=
s[] =3D {
 	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
=20
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01b2, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x02b2, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0847, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0446, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0846, 0xf),
