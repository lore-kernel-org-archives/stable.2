Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047498;
	b=AxOPoZv7Levr9LWn1BlZAQyZASCVa35W3lccT74uvDv1liQUnrcRle7lJ0C2GllrcsZ3
	 +gRQ9fABiLBGC//58DLSh8nObc2VDpi6aqWCtcwXrqLazpVrbndA2PdhnoLIRhWly+EAz
	 HUhHWKuIwPwVjfxSAPRQnIrGdOMrD8oXPeHEHynQMrodYb/PwRbh+31QobwmvECO9sFo8
	 Dq/uSNHijC6baNIyqLGBI6MitXSOChBkGf0chynrQealJWuv2p5UEJDj5M0MAIsPX5Ru9
	 0Pdmb4Y5lGlE84BfN7t92lo9yMC6JiDa5CZwj05nXcLhNfNdPzGG1zESbd8u2CZ/DTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yJFzzKWHa2b2y0CvAs2RBSZeRauyMDdc9jDSobWtZNw=;
	b=lr5v3Af0tHnzR3OTDwLg3Mj0WpAf6KdeYCVmV4BnY9uHXRT+DEMtxMr1UBBIiL0Y/fEa
	 9hytjhQ94Kvwz8ACozOO2slVXPZ0GvC3jP+PWUpUYSZEHxzswmGMkxt+odfx4QY5+9kkI
	 kYLTIqKPXoR33P13ryI2pYsJwadPJqgEl0bkU4BHKzzeCiaZDNt3Pr2po0kWTsDtwAvBR
	 cKf4M4B7672ZbXB60f2P1hKaPzKCM4m2EBvPIF81OrbLDKiXiEsxgLF6hQXiT4CyVA8aM
	 ek6qiaMKp2w49U5QoPK8mVkAo537Swu4NCgncyLWHOAHtm3JVKiS0K7rxGmFE6svkYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRKB6vF9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97429606A339
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRKB6vF9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D131F0089F;
	Sat,  7 Nov 2026 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047498;
	bh=yJFzzKWHa2b2y0CvAs2RBSZeRauyMDdc9jDSobWtZNw=;
	h=From:To:Cc:Subject:Date;
	b=BRKB6vF93KqYjIuaqQzEeRZk4L5nieHMqYO/6YYRPqmH8DDqcSzWo8+BKQo5ACyRy
	 xuuWqDiFNJ2Wzi7sljuFW5/Spfqh1v9XRjmxH5bAEzwgCCYMc6Z79MEtYdvk2F9iM3
	 JZR1xT8OVyhfxLw9KkWkRrY4qvruCbMjiFWNkq4R0I1XH84CMZiu8Pxc4v79Z2p+Lu
	 Q/vbuunP1EPsL2yS7lYIJJAj1mSukgl6CduCLe6PKSU93QSOQuGYByNl1asqyEeOc5
	 JYsfFRjjJRMTXjv/U+bzM3CW5lJ99KZfX1wYq17p3dBWfwsi5sgMfq2EATjPKCaZ6t
	 m/jZxLkFCbIOQ==
From: Sasha Levin <sashal@kernel.org>
To: borntraeger@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/vmcp: Initialize full session info to zero" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:36 -0500
Message-ID: <20261107053136-failed-6.6-f63eb4ee4a30@kernel.org>
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
git cherry-pick -x f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053136-failed-6.6-f63eb4ee4a30@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




