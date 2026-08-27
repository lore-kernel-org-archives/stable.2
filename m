Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E113499F3E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854096; cv=none; b=VTis00zxUQASM4iW5GRP2BHcA6IyDOa/5eSWWMpoSl/PM2et7io7m0WKr9ZfXxH+y9q7Fc48loffWWiumOipLEt6ZC0tMJTDmGUg2uVv20nLfr3yS05E4rI+4FryqHIOHEbZnunHdO7lVa1JN4XI0mZbxl7eFWxWsxD3hwEIn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854096; c=relaxed/simple;
	bh=PIXGMU4n+Uv/u9GnO7fStLTPwJ0mTfi9nyEuNUKmNuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz5Ykfz7vShL4l0aOdJFnQBkVpyvRg/MmsBuRGOBu1Hb2Vh342ZMBv+uPIlszg5v3LeVMl59PT7aUbKwpf1gfP5LgOVH30SSlmKRp+Ugzr9syr1Fhh07qEexAYHptDMPacvx163qMfnLfrrp+cEW6DaDVzAVpFiwdQ7Ak6W0UM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hwuIN5/S; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hwuIN5/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787854045;
	bh=q7bBIsYeRYgAgjuS1gV55ntq3mczboRRP81uEQKnCxM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hwuIN5/ScNUwBOpMiL8knUgfLoHbtT/aoEBn2xpme36i1O2N1v+6efKyWlDjIXGwh
	 2uy2C9E2V5UcVPS2mU6MBdNPRO5Va40/5FVzEkQ1mMuarn9M7qtQdIQA2sW0OzyyXf
	 hCY+JO/pmL3bIPOsoGjEUSAg7e141ZkjVSaO5iBQ=
X-QQ-mid: zesmtpsz9t1787854027tc1575a83
X-QQ-Originating-IP: RODLhorXTc7imyRK/hp24XEP9ycOSOxrfKZi6GmCkk4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 02:06:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4052020208419059330
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6.18.y v2 4/5] selinux: reject a permission value exceeding the class permission count
Date: Fri, 28 Aug 2026 02:06:08 +0800
Message-Id: <20260827180605.4187309-5-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MK4MAyUlYG3NhA1ttJP9cJoFTK5677WGgzckj2m1EJCjICwQD2p/vgHQ
	rzShcsiDlSZhpm8C3T7YVt5xhycgpswOzA4CCNBVaCdE5rp87jS/RTE4MoOI5ViQ0E8UyMK
	pN7gBZipGodcTrCvCRd1O4NWh8+cIOuBopK4mFUKOcM5FwpTJyyzZ7jgAknvmjEXKOSy8sg
	xYfgFbxaJ8f8Lbh428BjI47cZex+l2t2DXYmfjCio6jflU4sRs1qcwlRYIEjscVgSw9B+Rn
	dsW0+vM7zEBBTCM3pEpLUdC+IMKMNCYMwQYZ3gg/WjPaIGRTDDdC4DxwDf9Jplu7iwHryC5
	+UvUWmw42eWQfesSMc9tMk4mipg1YDwSNBuQOJ9+h7yyJ7Z+NkQSZLJXdDvuZEBuxGnsYNX
	j4B8rhWpZbVafW0etSvgTNUb+i8BbywQuVB5HStZoopwcd7JnN2uxTwaZOzpkXuPbs9/S8C
	I+sZ3YsPWe+vcKiEEaJEhmgHGQFVNB9cvJ539Ln7x3IYUdDojQ4tUHMa/B5Kh0SMYiKlJ8U
	TCfEjjMdcXhkHdzO3+YyTv6SIrnMrFPLXRMF1z2WB6aolgnRQllxhlCqSzymE/ORP00HuVg
	s5jvQ+JSrhNuhoYW0/pUOp+OJxap5gUuajrgarudhujHptgGfHlHIayotwVt7MCwxcdKpf6
	B1b4ieClAq/TosNuKrLrYgK3N/QanHFkpAu2sFplykv45bqjjZICmw4YapMBFHDU8t4rpxp
	+ipOPcFTQ84PHNxqsNooCk9hMbje4CIlN87+ngS2Q0WFnfMD6yFqHSHFjwUFoRmaPzZA2JR
	eH4k/DrAaEb4l3ERwDvB+vhuKk3ASC5ukBT07+DP4tCoyCg7Kx6GCelYFiFz2BTdgLSpMeI
	i2V1i9W3+y8cQGd4bQXDk5474wwdm9CyLxtnIr0cd5z7xOhFxl88VXbgrauYH+8cvzj0n4F
	4QIRiDdjgJMrLBos2nAdNPGr1BnZjnCwSNxl1ZLgndoPwfOMhoy1H9j9VpT7eAkNHE6IGLK
	gnY7rqCCzRPpQvx0mPW0VlkpoZ4GpUl4VXpNmiWKMUgJhdyHd6zmEAiqUaY+W65VjEuWYzk
	Dba52ufJKCluUnzE52t0iQ1u4go+u1DjUbM1So1ENRadbeCmy1mzHUlBi+195cgfWyqyl3Q
	h/TUceS+YqKnAnAUSB67ddYbOA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
index b87a512446197..926dae3731a0d 100644
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

