Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050945;
	b=2q06qhaRoFfYvDg+cgbHagGeARrF6auOjdhEMyDTwgKZGEueDPPH2VuqgV4sfV/YIhxM
	 PA4cGI9rotCg1QMNIx3kjuDXfjprpcZ43eoPLM9AThdt+Ce1uOKnOt5DIJuhuMr1cc+Ew
	 uhmJKDsEePykmRJu1ngZa2Zs8p0bK5H3oBSAUxKKvGHm1OrMfgk++ZQUUgGbLbiMgLgcY
	 BE//TKwyFvLQ5SDSTiUBpOl0LbAqqambmHKtZtZbAUm8AtXMzcfnb1j1vobZmFWrQRBgs
	 MntLJKWM0qYk5fYlanuTwJQJY7o411K9Sl4z7bzOsk4uSaLzHwWLRZ+Ts6LeRlfZjAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7Pf/lueRuozOiaTTkNFZp+/dMXdvl0TmQTYv/WjuofY=;
	b=pNtYGbuXc4gpalIWNqpSOz0trvO/Zvyri5OE1NbOthAQ1R0KbUZ+g/oU+DaaQDD1gfP3
	 pReRbZTABwLp9cKT5JQzAt/1SoYEqIHNMOWDyUk1N2m1JKrHx4iHlIiIyjdfHEsvRLNcn
	 3eQK42PWdj5PKFu35ZC474Niw0E/WmnqYiSwxyKdi4lZ5dfkU6/No2CzpxxNnYPGUDn8h
	 Z/jgkYU6bvd8uH/45gtj72HH14GAzgPcCZjZfZrj7KwFQRDOhHIB75MvbZyxmDuokXQlH
	 jrJ7hDxfURHXVCfTVzpwFNj7BvQtnE5+DJfXZmIYHzlnOtnBXkoGKe8RIiWMeivn3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH6bvpIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B110606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH6bvpIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9851F1F0089F;
	Sat,  7 Nov 2026 11:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050945;
	bh=7Pf/lueRuozOiaTTkNFZp+/dMXdvl0TmQTYv/WjuofY=;
	h=From:To:Cc:Subject:Date;
	b=TH6bvpITztUkR7pR37QjRJdkZdALDx0h3ntecr51lHAZu2t1zOVE2PYUjPL57Wlof
	 dAzwwdHiWcCzhr7zkNQu+5rWqwH0mQt8yOwQ+ONpe+p0wQBKAQ07NadtjRvmYrkmJE
	 Us2XnOcXQILF0HgVo7n8tekQwrdVvdkgjzUNd6ccR8znzqV3xRfPEqYhZlfEUdYorH
	 /I2SQpWzfPLPUFGuRnxVZ+KpTXrtXBlhyn9pMaAiaRUpnNl6Y8+XivWoBlhYLk81Df
	 rnvS31RI8Jo8FxjcFUEfU6qciURTrE5+XPWdPVgSzBktanVcyridhSsfhsQ7jws0nj
	 ZxxCpLPOqWCnA==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:03 -0500
Message-ID: <20261107062903-failed-5.10-9c1d14d3b66b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062903-failed-5.10-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




