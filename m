Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780671;
	b=SR/AFwDOiuratPstDfypXTdzO4yZeMXKgAS/fDfiPhhLpvv4/qMvZf6UPpJmlLLIQXcd
	 tM2uSdpXmTZQ82n9upMkcEy9CFpE5BjXo3UDvTRW1iXczrRpAaShElnfLzQF9iNbXD/1h
	 9exzEJDTEQHdZK0D+IQf0MQGY2BqvvBdQTxieXj3ZWKGisv8ywXim0Xp8OxgQ7C9ojoJp
	 PAmrty+N3Q9pHRLRZOxFT8rr1VuxB26lc/AgqHIhXQ24jxy31Y6BZBsU/dSMGVkhOjXlq
	 T9gZjNxDF668iQ48dYwWDDBz3LRfRQnpQErlEC7q2ejVzMztFBMdnM6nYzhEcfsLe4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780671;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lYh1X6gu3bEoP46ZRo2CKjE7Ru+ghnrATHznTlKdHL4=;
	b=kbFtHpKmDu++PXJhhT2uq7bjZuUg1r3tf32FkG2YWcLZUt+E+fYfgIsRVQgFR5gYr5Hl
	 bgvj2APdse4pz1rf2hkWcdHhzN+HAFvHqb/Q9NZ+9mHbfhOBJfmD6D69jkAwF6nrnA3bS
	 AR/Uh8X9hAIJ3u3DKR5qjHYdXN1jM12HtinqsHEVN152/G7dJIr/woYFYtePj8On6un8z
	 0dXSN0w2KZhQ+K3+URsXOY+7O7kMu2Mzqf2eiHYkACjmu2vs6Ed3n3u8Uh7xugJ5Q4MHa
	 QHnb2TtOMDyJiPgXB4fdITXASGHzcwlSnwYEbQhjHfxLPXy4kJFmy7Zr1EIcj5jCshA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="Rk/83KGr";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446CC606A31E;
	Fri, 27 Nov 2026 11:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 446CC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Rk/83KGr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lYh1X6gu3bEoP46ZRo2CKjE7Ru+ghnrATHznTlKdHL4=; b=Rk/83KGraaBTfzF4MfaRTlvEZm
	8ybOmvlau3oTGuJUOzEHc/VNvlHXS4VVgzoE7IqQ7/5enq9PE6hephpIAGNDSgZFCQaBM+cKWC0lZ
	QiuMRd8mzBa354QpthZIOsDVSSwt+0g+OtNVgjDiPJbhh0tsiwG8imhJP1ONg0A25f0EhZ1j1l2k1
	AR3Trg/rcUnTaFrhOJEmcuHijwnp9M0D9z/Hoezdwx5F+Ji/FRM3qwaN7pgET6aiNJaBvqbs+IuQg
	XY3a4DTxxHQjX5ahvGDNr83Ioqgr55mQmoSqkLybgWTBq/VAUryzJecM9WVvExMKE+p/9cTdZLjFO
	ZEQOS9ng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWuaJ-0000000C3hu-0A3I;
	Fri, 27 Nov 2026 11:57:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE34830027B; Fri, 27 Nov 2026 12:57:45 +0100 (CET)
Date: Fri, 27 Nov 2026 12:57:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261127115745.GA2883950@noisy.programming.kicks-ass.net>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
 <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
 <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>
 <20261127081303.GN49833@noisy.programming.kicks-ass.net>
 <20261127091852.GD83911@noisy.programming.kicks-ass.net>
 <20261127-tonlage-pilze-demolieren-5948f82f401c@brauner>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-tonlage-pilze-demolieren-5948f82f401c@brauner>

On Fri, Nov 27, 2026 at 10:45:28AM +0100, Christian Brauner wrote:

