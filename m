Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772734;
	b=lYC2ZsxabBap6z7AW3CyYr8mZZ/oX6BIGZ2usps/ye92dB8ZPN+oA0hH+eIvyna0uKoO
	 skkNCnd9pK6CYDxmcFtSWWDdVXm7UUOMB17BwOS9BKD/ONMPRPdWGb6PGWN5DrX4Zv9zy
	 /d/ZYMUPY189m7/LSJ2MzlSqwB64rRoijOAI+ir7FJq4c9vmU37C2MjQOpw6J6nJwaBOW
	 Y+QPrstHIsMTxN+afWPTXuA7topKQsFoq+OwatByjbExKB3so5LKjDLLxxjhl2aczti3O
	 G8zMVRLr5riSa4REGg7tRuQgiDoKP7zccqZ74uIDlNNRjtQCqe7RNEyfCp1B0T1CmMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772734;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RczoZg2Epk8iTLi3BcJGcft1wIDv/G28fsZ43jaIlC8=;
	b=WeX8FxXPFiY6wn5LGs4dywZT4/ZhdEzJNB4nv1FiluZbsjEfRMuSSA+azFOiJeywxxNu
	 ZREY1vRdXGiuiNkbQO82zCVJnWdynHVTtkfNP59gbYkANQoo1s7oyB98GBXuggv3PooJ1
	 vExVMBuCqPGZQ/VzD3247zK467YfJy2JDR/53rzH9egm/EeyDH/SvWtrUy7i3fsonjfE/
	 Dq/VdHqC+d7px44AOfrV5szhnpEAr/18ilbRqHjTgUq7NkrwQVmwdoIEFW5PCm9yZoPxn
	 O7dSjNNSsV3qtXngHvde5NAdTi3sdZViIOplLkIdm0gi/cl5oCCznrStyhUuRRapo1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+Jybfkf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5B606A31E;
	Fri, 27 Nov 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+Jybfkf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A231F000C1;
	Fri, 27 Nov 2026 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772734;
	bh=RczoZg2Epk8iTLi3BcJGcft1wIDv/G28fsZ43jaIlC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+Jybfkf+uM2Z4Bz7gFkrAEcGEmsYF6TNblOKK2JEe0WjTZxM52r/8xMXxHMyrl13
	 WbvM4gLObGcyluRttsE8TrMm1k0fOFCvc6SwUmmNL91SIx2Tjd9JiBkRj3zOyQxztH
	 XHSbf08rhGb4NJFAjZKXKjy8lle7uzN3/JYV6DWv2arg+rdYHeASta7eOofoXNOsUX
	 y1FJxtxQSxf7aaVLX0lYo+KIRP7GQYDOGMH0vbMC7GU88U5Ua8P49syEi7XLrTjHGb
	 yZs4k9bDrqSm8vi1Z4ehGHm7xScKJv/4Kyiyl+6tC3sZJwzbMG//kbYhwbLiKOMGYd
	 9BZ7xA21VRt8w==
Date: Fri, 27 Nov 2026 10:45:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261127-tonlage-pilze-demolieren-5948f82f401c@brauner>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
 <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
 <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>
 <20261127081303.GN49833@noisy.programming.kicks-ass.net>
 <20261127091852.GD83911@noisy.programming.kicks-ass.net>
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
Content-Disposition: inline
In-Reply-To: <20261127091852.GD83911@noisy.programming.kicks-ass.net>

