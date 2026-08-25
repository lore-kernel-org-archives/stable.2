Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20C3E49DB
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652327; cv=none; b=UULSvN7Kppw/RmlvxGO8Slsp4TORXHSZQEoOckJ7p/x07ZCdsju2UCV5zcwTXMKgCkTrbITVLn1WGvDPiLckRJ2xborGu8MAtdiAnDrgnantyBq0qZWQfvnsNbIbkCQ3f6I3Dwx/J0yDUkX5643sVkiOgijbt0/QAcmi+tXWyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652327; c=relaxed/simple;
	bh=JORSvsvygPMj7XOGpq1vadI7kmpYTNt9/Y6ECdrvFhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uz20XV5eQyLl29fXMVTiRMriS9Uql4MB2mzutenRAj0V0GT5ur7tXGAsH5sD7nuHCh8/LVHy7rPKcFsYeOKJEqsbBPx7hvbl6XcKbdGyYsDHGPp6WiDj+m3J5InNTlBByn7QS1q2jaqWPxG6Hy751JzaJ56ON7fhON+Chfgk4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HOq7Apiq; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HOq7Apiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652285;
	bh=xqurPrAdU5E8WoOV9DyRFkYq5eDBFYEDsE4x8g2Dkks=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HOq7ApiqBODcaa0ho5nO8kJWQ0iSavbKKMJECviFLQoTiH8ZIijq45eZPi9rrB7C5
	 P1/6roIikIQq2m63KwJXg6scJ/cCuWsI/H4G5TrXccJ3o/4Aq48f3X7xQr8SvSd8CW
	 k9HMRdn4MrjULyskA01wjo5Kjf4pvLss8yBONiVI=
X-QQ-mid: esmtpgz12t1787652279t05b84636
X-QQ-Originating-IP: CEsIYq76kTOWMf14KAQjn/B2FzR91HBHzIRxLP5ePSY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:04:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7360740267623946364
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 5/7] selinux: reject a permission value exceeding the class permission count
Date: Tue, 25 Aug 2026 18:03:41 +0800
Message-Id: <20260825100338.4039846-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260824220022.435960-3-sashal@kernel.org>
References: <20260824220022.435960-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OQDnMK6ucigbu9epbsn6lv2tMCiVw1M3efeFaNAerhfHMZz4/7BOTsQO
	X3DO8FEAcOz+O3PBIPipKnXsQ9UlhMTRuzAA3fRgOXhdpeVScKEwkYIl8nI25UbJZaX2KJm
	17MTmMtd/yqJ3z6FlksIXP0HGkUzj/LnUQBdHZ9jfAE7WP5g7HuQ6ur0vRpKWR9cW7Jrzi4
	fdYUT/6gxJIRBWurnEMZV9KDhMXFIoF9aH+KqdVrE4sPPNQ6VqV4P4ExveFSvRrGdLACDO7
	hrlZJfRemDM0ZvrI1dFHugb1ozNZ/tX76M48y73kiPIFWyXEmPO0lJiO9DwNgG+0agDjjNO
	kvOZVb7VPC8piiBk7+/hFsWhi5IblobgAPjDncwDm9te62XO7JYguQCt6eMYMSPHk7p2Jtn
	sT27zlw6QIC/Liw/t8UsCBlkQrU/1qv65xO7nR2bjR8qyaYnnCnKuFG9MMRt7uAZ0RV3d1h
	QP4vit+dsqbQFTuT19mLf00GSJq8RX5LT0SbO+o9kHTVM1++qjDuIZSDdbbuzcqkBaZAMQi
	HNPCbuK5tYZWqv2fn9xh8ZEKfeXy449Lo4sJSCVSgJRuEbundpXy084dUnQfXnCKqpuysAc
	B0MFku4T6peFU5wzN7vUaGrtg+T4rkk70r4WK29WcIL+2QlUGkGvC9jveRHLgocZZfXyEQ1
	QdVfPT/V4afqTjsGOpLyO7PZwd5dJWMPaVo07rX3FNFs5t+dS5kpSeYerrvHXsEhgho7uC8
	VHeEk4iuHDBANOihlWbQsw5apTw+zS0O9uskIae+so/I0VhiF05pRaniZWRxG6HePEZp1kB
	AcaTKasvj8dmhylEI2us2SOl+dociEOG4NutC7+NR/XsyUAUC4NHhF104E160WlK/pOHdYY
	0qbHSSe653nGuxvuPByDb5z5iXB2M3u3itFE3woXzY2JN/aEaE61eCZ32NJtIwpDNahNfGN
	4Zc0xXcXAdWFVOv6tvgaYR5c821BJ6Zrp1jrO+vZCU3JT7P9GJpK2+vSPv0iIccUDV6jKCH
	10qWD4rNLjgh6rau5sBvfsZZ92hPzLyRX/TItpxf6OsBLQBOFna1JZQ7hQycWsZwGL+VabR
	dbItQESgrse3fAwam5ueRjX1l5zn+Tbkw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

