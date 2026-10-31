Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793485716;
	b=efioC9UEH0Ao++cXQxeBJS4QLigQUymIU4QWQ3NAlfHF8rbzbDbjBHvB/QDbYmBxA2T5
	 9Ddqw2JOhlwXO2IvaE9+JoehpBDffCSeOtLzp6lERXRgkKoYyCUG6Ma6kvyftvEQoM99P
	 AtQU5DywPAlZAg7BxRVVE7RZij2jdkzmyFI1KWUGLJH2DXiY/L6wL19UbGDDZbsoPtDKk
	 chkiKYWpklJuIEH11OnX7pVlxMsBxSDmr85QQ0Bi67n0QyDW4rUS8ye8rOh9IuQQVsm6S
	 Jt6Qw0H4+Khymxw2ElXCJRHKzHhRQSO6ZzLpquKD14PJxQvwUqn3FFeLsAjogMHd//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m0JnkbHJkuPfCHVuDrGb2+stBd0JEX0qG9o4dkUA+8w=;
	b=2v1HUvcY/QLuqmENFAfi0R9LTmqLTzBmvOCLc+zJw81QEyBEbTucLCIXv1LQISKbqxQc
	 HlZDoK/LQ12PTZLYb2VPdQqTfKAPtmRNlOF88BzYpe5nAx3uFYIVw80DUfEzlHhL013SQ
	 gwL4rIL1/5ULT9FFD/RvE53SBWkiqirBBfuQ/KBQlm7zLROBgmyIjvGYqpOBINMT0pYmv
	 vCxXLWnqdEuHnbi0jxUYBlq07FhESFKwvAViOwx7eSbycMWny3kTlwvElGeOwdM/6mM0a
	 IU5SjxRm+usrUWcygN26HJpW+guxe+RVHfXPeGK7Sh/H78x+5CoU1uTDClXmjbVCBXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgBwhI3y;
	arc=none smtp.remote-ip=74.125.229.134
