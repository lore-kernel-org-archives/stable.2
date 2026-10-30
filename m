Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363631;
	b=mKigElZpOBvWEyIXpbdILEGOOe5p9j9/tRAK2Wyes11G0qJKsvLKFWO9LyBLB+ytIQqy
	 6BcOOpU6I7oCbs3Q/xdwxeKDunq7RAbu5IugqWK0pxgqTesbPyP7YeOUDrfQrPzVMjzXl
	 po9TKLHyywbc3ZxPelWPp3w6n3E+PRKWrWkHh5jrlGe+716sTAzMUcnYc9dpsQgKFANv5
	 PR6ZFwxFCqlMyoXeoTpMnEhvWiL8a0r+NsC7h2r20NjqZpnCh4GNBOuUIMfjiaip6eVG5
	 vXciK2m4XTWrV25FhdGxhM0140RTq3LKpfk7J8k04AOzTPLWfSxTeL+orORsnm6Dg6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363631;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=440yx7MBYSaEWfj/YftcqEO/a5ZeYK5vW1pKavKHSd0=;
	b=maBtIpDh7n/1u0pTsIwJJnhRIABPaJLFubEoI9ynOzaqBFNqHsOvofXPI+z5PX23kh8q
	 ZczgQUTEvG5nRU3NazTB6/KONIfRIYMXZxJ979gbAzmKuL84hiueX6LE6pzo065WUtDE3
	 j773+7fVV5ovR5wiAmO/2x2O05334xCvnokJimKJzo771blr8+pJlAl/zGJc1UbYla5tC
	 lQnwNJpCoeZDOuQK+D6gbEh+NPiwe8wma3kzjv0rNXXGyAlwKifvxQ6tuXJNbO8vU1S/i
	 OVxbV1oIRvXdjMLcgFZpzNUJs/0f0hHuUdWHUkfiCTsdbyiqxwaqJ0rf0uEFNRUJsPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bpdlFD2y;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72139606A31A;
	Fri, 30 Oct 2026 12:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72139606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bpdlFD2y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=440yx7MBYSaEWfj/YftcqEO/a5ZeYK5vW1pKavKHSd0=; b=bpdlFD2y3zcUQUq+X1K6OcbQ+r
	rZeAOi0Xhn7B6yKNPye2jVcb5R8FxpWxs45AutngKvs3Uyq48JJD/CLGW+k4tkb/CqEl0D9mhXkbM
	ziutWv+5d/l6uHtv8DDy/zAbRWyAJsGEI9zRydqvNOrwAmJDbMIdrm/CV3XTPdYQq/ZHJwRlru5rT
	k9ReqIYXTjXXT5kZwoXJ/kcskE8qjhLyJ1bU6lMWmkjOSKZfqiOmuuHQdtVi0UEIumRPxAySrU/jC
	h+RI5nebedjxJmwnlaoBw9JEIUFA6UCjCF0Sqs856PFQR6sJjMXKD0KaCVxoxve4JEAWyLHQlMVVl
	nl7utUSA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xMlne-003ony-2L;
	Fri, 30 Oct 2026 12:33:39 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 30 Oct 2026 05:18:49 -0700
Subject: [PATCH] ACPI: APEI: GHES: Fix severity check in ghes_log_hwerr()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-ghes-hwerr-sev-v1-1-145ceb996c77@debian.org>
X-B4-Tracking: v=1; b=H4sIAC2L5GoC/yXMQQrCMBAF0KsMs+5AEkOQXEVc2PptxkWVGa1C6
 d2ldfk2b2GHKZwrLWyY1fUxcaXYEQ/tMo0QvXIlTiGVGA5BxgaX9oGZOGZBzqGkHMOxL9wRPw0
 3/e7h6fy3v/s7hte28Lr+ALaDMH1yAAAA
X-Change-ID: 20261030-ghes-hwerr-sev-e440624108b6
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ov9WcK1Vdwuag3dbjig+CDDxcuZZVh8HgCYniPBlLlM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq5I6eBrjZ/RmteRo+cIvUd0Qp5xq6wACKB7S+U
 TbvNdDJ2pyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauSOngAKCRA1o5Of/Hh3
 bQjmD/9WpQSYYGNFzVgN+WtPGsGwnAgRZYrnXfx5pbVBrFSN2cT62ALZtVyhEg6RkP4ZEdz+Ftg
 xbRjmvenEE20PJm84QikzGtqmyrVAqZzFONKBtqET9RNOXQr37pL/37XZPFtR5iZ7f8zVlCU+T0
 os0Qt4GsUMEsPU5/wFMdMoVuCVVVhXuQbGYNDR2LnAVN+lNzRl0EqL65BPwqjQwuvMOdNFK/gq3
 Wp742zoYm6pkSv9zrAetipcUTGOx+phX5cVP7iY0Lh5J0sjIlZErypdaMbSj2kot9SDU8c3Obag
 jXp3cOoGWe0m1/PhBBFlNkyTFp4kaL2GhzGjMkyG+LeSXtmyNL5+Zs5HB1VSGtnp+MTcqH2ladY
 lwDnoPxHp52vuDhTDIF14m8GHMAcXohIuvCBJJVTBuh6QWsGdzLD/G+74aAw755xUQ0yz6OQ9DP
 sv3OqhRdTsikfsSF3nYK8cl0gZWX2ihv36q7NYpzgvSRorryf8w8ih3To1jZhRjclB+gFM+o0rm
 akGhqO22OmmmpMr8lOnd+8Q6Z3NSNK0gQI1apqKxycNqPgXFe5SMP9jO+SXz5qGUtAa2vrknlFn
 BwFFaQPw+PQHxL2YM4tXUguiaL5H4W/ZwvXQ8OAopig8z9yjepDWFyu/y2wFWlztncqZLm6p/E5
 Wap1IfMtQddAyOw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

ghes_log_hwerr() is meant to count recoverable GHES errors in
hwerror_data[], but it skips them and counts informational records
instead. As a result, recoverable CPU, memory, CXL and vendor-specific
errors reported through GHES never show up in a vmcore.

ghes_do_proc() passes ghes_log_hwerr() the record severity after
ghes_severity() has converted it to a GHES_SEV_* value.
ghes_log_hwerr() compares it against CPER_SEV_RECOVERABLE, which is 0
in the CPER enum and matches GHES_SEV_NO, so only informational records
pass and GHES_SEV_RECOVERABLE ones return early.

Compare against GHES_SEV_RECOVERABLE instead.

Recoverable PCIe errors that ghes_handle_aer() hands to AER are also
counted by pci_dev_aer_stats_incr(), so with the check fixed they are
counted twice under HWERR_RECOV_PCI. That is not addressed here.

Fixes: 3fa805c37dd4 ("vmcoreinfo: track and log recoverable hardware errors")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 663dc2e601cf72..5d888c82efeaa3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -899,7 +899,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
 
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
-	if (sev != CPER_SEV_RECOVERABLE)
+	if (sev != GHES_SEV_RECOVERABLE)
 		return;
 
 	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||

---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261030-ghes-hwerr-sev-e440624108b6

Best regards,
--  
Breno Leitao <leitao@debian.org>

