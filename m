Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA54119F7
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821755; cv=none; b=ik+BtT2zWx+w7YqNNNXHl68ouzM8h1QiQeUeOsCRunHB/SabTz92m/tfkNvARYt2/1aOpWNB3gbXX0R2n2sjV54U6uULLkOiKME1tb8L1vTjobFmZuOMAC0iterJyErsWpFs3x01Po0LXkmh7rP7hD6zIgFhq0yS49sHbNQrDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821755; c=relaxed/simple;
	bh=p3pJ/xmQrE88TJHAknveg/FhUq96V9Y3w6K74L6GZ4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2NyIy41ECKy+DhluVYUA04DzxET6axXar65zkXEMpk4HW+EfArbJUO/WoKEYuGg44LpEg3d2Sor+9puKxQexiPLB9opBZCV7mxQYZToNOvzoTTpiS0Gz9hWiahQQcOcmvwtueMfYiifgpqqti2vzmUcZ43BJjiyKruAd6XBlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Ka5GWiS4; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Ka5GWiS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787821700;
	bh=mauNWAAPy1VPuuULg6ikdwud9Wmj+xDqbDT4c1y/5AQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Ka5GWiS45c/EWosJXqcJPKuGhKwcUz2k/mIxYhATr7PpELfRAF9erUSpYQC4SKNfe
	 od9F7jyHsvQwKK2s/6RKyLareRLDDsC95ETIBPgwys3hhI1wLS4Vc1UfS/TNYSqqkC
	 BeYKKvvhom8wC7ag7XTM0b2c9Ln4l8o9mciARqh8=
X-QQ-mid: zesmtpgz4t1787821681t88f31046
X-QQ-Originating-IP: I+scCf8EoYFbKX0yYp60/uVWKO+Msga2jzQQ97ZdFFg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 17:08:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1723470195298251195
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's permission values to cover its permission count"
Date: Thu, 27 Aug 2026 17:07:59 +0800
Message-Id: <20260827090759.4047735-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026082710-viral-doorstep-98c6@gregkh>
References: <2026082710-viral-doorstep-98c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NdzMBwfAowx1U6IY9NK4VSGiz0JKVCg6sjaEiPGI7/ljiF2PxHbRaTSj
	MMXYkf1WCORjU9DX8gJ0+XgVLCEfJ+kd/K8veFD69sAtCtrf9k6k7LIPnkCzryZ+ranlQhh
	sGnfVb4LFSN6MUzM9p4i0GVJnRNwRcUfEaylNjTUjuUcBm5IgCbC218U7AOQStPd5v81IJu
	iKoEL+VOgpLjmB7zNm5fPbOIegnWRMRPoWw+ThoXnZ5SqmJ9DpiG9UrRNlmU+1zwD0JxQC8
	xP4IMYqdvvTmoeOLQta9/XNuMvUpY59bQvBDZKg35Q481FF2w32lZtAWuxNPtrysTCb4n7g
	9yCo01X1BecIVGRe6aHzOVrWjnVFv1NOhnaBBsghyi834GpauX6gExbzguG9+ks3iBng3mu
	xGyKplrzJLBadBqlKShBdKU8sa0ApqjRNDsIezNd0nELo+TgxiSaIZn5zIK28+w/HaM4XW/
	4ATTdxfbbapGUCreE3I4pxcxR3eQn8ZTt0Xs837wz9g57jCcYWSb/FJpdN1radyrYo4lBIJ
	DNUnxR9ZhYMIgQhY2eJGvca8U7i7IwWCOyBkhpSdfvX1zCVR3dFMYxwdtqgbYnipNGbW0NZ
	arox+NtvO+k4gOqTDY4vFDQPtxt6wsO2aiEbdUiWELsoj1I0M//DhrJ2ITJwzF71lHPilda
	U9sd11oMA9jiuPZGg8Xji/rkXYPrwur6tcieltlXPq+D85XRX954Z9wi/e4FCFhp+Hr46uO
	ZvcNx8XFoiV2eqcGBaC+Dc/6vV9N/WZaq7uCSCC1WN/eAJxJwOPSPYgxUT+nA6583NcPh35
	cJx7/vgdmNYofQ4x1wCBdwp2kVTYACl1P5gEBFxct4wJ+HHCj+bZWvOnOIzWzpsAM1k9GWW
	pWmDlvHHafY2u3+RNvvTHJzJ7yWFjRkIEKSsXemqIATzMmvMAqjYJ4PmOKSq08rIvuhzCem
	UZeZgGCLa+wBy19mdvNl6BjaZNyMRekJ7esVGLcFOhvpwK3McR6ym6hLNhLre/ZKFqv+O3y
	7gYa8o+umoqaTyLkvguRcTF8DgEbPUNWiTvW4bCMbB0vhHWBWKDmkmjrpHisEmk9JmHmnDE
	W8dSTwQ1XkbqiZCf0NHph8cFQUHkzIosucVxEc2cF6Wxc3XuCJUIDmbesz+gU1ecpbni2KD
	VwTmMCvkBV/d93KNt+1kVRCZ9C/v5ufAkrLZLffIinSeE7E=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Sorry for prev email title is garbaged...

