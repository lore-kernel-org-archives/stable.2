Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682059;
	b=yflvzQD22HFNQSySeftKjDQXsCGRfFGfNl2tNkNPLqpNhOjntnK/ZtGn9ZLXnwwXCe2h
	 d5gN/YTF4B12xFc6x1ON6sa4ZRsa/T0twFAYNqoQ9pWZWHgMN4+O0FpWw1b+YN12sS7Wg
	 B+QiWDEW5CeN1GLzyXW2sThp0LJ8xj6Ez7xvqjJIs/kw4keiJX0ySmntUVrjFxHsoMi6X
	 b6GPJkO4Z0NL9QbY4NVWbjJJQgSjpM2+1WokdtWHXSPWZtaTHjmEDOCEVdeHlVvwV7jFe
	 YHkFZhwB1QILpBHZL08cLNHVc5j2QI8szvnK1CASsNH7Vhi+RzfMU4s0mmXmXFEn7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LIVmSzIk4JB5kdc6PM/uszD40rrL6s33RURIe/NS8kI=;
	b=TaSLcn5p5pX4ahg/f1wmxmzBg0idIbErzOqipC1yUSxW4celCLSicnnnTcOsP6F7N0lj
	 7VSdwre+WN2fpEM3V2zbSLT3j2B9OPwjMPGFcWW7V+NSTURpZNhfOHlg4XRySRZTvrBtC
	 yvkcDoEIQVYeTC1iz7T4BBJ95587uK3N+9WQtf9uVLeKU9VsCrHw2sbNQoMbYCmrbUps9
	 TYtQ3GLr41yaU3zXm8xa+jKN4iVrnc4JRXK7ATZtiNBjiGcTb8bb20IYwh0gkWJR5fEVI
	 XvYRPpDZF/W6LU49uYrjeSnMNdvYmi7HcnKl+B01oW4BtOq8oQBv0tIIr1FlSf7p9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aw+WlVkD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0B606ACE4
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aw+WlVkD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D851F031E0;
	Thu, 22 Oct 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682059;
	bh=LIVmSzIk4JB5kdc6PM/uszD40rrL6s33RURIe/NS8kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aw+WlVkDflIuCe2UB0TbEzHpK5lym6vBsUSCDjxqozE8vgFsInsNrJdFen5raaVJt
	 JBes1Uxq6d4Dylnv0GizonBBHDNjXFKp/UvVgdWR+ky6XgTZYQcgwN4FafkrOutmIa
	 falgbOEcacvkNZk+5JXITc+byId8UXBrCzckyp17kjSytmcPsRMEuv7sDQY7DoSXCK
	 QMwK6oj6RV3ZrtBckqa5pw0UwlF9iQlNKoLcuFS9U3CtEHiO4ZHpTJ8s9Ylq6pLkG5
	 WSHIe9DN8PGr9B9ud0zU3GljF2E67D1z9YZsT0OXFEdw+yzlMYzX6u33JdkNeFF/ws
	 t6ABAD4X3kN/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()
Date: Thu, 22 Oct 2026 11:14:17 -0400
Message-ID: <20261022145315.1605583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102115-justify-disrupt-2bd1@gregkh>
References: <2026102115-justify-disrupt-2bd1@gregkh>
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

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 53676a5e28231186c9f56d87b7998b640699bc15 ]

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Made the failure check standalone because the existing code lacks the SMB2_query_info() success branch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4da027ee4b99b..21a2b265ae7c4 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2070,7 +2070,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		src_off, dest_off, len);
 
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2095,6 +2095,11 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	}
+
 duplicate_extents_out:
 	return rc;
 }
-- 
2.53.0

