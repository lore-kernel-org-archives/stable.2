Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07B374E73
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613905; cv=none; b=tPx8U8HwbuH/iceQbsYoD0h/0DvXXQe2zli4dAa1lIHm/K0Lbjj4RbqzY4p0noP8BbcKkkdBLU8Ma7DxGaMjRZWlWso8hi2pLn32RZI6Oydtrte22IZHlT5QhS87nqbdlDsKCcRZYcBpyGgvapr8mFPtQVhcE9/cY4T9GvxDAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613905; c=relaxed/simple;
	bh=5g4uH0RrtbcULfEphRET7/XOqXw6ZIobg2gQHh5TTXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vABLh86TLUUcRNbp5HOvLoIVSnFBYR16PJKnVYWT52UVVlG9WhOiBqXvV1GdA1aHe6FkETl+UFQxgnva+W9MhfSbs2Q0YTKwF57O6rSrBdcYrB22HAypToR62XT8jRZQpg87DMjA4I+rHIe49X807AdioEgL40GaeMIE7w72PHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5KtG3sd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5KtG3sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CFC1F0089D;
	Thu, 17 Sep 2026 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613894;
	bh=Dw5IXBcDCBMeoL9VoOaPBnXoC0msW7vlKsTwFVpRoV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5KtG3sdoXOjb/IK+5qoCKhmNSOUPt4M71bJW3kAGtnC4pyPbM/xm6pElKMIPGiiC
	 0+3Hs7VNetkpbz8HdUNg1ubjSd2gjA8gZM/xdTk/uBFKrn5EFkSr6ONxfZVsxOLrXZ
	 pn7a4LbFziL2JEmoZXtKpO2mfpyUaZP9PS1SQq86ypmPTrDkmq7jNHommIyISPdANX
	 5SW/wBBTwaWyIaRSm+v1HwJ8R1JzpeN+ItMeLNFkOKka8Em69syrq4S9epAMQ5pUPG
	 aNM5Nj/aKWfAciI1Ou+dEpydV71QyQbLoi5SugAlgPu05wgqypYzNUOqQTNRNyfji4
	 TB1NLWptPEA+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] mptcp: use sock_kmemdup for address entry
Date: Wed, 16 Sep 2026 22:58:09 -0400
Message-ID: <20260917025810.3934358-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025810.3934358-1-sashal@kernel.org>
References: <2026091627-sleep-poem-4828@gregkh>
 <20260917025810.3934358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 52f83c0b5f857dbe24f66fc9a7f035523e9ffbc9 ]

Instead of using sock_kmalloc() to allocate an address
entry "e" and then immediately duplicate the input "entry"
to it, the newly added sock_kmemdup() helper can be used in
mptcp_userspace_pm_append_new_local_addr() to simplify the code.

More importantly, the code "*e = *entry;" that assigns "entry"
to "e" is not easy to implemented in BPF if we use the same code
to implement an append_new_local_addr() helper of a BFP path
manager. This patch avoids this type of memory assignment
operation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/3e5a307aed213038a87e44ff93b5793229b16279.1740735165.git.tanggeliang@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f9f0068e8813 ("mptcp: pm: userspace: fix address ID overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bfcef17fe9dda..493a4511a5398 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -67,13 +67,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
+		e = sock_kmemdup(sk, entry, sizeof(*entry), GFP_ATOMIC);
 		if (!e) {
 			ret = -ENOMEM;
 			goto append_err;
 		}
 
-		*e = *entry;
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
-- 
2.53.0

