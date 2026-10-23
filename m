Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779190;
	b=q2z9Doi/cS8soJcLulr/n3zoCJqPSTUir4YJOFqCOUwxP5nvw0F06X5R868m3/oZYhIr
	 tsHSx5bwbDWwQ1nwc2DErqB9RcHKUglxqGyrNG0cw+XRDU6syjTHHmg58kB0s7c/FimbU
	 lN2jXyinfgxzZpt8R796GgjeegKPE3GVOQNbkmcAyishn3b0BXnXvXXgD39unM3tfL6ZP
	 3iKU2AACW6N+f/tRqNJI++vfkre3MbSxT++86JvrnYWUwSYnyivoyTR0g3qSnIH6d1Wn/
	 +V6t5SEVJ7BPAREEwSjIDLl5FP+yq5POarLv949fs6fyGmJEOcEi44UKmjmEI3wytkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4FoCKLxbV8UZ17k7ny+PDZ4wC8nV8QJxctUdFkqIFLA=;
	b=hbCogUsmyRWHTgeohiB/Fk3DJyiQPrEBzagc39Xfq5g+EmnXrWi+85/q7w8AaxuH7dM6
	 sxTF/mNGYbTJ8vUcbjtwI85V17rKwXRmvCo8xdN0jeWBpCwCyZvDzLuOmY9fpxQcWzEGW
	 sGykU+hMgWo0Km8xITmX/Hu8rz2R9isckWuDkC9b9NYVXP+Q7AlLRsaIilhtDBALcopwE
	 aI+P6LFG9GgwhXPnseLKytedf6xEDBYXcAtGM2bzOT1iyK4YKPaa3VAAHZUC0ksCRZvr/
	 pnE6rVj3ZpVSXv/Jag5XSOKbhwV+NJY+uZClnDGQZbQmbyX8D4w1pbHPFoc0QthY6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JWi7MxIz;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857B606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3857B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JWi7MxIz
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a2b540f3so1143989d50.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792779188; x=1793383988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FoCKLxbV8UZ17k7ny+PDZ4wC8nV8QJxctUdFkqIFLA=;
        b=JWi7MxIzEivg/dE0FlI7yoQ64woRjflvy/p66c7W5Hgs5umFzQJ5SAZ6vRNEzZrE1S
         6cHHw/U1I6OTEILgYXEMAmHqHiMh34kuYHCyq/+c3ocWPeXwq3kIqZ1BAG0Y7ThAwxrO
         D+F+CaBrG9OnRahT8d4Pdt8DN8WNgfa2pjZ58O3F2xx1fZXl+RH0JGXLtAByV+4Yj7Cc
         /Dn8qx+mU+3xrhBUKLgEKoUYow2lqxRpyY7xuP11VGLKmMX3lRfrknXf1lYBGU2F5uoh
         4xg+vjidzfbEXZmAz5WxRoYOgVYKzgcj99QfBPVNzJIgXFlaisl80mWPOtxSCkkDN4Nf
         SjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779188; x=1793383988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FoCKLxbV8UZ17k7ny+PDZ4wC8nV8QJxctUdFkqIFLA=;
        b=1YQ9dNWMQIZi3aJm01s7ImcIWmdlJpCd55Gh+97/YuBmhwY/Nu3WJkNW3VCDtEOYWn
         5Iji+rcPVdzWg1YehaolYrZcZShHoc7oQJ/aC92uKTBrHjzpFqslWhrkVDYAy5H4ZTto
         VE2A8h6qiVTxQT5Ex7M0cAyOR6ZVcVo2W0YuPAtzG2sKOpVnJru6jzCWThS1uu/RUNNk
         lEQkSTtVkeR/DlygpGLZYLXh8KYnPR606uFeIH8BfcrYUT6e1M+ca4ka0AkZVJ8zQtE1
         A9H4hTp11HRxyc4lay2Wd0beH4cK9Yaq1wyOoFVf3HHsr9fdOAOsX1ydjXn/sI6Whe11
         4XrA==
