Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC263CB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611546; cv=none; b=Lm7m5amBpfLq5ZW5rG8ejU66ffbsaL4NwpbOj61O12sf45+2l/2cRCmsh+V4kWlU6IX57SmUYX26Do3dQKPCQGeM5p3gzo9iriVk5RWFmnoQegoph1UDtgZT0UYhycK0bGa7KjuxefzqfE3DeGaC7Y5thV1MJw2VPU00jN2B0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611546; c=relaxed/simple;
	bh=ONFcQxhzzDhHzBkz6Tj0qhzLVxwh6cJVGRhuyh1ates=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtGJoDIzmDRpEZRDRG+4a9d7EGfPEXT5c7NTszJewq+MfmP8lC1v4ZALgcx8kuES7H/23X6NCRDAo5q56vtRuF7OLr+IaIvMkqoJn+zmp+ou0zEK5sKllNxZ0sU8ENlvdTrTJszfAWQC7hjal1Gxl8RvWFCdhvmqmci4vLjHhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY2vl5oz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY2vl5oz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45861F0089D;
	Thu, 17 Sep 2026 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611545;
	bh=O+kLEk8NK39DJCclSLeUkaWfWCV0PCflVqsLV4T0svk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SY2vl5oz/vvy+h9bX+D1JQFlIkpJzLdCSXXgXIh8t7wVq1yiynBhx5o9AzvzPxTeA
	 LMNPgQgEeeiMAMMxdFHmNhpOjDjRq/XPJd9lbo3fwWOBU8I0Ej9XczI+AdIgFKB7me
	 xMqQ/wnAIvIKDepAAofapWZNOjPZA7OI572q9Rs7T3WjmeJAV92hA6rQNlQ+YSKJ3I
	 ECCFZxBm67ImQWUJNurSUwNt2/n3NeKrDYjRBKGI1E3iFoVGyRMhFB7dv2ra4ujwUF
	 KSkOD7dDFc5GKphdYrk8BuxgrpJulj2ZDyScMKURSbichB/VN4dNusxNeSzxgYtF80
	 iLYf9+jdpHbCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] ns: uniformly initialize ns_common
Date: Wed, 16 Sep 2026 22:19:00 -0400
Message-ID: <20260917021902.3810750-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021902.3810750-1-sashal@kernel.org>
References: <2026091618-used-flashbulb-70ef@gregkh>
 <20260917021902.3810750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 660def10b01b248fd97255afacb7b0e305ac833a ]

No point in cargo-culting the same code across all the different types.
Use one common initializer.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7812d6dab069 ("bootconfig: Fix integer overflow in initrd size check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/proc_ns.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880f..5ea4835550823 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -70,6 +70,22 @@ static inline int ns_alloc_inum(struct ns_common *ns)
 	return proc_alloc_inum(&ns->inum);
 }
 
+static inline int ns_common_init(struct ns_common *ns,
+				 const struct proc_ns_operations *ops,
+				 bool alloc_inum)
+{
+	if (alloc_inum) {
+		int ret;
+		ret = proc_alloc_inum(&ns->inum);
+		if (ret)
+			return ret;
+	}
+	refcount_set(&ns->count, 1);
+	ns->stashed = NULL;
+	ns->ops = ops;
+	return 0;
+}
+
 #define ns_free_inum(ns) proc_free_inum((ns)->inum)
 
 extern struct file *proc_ns_fget(int fd);
-- 
2.53.0

