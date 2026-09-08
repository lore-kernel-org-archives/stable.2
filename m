Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC15328D3;
	Tue,  8 Sep 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876891; cv=none; b=BBr9fgrdfwZCFIVSZ9TZ9pKqlhBdLpD3oYvjXU2fiOrNhjtO0gFrEO7HjSin6vvZzZ7BjW0lsDwrv760z8tFf64Hv/diKBk5F9tMPL50UQWeKk4AoWqwrq0klDro10EyRlfDedbuXIGHt7Rh7cbyvPOLxREawvebMeInDKqchsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876891; c=relaxed/simple;
	bh=ffiRbKuLcxin3A/WteZmozAqUov6MY2AXBJ4V8VM/uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pG9H3GDXJhRUASnppJr+2Z43S6ddE4P/GRaONjc65Jo1+TFkYNxuWTbtqAl2wiUyo6UzWNYUaFAb4HEr4vlZjy7mDTc4dR1s5cWzn44Dk9zohMQkqi1Zl+xH/8khO9PJNGXdXZoIU+ufVodCHzPjuVl3E7TgN20SKa8BimuCvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5bMq9YE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5bMq9YE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA571F00A3A;
	Tue,  8 Sep 2026 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876875;
	bh=e6nwdDW9Dbh9wjzItEeoZ2mpyN9We/YnsvBrCCz/FUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g5bMq9YErnC+gbI4dHdjAY0HtZ0nA94Nd4Jt7H3pge0mwNFCTXUj0mda5xpmfmKVS
	 MQ/wrgkA/N7mBwECwMDwLCIXlSGGJaGFDQ+5ixABR1lfbTNPJMo2SEI+ahEvfp+SCT
	 ETjw5aZ1ji4Z1m8ZzajGKTRLkawWtyql2GbRwbdbg9G8ZNb01U9sVbcCRKpKdrDdhD
	 5beoP81TfgCeRjBR5sVGIYkka3RCYbYqAlwXLTa6fi+Y3Pwz+HPWmHhMkout8UYKCr
	 U8VQNtWR8YWEQG1S3dt6yo7VoBYuEbmHw/VnakoOGyFHiJz3A5kAAu7lMUEKua/U6W
	 I2+6FTUmh6/zg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:13 +0200
Subject: [PATCH net v2 08/15] mptcp: pm: userspace: fix address ID overflow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-8-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Qing Luo <luoqing@kylinos.cn>, stable@vger.kernel.org, 
 Kishen Maloor <kishen.maloor@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hEpKFWxV5Gco76wOpHpHe3xccke8Fe8uRlOsRHjFtXI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSOiy8nzmOJDi5azRvvbBT97asLby4C+iF45ONmMw+
 d7feu9MRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERYJBj+6QS/0VX7r592zrPZ
 au6rtXorHcsOiTxyvLnkth3bryA5GUaGL7/cXlmGv58w+7XA3Ko4ZT2lRxcvpTF4n6t7PbVzx6E
 lPAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Qing Luo <luoqing@kylinos.cn>

When all MPTCP address IDs (1-255) are exhausted in the userspace PM,
find_next_zero_bit() returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value
overflows when stored in the u8 field e->addr.id, resulting in ID 0
being stored and the entry being incorrectly added to the list.

ID 0 is reserved for the initial connection in MPTCP, so this overflow
can cause address conflicts.

Note: the in-kernel PM already has an 'endpoints == MPTCP_PM_MAX_ADDR_ID'
check in mptcp_pm_nl_append_new_local_addr() that returns -ERANGE before
reaching find_next_zero_bit(), preventing this overflow. So this fix only
addresses the userspace PM path.

Check the find_next_zero_bit() result against MPTCP_PM_MAX_ADDR_ID and
return -ENOSPC if all IDs are truly exhausted. Move the ID allocation
check before the memory allocation so that the error path does not need
to free the allocated entry.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Cc: stable@vger.kernel.org
Assisted-by: LLM:0
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_userspace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b94fbb483bf9..fab16d953dbf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -69,6 +69,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	}
 
 	if (!addr_match && !id_match) {
+		unsigned int id;
+
+		if (!entry->addr.id && needs_id) {
+			id = find_next_zero_bit(id_bitmap,
+						MPTCP_PM_MAX_ADDR_ID + 1, 1);
+			if (id > MPTCP_PM_MAX_ADDR_ID) {
+				ret = -ENOSPC;
+				goto append_err;
+			}
+		} else {
+			id = entry->addr.id;
+		}
+
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -78,10 +91,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			goto append_err;
 		}
 
-		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
-							MPTCP_PM_MAX_ADDR_ID + 1,
-							1);
+		e->addr.id = id;
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;

-- 
2.55.0

