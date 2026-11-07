Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049926;
	b=qoFKfbv2aNBxqiYPvGbuuGl8mDxoxMygj4DTBkbF3rZw5qQrVyCSr1Qx1hkPiaCwpWWX
	 /PwUGSFkcxmTg+Wq2RYGjej8WcOtDltcs1cuiu3uE+/c/x7rKAONF2usH3e+RBUNRSnwd
	 k5Q/tnIO0rCoRbiYAwizj581WSg91EKUe8HoSsxTFnLa8kd8uGt0sN1hMGM5yezlBEz/a
	 SYAxVzyGTVD/AuROAJX1SipvVBfwfC8+csWbtwr98ccdI2AITd9YejX61ehUiLOxDfkd6
	 EpT1x3E7VKwf72Vy1nFjYQfJh0f+SRtGK6BqnfJJkZh2zqajDSHkJ464mtfn5bdUDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049926;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OarWlMjQfHefdoOXrK9rZtLnFf6kc3hclceMetUYatI=;
	b=U4WVWlgM3TLM6FkaC9ln9Uuo+Uuw0l9ivlG9w2czwoCmPcQqQw7r8rXWQaTYbIpu/ZUC
	 QaHEumHvOQMb/XLeEtcUKJNr7Og3XSrXJKq8VCMJR1FaJM2RBJ4S0VvpPILe+sUOBZeWL
	 uBTJe1+BM47FulQhck1gUCAezFnOOmhG6irF3b47Fys3e1Xvf7HmVcXm48mtibICSq2c2
	 tyyG66uUDExheR+CyMOIvnpebKsld5l+zOp0Mk7FWRINp9L6WVIBUaloJjzTFGZ4P6v9o
	 5BETuEILVsCv+Zvhd5I0dApf7RgCdBvTRi+EsgqpbZ8G1BTm9xTu2YX9WZXlsu+HiqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcEzDQkc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcEzDQkc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A431F0089F;
	Sat,  7 Nov 2026 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049926;
	bh=OarWlMjQfHefdoOXrK9rZtLnFf6kc3hclceMetUYatI=;
	h=From:To:Cc:Subject:Date;
	b=XcEzDQkcSgJTFbCrqAM38RQLlSSkVzj6Hl7LKZNVTe5YXX4gcOSEQmM+iOQdve7MU
	 90fjQe5MoPlSBGrSoNm58IP31G33IQ+Dl1BDi0QqqZMPFt914zavVzhqBF1jRj2Mz3
	 gaHAoxyOo4QSZUNOYF1RxbdPvsi5lCDH8AhyG8sIcrbPDFzb7OJ4KbrQ4ZhiotKkvU
	 XPhfhw7nIT8e3pWLg09lwsVwM/jkTzNiXNm0/nQQ0gAQuDnqNhvuR8wrC53EKUER7o
	 rEg0qexzxI0MIV7ahOUR0MuGLUPKaFCh1NcZPerozzfvQatajOWKc/eeJv59n9Ge5e
	 lB1F7kl+XZdgA==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:04 -0500
Message-ID: <20261107061204-failed-5.15-9c1d14d3b66b@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061204-failed-5.15-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




