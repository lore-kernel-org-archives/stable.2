Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EB3DDB0A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585674; cv=none; b=JMNBb9jvgJA9QAlkhyx1+FSGNaOq+wFoyf1qySVmiLFv+Ch+TBy0I+za9D3TM4asgOGGpt03WJ9/4DmSBpiYGVOeiEvnr7iYS4zBPe5NXs4lWrfDkALMaV/Mi/2iNuQ2XhMUVeWXzxLVtgSE5pvSCSaNWEmQRNnY1d0Ut//CzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585674; c=relaxed/simple;
	bh=CxMvWIwu1GgVMHsJoBNUEsEeDYxUxeRinp5xcnHKpCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CratzgKvi8IT4c+h1Tr/tmmZhCRmRoJSSJB3XsZbhVLhlssZr62XnSrshqhN/OguSchkaaMf4fwhr/7Sl4aF/CjHaemuyrruIXkV5w1CSyGgfj5C5IvtZHbNaxDsTyAhYZaqXzSxHSZ7YpyAz6BUzXsPQv8TMu75HTo26c/6/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3i32ZVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3i32ZVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0C71F00893;
	Wed, 16 Sep 2026 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585657;
	bh=8iC392c7bBdRVAZYbO1t1gR5fPu12C+zyrr6nI6ud/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3i32ZVJb1RcZMQWPUIzgm0gWCgRjH1Oak8CpOGWbklUWsazbHoz3ZkQHxdR9HfVc
	 Ypv80DWpvqwzeH/eeH0m8O29aWP42tuxx4DcWxFBJl82GX02D3PIvkRGDA3mhTWtZv
	 iMKwjWmW3rQsomvnLrjcezZTdUzRp5JO+Raoxx8jAXPDj/mKRbzpR2dpKlB3/ta+7s
	 gqmHdfFB5llReCEU5/inlh1foolnDsuXLao7s1Lt5IGBOuDiarkMHk8cXMzQDp8dab
	 utFaBesyMRzfkZsib0juVMVKQ5FYUXSZXOpQLfR2VVTXJz+QoVsz9kvJWm97IYP1A5
	 ZroN7Epksv1/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: zuoqilin <zuoqilin@yulong.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] tools/bootconfig: Simplify expression
Date: Wed, 16 Sep 2026 15:07:29 -0400
Message-ID: <20260916190735.1968203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091617-cackle-deeply-2ea2@gregkh>
References: <2026091617-cackle-deeply-2ea2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zuoqilin <zuoqilin@yulong.com>

[ Upstream commit 30d103f2d4602da07313cf43d7b746e89d7d9c1d ]

It is not necessary to define the variable ret to receive
the return value of the xbc_node_compose_key() method.

Link: https://lkml.kernel.org/r/20210414134647.1870-1-zuoqilin1@163.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: zuoqilin <zuoqilin@yulong.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bootconfig/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 387cb91862dfc..6862afd66cfd3 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -84,11 +84,9 @@ static void xbc_show_list(void)
 	char key[XBC_KEYLEN_MAX];
 	struct xbc_node *leaf;
 	const char *val;
-	int ret = 0;
 
 	xbc_for_each_key_value(leaf, val) {
-		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
-		if (ret < 0)
+		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0)
 			break;
 		printf("%s = ", key);
 		if (!val || val[0] == '\0') {
-- 
2.53.0

