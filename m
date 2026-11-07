Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045943;
	b=i+6yzasgyfZ7EQS9m/CXXhffOTeIs/2gCRXbUhjBfTQztH65fTvckWIKmiOSq585O2hJ
	 OeYs4oIAG9cgMUxSbgWzA+MMLjJQX9jTRmF0UmA7PYcv3Ym7bCjpohLYbwMhcvNRUzDk6
	 n6kvPzN3kuJ73/Q1QSlrinrMooM/biL+ihzwY2GyJI8le3d1a/PtjZ30u7+gieMqkao1O
	 HpVMUyxQWYul2RtepXrgneNj+UAeTOxmqexLUDti/9N4MOyapb/GRqjTX7j6ODK17bbpN
	 RBPdVUveYHaTU55KpvAlTPJ31Uef07zgxScCvO72JHIOyjQ1gGV+3sq/KukeCNkFPSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A8ABoYBwInM9rxT0MwHZz+7uKd0WEDcRj2h6kPwQVOI=;
	b=bCgX0gzi39Xi06meS9FVNiCXNrKTue3zKOyPUIupH6hNgEFp7uylKt7WgOZZ3rq7HFoX
	 awqn1uigQ75irx1GLBbwNPW86GUu9FYx5jThtPT9EhcMZWoRKkAOCG46eCkg77CcXhMmv
	 N51zTP37+Ct7HU/lOU43UR6N7uGXoQavL8OdAi/zUgHobu+I19BXGOqmn3q/56PUyI1aX
	 sPN/ZXbc2JRSyxtksyVxC3WUJTNTRTXr3L6f8oagOnkW63G8QQuvK+nBVVxKV+1SG9bTM
	 eUV5CRwo5QTIzGeFk+TNS3RTYxPB5NO8/ZpyuDRig/EY4iOZOxnxrYZp7dIRc9XMUZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlJqPp1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlJqPp1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FC61F008A1;
	Sat,  7 Nov 2026 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045943;
	bh=A8ABoYBwInM9rxT0MwHZz+7uKd0WEDcRj2h6kPwQVOI=;
	h=From:To:Cc:Subject:Date;
	b=YlJqPp1xs94m8tvQ9nJfpn6100TSMUX8oU2i+WSofkru6rRpTuBTK9T+QO5Cpz6tv
	 sPTg0oe5sSmFAIDt+iecKdeYKC8DRaAhepMYoubeNioO1xAyRm3k+uIVc+zZX9kvZI
	 LQZIfSh9+KCKmzzKw0d+2MscXc+5YuZo0C4AsACJ5L8cP2ORkfnMFFi4MdbNEUi2zp
	 j6SPiTp6TC6cFxrbyHYAqI4bcpNigBHNTGykLoS3isNEq1CzMSszZPasP151o4jhw6
	 5d5xGPUkUoqjXMbBWYFX1HZBWBWIO1exNVPPjwZcnnBsgrLAvVOvzSQhEhVmnAiIv8
	 4Pt6kJSi/RxwA==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:41 -0500
Message-ID: <20261107050541-failed-7.3-9c1d14d3b66b@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050541-failed-7.3-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




