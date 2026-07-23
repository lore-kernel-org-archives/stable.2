Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DD38B7D4
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781333; cv=pass; b=IgHsBuWAxVXE5fgtQAkUwitaMcZQKt0RTPa9Mie2lNysuM31fR8xZfsuiTHs4o5dphU2rWEulNpSyokfS2IQOyFVHt/C6DJiFN+ftvFojocsLtgjXpAj321QrgezaeyocC9pEk3hEomkhHpNqqKXjlLGwSvc9gEZbAonddUL4VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781333; c=relaxed/simple;
	bh=3tIRl6n9ScEPVyFCPZX1mfWqRv1lJpXYKq2yg2toHMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddzherq9vFfQBh08fn+uoMdRCUaxvWetXLYc3hmbJdftjeJMJo1B5EsgiNxglv2Nb04sxXsRrh9A4hkiaR1NNjZHHRK/tYRc9Fg8wrQ4Fy5gfdxPbrjEZStFR+fFGkKhs3iAV/WlYfZvyCHMKJlq1VNLHMlWYrFs4GwKVtqXnfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=MJjlqI3X; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="MJjlqI3X"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69f2c67650aso367912a12.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784781299; cv=none;
        d=google.com; s=arc-20260327;
        b=GwGXtpqD4WbDDFtSiO448/YrqXKaf39Js0vKXVi6l9/AR+jq3K7+0aK6fVMvhzXQOK
         yAA/jA60TQhkkjLr6WT8yi8LAYA+79nVEuxjV++YnbxVV+TYJbwh5mxzj/BcFRMezG2v
         Pjqu9v7kDnYRyPBvHTPrhhNGVX8vg+051cgO9Okwme2dJKGmQZ66AE0C2H2rlivVSLmd
         Lz8tuDiHBjmgXMtT8gmQvSL3IpCsdh9lQRsja5QnEBl8TfmV3m1FNht3l6oRXLO/8oT7
         QsURV68OlA+sH50HDH7weVSby9izB1PB5SyVOu0c01WUNnJCRC7veb78dl4J67WHybo3
         M9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YVvRt3Do4BL7YwpYfYdAkO7uZ2P2iMzXV9MzEDFPk3Y=;
        fh=Yqiwi0pHFBLpNwXzhcrW6N1cxdLnkV06pFOjM4r8TtY=;
        b=FufGM8EIiWDDV03L0DphKKAfr6fqLgqsIXH+h9T0ch7SE/Gsln4gnXB+tpN3lvWJkU
         sWZbLMSl2k2a1gk8Pqpz/K/NV23+QUMv8kTpV61L0vIvhZ/NM5uMJF2x0hGu0lFLIOkl
         gVWID0X3nB7e1lXAUfy/F8SvWt2/uRRCk26HY3VEb0bt+EuBHoh38YmIuRsszbrk3pkJ
         GD/xoLDxiNnHdVjJB31iMyadH2UvPGCTp4kCKZlVYA9S8RnegptFqV129bon4sRdZ4d3
         3Q3I20LzCSOIV6j5ML/Q689Rvjb9i2L1scO6ydceTnHgGWUvfGNoGw8N8lfQ86qL6f6p
         Lwqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784781299; x=1785386099; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVvRt3Do4BL7YwpYfYdAkO7uZ2P2iMzXV9MzEDFPk3Y=;
        b=MJjlqI3XhKBBAQbLhAQzd+aBLi7LyjPnQYCsyCWYFnI6V+iGeiSIPNvy5oT5ezWbAb
         4DF0bi9l1//Qw6p3yFJDZKKwqSzaTwJXLZZSDwxyWtOYF6ZhDFFNekrhIMD6gVJGeIDW
         vz+QgXw/1LwUsaiYxgOt5liuIiZGqpxNXEAEDAjECgy/0oExjwQO8KpAYxJ6gbfhNFdv
         zUKutCvsvvEOgRbC7kGHoco2Aq3QJA3lVDS8qovBBY6v6kIEC/9wak58iJGbqmE3xbNw
         1OmOLiAFamrj1SW4WTmkR868J2Hijvjiy/lGXl7cqPmYC94cDo1nZCmzrnDT0EnqaIKv
         ln6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781299; x=1785386099;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVvRt3Do4BL7YwpYfYdAkO7uZ2P2iMzXV9MzEDFPk3Y=;
        b=rJEsIs2ikSvs2Pj7sT/7RWGcBWCswIA5gw+UdIdM8ilc9afgk/TEtWSEhF5iA4o1cO
         Ux+SfLPyhzUADaovYO/M4snxqmWBe3iWFpyERmNAlOp+fNDVaLs0N47TsxNxjaPcMroT
         6krlbN4A2mZgSiITePwd6lqQiI8eFqz2tG+PesZIzXYzyqSfdb5aGyEkuD7n+0IvTBLs
         AjnTQdAIin6ouKwEdpLAlzm2cP4O2om06ZQf8/mbMi41PMYUN6DZcQ8x/eadBx7zu7GV
         oRchhyHuH7vNl8Jgg7wtwHOTv5JOnTLd4WUPRxVcOWXqofPu3Nq1XxAmrRnQPlYe/SVC
         wo/g==
