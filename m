Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EC3126C2
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858141; cv=none; b=NZwFTIYXaxiYwtdclAuBcvdC6oBcycWMwi5+aY4h560SOS+e93Wi71i90vFK2AE97wpV4COHSH5qTwcK0b11lemUciygDVFyWNIY6Q7ZVr8RmRTB+h7ZpyFFLBg4t3Mwze5CdRAqrkNMxFa/o/1YT8EryLUS7cVj6k7xzioH5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858141; c=relaxed/simple;
	bh=9JpC01dmcCz9H/ptklHW8D9XXq6/qu2NBP+XEOSLXpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVfwdMeo01CPxl3Re5rMI53t7zmU9qI4p4c0TSQqutiaWFXyDSFaCUZGOjD4Qt2qN5S632n9HNgWayudfuYDpDcCy6g5zPd0HkdiFwcw/3VQoSs/vFYO5NDZfMDQ2AjoLDL/RFhcRDE0XjxAABsDKT6VlQIiU5WpunNaKj2treg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=W4G84Wox; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="W4G84Wox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787858100;
	bh=LQXQgl0+UFfsoBQai4g+76Bq2QEkECCmKI5qmvT1xi0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=W4G84Wox4Ec+tsJf1n+vDA1MO9E4xBEK9/Wm7eevU69n0FzYqQPAq8Pb1w1Uy8tO0
	 qx9GF+Z9WI3BtzgrVu9vk9MyQcpEQKaAzFroJgTgS85Fiz1ZtXBT1q1fFZj/cF5g4B
	 wuIIfJTJ+J3ks6LmmL19yPgyeT1NPJNzJckNl5HY=
X-QQ-mid: esmtpgz15t1787858082t991fac4e
X-QQ-Originating-IP: l4AM1v2YOlzIiCZLGMlYTFub1rURN8v0tqLnKehOU8A=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 03:14:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5757795152073921487
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6.12.y 6/7] selinux: reject a permission value exceeding the class permission count
Date: Fri, 28 Aug 2026 03:13:22 +0800
Message-Id: <20260827191317.18119-7-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827191317.18119-1-guanwentao@uniontech.com>
References: <20260827191317.18119-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEJQrEAwC9KXTHeBHfHCn5p14JCtadAIiUuX5bdhssqOwFts9kMnr+Qg
	cYVbYP3AF8XT4+wKcvx7qeYjkHQc95r5jWNcWmUluQT8/PBmDnewfT2li8vr4B1QxG4fhZO
	e3A0DNvzzErmp8kh8U8yWCbPBQYoxTFs+Kgx4vow8tUmiIeC8mo8vwxhPDbK5vurakyKwoX
	nUD6JDSKAlDzwqApKqVj0dEZRn/9rQIng4OjBNR3GjN3G8wXPmciyI95JGorPBIcoXgSWTj
	TRCbHRrhAvQfRuHEQdExyRMDyZ8pwyo05ab3JlRn30iQvbVrG8pxW3J4ncHIVvEomUFDH3J
	Tlyuh7azPD+vBQY4FZQdHmcawMPeEZNZ738NdkUKPmPyR1foPqdKIzd4SdLcnGSTNjn11Nd
	IfZ7R50Cz+Y9rToOyvLhI2ibu/8bk8Xv0UtqIqa42genh35WeV1lQx6hpwomnAC9cpTz4bA
	Du6xrmq1EnohkB+Fejp3YhVpa0X1fdGc2YkKTseR9e7kFg8gG1viQEDU+JBkceaxlDaIVF7
	jxkgXQKOxb82isHuQ0CCDJ14whlwrdorNql6U3VNNr2b2yII/sdCunk7iYaq928lvUnJ5Wx
	5dwXsxMpk4Iv0SIK2H6QM0lzofFDtrZ0RwjbvTcvDPRrlOeblDSmtZIabDs+Z6puy9vUfh6
	oXRBE0UqSLHXordAUy8oe7VsETEBXKNYUhc1qDJi6ALAq7mQGtDmayyqEMe8uA8biDdyDgd
	JVuZSu98A1GzataSK6li3kxZXorXVIYdLJ4KvM/AZMs/+KIRDDARNrTLLNKrvqUJKmTBwRz
	wrmGYmpHJUz22oUrWg/lLiW1ff2pzEwM+Mb7ttRifMPi0tAEiLchPf3EJWHM2PP0ShEPOvg
	8lHc/tlBdd1LHGq2yiTKIknaa0+i6mI8ItCt8Cp3FEBG+NonEqZnnFLrNDPxMzxIuRrrmGX
	qI69ZfVaM/XFQhK2NKc3HKrl2ZUduM0mZCh+v9wmGp/eyTKz8XkMgPugZeMIZS5cnvPNAtL
	HlplpUDVvkAZw+TzLVN3rN6ccT2EYp4tCLnbbfmJIt4GOWF70JrUKhvOIZ4/7qMIEex3rQm
	l+gxxAH/hkTlCcudNtALD50VGFZAfzJizB5QyYwl8b/MYsHpyVFu7lsGPxHtWBO7tf4Z1qe
	tCKiN8mzn2a221uo986owb+YfcGcCMWzGzIU
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index f93b10ce19652..3dc6d3057a89a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1148,6 +1148,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
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

