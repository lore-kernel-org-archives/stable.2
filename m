Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E1314D1F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084459; cv=none; b=YsSQk9KA8lOMj29vtgSGFW46wiwOOaWcreSksEvJB7aCMJcV4iCL0jRNwYpkUFGuLYtJpxGKb0MJeb+tp0ohNOomHDVsEyrs6sUHWLWRwHu1yIn1U6IcAPR3GQGwcwLLOYw/4BY2LRlQ/uFFA7eheBxMfsdz/g8zkSnOZDUCpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084459; c=relaxed/simple;
	bh=UeUHf9LkHO95zs22zUTdMRAD6/7uwZLMA15ryS0SRSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGzBGQ+b/n0Vgz1ujA70o/btdgR6lAi/LnhVd5b6uQcxRHPKTpKf3m7xJwwhMRrtND5cSy9ahg43hUeyU4tQcmiMd2YoZM+NI4XjtKjh8fN66rAuzxio3xXSkRjzPWriiuaMQFjS5D4S4pWpDK/Yz7C8DzaLxlOlVKdeE2EsRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMNTogjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMNTogjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23991F000FF;
	Tue, 22 Sep 2026 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084458;
	bh=LBEFCTq2v1vlAW9vGN4S0NSnoS8/2iKFCzpxs77wwyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMNTogjqqLDZQNx84fQoI1sn8d3DuKUrshkpx7MpbnNzRQLTvPuTVc3ycLFrSOS0Z
	 +929BGvHN1kUmxOLK2nkocG9gFn8QXmCMlEMcSd74lENGUKOnMv6EkniDXn5yhKNnC
	 Bhyo1+RKxP2EwIJFbn6pQoSaE2LwWzDCZnJ7N0VZb8s2Cwih1kkQPDayTRrDphEBX+
	 2xV+IJnGxFBV1NWcjgimn3DicX+zYZ3u9UcUFuu+Ns9Kz9N7clbtkIGafmCPU3krRh
	 KGfmNjQgJD7yX7ftOW1wWQr/y7jqK17XZhSd+uwh2Vny6fRep9g4m2fRDLNtn0BmQq
	 RA0ulOZOyPsUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Tue, 22 Sep 2026 09:40:54 -0400
Message-ID: <20260922134056.2503713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092256-genetics-desecrate-9b80@gregkh>
References: <2026092256-genetics-desecrate-9b80@gregkh>
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
Stable-dep-of: 0d1cb83337f1 ("ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()")
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

