Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852025;
	b=Pao5GKpVI3tPW+poAGMpFVMG2BESXTqbqiaLd7X0cfKQZN2mBzDUYNN719AP/wolLyHL
	 ix4YQ8aJAaCxSL1N7hUh+0mO2z9RNCDwSmEKHAacAbdOcIoovvTGXdTTjuyKN7RCTwTF+
	 v0gxKHp1iD2dQ7EMZY2VbAcOFxiaGkG30BKlwdbvsZVUuwUIlu8JjlOpCssrjrldTqiZu
	 qWHRSyVxJv85uVuWVkcL8ZgcxuzgVEYLADiZC9PZ7tOh1kP+Rnqmx3o1Bg2uo3SDPlaY6
	 /xEFO1nnV93plygY/eT6k0DfPV0aN3TtZNw0WF+TWbp9zS9Wwxj8QuXEHBiRKfdyJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852025;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z9itY3sFaKo4aFamvcDFo7fjuWWUI0oOdPWW++KRUSA=;
	b=GLBtcgo2XxD3CvQ8oD0cuJT/OwkYil/pNisRwGF67Nd98ig93EBcpBVbe4H+0aWnaeBs
	 NH5YfLRqy1jyiHG8OruHIUnJ4Ytgotse7x0i96ydPn80cKcVAXqRRajZE46T3SMDpvykB
	 bgbJeA0oihQuyjkCVVHpxBf3l8r3A+GU9zh69dev9vZWSu7CaTX4GgmER5Zrn3FjjPJCT
	 /0c7VS04q32Iak2rg9veghqL8ytW7rhvnNRxXI3U/xwOK7lMMd+/urzs4XGL72XDa1ACG
	 8LtSrTqqQSnTVYjOQHCiLah12/4nxjDAuvtFPpsgA85IGZ+azDqiDdzy37xybVQG32w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=JfIPx31E;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64303606A33F;
	Mon, 16 Nov 2026 18:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64303606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=JfIPx31E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794852016; x=1795111216;
	bh=Z9itY3sFaKo4aFamvcDFo7fjuWWUI0oOdPWW++KRUSA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JfIPx31EMnRMdkJD7PAIr22ncUpj2cfU9NiajYlpI8IrBYnXaVPmMeJEaK66ckOQT
	 dFpeWU9W1GP0AF0xA35fTR61V+HFLKYfDNYimilNhXafx9YWyM3EjgFLjN1P8whuJS
	 T3GWbO4vDGrblkKe5lVr/6eg62bQ+mbLWHqZjOAJcgdRTNKhVoL/+RqgACTr3C7R7A
	 IeNa/Tsw+HHLZCMuaXa4uJF1z8TrYplNzE38NazTvqBVVtUKmsbtsIdAPxRApqBPvd
	 r/dhMAqiaNhir5dfi7l3F/QSKrDK9PI++G95MhioHHEy3pDAj//PWfcUxFa5gmyHfL
	 XyvHdFdYLm82Q==
Date: Mon, 16 Nov 2026 18:00:11 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
From: William Chuang <founder@logarcheon.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, William Chuang <founder@logarcheon.com>, syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: [PATCH] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
Message-ID: <20261116180002.44336-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 1b394b004e1d598caff714f572707eece21ebc06
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When the filesystem has been withdrawn, gfs2_glock_nq() returns -EIO
without queuing the holder, and gfs2_glock_nq_init() then calls
gfs2_holder_uninit(), which sets gh.gh_gl to NULL.

gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_dq_uninit()
unconditionally, so in that case gfs2_glock_dq() dereferences a NULL
glock when it takes gl->gl_lockref.lock, causing a general protection
fault.

Only release the holder when it was successfully acquired, matching the
pattern already used elsewhere in this file (such as gfs2_fiemap() and
gfs2_getattr()).

Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D5a5f492ccae698fd7434
Cc: stable@vger.kernel.org
Signed-off-by: William Chuang <founder@logarcheon.com>
---
 fs/gfs2/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 75fb1a0c91425..4110b2d0b549c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2255,7 +2255,8 @@ loff_t gfs2_seek_data(struct file *file, loff_t offse=
t)
 =09ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 =09if (!ret)
 =09=09ret =3D iomap_seek_data(inode, offset, gfs2_iomap_next);
-=09gfs2_glock_dq_uninit(&gh);
+=09if (gfs2_holder_initialized(&gh))
+=09=09gfs2_glock_dq_uninit(&gh);
 =09inode_unlock_shared(inode);
=20
 =09if (ret < 0)
@@ -2274,7 +2275,8 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offse=
t)
 =09ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 =09if (!ret)
 =09=09ret =3D iomap_seek_hole(inode, offset, gfs2_iomap_next);
-=09gfs2_glock_dq_uninit(&gh);
+=09if (gfs2_holder_initialized(&gh))
+=09=09gfs2_glock_dq_uninit(&gh);
 =09inode_unlock_shared(inode);
=20
 =09if (ret < 0)
--=20
2.43.0


