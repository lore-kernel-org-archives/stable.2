Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882327;
	b=DgK+vIICEG9mgtIqoYe4mh85cVndj4uDKSlOlsK5VgrExsFueGf6P9UF7ka0fpsQHnXq
	 YiGDjet203iHJa+8L4YpV7Ou1EoBJMRh+Bsbmr44kosdl+n9WW+9TNCfVgVzyAvbgquEo
	 xjtk+oJMEF4eo/yhTJ/vCpAiL2tROtRhJBM+tV75N1Mnr8iq6Gtf7Mu9e2n4wAa1mtpZo
	 snf7D2jZIEOMbNyhhiz6zJRUJFXgx5Vv8lZNgNeihEOHzN8eDAHJ1LhmGy3ZRHl3pL7XI
	 DeAqktAH46AhWbPz5xa/JzqXUHXDV77wiOpeY4S96L27z47JLuROnNRk2mOrZYscIww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882327;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lpc466ZIpZzrPhmQQOdLoE0mRetL1bLltV97g0gGBWQ=;
	b=GQPjI2HsEtBCM5T9j/E2eXJCNF7OfJ41nXrNZcmGZ2Vnx63PKC1WYyDcwYjuAyGaM+pk
	 Jm3pAzozCsq49KOe8Cg93cV92LJHOfcW7hIKyY7y1V3Wf1zn6S/HYBEI7Ur5ily7H/rXY
	 Qnn9LSZbAYj6fc+KgtQ7vb6MunOPC0dGUBcOrlW9hA2IxILjxx3zmPhpb3631UGuoPMOm
	 35jAYbQ/Jv53TG+nRV1r92y8U/TE8KUObyoKnplXuaJehi0gysmYTw8YfWnsIj1a7KF+G
	 5iM0YERRxlDcmGoLaes2Zr4D+8wgqiG67txyEy2o3GsVfXn0rPT30CJkekazUsT9Tpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F37UsqX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E37606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F37UsqX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34471F000C1;
	Thu,  5 Nov 2026 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882326;
	bh=lpc466ZIpZzrPhmQQOdLoE0mRetL1bLltV97g0gGBWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F37UsqX3aMHXcLIOi/k1xMC0ESJ1nraUuXNtiT1sAXx3f7RhDCc9+sWI8HE7Vy/Hr
	 tej4bWdFq1ASMxP1HKTmSWW8Z2LV+fpbcvHWJvtQCVK2s3aTqmqS0UGQx0I83nAGry
	 ePAuwO73MbskIHmJ2r6zH9XMTNSK8UiZIm0nt726blM9KgUDm4Tax2jr1WiXQ2tduc
	 mWV0ImVwjwl6jl6iTWahVgQXbbGJDvpY8BsSD4L4HCPGUPvZJRea0bxrOqY4yzWzZk
	 tqE8RObtaPceBEa62+c5k9+87U6BYI1XMH8mgk8NUtgSW1N3ublGOlZPiMp2IIicl4
	 OV+L2ziFVH2fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: do not copy up a dentry that was removed
Date: Thu,  5 Nov 2026 07:38:44 -0500
Message-ID: <20261105123828.1387546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-bobtail-armored-f04b@gregkh>
References: <2026110407-bobtail-armored-f04b@gregkh>
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
[ sashal: adapted LOOKUP_EXCL handling to a d_is_positive(upper) check before ovl_do_rename() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 1c2c1b1801eef..8238254ca4616 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -758,7 +758,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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

