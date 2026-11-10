Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273059;
	b=i43We6wRYHc+pzHwzfZUmFAIhS6dQVBDnPy+bd2XqZ5G2PqvQDnBacHGK42UPYLsvXBe
	 N/edT/jlaP8hRKZhByd5Ex1WsNY12D22xv1tkxFWKF8HWR9y7W+V1vutdS0uJIf0uJfdZ
	 XXN+DRvM6jsijSrjo45Wuv8nYQXhejYpDdXiGCzaLlTMiJKNLYJGux5jCasRuRTRzcSi6
	 cdMklNv0lW/gHm2Pjt3JCayGrmPYcvNtGl6lCWMUdvmjnnamGh5/9SVfiD7JtVe4+eQjT
	 Di0EmnEZyM8FhIBdF2+dKxOK/9Bc/kBjHg3ThQJtR/bdkOpISctLlmbmrxyTASTXWbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AGCF0MBbWYlSPob9p2hGEfKcmGS6coXsQFW2QnxHE/4=;
	b=OxBLmGa60XplrjzR85RBWYiybhqqY6bHYK/ZzKnE827cxCPGPF5iZsg9v421dzFOTWr8
	 enHCoc0K2M+UzV9QyuKKn9hcsAQkxkynfkxhlXs8kGEVYTwgNv2oY4RkAQJLtKrLkdVV5
	 PgQwCW5dw9khbJqrg4aUWYxG7xMrz7W13I68tatKpyNqZfQVeshXdmxWxxnqdj15cv6Sc
	 XU4UB4vvGC3lYWYHd/L9n2AsZ7jqGrs1cSeaf4V7Ow1xudiCBxwo7rFYDLkVNYYDfZEpi
	 tVXaMyMrNJr4Hx1tKoEyqzdiZjjRUvTubAiyDMJys8Gn4YhRPTaRyhFwkr4PPFgV+8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIiXUDDA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIiXUDDA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF98E1F0089F;
	Tue, 10 Nov 2026 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273059;
	bh=AGCF0MBbWYlSPob9p2hGEfKcmGS6coXsQFW2QnxHE/4=;
	h=From:To:Cc:Subject:Date;
	b=XIiXUDDATQaTOUkyFRmtq9U/qrNbAttiljyumPxG2q3MwHpkjgB8ADryKGlpFea8J
	 XxXVswPHoW/c23iUinr3EtfZ+ZotvLEawfyL4pk3MNNz1wTCIHhUSrpcn4Y3BwfoTa
	 JzQt84BIQyaHYkj+Ii3nXYKiIo5QQLHyJEUTNSpw93vixplGOF1W90pqdvjjGmuxa9
	 JN49wQ2Rtp5mK9/+qebKPnWeSgph8XgHevIuwnplTVHMxjLIswfAVz/uEn74WEcywJ
	 vdEWy5iwebLhz5EqfKgef95gaJE//l0b58NIAQBVj7k2fNIhgzbZkxUBrbKCDMGzvF
	 KSog04ltXEjEA==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: revert fsids on durable reconnect and replay failure" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:57 -0500
Message-ID: <20261109201057-failed-6.6-539223f18026@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 539223f18026448f67d33d09719c355b91db7fd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201057-failed-6.6-539223f18026@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 539223f18026448f67d33d09719c355b91db7fd0 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Wed, 28 Oct 2026 20:28:03 -0500
Subject: [PATCH] ksmbd: revert fsids on durable reconnect and replay failure

On a durable handle reconnect or a request replay, smb2_open() switches
to the SMB user's fsids before calling ksmbd_vfs_getattr(). If that call
fails, the code jumps to err_out2 and skips ksmbd_revert_fsids() at
err_out1. The user's credentials then stay installed on the shared ksmbd
worker. Later work on that worker, including other users' requests, runs
with the first user's fsuid, fsgid and supplementary groups.
ksmbd_free_work_struct() also warns, because work->saved_cred is still
set.

Jump to err_out1 instead. No path is held at this point, so skipping the
path_put() at err_out is correct.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Fixes: bb8bf7eb13b5 ("ksmbd: add SMB3 request replay support")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 528bb4ac97e16..2e955d272f4bc 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4530,7 +4530,7 @@ int smb2_open(struct ksmbd_work *work)
 			file_info = FILE_OPENED;
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
@@ -4560,7 +4560,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
-- 
2.53.0




