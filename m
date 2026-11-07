Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050887;
	b=I3h4J5chqS6uuG5/3tYlHVX6Y8IUFrJ/ehvP9Cf3wKp7fQKLc9aFMG7J2OO/RmV4y/QH
	 yp49eRTqMticMgcChHkZ9ufqFz+V2/b27WS67urtBAYnb05N89tbDJLz0NRvjBtg5sVGd
	 8fAdh5THqeQ1F1+Y4F3oNdgeL0D21nrnUJBo6RPnza+5FI8Cue/NCDGffqPIediVkoysY
	 bsryhHIIvSlDXK8M26Xt2aYKmFHx9dCOCdP+xLQuOtWk+6WWUxp4ZAZx/vHb1vwg4+SVQ
	 cxetIxf/Wxo7agJZuLklfbrqk62nlv+zCSiKwHtmyBgCkc75m60+yFMr1Ac2kSeE9cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qnjLQLKGrpB9SxS+vp33a/qXng6JE/jbyDHYL9Cy3OY=;
	b=QnZ9vv5hFksuudGJWTTmCwrEjqI+KO4vjaHQ5+sOndvybM5j0QZW5IZk1BVg3osLDeEF
	 f5OX470l5ExelJBy9IACna/ZpazyrGLzLwhVhxbKZcIytEQBLtgUPV7WpmAhN0/u2A9AT
	 6mMytGkZnWrDlZuhcqCqoA9V+8gEA0Aktukhiw2DMzEMXoCbR3jDE9TZByfXlQElXLvyW
	 S/q7WjD2/lmqP3NOOKY7wDxNlPtZcwmEUMIOm/dw/BKJ8BrWV4piydBhi8+L9CaUNQ1U+
	 j0mfXkKfR9tePsBntSKq1aes1Z/3CQA+GSoYiHSRDDrLjxczK9BgGEqfmA0Ul6IypbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiD9Ia0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiD9Ia0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919371F0089F;
	Sat,  7 Nov 2026 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050887;
	bh=qnjLQLKGrpB9SxS+vp33a/qXng6JE/jbyDHYL9Cy3OY=;
	h=From:To:Cc:Subject:Date;
	b=IiD9Ia0K7setQz9Ofjg1Il4UVZUUsoEuV/zZevw5iqCfSN5+/4vj1qG+cAMf8OF+H
	 kuED2x8zAfsIfWys4XOipcsPIkQa+eqxkUaguD7CZMVFssn4ZuiShoqt2afgIu4rMU
	 JLrg/1g0nBiGaFW4twKtyRssh0IVNb2dJ23+WC8SEoP7HZllX7ytrUFFOrwrhnc7TG
	 bPQfndJPMLKDRrwZyGCscYZxvZtx9u+FdCxpgtbXbRdKfeV/v4kEOGcDkeHsTGu1df
	 nTS2gkx6a8mt/iizxpJsQFDE2eTZJNlQWZIlpa19NtqJfwq2tHCMMOVt4v+bM0pf1o
	 xzc1zaHGhKQrw==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Remove an always-false WARN_ONCE()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:05 -0500
Message-ID: <20261107062805-failed-5.10-cd37a69c367b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cd37a69c367b6a5f685db0ac7d01f08545081a30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062805-failed-5.10-cd37a69c367b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cd37a69c367b6a5f685db0ac7d01f08545081a30 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 22 Oct 2026 11:44:38 +0800
Subject: [PATCH] scsi: ufs: core: Remove an always-false WARN_ONCE()

The WARN_ONCE() in ufshcd_poll() can never fire. completed_reqs is set to
~tr_doorbell & hba->outstanding_reqs on the line above, and
hba->outstanding_reqs cannot change in between because ufshcd_poll() holds
hba->outstanding_lock. So completed_reqs & ~hba->outstanding_reqs is always
zero. Remove it. No functional change.

Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Link: https://patch.msgid.link/20261022034443.3034432-2-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2ba244cf40ac7..f03a8d39fb7a8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6017,9 +6017,6 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
-		  "completed: %#lx; outstanding: %#lx\n", completed_reqs,
-		  hba->outstanding_reqs);
 	if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
 		/* Do not complete polled requests from interrupt context. */
 		ufshcd_clear_polled(hba, &completed_reqs);
-- 
2.53.0




