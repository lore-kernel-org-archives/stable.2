Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201261;
	b=JXHSmpNHop452cc42ytEktkoCHzuo1R3l0vly7usrxwsufhT9SGrU+SpJKhXDpSH6Dwp
	 KziwmQghwZ9tTJdujW/y7f0vTQPFAUdXhI/NYlGw9mbn5AEKPdiOi9mFmi1MUifF1lvYz
	 AMs5LIXqy0tSEF6cy/DuZTD4Y9UchOL5GFGpiOx0NzndWG9lN4yMGfsuba8P92gMnQg8G
	 Ws6HvPoClB54wDasZ+/W4sZbGA801STsi+I8Qeedo5Eq9rZnqwQgIFGbhOJIx5mZ1EmWx
	 xsiYN93Np8nGnAAG1A+kKZc62a/ekzJ6/CVOUXMI9YLGl8hqMcorJ34qUblXCUEY93g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mviMX423LKxXWIxiYJZwCl9XcD+q+XXpipqa/Ow8DSE=;
	b=fROkWLq0fh3vVY1M6i+iJMdzreeFJjjy8ko93rlbY+Y627nsesdJlHh08yw4pREBkwNe
	 swKesI3/y8w3mrQMAfTwZz8JxXwE/nsDJDgIcJRMGa5590ZNSD236UMhiUq6F74w/KEOT
	 FNk08X8EsVockiMDc0JdCEEHedNzbJuq4tKGnOIFZNZktxEJr3nSYqicKBvSuwlpXYxsn
	 HaZgJLB/DWaw3EDeyuPxiojiUyx6vd8wmXjzeysusiVAnA9nyTRKs5XOUbbgS1gACwfkt
	 IAMEOxsffRq6qzrTjAoZncrORUTceZISLRMtzWfNcnMYsuW/6gmJEORy4AZ9zhJ1LIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pHyTfUEV;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC560A3828
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29DC560A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pHyTfUEV
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-384c78aa0dbso1574804eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201253; x=1795806053; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mviMX423LKxXWIxiYJZwCl9XcD+q+XXpipqa/Ow8DSE=;
        b=pHyTfUEVfORxIw3AaIEr3qtXYXd7UBO4Rd9gAvcyKry0tZV1eZlJNE4Yi/ve+TTbFH
         80iAQSovUW5fcyO/DXTVpLbW3RDQZ8cxSoW4NJdiOEslOjDfqsu2taaf7uxcfJ5afly4
         DtBrPIN7WqRa1E7cbK1rTG7ZCM6ErTnCHsjU2I/fVYcV11JYbBQ7Vjrij7nl6D/n1iz0
         4Zt/m2UO58MNHYYrnpH+DIADjkVJ2lxZQQ1atSq87pWSJwTEu9INdrXVGVNCIHhehDIr
         zlKRMMLdWvpvWwsc0x0wSfrJArMUKveQHDwKsEDiEGx3I3PJhQurqe2RXPaTXWAUV/s+
         DpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201253; x=1795806053;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mviMX423LKxXWIxiYJZwCl9XcD+q+XXpipqa/Ow8DSE=;
        b=WL3XsCZP8n5FuaPecVZloSLlECC28WBMKYzXlFZdMbIfEzpP+L31QtpF9h/ZGGtmuS
         OaDAoBxg7kk+bVNYAlHL3jepHaisw/RgaKGfIEXzqMGqLvSUHdHHo35VWixlj55m6jLK
         XpBbcKH4bfbklnUOYUJp9TxDUTt42jkjW3ErTUO2hSAC1DBb+1d+0bojcWBryXBGK2Ol
         AuLQRis0d+RJOmXtQZNlW9i62mpZBmEh24u2bM+omS+BTsGTPQqTM5Jxeq3Ohy4GyWwr
         sM4NaAJk93gRNV0l6XuVsnHAsZYyVjDsQIL0kSCq1/2wpJAg4/A7zbaZHrRKjVeSRSkm
         E3nw==
