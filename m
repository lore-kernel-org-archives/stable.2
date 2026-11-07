Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049864;
	b=m/w4vkBAKFt9GC6j0KKV1yOXR5cGjDaaWzaA2d4gbcSctzUh2h8bD1uZ/OfscTIOruuz
	 PJeFWpRTEa2sPsSzmAgXIElaspWsn0eRH3M2AAC/nweUK+gDWPZS1T9TGnJhh1NmkcmPB
	 GnhXOZyTpWSqkTCk5GcqO6UIg4QSNi+UxEtikiebmZU8mzBJuYIgoTQ056uZ3R+VGqyeG
	 qIJtP/8ndJwLjxcOoy/CwgDdrstMI+vtAKlL4mGiRJYUezvZQqtmt3XPRq5McwJPDbCPA
	 gRmQnLSVij7C82aM0MQSnt3RGVVlAPc1I8oFnKER96MHyHUs4aIxeG6zlHSdx6OBOPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uiSUWceEvbxqYgU+QNEHXdcYWBx00TqZDtIWhFNNQ0A=;
	b=jfmqrz5PCtKyZfhNdmdsmQfP6hBgQueW+taUE64hzI7he9hq8QmVV8G2CLsCBrwZVcmn
	 xiqyhW3HRfJwfiQDVVcOO4IV9PuPQ+1jPaHmFhegpqxQxzeD8Bxd4h8zLZtjClTpAI12+
	 5nG5G8XJ0hUZGtcP+l/GHcHEo3Fgewm1u7PaUtTDCEdMrj/+dWAcr2Nj+2MOQ+K5PL2QF
	 NnJdzWqn4woT7LIKHqq/iscKf5dqjGkQfjyu/M50urptBVf/izj8RA5hzo3r/TNAEwqPw
	 WOI+UYjQZbxAgxstSnc7igHJRdn374YhOmMJTol9flZzOW7FnWvw/O8Z/UHavDYYB9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OugEeuWh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OugEeuWh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5211F0089F;
	Sat,  7 Nov 2026 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049863;
	bh=uiSUWceEvbxqYgU+QNEHXdcYWBx00TqZDtIWhFNNQ0A=;
	h=From:To:Cc:Subject:Date;
	b=OugEeuWhqCtIdCmCuRG8jyNnRh7fWoOWMtn2zIY1EjoBH7+kCJ5hLqULRJBZwNdpA
	 54ll6CNnqBy8qp0I0jFjtrWZ8URwu5ow+hA0K4QKzIu92YUam0hojS2NnkvDCaVate
	 QaHcOoWwYVSmkYmQTF5NiwUcgAIqg9Ja4HRXXWy8mhYhaLs+RnqwFibfFep4tHhRbO
	 X4DrqPcJWx6t0xguexHZiJFzH7CkcZUytMX1IDJdm4ldChBRTxhNrkRq5+2DwhUKj3
	 ppZEt15qh4q3CT8qUWBocMjcIh7T9CFaF4SVIgWOEFVxNXZWrfQ5Y90KBfutxMHDov
	 dbWQeB1ljHhUA==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Remove an always-false WARN_ONCE()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:01 -0500
Message-ID: <20261107061101-failed-5.15-cd37a69c367b@kernel.org>
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
git cherry-pick -x cd37a69c367b6a5f685db0ac7d01f08545081a30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061101-failed-5.15-cd37a69c367b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




