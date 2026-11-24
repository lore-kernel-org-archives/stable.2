Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561185;
	b=SfbuIFgmIt3AKZ0y1e4Du43aermWdY2FJYa5LqBQBssXBpSj56CjItVlXFKENjQ9aF7Q
	 7MDA0gmkvcl1ZMe5iF3kNbv5iyaFKK/jLQJgtAYuilK/gX/lwM4kIzcVCudEMuXX7BLow
	 4ibXE5RUQANna+dT5uKsH8G7Jh4eWwDByCZip4bvy9qQOBtMUDVOnGGkikvitY1H7eEwN
	 CSJKxuj+kIon36npPrA8XeaWcswjzOO5HKcCh3uC3OxltJkE8+Ov84IxHuRdqlnEXzISl
	 sKUGw7Ooh+G4jJkPm0vj48Sfgj9aIoIc/LFGWya1iyL+nV2Fjh7vKpDswGEgcn8ml8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561185;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PVadO6FN4yERgIRYvZ1jIjoIb/Ez8TcW7BKAOAgnUo8=;
	b=Q07LniW5mci/SMJT3SwZZRUBlpwE1zsfuaB4YJYY5xx1XB8zXDeBiZFAnXcxdsbaVE8T
	 EJFkmhUH//jQC/YWNi8/bfFRU19vtoT00bhvnQRWivXodROJYadY/N4UModK2lh2XR60l
	 y1C4jiVC4hEnIVprN+Adcb7W7P9pK9KS2qGMTHgMCJVEmzPY+KfgZevUS9g9NqBHTHFGy
	 s2YXQ+FDF2RGjY/XHZImVVxmCAnSduxs6E0ynntxYPAMPy4uz+EQZkszn7wqjVcTUsi+1
	 1pxVjJuJoizyZZWCM1Y6JxuXWP4OUHr2qew1pI0K3iLRj/SxXi0tBX7vQNQlMRVbucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lbw0GxdG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9F606A321;
	Tue, 24 Nov 2026 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lbw0GxdG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3580E1F000C4;
	Tue, 24 Nov 2026 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561185;
	bh=PVadO6FN4yERgIRYvZ1jIjoIb/Ez8TcW7BKAOAgnUo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lbw0GxdG1Nz4OYr89mliWrg+kYmoXuGpeF3Gy9/2dbtXNZ0iSefXiM7lIBAM0nu3J
	 /69CBhU3xMLpaBoFqrZurjIhfD7jGd/cTR5OtTwwXmduswoZxlIuosPRpvNuWyk1SK
	 0kPp4/KUnIP1tuWwRhZuVCLrdQaMjU8pjLRTK/GsEcfw/fF64yjQ4WfwQNMIBnFbLS
	 uH1xp0WERf0s5Hx8LOgMekEUWtMI14yuoLpi+zSxnWTURAo8cbAxcfUESfjwivBsCE
	 L8zJNrzytFV6SV55S5iE/n2Y57ZRjMBmK4bdrqjjSWInapipQRLHyPWz4zJ1bZ5f2p
	 CfPqP08p9p0Ag==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:27 +0100
Subject: [PATCH RFC 04/19] perf: copy ioctl arguments without ctx->mutex
 held
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-4-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=7025; i=brauner@kernel.org;
 h=from:subject:message-id; bh=N17DCeHiDWeBL9NdRznr81HJuP5L50OLTyEoYplFMWc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzie06+nb3H9XVp+bPYNYKeX/QdNcXrtusH06Wcl7Y8
 rB0r1SgekcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEFmxm+F9nvaLvr17ujpqF
 M522Cbv1R/tu+bDLJ6P8e8CFc+tmVPQz/C/5t5rt4IJVRzquKqkuZlTI6nuRwMW6/dWtL963Wqq
 fv2QDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

perf_ioctl() calls _perf_ioctl() with the mutex of the event's context
held and a number of commands access userspace from there:

- PERF_EVENT_IOC_PERIOD copies the period from userspace.

- PERF_EVENT_IOC_ID copies the id to userspace.

- PERF_EVENT_IOC_SET_FILTER copies the filter string from userspace.

- PERF_EVENT_IOC_QUERY_BPF copies the query from userspace and the ids
  of the programs back.

- PERF_EVENT_IOC_MODIFY_ATTRIBUTES copies the attributes from userspace.

This is the same problem as for read(). If one of them faults the mutex
is held for as long as the fault takes and an exec of the task the event
counts for hangs with exec_update_lock held:

  locks held by perf-ioctl/217:
   #0: (&ctx->mutex){+.+.}-{4:4}, at: perf_event_ctx_lock_nested+0x18f/0x360
  locks held by exec-task/216:
   #0: (&sig->cred_guard_mutex){+.+.}-{4:4}, at: bprm_execve+0xb7/0x1400
   #1: (&sig->exec_update_lock){++++}-{4:4}, at: begin_new_exec+0xa4b/0x2df0
   #2: (&ctx->mutex){+.+.}-{4:4}, at: perf_event_exec+0x17e/0xe40
  locks held by stat-reader/218:
   #0: (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xc5/0x1280
   #1: (&sig->exec_update_lock){++++}-{4:4}, at: do_task_stat+0x13b/0x2870

Copy what comes from userspace before the mutex is taken and what goes
to userspace after it has been dropped.