X-Forwarded-Encrypted: i=1; AHgh+RpWa6sErHTH1OabMDGf8TJWPoB2awTX1bTPdV2Nt+a0N0tu6xwIioxo+Xij4Y1wEnaHVYrWTg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBiVl9gHeRT3QJAlrv59gbaM1r3AvaBoEtjUTbfOSjNw+86nc
	eQ4V+GV6+uU2hK8ZtlAog0d3SUULvZ/Q0OmiHH3fgSWSZQBubuXPsOFvUOxwASfD4qQYnM0BG+o
	yDEmEY/a01hatz2CAbHWSXGmpPDqpv+JeDHa9tf66Gw==
X-Gm-Gg: AR+sD137akUeG0no40RLedNdj8bqEpU4dZXcY5CuePTvNhUB+aa1ZRHLjXggfzBfgWV
	Hv8rzvGh4Cvy36HrZFF3euN+HqVArEDCyRy1H2MfrQh1VXfDXfRkEXVGlDWfRoAEg/9NOpUowJy
	tSFvb1CqkneAT3udc93PHwSIj0QI/tydiHEJ93TvDL9t+AlgBvojYIKJTGOcBbuFPp4fnPCyTQZ
	gTZ6Mgl3boPN40ZQrTdNFnmThNXoXll4hPTsxbkrDBgC2f4KvTXwnOwoi11BoN9
X-Received: by 2002:a17:907:7ba9:b0:c15:d0ef:a0c3 with SMTP id
 a640c23a62f3a-c1c5093591bmr74498466b.32.1784781298809; Wed, 22 Jul 2026
 21:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722114931.3557110-1-max.kellermann@ionos.com> <afb662b8da9c1365546f658d75f27c88903f8a9f.camel@dubeyko.com>
In-Reply-To: <afb662b8da9c1365546f658d75f27c88903f8a9f.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 23 Jul 2026 12:34:48 +0800
X-Gm-Features: AUfX_mwzMooYN3DkxYc_rUC_sxcwF_f4yADvVoWtrRdjn1aDa8hLR5SIjeKRzUI
Message-ID: <CAOJNxRKyeBw1cxtXwQXoUnGrguGhcYMDpf2Dujhp=jHofSDvNw@mail.gmail.com>
Subject: Re: [PATCH] ceph: avoid fs reclaim while using `current->journal_info`
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks & Regards
Xiubo

