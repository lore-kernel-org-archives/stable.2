Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256B37E5E2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574379; cv=none; b=H4SmkvEGblMv7XY698ct1P5I3RqXoTGLE+YlwTcaq1ah8zqQCLmkVFUPC2Vxzax2j2ey0Km9vZ+vCTHMi3H02hoFyfPIPQFUKDXZsWSRdvKIGUUpLQyARVT999aUTabbIDhXgUp80g94fSVpqGPUuBoveVYaQPqZN0BI7reJEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574379; c=relaxed/simple;
	bh=H1UpL8RE+4ubIeODOHRKKNMEkz2Emg2PEoozV6LwmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIwhU2/rNDcCLiOZ/ECeCd8opMreudi1EuBVY322gw8isxwQcbicN1QdTTdsU9iRt9QiF7GRAi20Ui3xuklpc1Z43FXZa0Rk/39h7/pAI0Pgds2C0/WjjT4KSavjQ4YwGkY0CmJmE6nChI3vnPcTMXun2pj3IAOxp9KMVNC0QT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O38rKOds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O38rKOds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024721F000FF;
	Wed, 16 Sep 2026 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574374;
	bh=z4+5ZDCl3IpaHTGAbKAbhO6uoQCfnp65A60IcD/kffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O38rKOds80hf/GQAKaR8NIeIGsYQ19kB2mHj4V/V2EAiFA8TA9kg03Dqh0tB6D5rn
	 M+JEIDshCpn/sKhtQGMFzcMg29Hve0ZV78zOsI8RnS9ovxSYJhoi/ocUsivARzXVxm
	 K6NXDmA9zAmSL1l9SPGMG1cd4actIlGIDTfMvOUoqbyhKO1tuoYr8jTz4lz5EdlBwJ
	 Nr+QRQA7KRljJMvDFuXGUhCFKWfecWv8D7gk0CXsNmY0lfZQJfFol1kES+DwNY25gq
	 G3r6HvMJVWrUdf3agc/2y5E5eUaOqEsWmdB35YeiG8XC82NA2en/KqWp4NdtHJB5sI
	 KsF/4bTI0P0Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] path: add cleanup helper
Date: Wed, 16 Sep 2026 11:59:30 -0400
Message-ID: <20260916155932.28397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091645-grappling-craziness-559e@gregkh>
References: <2026091645-grappling-craziness-559e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit ff2c570ef7eaa9ded58e7a02dd7a68874a897508 ]

Add a simple cleanup helper so we can cleanup struct path easily.
No need for any extra machinery. Avoid DEFINE_FREE() as it causes a
local copy of struct path to be used. Just rely on path_put() directly
called from a cleanup helper.

Link: https://lore.kernel.org/r/20240607-vfs-listmount-reverse-v1-2-7877a2bfa5e5@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: a7c1290eef60 ("configfs: pin the symlink target's dirent instead of chasing ->ci_dentry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/path.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/path.h b/include/linux/path.h
index 475225a03d0dc..ca073e70decd5 100644
--- a/include/linux/path.h
+++ b/include/linux/path.h
@@ -24,4 +24,13 @@ static inline void path_put_init(struct path *path)
 	*path = (struct path) { };
 }
 
+/*
+ * Cleanup macro for use with __free(path_put). Avoids dereference and
+ * copying @path unlike DEFINE_FREE(). path_put() will handle the empty
+ * path correctly just ensure @path is initialized:
+ *
+ * struct path path __free(path_put) = {};
+ */
+#define __free_path_put path_put
+
 #endif  /* _LINUX_PATH_H */
-- 
2.53.0

