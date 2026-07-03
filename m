Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4E3B47F9
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082008; cv=none; b=TlBCjJk76dL+rEuP1V0+x/Cvo2Hs301f3QRYkWo896HvZWenW4OBZJu+6rhHnPecYMk3QnUZFh8AC6dQI1VfEgPfNKiP/wQEdl6TYkpjHjQMiX/vhAmTwbKQIRPGDfILVisRw/HJQlExktEcKK/zyjPeob84Hbwybv95InwILg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082008; c=relaxed/simple;
	bh=R4H6mA5gWgQK/r/Y5vAxwtR8xNPHZPMqcOCUm0SRkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVR6PZcJyaXKrOWzPmCOk4vstXHQSZhArM6aDiTBGLvTUfQ6oMiVtU8fCxtbruLgbeNXkhf+QPGaC32WBGMRJZ5c2s0c90gbVEF0vwrsPK636LdiuGx9PdyccTw42vDwp+ajBvpEjjjil9W/GFKCEm9akFsn1Li4coDtByHs8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF4sT9EO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF4sT9EO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B19D1F000E9;
	Fri,  3 Jul 2026 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082005;
	bh=nTjSNYtdXhy+Eam8oW0BIKRqEAk0k0uZjWWAKwtBxH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hF4sT9EOhGoW/hBesVyTtw0+t29jIOzb8co5iSAayDTkRLjv73r1gYh3FxAXKwcQ1
	 dd5NdXv+mT/jySQVlZCpg18JT8Hu0ZhYWwkgoUPGm3b+cXVF572/N5RTiSBdrfP4tb
	 XCrRuYFici2hYxBJe25asjqKim6tM4PbcPsmt2GyA8ubI/hBgcNbRscKDmeWq+2dcH
	 J2o0lnIbjbGHThygF/Y9ePVyWmp9Bg0ConSnRV0hmeNR+L9nOn+6bl9FKWlT4zUmJN
	 h5W+pJ2wkt77jToCXQ99XV942HhluI1swQw3nqBIccm8aQrzWeuMtbMr86649Tgp0m
	 rddNVD03gjkYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Fri,  3 Jul 2026 08:33:23 -0400
Message-ID: <20260703123323.3944624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070220-unloaded-brunch-aac7@gregkh>
References: <2026070220-unloaded-brunch-aac7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 7eba000621fff223dd7bab484d48918c7c77a307 ]

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitialized memory which likely
will be neither NULL nor IS_ERR() and so may end up being dereferenced
(for example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization. While at it: initialize the remaining fields of struct
fwnode_handle too just to be sure.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com
[ Fix typo in commit message. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fwnode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 735f6f334a98ff..4b6bf73f272395 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -195,8 +195,10 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 {
 	fwnode->secondary = NULL;
 	fwnode->ops = ops;
+	fwnode->dev = NULL;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
+	fwnode->flags = 0;
 }
 
 static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
-- 
2.53.0

