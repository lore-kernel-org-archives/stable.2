Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452264B048B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853182; cv=none; b=mI6t59+w6Yntl9II0U+Fx+QYbeJxqnGyGMTAp5m4pmlK7EPuE3b5OCMcUzx7sXipgXbS4AiFMN/kPWVx9mOP678wd/kPqWakjcdRmcq4kwKRjuaByllmfCq7mLdDdykrHfX4w67r95DdQmPp7QkLSpZYI7rchmhxh4pH3HBQC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853182; c=relaxed/simple;
	bh=HHDceGy99wVBw7g6/6TQ+nFftJu8s6G3f7hwMWjS/1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKSY+xsdj3NCawPenzOQg+/OpBEebBceP+dU51D3KjCASr8wnK3EoVzPTw9dB1/mG1W0jbiT/jO0S4wmRntzCnGLenhvt2ngkmEOKiNBnozwlzUx37YUVueWs8HngHPFHceHM28ooMMKvWPtmJs8zhgJ+OXhGGgu9ZOlOB/umtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=T8p6F2yy; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="T8p6F2yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853132;
	bh=MCTKQlaBXzi++1VNsG3lfOQgcAW+3d2QGwo2jFZrZ+8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=T8p6F2yyssiZVsy5hxlFnrh46QwvLR7pOJ9v4WXzP6kkcExaOZWofQjHUT27uLYAl
	 erSXWf6AneslTyqBMaj09oVZ3zr07NKIuqa8CF/FJDsI4tXFLh3vaNU+fS1IXMLbRv
	 KB7JauqUzX5NDzamm4/o2IfkGgRp8IfZQec/LTeg=
X-QQ-mid: esmtpgz15t1787853127t861c1e8c
X-QQ-Originating-IP: jlDFwuyWZRsxyxddvXOFadCoe5IeUTL4ebqPs1dUSYc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 01:51:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11917769301011810815
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 7.1.y 1/5] Revert "selinux: reject a permission value exceeding the class permission count"
Date: Fri, 28 Aug 2026 01:51:41 +0800
Message-Id: <20260827175144.4174620-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827175144.4174620-1-guanwentao@uniontech.com>
References: <20260827175144.4174620-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MCAP4yZN65pfjybUKajEoaVq1GhbrKbY/KgK0kP+R/iT14yp8GOHIoxT
	RdvjlBgvMBZt6s6chAfJwGeTA95a9jlri1WA+USgK3yhtDvxIKkJfLRkrEOjVL86fcHytRC
	79ry0UJFWdFS8QNEu7kCswmRQ8KuwXvztcFe1A0n3hfDH50YdZGxgmn1ulsZ6/EMErSodXM
	QkgsgBYKQguHflGXgP9ln9W2AVC8W5hUVqKkhWXoggkIkDgDLUJTx/qcAdUUpqeBilqj86O
	poE9G8OoimPvytYVQG5rYzj1x3KlwSwj+JQZbl4kSqd0fvmA6iSp3wmiP9tw9EqmYzhKFWq
	GVMQqKI6blQQuE3PwLDakfSd0Sn4JfGvGDqKU+vd0d8Z5XbUWi/MMq7Xt+FhxqaCChBrcsi
	Ge7BSAljjauRtWfBSab13QJLCKAcFMZYFAojTcKnIlD/4AJGsLMoUH3UX7e3a4j7k/UdYKz
	NVTLUy7iyyjyb8OBwdmYR+b01Lv6uJVktquMdwa++nPZ37ZxxlUk8TqTrlQ2J897xh20cs0
	8vtsrlsHSqu9sND5nZAthOAMpEz21CjoX/0tiwdDEbC2YA1Sa6aqxhq4o9/o/AN3R1Y6xBP
	gpCfwcJTx9WJNmhdWzRaRyT78NVRGTKy0PwiGNtLLiLjQn54i6Pw3NA2i0oo9z7EbRSIfqp
	oAyC+n0oAY6tuQsxdFY1ylDrjscHDprww5wAH7YipoL3khJSF4PRJAnsPnFIFT6NTQnSwpx
	ERUtT+4bcqPOI7crQyL47C7+p9wTbcvOzwzN6jJR3I0wS6GIkGCTtRtsSbXX9tRqxRGeds/
	ZbeHX7rVIVbL0oN6SkyVkxPzX+iDpDP4cwY72Uuw4e4zt9OZm8goH+RlWrdd3+MolEScnIx
	uIS0dzLte1DYC81BddOOgEG6robC81eZQAhDMwfjf1amY3Uk8B4TJ0M8EEhrDOlQmsvSlPP
	mIGB/1nZ1lFpIgL0wABDh5lZVTHPHe7pTz5a96X3XPfxOhuep0C9VFYLBej3X8lRnrKeB9R
	PzBPl9h7qJBtauTSZASXgGigQ4gVrCWKQhkQGfwpLEpkKRO5nPe5fsZ1TCrOegaRES0+RPq
	J0yQQs2yehdw+wVOBIyeAXkt4jYk8xY+uWulTNo9bK8CxJRKXn5TRM9dPV+Zz1TTQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

This reverts commit d81bda85d95f3a2b9eb906c7a818d88645413bb4.

The stable pick applied the nprim bound after symtab_insert() because
the upstream context (the SEL_VEC_MAX check from commit 18fa21f10d00
"selinux: more strict policy parsing") does not exist in this tree.
On that error path perm_destroy() frees a key/datum pair that is
already linked into the symtab, leading to a double free when the
failed policydb is torn down.

Drop it here; it is re-applied later in this series in its upstream
form, after its strict-parsing prerequisite.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e4fa4be4823f9..b788916f5ed07 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1167,9 +1167,6 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
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

