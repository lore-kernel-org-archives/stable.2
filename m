Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047305;
	b=Ig6Vh8Zl+2hd4IFUMMCe50+fx+M7SGqaeRMN+pIP3/TxBVa7UK6vfzGvZeuiwDqWOTyM
	 1RaY3EI21uy0hIik61b+ZWLCh6OjGAuxgBZYyDLSVrRz2cW97N6xMLFszNsAVHkbJ1WA4
	 /1NteyyheT8D7wBhNTvCLcl6xmhfmUc9uGFH65PPWZGgIIiHrJphBVkGBD8GSWzVmUHYl
	 ZMR6SUJWonU1WAZeOlaSKqQgFk6v5cyRB2GlVxQAq30tDiBxpH3UqIOAOc2Z4/P7MqwLb
	 3KhT9PqAAVaJdL5o53meamS4MJMauER0g5okPjGHMJl4cbikEYytAsAPvZo2u6Kch3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BGGvnMmIJaSLxjxwh1VQ+b4MA2nRbu2FZWJyVdmTSMI=;
	b=gXdPZ5hC0kFtgNvYArCF/bnr60MlXGpeSZf29KUFd/mKQ6b3Re8LhKnCOSjpKsB+xvaB
	 yT4+oKbM3ssq2Z4oBCvdG2szklHpdPXGjBibV/YfQ4J79uaOeqzRrKs/zKnRZT+iLNQGe
	 M54mX2W6RceGiA+v/bPXepCiMoEClDuBsHHdWdqmwph4wM9JX5LOqax/9PNsM8/6sUfHj
	 HOxOesUPH+qHMcC2OId1alsqrtabn7cA2VwaKUNOQVK1pIT4zoSwLAcgL2D2Oip+Q3xYK
	 tI0/kZl/0JfrxtvyJECCXGBAxGKE9dSgI7dnkI18pkTE8XGfMwX+YGKIuEp1yKDkeHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCJviQxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCJviQxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D6A1F0089F;
	Sat,  7 Nov 2026 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047305;
	bh=BGGvnMmIJaSLxjxwh1VQ+b4MA2nRbu2FZWJyVdmTSMI=;
	h=From:To:Cc:Subject:Date;
	b=CCJviQxmaoUkdnQNmx5ySH/EiexAOJyRqIA/9sinDHYdU5PBpYZErw3gjeQEy1IH2
	 AkbqmE9O9/emBIj7Q/u03OHkdmRhxBo80jBqpBY8VyjHr/K4jOr30qed7ihh0elBk8
	 3tHeEMYMCEnyBwLR0X8ZgvgWsHIHku57h45vZ7lzehhp+eH+Kb7rzozVGmL2NBXwhb
	 dGSZpkaY2n7ztlcgbUlm7M9S2CR6FFX2dOP5qBvnZbhHsesvkK/m3qY3mXbf2V2GSU
	 wKEC4CsZ2jzUM4ZHI0IfA+RyEmIzOrWzPYbDKDQWogeKjQH35mdtdokhVB6BwnKgby
	 f4i+fdveiK9+g==
From: Sasha Levin <sashal@kernel.org>
To: jack@suse.cz,
	shionthanatos@gmail.com,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	jupmouse@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: Make sure there's enough space for LVID implementation use field" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:23 -0500
Message-ID: <20261107052823-failed-6.6-a61fb39759d7@kernel.org>
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
git cherry-pick -x a61fb39759d719a4f4966742b4d28387e33d81c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052823-failed-6.6-a61fb39759d7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