> Why?  And this is not a real git id in the linux-stable tree.
in stable-rc git tree.

> 
> Do you want me to just drop all of the selinux patches from the 6.18.y
> queue right now before I do the release?  I'll be glad to do so, but I
> need to know why.

fair,

What happened in my side is Github Copliot review point out the issue:
"This validation runs after symtab_insert(), so the table already owns key
and perdatum. On an out-of-range value, the bad path frees both while leaving
dangling pointers in the hash table, and rc is still 0, so malformed policy
data is accepted and later accesses can use freed memory.
Validate the value before inserting it and return -EINVAL."

In continues review, there LLM point out the mainline don`t had the issuse,
for correct sequence is that git log --oneline
(v6.18.46-1) selinux: require a class's permission values to cover its permission count
selinux: reject a class permission count below its inherited common
selinux: reject a permission value exceeding the class permission count
selinux: more strict policy parsing
selinux: use u16 for security classes
Revert "selinux: reject a class permission count below its inherited common"
Revert "selinux: reject a permission value exceeding the class permission count"
(tag: v6.18.46, stable-gh/linux-6.18.y) Linux 6.18.46

This instead of Sasha`s series:
2026-08-24 22:00 ` [PATCH 6.18.y 1/3] selinux: use u16 for security classes Sasha Levin
2026-08-24 22:00   ` [PATCH 6.18.y 2/3] selinux: more strict policy parsing Sasha Levin
2026-08-24 22:00   ` [PATCH 6.18.y 3/3] selinux: require a class's permission values to cover its permission count Sasha Levin

The different in all applied different is 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ef7f767a682b3..483d7d54642a3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1171,6 +1171,13 @@ static int perm_read(struct policydb *p, struct symtab *s,
        rc = -EINVAL;
        if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
                goto bad;
+       /* indexes an nprim-sized array in security_get_permissions() */
+       if (perdatum->value > s->nprim)
+               goto bad;
+       /* two permissions cannot share one slot of that array */
+       if (*claimed & (1U << (perdatum->value - 1)))
+               goto bad;
+       *claimed |= 1U << (perdatum->value - 1);
 
        rc = str_read(&key, GFP_KERNEL, fp, len);
        if (rc)
@@ -1179,13 +1186,6 @@ static int perm_read(struct policydb *p, struct symtab *s,
        rc = symtab_insert(s, key, perdatum);
        if (rc)
                goto bad;
-       /* indexes an nprim-sized array in security_get_permissions() */
-       if (perdatum->value > s->nprim)
-               goto bad;
-       /* two permissions cannot share one slot of that array */
-       if (*claimed & (1U << (perdatum->value - 1)))
-               goto bad;
-       *claimed |= 1U << (perdatum->value - 1);
 
        return 0;
 bad:

 BRs
 Wentao Guan

