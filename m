Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E683EF0A6;
	Fri,  2 Oct 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959266; cv=none; b=sSAfD1goexPoqVH8xrm+ragD4bqsvCdwYFAO5rNv4nJHRd9HoXwZheO3Gnc2lUjPrTKMixa3rwbpv8xc3qqkkpICMJ0mLKznKigN9c68MDW992Dm5r5t/ROuQ9Rq9Yp+w5ZmxLM2dPUmrv0s/tLnPekDU6rppAqRsKaH1L/ql+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959266; c=relaxed/simple;
	bh=Jxsu3E//kk8OlXjELtyxUZx8BtwtdzOD5H2eK6cvCis=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=AdHmqO4S7LlR/xmofctOJ6cNeiOLo05sKIEZOw5TtpnRwNUMRwLiKH+xiUzzK/RkwJWwfnfRkg28wFjUywV6bz/uCjAFerLv1mOG5yiI8v983XPGtkSSUXF6D/+7EhoDaKk01vezYNwS+X0qKb3/WRqECMhdkp+dkJAk+yawbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WRdBAa3o; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=xiP2SC4L; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WRdBAa3o";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="xiP2SC4L"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790959252; bh=R7qA7dnGvKjiso23y8hvLPI
	cBe4EcGl0kizpnGr4xNI=; b=WRdBAa3o4V07s2B1Zr2yJPpJ0S/1VhVKtakU5He3fxKiZzIdFK
	uzj8X4/LEo85YHoeMI0w+OAaSjv7LffoKmiBlWFClbiXE713sKepUdeZjpjuYJErt/9a0S1TLBo
	rxmqaGDMANlbTD2MV5sU0LhAxTHqQW110DBRalPV7Y2aMr4jVoEsEzaVesYfHbX+SaNVVRig7zX
	va+CtesvFwt8hnFHhp/Eo4WyyTzosFPsI7YbiyJkeFAuXz/KP0a/fHFrU8+tJjp269AwdX0hs/m
	p1jvBawDDj5xxnPa3PJiEj36nfqrUaJMThGI82Tc4dVn33zb/UlC6SslhVmX4HYHX9g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790959252; bh=R7qA7dnGvKjiso23y8hvLPI
	cBe4EcGl0kizpnGr4xNI=; b=xiP2SC4LKMXvww+ZLwFq2feDldQANnQlPWOI/GQB9nFxqAIl59
	awuKi8y03i7IwRTl9P/8QGJ3sn077RoSxJAw==;
Date: Fri, 02 Oct 2026 17:40:52 +0100
From: Bradley Morgan <brads@mainlining.org>
To: tjdqudcks0424@naver.com
CC: akpm@linux-foundation.org, bsingharora@gmail.com, cyyzero16@gmail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, stable@vger.kernel.org,
 xu.xin@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/2=5D_taskstats=3A_route_ex?=
 =?US-ASCII?Q?it_listener_records_through_their_netns?=