X-Forwarded-Encrypted: i=1; AKwUvBwmBtj2DaTfkaDRRx2fxrsFXVBO8oXROLtpoftaxmJV4wjXRsJuufWZC0Qm8KjXsJgmhfzv8Uw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+z7DYQpLLpswvF2PZviKvMHs8MuAkSHwq2vle9ke0It3pcJnL
	hg8xv5QCeFS0+uUFUw9dKsOS8cMdhWCupbec5CzR0LqezDeWjydh5bjzvyY84FHHWQ==
X-Gm-Gg: AYBFou0v5Dzc2Hw6AR4ZKgMFwWkPDA0XGjGGUTyHZN1RnS0lHsNr70eCMuGME0hw1te
	vV2OB5tb2RYPeZ5GD2FvOlvmNiSIB+05UV5plKhJKo6YMZIflmibCpwnFnY1p8TG7B0mBMlpV+W
	VlsvgGPn9oLvjke34GSJFXXVVJ7D4OnpRwBYOVaHJZi0EiJzA0IYo0NqOAB834ViCyGHFmFXJtc
	n3ub+10W9KFnPPETUZLBykh6jpxpe4fyxlCxhtC+mGS6i0x07bn1tL7TkS3LHqmpOtSgYUFA0ZK
	+N/fkPYQ8fxJTYqFsZtgg/DeGXwOrniZSpFvQfEz43sBxlrIR0UQyfFBPuHcPm2TNzSonoCqHhH
	INATBp3xqCILElWY6/h6K3tBfFHqFJtF5/SrWsWOxfKNJ67vDRBrzK34zjHvmSTkPfXqJhBn+Z+
	bQ4VB7PHR0hhDhvtJqrVCbPbdUT7hDkAjcg1jWBh5+ZmEzYM5YqKO/dAhzVFMhjoNs1kSUsTLKx
	qeYAR+NBiZ9q5pZBnP975hZ7XrEsCg6vjfhb+gF5W1x/bLs9G2iV1KnFmbWadNh5fCZlTpa0AZ3
	M8pm6xCncKovZskuzY49HaU=
X-Received: by 2002:a05:690e:43c6:b0:676:8cc2:bee5 with SMTP id 956f58d0204a3-67a35c97da1mr1062555d50.85.1792779187892;
        Fri, 23 Oct 2026 11:13:07 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a4263bed4sm341889d50.0.2026.10.23.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:13:07 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	avagin@gmail.com,
	mirq-linux@rere.qmqm.pl,
	arnd@arndb.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: return -ENOTTY for unknown pagemap ioctls
Date: Fri, 23 Oct 2026 14:13:00 -0400
Message-ID: <20261023181300.3366487-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
optionally clear info about PTEs") made do_pagemap_cmd() the ioctl
handler of /proc/<pid>/pagemap.

However, do_pagemap_cmd() returns -EINVAL for every command other than
PAGEMAP_SCAN. Before that commit, pagemap had no ioctl handler, and
the VFS returned -ENOTTY for these commands. As of now, they fail with
EINVAL, so tcgetattr() and isatty() on pagemap report EINVAL instead
of ENOTTY.

The issue can be reproduced with a simple C program:

    #include <fcntl.h>
    #include <stdio.h>
    #include <termios.h>

    int main(void)
    {
            struct termios t;
            int fd = open("/proc/self/pagemap", O_RDONLY);

            if (tcgetattr(fd, &t) < 0)
                    perror("tcgetattr");
            return 0;
    }

Before that commit, the result is:

    tcgetattr: Inappropriate ioctl for device

After that commit, the result is:

    tcgetattr: Invalid argument

This patch will return -ENOIOCTLCMD for unknown commands, as
procfs_procmap_ioctl() in the same file does, so that the VFS turns it
into -ENOTTY.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Unknown commands should fail with ENOTTY: Documentation/driver-api/
ioctl.rst says so and calls -EINVAL wrong, and POSIX requires
tcgetattr() to fail with ENOTTY on a file that is not a terminal.

I found no user space that relies on EINVAL here: Wine and the mm and
kvm selftests only use PAGEMAP_SCAN on pagemap, whose results do not
change, and CRIU and LTP only read the file.

 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..92b275dc0d59 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3307,7 +3307,7 @@ static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 		return do_pagemap_scan(mm, arg);
 
 	default:
-		return -EINVAL;
+		return -ENOIOCTLCMD;
 	}
 }
 

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

