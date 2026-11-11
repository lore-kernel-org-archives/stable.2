Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415879;
	b=dGyTMV6Dwo8rm3igNmT0qTUXA4WA7k6qPtfmknphdAMU3E52peUqebGsiWtAWv4GKSEK
	 q4FLEOzMavwR3O9LR/mvcI2NnE9wXC19J4Pb9n90As40fFOtUkgFz4L2qejYXZQd5eS3n
	 PYqNsRowY3xrz+otBmDR1v+oKLUD9L+X+ZBZFpn/bYD7WasmOZYTvKLNiwI0aPxIYG5eR
	 DcZHdOy/kHiLDZpnCUY0sJX3jfjgdau60GjG6ZiEs6dZ91l+iP2TDDuC8Eown51tnnnTN
	 2P4Wke7zU60gOuEpnNi1HhirG/JPTxfIGUQykSXCXtRzDyenQoPoCGET9uI6dOttPnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pJ7xwYs37XlnxEQvkg2WIWg6N4W3MeTpMh8BRRyQEB0=;
	b=sLdI9Iqntz9WIhLQlZ/Z01J44AECXj6drCEyp5jbCUqo6NIufdWrXDVZCrzRWecLlchM
	 6JjKwUq+Ku9SORk7vDVKQLHl/FxAprhFskrpraq6R0pUz/zPKc5PBqGymle0W14ogLpLI
	 Ss+EBK+/5mfAuprPtxfpzDbE4HuTvzjZ415fNbpGcInGmFCw2ldFcsq/tTouKf0Vjsc8v
	 IH+hHLiVYXa9ec/F8er+hHg1WBcpdhPUa2GC3H2hKu8EdzpfO5hdt0YI7bOhpl/xa9Tat
	 h23VDbRpCYCPRXzF6wFT2DvpKwVmWWXgFmWkVtW9Hti0mhx2OS+7EfgXqDG0FNpkBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQaGjEZt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2B606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQaGjEZt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925D61F00A07;
	Wed, 11 Nov 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415879;
	bh=pJ7xwYs37XlnxEQvkg2WIWg6N4W3MeTpMh8BRRyQEB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQaGjEZtO+zShpFdavwGPR1AtnPxg2MDkWpiqRxudL8BkESm6advX+jtIenPnMCbE
	 4+OpvLVxUF0W0kKobwuAbzAOgmRM2vO82045SXIMg+z581p8jKQQxrbaF0goGuri/L
	 c5aOR2G5y+cbib4teimmC9ZkaEYFiPcoxF1x8nHf8/UpwEPtCKxFAr4oJF5oU/7glm
	 YreTv6MXEIDckdcSjPcCzNw1hTA+dINhm3J02u99khWosS1hieuoH6GUiMY432C5t0
	 rZ+/DqcO7UCMVlk9YtIjUpZmKxR1E00S6ac3fAZ8tvmUjA6wzHgEs99tJStTArD6Ba
	 m4mIvr8iySDPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luo Jie <quic_luoj@quicinc.com>,
	Yury Norov <yury.norov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] bitfield: Add FIELD_MODIFY() helper
Date: Wed, 11 Nov 2026 11:51:13 -0500
Message-ID: <20261111164957.3294291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052239-failed-6.12-ea9854a169e9@kernel.org>
References: <20261107052239-failed-6.12-ea9854a169e9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luo Jie <quic_luoj@quicinc.com>

[ Upstream commit a256ae22570ee4c3427fdc703a58a89afee6a332 ]

Add a helper for replacing the contents of bitfield in memory
with the specified value.

Even though a helper xxx_replace_bits() is available, it is not
well documented, and only reports errors at the run time, which
will not be helpful to catch possible overflow errors due to
incorrect parameter types used.

FIELD_MODIFY(REG_FIELD_C, &reg, c) is the wrapper to the code below.

	reg &= ~REG_FIELD_C;
	reg |= FIELD_PREP(REG_FIELD_C, c);

Yury: trim commit message, align backslashes.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Stable-dep-of: ea9854a169e9 ("spi: cadence-xspi: reject SDMA transfers larger than the requested length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bitfield.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 20978c60b565d..c60554acc16dd 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -8,6 +8,7 @@
 #define _LINUX_BITFIELD_H
 
 #include <linux/build_bug.h>
+#include <linux/typecheck.h>
 #include <asm/byteorder.h>
 
 /*
@@ -38,8 +39,7 @@
  *	  FIELD_PREP(REG_FIELD_D, 0x40);
  *
  * Modify:
- *  reg &= ~REG_FIELD_C;
- *  reg |= FIELD_PREP(REG_FIELD_C, c);
+ *  FIELD_MODIFY(REG_FIELD_C, &reg, c);
  */
 
 #define __bf_shf __builtin_ctzll
@@ -156,6 +156,23 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
+/**
+ * FIELD_MODIFY() - modify a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg_p: pointer to the memory that should be updated
+ * @_val: value to store in the bitfield
+ *
+ * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
+ * by replacing them with the bitfield value passed in as @_val.
+ */
+#define FIELD_MODIFY(_mask, _reg_p, _val)						\
+	({										\
+		typecheck_pointer(_reg_p);						\
+		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
+		*(_reg_p) &= ~(_mask);							\
+		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
+	})
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
-- 
2.53.0

