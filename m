Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050070;
	b=XUqbKNPy33RikLJ/p+7/ilR+BazvB7zCUAT8vH6BNf769/U9s3JRwk9drCD+KiGgZuih
	 2i/dDL0UWOysE2eEZdR8mZ3XZZGKQgBaBYxu4yK3owQlOi7YTaCdsyNbqRGsVSVfn2ckm
	 +4hcH2bS7Yn27pce4iulDYl5AhBGRAJoQs5zPXly9x9iFFlnoVtXzol2UbkVOr7yZgmkg
	 L7xPhoCQJA3JTqDWLaIgP0Cq81/6p/18P74qLsaBm/PTsBi0nlhLBNq8zxLaEPfTr0rhi
	 26VI2+5uhSsE2OkTVEgLY1CDv+Y4Ko5ozBiQsfZ9qIGDiVXqrr9AoEXZpIcsKSjqlCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jqyuwk0zQDYXOi4yZNfgSF1MiPxRdKehwHfAJUuBT4o=;
	b=5Qr7TkN8SRjE4xCMM5r0sY+TEA9BjQ+M3D0V8JdOS0SGBgVkRPo/7h3s6eTATR8FTspw
	 fzu+JBnuV/E5LBJXlQE3xKjU7y9tU6E9xC4TVWsxaQNidHTtCCCEashMfAyH+G7UEAIiH
	 xUsWFbMl98jiBdkjqURMVaEj+rb7+lBvmFqI0H+dKfJlapRMXR50ePlinOjmXoo5rm583
	 QzRweSNu+Sq6BelaY9fDoWIxujcxkPBwgPuUeVzsEsBIScqvUaWtOzAoQre+XfFG2bjB7
	 N9a8IamLcSynmvBHoa4op8HdhvjqWCBAw5gvIA5fxlb8qHVxQ/8xbao8eHbL3NEVqsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W2+DlIw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB781606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2+DlIw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEBC1F0089F;
	Sat,  7 Nov 2026 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050069;
	bh=jqyuwk0zQDYXOi4yZNfgSF1MiPxRdKehwHfAJUuBT4o=;
	h=From:To:Cc:Subject:Date;
	b=W2+DlIw/iJ1nrEEWG8AJf4ZUHq/6q3ys8T8Jgi8M5s9XqxRB/p7cInuaocPGmqzWz
	 zmLM7bT+4NyheF5+NEzUW1iTSsZM2FdU+tR1iih+rKw91wFK8uKtSg5Bx8qZ4Ua+V1
	 1CJRMORMveY84Yr5KkHs0bV5KJSAv2N3FSO9YtqBMyrEwTx4E9fM3g+d7US65o9s6a
	 yjJFNdn3CAeKnCaZPUhFbfmCOeoy/e2ZF7nbNhT77iL+PjOVzSzKYCzQw0gEsRmvtB
	 aAmvWLT8V0io7WUSQgfbLI/raU1hUMKN1qxSeFyojV++/RQfFNHH7jky2d1WLdGrz+
	 Lm9nf9h6NPRtg==
From: Sasha Levin <sashal@kernel.org>
To: jack@suse.cz,
	shionthanatos@gmail.com,
	gmwgg05@gmail.com,
	npczmd@qq.com,
	jupmouse@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: Make sure there's enough space for LVID implementation use field" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:27 -0500
Message-ID: <20261107061427-failed-5.10-a61fb39759d7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a61fb39759d719a4f4966742b4d28387e33d81c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061427-failed-5.10-a61fb39759d7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




