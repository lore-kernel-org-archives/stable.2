Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8623BB11C
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189186; cv=none; b=Cw0Rmeo4E1xVlZJslraXcZwyw3jCjNMu4N1kKRDeuckDKrAnAA4ZepJwFH9hzJgupkAbYXXXcDGpSZciUn8YO4EtTJ3dZYE/qIJa4GwhWGWv1IdGZjqgQFU2B4B6mONWmto6asCTy5qMQULW/rbAKuGPJdzvag7zsPK1vAdCTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189186; c=relaxed/simple;
	bh=fZyG2LCJvcvBYhYpOyjTMnB4qD3fVxk9fWfh1waajqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NG58zuW9spFv+8WHkFDFaVvLgk6qTnZOQi1Hn6Ix7nUJqN2El9NrW5yhBqguWn8W5y58xb1NspnR2wrkrkubc5cUkDKCjkKGS+e2J0Wp+FiI+cHHsMOqJnB29mQ67LdPxiSipTcnseD3h8vX3aq08O2IIGWS9h5yPAs/8HGjDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hQle9+Xw; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hQle9+Xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784189164;
	bh=pJ0ue5z7tVOj7TGnclWbS6a3sv7VtouVbcLR2mY9xP8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hQle9+XwNm4ATEn+hDjOvWKKViNjB17Sf7jTlE0PilYnp6HFCZwHGXiZHw6plaUBt
	 q2zvN9Ie+AsNxF2WVWa9YI7cDrXMP9A43rHfFvfEbamxIU+Nmye7c+oIDxiBSZrQdh
	 niaKoEJ7QruCv6Xkom6LF/s31QaNnSlBvA9ND8Sg=
X-QQ-mid: esmtpsz18t1784189148t56648ecc
X-QQ-Originating-IP: NIX+5yCV040ALGhXzVQoMIUu9k2HA+mwZFp/+eWJQr4=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 16:05:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16481410924050730160
EX-QQ-RecipientCnt: 5
From: Yichong Chen <chenyichong@uniontech.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sj@kernel.org,
	vbabka@kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 5.10.y] tools/mm/slabinfo: fix total_objects attribute name
Date: Thu, 16 Jul 2026 16:05:45 +0800
Message-Id: <20260716080545.1165733-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026071426-vengeful-comply-0d73@gregkh>
References: <2026071426-vengeful-comply-0d73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NzNR7SOOwbgsDOXBLJXdcNoJo/4RdirAEKaM+GeV4R/Z1BrdQ1pxJ2Tz
	M/KaAokefU8tKHf2fgEx9TVfx9fj+tkF43UxguADtEIyUCzgNDTb8RiKudjLqgGzsQucb7p
	07XjdU+yKOZqEmZJupDGY+bM5pyeo8Ekn99rJQ9f+DMhtFw/QzmUVBKISCNwAP+Z20xuzWb
	To+GwTxG4dasRD8NyBIKic3x5xZ4MCZyUM4ZbakoFpNwx9ky3OlxMx9HM3L2iWt8Aczv6sb
	7SYoasxoWszrlSkbEvzAXAUIQQQWQr5xhmJejfsd4umZgUkgbueXrBXf9Htu1d2e6xT5bWf
	up5cofaFtGuzdxIztMHa8i3xNeGWN4V0MfLLO0VogkfLzjsv7iqpvpfbv8E++WUNGz8EPIw
	h9dnSZ/IaiIWoI6VRgqGeMp0jcVYtF0RH+R0v7KWREONs5Rh5dzmJUvLL2KbpjE7jVeXlUl
	xFKfC6xsGCN6VKsz5J5xF1Jc9pJfHh/UW1kHDEerjC4+wcS/s9g8pvWmA8lWieehiWhWx5S
	yrKvUrTt3jG/aLFLFRhT2LJg8ggwZ5EV3yFCx7OJ/GSJFztTTPwoO9NhNvdKXUp77AEU+o/
	Mv2+ndn1dQAfGIZtDSi8QalVUj6sIVuReg9QUDm4X4pVAjXhZHfpQQ9E5afoheeGI9QmSI8
	9Vjxcu8Rn81lOZ0ERrxnCEoDV683yxhVhOEOvSFr4xZGzZuJHc1ZJZEfq0Hs3jgcRUm7WPw
	P0Yic+pWSTGTeXFh2yWg/c0bzq6H3BYUq2gFQ81oWIn+dglRaX0XiwAFO7+JaqZRpepBpuc
	RMmYuAgSM3ue0BRDm0Ooqu6AXuYhKQT3pgrvu8f9kCpZZk49J6sFQ7ymv5njA13XpFctCoM
	1nMwhKZ4OwjYW6ChB+qF8aGQ4zlGTYi2b04ctcY6KaYTCd6p6uxgpSegqTZgx11622fkuxF
	wvGlV4zhnEWwCAkZvQT1fLabPzvChxlCk8ZtLfWzbTT4S+157RqCh4dotZ7gzTD0jyiZLkL
	AYmxyzjP5MQantgtPbqtANEcts2kDXHwsPgpH7YgGMrJue/uW2TnSLTTt5DT6pDIi9FOELz
	L7XzF/wFUNztCWPajJ5Tx9kY9T6ahJI27HDDe2sRM63
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

SLUB exports the total_objects sysfs attribute, but slabinfo tries to read
objects_total. As a result, the lookup fails and the field remains zero.

Use the correct attribute name and rename the corresponding structure
member to match.

Fixes: 205ab99dd103 ("slub: Update statistics handling for variable order slabs")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Link: https://patch.msgid.link/96556748872BB47E+20260612071359.649946-1-chenyichong@uniontech.com
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
(cherry picked from commit 892a7864730775c3dbee2a39e9ead4fa8d4256e7)
---
 tools/vm/slabinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 3ae985dc24b6..5819c4133e0d 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -33,7 +33,7 @@ struct slabinfo {
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
-	unsigned long partial, objects, slabs, objects_partial, objects_total;
+	unsigned long partial, objects, slabs, objects_partial, total_objects;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
 	unsigned long free_frozen, free_add_partial, free_remove_partial;
@@ -1232,7 +1232,7 @@ static void read_slab_dir(void)
 			slab->object_size = get_obj("object_size");
 			slab->objects = get_obj("objects");
 			slab->objects_partial = get_obj("objects_partial");
-			slab->objects_total = get_obj("objects_total");
+			slab->total_objects = get_obj("total_objects");
 			slab->objs_per_slab = get_obj("objs_per_slab");
 			slab->order = get_obj("order");
 			slab->partial = get_obj("partial");
-- 
2.20.1


