Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9A3CB54B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186003; cv=none; b=bQQvaLC3LUTksmEESOb0MQQSVYUB/bOBsogTbzzo3qNlC5OW1sRRKBoRmzHQI2NDvnkQZfvbve4B6yzohohc5DNwdfz1SEbWBdYqWLtrJrMj1fNKXagrqMyj4x/GMrMez83TwW849rh1FUmC1hQFGYiWz1qyjI3eG1wiGi6Qm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186003; c=relaxed/simple;
	bh=XTtvXRZoCRauW0bhN5K0SvRc2QE22phT2f0ANCYT03s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsUuD6UozcZl7ozDccKn+430SRglIrt0gk4+BRivtffm06Ve/m/qmG7r9oGyv6p2aubWZAHuM3qPQFLxywpIRZOp8vIPBdc0t8u3rMCfa1cFWKWPjyaFov7bLqlneTPhuwDJdvGM9y1OybWl4v1taodq4HXiJ4qi+8EzYRLM7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWHrhDgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWHrhDgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062AF1F00A3D;
	Mon, 27 Jul 2026 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186001;
	bh=rvFoiaF078TS24eYawIAhK6ZgK/F7VkJIQupvRoHleY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWHrhDgxdjea8A62UsCTInn8FskMW4z1HHJILv/RLnqBe0uYtue14eq7mgBHMqXnD
	 tBkBLZbJ1IKLPynYqZX1DN7lSjL9NA0SbsR3LrRVV5BhBqyvUIeqf9nejjXWIEVIj9
	 MkPIKtKV+9m916uizAnKdaaezzXPMOXcT+uMw8BrdKRJASMZCy+V0tFG943xB/pE0K
	 TD04oGSIMHtA3rSXYa6q9A5Fo0j/sWjDHMc0K8owNPIVOG+4psESXaqFvvftcRkAyZ
	 S0hnSfsbJhRlAbm3OlNK3+T3FYMjFKdHRf8Kqb+Xe5fIkogkTGDnHNCbIH0D4NN2bJ
	 WRXzMWe+hhdcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] cred: add scoped_with_kernel_creds()
Date: Mon, 27 Jul 2026 16:59:57 -0400
Message-ID: <20260727205958.1929027-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727205958.1929027-1-sashal@kernel.org>
References: <2026072016-oppressed-overstuff-75e8@gregkh>
 <20260727205958.1929027-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit ae40e6c65791f47c76cc14d0cce2707fe6053f72 ]

Add a new cleanup class for override creds. We can make use of this in a
bunch of places going forward.

Based on this scoped_with_kernel_creds() that can be used to temporarily
assume kernel credentials for specific tasks such as firmware loading,
or coredump socket connections. At no point will the caller interact
with the kernel credentials directly.

Link: https://patch.msgid.link/20251103-work-creds-init_cred-v1-4-cb3ec8711a6a@kernel.org
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 981ccd97f715 ("dm: avoid leaking the caller's thread keyring via the table device file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cred.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 8ab3718184adf8..be2cd07b174c5e 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -187,6 +187,14 @@ static inline const struct cred *revert_creds(const struct cred *revert_cred)
 	return rcu_replace_pointer(current->cred, revert_cred, 1);
 }
 
+DEFINE_CLASS(override_creds,
+	     const struct cred *,
+	     revert_creds(_T),
+	     override_creds(override_cred), const struct cred *override_cred)
+
+#define scoped_with_kernel_creds() \
+	scoped_class(override_creds, __UNIQUE_ID(cred), kernel_cred())
+
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference
-- 
2.53.0

