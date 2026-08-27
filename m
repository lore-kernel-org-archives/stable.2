Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388913033EB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854025; cv=none; b=ldPtLstqB8BuuCCtUAGuY8NNvf+ycaaTisYihVbiKm8ymlEQzpAiMkRJcSeF9cu2fBGyo9waVdfTEhFsw5g1MhN2qmsDBnyn8PsLOhiMyDDpW8oVHV17lWu6xAKorD2d8fquAKEdlEftYz/na0Ss/6CezUHVZ6swMn3veU7CaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854025; c=relaxed/simple;
	bh=J5q7ji+ph5yJ/ttBggqZ5OIBoe0jb6ssZOGHeYcZ1lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/cfQSH7QAKu8VteFp0YDQYfM8qPFlO6aEKwMsLtdcOnQ992orA3UFGtXog8vg4dlqbaVa4PALp0tt8mVBulRoFbIbABzSLcPiD/NuHMK2HPpygyZVi73akNjT1IeOXkaeTfBxgv7AET/3qPbDHgUHfkx7SHIYfjlMv/7fe584Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c8aqwogn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="c8aqwogn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853992;
	bh=bA9JVPMh7SB/JxigdeSFHqh14laKSeXhLv4s6GvrBz0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=c8aqwognxFu/SA129ClACK+2/tInXkUr4St/+rchHdqmzSKghRyddBUNAcxcz3W/4
	 Ss7jVbMvmnOpdUV2lcegd90b+KyQf2gXJE9XOAVCnino9gcks41orvDEeFoyL+Z0Q6
	 VL33OpmX+MnUkAsSptQMId+it70KMDD9YFdje5Os=
X-QQ-mid: zesmtpsz9t1787853987t40ab3cbc
X-QQ-Originating-IP: P+SZ6ZUlKsVf+yDh280k8B2Mptx5a6PlSNH1KesAS6w=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 02:06:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16530772137802749702
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.18.y v2 1/5] Revert "selinux: reject a permission value exceeding the class permission count"
Date: Fri, 28 Aug 2026 02:06:02 +0800
Message-Id: <20260827180605.4187309-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827180605.4187309-1-guanwentao@uniontech.com>
References: <20260827180605.4187309-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NnQqtXtcpoHJcnj27G8OC+SyncEsg//GfM7CYO+fDu3ZGyD2NCNcWW7b
	gUxQVA7vNcuAZp56wKZKXa4OHjxeZm9veX9588jijnLHdt6QRpMjwbrSUn0IoWyScia+gnL
	6RiowkKXDDnVUaKPcOerqwHUoQvzMLE2LFCpZNVaYx9vho4pvio2hhSJ0hfFOA3yFVdBFHJ
	uVU2u6HUC9KLiaSf+JbykcYarDd7PmcucPOQEWBcbtljkQtMkNtznw/oHu/veNHPq4QAjI/
	T3SbtuTvubwZMVES+Lh3wvmhXRe6mWklXVuwc5B4btIx05WuxPqoOIpbkUL1CBaEzmn3aAh
	uvvR3gGFG2osNUSs+0Tzra23gK4fakM2/h+Ou0uhEvTNuJGtZql+waonz5397doZszaBisf
	SiivyhnmkOpj2uQtop6LfjsuPajmHr8eCsR5p3l+xVy1a3aUTDGcFYl0PPwwgcMAWOtaAu+
	Mll57hVFzxhn4CDGv5waSEKWL/xwEv63L1EwkfVq6IWC2g3Ioa85Yb69zW3vKUH7IRxVuF/
	8WhYbiL9fzhqXbhNcVlNd5spUBUxnkV5p8RejObzrF0RceIbIFkLl7ViloV1FkQvXPIgBeN
	BiWuL8rtHfKyyE8T9kLb5Z+JJbVfspZ2Hgk73i46OAoKOYge9TM17zu9yVPioz8R8XoZR9A
	xPT1g8COaWUTqBe//VABX9oFUdZMALxWmRrU0ITQ49M7v/AoR4Poxt7rUAFh0bhnv+xXZN/
	8z7lFhYOSG2iMU4GR0t9v2K1KpnVBut3TMxEySDjCDxClJUqOPC6054hMSY3WejdXLpPo24
	m55tL7l1uSI9sD/iHwn+RxSscREWgP4chpcFB5vmIiuI4vIfgiKx95Rw1bTBcZz9m4pOMoI
	uFAeu+OKTFNVdmk8yqJUeL+MaTF0qHNUKtbP1wB27CM/h2yzHUjuRy/77y18B5q6V9kLVUF
	1dcxvQr88t3BtJZ0ZQFJJjVmPuhdP7XefU6cktyEyoNf8DQkLCLS5cygF1Jn+ZARAaTeaYm
	MtF5yDJ/PVVbSklLA6aMG85dfzA79wIXnxkmXWjnWP11sBVm9s/AFBdHd8Y3Y8devAflmW+
	IXNmc97kH0HCK2cgvnAAwD9cUy9i081EPCEc8t2egkzlWkHajzFBVW0bGA33hYdVaBJu0Rc
	DXE0buQpkcqqI99GCY3gkwFgnf8KG8NSjB/keLoAPCJ4R0FwT4MXXo8B1qzl4tgrGtIp
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

This reverts commit 9b46fba7528f58ca09eac67ec7d474ff1e9af066.

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

