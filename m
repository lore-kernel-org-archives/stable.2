Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4526B08F
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221123; cv=none; b=ug1ZSeWkuQEH7K91VYeXM2NMe5CUuoefiu2M3ODhhF1MKs5yHbhZEG/cJmtIW6E8Ag8prv7qeFryDFDe6oBGJar2UH21eZ9qC7T8EU7l7mwcryg9ADRc9dpIlwflF/uj66/cmhTwQRO+fhdF8r1ygbNgTs3GHMWhMF2/i+XSGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221123; c=relaxed/simple;
	bh=6swZ3nHdXnHjaWmKCXCqA2jFFDjAuymthj9DtkQl90k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvytfism4g6Jl8oXAQEEffwV8wpCfo1IruZ/Vf56fLyvoMrawn43xbOV0UN25PHwZ6DdQla/FCR0quBsyXqPymD8ZsCTo2itn23vRkbu0uFq3KOuiv0N5vHXLLsDsKR6KbwgltFs3FQWFTkLN9JTELrc/SGyL1yXh0LPJlKZ+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8F6Z7h5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8F6Z7h5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA411F00A3F;
	Sun,  5 Jul 2026 03:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221122;
	bh=bJpmbuWHAmYr36IyDgSThWk9cZ0st8mcvrZAtq40IG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8F6Z7h5O6yD40KvRfM6bg5EKzV095aopzygybNG+0RBjFoRoUeLbbH0AjMzqWDVB
	 o0vh6G8zPpwJir65gcBBhKgrJNbTMJ1QAyl0iVgPB2Xkqf6D3uYBXnfYH3BlZhtwGN
	 PFMIMV3EtOHC+ZYWwODNUcivTjxfnGSiDNev4KPacR4RfnxJhqZ7yPgkdFs9C7i4Qo
	 rIGwhINQCo743+VggqffIKVvRqGntsaiF+0RO1Holfut0ie1ktovEQLzUojmsn2aQ7
	 bLtXDhsuNv8CtksgsCXhtpH35GO71u3xGOSmWEYG2K8cxprXQe8bGewU0MxsOOVY6+
	 WPp1btI6b/dwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] i2c: core: fix adapter registration race
Date: Sat,  4 Jul 2026 23:11:56 -0400
Message-ID: <20260705031156.1601242-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031156.1601242-1-sashal@kernel.org>
References: <2026070232-straddle-keenness-fbbc@gregkh>
 <20260705031156.1601242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ba14d7cf2fe7284610a29854bdff22b2537d3ce6 ]

Adapters can be looked up based on their id using i2c_get_adapter()
which takes a reference to the embedded struct device.

Make sure that the adapter (including its struct device) has been
initialised before adding it to the IDR to avoid accessing uninitialised
data which could, for example, lead to NULL-pointer dereferences or
use-after-free.

Note that the i2c-dev chardev, which is registered from a bus notifier,
currently uses i2c_get_adapter() so the adapter needs to be added to the
IDR before registration.

Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
Cc: stable@vger.kernel.org	# 2.6.22
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f5338a8441a66a..1c8fe902d43dab 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1556,6 +1556,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1629,7 +1633,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1665,7 +1669,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
-- 
2.53.0

