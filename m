Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B2411FB7
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740824; cv=none; b=bIvZka0/gFa8Fx6OFkEskWenW4+uR1BPw/yDtoKbfHqd87EmI0qfnmaAVse2bFDcmsu/VIhqXHpt75EFKwTwwS3iXMC3k0aQtVoxDFZszjzEJnW6gzaa+uxzDkUutb4/TLHoP44SV4DohSL241aXE2x33G8eIpsoBF2BscdzrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740824; c=relaxed/simple;
	bh=hSwoM5fYECzpJjInQHh4DeaEIkR/oeowe2f3PU+yB5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5aK0T6NyQmbqt/lShwNsXrt5oyhzWI7viyrxQYRQRTPsW8TYQQ0yvdKlVJV//yeQtsDQxHpQ4Zz2DE2ASGZo0mvZqfuIPhB9ShDK4w8lqRv/U73An7miUY5qi67ibwqh8VQp1YqxjwfIuruoCouBNcOsxoyVXoQtazJPftMD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=JIB9zQYh; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="JIB9zQYh"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80dc4a68e4aso100401707b3.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784740820; x=1785345620; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MSzUPgIh+xa7YWqApOSZw6hzwFlIazSNiDaMddWGUUs=;
        b=JIB9zQYh/Rb+9OiqcvXVLuLbVb8EeopEpxqG1dm9oR1GczhbN0MpzC4+xTn12D3zG0
         k+jhLefuCNxi6MwdXgQ4J+YOlXurHZI+S0Qe9UAZAdswVx96g+N0WGZZCod96hfSojy7
         vKpQPwKjagaApsem43vfweSHV2vs463h8aMjyaSV1CWEoPZI+EvO4TcObuz4HNzx0Rlr
         jB31zZobNcHNUNc7sBqkDcQU42CPu53cZWv+92T7ECSB5uHuReZdwNnOa7fLjRVoMV13
         72DFzEcbSbMrYAus7L/c4z1qSycIicBaSS866IZFUe+s3U4dIeYoNdLtDE4BkJX267+B
         AKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740820; x=1785345620;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MSzUPgIh+xa7YWqApOSZw6hzwFlIazSNiDaMddWGUUs=;
        b=Q52qxGf+GjyXlCCbqHpZQ7H7f6J2A/bRr1oSyubOiOQRQwxDnqmnhPQAkn9jn50sh1
         kDkdDTNO3LOCEj+6T4OBKWdKtXVUTfZxzpN/G3sHDmCrcwpjL6CijV5EnePIN5jKp40y
         Frce8e6oYtgtWDvcWAvyYSgWRPCRnaLyd61OiU8JQYY2O/e+Lvq6mIW4n1SA7rDaa0yx
         sTCXP25DkXjzeI/poAu1Yqa6InF1blVVJVW9tj+SZVKUHgj0DovZkWGIvNb4BHPReja7
         XQdGoA4Kiu8JSvu5P+GczaKgnYA2xmzgIVdqMiodI/DLNR00672JPEJyDDnqm47W1W7B
         SQpw==
X-Gm-Message-State: AOJu0Yzjn7YdIAqwf46+WDbLA5ZmDvlitoaT0FuSlwUpFYUehCgiXlLO
	Ph0HmMfiZYHimuHjp2nKwVpvznlHc3pEM3Fou2sFxE3ioD6wB0glXaUE4MHruZPgL6Srvccgg16
	46KHA6VM=
X-Gm-Gg: AR+sD13q/X3LPhGVWZ2XvDD6ZBWIPQCbmGMizQ0IwHAOXEuxJCISx+QwRxBPwQRlWIp
	qrLsk+O5K9aMj/k96ckLv4CYTWdlluTwM59JbrhMPOzOS8YUjtBqf0XyyhxiemmVSSsdJ1ka1yd
	QD7jUF7UJ3R47A2L7QFc510ACPGMSE2NZn7PQ4S39RMItCo2Sej+zkSVXnaJCgRC6fOJ2tqSxUA
	a4hUaz2JY8UaNpQBdv97tAwSY+Tw7ng9kR/8XcYMzFb2Dbo9MFY0X/wcXgDMNUMlX2hLzMb4Brm
	+y1VMR5Q3Dh9gNynoMN4wx8A8zjTIdj0ksSosVO+aHcEE3osolfImNO2eChJbc+Ndff89QEJ1op
	7eBhvEBOFzhz5fZrmOSuwdpovmaTKLIIQunxQ6WRqGr9OVTtFJVSDx/Kb8fbDzLzgdDEBEp0LAD
	DIESKofLAfUU/g0nQc05hSiVbJyDpdOflYr5Ax0rjYsf6X0extgfcZOkWdV7Jt5Uicc3hMLWYTW
	nfxZiqakbXaY+GtJw98ROeQLfbO8c4RWo0ZZuQslLe8vcLvDbWR82WWpgNVGCw0xLxvNHg=
X-Received: by 2002:a05:690c:360e:b0:81d:2194:6c4a with SMTP id 00721157ae682-81ef2610887mr78447727b3.47.1784740819725;
        Wed, 22 Jul 2026 10:20:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:12d8:c69b:ed00:1fe4? ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33d9fd46sm16658927b3.28.2026.07.22.10.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:20:19 -0700 (PDT)
