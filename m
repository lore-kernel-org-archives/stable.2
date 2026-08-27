Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D0314D34
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820110; cv=none; b=fGRdFYH/uW373/06IjYabvD6F5pl6n0n7r3ajQThAG8iiZZNrrrqDD2xXFpXRzBJCfLAKkb4pCePnG7fVYj2SKumrSkWx1aOEOrO1vsH/RqQHLMfB8TRMeypMqLhDn/A7FJkyMeEShMpgK/BteEDiEUqyCdJQnjb4xl5wD3truY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820110; c=relaxed/simple;
	bh=JORSvsvygPMj7XOGpq1vadI7kmpYTNt9/Y6ECdrvFhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7LD88GhjYJhveRWTYrd3umlkIIQ4kqr1VYwAn9gEV6rU6TebeQcO4btVuA/Gz49Lgw5mxPTm5UML9HiGtnvMLrhOyoJNRg9WsNIXRsPJ4VHn0jmBf2r8HOK5BZ1ByIeoDNUxRhKUDI7yrnkPaI47RXTaOt7HiSjjoQbK7gr+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=M23dz2pz; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="M23dz2pz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820070;
	bh=xqurPrAdU5E8WoOV9DyRFkYq5eDBFYEDsE4x8g2Dkks=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=M23dz2pzcUoEpL785qCykM59EfkKOrzAQwGWxAEsppDR8niaxGbaVUSh8DupkgAzQ
	 99+hZRKz3+1yfyvvWjnaQ+xlZbRguFf/9K9BKtqUIGJlZ91MZl5wgwFs6bynHAvXBw
	 MJvF5KawFZ5GroQN0NOWS+SViCociMp8iZFx84vk=
X-QQ-mid: zesmtpsz5t1787820065t4f625f98
X-QQ-Originating-IP: T9xgXRUH/8xlbnIjxVipfildYfti+0FYbzbUzL8/VzM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:40:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6292414292233111484
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.y 08/10] selinux: reject a permission value exceeding the class permission count
Date: Thu, 27 Aug 2026 16:38:10 +0800
Message-Id: <20260827083802.4044165-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827050834.10002.stable-daily@kernel.org>
References: <20260827050834.10002.stable-daily@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NFVb9DbYE8xiCJ3xLUDi9Y5BrnROAEg4vMaS7r4lhg0+o2qlAsf20+R1
	bc8akwuLIps3QEmJvHtD/5+a6XJjM+HL3TSkZlWSqmR7bY/fP2JvMtyLfyUSG4n7yUUSwY0
	XkkG4LIpNM9Pb8Wt4JksCA6/OcUicsYZFgApBtsrxBrwjZp7Vawq2V6LmC/G5MObz7IWci5
	o+eiYSsDiBAyqjMjtj2P+VLYKaP+7Lh7IQbaejSHhrJ33udRUzDoAXJUIXNelkP0Def5KBP
	mDHzaquMKIcW+Rs6lVKfGNuBlfXSdKgtDqy5RVGWm55C2FsB3iTm0WvdVYUS51FYlZg9VsD
	FnY8bN6ZXQMHI3EKb7OVXPs10bR892ULogz4vVpCyFk6N37YxlNcH1sBev8itSkBayeuHXH
	1AtbyaciXIYbg9JhPhx2d6s/8M+pkFLIbll9Kk77lySOstzQ0pjLcuhh0+9OPGr+hGiSS0B
	bW29KjMvKFpVZkaFQGSheR9A+UB91KAbHFUz3sopn/3YR4G0L4jtiSSybj16QFNOGJsMMph
	dNQ7txPqcMGRoY3ZqrR4DuOLKr3wyMmtdQukcaK1+KjDgcNvnZlKJ90fAi4VGRaO3DI423e
	Sx4VV2bpuaP0IdF6dbg5Py16xcAUlnFjiP1US60KAIwpUW8lTcEHxO9NbEsbnmjYRFvT+cc
	n+k3C/FruXBqP+GTt4SjK/bgki3L6PyLbivoALPRYRef98Kw289bsRLv5JpsLrszw5VUNAZ
	lE6JKjtb+mpuv8dXXCo0WkAtsh8JqVlhQQuTNuL/O0kC8ZNEHzplWIWCcZ7XcOkzE2taxuq
	wq1tQPh/rEY3VcPW2nXz4Su1KsjnT7wEOffip/EgL08jIjX0sCKFmffb6Ei8zi2BuQg8PEn
	n7fgKI2qEjgvKSnHnSOs8kZSQVJ4wdEDViCmLZ9tgaUKMA7qziZI2ClGoWjS77b9o/X5D37
	cgSZ4UrNt5jdbi6Za2xxqlZiIqZmc5sdjNQADlqzGEjs3I7OsjTxLOz8AehxNEEQP6o5B4q
	7YjwnL9ncGuLbUqrseRNDksDvCs8YACLu5/7MKW924WviFs+RLA9Ts94wfjHx9/dWqowEro
	E7rF6JWzX95qm7VUxLAm+pgRp0ZdjQZ5KpNJXWZLJR3Mub1Nya/tvJLRkvYjBuUjgjVBLCS
	6l+kormI0W3T0Anz7G9C5nxIrRkFrvjxUGJDEdsteB2Tl78=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Bryam Vargas <hexlabsecurity@proton.me>

perm_read() bounds a permission value by SEL_VEC_MAX but never by the
nprim of the owning class or common, which is taken verbatim from the
policy image.  security_get_permissions() then writes perms[value - 1]
into an nprim-sized kcalloc() array, so a class declaring fewer
permissions than its largest permission value drives an out-of-bounds
heap write.  The top-level symbol tables are validated this way; the
nested per-class permission table is not.

Reject a permission whose value exceeds nprim, which is already set when
perm_read() runs.  Well-formed policies are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: tweak comment for line length]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit d14b5d0e97fccd27974fedc03b903408872907fd)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8dc77e347a77f..a3d52beb65487 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1160,6 +1160,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = -EINVAL;
 	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
 		goto bad;
+	/* indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
-- 
2.30.2

