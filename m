Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657470;
	b=qUSyzqPg20nAYp20U+7cCvsAItZuaM9mlfprGfvgL2tV327eyPTqGaqPMVeS5wgOhtLF
	 YpZN6mx+2LoFf2AS0OQIpRZ3Y5Kex7zI6J+Jl21xN7cb2cXl7awqElvtFKNBn6CCCPv2f
	 zBQ2KIyZq8YIhwF6/Ad4EvpM3eaM9wyGEgW3YcxrV8ZbHd8PWBrONyVf08PrmUc+lF1Ci
	 +qUIiqCZP9eqUT3k/F/0UghKxCft8Q/Z+Wf71ePDTndgSvHdmFOvJ4DrYXmlSN6Hg768t
	 PxBXu1xHYjqY1SqqhY8On5gHNKOHKIcmfVcdf68dcg0gJulYgpD3loqlN82xfy3kitA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jj2RpMYUCgmZMx2hXck8/XUVLfSK0a4k5R9erFbjQ1k=;
	b=bjMSKKwN1NVWosW7WAKUe7B5+ceAEMlfH0+YdD78mF7v1wSOOiHYsH/t/V4qioJO8tsG
	 FzLGbwqVRA9v5LJqzKAcFu2XeQMJ3orDnk4VV8+rxvs55P24QnNxvDhy/dw8GOiTEJwEP
	 UAoJRhO6Y5rf/EIyeK2wlHvYIL6UE2XA35lDywcZX4jL9XQA6o6HK7vzke3pv5p7N4hgx
	 Kwzew8mBhZ1x29+EsHuvLO/6HX2a6fdmv0EERiA/jhqb/zQftXP2NH0B9iYi2YBkgNcq8
	 VVnJZykuDsn5q17j3NLQ3bJwcNffrn6WDYe9Bw9BO8UWS3uJNQJMhEqrzBV2NwV2oqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjvfXIz3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287A606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjvfXIz3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF7C1F000C0;
	Thu, 26 Nov 2026 01:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657469;
	bh=Jj2RpMYUCgmZMx2hXck8/XUVLfSK0a4k5R9erFbjQ1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VjvfXIz3z0DRJeWVAPuKB/ol0DerOlpVe0DpcaNa3XM5ms0cAydYTqCxgEhG0zQ+s
	 QO+AED3p6aQbquUX5WD5u8izGfrHZhrKq63z3wDvQ9/cZFV4VfOzERd6v5JG7CY2cP
	 9vosQqpJlzPsojWVAmWJI3M4zvjphqsRv4kRJYOfG5TYBKaoOE2rrhNw2jkVe080Yd
	 4GCXj21LuucIoSregEDcK928WYDfg7x3olfQM1T5ZRBb8YcUi1SONOPDNvZVb/qJOq
	 7XyT7WpPcVYfM9LH/gbZ5TdX8MrF6eNKuLmagq5ZronIE9H1HCmmOn8Bbp/bcZoI0E
	 z60+Gxd65v0/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ovl: do not read the flags of a put upper dentry in lookup
Date: Wed, 25 Nov 2026 20:44:26 -0500
Message-ID: <20261126014412.1696101-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126014412.1696101-1-sashal@kernel.org>
References: <2026112529-hunting-smugly-d292@gregkh>
 <20261126014412.1696101-1-sashal@kernel.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 7031366be218f291592a7ad38bc34a7cd1459737 ]

ovl_lookup_layers() passes ctx->upperdentry to ovl_get_inode(), which
takes over the reference. If an overlay inode for the upper inode is
already cached, as for a second hard link, ovl_get_inode() puts the
dentry and returns the cached inode. ovl_lookup_layers() then passes
the put dentry to ovl_dentry_init_reval(), which reads its d_flags.

With a local upper fs the put dentry usually stays in the dcache, but
with a FUSE upper whose entry has timed out, dput() kills it, so this
is a use-after-free.

Fix this by taking the revalidate flags from the upper dentry of the
overlay inode, which is the one that ovl_dentry_revalidate_common()
revalidates.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-986db859-840c-479d-944c-b9c43b93377e
Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 0ec6b9b3c4baa..2c962a53cc59e 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1390,9 +1390,17 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 
 		if (metacopy_size > OVL_METACOPY_MIN_SIZE)
 			ovl_set_flag(OVL_HAS_DIGEST, ctx->inode);
-	}
 
-	ovl_dentry_init_reval(dentry, ctx->upperdentry, OVL_I_E(ctx->inode));
+		/*
+		 * ovl_get_inode() puts ctx->upperdentry if it finds a cached
+		 * inode, e.g. for another hard link, so use the upper dentry
+		 * of the inode.
+		 */
+		ovl_dentry_init_reval(dentry, ovl_i_dentry_upper(inode),
+				      OVL_I_E(inode));
+	} else {
+		ovl_dentry_init_reval(dentry, NULL, NULL);
+	}
 
 	return 0;
 }
-- 
2.53.0

