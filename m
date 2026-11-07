Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048267;
	b=qmkEv9yUv25S7E/Z+9G4Gr6fAEuHo6DuWkhsde+o/nLjPTD+aZM1J+AJrAjQGhucNe7z
	 rjSEb8rtfEuJuffExxf84dKnW0BO8iUXdN1dri+2uVEl+rqFXoufYhEuGf7QXWy1dzT6n
	 Cm5z1pKSEGiHMNl8SpoUvja9RrqdElNb5siBRipMs8ge3m7OmiXukp2eqzmkVk+8KzZeu
	 jSAIxVOj6XohmNeY2H/FLGeUWAVototpCBZ+vQ0atdAGAYbgM+1QDQwVA43BvKqWJSOf9
	 IoPAWpVSTvYxibqvrWN0tjQ5nE1fkaXse9FjudxEyvgQf8Kx25aQyzrDvoOz+xiykDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048267;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QNr3nlKv8ksxa69hUumTTbC7ZT83Tpi8K5zPKycQgdA=;
	b=wkRdShjUWAH8AEOdf0s9LGxIfFOfhNx+g+MbeZiktwCzWzv2JzKVuPFgx/sYOIVFiFWa
	 2hmFuwJiZwLU88OyyVhC8LI9dAXe9LudNhqLrki2FgapL6elJtR6R+rl3DpecBrIMVltr
	 663vaUTpWejuRX48bz7fjxnmqbzog1YGSa1ToyOWpiVVfDguM7IMVzOzMJajAko20zMCR
	 0J/SSNc6Fyj5W9AzrkhMijZa0/nk+PosZMe93zXp4aMsGTBHBLBDqXDsCf9p1gQg0Rf5E
	 lvznydrJRRj67PyqjunA8W1kwj3yhuaxBqJS+TKeMvzP/vk3vkxNg+TSQBcj9HxswVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwqU8huc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F31606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwqU8huc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35861F008A1;
	Sat,  7 Nov 2026 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048267;
	bh=QNr3nlKv8ksxa69hUumTTbC7ZT83Tpi8K5zPKycQgdA=;
	h=From:To:Cc:Subject:Date;
	b=KwqU8hucLvB/6v9oEaPfaELAYuPMgIzg9WeDHOPN4p4ogU+P9rZ9amyDpY1cZ2ATT
	 vgpyQ3jEWrLvb2T3sST50ip08rMLfka6mirURQWHohkY2qyDFT7cHaqESG7WWNrbc+
	 zZx8d0/0n58npC42Ty86XRyjrjjSF4Ph417h30sYUBFk+xdrM2zBmCgizDYDHJpz5z
	 Nq1VzoV6gEJ9IqU5daAp5ri+kUud2yLeIFOYI4Swp91jnzDZc5ZVyNAJDWfQ0h7QjV
	 9tpEXxGlZk2igX9KNRHFv6HDJhcmnKhxfyzbu2Gd4j/837KxIerjLxgQjQN9eGC3hT
	 AeulbPMyvOjJw==
From: Sasha Levin <sashal@kernel.org>
To: borntraeger@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/vmcp: Initialize full session info to zero" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:25 -0500
Message-ID: <20261107054425-failed-6.1-f63eb4ee4a30@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054425-failed-6.1-f63eb4ee4a30@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




