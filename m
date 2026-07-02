Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997B32D0FC
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030976; cv=none; b=EyotD/x3vlnJE07AYFjD+IzY+Qm05mtoqjsLgLc2rsFMwTCi82AnSJciYnqoRHXMW61YcreeuJkBo9drGxpM1rSZO6skjdk/ffQr7HHMrhvoN/h4/G/M0YPQEIwVFLDcM9EzgDsrx3v7jcWP6y5Rl6LqyIlkL4QXp3sOcblcGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030976; c=relaxed/simple;
	bh=OpH6b+rTMzfY1VgG4nqaEPfax2xXaGKscfuCARbsFPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXY0hkn1GqoenZTYDOFC69fNtgdwLHrwQcbeENYUyyPuqwlY4PSxtQW4u3UqCTmU644hLBUHVSXz+KWEzdEl8kqFTzn0IxufOyDvnheZmRQfV1fWQTdBXKxc42DH22zzAPA1DuUcCDFl1z0lxdM2vX9mC//YfXDvnPepH0newb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlC39Y8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlC39Y8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B821F000E9;
	Thu,  2 Jul 2026 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783030975;
	bh=ciMCKRiEMoZ3pEaaSI/Xcv4O1V6tLfbeY6OS3OluM48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlC39Y8UERGArQjkt8oQ5yZsb4ZeBXaZSaiJ3j3LExQIDEsLk9AkZeMaxpVSgITtg
	 H3pVfatP4RbnpdI5g507RlyiVhxe+MiMqt5ct3yz0hIdYR6J/ypriVwsumTQk6+nQ4
	 7UkY3Ka3gZcIZkCxqkT5CfDjPw/XA3Bu8bIeavISNLzxgF3vlJtk4E1ftRbI/pmsGO
	 dwqF1d3Hsqc+J0JFFlRWKEeSHid7xeuGL2baAulZs/XmP8ev6gE9jvn30bikrDWViA
	 Fo7EfI2JIvOvA5NVryG2mBfW758UYRcVkHBA5R1EE6MDRNHDbHRvgPSwdEEyueRePI
	 ugxrx5g0n7mPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Thu,  2 Jul 2026 18:22:52 -0400
Message-ID: <20260702222252.3701173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070219-marrow-guiding-4009@gregkh>
References: <2026070219-marrow-guiding-4009@gregkh>
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
index 2ff409d740a1d3..0f219870f56f9f 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -202,8 +202,10 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
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

