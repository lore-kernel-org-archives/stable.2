Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914275;
	b=2ut1yxVMbCuGx2OO8OZKVxIsg9IqFPkAByZUOE3Pu4rh9T+6lkNXbIolAw1EzZ733/wL
	 GEkJkree+CHDFMr2YjBvBQxjsOD6b5MqFC0LMV5fOo2eGB4m9nOh8eyalGAHL0q46h7Vi
	 yI2hyMcTTP5b4K2iAfdYbM6iIGTwPXqdkXHjCn6z0am+FttC1HIuXI2Y88jVBY/DdaHLS
	 rAjDKdo4yEZ1+rhnrS/2zdxN1lmfK0Faokn8gpfZvkMahSs3UK0V6m/9Dta+OMEbGzZe1
	 +YpjU5jNb3sQu2pGPmJleLME/R0AY69/bFQ0InxhyP5kC45oZv0iOuECyD250BHPcsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914275;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ChocN/q2mB/E5VW7WeyrIaoqTP6cF6JJgg9ERaIrNlw=;
	b=hHbtoVFetWkbIJgck86p+P4D09mGExc+rxkbl2DuTjh5zDmCuguoPgZQoq+CI+xbPyQY
	 GhnB3W2eF214aanx7j/Y0zR0X0X9BeM0N4+iPpTdLoId8K0PSMmK1xrYl7vTcx0QyN/c4
	 kstyaHjOnb1pgNf3qVpzyCSD/cdQmJD+SCDLVK5Az86q1DL00LAY78Ig/kkqgv4nqkNkF
	 aBYKOh8bc1kRFbVQwsvJgOik0NYEAMmttxWzkTrRLFnaildrskKvEjDZz40YIq8+ZB6K4
	 7OV7yQPBC8PChX4URLEqyMLzwx7uxZ9wIQPJB5D/tRbgtoFoz6wwwrUzZUqpYnvM8OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtyxnH7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5F606A326;
	Thu,  5 Nov 2026 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtyxnH7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7921F0089F;
	Thu,  5 Nov 2026 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914274;
	bh=ChocN/q2mB/E5VW7WeyrIaoqTP6cF6JJgg9ERaIrNlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gtyxnH7Dh1qyli13VX8NB4igOYMzNXl1zSFCmuK7NH29Nc0diIzMZPvos16SoZTgr
	 foXhvw/UWMooFgepWTprYPQCkp7XcS7MHfrm0X3OcW4VtBlQrUKIiDT55BjOc0YTuC
	 68oI2abfveQMYJdolwMKouuZ4UB8/nZHEAAW/esjsCN3S+mRVH+hAYlFHmIaUhV5RX
	 f5V6YoCvvCGxypc8GBQxHvugBWwrru0fSSqB+z1vtaq8XxyxuGBqm1O6hK0Zeh+UUO
	 odtorYfejzADLXOxddE6ATwiULslxCf6QplSVmHyEBm02dH+G4vu35jSIa3ZVLOyuX
	 JQmCmeCmjRfqA==
Date: Thu, 5 Nov 2026 22:31:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH RFC 18/38] proc: don't WARN about a name that is already
 registered
Message-ID: <20261105-wegstecken-dingfest-nennen-25356ee389f3@brauner>
References: <20261102-work-procfs-bugfixes-v1-18-59422ed3e465@kernel.org>
 <9cb48eaf-72f2-4e9f-b979-1ead58deb22f@p183>
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
In-Reply-To: <9cb48eaf-72f2-4e9f-b979-1ead58deb22f@p183>

On Wed, Nov 04, 2026 at 09:43:43PM +0300, Alexey Dobriyan wrote:
> Now, some names do come from userspace but it is up to subsystems to
> find duplicates and return errors (and sanitize for dots/slashes!).

Agreed. pktgen seems to be the only case suffering from this currently.
I dropped this patch and added. Tested and the WARN goes away.

-- >8 --
From e919a2c72296008ea07b5930bc9e02d59743bbbd Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 5 Nov 2026 18:02:42 +0100
Subject: [PATCH] net: pktgen: don't register a device file under a name that
The device files of pktgen share /proc/net/pktgen with pgctrl and the
thread files, and a device can be named like either of them:

  ip link set lo name pgctrl
  ip link set pgctrl up
  echo "add_device pgctrl" > /proc/net/pktgen/kpktgend_0

  proc_dir_entry 'pktgen/pgctrl' already registered
  WARNING: fs/proc/generic.c:404 at proc_register+0x555/0x8b0, CPU#0: bash/241
  Call Trace:
   proc_create_data+0x9f/0xf0
   pktgen_thread_write+0xd9b/0x1780
   proc_reg_write+0x1c2/0x3c0
   vfs_write+0x1cd/0xfa0

The same happens from the netdev notifier when a device that pktgen has
a file for is renamed to pgctrl, and when a device that two threads
have under different "@" suffixes is renamed, both files move to the
bare device name then. The files of a network namespace belong to the
root of its user namespace and none of this needs a capability. So
once pktgen is loaded an unprivileged user can taint the kernel, or
crash it with panic_on_warn, from namespaces of its own.

