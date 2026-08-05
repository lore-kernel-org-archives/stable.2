Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53243D8100
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916593; cv=none; b=seP1Hrn9jWsIMc9y4fFTI537OnFoIFMHJmKUVlE4gWtO9pel1sXOipYTUmBgFDXR6ylSXH0E7yLA1JDE+xo93zbU+Zk7RQOFRkA6qeKdNgZJ5gNr/gzCiaCykb40HLDx7VWd1zFzwND/nFiwEV38InN5WH6YRZRhLM412LnV6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916593; c=relaxed/simple;
	bh=1tsZOP1cJe1vBjHWkYNRr+dqkrAkT4Whnc/9jiAlbZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdCtPVG63uj8z/UdEHH4GsbCmb62r9E2BwKsHTzUnq6E5OqOBEWC2cfA0eDHGDQ7Cq9l8c/qQc38rff0mFiGcS9xqIkkzt7XrQtHCNm3lG9CsjngT3FhZpxHZvyjscjU+eYkMvwqZl/Gz+cQRB2OVtVOBFbI5Q38+G02ObTFCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbKnqcgh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbKnqcgh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38101f85591so1633526a91.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785916591; x=1786521391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0WUaISw6qk3Jf0zcCDZtifF5pf/akYlS+Jfhu1wJBuI=;
        b=RbKnqcghVN3KHJh/C2lSYnlUWjQjHFkYbSlrWMyIBQdVtM2oc3T4FDpuZokMDoF22c
         r3VdwhoMicQTl53tZERJZiZjjdtf6hTy2zx03VUDEoIlVBgsx0+uU/l1SHgtU7XFb1Mw
         7GhAknrIP4oxBkvmu0dTEmBI/yygq/SJjf8plR4KBwc+622fDPTuYATSS2cb+BvCxKl5
         WFcNKXDsjDAAW9lQnLcogwCLxUVCFfR5yopNrv/su+n2t5MiqrVwU3E5RLAt0Q7aWbQj
         R6Tzlw8HjhhVtuqoRnjifhuPYF2XW/b8HGfwGtz6M9X2Qy7sxaudjdtofHLw6uNQgVfq
         J70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916591; x=1786521391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0WUaISw6qk3Jf0zcCDZtifF5pf/akYlS+Jfhu1wJBuI=;
        b=Lzkg+gImIf43scyYiE5DzI2QAMO1FTCASniMmoOpvdsInbNI3PpWn4q6LGS2HANrwa
         7KtxWKViry2E5SwrOrhaSqsW74taVo0CFywbq/2lgvlDe7B0NuzwW+QscD9+ULHGU06I
         O/rwbnQMpyQTNLNcWOFNDabhEMxoSe4I1bwuu5J+h8IeucHYDeXowwEcFPXE3KqfwXhd
         raYJv+UHPGc2HJP32yuNDtohNTMqkDP+kQIbZcVuwC61Dxem9/FvH0x4e26aXQiSFTFb
         cEYSJCzOheoA38LwSm3nsUvFonE8tbbpBcX0Q0V+ezMufuq7V/e+tTWXbnhe5woTLkZD
         J+aA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9vQ/A262Q0l1dfvo5zxsD2hWlAmCFDgB3r6P9OzdhTI4VBABfkuTe4kbOOYM4pXGEq3++5uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqGh8zMovelSC7WpMHWUKgd5ZAWHmUAjnolr9n5THUDBwllCo
	qXeftS8LbqxQ+KWYC2gzkVa+K6s+iuz142inTP4sxOaKaYqIAkpa7mdY
X-Gm-Gg: AR+sD13frK1XjR/9K3g0XnDO2aiBRD6dGqCAJroT68Q7ORJLJgh0myga6qzFphF8anH
	pB4YPpxXr7I3Hv730QiMaydgTmBJ1O/gl3PQ2kmAWUikq+4LZkKOP+3PCvd5i6nBZqA/LWr6v14
	XW9KTTiLwZ2zRhXZHLRs1UrirKKPqhEvWH8Mjj/zNHBfE4vNdRm1ilhYjlqMTAXvqNIpt5+q9hn
	vSK7N4kK+Q/tKkAKvKzgs+ASOD55yLaM67qYQIY46CztQ8XT8/uaEzwgH+U+dMPnP0hbix4KlKX
	P68EEK+5ZuW4XFYo2nikCXkXQvapUg3veW6zDRSrCcJqZ29ysz6fMIRWe543dNw4NYlWizuptVb
	8rKYSPgJL+pcV5yuh6JHqIwhXZZDe4CUCpyCF9EnM29ie9pomI/tc8fKkHda8CIm/kJ5SZndZkZ
	G1nZOBL1MDFFWjUm2C9a/8lQGH+WO0OVEDzgaxvnXKiDEp/X7cnvIBhIFCijMuN3I2a+qKMIiTy
	fiZE17CeZfd6SuUG8UEt3KquMsICvBfx5SxzbaQ5+nVs6MhQfqIGRtXgC3jBYYdim9Ysmca9/KU
	cpMK8Gvqr5SN0qeOXXVPZjvFerNN30oW27Y7QuAAB3OQZTd2ol5R
