Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140532720C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447053; cv=none; b=Zjjmx223mItIHWcUb6Ys3jYtQoXZEGy4TtNeu8tHk74aMw04EqTiVdYX61ExU/cJiHz/j14wL/OTg1RUEEMBh/Y1twc2g226H8UDjtabun9L47c/sISPN/cgbxA+eONyYOTo6q8BDbAGY6lC36mxJAn5JzkbhOwdlrCdz9khFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447053; c=relaxed/simple;
	bh=+wuHo8ozVdUuTxnavWUMONxAKt+BH51JozL6JQEdV0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWiZpkPaKggZxc0sQGmkSbOmcmXm+MTrX5pOdt7q9GZ89DcrQTDd0bF6ciOXJuxTrLNwg5smmSP2B8LSK/qs75vWfACwRHIs/TdWbZhzHsVi5njyW6Jzfx4zQFjyljLvY+zzU7rgBkPlvSvWgYwVzW6EZknnPuaVuTuNAswd2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2eMidBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2eMidBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC8D1F000E9;
	Tue, 11 Aug 2026 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447051;
	bh=bvoqAGR03ZoRj6Sgyih295H6oLY7uTXEFkN0LHqoRCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2eMidBYMwmPKd6eTIIy3K2SMobSxfWeFxxd9u8QFNGjHm+u1EANWCVfjLAdTgR4K
	 /VZrULQPu5xPW0IqbKOkOFY7NTGia9fGx+/2ad4FK1KKd98sNNp5GMV9rFS90z4gif
	 TF3PD+Obn6SS3ex53rtqcMghGB5pOIVLvfvJX34zR4leg0SbcOQ72/gVv6pd27VNP8
	 EZixt9XDIHckWjwq37ni8LDv36us+OzBGQopZbg58DxwOHattSRSdz6CLdKSWUFO/h
	 psycwdPZb1D2inwN4bWSap93tF5xlQYlG8lN2QHKBgrGFysZ+zX81+yk4pb2vXZhB9
	 aPZrmUfDt/jKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] overflow: Change DEFINE_FLEX to take __counted_by member
Date: Tue, 11 Aug 2026 07:17:25 -0400
Message-ID: <20260811111728.2259626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080501-hassle-thinning-e82d@gregkh>
References: <2026080501-hassle-thinning-e82d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d8e45f2929b94099913eb66c3ebb18b5063e9421 ]

The norm should be flexible array structures with __counted_by
annotations, so DEFINE_FLEX() is updated to expect that. Rename
the non-annotated version to DEFINE_RAW_FLEX(), and update the
few existing users. Additionally add selftests for the macros.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20240306235128.it.933-kees@kernel.org
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: cdc36db204ff ("Bluetooth: hci_sync: Fix advertising data UAFs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/overflow.h | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 1d3be1a2204c3..8e58a9ec76e10 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -246,4 +246,72 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 		sizeof(*(p)) + flex_array_size(p, member, count),	\
 		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
 
+/**
+ * struct_size_t() - Calculate size of structure with trailing flexible array
+ * @type: structure type name.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of memory needed for structure @type followed by an
+ * array of @count number of @member elements. Prefer using struct_size()
+ * when possible instead, to keep calculations associated with a specific
+ * instance variable of type @type.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size_t(type, member, count)					\
+	struct_size((type *)NULL, member, count)
+
+/**
+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass (different) initializer.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ * @initializer: initializer expression (could be empty for no init).
+ */
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
+	_Static_assert(__builtin_constant_p(count),				\
+		       "onstack flex array members require compile-time const count"); \
+	union {									\
+		u8 bytes[struct_size_t(type, member, count)];			\
+		type obj;							\
+	} name##_u initializer;							\
+	type *name = (type *)&name##_u
+
+/**
+ * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member, when it does not have a __counted_by annotation.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @type structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@name) to get compile-time size of it afterwards.
+ */
+#define DEFINE_RAW_FLEX(type, name, member, count)	\
+	_DEFINE_FLEX(type, name, member, count, = {})
+
+/**
+ * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
+ * flexible array member.
+ *
+ * @TYPE: structure type name, including "struct" keyword.
+ * @NAME: Name for a variable to define.
+ * @MEMBER: Name of the array member.
+ * @COUNTER: Name of the __counted_by member.
+ * @COUNT: Number of elements in the array; must be compile-time const.
+ *
+ * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
+ * flexible array member.
+ * Use __struct_size(@NAME) to get compile-time size of it afterwards.
+ */
+#define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.53.0

