Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24D41F37F
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169907; cv=none; b=ODqV8NuTl48ha+LoRAvxt39tFkGHgkLkL4VSFiNek5e13/VQ4yA0WQ4hXAFNQ+UIkF9uDRTK7pA1z6EKHGdl0spuZwPFbnG0m2lUmNEmzTgpXEy2STQ93dKsPqPqvKiyLOernQlJPK9VbH/bBJQGbRbJLik2JrrT5dtzQNnciTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169907; c=relaxed/simple;
	bh=Y6g7Ihwu/R+MviYtMgBIOT3MosgJUNhgxIrcfY9YjLc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jkdAAMByHeesOwurSqpIpHs28AmN28SOPBNpdZwPZh/7Bot9eNpeWBS3okGvQZVV8e4B4QR9jo6RbULsji2r+99j3e2sAlbodm0lpCLPhP+bo/O3seuMaNSCqhXRJirI6boP3lM74kcdotk6vrYtRF2EQvxrRE4TD3TRNENwclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OhW7+MOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhW7+MOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC31F00898;
	Wed, 23 Sep 2026 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790169904;
	bh=ppbbx+AZyuJAOKqobVH4awa+ZM77M8mgYeYTo34T/Oc=;
	h=Subject:To:Cc:From:Date;
	b=OhW7+MOt0ChQ0Y67TkoSSAGxbfMgc1B0gkHGoMKL7rtIZ6F9mkLUpPosi6ZGlPYRZ
	 Rg8nrCnEfuPC9OLDYvflehWsx/l6kvdlPBgxRL3+O0QpJVJd4nHOgSJFJHpEvRQtzc
	 iIXB+IUdLZJfdq/hBAxJga7WPqrLcTt4uObqM18o=
Subject: FAILED: patch "[PATCH] ksmbd: fix partial normalized name responses" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,chenxiaosong@kylinos.cn,mobin@mobintestserver.ir
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 Sep 2026 15:24:52 +0200
Message-ID: <2026092352-axis-issue-076e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f4fafaf02174c32bce2f9bb4196fadf13f1fd96e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092352-axis-issue-076e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4fafaf02174c32bce2f9bb4196fadf13f1fd96e Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 9 Sep 2026 09:58:22 +0900
Subject: [PATCH] ksmbd: fix partial normalized name responses

Windows may request FILE_NORMALIZED_NAME_INFORMATION with an output
buffer that only fits the fixed portion of the variable-length response.
Treat the fixed portion as FILE_NORMALIZED_NAME_INFORMATION_SIZE so ksmbd
returns STATUS_BUFFER_OVERFLOW instead of STATUS_INFO_LENGTH_MISMATCH.

This avoids rejecting valid partial normalized-name responses.

Fixes: 6b8b79226bc3 ("ksmbd: fix partial file information responses")
Reported-by: Mobin Aydinfar <mobin@mobintestserver.ir>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8acc5174530b..0436b7c898b1 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7312,6 +7312,9 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		case FILE_ALTERNATE_NAME_INFORMATION:
 			fixed_len = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
 			break;
+		case FILE_NORMALIZED_NAME_INFORMATION:
+			fixed_len = FILE_NORMALIZED_NAME_INFORMATION_SIZE;
+			break;
 		case FILE_STREAM_INFORMATION:
 			fixed_len = FILE_STREAM_INFORMATION_SIZE;
 			break;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index a6200d8630e2..ca8e27f7b712 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -212,6 +212,7 @@ struct file_sparse {
 #define FILE_ALLOCATION_INFORMATION_SIZE      19
 #define FILE_END_OF_FILE_INFORMATION_SIZE     20
 #define FILE_ALTERNATE_NAME_INFORMATION_SIZE  8
+#define FILE_NORMALIZED_NAME_INFORMATION_SIZE 8
 #define FILE_STREAM_INFORMATION_SIZE          32
 #define FILE_PIPE_INFORMATION_SIZE            23
 #define FILE_PIPE_LOCAL_INFORMATION_SIZE      24

