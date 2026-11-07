Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046496;
	b=I7Pf43iZ+SLESgwqfv8vdGgVNTdMr7mkr67lYtj+otpabpaxfR4Gw5qjtjtITXYpi1hD
	 oR+8K7pTGZ/w+ZSYelJkj34kdI2GkxjqRW8yppJeNy9Xsd67KQbjGLi+OdmQt29sM7otq
	 m2miRtyVPiPFN2CSTjdsKfwUKbMmuCVfozpnM/CuZdJ5hjdOsxOi93ABq3xoIK9z2maZ5
	 APjYQaGobBay/LOlRreeJQTd3SaKhrNk39FknJm3hA8Pj/cIocBdP6CdRHhx8LMnI/o33
	 DEfDtQ02R/YQNG5ZDQonKrk/qRu11LcG4Xq2O+vYEPWoNDTckQtmn7H5PwMHeqyqjxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046496;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PbTs6D+RGwP/oXMGjZHVifo9TRTWxn9iww2vVaXuWMo=;
	b=s10q1i2liwiFW5k17jdFfppTkLlF7i65wcWGpme6lg1jAe1eSfZt1lTk7qrkmoN/zv3b
	 VpkczBwcBrJS4udqM43XpVEDnFCJ/xDewPCyR2yGu6bF4hAcsv3Sb4vI7rneDOAMOEE3j
	 ukjnjoFUxS1B3wviIlfiE9RLFfL+4wTJilMOPZSDkLPtv6uf+sBnuR8UHQbYxv3+LZLft
	 vZU6Q1ImQqKoX3avoa3rggHJ0ziWRl+avD7KFQL4MajNOIe8QTCXbFV9t5yAw7D9HW8da
	 4EfNkWQuXCFw1T3y/I2mLktT3NWSEdR+/g9fHcMHcd4XCD1TpZibLnwXhfHe1WEjwUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8pHu8QF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D86606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8pHu8QF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583CA1F0089F;
	Sat,  7 Nov 2026 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046495;
	bh=PbTs6D+RGwP/oXMGjZHVifo9TRTWxn9iww2vVaXuWMo=;
	h=From:To:Cc:Subject:Date;
	b=d8pHu8QFs6Lijlagfu4yOh7zeypWjotnZP9+4UKC3P7cviEV7v6ZaGRuLn8Olu5u9
	 R02MoEOM2GmWJ1lwFUj4o1X7bqibj8Gyz1LZToW2LmKtMTngE3Se41LWatNv+Xl8ly
	 D5OPYSIInLx/6bKNSfJkV/OJ/X/4PZ3vgzhQfN9y68sElaEx4T2zsLwohjdD+E5kM5
	 pWJiY/zIsMs+GaaR0EDnj+4wMWEpLUDiIj7qnh2UiRwS7OnKtCGFqP8My8pgRGc1Io
	 AFYvoTfwanVILRytukA00AseTYRuHxoggtZ6bViBhuIFnVpznNZ20ZYTCr2OVF5FLp
	 U87ubtYvcS0Gw==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:54 -0500
Message-ID: <20261107051454-failed-6.18-9c1d14d3b66b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051454-failed-6.18-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52 Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Thu, 10 Sep 2026 11:00:35 +0800
Subject: [PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then copies the data into a single folio
with no length check, so a malicious or buggy MDS returning more
inline data than the folio can hold writes past its end.

Clamp the length to folio_size() so both callers, handle_cap_grant()
and fill_inode(), are covered.

Cc: stable@vger.kernel.org
Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ae6aa9db5eb24..86fe0e76cdf07 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2245,6 +2245,12 @@ void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
 	      ceph_vinop(inode), len, locked_folio);
 
+	if (len > folio_size(folio)) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+					   len);
+		len = folio_size(folio);
+	}
+
 	if (len > 0)
 		memcpy_to_folio(folio, 0, data, len);
 
-- 
2.53.0




