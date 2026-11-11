Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437054;
	b=mO4Wra3nRe53IAVGBMP9pg6Sa7QiL04+J79eahoeWdiLggAz3NMed0vZqsvdLRAyIRXu
	 /NabG1VLLUA/jxyBWOCghxxh88RGrKIyYzDE1REvwe0I2NlSFitp/pT0awFXPy85ajI78
	 0XSBgCcwgHPJYk/lMN1nLDANlRL01UqSFXhleoos6dNXTxFBWNK4CXshFxrOXxDuPzY1Y
	 wSe9Z9CGs/X2EfYfeJqj7apKQuBLKpys38XkF63jmyKGSMrBk4WfFNwbbYs9QgjIV/2KW
	 3zwh+zsxu36DDC/S6Ve1oDmLUbvCx/Ky9EECGRpzpwliKaqjUELbMPiDq0m0CVs71qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NQkxvsqB5+3Z4Z6U3vwfQkv8YQsNVSilxqSf6o8hlcM=;
	b=S/CJcqxu6xKmIxSE+j8EogaYVc9YJm1/3Sr3UKDk2Z8xw/T3eI24h/hJcQ7SOMYEj5uR
	 VW/SfVmve4svqxlBc/p+n5zIcqVJE7k0muuzxoKdq9uBxsxeW1Fm4xO8ILeGu5MRvSlhh
	 kHwakYg4H+9PTWS1xi2jiWbgHHSYZOFzZd+fmjXStytzq+df+KyYylL/b0QarIrjMvSKF
	 zIKlKr2IXv6EXp4evtFTSLy98/VmIBbMKgTepCqd4mmFERjQfAcZaKS+TjwJUetfDORkm
	 3tuRosQFyGSyYwkz/2crljci3ie6YIeTMe70fIASL6UYInFVgLL0Q7Fzb6tRJ4LGcCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK3mXGXz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86574606A337
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK3mXGXz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3351F00A0E;
	Wed, 11 Nov 2026 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437053;
	bh=NQkxvsqB5+3Z4Z6U3vwfQkv8YQsNVSilxqSf6o8hlcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QK3mXGXzijBn31QPusVZ86qgUHh9BAkgKitIR+qP6WzEHKwXpagN42QjUj3HBNeJZ
	 BCM0ozPXgqsHsTiR3R2yTZ5JIBS53sidTfOnffgSqC+i+vrdQBz4VBP6epmJLrOvsd
	 xXCcoMCiStmtbNxefmz17oEKFWw6yTa92w+D13ba3FY4pbnm49FLCveBQ8kdIm7gs+
	 mMib8J6Lkt3kh6bWlHYGBKwmUGEQpehhENuzjkeeGRJYx5eLv0Tdh5YfeS3BrRlvcO
	 r+x65HnwAGuPxqMjZyNl2/6aB3PlGcYcX/CRgak4ykBOJMWBTTHBBcEKmQRHyRRrKH
	 hYak3aYCS6kTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] proc: add proc_splice_unmountable()
Date: Wed, 11 Nov 2026 17:44:07 -0500
Message-ID: <20261111224335.80100-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224335.80100-1-sashal@kernel.org>
References: <20261107063040-failed-5.10-eeecea75ece2@kernel.org>
 <20261111224335.80100-1-sashal@kernel.org>
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
index e601bf77a5f80..e35e28415dd8e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -331,3 +331,16 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
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

