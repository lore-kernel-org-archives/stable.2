Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562433546CD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527904; cv=none; b=eDx5WpASXBE1UqYgptkWBUBJ5FJWGdUPQfVcRUNiAdFZb8FnI1v6NJ7SJtmE0G39BM/9qzmmEewE5bPsvQOadpjFkVNwsOvIoRxFPttQMPJ2wi+AcH5M/Lz0WCjmENo4AIeGv/bsloVQGJOGN0rP/l+yeqB/bSr5RoOAkrfW5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527904; c=relaxed/simple;
	bh=nNz3tl0b5mrLYgGRMPZCcKXFOxkTBtbcMPiWmCFbY8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULy5nhKXmOmnvIhQmpXfB0l41IkmN+b7pQfDcvAfV3O4zFM6lahF+FXBqdJq601zABnxE8wqkFKjm+OJAqUotPNUMo7vS5i3ot531jWa/XdW0tW+xmAACqLpk9ROBSfqzOnrzjI6ESOXGXt57Hfj/MVnwqzqBflUAXTFBQU4e8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtnBkMVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtnBkMVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90D41F00ACF;
	Fri,  4 Sep 2026 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527896;
	bh=SjVTq2e3gZskhHV0vgkwvHynKGl1qLJthb5da25Ip9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtnBkMVPfBkumE9CscvIjh1iphldffaY4nqPP2aq/WIe3aK+Qb1Wb5oHj27PASxIq
	 QGw63UfTfUDDUfgZdzRk4AUuu/SsMo9vccpvjEP9vS1nSKdHpfz9hzIwiQOLtcmoQp
	 7JnDC1G6i5a996vkuzA3CnFDzLPa3o+LMY9QrliqooK4BjNqLbOW7lVVbXQJFRtxIB
	 pBZ5yVArB0I5/Mz2kBdJlb3wmvtkXAns7thF3hrA+mcXfF73+6Zoz3mAU+ta0S0yND
	 aFM5LZIlxL4nQwYcjdIyyJTdsHbIjkaA+OzT7KKsA2I9AFP9Gwjze6XqClC6DDGD9h
	 VbhT/+/ZGOq2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] tracing: Fix logged instance name on creation failure
Date: Fri,  4 Sep 2026 09:18:13 -0400
Message-ID: <20260904131813.503518-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904131813.503518-1-sashal@kernel.org>
References: <2026090305-creole-floral-cc49@gregkh>
 <20260904131813.503518-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit a9a01be2834a529cbd490ccbab02643f0c1735f2 ]

When boot instance creation fails, the kernel incorrectly logs "(null)"
as the instance name because strsep() consumes curr_str entirely during
parsing.

Print the properly parsed name variable instead. And while at it log
the error code.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260807085423.4175161-1-vdonnefort@google.com
Fixes: cb1f98c5e574 ("tracing: Add creation of instances at boot command line")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 61e7c857a4652..535e47b5c40ad 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10326,7 +10326,8 @@ __init static void enable_instances(void)
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
 		if (IS_ERR(tr)) {
-			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
+			pr_warn("Tracing: Failed to create instance buffer '%s' (%ld)\n", name,
+				PTR_ERR(tr));
 			continue;
 		}
 
-- 
2.53.0

