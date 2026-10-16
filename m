Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF0447237;
	Fri, 16 Oct 2026 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191848; cv=none; b=It5Dh/PxY6y0U4D6vlrzeCEIQC4jFkHMKZFuK62dxA+FEg/37/jTAB8o5UeK303vwVRI2gIBXyjajiY/fdvVor/Df3a2s2NKLtN3ChZ6Hv5e7aXhhoQ52gGUvtqDziAQ4m14YCdDKSExb/JTGKv6RlnHQoKcDU0lQmpx/h0pTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191848; c=relaxed/simple;
	bh=4hzHIB0Y5JPlhprW+J1idLrj1nO22R2E8VcKkQJMrDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OiX26FuKaTqMQYEuYDf6LigNWh1B3uWzT0vAXa2bTiwxxxZwxH1QyY6luNScrgQwUOfnnLcsit/yiglLr8f5Q0RysZI1K7BpFP6+ixIQ59Gn0Xk1uCwihZ06DMjqRlS336umXHwQ/rBWeCKGzqjWnmq60h1vAhuZ6evsjbbBE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UJJyq1RO; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UJJyq1RO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792191846; x=1823727846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N+HMwtYomXTCU6APfdeFwp0AAr9WthCoGnVUMU/qw5o=;
  b=UJJyq1ROJz09KPFHrW0RQQauGEK+FvBzv35nWYS9VCwagv/rvvR5C+rG
   i/Fj26g20Qw2lxaavHItzh4LTDw2QMTPouV/Xd7cW3/kFw0Xc4h3KMaJK
   CudiE7w0QoGrqo3Pp38xjNtWihduySQGPQGD8kUWI8Sf6IEm23kJQsKkH
   jgWJ6xT87RaITQJ5l1e6vzZj3mTsZZTDRhHDOZ9qMSk0M7xMm2SBVraTB
   7gqCBmDx6r5xHCzmu2gTmeCAPzbVSLGvWDdibPh2ixvLHuNK2fxyIplkl
   dJrLx/wDqmYGmYK5Gr4SnuCy0mkZM3KWt0+EcTxEK2Prus4/HVDrt9Sri
   A==;
X-CSE-ConnectionGUID: F+PGbVPKT32QkFZLKUD5yA==
X-CSE-MsgGUID: KLTRFuNBQQW9sgbw8K6hGA==
X-IronPort-AV: E=Sophos;i="6.27,162,1787011200"; 
   d="scan'208";a="31289766"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 23:04:05 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:26478]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id 7051b923-aa5f-4e2a-8f20-94827baa4d21; Fri, 16 Oct 2026 23:04:05 +0000 (UTC)
X-Farcaster-Flow-ID: 7051b923-aa5f-4e2a-8f20-94827baa4d21
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 16 Oct 2026 23:04:04 +0000
Received: from dev-dsk-aarnahmd-2a-95203392.us-west-2.amazon.com
 (172.19.38.251) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Fri, 16 Oct 2026
 23:04:04 +0000
From: Aaron Ahmed <aarnahmd@amazon.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Gavin Inglis
	<giinglis@amazon.com>
Subject: [PATCH] ftrace: Initialize modname and offset in print_rec()
Date: Fri, 16 Oct 2026 23:04:03 +0000
Message-ID: <20261016230403.4916-1-aarnahmd@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

print_rec() leaves 'modname' and 'offset' uninitialized and
kallsyms_lookup() only sets them on success. When the lookup fails like
when a module is being loaded or unloaded, 'modname' holds a garbage
value, passes the 'if (modname)' check, and is dereferenced by
seq_printf().

  Oops: general protection fault
  RIP: 0010:string+0x48/0xe0
  Call Trace:
   vsnprintf+0x1f5/0x650
   seq_printf+0x8e/0xb0
   print_rec+0x6c/0xc0
   t_show+0x4c/0x440
   seq_read_iter+0x119/0x480

This can be triggered by reading available_filter_functions while a
module is being loaded or unloaded.

Initialize both variables so a failed lookup skips the module name.

Fixes: b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
Cc: stable@vger.kernel.org
Tested-by: Gavin Inglis <giinglis@amazon.com>
Signed-off-by: Aaron Ahmed <aarnahmd@amazon.com>
---
Reproducer: https://gist.github.com/ginglis13/dd3f64426767cd48df55dfe5d26c2299

 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 673a54fdf3929..164fbc07bce05 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4426,9 +4426,9 @@ subsys_initcall(ftrace_check_for_weak_functions);
 
 static int print_rec(struct seq_file *m, unsigned long ip)
 {
-	unsigned long offset;
+	unsigned long offset = 0;
 	char str[KSYM_SYMBOL_LEN];
-	char *modname;
+	char *modname = NULL;
 	const char *ret;
 
 	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);

base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
-- 
2.47.3

