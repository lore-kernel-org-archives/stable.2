Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890918;
	b=05jmFY+xuv8IXyaXrQfYW43kGOF7qosgFlPHAckfE/tQRzKnCgNIWfn7dmBTXBrKzfmc
	 XhTlA0kjQ6lb3LGmcO6Cp6KoaEAUt32Ii22UG/vy2rudeCnmz+9Y9+aAtxrl8ibeR5wIt
	 qm8zocI0InHnVvVPO7UYrlyuN5phnQe7/+sx/bLepMsxWxgaP8h1K5e1ny8hR8IrKNzug
	 BOZ6WvcpDztOHVVX8LhHNUjhpEhMpKDV96AofrASd1R0+A4TI1cdT/hc+qU+fxxnDTTjd
	 eYG2xmCRGVH81+AGwjZ1n9tXfMnfLi5I6iVwEfAtLA6LCR7jcU0h7NAEw/ioCQGwC8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o7js8l+OTzOn83DN8L0GkmX4bMpevE/9Om2C2ln8/8I=;
	b=3/MEjUQwnV49fZBhDzy7XJ2Feo2LnGx7ABZCBlu1Fx0mf6WOmBwa40oLN1Nto3PH7uJq
	 y7qJMouD5tCEIVZucaxuDrOmenYmkNtG6Ri8OwYl/JuDBZ1g759XPje++zzyIgHjO/Tw8
	 CXBF37x8UOUOuRQ9VAfcp+ReqrSYNn+P23hEyMagnjUWfH3mw2p1fXB3r1+LpvN1rzAHH
	 qEGkvc0zmuBxXV+SB3HXjH4V0puk/tgwcJHbY3xCXk608bEBuevF8ukIk7UgXreKS8Oo7
	 S/i2CGlAP0a7cUdv246BLaKlamMQBFmtljU+QSKU5PYd7D6EKNSatjKRca2loaf+8mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7Z+g55L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92726606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7Z+g55L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851561F00919;
	Thu,  5 Nov 2026 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890918;
	bh=o7js8l+OTzOn83DN8L0GkmX4bMpevE/9Om2C2ln8/8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7Z+g55LnKZsKKdUGdCkKMIOsXJSI3Il+7t9arta+Kr6XFT1JJSOCVQDg8E1zuCDF
	 C2yqLUSLddRsvhW9dVolpwC8TFeGdB+4cQZrkz+fBW80ZlhTxTLYz+JrG9FL6UwzIx
	 FLi7a9GkNAaIWbEH2dk92v9PIBCmdFQ6KXX+/aJVzRIfOfOs8EjD/FhXOSrib9QfVg
	 pjmAmwdgR4rClpSjAQXJIsiuyTfVYQRUiJnYfqBMxdvMcC5qw7aQhHDd4om1oc5boC
	 GcSGdvYcgfbSlOcJ46ZP75mEGVrCQLsDG7i7Ea1iDJ3j8JgEm3sASIBo/AW9oAZs+P
	 QjZ3verxlBmhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: do not copy up a dentry that was removed
Date: Thu,  5 Nov 2026 10:01:56 -0500
Message-ID: <20261105150116.1655939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110409-shorts-resilient-2f0f@gregkh>
References: <2026110409-shorts-resilient-2f0f@gregkh>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit f635192ad223d2009ee640b63adf5ce3198aa338 ]

A change to a removed file through an open descriptor replaces whatever
has its old name in the upper layer.

Copy up must only create a name in the upper directory, never replace
one. After an unlink, an rmdir or a rename over a lower dentry, a
dentry that an open file keeps alive still has its old parent and name,
but in the upper directory that name is now a whiteout or a new object.
ovl_copy_up_workdir() renames the copy over it, which brings back the
removed object and destroys whatever took its name.

An unprivileged user opened a lower FIFO and unlinked it, root created
a file at that name, and fchmod on the old descriptor replaced the file
of root with the FIFO.

Fix this by looking up the target name of the rename in
ovl_copy_up_workdir() with LOOKUP_EXCL, so that copy up fails with
-EEXIST if the name is taken, as copy up with O_TMPFILE already does
when it links the copy to the name.

Fixes: e9be9d5e76e3 ("overlay filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use LOOKUP_EXCL instead of relying on d_unhashed()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: Adapted start_renaming_dentry()'s LOOKUP_EXCL handling to an explicit d_is_negative() check before ovl_do_rename(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 018867303a93a..5d655889af06e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -622,7 +622,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(upper))
 		goto cleanup;
 
-	err = ovl_do_rename(wdir, temp, udir, upper, 0);
+	/* The name may have been taken since lookup, never replace it */
+	err = -EEXIST;
+	if (d_is_negative(upper))
+		err = ovl_do_rename(wdir, temp, udir, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
-- 
2.53.0

