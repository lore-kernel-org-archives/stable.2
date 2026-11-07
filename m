Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049340;
	b=Zbt6f1W7yULiVnsJEqomWw8b9aIgPGjnWWEiBlEf2sByRMg0j+FWPFoXVb5m3Iocx9jM
	 Y573PMkAExssGQStUoAlG1+pBEvNKnb1mqCYma8aE/LUPNCdphwRLcYaUSbOp6JFKqKXY
	 IkK7wSF+boc/1MK4faLYPuI3BDe90OdlvjL7QQecRPOpNdFptGSxhDKNKKAvY5ZnV8BK0
	 aqm/S62hSSczqY//AITc3ZhMgf/odx09kfVUvmvMb4RscrogSVjUS2T2Fb71VLs17eYY1
	 0VmZvxQDABNWLztY8CzCjblU0mg8Nmq6DP51BIlrZYlopNJBUtV5b8/Tb5f5tQ3Qfnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UiCoEPl/bHbbZhcYftcl8oa/x1qfprpjkPJ1vOiK/5s=;
	b=dFRQorhuPFoZnEIWGHJULEFMvBdq2Li8lY+glhZrCAqWa0fDvp7AP3u17yFCYjfjr3D1
	 d7/tl2MHziQSXhIPe6pDv/rmsMgjFJ2ncHmuXQPzJZ7iikF4dUm4lE8afGWG0y9rVuvyF
	 GupGQo6Uuwpted1uSm4yKPm9TTIUIOj6SX8GW5GG4VKd+5Y+Fsxw/RDoUJ+fdRS5Svpsa
	 ybgcXK6IQiCJLYx5uEJsU8S9fDh2+9IjKwhyWoBwKgmW24Dk7HzwQ9WcXV0RmuwFwVxFS
	 hUY0/j42HGyrp16V/mkuy77Pp6RduUcDn983krcc3defmIWWIfc9p81/Wwb/Wax95sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoxoU5iq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E81606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoxoU5iq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E561F0089F;
	Sat,  7 Nov 2026 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049339;
	bh=UiCoEPl/bHbbZhcYftcl8oa/x1qfprpjkPJ1vOiK/5s=;
	h=From:To:Cc:Subject:Date;
	b=QoxoU5iql8Mo8rRX1iupA4dDYyTNISbvPeV6J4mIvMLwva7M47rt7h7qb1eRzKLWa
	 UU5tmRNSRWl2ZRKsI1VXuN4GpbUWk+c4KRtGTwFjDSa9TYzOyYOdUWDX0qBvLGDwu7
	 j/Gob41HMaYKISs2dgzLMS3fuNUTgIGAoTosNjEUz5P3DFKgFofYORiaooG1lXNJMW
	 MN44iuhcmpn1mv65sjV2QEcHj/JCJUVIPAjfJhr8LEP8xzv5l16H7tB9JVAPaUYZnp
	 A+5AfYYlAMFhPMBPXcM62pBX4tMx5uwFRaZ/BJJBFq3G9t8dsZrwmdD8FnxCB7f5j5
	 7gRFupBkJROmA==
From: Sasha Levin <sashal@kernel.org>
To: borntraeger@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/vmcp: Initialize full session info to zero" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:17 -0500
Message-ID: <20261107060217-failed-5.15-f63eb4ee4a30@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060217-failed-5.15-f63eb4ee4a30@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




