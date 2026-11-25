Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629013;
	b=2rVQRuijqI2RFmaOFbM7a+FlxxtzAQzRONhaJH30OcwxRiqI7QjjhH26nT3i95A50qf/
	 oAUxNPgQofo3t2c4Hcofy54PJsazfTUJIpMm3SJ83BcMbP0CI9Fz5kmfH4wU7o57/zOzH
	 3oDVMedPS6r4vDsDHRx/HSuMX5x4+8ABa/JFAcLg8pcjJReiXluGEAHASsgAz2mh4XLZC
	 Hn0PddtmOfKu4NotyH7aevkvdYxPRqUPGg6q5mRxk+V2kUrAUD2QkH3Q+B6Ll00IcoHn4
	 9w56aDc6Hxcsvj9epBpoAVo0zjWmZ0s6Oklq3pQcZY7OEquPsHCLhw9HR3wsweO/yUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iVdPOcw1bs6hdzSnoCmlTQe9oM25xdIMmK+wXSHKTBo=;
	b=oY/0LI1FyD9HicxV4C4YuK0mXSsR3u6tp46BpgfLTfW4iZxLvMHovtm5UlguxBSSJCdU
	 1o+cHjRrtwubxORX9XBHX80+7lTIbgwaBQ+xEePctP5p97xglNGB1OzrNylTdV/0CvnDi
	 nPNL3THPapQY+jHbfA2nA/NL8uYTfInfjBTAMeE7S/53e93KXIuArjIXe+XqUzznGSZi0
	 BZdKcUGTCgBXpcN61vQoC7s8/NXDm9vKBNDnGMCL9C5dKK//xEYzhdh1uZuAB6bidlTLy
	 8Ku+Zv6Lhb25pbOaeIU5bqVGJl6BTvHstOQycAZPXF3Njwxo6ClMdci5t+ILNmptv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=VAa13JZp;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E00606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E00606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=VAa13JZp
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4c685c751so53955227b3.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795629012; x=1796233812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVdPOcw1bs6hdzSnoCmlTQe9oM25xdIMmK+wXSHKTBo=;
        b=VAa13JZp07sBbOtWf3GoIBMIBQheUsIZTo3rZc0GmkeFHLHaPzAoIRZd7GdDmnRrRJ
         3a3EO/RwOxQes9cJgDIvwhUr1psiHVxzS9QV4IISmDTLGCktmYY6IZgzxLA4FBa+FGDS
         soP+EpDUm4KUe9avhBaeI7zdedR4GdIObTjNQLG4RKn+7UPwCHaMCQ0xAdbQx4mcreMu
         AV9h4tGyOnXg0pL1/BbDlCA6KK538ImkSkkhNaOxG3eU1ojjwZs+SGbOaNzp4LweZvDN
         n+gdgxejXIxaDbctTrOng4qUiBRJ8JpiNV8Cud+pfPDHdJAz8KsZoq9JrP7yNm6XH3Bu
         miCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629012; x=1796233812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVdPOcw1bs6hdzSnoCmlTQe9oM25xdIMmK+wXSHKTBo=;
        b=kg1DaAFiAmcZ6021p8nLkLODVJlVZF6ItW2JISL02Ra7xN8p2geT/MXnsptpZRTLu6
         +d4tkq65vC0Pba+i1X7My5iyNmmSyz0PFUGeLpEKGX3kqWR3iyjBPshBkUd74e226ExG
         P8vnr4sRPcNAOx5gp5UaCV6YoXohPcDuQ5xTgr0gPFK8KQo+eH/t2D3jG+Kehw1MSP2l
         LIilk8SAz6RvIlljKBneAIWa+XfgSKPGHz6MtYxzk5eFTarQg9NkcdefFjM3Piy0T3J2
         WjMk70NIda/vlzogZDVvRbjNAqON9prZIP1dAQJgN5zDrF++VN5DzqC6XWKyxiZdrMwX
         4MrA==
X-Forwarded-Encrypted: i=1; AL+hErE7DdHZfsSWq7lKaE506lr232yvjoUXad4ws/+cAnV6LRh5sj2xjIZ3y1ozBqfXkU2kZkgG+Xg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AD1mbWhK1IE2mhyIeDi4jhYpay0fUwWPPgE+Jog/q0vDZG/9U
	Z7uv0CI6QoJoQAgwr+drofZ9a1VLSOuI4zmgZRx+K9PuZqSIT/KVYU9VpE+2Pn6JKdvKxDPqsNQ
	Mfz93xxzh
