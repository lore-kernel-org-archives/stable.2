Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046106;
	b=y3YyeFz69cpJ6T6Gokf+/JWleFl0uyJZw+2SilBmqxIkiyEhqfnTANZvq6sExB+x0EQ9
	 sFvt/nioscbhE5O2FpbiU7VUY2Zsx2TufMMLkyuND0MsLJj//Wd8HrRFJOletaot/SmL7
	 5mFvTlokzeJO+vbjxZCa8Imp/LG8IfK991Bt6+UuwXZbBEbY9k/w9l/+oV8F29Rx27+cA
	 6TNvKUHgGaM8deZ2uRdRLXYNw+fb0La+L9s2O6+SjjuAO0QSoTv7T66l815qWIslJEVcd
	 t6hLr+0RFtxXx9VmO4959HWug4U9sqe4GajxWsraVpm/EWL692o5HQKb8Hg7C9/TiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wZLAA1biH3NXdGAfyXCt8onCsd0totAm6vkFnJVufGw=;
	b=YL7/NlQd2l1QrgOggF3DH8Y+fSt/w3KW5reo9Z/ykKqDcGVew5tDjiy6sZU0MDd+cVRn
	 e6eZbjRNDjm5cg6BPYzi+85xdQdwqHeRzAkyQJLSdGbk73EP2GnmNhQKLsOoneoxnmH8M
	 sX2SeTzAi1b4I3jtRKymUuJsMPM0FUuPOqViYdhA4OXwe6I2pByiPWJlVwb25Eb1DC2r/
	 DtK5TUmJLKJSCy5shxLEWjvta3PUhJx3mtrmKPxm7nv+cqcH767Cb8RTNcFr1AmR/Fhjs
	 tzHdqJVW+/AkCsNSbPKjo8nZsmPqKDFS40Nd3PX5v+bwaPk3g2ySiT5biJOSS3MqdWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMjsw3jd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B2606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMjsw3jd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CCD1F0089F;
	Sat,  7 Nov 2026 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046106;
	bh=wZLAA1biH3NXdGAfyXCt8onCsd0totAm6vkFnJVufGw=;
	h=From:To:Cc:Subject:Date;
	b=OMjsw3jdR4C8200sRdx7E8i+GzQlLils8uEgf4BafIkEC6197fKkMgLyXlEMavR/I
	 yljTPcUuTyuISWifGRhiG6ymrILmAKlCmlsMjDQI+u6Zge52hpC/GL2Af7qCqPWuR6
	 4N1sVDPJu6mZSDgQQ5TDZ+pAVM4PAlnAhcUQ4iKBaEN92LofAwGlMqKoR3L7mNESam
	 T0G1ZZvD7vd3JnrsgCMH+5KRXvW5SQ9cgxxBItvC92TtL6exZrgR67C87+hTlwqBEO
	 /hJHivPR0yGJkgbUjo+ptGbKmxv4kAlJFefTHtNnLV/v1VKdMJTCuz60bRjtKar9BG
	 9+1LNGWbJoFFQ==
From: Sasha Levin <sashal@kernel.org>
To: borntraeger@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/vmcp: Initialize full session info to zero" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:24 -0500
Message-ID: <20261107050824-failed-6.18-f63eb4ee4a30@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050824-failed-6.18-f63eb4ee4a30@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f63eb4ee4a30fc5d8de07a229d92310e3c8d560c Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@linux.ibm.com>
Date: Tue, 29 Sep 2026 15:58:29 +0200
Subject: [PATCH] s390/vmcp: Initialize full session info to zero

The cma_alloc bit as well as the response can contain old data.
cma_release will not free the kmalloced memory in that case and
the response code might leak kernel stack data to CAP_SYS_ADMIN
users.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/char/vmcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index b277f9d0c321a..2cf94f23af2a6 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -104,13 +104,11 @@ static int vmcp_open(struct inode *inode, struct file *file)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	session = kmalloc_obj(*session);
+	session = kzalloc_obj(*session);
 	if (!session)
 		return -ENOMEM;
 
 	session->bufsize = PAGE_SIZE;
-	session->response = NULL;
-	session->resp_size = 0;
 	mutex_init(&session->mutex);
 	file->private_data = session;
 	return nonseekable_open(inode, file);
-- 
2.53.0




