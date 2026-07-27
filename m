Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325A3BF67A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190872; cv=none; b=q0hN4oBsJkPFSgIErYj9kw8isStAlj/FitzNeoHfMztV2e7nITgPCOAUDg8F8dgSTwg5CNSuFgjv4EQ+jjOKgrTW2RvheVl8LPJsURvkiyTS5iCiWLKKL5sTao3Vy1oMIlchbR1BYZPhQx6XwjzDhs/4sMdOY+z9qyaHBcEZBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190872; c=relaxed/simple;
	bh=GNx4eBmBX0DCoTrCTImCRHnZvPtw5Ba+/aG99nYSk5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6c2zXCwARx5rCIAaJScNOHAtIfuANOlJeTM984nuU+vWVfYpDum62VEVosUAP/m+oEBcIbTTBsu3O+RAN5u7U0KLq8eiyyml8/v6t//5bSWyFMyUGZGTfaEEQgm1b54oO5RB0qO3dWQ3gKotCzIRC7BQJ8QPbr+hKXORRHUngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b51S7l+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b51S7l+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364ED1F00A3D;
	Mon, 27 Jul 2026 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190871;
	bh=7QB39k+kfewc6jearhYDlb++n3Mv5tQ2oOgaohnPcBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b51S7l+xHUYjaZ6VJFDsdis9gA8cJrmuB7/nE4VLwNnyaaTjofSpgolPq9dUUehB+
	 0t4f2uYpvhG7QzcwNkG1KE0rTLIxQ95T5jI8egSbht24MOfzgz4AbL3wZ2J1cWrNWo
	 HYp4ZloD6Cp9HGD74SMB161GPD22PfqYa1bC/Bq7FDoFbiGrTk0QXonBpvMNRbku0N
	 L8gsf0nqc7qAjUz+mVZUPGCVCzUfcHiEj7K19VrGM+a+CEckqmeEnmUJrv49dSjM4D
	 HcvV5qPRKJ7AFTjtNPOucn5K/ClnkBA10M4LXiJO7Akc8yP5d09yoJ8+lNr0s2WGzz
	 uLpJLKI2AUu6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] cleanup: fix scoped_class()
Date: Mon, 27 Jul 2026 18:21:06 -0400
Message-ID: <20260727222109.2119761-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727222109.2119761-1-sashal@kernel.org>
References: <2026072043-kennel-tasting-5eb0@gregkh>
 <20260727222109.2119761-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 4e97bae1b412cd6ed8053b3d8a242122952985cc ]

This is a class, not a guard so why on earth is it checking for guard
pointers or conditional lock acquisition? None of it makes any sense at
all.

I'm not sure what happened back then. Maybe I had a brief psychedelic
period that I completely forgot about and spaced out into a zone where
that initial macro implementation made any sense at all.

Link: https://patch.msgid.link/20251103-work-creds-init_cred-v1-1-cb3ec8711a6a@kernel.org
Fixes: 5c21c5f22d07 ("cleanup: add a scoped version of CLASS()")
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 981ccd97f715 ("dm: avoid leaking the caller's thread keyring via the table device file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cleanup.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index e6e262ec359671..f019c6666956f6 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -277,15 +277,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
-#define scoped_class(_name, var, args)                          \
-	for (CLASS(_name, var)(args);                           \
-	     __guard_ptr(_name)(&var) || !__is_cond_ptr(_name); \
-	     ({ goto _label; }))                                \
-		if (0) {                                        \
-_label:                                                         \
-			break;                                  \
+#define __scoped_class(_name, var, _label, args...)        \
+	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
+		if (0) {                                   \
+_label:                                                    \
+			break;                             \
 		} else
 
+#define scoped_class(_name, var, args...) \
+	__scoped_class(_name, var, __UNIQUE_ID(label), args)
+
 /*
  * DEFINE_GUARD(name, type, lock, unlock):
  *	trivial wrapper around DEFINE_CLASS() above specifically
-- 
2.53.0

