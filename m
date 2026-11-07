Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046748;
	b=N+QP3bPyBnHHj/C9YwfMdL2lMnszjEtPXjVeV1ggNZzJhn4hQPOLkASsoVOx73P1k33j
	 H7auU9Zu3sCH16s5H15uFkdCh9FRsG5JQ8C8gFa0VIuTIQQbm9LGlO3/jecRT5xcgJeIK
	 HKPHBkt6QuyDmsM8pm2S1w5BwvMRhEmGmPjXsp4KujZxkG6edVvk4sntGbo/wk7BtQIve
	 sgTWyQV+DWaiTXr0SeT4PK9BEdf/GuHYJok8eb4E/eV/yOll9wW3NeXpEsGVoysJxwefy
	 dLuIOUwRYzvXuydcSQ5JCUqSm3xZwhlvYgYUIT8mLO+NtWm0sOf1u+5RLw6zEEjn5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V4GpCvEKp0ZvKIT+G7zYwbOAu4Nkp+Qr5jrALx7AM0g=;
	b=1wCMnCBX9mJ7CC+L2qAARSgtZRSZEFwc113a2rKZ7TzMSBgkXbjN4PmClV6U/Ks7aeda
	 kWaY2mugXvfaUcTxO4XJ+5DwITi2ifZ+IApG7xt0Dd1TI909tvzHg7prPT+6sSkcnGPvN
	 bvSHn5+Fo0/pCXY6HzG/dicFvYBRRpxIeQUxwkGE5/u23p/oPojTDSiPjLBhpbP7OY0Ps
	 dowqd3ud5RINj+yYLbeUlDo0UqMAKnLzw4VqgzWAqRsQ7+1Jh2sVmOvEMVJuJNDx44/y4
	 Cmwze1MeiR02egI0zBaxdSVOt1/2hpXy0mor85vTgC26y/Hrj2mtfoSyb7L9QgjJHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COVfvKzp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A56083628
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COVfvKzp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F421F008A1;
	Sat,  7 Nov 2026 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046748;
	bh=V4GpCvEKp0ZvKIT+G7zYwbOAu4Nkp+Qr5jrALx7AM0g=;
	h=From:To:Cc:Subject:Date;
	b=COVfvKzpgxx4tPZhFcMFWHdMH8Oogn8n+TZl/y8JlK8Z3+CLI1T24SrdZDFkMfSs8
	 mHHTnLqaH7uvM/2JWz/T0set66js6VF2ZxenPa/72V9M3FiaxFDjnpBK4lUWDEPAy8
	 4sBQxGjH2/l3fr8HYwVXI/K3/TLZ9j085asCJWwLczvvIWbgvCYPoRSfeMQF3dpIZV
	 3WD+MhkdUXspUo2whpGMvmoaMdbGMV3+Iaa2PYIRwn/spgCNnGA9QuesBT0vLYONCG
	 flUmtv7Bmy9z73yoTTfefopJONSWWhm4tZKzo7u4gy12Oq5MMPeO9gDlS+aX0cx8Pf
	 TdiEJ9HkNOX9Q==
From: Sasha Levin <sashal@kernel.org>
To: borntraeger@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/vmcp: Initialize full session info to zero" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:06 -0500
Message-ID: <20261107051906-failed-6.12-f63eb4ee4a30@kernel.org>
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
git cherry-pick -x f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051906-failed-6.12-f63eb4ee4a30@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




