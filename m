Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AF3F7A8C
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821662; cv=none; b=saktOhC2A71dO/9R9teg+P+ai62k0ldYkVVUsfnDCvF2sFwnVO4l4p9/gM3Aq7l8tkYVfQpKl4Weh4NzWGFLnXIxdlijJy9mvbITY+hThQpHv//drHozWOGj7kSlCPDanKpQfLnkl4h45x81KO2TNsMm6laGw8fdcSQjt8Rl0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821662; c=relaxed/simple;
	bh=C9rV8beil+ZSPnXdbv9gltxb65/Nmpx/DM2b1hrI3mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snrI1hfp32JvUJyi2XOF3GHcQJaGUcPyXRuVk8I/0V3ogGSnLG2KvpCXXCT1or3c3IPYTNDRB/1CVRnyB6aaZi/vvccZMEk7H+FCILJC9NTCJE8P0SEbiBvA0VLTyeAkwv9vojt+K3W7BjTTznOtfVjkQmjR2Ks/Z2OpkrQJQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WHjNKENq; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WHjNKENq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787821610;
	bh=eIn7FcxWroBRGhpZkwaXEqcvPQzqQJu6ZCNltwawte4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WHjNKENq2hcsFeCFMKz96/U6rFZZkd5Aknm+dr3K0iyI7o9jXEMb6KlBupX8vZJbg
	 me2LC12DlIlixSN5mV6rPOBOOO74tRm2qXD+xC6XziNsNuD7BAYQFxHfwIH+h+MJt2
	 3wu8T1MrN4kmwbHTWl75VWt5oAOiMH6Zkd7EiDZ4=
X-QQ-mid: esmtpsz11t1787821591t0c68d511
X-QQ-Originating-IP: hoi0cYQJw6uOktvV6JPUYTTSRDSCe0nS3MCw/n/vS80=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 17:06:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13956713814512103703
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.6 00/87] 6.6.154-rc1 review
Date: Thu, 27 Aug 2026 17:06:28 +0800
Message-Id: <20260827090628.4047477-1-guanwentao@uniontech.com>
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
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OZqyam1FSiaoERFi6i1ttEsggrp/f9yz4cSHTD64QjPv6rlGvDBYGqBF
	LGsGYxbMZsaLz9fhQGcb+x3HAe2BHuQwv5Jy90PjK2KViOi8j06+B/cdUJACykrPgXIIInd
	2Bi0DsQ14aUe1GZCv5Zs2WtSWzCHa/7i5KZla+UiE+iyMeByIWt/YeqatHLY5KeO8c16Yht
	YuimAwT//bDuGypD8sLojkjfuT98opiIKFHwRC/uHGDQKRUe7PQX0QyEAjV9UUho1jrzCvV
	ijfeS9an7oMQUzeL/2qUMo3iJKw4J8B1J5MR5SGs+mDpVd7ghDXjaMKbIQ25HmgprhVSH6q
	03mpRtWYvPxEPFKtbqhBnCBCBpBbCKrFzZg3YmPqftyx+Qltm1m3Q5QmLHItDBjW9seCB5h
	R3dA2zsFMJWrPPyDRJVcmWC5xOW/J/c6HFWtxVxn2NRhlYgk4DEdfvmu8jPbUds6u9hmh8I
	tkH+F5+S3/+H8koQCvNOOLbpNQKaOoYSJBkiUqg0z35o7uo3tSUyfHf0avie/qCZ8CkFHW/
	nzn+6SshcXx8scN1zHNUXs76jVMiKgcmLkM7jgjINf5P9q1rgmw7b5ZSxebhcHjzV7zcT89
	KMvUq0atMIWlSFA1WDzW2J6iOsSKjK0IvIHFl91aHRJCZ3dlD1skvYP1Yw78VtBofWjst70
	QqaTDwXjJvJnbf2TKgzcgubJrQ9EDsGaMUk+mIPpME+Mb4kAGk9iivLisOmm8DrUgfG+8k1
	aidCWpwCt9lmE+YUxuSXKqOWmNdxbFoWLYph1g9GCaSXxxKL3duklQNGm84EjwR6GG0Tdx5
	Lwv6EWkTNkE11YX2Gp7N6GJuzjmFGuBHDuOuoXIaJRhlCV1tvnF/V1bhzxrVtG73DYGHK+M
	BYkSbJmO2Ni24LSNR3ln6CRAGX8ssTc17ItVqW3H+iI2xF57N+NSgrVq4x+PfjyBRRjjRzE
	mkKNqKhRD9xRaHiOrvfYBFZ5dU87oCCkycw2wp9S0e+8m/ds9qRlsFBIubnCxJhKur20nn0
	NwMIk8WeTAXYL+2NRiUkIUGTgtw7G72b3Th2Sr/pHquiY/dJ7GK5QacTe+VtPaiMDnslrvR
	QfDMVqEQ6YDOKVD++NAZGgyd5EtNItj0KBJOxxqrJEwmqFzMoroOCyoX/vZpyThZqYZhY/C
	dIcH28xFKgpOhIq7MpKFxyxI7wcZ82mDW1E9
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

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