Remember the name a device file is registered under and refuse a name
that pgctrl, a thread file or another device file has, both for
"add_device" and before the file of a renamed device moves, which then
keeps its old name. The thread files go by the prefix of their names,
the threads of a namespace are created one after the other while its
first thread file can be written already.

Reported-by: Chris Mason <mason@kernel.org>
Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/r/9cb48eaf-72f2-4e9f-b979-1ead58deb22f@p183
Fixes: 6c2f91e077f1 ("proc: use WARN() rather than printk+backtrace")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/core/pktgen.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 02af70d360bc..4dd5920d5769 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -240,6 +240,7 @@ static char *pkt_flag_names[] = {
 #define PKTGEN_MAGIC 0xbe9be955
 #define PG_PROC_DIR "pktgen"
 #define PGCTRL	    "pgctrl"
+#define PG_THREAD_PREFIX "kpktgend_"
 
 #define MAX_CFLOWS  65536
 
@@ -416,6 +417,7 @@ struct pktgen_dev {
 				  */
 	netdevice_tracker dev_tracker;
 	char odevname[32];
+	char procname[32];	/* the name of ->entry in /proc/net/pktgen */
 	struct flow_state *flows;
 	unsigned int cflows;	/* Concurrent flows (config) */
 	unsigned int lflow;		/* Flow length  (config) */
@@ -2044,6 +2046,34 @@ static bool __pktgen_NN_threads(const struct pktgen_net *pn,
 	return false;
 }
 
+/*
+ * A device can be named like pgctrl or a thread file. Threads are still
+ * being created while the first thread file is writable, so match thread
+ * names by prefix. Called with pktgen_thread_lock held.
+ */
+static bool pktgen_proc_name_taken(const struct pktgen_net *pn,
+				   const char *name)
+{
+	const struct pktgen_thread *t;
+	const struct pktgen_dev *pkt_dev;
+
+	lockdep_assert_held(&pktgen_thread_lock);
+
+	if (!strcmp(name, PGCTRL) || str_has_prefix(name, PG_THREAD_PREFIX))
+		return true;
+	rcu_read_lock();
+	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
+		list_for_each_entry_rcu(pkt_dev, &t->if_list, list) {
+			if (pkt_dev->entry && !strcmp(name, pkt_dev->procname)) {
+				rcu_read_unlock();
+				return true;
+			}
+		}
+	}
+	rcu_read_unlock();
+	return false;
+}
+
 /*
  * mark a device for removal
  */
@@ -2091,13 +2121,22 @@ static void pktgen_change_name(const struct pktgen_net *pn, struct net_device *d
 			if (pkt_dev->odev != dev)
 				continue;
 
+			/* renamed back to the name the file kept */
+			if (pkt_dev->entry && !strcmp(pkt_dev->procname, dev->name))
+				break;
+			if (pktgen_proc_name_taken(pn, dev->name)) {
+				pr_err("can't move proc entry for '%s', the name is taken\n",
+				       dev->name);
+				break;
+			}
 			proc_remove(pkt_dev->entry);
-
 			pkt_dev->entry = proc_create_data(dev->name, 0600,
 							  pn->proc_dir,
 							  &pktgen_if_proc_ops,
 							  pkt_dev);
-			if (!pkt_dev->entry)
+			if (pkt_dev->entry)
+				strscpy(pkt_dev->procname, dev->name);
+			else
 				pr_err("can't move proc entry for '%s'\n",
 				       dev->name);
 			break;
@@ -3841,6 +3880,10 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 		pr_err("ERROR: interface already used\n");
 		return -EBUSY;
 	}
+	if (pktgen_proc_name_taken(t->net, ifname)) {
+		pr_err("ERROR: %s/%s is taken\n", PG_PROC_DIR, ifname);
+		return -EEXIST;
+	}
 
 	pkt_dev = kzalloc_node(sizeof(struct pktgen_dev), GFP_KERNEL, node);
 	if (!pkt_dev)
@@ -3888,6 +3931,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 		err = -EINVAL;
 		goto out2;
 	}
+	strscpy(pkt_dev->procname, ifname);
 #ifdef CONFIG_XFRM
 	pkt_dev->ipsmode = XFRM_MODE_TRANSPORT;
 	pkt_dev->ipsproto = IPPROTO_ESP;
@@ -3937,7 +3981,8 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
 	list_add_tail(&t->th_list, &pn->pktgen_threads);
 	init_completion(&t->start_done);
 
-	p = kthread_create_on_cpu(pktgen_thread_worker, t, cpu, "kpktgend_%d");
+	p = kthread_create_on_cpu(pktgen_thread_worker, t, cpu,
+				  PG_THREAD_PREFIX "%d");
 	if (IS_ERR(p)) {
 		pr_err("kthread_create_on_node() failed for cpu %d\n", t->cpu);
 		list_del(&t->th_list);
-- 
2.53.0


-- 
