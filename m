Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437023;
	b=scRkHxdprmsjZ8ldw14iGb/yw1DrHjG8CjctuEt2t4zyeBqWXi0WPN+9kun1FnhIdyQC
	 aFPdoIJuMJCjCxdytTmXfQi9+DJ7RhvIbP9AR1bXY78czxwRSWMqoLSKArP4+Cudutj26
	 BsSCWux+tTMZutulbzyz0OkW6OCAfq1vA/kyIuFcER+JJv5uMG3+hwm/SBpGHsuJAOWjy
	 Jjq9MxwNIgtbbZYrQWyVNON4XXlUGu1331XHxMbw7su8KCLJ33/1JsMfQZRP9N8l39jRC
	 aGTsRe9CCzJIBlToOUvrWAnolxHzTzwe3VxIWTZGzjtaaSSXbIYbsDZSflFBlYm08PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=diAskAusDKp+8NWi8M9DtyJtv5c1jpvINC8DYlpk8pQ=;
	b=x8gdC9Djf+Fh9lhP0oL+WMtJkrt6k1U8VX0iS38bBtCVL/+wkKcWAKgkt3pN6yc4NlSE
	 7u8StHHB8Pmny8XToxQUqKIHH80JnSPxmddfkXfddoNTB8f25hyjzISz3G3n7lvrnAMyv
	 y7kpyVNQIy8RrmJ0aupgQ0NLTl+bFNwZp8YX4J1jwqm0S34FotNuLOBmtUSWeprRDquEY
	 ecqhparTkwORFo30scaE1iHxefOUC5DMST1h6soo6h5HohXVzMcKmEeGQ8ttmZ6Gt6cuC
	 ynDjTqz00rfXhuj+R9Uj8RDReqw8Ey+h+3Gwaq9yR+/neT+Y+l2K7UC5c6MxLmc4Niw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5cLTsx7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E6606B039
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5cLTsx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2701B1F00A0C;
	Wed, 11 Nov 2026 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437023;
	bh=diAskAusDKp+8NWi8M9DtyJtv5c1jpvINC8DYlpk8pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5cLTsx716t+5zvaEyoBsdXstxNflDMssG5plkmdX3R7UgRCpk1259qkBHmOWwP0m
	 OVJKbPODB2bLFV4V7JS++2acv3HWko5wyOAGUp+SjANs5o/wLxJj+sQKKFJ7wUCTsF
	 a1BodIDpnkvpwEngTIzIkYvTAg+4ZGLwJrC3nTXpWloT+CvH3keiC3YVzbYdhTYieg
	 xNv/M5OgeMP3AFYuF7sd2kFFaKHCTpSpgIL9QgiRvQYMbLlxUDtkN/2rZXWtg2PxBH
	 /gCjG9FE4An8eR1wazzvOo86Pf6/5aegANRRRDY8gMsWZhdJEILiiv8gvstXEhVqzC
	 7jtF7S084KdlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] proc: add proc_splice_unmountable()
Date: Wed, 11 Nov 2026 17:43:37 -0500
Message-ID: <20261111224250.73064-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224250.73064-1-sashal@kernel.org>
References: <20261107061331-failed-5.15-eeecea75ece2@kernel.org>
 <20261111224250.73064-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 32a0a965b8a5b7b505babae2ee10c513ede376d8 ]

Add a tiny procfs helper to splice a dentry that cannot be mounted upon.

Link: https://lore.kernel.org/r/20240806-work-procfs-v1-3-fb04e1d09f0c@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: eeecea75ece2 ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/internal.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 9c4a5540296fc..2c652681172b8 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -332,3 +332,16 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
 	pde->proc_dops = &proc_net_dentry_ops;
 }
+
+/*
+ * Add a new procfs dentry that can't serve as a mountpoint. That should
+ * encompass anything that is ephemeral and can just disappear while the
+ * process is still around.
+ */
+static inline struct dentry *proc_splice_unmountable(struct inode *inode,
+		struct dentry *dentry, const struct dentry_operations *d_ops)
+{
+	d_set_d_op(dentry, d_ops);
+	dont_mount(dentry);
+	return d_splice_alias(inode, dentry);
+}
-- 
2.53.0