In-Reply-To: <20261002105614.195370-2-tjdqudcks0424@naver.com>
Message-ID: <C72ED743-DBDC-4DDA-92E2-58B8AF529011@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 2 October 2026 11:56:13 BST, tjdqudcks0424@naver.com wrote:
>From: 성병찬 <tjdqudcks0424@naver.com>
>
>Commit edc73c7261ca ("kernel: make taskstats available from all net
>namespaces") made the taskstats Generic Netlink family available from all
>network namespaces. CPU-mask listener registrations, however, still store
>only a bare netlink port ID in a global per-CPU list and send exit records
>through init_net.
>
>Netlink port IDs are namespace-local. An administrator can register an
>exit
>listener after unsharing only the network namespace, while an unprivileged
>init_net socket binds the same numeric port ID. The latter then receives
>taskstats for exiting tasks of other UIDs. It cannot register a listener
>or
>issue a direct taskstats query.
>
>Associate each listener with taskstats family-private storage for the
>exact
>Generic Netlink socket. Record that socket's network namespace and port ID
>and use both for unicast. On socket release, the family-private destructor
>removes every listener owned by that socket. The socket pins its namespace
>until the destructor returns, so no additional net reference is needed.
>
>The per-CPU rwsem protects the listener-to-owner pointer from registration
>through unicast and removal. It also makes explicit deregistration,
>failed-send cleanup, and socket destruction mutually safe. Allocate a
>complete multi-CPU registration batch before publishing it so an
>allocation
>failure neither leaves a partial registration nor removes an older one.
>
>An in-tree regression test creates the cross-network-namespace port-ID
>collision. In a disposable QEMU guest with the unmodified kernel, the test
>fails because the child-netns listener misses the victim's exit record and
>the colliding unprivileged init_net socket receives it. The same test
>passes
>in three independent boots with this fix: the child-netns listener
>receives
>the record while the colliding socket does not. It also verifies the
>victim
>identity, EPERM for the unprivileged socket's direct query and
>registration,
>normal init_net delivery, explicit deregistration, and an unrelated port
>ID.
>
>Fixes: edc73c7261ca ("kernel: make taskstats available from all net namespaces")
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/all/20110630120831.GB7707@albatros/
>Link: https://lore.kernel.org/all/87v8x678ph.fsf@email.froward.int.ebiederm.org/
>Assisted-by: OpenAI Codex
>Signed-off-by: 성병찬 <tjdqudcks0424@naver.com>
>---
> kernel/taskstats.c | 135 ++++++++++++++++++++++++++++++---------------
> 1 file changed, 91 insertions(+), 44 deletions(-)
>
>diff --git a/kernel/taskstats.c b/kernel/taskstats.c
>index f31df72f0e9df..fb8cbbdd1c345 100644
>--- a/kernel/taskstats.c
>+++ b/kernel/taskstats.c
>@@ -45,9 +45,15 @@ static const struct nla_policy cgroupstats_cmd_get_policy[] = {
> 	[CGROUPSTATS_CMD_ATTR_FD] = { .type = NLA_U32 },
> };
> 
>+struct taskstats_sock_priv {
>+	struct net *net;
>+	u32 portid;
>+};
>+

Comment? ^


> struct listener {
> 	struct list_head list;
>-	pid_t pid;
>+	struct taskstats_sock_priv *owner;
>+	unsigned int cpu;
> 	char valid;
> };
> 
>@@ -128,9 +134,10 @@ static void send_cpu_listeners(struct sk_buff *skb,
> 			if (!skb_next)
> 				break;
> 		}
>-		rc = genlmsg_unicast(&init_net, skb_cur, s->pid);
>+		rc = genlmsg_unicast(s->owner->net, skb_cur,
>+				     s->owner->portid);
> 		if (rc == -ECONNREFUSED) {
>-			s->valid = 0;
>+			WRITE_ONCE(s->valid, 0);
> 			delcount++;
> 		}
> 		skb_cur = skb_next;
>@@ -146,7 +153,7 @@ static void send_cpu_listeners(struct sk_buff *skb,
> 	/* Delete invalidated entries */
> 	down_write(&listeners->sem);
> 	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
>-		if (!s->valid) {
>+		if (!READ_ONCE(s->valid)) {
> 			list_del(&s->list);
> 			kfree(s);
> 		}
>@@ -296,63 +303,77 @@ static void fill_tgid_exit(struct task_struct *tsk)
> 	return;
> }
> 
>-static int add_del_listener(pid_t pid, const struct cpumask *mask, int isadd)
>+static int add_listener(struct taskstats_sock_priv *owner,
>+			const struct cpumask *mask)
> {
>+	LIST_HEAD(new_listeners);
> 	struct listener_list *listeners;
> 	struct listener *s, *tmp, *s2;
> 	unsigned int cpu;
>-	int ret = 0;
>-
>-	if (!cpumask_subset(mask, cpu_possible_mask))
>-		return -EINVAL;
> 
>-	if (current_user_ns() != &init_user_ns)
>-		return -EINVAL;
>+	for_each_cpu(cpu, mask) {
>+		s = kmalloc_node(sizeof(*s), GFP_KERNEL, cpu_to_node(cpu));
>+		if (!s)
>+			goto free_new;
>+		s->owner = owner;
>+		s->cpu = cpu;
>+		s->valid = 1;
>+		list_add_tail(&s->list, &new_listeners);
>+	}
> 
>-	if (task_active_pid_ns(current) != &init_pid_ns)
>-		return -EINVAL;
>+	list_for_each_entry_safe(s, tmp, &new_listeners, list) {
>+		bool exists = false;
> 
>-	if (isadd == REGISTER) {
>-		for_each_cpu(cpu, mask) {
>-			s = kmalloc_node(sizeof(struct listener),
>-					GFP_KERNEL, cpu_to_node(cpu));
>-			if (!s) {
>-				ret = -ENOMEM;
>-				goto cleanup;
>-			}
>-			s->pid = pid;
>-			s->valid = 1;
>-
>-			listeners = &per_cpu(listener_array, cpu);
>-			down_write(&listeners->sem);
>-			list_for_each_entry(s2, &listeners->list, list) {
>-				if (s2->pid == pid && s2->valid)
>-					goto exists;
>+		list_del(&s->list);
>+		listeners = &per_cpu(listener_array, s->cpu);
>+		down_write(&listeners->sem);
>+		list_for_each_entry(s2, &listeners->list, list) {
>+			if (s2->owner == owner && READ_ONCE(s2->valid)) {
>+				exists = true;
>+				break;
> 			}
>-			list_add(&s->list, &listeners->list);
>-			s = NULL;
>-exists:
>-			up_write(&listeners->sem);
>-			kfree(s); /* nop if NULL */
> 		}
>-		return 0;
>+		if (!exists)
>+			list_add(&s->list, &listeners->list);
>+		up_write(&listeners->sem);
>+		if (exists)
>+			kfree(s);
> 	}
>+	return 0;
>+
>+free_new:
>+	list_for_each_entry_safe(s, tmp, &new_listeners, list) {
>+		list_del(&s->list);
>+		kfree(s);
>+	}
>+	return -ENOMEM;
>+}
>+
>+static void remove_listener(struct taskstats_sock_priv *owner,
>+			    const struct cpumask *mask)
>+{
>+	struct listener_list *listeners;
>+	struct listener *s, *tmp;
>+	unsigned int cpu;
> 
>-	/* Deregister or cleanup */
>-cleanup:
> 	for_each_cpu(cpu, mask) {
> 		listeners = &per_cpu(listener_array, cpu);
> 		down_write(&listeners->sem);
> 		list_for_each_entry_safe(s, tmp, &listeners->list, list) {
>-			if (s->pid == pid) {
>+			if (s->owner == owner) {
> 				list_del(&s->list);
> 				kfree(s);
>-				break;
> 			}
> 		}
> 		up_write(&listeners->sem);
> 	}
>-	return ret;
>+}
>+

Nit: this is an O(nr_cpu_ids) write lock sweep
per socket close. Fine for taskstats, listeners are rare, but maybe
worth a comment saying you know?????? ↓

>+static void taskstats_sock_priv_destroy(void *data)
>+{
>+	struct taskstats_sock_priv *owner = data;
>+
>+	remove_listener(owner, cpu_possible_mask);
> }
> 
> static int parse(struct nlattr *na, struct cpumask *mask)
>@@ -448,10 +469,12 @@ static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
> 	return send_reply(rep_skb, info);
> }
> 
>-static int cmd_attr_cpumask(struct genl_info *info, int attr,
>+static int cmd_attr_cpumask(struct sk_buff *skb, struct genl_info *info,
>+			    int attr,
> 			    enum actions action)
> {
> 	cpumask_var_t mask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
>+	struct taskstats_sock_priv *owner;
> 	int rc;
> 
> 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>@@ -459,7 +482,29 @@ static int cmd_attr_cpumask(struct genl_info *info, int attr,
> 	rc = parse(info->attrs[attr], mask);
> 	if (rc < 0)
> 		return rc;
>-	return add_del_listener(info->snd_portid, mask, action);
>+	if (!cpumask_subset(mask, cpu_possible_mask))
>+		return -EINVAL;
>+	if (current_user_ns() != &init_user_ns)
>+		return -EINVAL;
>+	if (task_active_pid_ns(current) != &init_pid_ns)
>+		return -EINVAL;
>+
>+	owner = genl_sk_priv_get(&family, NETLINK_CB(skb).sk);
>+	if (IS_ERR(owner))
>+		return PTR_ERR(owner);
>+	if (!owner->net) {
>+		owner->net = genl_info_net(info);
>+		owner->portid = info->snd_portid;
>+	} else if (WARN_ON_ONCE(!net_eq(owner->net, genl_info_net(info)) ||
>+				owner->portid != info->snd_portid)) {
>+		return -EINVAL;
>+	}
>+
>+	if (action == REGISTER)
>+		return add_listener(owner, mask);
>+
>+	remove_listener(owner, mask);
>+	return 0;
> }
> 
> static size_t taskstats_packet_size(void)
>@@ -534,11 +579,11 @@ static int cmd_attr_tgid(struct genl_info *info)
> static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info
> *info)
> {
> 	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK])
>-		return cmd_attr_cpumask(info,
>+		return cmd_attr_cpumask(skb, info,
> 					TASKSTATS_CMD_ATTR_REGISTER_CPUMASK,
> 					REGISTER);
> 	else if (info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK])
>-		return cmd_attr_cpumask(info,
>+		return cmd_attr_cpumask(skb, info,
> 					TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK,
> 					DEREGISTER);
> 	else if (info->attrs[TASKSTATS_CMD_ATTR_PID])
>@@ -671,6 +716,8 @@ static struct genl_family family __ro_after_init = {
> 	.n_ops		= ARRAY_SIZE(taskstats_ops),
> 	.resv_start_op	= CGROUPSTATS_CMD_GET + 1,
> 	.netnsok	= true,
>+	.sock_priv_size	= sizeof(struct taskstats_sock_priv),
>+	.sock_priv_destroy = taskstats_sock_priv_destroy,

Fine.

> };
> 
> /* Needed early in initialization */
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
