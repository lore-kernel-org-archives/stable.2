Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437053;
	b=0gI3tUEhQidnqWI3VQjz4dhrh5E9ColGMirELmrmy6qjEC4ncOqnz2EydahqWjOlmTnw
	 ee/0aYQJN1e3vO7++d4yPuYSju6AYfJPHO8/kHg59NAXPUcRw+A+eFh4KCTrZCYFgoesy
	 +h/Iirq9s73WcSmOVlWHZM0ClKlJoYqQZgKVN3un2s6BoBQXbcb1Iz1BxsubMXq1UuD83
	 BLIZEqrRYcVIP2OA7gpOf/2AekvUUriPw1fjO5ObozcGjZvoEZ6rD+zY0b4B3Y4SXE5+6
	 CgQa92wvBvbZGJ5OJWOWt24ITC6iUS5Fwnl29SCyDTi5xdkZ4dLb2GKDryEl/+O/PUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jp5GEaLjOnlI5FtQ9kb0+3D00KwSTNi50RMqOELG9G0=;
	b=au6Kp+K+DQIYfl8bomhIgV8gu7yy17QZGoTzGGlLzSEgQefFQF/EQ3B/34+lIbDyqiao
	 17PIrJiKoiY/jgKg2xyMJVSXpr6leFcCrSC8vv3lGY6h8+mUibVrUKdyLLxVEVMjUEXQm
	 L2oWNqIGCll7Ni5iUuxqV8FiQBXfDmq6GMDeR7wA/UV8EyRyhDnbEwDKqfjOYN33PzhUM
	 Y/2RdMJV6ubE2rnlW1I4iphswEtfNHmPCfU5aGztXbkp0TtFCZxcOqfFt9KzIg0oaVBGh
	 SY1Gb8HgG3lMSe2Mw5oaxW2sUf1Nu4/0dZY9BFJSENRHwtdvGgBHiGbM1Asu3FluTzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj8NXEWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1D606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj8NXEWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8892F1F00A07;
	Wed, 11 Nov 2026 22:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437052;
	bh=Jp5GEaLjOnlI5FtQ9kb0+3D00KwSTNi50RMqOELG9G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gj8NXEWZcIy0Zga7d604LKQeye9hNErNWo2Rl01K6RFrVXpHxo5CMkQPeb/QPrrbH
	 tMI1RYFNR4kHRdYVUdqOes30FE5nY5AeqopS6lhkJ/sSHRkZet0MAyXzAyiLu6W08P
	 vMJEZL/wKQDvaYsnb1FEjm1lsnseIkhRPYx+Uc2F36N8CHnvJKLo2dLHzibow51s0B
	 wvEiGrqstz1vYEWXjp5DKcN8s77JaS5vrtcLQXap+txnDGrQ2cB/rs5gq7Ol2HREgO
	 mQC2uuHol8cUiyEylJEJamoXqTdYDO5klwoS6zmhMs0PiCe2nOZui0mpjZDU92kUXY
	 lCU9Eb6YUjmfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/6] /proc/sys: use d_splice_alias() calling conventions to simplify failure exits
Date: Wed, 11 Nov 2026 17:44:06 -0500
Message-ID: <20261111224335.80100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063040-failed-5.10-eeecea75ece2@kernel.org>
References: <20261107063040-failed-5.10-eeecea75ece2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 1eae9a47835ed4703055afbb3c52fef6d07a8a4c ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: eeecea75ece2 ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/proc_sysctl.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 78bd606314281..b7e3d36737cfe 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -524,13 +524,8 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 			goto out;
 	}
 
-	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
-	if (IS_ERR(inode)) {
-		err = ERR_CAST(inode);
-		goto out;
-	}
-
 	d_set_d_op(dentry, &proc_sys_dentry_operations);
+	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
 	err = d_splice_alias(inode, dentry);
 
 out:
@@ -688,13 +683,8 @@ static bool proc_sys_fill_cache(struct file *file,
 			return false;
 		if (d_in_lookup(child)) {
 			struct dentry *res;
-			inode = proc_sys_make_inode(dir->d_sb, head, table);
-			if (IS_ERR(inode)) {
-				d_lookup_done(child);
-				dput(child);
-				return false;
-			}
 			d_set_d_op(child, &proc_sys_dentry_operations);
+			inode = proc_sys_make_inode(dir->d_sb, head, table);
 			res = d_splice_alias(inode, child);
 			d_lookup_done(child);
 			if (unlikely(res)) {
-- 
2.53.0

