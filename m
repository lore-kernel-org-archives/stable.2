Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B13CF1FC
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567260; cv=none; b=a8J1xTXnqmeFrj55L6Z9sSk9dtqUYxd3E4C0W6yhctCYJyEE2UD+CaC6FY//aAzISW8+JVmS7rkoSiCPtCnjGOR4qFgTwqbjXY3Bnzk8pG1I0mIwW2W2WNaw9tPlWOR7TSLFhzfAFLKszQnvpqLP32UwTZ9WhXITHGnJPpjfM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567260; c=relaxed/simple;
	bh=4QzvFpJrMIBOFL1LClfdnGhTbQVQVWWI+SlIcvg95ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1WSVfLQgKNiTqyihCTgBv4n0aq5CnvuowUN80bbMykBzOFvEcvElB85+xf+P/7Y6fY1QrfHQL/WJe7K3/5VS6f0MCgrCBeFkOhaQ3QirlKA2H9heucQ0otADYFRA41lVtwX7xcZFrbgWaqPqKyrRcVlaTCzX7V/THMz3AXD0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=Yua6chXR; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="Yua6chXR"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e50170ba7so506240185a.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791567256; x=1792172056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwD4Whw0BsO3CL4xljsuE9wjdul1Y3ABr5wVzug+v1w=;
        b=Yua6chXRFeG43IGQ6rz0wJwiS+ZsJikqXnfwVGzxSfvLPCe7rUkCI7RUJnau9bjhl8
         kgeRz43OUXNSSQphvMOsc8C6fqI+gmaXG9JUniliBBItKjwMSTvubTLoM7MIkcRIaaaf
         6HW/HdLJrQdmBquzkQdNLkRhr+jhoDRtfAKfLTzgKSqPC949wEXIZUNG5NqPtoKpyckc
         L14LbKpMBzpa+m3LB0OdqchuYSmxVDqipcyb94C3+otykzdii3LnJJds81LlEgYoTP/N
         SBjkb0HMcv+71o39WTMUPAvNVkdsm2FewHCkMvJiT4gJW614hOQwcVbBrqFbFpUQQClP
         pD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791567256; x=1792172056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwD4Whw0BsO3CL4xljsuE9wjdul1Y3ABr5wVzug+v1w=;
        b=OvTXuDy5yTuPfla7Xo3K98VZcZAbAX03okUkvnwAgerevQkuY2zMDj5Rb6tDMi5E6K
         YoaXPvpoRM0/xKYW5eYq3UgjZwY8kpAGJtDfrjesrkwi3Z5Grtsd9nyQv080SyPa7qrX
         bOyrA67pj0yOu6UJsWuESkZhYX7rjyDLMt6BPDa/IfBmcOeAgdmJv2Ri9wqUlopkaMJG
         2L2w8td3NPHDDcqqYqfhfjmTyf1OV/J8WMsusFwutfk0KTyTxUJzvklOsGktBIFQUBoq
         zQIC7Y25NfRS+B96NwHkPoEbgtZ1eT9cGd9BuZsJf9aTiuYgVno6Y/CGc49yCNgpv+jb
         ph3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwCFKlefyfyeZvFCeNut1dHwDk/Zo+uVThI9/WwWaSpSx/5YV6KTQ3N7g89jQVQKuZc3PcXMTk=@vger.kernel.org
X-Gm-Message-State: AFuF++lydlBCjalGWovL/+bRabficy2C/Wbog0exlyDycn9kC1hb7Q2b
	QMd7CS0CUEofBol186yNNDmdEE+MgChQbNCv6Gq6sRhzBIe1fN2nkwWT5bfuXNPkCA==
X-Gm-Gg: AYBFou0HESE83wDaLAm8OLBdNPMTj3hJDgeOTIR2oKWTJIFbHCqDyh7n8Nkoaj/7lgz
	4bglklsK8tvhW4Pdyiir9qKvbvklPTbGKApYVjJ8V+K59L4iSVDU2lq2cNziGdsVcdi6Dzlb2AB
	uQDLCscPWkB3w+LlVCfLIGDbcrd9r1jn25bKDw/7lb/m/iQEZjuegjm4HldynI/PojIzB2Dydor
	O8LlE9MFmC7kBQsuDrRDgQyN++NtBUg3rnf8WYdBBzUp0Y/LGHPSQV6XWVlVfyL5S5m5U1bkbhD
	G20aTamHE+w4Ls6Rjv74knO8UTlgPJqRIe9m5CnTuvMlK8LUdOS7bhPHZXrd72fz0z9UrMYWOEx
	Y8T2/acVRSyae+cmi9R40BZun3mCY2JcGhkyfNx4ITH0KMx2LAJrdLP4WbJlgK9fZp6PzpYH4i5
	r6pEdtTauSvL6OXeRlMYX0JdZNUTGTXCV5IhEsfFg3b2pWEb4g0KND5cGY8jur4PIDZhJd0NgsT
	ym9qRyXbGJe3wJZ4rDqcIWlOVnmzCdk
X-Received: by 2002:a05:620a:44c8:b0:93a:14c:32ad with SMTP id af79cd13be357-93ebcd339d8mr378214385a.0.1791567255058;
        Fri, 09 Oct 2026 10:34:15 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9720f19sm238494785a.4.2026.10.09.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:34:14 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>,
	Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: return -ENOTTY for unknown ioctls on the control device
Date: Fri,  9 Oct 2026 13:33:59 -0400
Message-ID: <20261009173359.3486877-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5ab2b180884c ("btrfs: factor out validation of
btrfs_ioctl_vol_args::name") made btrfs_control_ioctl() store the result
of btrfs_check_ioctl_vol_args_path() in ret before it looks at the
command.

However, ret is initialized to -ENOTTY and the switch has no default
case, so this initial value was what an unknown command returned. As of
now, every unknown ioctl on /dev/btrfs-control returns 0. A tool that
tries a control ioctl which the running kernel does not have is told
that the ioctl succeeded.

The issue can be reproduced with a simple C program, run as root:

    #include <fcntl.h>
    #include <stdio.h>
    #include <sys/ioctl.h>

    int main(void)
    {
            static char buf[4096];
            int fd = open("/dev/btrfs-control", O_RDWR);

            if (ioctl(fd, TCGETS, buf) < 0)
                    perror("ioctl");
            else
                    printf("ioctl succeeded\n");
            return 0;
    }

Before commit 5ab2b180884c ("btrfs: factor out validation of
btrfs_ioctl_vol_args::name"), the result is:

    ioctl: Inappropriate ioctl for device

After that commit, the result is:

    ioctl succeeded

This patch will add a default case that returns -ENOTTY.

Fixes: 5ab2b180884c ("btrfs: factor out validation of btrfs_ioctl_vol_args::name")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/btrfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 823a58bd2685..acb704b20c2b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2291,6 +2291,9 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
 		ret = btrfs_ioctl_get_supported_features((void __user*)arg);
 		break;
+	default:
+		ret = -ENOTTY;
+		break;
 	}
 
 out:
-- 
2.53.0

