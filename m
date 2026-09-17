Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B633B42C2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616150; cv=none; b=IgbCzdwnnJqObigJUy/DrtjEPQrtoerM2zN4CWhzs8ZG7+e7lBbSG5nwtO+CNHLgif3mY/ogB21sgAsD+Zut5YvSdVg6WDI6dXkhuz4G/CxyrNurjaXoRuj/oPgZsaoLtZ8hNOJc7RGWnb6NFRbl8avB81uh4lTAOpFo0ueWK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616150; c=relaxed/simple;
	bh=IYkmlsS3JlDK4rzWKhsaj8UZSgoc/Bg1tylKK1zsPTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCcnOEuVv4GCo0l8WrsAP+i0w/q212gq8UV9PNEoIakCjBIEFui3rtCM+GfF/l88/q1i35G5POWExwE0kjPWbiHDb93HEdOONWHSVK1yoM00Yvdj8jrS7q85WcNh9EWqggTnY4aJZOZJ8Fz6/NegrPddZzoAZU9QCJmHBf1spvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0yzSyvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0yzSyvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F611F00899;
	Thu, 17 Sep 2026 03:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616141;
	bh=1sVRDjm8ZPxLUPgp2X2lg9LHTynYuW7jCS5wp33IMsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q0yzSyvnX0ln1HSVDas7BJVUd6GVo9mD675q1vpwz7Sl3TR44d8mmel+xlUdV1XJw
	 CeoKu8BntQBCITwZxcmFt/nAM8XtrvPNf2gW7jFF9ufGjOovhRcmU3zd5yfbz3TLH6
	 3AySIWv6uR6AUF8y597g9tbYmZiPZWbcFmfXV0XYznFBvHXHLlFo0xIoC6mlALz2No
	 QWadjdT0QFI0GfqyeomVDS1GvnFAaTsVGXatAUeRNaYY3ThFvrwinvx8I65XTgp2OS
	 JDoA4IXZpJxatE0cRZ9Lj38IauVvtHvfp5dGsjkKDUNtMk/7UVcfqMvhfD1e6K/nGC
	 RCDenGC1p2OJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] mptcp: use sock_kmemdup for address entry
Date: Wed, 16 Sep 2026 23:35:35 -0400
Message-ID: <20260917033537.4044281-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917033537.4044281-1-sashal@kernel.org>
References: <2026091628-sevenfold-cursive-c662@gregkh>
 <20260917033537.4044281-1-sashal@kernel.org>
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
index e203b7f878a90..1bc270276db46 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -70,13 +70,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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