X-Received: by 2002:a17:90b:17cc:b0:387:d5bd:622f with SMTP id 98e67ed59e1d1-3903c6fce95mr2091676a91.18.1785916591024;
        Wed, 05 Aug 2026 00:56:31 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffb2ecsm3770582a91.8.2026.08.05.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:56:30 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	glass.su@suse.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: fix cached cluster count after suballocator reclaim
Date: Wed,  5 Aug 2026 15:56:25 +0800
Message-ID: <20260805075625.3518094-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anLkDGTDDzVDMijK@p15>
References: <20260805070837.3390148-1-matthias.goergens@gmail.com> <anLkDGTDDzVDMijK@p15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Heming,

On Wed, Aug 05, 2026 at 03:38:05PM +0800, Heming Zhao wrote:
> Could you share your test case, I want to reproduce the issue and verify the
> fix.

Sure.  The test runs in a QEMU guest on a snapshot-only virtio disk (the
host image is never modified).  The image is a clean 256 MiB single-node
local OCFS2 filesystem made with ocfs2-tools 1.8.9:

    truncate --size=256M accounting.ocfs2
    mkfs.ocfs2 -F -N 1 -M local accounting.ocfs2

The guest runs the small program below: mount with
heartbeat=none,localflocks, create 10,000 empty files, sync, then unlink
them all, sync.  That drives four suballocator reclaims on this image.

To observe the accounting I used a temporary diagnostic, added immediately
after the ip_clusters update in _ocfs2_reclaim_suballoc_to_main() (not part
of the submitted patch):

    pr_warn("OCFS2_RECLAIM_ACCOUNTING old=%u disk=%u cache=%u cpg=%u\n",
            tmp_used, le32_to_cpu(fe->i_clusters),
            OCFS2_I(alloc_inode)->ip_clusters, le16_to_cpu(cl->cl_cpg));

On the stock kernel the first reclaim already leaves the cache at 512
while the disk holds 2048, and later reclaims underflow the cache.  With
the patch the cache matches the disk at every reclaim: 2048, 1536, 1024,
512.

The guest reproducer (statically linked, run as init in a minimal
initramfs):

    #define _GNU_SOURCE

    #include <errno.h>
    #include <fcntl.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/mount.h>
    #include <sys/stat.h>
    #include <unistd.h>

    #define FILE_LIMIT 10000

    int main(void)
    {
        int created = 0;

        if (mkdir("/mnt", 0777) && errno != EEXIST) {
            perror("mkdir /mnt");
            return 1;
        }
        if (mount("/dev/vda", "/mnt", "ocfs2", MS_NODIRATIME,
                  "heartbeat=none,localflocks")) {
            perror("mount /dev/vda");
            return 1;
        }
        if (chdir("/mnt")) {
            perror("chdir /mnt");
            return 1;
        }

        puts("ACCOUNTING_TEST: mounted; creating files");
        for (int i = 0; i < FILE_LIMIT; i++) {
            char path[32];
            int fd;

            snprintf(path, sizeof(path), "inode-%05d", i);
            fd = open(path, O_CREAT | O_EXCL | O_RDWR, 0600);
            if (fd < 0) {
                printf("ACCOUNTING_TEST: create failed at %d: %s\n",
                       i, strerror(errno));
                break;
            }
            close(fd);
            created++;
        }
        sync();

        printf("ACCOUNTING_TEST: unlinking %d files\n", created);
        for (int i = created - 1; i >= 0; i--) {
            char path[32];

            snprintf(path, sizeof(path), "inode-%05d", i);
            if (unlink(path)) {
                printf("ACCOUNTING_TEST: unlink failed at %d: %s\n",
                       i, strerror(errno));
                return 1;
            }
        }
        sync();
        puts("ACCOUNTING_TEST: complete");
        return 0;
    }

I also have the full harness (image builder, initramfs builder, QEMU
runner with a log-checking mode) if you want it; happy to post it or send
it privately.

Thanks,
Matthias
