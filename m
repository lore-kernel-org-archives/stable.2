Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB21A6816
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652297; cv=none; b=CBnHWEVMfzq10gj7E7YSf/RzsXbihZaIrv7KgngmHjPCvzWZoZAl+TlmbX5VCUtVins48GkrYBdSo5THw+3mZ93/ZZ6pscJ1EL0R+BFn6OA1slCzObC6KELIDPxzjB7G8hlarMhzGIBC8nLh1bt3I0FlAUgo21Ikqcrrti2s8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652297; c=relaxed/simple;
	bh=KJ/H4uur7rV/C1KvMg8qZtEfyXFQOULg0Foeqf+3pfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7rOxdO03BJD+gcYMZpBn/mThNFHPl5qbpC2HODbuPp7jPn4oxUkB6obmnHfgpWfY4O4OgEa8ZjqADc1gWz/O3EgDki2CyEka0EWYUj4GvHSkiqkhPtQBMejMttGbrB4auoKHtDJiyZEHQzHiMgbgtY0Ujsa/KHRAlAgc3VgZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZfZZTmJi; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZfZZTmJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652235;
	bh=nhXNDgQ7+9tvSAAvZ/YxKuqpSnIQUi8hQ2icKPePmdw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZfZZTmJiLyrUagQYiiKe2zoqC/HOVWeQhfhWyJcjjjEI5Rhs5EISswCzpxZrhueFd
	 0GtxNrVsPTNCzfjeP+7wniJhS6evjge/2VzHjsvHT6mdi28U5b+3Rate0M3mJOgyLe
	 9zPCc528hm9QVf4E6ZkbboGPOrlEV8IpfsDfPlTg=
X-QQ-mid: esmtpgz12t1787652229t2aa0dd96
X-QQ-Originating-IP: 2tCWRu+OvQZpJdkQ+XtornQ41UUrvkllbKNO04qBmN4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:03:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7579593495663742923
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 1/7] Revert "selinux: reject a permission value exceeding the class permission count"
Date: Tue, 25 Aug 2026 18:03:33 +0800
Message-Id: <20260825100338.4039846-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: Mi0NhBPPe/4RLuY019CvgeKOKK7gbuH5tGey3xIE6NLmMykjz4oETQz4
	OWNYtlbn7j6cEfU2vkAd8fCluF5fFigblyJTXyb5FdO8hU4PSAmrSB7ZGoa1TM9tXLKH4x+
	rJ9iCuywEahxBJSyFE5kKpjAe0Rs08pBYrH5pOyNxeIn0WkviFR1/4ZkS1tV4lTcwgOfQl3
	Luc3Vel8agEks3fVIC7wl7+uBIc14ukqkkuODy7XF3Aehv+C8f/KbqB6KzHGOmx38XYDkhC
	VyGFZGTvXF1ZAtzeF5wH1+3FaRuV+XjOFA/ZWo50Nf4cWsQ8eQnIv33fXPsPEHxZzZafrI+
	FdvNhP5SJCjjSoHX2DKPa4l4ftgN9K5oKKVLzYJwvK6F1wP1W5f74h9eIl9513Nxl8pV9U5
	/s5dRqjjjOldTxDpq1zTZR+Dpb1WrELxGP/a97H4atwU2PuL39yQ5O/9SmWOGf6r+OG6RSt
	hA+0hsczRIgQnaPHa0T0I/paug3EgRmDDckg+RIiMIXY/13sN79W79ztCjsIvnvm26r4hij
	CZSlrW+gG9J4/O5Co6AnVmJ1e07xDWrt2GM7D7ZpB4eprUD/Rn1ApxO4lcU6U9w2HMMiNJa
	xY+PkV61NBbniVfcC2xBoLyXUKDSMI4xzvKRTAJGDnkofjzSQo48zm5mzXnSu2pg0CQJZr+
	u7cQx7EXwc+IWG/z1CZ/2tsXwTzoDNKd0VcXcl3aKKWLCGCcJN7vrQvxIzsph3PO1XtWMlu
	Oy18cKPcD6NkfDd11MibhjM363ecrteo0X6pUzrnP3R0iqgeg9rhacAQar0vIw5GQ+dvws6
	F+W6GDHi1DKyCz+KfY+847g6LZJt+yOyX3G5pACPEaZFUge5cKUIAlib7CPy4T8TKFPO+QF
	i0ZzymcQ2Y/Ejlm9lhTia01agzMGNvoMfhoyMEr9Qk5Gn2kNUX86k9jIq/p26rf/hyIS5SD
	FLoMI25yRbdIUXuNlWQDH9I97g8sNl/Xl8Eq+BB/WN0877Ea9bQM+RX6tTa6XaTobFlY8L7
	JAtx6ZbbSeiXWpnPOCouQy33Pyuf4cg/T8tuxfJV6UPCopGobuCB1jiNiucJ1ijTq2q5zSL
	8TzwPlUlcXJ
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