PERF_EVENT_IOC_QUERY_BPF doesn't need the mutex. The programs of a
tracepoint are protected by bpf_event_mutex. So call
perf_event_query_prog_array() before the mutex is taken.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/events/core.c | 93 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f00eeded212c4..5f648e00ae661 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6635,14 +6635,25 @@ static inline bool is_perf_file(struct fd f)
 
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
-static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_filter(struct perf_event *event, char *filter_str);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
 static int __perf_event_set_bpf_prog(struct perf_event *event,
 				     struct bpf_prog *prog,
 				     u64 bpf_cookie);
 
-static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
+/*
+ * What perf_ioctl() copies from userspace before it takes ctx->mutex and
+ * what it copies back once it dropped it.
+ */
+struct perf_ioctl_data {
+	u64			value;
+	char			*filter;
+	struct perf_event_attr	attr;
+};
+
+static long _perf_ioctl(struct perf_event *event, unsigned int cmd,
+			unsigned long arg, struct perf_ioctl_data *data)
 {
 	void (*func)(struct perf_event *);
 	u32 flags = arg;
@@ -6665,22 +6676,11 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		return _perf_event_refresh(event, arg);
 
 	case PERF_EVENT_IOC_PERIOD:
-	{
-		u64 value;
+		return _perf_event_period(event, data->value);
 
-		if (copy_from_user(&value, (u64 __user *)arg, sizeof(value)))
-			return -EFAULT;
-
-		return _perf_event_period(event, value);
-	}
 	case PERF_EVENT_IOC_ID:
-	{
-		u64 id = primary_event_id(event);
-
-		if (copy_to_user((void __user *)arg, &id, sizeof(id)))
-			return -EFAULT;
+		data->value = primary_event_id(event);
 		return 0;
-	}
 
 	case PERF_EVENT_IOC_SET_OUTPUT:
 	{
@@ -6695,7 +6695,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 	}
 
 	case PERF_EVENT_IOC_SET_FILTER:
-		return perf_event_set_filter(event, (void __user *)arg);
+		return perf_event_set_filter(event, data->filter);
 
 	case PERF_EVENT_IOC_SET_BPF:
 	{
@@ -6729,19 +6729,9 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		return 0;
 	}
 
-	case PERF_EVENT_IOC_QUERY_BPF:
-		return perf_event_query_prog_array(event, (void __user *)arg);
-
-	case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
-		struct perf_event_attr new_attr;
-		int err = perf_copy_attr((struct perf_event_attr __user *)arg,
-					 &new_attr);
+	case PERF_EVENT_IOC_MODIFY_ATTRIBUTES:
+		return perf_event_modify_attr(event, &data->attr);
 
-		if (err)
-			return err;
-
-		return perf_event_modify_attr(event,  &new_attr);
-	}
 	default:
 		return -ENOTTY;
 	}
@@ -6758,6 +6748,7 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct perf_event *event = file->private_data;
 	struct perf_event_context *ctx;
+	struct perf_ioctl_data data;
 	long ret;
 
 	/* Treat ioctl like writes as it is likely a mutating operation. */
@@ -6765,10 +6756,46 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ret)
 		return ret;
 
+	/*
+	 * A copy from or to userspace can sleep in a page fault. Don't hold
+	 * ctx->mutex for it.
+	 */
+	data.filter = NULL;
+	switch (cmd) {
+	case PERF_EVENT_IOC_PERIOD:
+		if (copy_from_user(&data.value, (u64 __user *)arg,
+				   sizeof(data.value)))
+			return -EFAULT;
+		break;
+
+	case PERF_EVENT_IOC_SET_FILTER:
+		data.filter = strndup_user((void __user *)arg, PAGE_SIZE);
+		if (IS_ERR(data.filter))
+			return PTR_ERR(data.filter);
+		break;
+
+	case PERF_EVENT_IOC_QUERY_BPF:
+		/* Looks at the tracepoint's programs under bpf_event_mutex. */
+		return perf_event_query_prog_array(event, (void __user *)arg);
+
+	case PERF_EVENT_IOC_MODIFY_ATTRIBUTES:
+		ret = perf_copy_attr((struct perf_event_attr __user *)arg,
+				     &data.attr);
+		if (ret)
+			return ret;
+		break;
+	}
+
 	ctx = perf_event_ctx_lock(event);
-	ret = _perf_ioctl(event, cmd, arg);
+	ret = _perf_ioctl(event, cmd, arg, &data);
 	perf_event_ctx_unlock(event, ctx);
 
+	kfree(data.filter);
+
+	if (!ret && cmd == PERF_EVENT_IOC_ID &&
+	    copy_to_user((void __user *)arg, &data.value, sizeof(data.value)))
+		return -EFAULT;
+
 	return ret;
 }
 
@@ -12367,14 +12394,9 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 	return ret;
 }
 
-static int perf_event_set_filter(struct perf_event *event, void __user *arg)
+static int perf_event_set_filter(struct perf_event *event, char *filter_str)
 {
 	int ret = -EINVAL;
-	char *filter_str;
-
-	filter_str = strndup_user(arg, PAGE_SIZE);
-	if (IS_ERR(filter_str))
-		return PTR_ERR(filter_str);
 
 #ifdef CONFIG_EVENT_TRACING
 	if (perf_event_is_tracing(event)) {
@@ -12399,7 +12421,6 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	if (has_addr_filter(event))
 		ret = perf_event_set_addr_filter(event, filter_str);
 
-	kfree(filter_str);
 	return ret;
 }
 

-- 
2.53.0

