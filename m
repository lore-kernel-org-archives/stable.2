Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050338;
	b=QiEDop26bKgTgvJAiY5CEo3aywLglMItg1mGMn1tyK7w7osp3xuHyW9dkSBSniUrFA2P
	 tQeMRgI2Mbryw6OGYE9ltBdz/Pec1fnzmThVvrpWHI2F63dLpQv6H8r3wHTfvC9u0HLVN
	 SVO2rLEXjVaYHPJKrEJCJmtqeegU132zja52o1sDOsEltFINB0X+YJJcZBqmPTe1+jqJ5
	 2YJRhSNAUqDLYNr7TeqQ2gLao1qtXvAXD5A2hcIWxQywgdBjoUsDKmh5lrZgapJy61EZH
	 jlaYJkvQ33XEuySSumvIN7eBsyslY6J5yMf3yYCJ0X7gs1NVOuwFkFq/ytycBTs4suQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=geMcUi37wOHSVJTFgYewwcfAKaFHlW/nBV7gybm/kGY=;
	b=ibrDeZXqq+xF05iYG+uo2c+dmMvb/wGioTNfaprUX0k5RGWGcBHetoPXWpD3E/ACg9Ap
	 1OC1f41yYXJczxaGnXz+Q84sdAEyi83nHmeZLdt0WB60PGqMO8rrfJBbDBKoAKzfH5hWX
	 rFY0ZwmW02kDZERAXS5jxC9+gN/uUUw/cDp8jSNiAxgWqSB9Y9kaAFBYesoX0DY1rfgTp
	 4+7xC4ur/7AcIN0OnQNHnYd7FSFBTzW8KdN6vXwNPmYWcZsYyKdSLFNWLMhl9mxExdJj3
	 mxha2FbHmuLkyw5o7b3zhTlI83DhONIQdf6XoRnpvdEY78bsFkWkIfD/tynG4S/033A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVsv68ay;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVsv68ay
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755731F0089F;
	Sat,  7 Nov 2026 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050337;
	bh=geMcUi37wOHSVJTFgYewwcfAKaFHlW/nBV7gybm/kGY=;
	h=From:To:Cc:Subject:Date;
	b=AVsv68ayNEcOJ4tpr8sHbsJQ7TLjvl4eXG6oXVZmE5Qt/NlaxNrJTw9Sfb3hFr8zJ
	 3jjWBf0pj0jtyPcawJA4QBBECmW5U0cAP1C7uiHnW8RjExsKNLV4Q73+shuVRkfDTT
	 +6l4V3/OSnJ0pfKYr9z485YwCl52akdlLBP6YE7eHHDPLtzVw4nND4KmxZbGrpDAPH
	 rCsrb36w520vJCTrCGWKUg29fLj1slRnvJuEfc5Hrjh1VC7jhQ4q6DO2yVMQNuQN+G
	 SUWf/9/DSzK8YiFAF8o6QiEymrr5tOTBI1aSXjlLl9LUGqgQ/hcphHjvHDtSeGZ1Bf
	 fFSmUwHt5kTOQ==
From: Sasha Levin <sashal@kernel.org>
To: borntraeger@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/vmcp: Initialize full session info to zero" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:56 -0500
Message-ID: <20261107061856-failed-5.10-f63eb4ee4a30@kernel.org>
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
git cherry-pick -x f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061856-failed-5.10-f63eb4ee4a30@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




