Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048058;
	b=pKk8hhVx4ywJuhC7MFN7uYMLK0uEh0w21wLdaeY6GIPU12+/n4vnFuZfD/pOkKwPvXHB
	 6Qxpz0ak7ekJ4Lv4yFyjo34yFRfVQxTfF7XBzBZXznc8Yyna7QSnUNexdtbHjCKtCUDHc
	 vnU3tG88qsMMCtx0JxAKl4TjCqLjOh+flQBoVj35eoYKngRvEHN5fT7NVdoQ/HWnIXHh+
	 aMoFtMuBSGd9VijPjqEjdaJ/kEu9pEgIz0Ix5KAzZjzsYn+zPZUjw99YyEQ8T/O79prro
	 5zq5mcEBOxqCq8cgIp6EEbmviC/CKxXwFIdQenULzPg/DJ2mCuo32+rdoBvI4NgioWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W23koU7WX40LwK4CiovLmAQviiFbIaZZvB6e732ejNM=;
	b=alL/i6eX23ipkrVfF6+P9HZf1N+LdJp2xZjnIyuHBNMela+ES7n3liddzGgLLAwI53L5
	 ieYwuMm1myj5A8lcWkpxVGiamodE8Bv5PnynVWjC7fDXpp8ioZPhJRTwFDpG2teyZKdKl
	 Jf1pzcCzu5IAxDQ9n3x8gz9ZCDUbB0SlUsqIh3qLL+VETjQz1QXNJ5Wj8YiYNiHaCYRJV
	 yn9Dl946Dw3AOk4vH1Pjq4EFau0G+BBp27purfYDRY4eS0Vl3ViI4JeGxEzvijGHTQ+lL
	 7MDVLjWvE8ANqpcJFWoAhPQz4wRFqxuAMlrHoEeFsZptVE48ePnI8RrDyLLPthYdl3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jT1USwF/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA5606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jT1USwF/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395AD1F0089F;
	Sat,  7 Nov 2026 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048057;
	bh=W23koU7WX40LwK4CiovLmAQviiFbIaZZvB6e732ejNM=;
	h=From:To:Cc:Subject:Date;
	b=jT1USwF/8adjSSrcODZfIDJuLWRuPDBNNMuUHbuPackdaOZxQ4XAstfxcOUa8u9Zm
	 tK84/8am3EIBEzxodAerCwdrPbAnGtM10hb1ifjCpbLuoJ3DOJyiF0yyR7AIXmZqN3
	 mz/Qum/Adw58UZnQc+6NzvA5Cs+HnQP2qhmsgf+CItiE5GwK0FebEMbrAIND2IHw4d
	 4KuD9ol+i0xpXoMlMlinc2TWynA3NbY6Zy77N26c7KBbB8tixm8j4rnGRzQzbvGCrP
	 qNgj4ihFrHAACFANjLsNCVQDU/BYljUS/7KDEcW3auknn3xYjjWPSKLQT35Jsymkyz
	 eeGyvYQCBSCpA==
From: Sasha Levin <sashal@kernel.org>
To: jack@suse.cz,
	shionthanatos@gmail.com,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	jupmouse@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: Make sure there's enough space for LVID implementation use field" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:40:56 -0500
Message-ID: <20261107054056-failed-6.1-a61fb39759d7@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a61fb39759d719a4f4966742b4d28387e33d81c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054056-failed-6.1-a61fb39759d7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a61fb39759d719a4f4966742b4d28387e33d81c4 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 31 Aug 2026 11:17:14 +0200
Subject: [PATCH] udf: Make sure there's enough space for LVID implementation
 use field

udf_lvid_valid() verifies that the LVID has enough space for all the
tables and the reported length of ImplementationUse field. However it
doesn't make sure the reported length is large enough to contain
logicalVolIntegrityDescImpUse structure which OSTA specification
requires. This can thus lead to accesses beyond the end of LVID buffer
for suitably corrupted UDF filesystem. Add the length check.

Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 781d2a9a2fc7 ("udf: Check LVID earlier")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2ba5973ef4dd4..5351755aca3ec 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1617,7 +1617,10 @@ static bool udf_lvid_valid(struct super_block *sb,
 
 	parts = le32_to_cpu(lvid->numOfPartitions);
 	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
-	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
+	if (sizeof(struct logicalVolIntegrityDescImpUse) > impuselen ||
+	    impuselen >= sb->s_blocksize)
+		return false;
+	if (parts >= sb->s_blocksize ||
 	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
 	    2 * parts * sizeof(u32) > sb->s_blocksize)
 		return false;
-- 
2.53.0




