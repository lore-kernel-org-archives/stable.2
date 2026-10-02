Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12037FF60
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974068; cv=none; b=Lq9PqIKP5h68xv/LL5jzSuEXJN1mkgqBB9xS4KMe1R41ImMahnGDCjxpeuKArN0zVRr7QFQLe/hgJ+nddAKV49xsGuz18ki7GoD1v3KytCZviedy5Y4n+xpuIpOhKkcnZPPA9eBhYNkoWc37SwW8s/QxwiChuC1uSfTh7QAO9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974068; c=relaxed/simple;
	bh=5reFR0cPRsol5tHJU+7BR61yhNOqUbb5L8/I1mTHXyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoqrblQwMIFcABUv6NvAsHwZ4c9Q1vGHfDaK+9j1Fo2AGf3wowX+qpRmjqMMenu1mD5OlKrEI7cDD+9ik63TTR3q3+RMaS6Mn39PVRtkCpt43GIkNbVcwFNbgduKmeBfIspdkmb8G/B5AQwHL7zEXWewO4uWMOEawPtADG8geuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Ucb1GLzP; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Ucb1GLzP"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14fe2605d85so1402c88.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790974061; x=1791578861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vg8t3uO9PE10Qg5jyexboq4szdm04bUUgkPs/yF76XA=;
        b=Ucb1GLzPG0rX878x+pxr7oRVWPNoVLvRwrLUkOONBUZlLeQ87XFZGyiiSlq3g8tJH3
         mNp+W/JX5BWPNNYq7GelriG0rPkvSs248CGAX8njZZdfbtMPH18BeV01iEIW//ZJdczP
         3+H4blzwNsdpVWdCSEOl5guiR2jcv164X0g7LbB0M8MODtCCnu9khOl5NzsB6E1zsZIl
         KGJ0RouQUlhXoZIURijGpK/iNFUwxZ1q08Hi8ktmcaaJ/QcQwd5vcLK/HTuyJSTli+83
         4XATkOnS9H6xXeRRlMLjRHJ1ovO87PaW0XHrzUnP5XhTOVrlvHWxj7OInS4auoLfHw/+
         raYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974061; x=1791578861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vg8t3uO9PE10Qg5jyexboq4szdm04bUUgkPs/yF76XA=;
        b=ez2955aXy6Vpr2ino+XQlbDAR+GdTdiIbWj6HDBYst7zWVNcqvoM7VEASYuZHPHD8r
         KFnyHizfIrpS8fkdb40Dw0tkoCC/Mg1wVzHpBXucdO6qnlwHlan96VZVTkYH3q7g+Rkf
         cDy7BKpQsoc4JAAt3Hkh66/qLt1grx9kloDwwXsrwuRxHvThRZhw4vlkNPG5CGdBhFHr
         IRvqzXORz8455TfEUx0d94pHSR1rdB1at4a2b7JKxns8y0+q/uh4bo7PjZ1W8yUN/od2
         LdzqHYt5L5nN3ywgLMXV1ojtZ88eOqmLy7sHY4MJgNlUso9+lP6IJL50KSQKbvLvxJEs
         KI1g==
X-Gm-Message-State: AFuF++lcDHcqsrw3On8ogq9mKG27dmKoJUGq1pCZPKQZXAKh20iLbGtI
	fAhd8P05cwb8mYqnwgIF+38f34hvJqkz8EOkVS5TC2/FtIOFDDJ6Dwaj0YmrAIHmv5UfJ3hq/Op
	EDgdt8UfLnw==
X-Gm-Gg: AYBFou2It2WnThaItbijIUp/F5Yxnr33q/3gjpNcj0hLAh0SWHTUa8WTMM9u7sipbXD
	IRR+1z9zpIstoVGa5Ced7eNqmU9W9EiIgZ9yKUW7fya7+sQh87MIhyELuGvV8eaDlfejyt/68+j
	nhdcBuDkN1fopNbTPa3fjesQBTupZyY+8u8YYWSSTTEditXaF02+qGXPRY5LnlDlCPVRlghJLV3
	R3YTQGSqvJavoTPIqtAbN+m2XWKW4mNBisQ/ZB3E97tgIQAwJ7VbxJxXOjHw4APrjECIFVzMU8Q
	s5N/lGcw/9Y9trHtuLMzYJ9Ax1+DL/tKlkjaFGp94P3d/eLCAbh07gRGr/5D5rwmndxiuVpeTJ8
	fLOVCT3324TToNriT82CSFj9eCQmS3lAIrVectu4bkLy17UqKd/Dy+l+3vkoJV1vlVcZiqlN9FV
	MF/eA2vWDetx8inH+3evs2s5ZS1uEems96x9UXtRw2AID0P9bkU9+lap2Qvg3Ee2Ojhpmn5bpcB
	IGwiV7QSvcQe0Nvzv7ilxHrldG8IW3t+x4XwSzsRSEA0cc9vLGtpckryIQP0IyjfzutarE=
X-Received: by 2002:a05:7023:b08:b0:14b:1e78:a19f with SMTP id a92af1059eb24-14f58fd2d99mr5644034c88.6.1790974060908;
        Fri, 02 Oct 2026 13:47:40 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a1e3:ffe2:b35a:69a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151f7bd2884sm79698c88.0.2026.10.02.13.47.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:47:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 6.1.y] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
Date: Fri,  2 Oct 2026 16:47:36 -0400
Message-ID: <20261002204737.26561-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0 ]

A number of Zen4 client SoCs advertise the ability to use virtualized
VMLOAD/VMSAVE, but using these instructions is reported to be a cause
of a random host reboot.

These instructions aren't intended to be advertised on Zen4 client
so clear the capability.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219009
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and x86 amd maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-53114. It clears virtualized VMLOAD/VMSAVE on
affected Zen 4 client models.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The code change is identical to upstream.

Could you please queue it for 6.1.y?

CVE: CVE-2024-53114
Upstream: a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 arch/x86/kernel/cpu/amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a61606a614bd71..8d9c067992e5f5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1161,6 +1161,17 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	/*
+	 * These Zen4 SoCs advertise support for virtualized VMLOAD/VMSAVE
+	 * in some BIOS versions but they can lead to random host reboots.
+	 */
+	switch (c->x86_model) {
+	case 0x18 ... 0x1f:
+	case 0x60 ... 0x7f:
+		clear_cpu_cap(c, X86_FEATURE_V_VMSAVE_VMLOAD);
+		break;
+	}
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
-- 
2.39.5