On Thu, 23 Jul 2026 at 01:20, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-22 at 13:49 +0200, Max Kellermann wrote:
> > handle_reply() stores a `ceph_mds_request` pointer in
> > `current->journal_info` while filling the inode and dentry cache from
> > an MDS reply.
> >
> > An allocation in this section can enter direct reclaim and prune
> > dentries from another filesystem.  If this dirties an ext4 inode,
> > ext4
> > starts a JBD2 transaction.  JBD2 interprets the Ceph request in
> > `current->journal_info` as a journal handle and dereferences the
> > request's `r_tid` as `h_transaction`, causing a kernel crash, e.g.:
> >
> >  Unable to handle kernel paging request at virtual address
> > 00000000077b4818
> >  [...]
> >  Internal error: Oops: 0000000096000004 [#1]  SMP
> >  Modules linked in:
> >  CPU: 6 UID: 0 PID: 2699135 Comm: kworker/6:3 Tainted: G
> > W           6.18.38-i3 #1113 NONE
> >  [...]
> >  Workqueue: ceph-msgr ceph_con_workfn
> >  pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >  pc : jbd2__journal_start+0x2c/0x208
> >  lr : __ext4_journal_start_sb+0x100/0x178
> >  [...]
> >  Call trace:
> >   jbd2__journal_start+0x2c/0x208 (P)
> >   __ext4_journal_start_sb+0x100/0x178
> >   ext4_dirty_inode+0x3c/0x90
> >   __mark_inode_dirty+0x58/0x400
> >   iput.part.0+0x2b0/0x370
> >   iput+0x18/0x30
> >   dentry_unlink_inode+0xc0/0x158
> >   __dentry_kill+0x80/0x250
> >   shrink_dentry_list+0x90/0x130
> >   prune_dcache_sb+0x60/0x98
> >   super_cache_scan+0xe8/0x190
> >   do_shrink_slab+0x174/0x388
> >   shrink_slab+0xd8/0x4c0
> >   shrink_node+0x31c/0x908
> >   do_try_to_free_pages+0xd0/0x508
> >   try_to_free_pages+0x11c/0x238
> >   __alloc_frozen_pages_noprof+0x4d0/0xdd0
> >   __folio_alloc_noprof+0x18/0x70
> >   __filemap_get_folio+0x248/0x440
> >   ceph_readdir_prepopulate+0x570/0x9e8
> >   mds_dispatch+0x1424/0x1ba0
> >   ceph_con_process_message+0x74/0xa0
> >   ceph_con_v1_try_read+0x3a0/0x1510
> >   ceph_con_workfn+0x260/0x460
> >
> > Enter a scoped NOFS allocation context and leave it after clearing
> > `journal_info`.  This prevents filesystem reclaim from recursing into
> > another filesystem while the field contains Ceph-private data.
> >
> > Fixes: 315f24088048 ("ceph: fix security xattr deadlock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > ---
> >  fs/ceph/mds_client.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 853bf698b356..3c692ad02c85 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/delay.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/seq_file.h>
> > @@ -4015,6 +4016,7 @@ static void handle_reply(struct
> > ceph_mds_session *session, struct ceph_msg *msg)
> >       struct ceph_mds_reply_head *head = msg->front.iov_base;
> >       struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply
> > info */
> >       struct ceph_snap_realm *realm;
> > +     unsigned int nofs_flags;
> >       u64 tid;
> >       int err, result;
> >       int mds = session->s_mds;
> > @@ -4158,6 +4160,14 @@ static void handle_reply(struct
> > ceph_mds_session *session, struct ceph_msg *msg)
> >
> >       /* insert trace into our cache */
> >       mutex_lock(&req->r_fill_mutex);
> > +
> > +     /* disable fs reclaim while we are using current-
> > >journal_info
> > +      * for our own purposes, or else shrinkers of other
> > +      * filesystems might dereference this pointer as a different
> > +      * type
> > +      */
> > +     nofs_flags = memalloc_nofs_save();
> > +
> >       current->journal_info = req;
> >       err = ceph_fill_trace(mdsc->fsc->sb, req);
> >       if (err == 0) {
> > @@ -4166,6 +4176,7 @@ static void handle_reply(struct
> > ceph_mds_session *session, struct ceph_msg *msg)
> >                       err = ceph_readdir_prepopulate(req, req-
> > >r_session);
> >       }
> >       current->journal_info = NULL;
> > +     memalloc_nofs_restore(nofs_flags);
> >       mutex_unlock(&req->r_fill_mutex);
> >
> >       up_read(&mdsc->snap_rwsem);
>
> Makes sense.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.