On Fri, Nov 27, 2026 at 10:18:52AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 27, 2026 at 09:13:03AM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 26, 2026 at 10:26:02PM +0100, Christian Brauner wrote:
> > > So ok, if we can't drop ctx->mutex in the middle of the ioctl then how
> > > about we don't hold ctx->mutex during parsing to begin with?
> > > We let perf_ioctl() hand PERF_EVENT_IOC_SET_FILTER off before it takes
> > > the mutex:
> > > 
> > > ioctl(PERF_EVENT_IOC_SET_FILTER)
> > > -> perf_ioctl()
> > >    -> perf_event_set_filter()                // no ctx->mutex
> > >       -> perf_event_set_addr_filter()
> > >          -> perf_event_parse_addr_filter()   // kern_path(), own list
> > >          -> perf_event_ctx_lock()
> > >             // revoked? has_addr_filter()? ->addr_filters_validate()
> > >             -> perf_addr_filters_splice()
> > >             -> perf_event_addr_filters_apply() on each child
> > >          -> perf_event_ctx_unlock()
> > > 
> > > The parser fills its own list and counts the file filters in locals.
> > > Everything that needs ctx->mutex then happens in one go under
> > > perf_event_ctx_lock().
> > > 
> > > So ctx->mutex is never dropped in the middle of an ioctl, a migrated
> > > event is handled by perf_event_ctx_lock() like everywhere else and no
> > > ctx is carried across the lookup?
> > 
> > Let me try this.
> 
> Compile tested only; Alexander, Adrian; could any of you take a hard
> look at this and actually test?
> 
> ---
>  kernel/events/core.c | 135 +++++++++++++++++++++++++--------------------------
>  1 file changed, 67 insertions(+), 68 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 77c501005143..c019e4faf655 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6632,16 +6632,24 @@ static inline bool is_perf_file(struct fd f)
>  
>  static int perf_event_set_output(struct perf_event *event,
>  				 struct perf_event *output_event);
> -static int perf_event_set_filter(struct perf_event *event, void __user *arg);
> +static int perf_event_set_filter(struct perf_event *event, struct list_head *filters);
>  static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  			  struct perf_event_attr *attr);
>  static int __perf_event_set_bpf_prog(struct perf_event *event,
>  				     struct bpf_prog *prog,
>  				     u64 bpf_cookie);
>  
> -static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
> +struct perf_ioctl_ctx {
> +	unsigned int cmd;
> +	unsigned long arg;
> +	struct list_head filters;
> +};
> +
> +static long _perf_ioctl(struct perf_event *event, struct perf_ioctl_ctx *ctx)
>  {
>  	void (*func)(struct perf_event *);
> +	unsigned long arg = ctx->arg;
> +	unsigned int cmd = ctx->cmd;
>  	u32 flags = arg;
>  
>  	if (event->state <= PERF_EVENT_STATE_REVOKED)
> @@ -6692,7 +6700,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  	}
>  
>  	case PERF_EVENT_IOC_SET_FILTER:
> -		return perf_event_set_filter(event, (void __user *)arg);
> +		return perf_event_set_filter(event, &ctx->filters);
>  
>  	case PERF_EVENT_IOC_SET_BPF:
>  	{
> @@ -6751,10 +6759,21 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  	return 0;
>  }
>  
> +static inline bool perf_event_is_tracing(struct perf_event *event);
> +static void free_filters_list(struct list_head *filters);
> +static int
> +perf_event_parse_addr_filter(int event_node, bool event_task, char *fstr,
> +			     struct list_head *filters);
> +
>  static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct perf_event *event = file->private_data;
>  	struct perf_event_context *ctx;
> +	struct perf_ioctl_ctx ic = {
> +		.cmd = cmd,
> +		.arg = arg,
> +		.filters = LIST_HEAD_INIT(ic.filters),
> +	};
>  	long ret;
>  
>  	/* Treat ioctl like writes as it is likely a mutating operation. */
> @@ -6762,10 +6781,34 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	if (ret)
>  		return ret;
>  
> +	if (cmd == PERF_EVENT_IOC_SET_FILTER) {
> +		int cpu = READ_ONCE(event->cpu);
> +		int node = cpu == -1 ? NUMA_NO_NODE : cpu_to_node(cpu);
> +		bool task = event->attach_state & PERF_ATTACH_TASK;
> +		char *filter_str __free(kfree) =
> +			strndup_user((void __user *)arg, PAGE_SIZE);
> +
> +		if (IS_ERR(filter_str))
> +			return PTR_ERR(filter_str);
> +
> +#ifdef CONFIG_EVENT_TRACING
> +		if (perf_event_is_tracing(event)) {
> +			return ftrace_profile_set_filter(event, event->attr.config,
> +							filter_str);
> +		}
> +#endif
> +		ret = perf_event_parse_addr_filter(node, task, filter_str,
> +						   &ic.filters);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ctx = perf_event_ctx_lock(event);
> -	ret = _perf_ioctl(event, cmd, arg);
> +	ret = _perf_ioctl(event, &ic);
>  	perf_event_ctx_unlock(event, ctx);
>  
> +	free_filters_list(&ic.filters);
> +
>  	return ret;
>  }
>  
> @@ -11990,9 +12033,8 @@ void perf_bp_event(struct perf_event *bp, void *data)
>   * Allocate a new address filter
>   */
>  static struct perf_addr_filter *
> -perf_addr_filter_new(struct perf_event *event, struct list_head *filters)
> +perf_addr_filter_new(int node, struct list_head *filters)
>  {
> -	int node = cpu_to_node(event->cpu == -1 ? 0 : event->cpu);
>  	struct perf_addr_filter *filter;
>  
>  	filter = kzalloc_node(sizeof(*filter), GFP_KERNEL, node);
> @@ -12035,8 +12077,17 @@ static void perf_addr_filters_splice(struct perf_event *event,
>  	raw_spin_lock_irqsave(&event->addr_filters.lock, flags);
>  
>  	list_splice_init(&event->addr_filters.list, &list);
> -	if (head)
> +	event->addr_filters.nr_file_filters = 0;
> +
> +	if (head) {
> +		struct perf_addr_filter *filter;
> +
>  		list_splice(head, &event->addr_filters.list);
> +		list_for_each_entry(filter, &event->addr_filters.list, entry) {
> +			if (filter->path.dentry)
> +				event->addr_filters.nr_file_filters++;
> +		}
> +	}
>  
>  	raw_spin_unlock_irqrestore(&event->addr_filters.lock, flags);
>  
> @@ -12186,7 +12237,7 @@ static const match_table_t if_tokens = {
>   * Address filter string parser
>   */
>  static int
> -perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
> +perf_event_parse_addr_filter(int event_node, bool event_task, char *fstr,
>  			     struct list_head *filters)
>  {
>  	struct perf_addr_filter *filter = NULL;
> @@ -12213,7 +12264,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
>  
>  		/* filter definition begins */
>  		if (state == IF_STATE_ACTION) {
> -			filter = perf_addr_filter_new(event, filters);
> +			filter = perf_addr_filter_new(event_node, filters);
>  			if (!filter)
>  				goto fail;
>  		}
> @@ -12299,7 +12350,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
>  				 * different processes.
>  				 */
>  				ret = -EOPNOTSUPP;
> -				if (!event->ctx->task)
> +				if (!event_task)
>  					goto fail;
>  
>  				/* look up the path and grab its inode */
> @@ -12310,11 +12361,8 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
>  
>  				ret = -EINVAL;
>  				if (!filter->path.dentry ||
> -				    !S_ISREG(d_inode(filter->path.dentry)
> -					     ->i_mode))
> +				    !S_ISREG(d_inode(filter->path.dentry)->i_mode))
>  					goto fail;

Just a thought on this. In vfs-7.5.lookup I have:

file_check_backing() which is the new default way to figure out whether
something can be a backing file for a given subsystem. Its checks are:

int file_check_backing(const struct file *file, fmode_t mode, umode_t type)
{
	fmode_t io = mode & (FMODE_READ | FMODE_WRITE);
	/* Drivers may point ->f_mapping at something else. */
	umode_t fmt = file_inode(file)->i_mode & S_IFMT;
	struct inode *real_inode;

	/* O_PATH files are only fine for callers that just use the path. */
	if ((file->f_mode & FMODE_PATH) && !(mode & FMODE_PATH))
		return -EBADF;

	if ((file->f_mode & io) != io)
		return -EBADF;

	if (fmt != S_IFREG && !(type == S_IFBLK && fmt == S_IFBLK))
		return -EINVAL;

	/* Look through stacking filesystems at the inode with the data. */
	real_inode = d_real_data_inode(file->f_path.dentry);
	if (IS_ERR(real_inode))
		return PTR_ERR(real_inode);
	if (real_inode->i_sb->s_iflags & SB_I_PSEUDO)
		return -EINVAL;

	if ((mode & FMODE_READ) &&
	    (!(file->f_mode & FMODE_CAN_READ) || !file->f_op->read_iter))
		return -EINVAL;

	if ((mode & FMODE_WRITE) &&
	    (!(file->f_mode & FMODE_CAN_WRITE) || !file->f_op->write_iter))
		return -EINVAL;

	return 0;
}

It excludes anything that is a pseudo filesystem:

arch/powerpc/platforms/cell/spufs/inode.c:      fc_init_pseudo(fc);
arch/s390/hypfs/inode.c:        fc_init_pseudo(fc);
drivers/android/binder/rust_binderfs.c: fc_init_pseudo(fc);
drivers/usb/gadget/function/f_fs.c:     fc_init_pseudo(fc);
drivers/usb/gadget/legacy/inode.c:      fc_init_pseudo(fc);
drivers/xen/xenfs/super.c:      fc_init_pseudo(fc);
fs/binfmt_misc.c:       fc_init_pseudo(fc);
fs/configfs/mount.c:    fc_init_pseudo(fc);
fs/debugfs/inode.c:     fc_init_pseudo(fc);
fs/devpts/inode.c:      fc_init_pseudo(fc);
fs/efivarfs/super.c:    fc_init_pseudo(fc);
fs/failfs.c:    fc_init_pseudo(fc);
fs/fuse/control.c:      fc_init_pseudo(fsc);
fs/kernfs/mount.c:      fc_init_pseudo(fc);
fs/libfs.c:             fc_init_pseudo(fc);
fs/nfsd/nfsctl.c:       fc_init_pseudo(fc);
fs/nullfs.c:    fc_init_pseudo(fc);
fs/ocfs2/dlmfs/dlmfs.c: fc_init_pseudo(fc);
fs/openpromfs/inode.c:  fc_init_pseudo(fc);
fs/proc/root.c: fc_init_pseudo(fc);
fs/pstore/inode.c:      fc_init_pseudo(fc);
fs/tracefs/inode.c:     fc_init_pseudo(fc);
include/linux/pseudo_fs.h:static inline void fc_init_pseudo(struct fs_context *fc)
ipc/mqueue.c:   fc_init_pseudo(fc);
kernel/bpf/inode.c:     fc_init_pseudo(fc);
net/sunrpc/rpc_pipe.c:  fc_init_pseudo(fc);
security/apparmor/apparmorfs.c: fc_init_pseudo(fc);
security/inode.c:       fc_init_pseudo(fc);
security/selinux/selinuxfs.c:   fc_init_pseudo(fc);
security/smack/smackfs.c:       fc_init_pseudo(fc);

I don't think anything on this list is something that you would ever
want to use as an object file?

I think we should do an O_PATH open of the target file and then you
call:

file = filp_open(filename, O_PATH | O_REGULAR, 0)

if (file_check_backing(file, FMODE_PATH, 0))
	return -EINVAL;

We had a whole bug class where various subsystems that used backing
files just allowed arbitrary files to be used.
