Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661000;
	b=tEugZ7wIGgbFfhGJRPHhpNhYW+jGh0Anpsh/mSpQva5ISg0sXyewKkejNQkZDwsljp/n
	 EsIGtWk81OK2FzKKgBOhzOFQIM5Kqb3nlDl38uUSirdqt8Ym4TxC94M9jys5UUuy2plt8
	 sZBc+nyWXnu4Xz49VvQxHWC45w/vdPGTYM3ycZjEycJmsqpmcleSPla0jlYlSegJ8haFL
	 Dh2QsnLxzXMX8ATgnJtyNPGIChcCvWi4ioWCQsTTBuriNbjBYWkHcdVmUgEPfQZBBparO
	 ERSkcWs8YX8wqjWmYgpfRhU1kfLD3oP0yXyfVWVoFpDwnkfjUpH3x4pd+MG3ccuzQ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661000;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=icAtHuOIlqxpJbKeEtpLnDpY6r0X2mjeeXW/VZe8HYw=;
	b=C99UNx8NE4xEE9w+1CKpqjzd0kqn19Pp/RRNDDJhdwjVH5KnYIrZbE1cmw7yP2V9Rq+b
	 5LDxHf70Fy9lnfzO8ghma/1DsH0qHilV5YbokMfsQ4RSTF+Rdyhvn6hmnxQZ8DBI4LFD5
	 eWWa+yFfimH6N8q+RnNLA6WiIjBY43TWFwdTv5sWuYDQxMqB5mix3BO0jJCFqqXXrVfH3
	 wXvL/wG1MRj25wFFwDUIo9SGy0DuCtdiniHS0USuh3C+2jUdedw7qEjqiBzHCTi2/N3/N
	 VELY0L/2QYxkzpaBUJSHlYsyt6gUVD/eZM43Ri7e+P687zzxroLBKs/dF3VsxUJ8p1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qD3+y0Cc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1mmJ0rpu;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6E606A327;
	Mon,  2 Nov 2026 23:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C6E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qD3+y0Cc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1mmJ0rpu
Date: Mon, 02 Nov 2026 23:09:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793660992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icAtHuOIlqxpJbKeEtpLnDpY6r0X2mjeeXW/VZe8HYw=;
	b=qD3+y0CcO856KYLKpYBim+wmQS2AANsasRtMyCs3dlCT70YtB55FYyL4SEEXvd4VeGRe8t
	QRpHNmEJCTeh0znTO+4VLFm3ry6+svWwSpAkuITzRzKZSLE2zl/3jQcNdpsUJHJVw3PyPw
	29cn6wPQ+th5eZIxE7wMJK7C8Htpud1NOftI6c0p9jcCJyOis3zHNsxjRADYYTzAORbxh3
	DJzm4xOBQZw+aBiNyDrJb9gvn1mQQp9oe5Q30HVS507t/FTOwgfJhI18z6J01ZugmB4uGi
	/4F2hmthWB6vs5y2ayv3srj8d1zk2pH4gF/MNh9xSQtvrV8HdH6a787slgiubg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793660992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icAtHuOIlqxpJbKeEtpLnDpY6r0X2mjeeXW/VZe8HYw=;
	b=1mmJ0rpuTO4v8oKhgOLQlplzE/1HdnNMoDiUR+BuHyO0YRYQmewFusCibkc23/+nvzMj5Z
	eDx5YMzuki8mlqDQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Correct ABMC counter ID field width
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <3a5e99300f1309ae279beb058ef0438516b2bdcd.1793392128.git.babu.moger@amd.com>
References:
 <3a5e99300f1309ae279beb058ef0438516b2bdcd.1793392128.git.babu.moger@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179366099115.1009794.1244204318948745267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     84b4b620af7d24916add5d45104023bc5d804f53
Gitweb:        https://git.kernel.org/tip/84b4b620af7d24916add5d45104023bc5d8=
04f53
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 30 Oct 2026 15:28:47 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Nov 2026 15:02:17 -08:00

x86/resctrl: Correct ABMC counter ID field width

AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
MSR_IA32_L3_QOS_ABMC_CFG. The cntr_id field selects the counter the
configuration applies to. The number of counters a platform supports (the
number of possible values written into that field) is enumerated separately
via CPUID.

On platforms that enumerate more than 32 counters, the current 5-bit encoding
truncates the counter ID and misprograms ABMC.

The section "Assignable Bandwidth Monitoring (ABMC)" in the APM has been
updated to widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id from 5 bits to 12 bits.

The CPUID enumeration reports the maximum counter ID in a 16-bit field and may
therefore report more counters than a 12-bit MSR_IA32_L3_QOS_ABMC_CFG.cntr_id
can address.

Widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id to 12 bits to match the architecture.
Cap the enumerated counter count at BIT(12) so every counter ID used by
resctrl can be written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id without truncation.

  [ bp: Massage and simplify commit message. ]

Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for AB=
MC assignment")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/3a5e99300f1309ae279beb058ef0438516b2bdcd.17933=
92128.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index e3cfa0c..ffd74a6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -214,8 +214,8 @@ union l3_qos_abmc_cfg {
 			      bw_src   :12,
 			      reserved1: 3,
 			      is_clos  : 1,
-			      cntr_id  : 5,
-			      reserved : 9,
+			      cntr_id  :12,
+			      reserved : 2,
 			      cntr_en  : 1,
 			      cfg_en   : 1;
 	} split;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 3838e0a..5d0d3b1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -470,7 +470,8 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
 		r->mon.mbm_cntr_assignable =3D true;
 		r->mon.mbm_cntr_configurable =3D true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
-		r->mon.num_mbm_cntrs =3D (ebx & GENMASK(15, 0)) + 1;
+		/* cntr_id is 12 bits and can only encode 4096 counters. */
+		r->mon.num_mbm_cntrs =3D min((ebx & GENMASK(15, 0)) + 1, BIT(12));
 		hw_res->mbm_cntr_assign_enabled =3D true;
 	}
=20