X-Forwarded-Encrypted: i=1; AL+hErHPwDIdNFPl53PEFIFRBEA6Cd7J3zpEHX/+ufPm5h/6y2+uxjUDJRhEZtSi2kx5ZCV7r5ud9qY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gOSMhgN17dYeYfVq4VZorGLYvuro/qii0HVErquvuMwf7mUV9
	RW8GOUFYy/d7iN8Z33xaGqTI65rS6diF+MbCkKOUtnNM1QWWW/QQ9FJsdgqtMxciTUpmDe9s/pb
	xX43qKKxOPA==
X-Received: from dybmx4.prod.google.com ([2002:a05:7300:d404:b0:368:2c6d:de10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6408:b0:383:1bfc:f1c0
 with SMTP id 5a478bee46e88-38570f27a56mr3664460eec.32.1795201252952; Fri, 20
 Nov 2026 11:00:52 -0800 (PST)
Date: Fri, 20 Nov 2026 11:00:30 -0800
In-Reply-To: <20261120190031.1587531-1-irogers@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120190031.1587531-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120190031.1587531-3-irogers@google.com>
Subject: [PATCH v2 2/3] scsi: mpi3mr: Initialize start_time on all paths in mpi3mr_bring_ioc_ready()
From: Ian Rogers <irogers@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>
Cc: Laurence Oberman <loberman@redhat.com>, mpi3mr-linuxdrv.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In mpi3mr_bring_ioc_ready(), start_time is only assigned after writing
MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC when retry == 0, which sits after three
earlier 'goto out_failed' error paths (soft reset failure, failure to
reach MRIOC_STATE_RESET, and admin queue setup failure).

If any of those pre-enable steps fails on the first attempt, out_failed
computes elapsed_time_sec from an uninitialized start_time. Furthermore,
if out_failed decides to retry (retry == 1) and the second attempt
reaches the ready-polling loop, 'if (retry == 0)' skips assigning
start_time, leaving the ready-polling loop comparing against
uninitialized stack memory as well.

Initialize start_time = jiffies at function entry to cover pre-enable
failure exits, and replace 'if (retry == 0)' with a boolean
enable_started check so start_time is reset the first time IOC enable is
written without pre-enable waits draining ready_timeout.

Found via Clang -Wconditional-uninitialized on an x86_64 allyesconfig
build with AI coding assistant help. Verified with a standalone C
reproducer under ASan/UBSan and by building
drivers/scsi/mpi3mr/mpi3mr_fw.o with LLVM=1 W=1 (-Werror) and
-Wconditional-uninitialized; not runtime-tested on MPI3 hardware.

Fixes: 9634bb07083c ("scsi: mpi3mr: Enhance the Enable Controller retry logic")
Cc: stable@vger.kernel.org
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 416f27c37535..1aeae8a55b1b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1582,8 +1582,9 @@ static int mpi3mr_bring_ioc_ready(struct mpi3mr_ioc *mrioc)
 	int retval = 0;
 	enum mpi3mr_iocstate ioc_state;
 	u64 base_info;
+	bool enable_started = false;
 	u8 retry = 0;
-	u64 start_time, elapsed_time_sec;
+	u64 start_time = jiffies, elapsed_time_sec;
 
 retry_bring_ioc_ready:
 
@@ -1690,8 +1691,10 @@ retry_bring_ioc_ready:
 	ioc_config |= MPI3_SYSIF_IOC_CONFIG_ENABLE_IOC;
 	writel(ioc_config, &mrioc->sysif_regs->ioc_configuration);
 
-	if (retry == 0)
+	if (!enable_started) {
 		start_time = jiffies;
+		enable_started = true;
+	}
 
 	timeout = mrioc->ready_timeout * 10;
 	do {
-- 
2.56.1.750.gf70dc682cf-goog

