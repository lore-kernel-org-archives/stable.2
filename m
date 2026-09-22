Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37C47AF6B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099764; cv=none; b=sKYTegIKH8iwVLXzb3S1hguuUExGdsUKLKTQPEmKQsMf82zDYJb72/VmDLva9C+LZiIIWPWR4eU+0deYko+TexSryFPLMnoCfSiFOUpnijipl+u7y9wbaqNJ5alcUCep4z/zuXmKRqUgCWBHqKikSDTdPhzOJcv+pFYPFHEMiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099764; c=relaxed/simple;
	bh=8MzoaxLbGLeuAP6b6ZY+NSrxaHjOZxeht5t3gktjA9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWHxUsa/a8gAo7QNTjYiwZJs9+RgX6pSTnQGe0x0mxsxZVW+Det/nrWc2lk2O6BlHGbWqJGoRq9gr+okpimDWfgkNzMta/zLw4MBahkFYOjJAVc+0Vwn5Ktlyf5gtQ1SDB3cM85sXougqm3ktNhsj0F7K26ejGqOuG29yg2VSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz6rrOBn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz6rrOBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA211F00898;
	Tue, 22 Sep 2026 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099763;
	bh=ksVBPM4h67+67DTqJoEEisHdHWmZqMcSOFNHK20JJ/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fz6rrOBnDCgETixHcxLx/vRyI3czOEV3u+S8LAqj5j6ZZBBwx7grue4VoSTHsiA2J
	 1RjR3wdKrDr0cUV1G/Q49u50At182UQWAKWkcgOU9Mzpt4/VzS0A7/awmuxKbHNpHs
	 jsfMU5QrAl81E6OG6FnZU7709G3gnjsEL32mk2tE+fCGKGnVMRDTDRoSKb1rhbicty
	 yEux3Qi+U/CLP2jENqls2FduMd07XT+/InAc8r9yCVFAhdNqpFgGdgOJ8fdqNodxDG
	 pp4Y8nEdGHnt2exb3lfSnN49/cwvEorSC0xkHBDPCTZM3a46d+c4trqNBQzjlWdvry
	 BjLaYaBucK+ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Tue, 22 Sep 2026 13:55:58 -0400
Message-ID: <20260922175601.3321063-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092212-macarena-tidings-7d83@gregkh>
References: <2026092212-macarena-tidings-7d83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 34af4554fb0ce164e2c4876683619eb1e23848d4 ]

To avoid issues with out of order cleanup, or ambiguity about when the
auto freed data is first instantiated, do it within the for loop definition.

The disadvantage is that the struct device_node *child variable creation
is not immediately obvious where this is used.
However, in many cases, if there is another definition of
struct device_node *child; the compiler / static analysers will notify us
that it is unused, or uninitialized.

Note that, in the vast majority of cases, the _available_ form should be
used and as code is converted to these scoped handers, we should confirm
that any cases that do not check for available have a good reason not
to.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20240225142714.286440-3-jic23@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index d8cd02433f910..36ef19f8bd08a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1279,10 +1279,23 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_child_of_node(parent, child) \
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
+
+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_child(parent, child))
+
 #define for_each_available_child_of_node(parent, child) \
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_available_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_available_child(parent, NULL);			\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))
-- 
2.53.0

