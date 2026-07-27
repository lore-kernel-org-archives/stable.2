Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542EE3BB67B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190872; cv=none; b=iQ6lIbzX6zPPckKgXE0YVdbo094owiaORn3cG0v6PfS1UoSEa5bWuO+aL+ItFavRCaZnnN0v1G5SqgjIoDzT5rNnU6JYmxHV2nbOdBWEII1mUGN3EiZPZo3eUVlFxFUMvvCJVa6aMoRrhuugPqT2Aidts9d4lOTNu+1BJr9q6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190872; c=relaxed/simple;
	bh=c/0RQZlPY4XblCBM1h7idhOx8gTJ+g78QPLw9jVJ7H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxcFTU+PhlntPvTV3WWtquqw1kl5h3Vw11xSdxCNdmwH1Cw3n+tjQQzkDLH70HTjiqO92+sQ7bbNlU8lez/VvbqOIkt/Qn2uJ4gi5FiS4uC9Y82Z+Gm009TvSoWpvAOuIXiW9bJ2U3xWBYZU3/pN2H4zZpHreVFzcwT3Dzuy3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvCrjMkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvCrjMkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1AD1F000E9;
	Mon, 27 Jul 2026 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190871;
	bh=H11fWXD50OO66agNt2yCCNBTr5y1X7JO1seD4C4o2jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvCrjMkPzruziJO7kDoHUTMe/JhOu8eRWpOnvwwOK21PbLcqbyb/mvQsfb5GkKHfL
	 S2tyDqTs1obPjywYWkZi8XlCqXSsnG5wPaZdhDRdx2Q7LukGUNyo5itcJPtTuTpxBm
	 LRvcREBVUR0qi2G6120RGUkYimZbitvgs9fsxETwD/0b17lg8iq1vCuNjDhtlH72dJ
	 ZdFJ8npd4v4No7OnHERRGL8ocORB6vTYpaort3z0tBLD8K3w6no14hUgUSfUdJi/Dz
	 JI2s9UpApDMhcEYNsvhcLQw2IrQ+TeeQFHf/lN5XC5JTDZ+4y6+CeI5qdU8IH49PWS
	 ttp0kouKClQJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] cleanup: add a scoped version of CLASS()
Date: Mon, 27 Jul 2026 18:21:05 -0400
Message-ID: <20260727222109.2119761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072043-kennel-tasting-5eb0@gregkh>
References: <2026072043-kennel-tasting-5eb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 5c21c5f22d0701ac6c1cafc0e8de4bf42e5c53e5 ]

This will make it possible to use:

scoped_class() {
}

constructs to limit variables to certain scopes and still perform
auto-cleanup.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 981ccd97f715 ("dm: avoid leaking the caller's thread keyring via the table device file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cleanup.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c1b7ec52446420..e6e262ec359671 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -277,6 +277,14 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
+#define scoped_class(_name, var, args)                          \
+	for (CLASS(_name, var)(args);                           \
+	     __guard_ptr(_name)(&var) || !__is_cond_ptr(_name); \
+	     ({ goto _label; }))                                \
+		if (0) {                                        \
+_label:                                                         \
+			break;                                  \
+		} else
 
 /*
  * DEFINE_GUARD(name, type, lock, unlock):
-- 
2.53.0

