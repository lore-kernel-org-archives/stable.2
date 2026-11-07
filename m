Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048038;
	b=FU/ElconMmJF8TpkXn3uz3bOi6EQMFzmzkQhnvZsSOKns3Hx80cDXVeQ/8178DGlTQBz
	 Y2hPu0L42wy4687BEuy3yKez70zZJbmcjn0pTaA6u8VMHzGvS/1ARn2G4Dc54xCg5kdsU
	 3m39EKHmgsHHk1PW2cVNfS/XbJim1qd9FhqGM+6WICUjBCaOPCS9DzNmi/YV/CiHJLLYn
	 zZW9B6hhgJYlLAyGz+oOuaCrfcj+0sugANJzFIDjRVsuUQcv43+Vi2w2jhEAfOE4kYgWW
	 x6PP0bMHNdP/JiXe0uAgloR+lwaXnCuJZQpQ1mfngwtc+OOA1rGC2zWCXu6oM6MIyhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gDceMt3mmmWONq4efqYKCtunMLg4VGthflw5XsOhEiY=;
	b=bh6nxgIVhFcu885cV6PFj8I0Co3WzaOZYjiLivryR3u8+uWT8aaVPpuy2yzV3LU0tnkw
	 6lzWqL7gTDmwqfzK15fXCPiNqHkKyabAlbDBlh268ExXh/ujbjIk1VgYmNtpeMeCECMaR
	 /zz8nrf2sRQmaOREV59dBzl4FUI5t/aitLqWAG+NqdFI8MxUblT9RMwr5WVmFycfqv3fQ
	 EUHhtMGUghDRTDu6J5Q9quqIy1fkiyPz87OlTdCC6q0vZ/8JJug6MxnHKHubNs1SVR0Pe
	 R+2N9wOB1w1GYlHC3jzFWNikXuki+c+uyqU3QuvJ232Xyci6D1gaMm0EMESaL2Z27pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OL6RikR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OL6RikR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14511F0089F;
	Sat,  7 Nov 2026 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048038;
	bh=gDceMt3mmmWONq4efqYKCtunMLg4VGthflw5XsOhEiY=;
	h=From:To:Cc:Subject:Date;
	b=OL6RikR8k117xfBlv8AITXgXJFrA2axHDJS0ufj3iYMWndVYkUhHKpaue15L6djUb
	 pnIUeTRs5W626JQ1eVB9qyuRkacFAb7HPjY89p1jzlbtlaIXdHzg5eHsPmBN0A91km
	 pivGpE7WU9BG6vgdq1Zt3ikGwJ07j7rNNWBkXIgZb2eLHVJ/1cZpUfQzGs1JWz0/fH
	 hzdox7aILi2lMeAVviersJLb0COCA3URbGWY0tP34BJh+gmiVe1rb0NItuC6ge6MlD
	 Iy7kAGyk5VWQd2F1cJYve7v7PVlx3RpRrDQdLn4frECpMzHGOo9hL4ACM8K1E6elxD
	 Dfjhz1j2B0WJQ==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: check accept index + 1 is in bounds" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:36 -0500
Message-ID: <20261107054036-failed-6.6-afe5d5a74739@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x afe5d5a747393cb3d00795db31d7fce5108a766a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054036-failed-6.6-afe5d5a74739@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From afe5d5a747393cb3d00795db31d7fce5108a766a Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Wed, 16 Sep 2026 19:53:07 +0800
Subject: [PATCH] apparmor: check accept index + 1 is in bounds

aa_lookup_condperms() returns perms[index + 1] when an accept entry has
ACCEPT_FLAG_OWNER set and the subject uid does not match the file uid,
so such an entry consumes two slots in the perms table.  But
verify_dfa_accept_index() only checks that index is within the perms
table, so a policy that sets the owner flag on the last entry is
accepted, and the runtime lookup then reads perms[index + 1] one entry
past the end of the table.

The perms table is allocated by unpack_perms_table() with a u16 size
read from the policy blob, so a crafted policy can place the owner flag
at index size - 1 to reach the out-of-bounds read.

Check that index + 1 is also in bounds when the owner flag is set.

Fixes: 6f442d42c0d89 ("apparmor: fix profile verification and enable it")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy_unpack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 3ffbab46eec30..7ebffb4ff74fa 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1495,6 +1495,15 @@ static bool verify_dfa_accept_index(const struct aa_dfa *dfa, int table_size)
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (ACCEPT_TABLE(dfa)[i] >= table_size)
 			return false;
+		/*
+		 * Accept indexes for owner-conditional permissions come in
+		 * pairs, so the non-owner entry at index + 1 must also be
+		 * in bounds.
+		 */
+		if (dfa->tables[YYTD_ID_ACCEPT2] &&
+		    (ACCEPT_TABLE2(dfa)[i] & ACCEPT_FLAG_OWNER) &&
+		    ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
+			return false;
 	}
 	return true;
 }
-- 
2.53.0




