Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883707;
	b=AzWtKodgIoI4KtwUD+L1l9U+Vs0V/2Ezhz2JYqT+9QAqVKALQhtGAbPkZsMk3iG1+yYI
	 gC/AddPgbUSxRlIBOqIqAZMKNr8oWVoy/Ygu8TyIjvuRHnMlYiThMqwAnBRzCWdIAvUAz
	 TKGqt5tTLtx/J/D+5KQF2PiULCahP5Za/2FzUILXNigIfa5/6fW5fXwrICi/jmaDUu5Fc
	 TL/0hFi+GllZ1apTpCspq9UPUr2nO31U/zaj7UZ0P+XKZjBz1Ff1J1UbzyD9HpcRFG4aZ
	 5+rlGHdwdT2pmEhVnWHY0feAEdXpLgJ3Eij3gJlPiADrHbu5qmrQzKaiU5XyjR+U2TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=38a//q+ANZLBgvyVpc8wPmP/KtnzWsCjQ4Rj3Ayci1o=;
	b=cLT9R3FGhT5vKaPXCYishKw8wFsFlI57PB/FoUJdoVUPK0NbuQnLcQrBuAnqS5XaBK2q
	 HyJunl/evC3QDjuWYIOVm8lOFfRfm3egFua/NsDZ0hmwES385sQxDDcVlPZMQqDK2DIsC
	 hgBBtKfh2K7SBl1ynUhwmXUglyiJuTg9GRGToLp8HZugditODul56JkdpkjDS+Ro22zbK
	 rIAKzhN1G03vWLu2NRUdVco1+MgjhuNTF9iheTS3UXEI4/BK/KYFtBc6Odu7TLWgOHsCJ
	 BOCmzdJB8pbW9EmsFQPUE9B3z9mnmIWv+S3TENBQ1cUU2Ej0KyLgPsVePTEnKvpKi8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLkHFwo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A2606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLkHFwo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC291F00A02;
	Thu,  5 Nov 2026 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883706;
	bh=38a//q+ANZLBgvyVpc8wPmP/KtnzWsCjQ4Rj3Ayci1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLkHFwo2wPrgX+dUhrVIctgotGaNi7jyQnwUgh7jl4FUOM5qNmkg/6Ckr+yvw0hHS
	 2eRDuzNc8uE33wy32IA9wX78fCdgeLWZSWY8nFvXrdXL1GNnDXSE/KZNAme1LYYHr0
	 WZzp13jWpeizlAlAMpRK0pZ56vbI3czLgkkVu6BSAfCM5F9oq7Ke9vnesE5ZZmjso/
	 cNyrLI967mDS7KouY9y8LESagwsIxw8FR1LVqdVo4yB1XaeeAGf9UAj2G/HiaxekfR
	 BWCLE4Ltk4fjLVyryAp5D5HXEpz8/6463sUQuYNKj2I5SWMlSII7n3h1M4OZamOdY6
	 wUj+SjQo+dBoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: do not copy up a dentry that was removed
Date: Thu,  5 Nov 2026 08:01:45 -0500
Message-ID: <20261105130123.1518592-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-flashing-erased-c7ec@gregkh>
References: <2026110408-flashing-erased-c7ec@gregkh>
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
[ sashal: replaced LOOKUP_EXCL in start_renaming_dentry() with a d_is_positive() check before ovl_do_rename() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 0f0c02121936e..4ac2c0e93aacc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -707,7 +707,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(upper))
 		goto cleanup;
 
-	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
+	/* The name may have been taken since lookup, never replace it */
+	err = -EEXIST;
+	if (!d_is_positive(upper))
+		err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
-- 
2.53.0

