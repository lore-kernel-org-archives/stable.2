Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685430;
	b=sPYwOveeirP+taPXvWJTPlIc9NULmeZFZsAr0YAYQ8v0FwZgj2A3j9ZGirzRg5gX1PWb
	 k0eD0XBtY1Arel2/MGnbW57qIu4D49/5euPrtpUxIGr6RfSzW/jaflkLV3dX3JSjF1h0Z
	 tI/mKckptOl7b2/l+gtfBI5dZ6Ni+DzOBguhQxtWWeAJX6ktkl5dAoNOlvscqy0QbBnVf
	 CrM12RRPm9k8mkDgYB73sTlnZPAooZOmtdw4Qs7x2Gx0/jYSjOX7XrGMAnEhPVT2E7mOR
	 lhGzJuR46yzKRg2tpVjbl/KmJsW3aNq2SdjQv+ZNII+2/8qioW5dp7HEYJNVBPft2Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685430;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=8vAUA+tXKBngYUH5vQIMYzDTXBGREk2oTfc9mdv5kno=;
	b=oYRtoF/qYIRe03uTRwUZoaOLuZpZmhNF4WTCi8MHd7Ry9p3q2hyAbTWaIQE8AmLaClBr
	 /tak7K6N5OSLQFZHnVgvct3Jmu186sErAqM40TPyM4Q+wtQRiKBJdu3G2zukf4OL8eBOy
	 ffVvWQDXEXLK8OIqbh49WCQmanEZhCszhHGhpW8GTA2cnHCuT/niWLjwwduEPp2CB16Ox
	 JVoZL7p77DoAyOeo4XG3dnpGO92A2+e9BzEcUAzFiJgIYnuV/LMckxK9gZD56sJ67VYw6
	 j6o4nhO6m9CNC+Wkk5/f2CXSn5VJgXrU/u26bOHAFSPQZSn03tazlnZMaQ0s8ysjMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wWu+nLOB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RO8jVIjy;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10175606A329;
	Tue,  3 Nov 2026 05:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10175606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wWu+nLOB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RO8jVIjy
Date: Tue, 03 Nov 2026 05:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793685426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vAUA+tXKBngYUH5vQIMYzDTXBGREk2oTfc9mdv5kno=;
	b=wWu+nLOBUsEz+hmUdOW5M49BRTAx7Bgpvv8WNx0UOOs0BkV5iX7EeqC5rzgI897n62jlmU
	RH//atjZ5yFRMJHWNzlHPSEq5tcAmPcipcsbdD1wQrf6EDR8rC0foQRllzVc2SlRdz4inB
	ZT+y+AIA+4roeEE3l3TsaHB6JoUhmO/GgtiVRVHCDqkKIEH6h4jtPH+RbapNPVZl8OzK+N
	i8wZ4DmnqS3v7IDyb6E6PayT5T2XQo7HCvCawWV0DHgmWGdUeQJnjLn5FRlSsJcjp/cJ2T
	Trt3JT7mnYLWvaLx56A4/AaR3QFr0MrkXlMSoFfY0y/HJmp4Hnz6QQhuEM1O4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793685426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vAUA+tXKBngYUH5vQIMYzDTXBGREk2oTfc9mdv5kno=;
	b=RO8jVIjyn5XyhaNrT3pNkuOtOXgDs2DZQF0ku0kTUSLoejLh+dbFQfK/66bG64SlFecXkt
	YDl574pczzIS0OBg==
From: "tip-bot2 for Naman Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/init: Initialize wall clock in get_rtc_noop()
Cc: Naman Jain <namjain@linux.microsoft.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 Roman Kisel <vdso@mailbox.org>, Hardik Garg <hargar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260831082528.1623843-1-namjain@linux.microsoft.com>
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179368542482.1009794.8515933785273652302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7d5af1f256fdecff6a7986bbc9146b69cb355bb5
Gitweb:        https://git.kernel.org/tip/7d5af1f256fdecff6a7986bbc9146b69cb3=
55bb5
Author:        Naman Jain <namjain@linux.microsoft.com>
AuthorDate:    Mon, 31 Aug 2026 08:25:28=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Nov 2026 21:38:37 -08:00

x86/init: Initialize wall clock in get_rtc_noop()

get_rtc_noop() is used when an RTC is unavailable, but leaves its output
argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
timekeeping_init() may therefore receive a nonzero invalid persistent
clock value and warn:

  "Persistent clock returned invalid value"

Initialize the output to zero, the documented representation of an
unsupported persistent clock.

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at=
 boot time")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260831082528.1623843-1-namjain@linux.microso=
ft.com
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 252c582..3b9b418 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -37,7 +37,7 @@ static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
 int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-void get_rtc_noop(struct timespec64 *now) { }
+void get_rtc_noop(struct timespec64 *now) { *now =3D (struct timespec64){0};=
 }
=20
 static __initconst const struct of_device_id of_cmos_match[] =3D {
 	{ .compatible =3D "motorola,mc146818" },
