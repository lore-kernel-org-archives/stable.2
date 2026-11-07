Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047141;
	b=oLlw8+fmM+2EtEgk2Hl2XJ2x7MXpSHybNy03nHAFUJ0MukMTM6u7xylqRL2Y6ZfUsUtU
	 ZrHbmi4BFBPb0UA6gc5MiZ7zUkqk3YvyLv+FDQm2mcZYT9T3UcKkoLYETrSSSeu6TFjXi
	 KxIiLcd7fxMe9BuQtBwgf4ph4feuTU07c6w1nxWm85FNZGGgk+8/8LCP/1gwBU5yyyFxc
	 pBiT9WBzLyyxHk0gdRGbmLO0TLWFbVLU9dCgZNjspOGRthPLjJYWv+ZL8mv3z8Z0CHAE1
	 8cvDpyURevpEd37i/Ze765YtgwUIYgplAdOpHczcrhKiRwyFxDKJr9kzEDE8zs1bpuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QGLUdS86hqMCgHejQBPrCtdvVp/CsQEQQYzqkXuVilc=;
	b=UnHhWGe1A07cT7ud9YfsjGzVGlx0QI6duLWrkYz4mfY7W4sMc382IYYGzYd5kqZcd6Ub
	 szXCWz6kAYS8OkSXNKcqbKHkBrHG+dJQxFtRnDFSLUcrrJr63F4HDdgtIZfLepGFVEHwL
	 KNt3z/Asj1Sbwg17AbFXEjlUHY5OPqNQt22wmGi0+WSKDVnWsa0vKy1Ujo4OwhRJd8r/1
	 Y8YGVd5/wICE+IkCD7UtwNYHZcTzTF70i87/OD+obd56+Bpi+9JnPw4/qtQZuPKv4sjxP
	 jliWTL0h7Vdgrugs9C7RpCl61UVEHIwNYcMk+ICZ1ZBoUouAtsa6wwyCz+h16sFYCLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNIwsMNM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNIwsMNM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F89D1F0089F;
	Sat,  7 Nov 2026 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047141;
	bh=QGLUdS86hqMCgHejQBPrCtdvVp/CsQEQQYzqkXuVilc=;
	h=From:To:Cc:Subject:Date;
	b=NNIwsMNMFdtczGI230Nka4+SifGf2ov6tOebc6+vb0yIHZ4DIWK3dEw+AHbVKl/PI
	 FzaFtrMKVoxvDl+UeZob+Ck/4S7rz5gQjTMZmUJTFH6Pz/0vgVd70zbxInhY+/FW1L
	 1aCTxILrmweWXqf7T1QIoVReOwF3K3tNHV43J5O7WsiHIGl8EDGJNqc7KdxN4gO2Eu
	 E4AppwQQ93sRNGPBgs2bPRAvQt/fEM0HhGAU0rXH6NInUvif2C1OzcvLCkFJr1gnOb
	 8LpdzIXYFbZuw0G8vO6N69JvgIuIUY8tNX3Z8JidoR9w1vspMFJDo1STkdgAigyweH
	 M5poH1CkYQC+g==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:39 -0500
Message-ID: <20261107052539-failed-6.12-1ae42513205a@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1ae42513205a38b811afedb6797f9f9c4de37b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052539-failed-6.12-1ae42513205a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1ae42513205a38b811afedb6797f9f9c4de37b90 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:54 +0800
Subject: [PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result
 byte

ufs_bsg_request() passes the user-supplied UIC argument2 unchanged,
including the result byte (bits 7:0) that only the host controller
writes. A non-zero value triggers the WARN_ON_ONCE() in
ufshcd_dispatch_uic_cmd() and corrupts the reported result. Found by
syzkaller.

Reject UIC commands that have the result byte set with -EINVAL.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: 9fb4c793223b ("scsi: ufs: core: Complain if UIC argument 2 is invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-5-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0db830e54ef0f..cadde515f040b 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -179,6 +179,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
+		if (uc.argument2 & MASK_UIC_COMMAND_RESULT) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = ufshcd_send_bsg_uic_cmd(hba, &uc);
 		if (ret)
 			dev_err(hba->dev, "send uic cmd: error code %d\n", ret);
-- 
2.53.0




