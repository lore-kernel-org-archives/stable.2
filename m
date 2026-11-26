Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658635;
	b=3hlyjwLg+rqGYL8z9OC3k5s1RCXdna1PdVSXo3NGj7c/vheC1aF+6YaTYNO1zUVuj3H/
	 N63jfQSgBw7Pq6d2wtAWuAIpSMJ5ifdNbn+cwSw91j0LMrAhwAIul6XeFgX9layShNOXr
	 C0GkT3b9LfwMpvbnv2d8ZspOzrMGkaEfPWPOsIkYWMuSgEj2V5uwhEETTkY0C5Hyyh7Xb
	 +Z0YdV0QvQdf/RVM+LUQ56JURnCd+uW3DrkudNM4vGqpMI8Jy6enXxex6HDPjFssDCvuM
	 vC/suz6tBa2kkhCCY6tdZW9DO5qo9ELGDWAEuPcPjPOJaiV8YBuyk02p5iXynsvOFcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9b2S5lfg50XURyB9KP1KeOvHCshhyUy7DtAlMUFjvdQ=;
	b=4gBPtbcxZJN7mZimV8zEaLAvbnXIgtg04bbAfWhycKAQuyTcNRmLoj5XLrfUvXbdwr+M
	 jKEysd8kI7d8qwaw9nDGNl12gHbPy3X1MF6gJgZKeG27UZkSF5wCNcPBsL/0ZW//zguVa
	 CbDPW3flXx/LwvIa6KFaxXpixWw0nV4mbKYa6DpulytNo9FujkWgkiFC8FkpyLtFH4zwx
	 J0s1hsByRSvfbk53QxCt0k6adrHE7wwkiALKc/2716xQCOqDViHgBaRBj2f/ssPhx1RU7
	 CzOsv2yYyw+b71D43CAF/xFoZavQBh4BlUXvwN6C6Z+SHQ12bWQURH5PbvTIroX/L4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iytvSOnO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FD606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iytvSOnO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8812A1F000C4;
	Thu, 26 Nov 2026 02:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658635;
	bh=9b2S5lfg50XURyB9KP1KeOvHCshhyUy7DtAlMUFjvdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iytvSOnOSt5XZlblJv47EhIavrd9VBfIYRd2T69KZOQEyLdj2phreU+FYYQrf5C59
	 GMYWJXZewnwpq7C/2yN/loqfQCrqyFNMg2dRmEXxgDrh62qKeaUA1azI1nQscRCTvo
	 tFsczGA8Pr7i5V3l/jayaVKA31e32W01Zp91zpytPw7kmpq5+RmlMw8+VoeWv0KtfR
	 9ML5VS+v57m16L+Or2wukVG83BqqNr+OTFCuLOAO80WulroDO7FQpt6QkwfsxYXCl3
	 ucywUIx3Zo/rg0dE7d56PEf3sAykUb/gE+90yy0NE3z4bd8pi+HAvX5U38CBwjIpyo
	 IsjUnoRCQvp9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] ovl: reflow ovl_create_or_link()
Date: Wed, 25 Nov 2026 21:03:48 -0500
Message-ID: <20261126020308.1696715-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126020308.1696715-1-sashal@kernel.org>
References: <2026112548-vowed-carded-1ef2@gregkh>
 <20261126020308.1696715-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit d6ef072d09b2341e606aeeaf14c3510dec329c63 ]

Reflow the creation routine in preparation of porting it to a guard.

Link: https://patch.msgid.link/20251117-work-ovl-cred-guard-prepare-v2-3-bd1c97a36d7b@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 86e2facd8630 ("ovl: bump the impure dir version when linking a file with origin")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 51 +++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 058e18331dd47..c9871c111a84e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -649,6 +649,16 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 	return override_cred;
 }
 
+static int ovl_create_handle_whiteouts(struct dentry *dentry,
+				       struct inode *inode,
+				       struct ovl_cattr *attr)
+{
+	if (!ovl_dentry_is_whiteout(dentry))
+		return ovl_create_upper(dentry, inode, attr);
+
+	return ovl_create_over_whiteout(dentry, inode, attr);
+}
+
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
@@ -667,29 +677,28 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 				return err;
 		}
 
-		if (!attr->hardlink) {
-			/*
-			 * In the creation cases(create, mkdir, mknod, symlink),
-			 * ovl should transfer current's fs{u,g}id to underlying
-			 * fs. Because underlying fs want to initialize its new
-			 * inode owner using current's fs{u,g}id. And in this
-			 * case, the @inode is a new inode that is initialized
-			 * in inode_init_owner() to current's fs{u,g}id. So use
-			 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
-			 *
-			 * But in the other hardlink case, ovl_link() does not
-			 * create a new inode, so just use the ovl mounter's
-			 * fs{u,g}id.
-			 */
-			new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
-			if (IS_ERR(new_cred))
-				return PTR_ERR(new_cred);
-		}
+		/*
+		 * In the creation cases(create, mkdir, mknod, symlink),
+		 * ovl should transfer current's fs{u,g}id to underlying
+		 * fs. Because underlying fs want to initialize its new
+		 * inode owner using current's fs{u,g}id. And in this
+		 * case, the @inode is a new inode that is initialized
+		 * in inode_init_owner() to current's fs{u,g}id. So use
+		 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
+		 *
+		 * But in the other hardlink case, ovl_link() does not
+		 * create a new inode, so just use the ovl mounter's
+		 * fs{u,g}id.
+		 */
+
+		if (attr->hardlink)
+			return ovl_create_handle_whiteouts(dentry, inode, attr);
 
-		if (!ovl_dentry_is_whiteout(dentry))
-			return ovl_create_upper(dentry, inode, attr);
+		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
+		if (IS_ERR(new_cred))
+			return PTR_ERR(new_cred);
 
-		return ovl_create_over_whiteout(dentry, inode, attr);
+		return ovl_create_handle_whiteouts(dentry, inode, attr);
 	}
 	return err;
 }
-- 
2.53.0

