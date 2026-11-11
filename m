Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413999;
	b=V6A9Y/jeYz/cRn7JLSIz+L0qi1f6oVlW4iOjiIYIWz3I1McU7KdDkgGiKiJ239Q8WjAP
	 2Jccz+IkJg/m/Qim3CYDuQRiRrdvdY7vd1oKhBaAnvgjACrrsJbqIdnGrDyrnb30PnGr2
	 8PaLJrEsH6crCNgg8tmoCy9KHGjOSCba7WC8IErbDQUQN8LgX8UWbj+bBe5dExKb/YSEV
	 znbnP2C9wxZilY0eNdl1R3IvUXMIm6ZC3wVz1Nj6Br1pfV4bSD2DIXqLK46SSjyNQZIKD
	 QJfK0oMgnvBDzntlHJPqR95NaPQphvGPkwA5GwUI13Af8I+LuVSN7kDDwv1wm9d7Hrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tpFQVvTSPM1AW6QGgundhbRDMIIJQ5qoStTy037Hp+A=;
	b=X5wWKLDfYwT2ewsL99nbBH/OYq+FzliWd7DuHHMGrUDkro26eKsb0A0nJghJMlxm6duI
	 J6jCMynsAm2b6xHIul6OkQUEn2FYCqilbQb0CtUts3gt9W5h5seM3kZnJeXz14LECqmjS
	 FZuGBCIbyE66C3sn8O3y0tHMAw2yAL5Jxigu7HOwyAzrQWko3hnu8/EnzgBgSWVVLV+9l
	 WOMPbfWG5vIzLVrsPPhiqJ3VkNRDpVBnEtJV0fGWCM8MWSIyR2lMAtnfLL5Ji/j1r4GVn
	 27b+BaznhrbBDlmdGw08Jb/MSqA6UIZXWAVVX/EDr2d53GEmIAJfvWYIKEqr5atHPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4Y0H9U9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2260A263C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4Y0H9U9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C031F00A07;
	Wed, 11 Nov 2026 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413999;
	bh=tpFQVvTSPM1AW6QGgundhbRDMIIJQ5qoStTy037Hp+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S4Y0H9U9M+R20k7ItmCkXwkB03NGP/hWSVoeNSwYzm+acNt3qPBC4NQVDZE+xF5yb
	 Z2FRGiXxbFS4L+M7KwNHk7tQSUDfIUM290Mvnrpx8YA5kihmm+rS/ZpAMmP+NSmbI/
	 eVtwoiOFDAas3PMuZwm3vt+1zqDv6IcNke1bwW/qkCpHSxbbmkY1eLTlC3TwPKklFB
	 oit7kI0cjOCz/QipWn64KeV2i5d8bOG/UBbHgRcUCvGJM81NevukIW1XrEwDZq41sj
	 fKcCXJjbwh83GWbJGf62/OBHIYoe2sqlRUSGNPNZLG+mhXUiAL1G5a3JPck92+jClE
	 86Cp5qjLEzV2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chung-Chiang Cheng <cccheng@synology.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] splice: report related fsnotify events
Date: Wed, 11 Nov 2026 11:19:54 -0500
Message-ID: <20261111161949.3187571-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161949.3187571-1-sashal@kernel.org>
References: <20261107063106-failed-5.10-79b496ebe382@kernel.org>
 <20261111161949.3187571-1-sashal@kernel.org>
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
index 8237ed720a35f..c4d3ac181a9f6 100644
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
@@ -1079,6 +1080,9 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
+		if (ret > 0)
+			fsnotify_modify(out);
+
 		if (!off_out)
 			out->f_pos = offset;
 		else
@@ -1102,6 +1106,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
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

