Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871468;
	b=zvVyfjU8V1vfLmO19Vt2+DM/MtxLBTq4HcP1AD4B8e0rQYO+XOkup7moZPuagTO1u6K5
	 QHZzlLLFGTXbfMqGxD2aNVHhv2zDimccAHDcKLVaVAVrK0drYKmR2T161ZCKgeuk7IAyD
	 M0XSwLvoLuZPfTRsqbq2vFLmaiea0RFnWHwx4duKpOfa/l7Xw+26z5bsgbzFh57NFIoNO
	 fSkGYH947hQ05lcCWXimP3ExdoZgEntdiTT22aLulUkpjmVywYEWHJBCCD0IBpSj/b7De
	 DAkk0pCFVc1m1zGjvifVMwlWY/YzOc3qBY5IkE7DNXdosQKPWkrx/zse5QLyoBFJc/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871468;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=s3KVf9BJ5yxXh5/OaiZDJ1j9l96YHyL2vcWf1Pd0oWg=;
	b=xgl7H2kiQFq6SnhjFlKuMFZeu+RgWyLJVkzsLlcTvNMORQJI5oOqC7JUrTDCDHgTIK2m
	 HCCfGZuR1JkPCkAPE4OBKM6PHQsFY14Knf2+W9Yr7GRGiibPtPWHoUt1QiSUa9scq4gy5
	 Gp2TSA0i7PdLGCh6bY+Sz4XcMN7rZRg4m2B6P84K2wdmU5hNgEhrITK/i40OXuevDR2xh
	 8Y7wMPxWb5q0oKpxXcENwa/sVOf0upBZg/4r4lm7FRYSSMwb0ifQ4E3HLBZJEsgfhSyph
	 jmuK3dwdr+Qr+uVbY0Fi9y57JGd5vcwjb/MWemrbyGg7cIHupT5xa1FKAPaifOKA5kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=MigZdrsk;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5C606A323;
	Mon, 16 Nov 2026 23:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B5C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=MigZdrsk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794871464; x=1795130664;
	bh=s3KVf9BJ5yxXh5/OaiZDJ1j9l96YHyL2vcWf1Pd0oWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MigZdrskiLpREv5N3tcxHdM6KaZTgOXoUgvx67mY3MkJJ7OYr3eF680byoUhrP/hO
	 EXRbR4DCvMQYTu9wdlEeqXrXgICmtoV2i58yxdCqiVPV+odW3eeM6WhBhv4LkTeqry
	 xg3e1MlHqvvtQEkWsASMxl+k5XE6vE7TbPauKkq1z/VnxnON91rtYRJFv3M6P3auhO
	 0iarmuUxRABcxvFiUKTdEHE+8MkkS0u1iqgAvibakuFFxKEn7eAe8e/JEqVRO3gxRc
	 1fzEZ61SmRWNEx8TzsQA7walBswEJB0QCjf4ic+wyMD34km0z7p2qFq1P3aK7t0PQ1
	 npypYc8Exy7+w==
Date: Mon, 16 Nov 2026 23:24:19 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
From: William Chuang <founder@logarcheon.com>
Cc: linux-kernel@vger.kernel.org, syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com, stable@vger.kernel.org, William Chuang <founder@logarcheon.com>
Subject: [PATCH v2] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
Message-ID: <20261116232409.46988-1-founder@logarcheon.com>
In-Reply-To: <20261116220843.378480-1-agruenba@redhat.com>
References: <20261116180002.44336-1-founder@logarcheon.com> <20261116220843.378480-1-agruenba@redhat.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 91d738133bb0f8f6091001bc0479f089751ad6ca
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

gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_nq_init(), and
independent of the outcome, they call gfs2_glock_dq_uninit().  When the
gfs2_glock_nq() call in gfs2_glock_nq_init() fails, gfs2_glock_nq_init()
returns with an error code and gh.gh_gl is set NULL.  This causes a NULL
pointer dereference in gfs2_glock_dq().

Fix that by only calling gfs2_glock_dq_uninit() when
gfs2_glock_nq_init() succeeds.

Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D5a5f492ccae698fd7434
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: William Chuang <founder@logarcheon.com>
---
v2: Adopt Andreas Gruenbacher's version of the fix -- skip
    gfs2_glock_dq_uninit() via `goto out` when gfs2_glock_nq_init() fails,
    rather than guarding the dequeue with gfs2_holder_initialized(); reword
    the commit message to match. v1 posted at
    https://lore.kernel.org/r/20261116180002.44336-1-founder@logarcheon.com

 fs/gfs2/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 2c2dc459c037..d4678e4832b3 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2253,9 +2253,11 @@ loff_t gfs2_seek_data(struct file *file, loff_t offs=
et)
=20
 =09inode_lock_shared(inode);
 =09ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
-=09if (!ret)
-=09=09ret =3D iomap_seek_data(inode, offset, &gfs2_iomap_ops);
+=09if (ret)
+=09=09goto out;
+=09ret =3D iomap_seek_data(inode, offset, &gfs2_iomap_ops);
 =09gfs2_glock_dq_uninit(&gh);
+out:
 =09inode_unlock_shared(inode);
=20
 =09if (ret < 0)
@@ -2272,9 +2274,11 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offs=
et)
=20
 =09inode_lock_shared(inode);
 =09ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
-=09if (!ret)
-=09=09ret =3D iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
+=09if (ret)
+=09=09goto out;
+=09ret =3D iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
 =09gfs2_glock_dq_uninit(&gh);
+out:
 =09inode_unlock_shared(inode);
=20
 =09if (ret < 0)
--=20
2.43.0