Message-ID: <afb662b8da9c1365546f658d75f27c88903f8a9f.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: avoid fs reclaim while using
 `current->journal_info`
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, xiubo.li@clyso.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Wed, 22 Jul 2026 10:20:17 -0700
In-Reply-To: <20260722114931.3557110-1-max.kellermann@ionos.com>
References: <20260722114931.3557110-1-max.kellermann@ionos.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 13:49 +0200, Max Kellermann wrote:
> handle_reply() stores a `ceph_mds_request` pointer in
> `current->journal_info` while filling the inode and dentry cache from
> an MDS reply.
>=20
> An allocation in this section can enter direct reclaim and prune
> dentries from another filesystem.=C2=A0 If this dirties an ext4 inode,
> ext4
> starts a JBD2 transaction.=C2=A0 JBD2 interprets the Ceph request in
> `current->journal_info` as a journal handle and dereferences the
> request's `r_tid` as `h_transaction`, causing a kernel crash, e.g.:
>=20
> =C2=A0Unable to handle kernel paging request at virtual address
> 00000000077b4818
> =C2=A0[...]
> =C2=A0Internal error: Oops: 0000000096000004 [#1]=C2=A0 SMP
> =C2=A0Modules linked in:
> =C2=A0CPU: 6 UID: 0 PID: 2699135 Comm: kworker/6:3 Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.18.38-i3 =
#1113 NONE
> =C2=A0[...]
> =C2=A0Workqueue: ceph-msgr ceph_con_workfn
> =C2=A0pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> =C2=A0pc : jbd2__journal_start+0x2c/0x208
> =C2=A0lr : __ext4_journal_start_sb+0x100/0x178
> =C2=A0[...]
> =C2=A0Call trace:
> =C2=A0 jbd2__journal_start+0x2c/0x208 (P)
> =C2=A0 __ext4_journal_start_sb+0x100/0x178
> =C2=A0 ext4_dirty_inode+0x3c/0x90
> =C2=A0 __mark_inode_dirty+0x58/0x400
> =C2=A0 iput.part.0+0x2b0/0x370
> =C2=A0 iput+0x18/0x30
> =C2=A0 dentry_unlink_inode+0xc0/0x158
> =C2=A0 __dentry_kill+0x80/0x250
> =C2=A0 shrink_dentry_list+0x90/0x130
> =C2=A0 prune_dcache_sb+0x60/0x98
> =C2=A0 super_cache_scan+0xe8/0x190
> =C2=A0 do_shrink_slab+0x174/0x388
> =C2=A0 shrink_slab+0xd8/0x4c0
> =C2=A0 shrink_node+0x31c/0x908
> =C2=A0 do_try_to_free_pages+0xd0/0x508
> =C2=A0 try_to_free_pages+0x11c/0x238
> =C2=A0 __alloc_frozen_pages_noprof+0x4d0/0xdd0
> =C2=A0 __folio_alloc_noprof+0x18/0x70
> =C2=A0 __filemap_get_folio+0x248/0x440
> =C2=A0 ceph_readdir_prepopulate+0x570/0x9e8
> =C2=A0 mds_dispatch+0x1424/0x1ba0
> =C2=A0 ceph_con_process_message+0x74/0xa0
> =C2=A0 ceph_con_v1_try_read+0x3a0/0x1510
> =C2=A0 ceph_con_workfn+0x260/0x460
>=20
> Enter a scoped NOFS allocation context and leave it after clearing
> `journal_info`.=C2=A0 This prevents filesystem reclaim from recursing int=
o
> another filesystem while the field contains Ceph-private data.
>=20
> Fixes: 315f24088048 ("ceph: fix security xattr deadlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 853bf698b356..3c692ad02c85 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/sched.h>
> +#include <linux/sched/mm.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/debugfs.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -4015,6 +4016,7 @@ static void handle_reply(struct
> ceph_mds_session *session, struct ceph_msg *msg)
> =C2=A0	struct ceph_mds_reply_head *head =3D msg->front.iov_base;
> =C2=A0	struct ceph_mds_reply_info_parsed *rinfo;=C2=A0 /* parsed reply
> info */
> =C2=A0	struct ceph_snap_realm *realm;
> +	unsigned int nofs_flags;
> =C2=A0	u64 tid;
> =C2=A0	int err, result;
> =C2=A0	int mds =3D session->s_mds;
> @@ -4158,6 +4160,14 @@ static void handle_reply(struct
> ceph_mds_session *session, struct ceph_msg *msg)
> =C2=A0
> =C2=A0	/* insert trace into our cache */
> =C2=A0	mutex_lock(&req->r_fill_mutex);
> +
> +	/* disable fs reclaim while we are using current-
> >journal_info
> +	 * for our own purposes, or else shrinkers of other
> +	 * filesystems might dereference this pointer as a different
> +	 * type
> +	 */
> +	nofs_flags =3D memalloc_nofs_save();
> +
> =C2=A0	current->journal_info =3D req;
> =C2=A0	err =3D ceph_fill_trace(mdsc->fsc->sb, req);
> =C2=A0	if (err =3D=3D 0) {
> @@ -4166,6 +4176,7 @@ static void handle_reply(struct
> ceph_mds_session *session, struct ceph_msg *msg)
> =C2=A0			err =3D ceph_readdir_prepopulate(req, req-
> >r_session);
> =C2=A0	}
> =C2=A0	current->journal_info =3D NULL;
> +	memalloc_nofs_restore(nofs_flags);
> =C2=A0	mutex_unlock(&req->r_fill_mutex);
> =C2=A0
> =C2=A0	up_read(&mdsc->snap_rwsem);

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
