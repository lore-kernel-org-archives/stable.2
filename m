Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412740;
	b=xcZV15A8JM9yC1tPGy4qZswZVHPrLgrlcf9VDtD5uqDCyWK2JpZMYqIqAySQ923Ze56+
	 8SIoDcLhohoORFsEt3M8BFW9bhSjezd8gBq/rlz2yAOMZvOaxoVEG7OLgU3di7ZfJ9x/F
	 oHyh9z3hQMilAbv8s/FA7oLgajfv1Zfuod/hxtHIdD6FiQAuLF7IhQPATkDK6tw72ELMx
	 KXg5PtbfYC72krZ+eB9e7F5ZQ4aiXi5Nowsr85DWua7voViIv3cMPesAlFtgu3Eoay2NX
	 A/SZhqH6UD0rqwWo5znLkaNHQ78SP9RqnGRLRgKaAzXv5B6HMc+/UdayO2lZw7o/V2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fMqK7Cg1yuf9osSO9G/i90EWPEYx2997fCxznjloMx8=;
	b=1nsqAYNaUZ8LEQ3mlKWdbpVC8/f9TCJY1Yk8Oi3NDzgEE5DFPsbK9037gs/fMJUubmo2
	 YNaN1zdN2dhPymkXE1weozMRgQbs+rOZk1VHm+2aej5+B76scYjMBHe7YU0lWsMovYXt9
	 95XX6IXQ2Y8oKHq9AIqEasD1UqAD27WFfdhc9Kfpr9f8LR6qtf0+yZ+Xt/dZApqrMMk8B
	 PiGCnBgaPq/s9l7RNf1CLvdzRcVvvwIvl/XIaZMx7+BVHyOXHG8DMZzXS47eLSX9l/NWw
	 rdc9CqEvmObmHFrjQw82iZpa+iFxhZ2Q5DftNCB1slXW2ERr1rVRVOZI0PNTTqCmu2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxE5ZTPB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B9606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxE5ZTPB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31A61F00A05;
	Wed, 11 Nov 2026 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412739;
	bh=fMqK7Cg1yuf9osSO9G/i90EWPEYx2997fCxznjloMx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxE5ZTPBfpg+SpbWgQrIg023c4XodXbw46dYasQD8OihE02XIckUZmwVTsGDi7DCA
	 F/nzPhdxn9GRgpzz6TVYDP05sYH8RYA2bjso7gJ1NRccCHiHmrEU9z9kLjAJwi5QM5
	 bddhqXCdwh12ah1L38xOMsym0MiEpb5NYok8/pKsukQhOyx25yaeFO0B2IYuVFedrx
	 KbmIECKXg0xWIhdidta14mJBJL/yFs1y+AoYxb1Tvq8hBEE3OoSxevgxJaKogTeQsr
	 fLD+o9vQ8nddm5bHN4XMfk3OJukDUNg90CyjSRApb2PBU2921KrnJLPs87Q8WGneVc
	 CB+q5F7mlaDBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chung-Chiang Cheng <cccheng@synology.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] splice: report related fsnotify events
Date: Wed, 11 Nov 2026 10:58:55 -0500
Message-ID: <20261111155849.2761399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061356-failed-5.15-79b496ebe382@kernel.org>
References: <20261107061356-failed-5.15-79b496ebe382@kernel.org>
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

From: Chung-Chiang Cheng <cccheng@synology.com>

[ Upstream commit 983652c691990b3257a07f67f4263eb847baa82d ]

The fsnotify ACCESS and MODIFY event are missing when manipulating a file
with splice(2).

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
Message-Id: <20230322062519.409752-1-cccheng@synology.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 79b496ebe382 ("splice: avoid stale f_pos writeback on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index a43152bb106fc..b939b101fd832 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -30,6 +30,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/uio.h>
+#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/gfp.h>
 #include <linux/socket.h>
@@ -1108,6 +1109,9 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
+		if (ret > 0)
+			fsnotify_modify(out);
+
 		if (!off_out)
 			out->f_pos = offset;
 		else
@@ -1131,6 +1135,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 			flags |= SPLICE_F_NONBLOCK;
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
+
+		if (ret > 0)
+			fsnotify_access(in);
+
 		if (!off_in)
 			in->f_pos = offset;
 		else
-- 
2.53.0

