Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5756374185
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611545; cv=none; b=RJpN5JEKN3Kt2Xh6RfX8s5ebmz08t1ZrxLVGps74ZmWd1Mi+WwG6HT6EBzksfKIF2dvbjkaG5q7JETrKIrSTrDgoRwSpv8HPCrBP0ZVJvrfrzEGL6X/QPLbQdY39VT0zPETrhi85ge0MhFnEdPS4CjDjP4/LlZ8q/qxOsA/7d8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611545; c=relaxed/simple;
	bh=AlQhN7EeDOFjfv4c7qUHGgUSww4lmu323J/Z/yeSU84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OamUvPGJnsolP/ww2fRwSXfb7YdEdLaBSuTMol5clfxKV1703V5uZLUGb5G8ZWHUdJBYoNOgVjWQ5zKNZcJEkFh7XS4W7ybgnVEwug7e8yf7wltvfKpATdu0k0kT5/kwNOUWySHyxRyqsq/KJx7JNiBcreu14sw5wGqWMGRg8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdT62DZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdT62DZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C851F00893;
	Thu, 17 Sep 2026 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611544;
	bh=hXqdOC1bPjxPWjb424U6IYz8baU7fmc582YuBY1aqM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BdT62DZMHTxC1m/y0Llym+8pPUMah1EEahn6wIvpmQy+d04gKMJBCVVJbQXcYPjbn
	 GegBRlxjAYrXvJ8qTtPmPCoVIHKAAE3MO2cGsXVqVeylxaxFfV5hh15FIwQeBE/Mt6
	 /K+nIy13zA0OjOKJTw1syZ5zjTAr0qKjWNGXSMiVnHcD/BlrCYixETP1icCvYhgmFg
	 Y8z+ETkl2yWRlNSntlIddnXA3kqBQUl5rJKGW1fW9QkxAQSzGgtgc/jHHnfEuS/moT
	 ZJWZbWOHu804fysZVvsYknY1YAkHDvfpxNNfIY0qwAu52hFXubUIBzQDoRPatgks9R
	 weGUYNCXFlBqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] ns: move to_ns_common() to ns_common.h
Date: Wed, 16 Sep 2026 22:18:59 -0400
Message-ID: <20260917021902.3810750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091618-used-flashbulb-70ef@gregkh>
References: <2026091618-used-flashbulb-70ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e3e1812f8e25ac277f5cc9249802365300c582e3 ]

Move the helper to ns_common.h where it belongs.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7812d6dab069 ("bootconfig: Fix integer overflow in initrd size check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ns_common.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 5fbc4000358f1..d2b9e0b4a928f 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -4,10 +4,30 @@
 
 struct proc_ns_operations;
 
+struct cgroup_namespace;
+struct ipc_namespace;
+struct mnt_namespace;
+struct net;
+struct pid_namespace;
+struct time_namespace;
+struct user_namespace;
+struct uts_namespace;
+
 struct ns_common {
 	atomic_long_t stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
 };
 
+#define to_ns_common(__ns)                              \
+	_Generic((__ns),                                \
+		struct cgroup_namespace *: &(__ns)->ns, \
+		struct ipc_namespace *:    &(__ns)->ns, \
+		struct mnt_namespace *:    &(__ns)->ns, \
+		struct net *:              &(__ns)->ns, \
+		struct pid_namespace *:    &(__ns)->ns, \
+		struct time_namespace *:   &(__ns)->ns, \
+		struct user_namespace *:   &(__ns)->ns, \
+		struct uts_namespace *:    &(__ns)->ns)
+
 #endif
-- 
2.53.0