X-Gm-Gg: AZFdTZfwVygItkNFmPH5s/HXw9Z907OqO5VAZEvUKlNpYzqAJkxlz9j96K6KvEnZqDH
	JhSBJvSYFoT0OH1AO/8VDqRgpJTbzPBvWJv26owmZ/AOtYfh18iurKtpr7JBEss+7ejt6kbdt1K
	i6n7zFgigSf+WL8yXVm+1lQD1pN/c4zZWrbxgapN1FgNB/x4rpyvMMkPfIhR/z+yPKe4rv43iAT
	qUlokIIBioU6dI45+kDQwWaqMyZ5WBw1gXa4v6h/rFpA8QTu8iPzaL3DEwHrUK5PxLD4WK0/2OH
	1y86mQdWebN8jX8BnpBAit3cVy4l9int5SDf4IK2IACV7vL+wXdenU5cIME5+5d5QxeNc0EDAqi
	hPfmhovKeYgNiAVvAN0UnenWBlD1ADQ44X5EoH570+uPXC+Z3CoRZMbqKeeeol4g9KSOf6o/dSL
	vYWR9czKtxwrxAhO7ISp4x6SYyYWERpq7blkxxApKfF3KmKufDC8vNHL3083wHNsaUnQ3OKnZN6
	5WqMVSAaFHyaiEREeLLmpDbTD4dlizRoIsHF125hIhjdw8NhLQQ7+WeyLyomAo7p3DnxmEWyMRZ
	oXgEtf1ApVKBkVu3c0APACV6Jev1Ivv1eC8s7ANB/8ILxvVodQ0=
X-Received: by 2002:a05:690c:4448:b0:8b2:e4cf:c399 with SMTP id 00721157ae682-8b520435b9emr76177847b3.18.1795629011607;
        Wed, 25 Nov 2026 09:50:11 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52034f7absm75322567b3.41.2026.11.25.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:50:11 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
Date: Wed, 25 Nov 2026 12:50:07 -0500
Message-ID: <20261125175007.3659558-1-hengyul@cs.unc.edu>
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

Commit 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
made gfs2_glock_async_wait() interruptible. It returns -EINTR when a
signal is pending.

However, -EINTR goes back to user space as it is, and the system call
is not restarted. As of now, rename() and renameat2() on gfs2 fail
with EINTR when a signal arrives while they wait for a glock, also
when the signal only stops and continues the process.

The issue can be reproduced with:

    mkfs.gfs2 -O -p lock_nolock -j 1 /dev/vda
    mount /dev/vda /mnt
    mkdir /mnt/a /mnt/b
    for i in $(seq 12000); do echo > /mnt/a/$i; done
    umount /mnt; mount /dev/vda /mnt
    mv /mnt/a/* /mnt/b/ &
    while kill -STOP $!; do kill -CONT $!; sleep 0.005; done

Before commit 11d763f0b0af ("gfs2: Retries missing in
gfs2_{rename,exchange}"), mv moves all 12000 files.

After that commit, the result for 783 of the files is:

    mv: cannot move '/mnt/a/10' to '/mnt/b/10': Interrupted system call

With this patch, mv moves all 12000 files again.

This patch will return -ERESTARTSYS instead, as gfs2_statfs_slow()
does for its glock wait, so that the system call is restarted.

Fixes: 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Since commit a098f26d3b80 ("gfs2: Get rid of sd_async_glock_wait"),
signals are only checked while a glock is still pending, so fewer
renames fail: 60 of the 12000 files on gfs2 for-next. The stable trees
that have commit 11d763f0b0af do not have that one, so the change is a
single line there.

Application impact (Ubuntu 26.04 user space): rsync 3.4.1 updates
12000 small files on gfs2 while its processes are stopped and
continued every 5 ms (kill -TSTP / -CONT). On v6.19, rsync exits with
0. On v7.0, it exits with 23 after 267 "rename ... Interrupted system
call" errors, and those files keep their old content.

Tested on gfs2 for-next (9aa0082cf969) with lock_nolock, KASAN and
lockdep: rename, RENAME_EXCHANGE and directory renames no longer fail
under a SA_RESTART handler or under stop / continue. A handler without
SA_RESTART still gets EINTR.

 fs/gfs2/glock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index aa11168255e9..05e6b0f6ccc7 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1318,7 +1318,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		if (!glocks_pending(num_gh, ghs))
 			break;
 		if (signal_pending(current)) {
-			ret = -EINTR;
+			ret = -ERESTARTSYS;
 			break;
 		}
 		ret = schedule_timeout(ret);
@@ -1329,7 +1329,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			break;
 		}
 		if (signal_pending(current)) {
-			ret = -EINTR;
+			ret = -ERESTARTSYS;
 			break;
 		}
 	}
@@ -1363,7 +1363,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 	return ret;
 
 interrupted:
-	ret = -EINTR;
+	ret = -ERESTARTSYS;
 	goto out;
 }
 

base-commit: 9aa0082cf969a9973ec6554586753c53211ab799
-- 
2.53.0

