Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B24207A32
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957849; cv=none; b=dJoOv0XoJcwi/Bds18ENwCOoGue6aAqlGkBMGWt/KO+iwFHeUXVmv66j+sT4xfjzFQZv8D1b9ImNJlMjHoqk5ilIGvb9yaFziUSsVXMd9r6dUvQABvxMHa4zUHwvco81CWXfPuCTsaAFHbJyoboebLyW5b+lbXf14fHH0K030hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957849; c=relaxed/simple;
	bh=1oX97FwvIa1USE8+LEEknrDmA1lZQy1Y1zDPzsBh7NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNqWDFzakY67La3OnVvys/ASuL1xKpkIrAZP0qQj1GWQhuYC79j9UE2AseIYojKmYd0XEjrbS17lCpV/NC7eq0BsBWajVPHa5tWdCfRKNl3ud5jfvahXETgDxtyAHV3EaCv87JtQPf5hklOr5fwIFDzqQNvYr+wbrWLdnhBf3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NDXFkWY/; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NDXFkWY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788957847; x=1820493847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMtsOP7fIZ0e8+NrOppx9gQ9PBPii0AkkohnY17UPSs=;
  b=NDXFkWY/ydl879R1enhVCP7jMK40ACFQInpOe+jV+VyhpcbDBx1cD7Z/
   te7IPUOCiF7zqwvZOkfPLblt5ScbN0mnwCbfUHJEY+1wV7RgHH1kG+R/m
   GFSfR10GZyP4kM3V8AkoRAHcer9NkObfewj3pP8TTHZC6jDojnvJyQf19
   XQSiMDKAYD3GfdlQk1MvrqIEEdznxybggkucj3eI0/i4cn520vGNTKYPT
   1tr9GIHuYhSqL56acs3NEEjrlIfNwWUogWH2N9Ex8BEV9/gs/IrYeDnpm
   OYip+fPS/39hG4WOJzbEcEjFjfyXogB6HXKl5Lydrx0YDphs53JZdRbFE
   A==;
X-CSE-ConnectionGUID: jeHKoZEHT5CwfJitKMKBbQ==
X-CSE-MsgGUID: KQcUpawqTgmTBNs/L20uSQ==
X-IronPort-AV: E=Sophos;i="6.25,270,1779148800"; 
   d="scan'208";a="28215581"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 12:44:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:15459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id a255356d-eadf-4ab1-b49a-ad15280c2723; Wed, 9 Sep 2026 12:44:04 +0000 (UTC)
X-Farcaster-Flow-ID: a255356d-eadf-4ab1-b49a-ad15280c2723
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 9 Sep 2026 12:44:03 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 9 Sep 2026 12:44:02 +0000
From: Alexander Graf <graf@amazon.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Willy Tarreau <w@1wt.eu>, Yuxiao Wang <yuxiao.wang@certik.com>,
	"aws-nitro-enclaves-devel @ amazon . com"
	<aws-nitro-enclaves-devel@amazon.com>, "security @ kernel . org"
	<security@kernel.org>, "zhaofeng . chen @ certik . com"
	<zhaofeng.chen@certik.com>, <stable@vger.kernel.org>
Subject: [PATCH] nitro_enclaves: fix use-after-free on SLOT_ALLOC failure
Date: Wed, 9 Sep 2026 12:44:00 +0000
Message-ID: <20260909124400.27857-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2026090816-jogger-licking-7f67@gregkh>
References: <2026090816-jogger-licking-7f67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Yuxiao Wang <yuxiao.wang@certik.com>

When ne_create_vm_ioctl() fails the SLOT_ALLOC request after
anon_inode_getfile() has succeeded, the error path calls
fput(enclave_file) and then frees ne_enclave.

In normal userspace context, fput() defers the final __fput() via
task_work. ne_enclave_release() therefore runs after ne_enclave has
already been freed and dereferences ne_enclave->slot_uid, causing a
use-after-free: KASAN: slab-use-after-free in ne_enclave_release.

The enclave has no slot allocated and is not yet linked into the
enclaves list on this error path, so ne_enclave_release() is expected
to return early when slot_uid is zero. However, reading slot_uid
already accesses the freed object.

Clear enclave_file->private_data before fput() on the error path.
ne_enclave_release() then returns immediately when private_data is
NULL, leaving the ioctl error path as the sole owner of ne_enclave.
This is safe because the file has not been fd_install()'d yet.

Tested on an AWS EC2 m5.2xlarge with CONFIG_KASAN=y. Without the
patch, the reproducer triggers a KASAN slab-use-after-free on every
SLOT_ALLOC failure. With the patch, no KASAN report is produced and
the SLOT_ALLOC error is still returned. Normal enclave creation and
teardown are unaffected.

Fixes: 9c8eb50fe9e2 ("nitro_enclaves: Add logic for terminating an enclave")
Cc: stable@vger.kernel.org
Co-developed-by: Zhaofeng Chen <zhaofeng.chen@certik.com>
Signed-off-by: Zhaofeng Chen <zhaofeng.chen@certik.com>
Signed-off-by: Yuxiao Wang <yuxiao.wang@certik.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index c91300a..0d7bdad 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1706,6 +1706,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 	return enclave_fd;
 
 put_file:
+	enclave_file->private_data = NULL;
 	fput(enclave_file);
 put_fd:
 	put_unused_fd(enclave_fd);
-- 
2.34.1