> > @@ -12310,11 +12361,8 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
> >  
> >  				ret = -EINVAL;
> >  				if (!filter->path.dentry ||
> > -				    !S_ISREG(d_inode(filter->path.dentry)
> > -					     ->i_mode))
> > +				    !S_ISREG(d_inode(filter->path.dentry)->i_mode))
> >  					goto fail;
> 
> Just a thought on this. In vfs-7.5.lookup I have:
> 
> file_check_backing() which is the new default way to figure out whether
> something can be a backing file for a given subsystem. Its checks are:
> 
> int file_check_backing(const struct file *file, fmode_t mode, umode_t type)
> {
> 	fmode_t io = mode & (FMODE_READ | FMODE_WRITE);
> 	/* Drivers may point ->f_mapping at something else. */
> 	umode_t fmt = file_inode(file)->i_mode & S_IFMT;
> 	struct inode *real_inode;
> 
> 	/* O_PATH files are only fine for callers that just use the path. */
> 	if ((file->f_mode & FMODE_PATH) && !(mode & FMODE_PATH))
> 		return -EBADF;
> 
> 	if ((file->f_mode & io) != io)
> 		return -EBADF;
> 
> 	if (fmt != S_IFREG && !(type == S_IFBLK && fmt == S_IFBLK))
> 		return -EINVAL;
> 
> 	/* Look through stacking filesystems at the inode with the data. */
> 	real_inode = d_real_data_inode(file->f_path.dentry);
> 	if (IS_ERR(real_inode))
> 		return PTR_ERR(real_inode);
> 	if (real_inode->i_sb->s_iflags & SB_I_PSEUDO)
> 		return -EINVAL;
> 
> 	if ((mode & FMODE_READ) &&
> 	    (!(file->f_mode & FMODE_CAN_READ) || !file->f_op->read_iter))
> 		return -EINVAL;
> 
> 	if ((mode & FMODE_WRITE) &&
> 	    (!(file->f_mode & FMODE_CAN_WRITE) || !file->f_op->write_iter))
> 		return -EINVAL;
> 
> 	return 0;
> }
> 
> It excludes anything that is a pseudo filesystem:
> 
> arch/powerpc/platforms/cell/spufs/inode.c:      fc_init_pseudo(fc);
> arch/s390/hypfs/inode.c:        fc_init_pseudo(fc);
> drivers/android/binder/rust_binderfs.c: fc_init_pseudo(fc);
> drivers/usb/gadget/function/f_fs.c:     fc_init_pseudo(fc);
> drivers/usb/gadget/legacy/inode.c:      fc_init_pseudo(fc);
> drivers/xen/xenfs/super.c:      fc_init_pseudo(fc);
> fs/binfmt_misc.c:       fc_init_pseudo(fc);
> fs/configfs/mount.c:    fc_init_pseudo(fc);
> fs/debugfs/inode.c:     fc_init_pseudo(fc);
> fs/devpts/inode.c:      fc_init_pseudo(fc);
> fs/efivarfs/super.c:    fc_init_pseudo(fc);
> fs/failfs.c:    fc_init_pseudo(fc);
> fs/fuse/control.c:      fc_init_pseudo(fsc);
> fs/kernfs/mount.c:      fc_init_pseudo(fc);
> fs/libfs.c:             fc_init_pseudo(fc);
> fs/nfsd/nfsctl.c:       fc_init_pseudo(fc);
> fs/nullfs.c:    fc_init_pseudo(fc);
> fs/ocfs2/dlmfs/dlmfs.c: fc_init_pseudo(fc);
> fs/openpromfs/inode.c:  fc_init_pseudo(fc);
> fs/proc/root.c: fc_init_pseudo(fc);
> fs/pstore/inode.c:      fc_init_pseudo(fc);
> fs/tracefs/inode.c:     fc_init_pseudo(fc);
> include/linux/pseudo_fs.h:static inline void fc_init_pseudo(struct fs_context *fc)
> ipc/mqueue.c:   fc_init_pseudo(fc);
> kernel/bpf/inode.c:     fc_init_pseudo(fc);
> net/sunrpc/rpc_pipe.c:  fc_init_pseudo(fc);
> security/apparmor/apparmorfs.c: fc_init_pseudo(fc);
> security/inode.c:       fc_init_pseudo(fc);
> security/selinux/selinuxfs.c:   fc_init_pseudo(fc);
> security/smack/smackfs.c:       fc_init_pseudo(fc);
> 
> I don't think anything on this list is something that you would ever
> want to use as an object file?

Very very possibly people would like /proc/kcore to self reference or
something, but I'm not sure that's a thing. Adrian?

> I think we should do an O_PATH open of the target file and then you
> call:
> 
> file = filp_open(filename, O_PATH | O_REGULAR, 0)
> 
> if (file_check_backing(file, FMODE_PATH, 0))
> 	return -EINVAL;

We must close file, or does it have __free(file) on or something?

> We had a whole bug class where various subsystems that used backing
> files just allowed arbitrary files to be used.

This seems fine to me and can go in independent of this locking stuff.
