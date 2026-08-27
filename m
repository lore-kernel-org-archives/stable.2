Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32093F6615
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820062; cv=none; b=BLj3G174UG6eV4CTddII/eyqvjoAraiAZJJwa7rtu1fv/f+gTtejfHwctVBJ6D60LLZVbMC3fMJpipFRuHgSifm6T/vYB1m5MUY5rMByDgA+iCpEN2GF2w8GWTLqLavY+GACc8PELAOkDRTHj+wZkqOSAH6hfv+Ac6uKBO5GyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820062; c=relaxed/simple;
	bh=KJ/H4uur7rV/C1KvMg8qZtEfyXFQOULg0Foeqf+3pfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6yhykpISiybdnlKY9TMlBy3zxzTQcr8PhGS3f++fKDdEKdoqdJqkvv2STIvcKb5TKmOUGexE3K61jsHUUAOWED53+3VksHmr59M/F7+aTOAshGcfUdV9VBs6qVaxCFTRsCVsfdcVnJwhR7r161Nz0lHCOa0lnjGAdj7ZPp+PQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QLk4Dm/7; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QLk4Dm/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820025;
	bh=nhXNDgQ7+9tvSAAvZ/YxKuqpSnIQUi8hQ2icKPePmdw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QLk4Dm/78zgJ0Qj3KxIQNF4JFGcvDAZO9VNwbeunxP7tBvIwDXEI5/4OkjKAdLBmB
	 qiKArn5lFKhPPRuOBH7Dgu4Nz2oItpknkPj+IZd3/18optQ8WCY/2EdL2JrxXUYAor
	 D7h4EypsTldfgFV9znpzKNcb8gk7nsLUmOcjsfH4=
X-QQ-mid: zesmtpsz5t1787820020t602c6764
X-QQ-Originating-IP: dL+nX6Mjl/tmF12G8vaznkDrfxb6vzcaZUiTneaqX4E=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:40:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9896568804142354700
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.y 04/10] Revert "selinux: reject a permission value exceeding the class permission count"
Date: Thu, 27 Aug 2026 16:38:02 +0800
Message-Id: <20260827083802.4044165-4-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: M4lPCacZ9YleLVFffrnlSzR7GH7xBUO1lyLwD7cI+3puotTTO99AL8BY
	4IwH1OfW8tPx8qUYiQtT6BbLzZmD6jAUT66oJgb5a5rcEyEWTxgWhemAsHY6MNvElSljGgK
	Ed3jPu4N7jWfwRZT8A+0W4KlqcvLAa8hiVJ9kDe/JtuXukYowMLiEWtEFMx67YM7i/wDJhp
	cz0HLseHt7LaM1U7cPkAFp4JWdgSjbYUrhZAiK4EP/F5PpNHL/uRqn/H7i0Laqmsjk/YtKT
	yWJM45dWc/iTURQBp8IhYpiFvSt4411DtbN/WjdB6noiP9vHNnyNW3tvz1X9j3BBAwubBlm
	esd6NvrEgTUfbi48IzKOWw0g3Wrhwp97dpti31ZvMcujsfiZlASeAFOqWvFMJzgiXTCWzBF
	3sYRmmhw7UzOgt6XhsZM34YAbknEyGXu/rZoeigK4Nhnv+23VUeGFkIxXsILCZfXkkWnlKD
	17kh3KwlHjO8vvIXAo6fKpiaGtj2Wt2m5lQjyvvkl6D7djznoO+RTmT++UkBMz3Xs9lRQUs
	6cMP7CqP+tTsQQ0lbVLw+4k8sWHwgIQRn0V0tMKq3+seLMpFiJyNfJfdf31jPJSiac4KBNZ
	yo3ZWtfi0No1JLTVAeNWULjIVYlLAJznZR6Zpk+qzIIJ496JWC7P/VRWqGwnpF50G5DAfjB
	0dmOcHtBVL1J3HQY6HpoBMZt1h/MeLu9wEJDYeLkR8A9bCJR+omwJoSYfVvUBPZ6YO212CR
	wtUpxfEF/CBQoBQmTeoJsf7C2JBYm76R1Fy5hbQDTq+PPA18YLoW2Zni7e3DmTlgidDaiMu
	vNwuEqYodMQR7i0++rPIVfFawFHaXOR68LLRX77TLEFJgtV1AkjmFKLmH/McqST0F4/FFDC
	LHKPMAAVHQi4/7vnn/OEipNV76C5C6O3DuS6vKsGTp1vfqqqSwjZzmq+lOFCR2DeH3DZcPl
	K7fGGGi83xY1zK9YWxNJ/X4bO+APu7RE9yW7rQNgIR1fQnqdFE3PrfxPX9sIwj8vh4hGc79
	m3oSCYZ8qdShAJroTzOhWu4Cn+/Avne3myXjD534oZhXvIK1kOBvkl94Uj8jD9ArKxvAIwh
	im6C6tMqwSBCwHMgd/Z0Tk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

This reverts commit 62be2361da29505d3183da854f1c98d2e208e852.

This pick was applied without its upstream prerequisites (commit
fa79a596848f "selinux: use u16 for security classes" and commit
18fa21f10d00 "selinux: more strict policy parsing") and is therefore
incomplete. Drop it here; it is re-applied later in this series in the
correct upstream order.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index fdb8a62da04ad..69c19ef4b8817 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1168,9 +1168,6 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = symtab_insert(s, key, perdatum);
 	if (rc)
 		goto bad;
-	/* indexes an nprim-sized array in security_get_permissions() */
-	if (perdatum->value > s->nprim)
-		goto bad;
 
 	return 0;
 bad:
-- 
2.30.2