Received: from mail-dl2-f6.google.com (mail-dl2-f6.google.com [74.125.229.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF5606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 22:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7CF5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgBwhI3y
Received: by mail-dl2-f6.google.com with SMTP id a92af1059eb24-1ae5089e28aso23152c88.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793485715; x=1794090515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0JnkbHJkuPfCHVuDrGb2+stBd0JEX0qG9o4dkUA+8w=;
        b=dgBwhI3yf26UwLuKeQmvpbcyMU2C7cg/wIucp8d0W3AG3ij8p908y0P0SnXHzdgBAf
         eDjsBGtjxZexsV9LTvsQNcgAApRVYuJSBOt70dJFXrbXMFZqIOPfv43Zf1X3q8RhkuLQ
         JzwPEExMLvjlDU8NlwAuUPLPFlxacleKM8j0ORixD+u+elvJsoaFqYr+nqiH+OroB8Qr
         WYl9YK4Iuf7nJthX3782Bm2aZi0Q34XRBMMXkJOVF00AdhVYzSEW52+Y8qEIIsLEXRz6
         yoRMLZ15xJZ/m7NHWQHvrVg0XZs4Fu8csJ4PvhxrOPRcwW9uLdb/mkJYAFo84BVK8omp
         Rtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793485715; x=1794090515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0JnkbHJkuPfCHVuDrGb2+stBd0JEX0qG9o4dkUA+8w=;
        b=0YCzyQUUaSgeteZAMMqwn7xPze8S5RGrykQoHX5AnRO8BIFqRtqpN6XiwRBCIni2t5
         L4+RI2JIaOT8ZcbBfX31EAacY6TciI6MgxW/Tu4QwD9A2Ixcs9Ii8xSSJxPPQnzdTut/
         4xotV5bOeQDWe6nRhlZBGDBT3F/8neyN6YnCAmX1jAQftw+I2P5ei+4aTeh+AzIxYiXH
         dzJxl8gK1UZkrkFizDYLbyxAa+B+jLuoJGq3izbceSq8ukqNl8GdD/xJjLhGoJzBDR5w
         wgTlf6bJ5Bp/UDNQG/MWyTUI8aQCWhlh8bOe/399BvYaasowTm+bHHrxpJjW9tdrwZH7
         FbbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/2qpeEfr+y9TKk9cLX7Ia75ZiO3Tix9BpzzGGwdFWeycjFOdTRMlbEdFOl6RSlIXR3u4cGGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2Ml5teiORw3E2KjPXXrjeXCoPwFDtT8/tOJLWLPwjYP5ZqRli
	0RiNWXSH/2GOhXAHAo+c3xG/vaQxSKOI3fcn53+VgAOR3/uvMVJCurJX
X-Gm-Gg: AYBFou3PRhvSvq0nDNa9zga3sbNB0IaD8p0pilgJ1yVgjtrMBNqCNJVkIDgAIPYd9Ju
	gVpMp/Y6ucr1ZFY83sUYE5k1+WNnkYiP/oGI8+hz6v1eOa8ZWpC+ckk0/We7PVLQYPhlqjU7hM+
	aa46M5NsrRqHhY2yd//r9LYP8PyrEss+EdQs2xyDmPzvruI2mYaOvxm6yY0CBOAlWFjC0+ljxQt
	PduAy7jg3TiQaMTJqgp4ALd6x3p8Yy5l6MfKftRE5Gyb9lMqL0Dxs7dhwdQqi5oqJ7Q0JgSayO3
	ou0eDQZtEoxtx3Ny8J7QNQbUV7r/gBh6DRyHMp9CStqeqg/oL6Qx7TXhm/pV3rghdkNDxDUB28T
	+SMmoUNf2EjK1lBMMDeRKTzmHYu0cPfluM8Xg4nlD75MCch0P1/ogYD4GQYo3xCDvKLDOccBUgw
	kJpieicTgoHTGDOKOKmMCS/DdGWFN20T6cy65BzSzIdKXuh5+YdgZNaED4128ZAqcxITUKCzZRs
	RrOluWxpzx+nZ8osSX4CdLMBtYCDkdTFfg5iW3DMGw+D0MpJu9l2p81V+B7qkurau4x4eisGxMd
	i1RrncGeU0TMdQPP/VGNBIaxUoHG1jG56yzd9wlMdT5qDEW/0sG32Ior
X-Received: by 2002:a05:7022:5f0a:b0:14a:a6dc:9cbf with SMTP id a92af1059eb24-1ac599f5078mr7780009c88.4.1793485714706;
        Sat, 31 Oct 2026 15:28:34 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm33876066c88.7.2026.10.31.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:28:34 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] exfat: preserve the 64-bit FITRIM minimum length
Date: Sat, 31 Oct 2026 22:28:23 +0000
Message-ID: <20261031222823.223-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FITRIM minimum length is a 64-bit value, but exfat_ioctl_fitrim()
uses max_t(unsigned int, ...) to compare it with the discard granularity.
This truncates the requested minimum on both 32-bit and 64-bit kernels.

For example, fstrim --minimum 4GiB can trim smaller free extents because
the minimum wraps to zero before being raised to the device granularity.

Use a u64 comparison to preserve the userspace value. exfat_trim_fs()
already stores the minimum cluster count in a u64.

Fixes: 654762df2ec7 ("exfat: add support ioctl and FITRIM function")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/exfat/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 1386149916bb..4e7a2fb30279 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -586,8 +586,8 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
 		return -EFAULT;
 
-	range.minlen = max_t(unsigned int, range.minlen,
-				bdev_discard_granularity(inode->i_sb->s_bdev));
+	range.minlen = max_t(u64, range.minlen,
+			     bdev_discard_granularity(inode->i_sb->s_bdev));
 
 	ret = exfat_trim_fs(inode, &range);
 	if (ret < 0)
-- 
2.43.0

