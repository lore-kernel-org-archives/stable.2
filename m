Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658263;
	b=utLLMXf9ikMXvP630q94/wBJ0uOzMRFrT3VRMJLzU1CPbycXbtWZAOsjegYVEM8wYqM3
	 k52GC7KauSleOCMuEqWbj2TOIUXangTLXz7PWlE8ZkSWFGwi+bwTPc7FJ/9YSgTe/klIF
	 6ZD4o1iLwjyQFBt7vLPEDhzs6IXuCVatOF0rXz3wRv7G5vPN9PgSxl9YdzBtocyIQctke
	 tokPP3r+8niCYVqmA72lI7NIr9l+VIz6XEGfDTSu+Iz0YKcSZROMb2pRydv4qDPHXlzNU
	 Y5aJxUm+Ed97fwLT3xYzgj/HODh6Vu69FcMQfzNY12LGoccXwBE6WUo0QIQrJTdDvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rpcC30nipgD+Jtsoj1QqYe0QMDzWwaiMwVYpe9Hn0lE=;
	b=ZCuwIfuQpxO0qAvo/uUKtg9J170Qka+XtSTPnXHphgHYzS7j8ERAvXnRiwngYOx38ANT
	 h6OcbfjsDD6+S6DEXSaKhFPi2Y/7m5QK3HdZ7kjZKVpka4gDHhvOMhQXN83KXh+J9yjFA
	 dN5N7hqlMpoytwbtDVFe6WiBxDvQb6UGGtroSxkOrL9lHc5dIKRSX9OL0f1sTS2TAZca5
	 6via77/b7Ut5CMhi7FISFA8K2KlixnCk6IHL2jhNyDg+Fns6VMaKQkNyhdMSeG7zBgts/
	 /oQvrybUSmlqNSiIvXVe7ybqP18z/mvT+iB+zRxkWPNtvjKMWST0jQXXumwCts7okww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxBr3Ldg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83129606A32A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxBr3Ldg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37A11F000EB;
	Thu, 26 Nov 2026 01:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658263;
	bh=rpcC30nipgD+Jtsoj1QqYe0QMDzWwaiMwVYpe9Hn0lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxBr3Ldgbtu09Y31R7WLJK2yN4fMMGR0OG1RTTz4+bGacpk/aXEaIp9rumJjwubI6
	 CRlr2FKfrrif9RTS+Rsm0LExkHakMqww8IdIUNz+xMR1XC1+NOFdNCSOOVPyMBkpe5
	 J/mYZh+TM92GeoqsQO60n1MyUVQjC+v9AMXOc9RS4fB/JE12aFa+j6V6ip3I7wYQAb
	 rmifnDqdR8LrzIwvXnbB+Vx1hFTCd9oSFh8gBUIAS1nsKzGOF0VP0D2OTUQiYK9V8d
	 bZBl8ylteSfwbXZWlK9ToN7LgLykwna7881JpSFbbLwuYEnYmPC+xKpp+gAMWgBFi/
	 Q8bSEh+WDJ79w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] ovl: do not read the flags of a put upper dentry in lookup
Date: Wed, 25 Nov 2026 20:57:37 -0500
Message-ID: <20261126015719.1731625-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126015719.1731625-1-sashal@kernel.org>
References: <2026112530-preplan-eldest-5662@gregkh>
 <20261126015719.1731625-1-sashal@kernel.org>
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
index 2eddcaab781ba..7053a24f42d99 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1363,9 +1363,17 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 
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

