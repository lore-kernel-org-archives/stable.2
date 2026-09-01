Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095B39EF12
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270496; cv=none; b=e6ZsTjJsGU7xcfu0NDGAnW1JokpeO2zu75cr7Avcvuc/+/TSMT85itVlJLTRxajf5Uh1m6LfJ6w/4BjnmTHzal6iodV03UvMix0+nwrGTq4WdaL2ycpWxvGgnRT9WSmEFdIiXCalswt5HrXty6cwOhdr8Sxp3FsSm+4aXoBaVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270496; c=relaxed/simple;
	bh=zQ0+33HsIVp7SkKZyP8rBcC4/rxvlphvwq/cIYRfwts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpHVaa3mNL7htJBsMBC+Fr+MJ48m12fC1EWYHFgsETMOKsGhGcKZqlF2tOH2YFvjXMBmfcQR2efjNERE6DcVQZA186cZcBXeL+jNK+Kh+d9Fmx8c+fmNXFZp0PQDwjvMfo6M+vl/gzYrSqFse1ZcUkopxvsg/X8cjljZf5D+Ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=aX4m7rPw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="aX4m7rPw"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1116883b3a.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788270492; x=1788875292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGh/luDrC60UBrLdQENH1WKnA2lc40qpD3rWmmT6jZw=;
        b=aX4m7rPwHeens+/pweaexAMlLLllzqL9eIJEjzDx1w5J/n6oYMuRcxdGo9uKXQ8lWx
         D5ZKwBVSHuV2xtnx4PqMzDNfZWrq9jZYHx5JddYPYGMlWNfECnR/eAV7DilQ66/AHK5S
         g5OUX8X7Q1ZAD8emmKDrn0Nvc6NYHcSLDfi4jX8ToVw29btQMgqb3PBbzx0zEPxwqX8y
         vjD7oYsrYR9ttWV8Ml1n6oyLFNVtHo84KEjwhKRtceHDUjzU2MivaEJ/RlrhIDU5hQ9k
         WSjRt/SfITj9CbVXJPLyxSt+rlJ9msdDTgJziR6ig2MrjchRITc1hpqi1e5qzTRPgyxY
         XdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270492; x=1788875292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGh/luDrC60UBrLdQENH1WKnA2lc40qpD3rWmmT6jZw=;
        b=sVllbVufKORewQ8G+NXweNpKm9D0pW8iJsJ62qxYog+uIjGjOfR+MipxjlruiFW4bw
         Pcqz07pGD5xgkdI5omzoqsCFe8DuTcJn1c3UAIXsap36ZVGpKhK3TU0tFER2blhrqFCa
         4QdI7GXPbJlQFYIftRyMkJCDqqPVTzexKqFn1noGPX6oS0y2AEXk7DZ1/BGom8gNXA8a
         5Q4ZM0edZ1JG8/Mn3YgxDERjpkL12prkfwuzbNioKRADbwBVrwJOuuspln/Pf6JJeO5e
         L3wL8VIBa8uwTPpbNaenyRUVm7cHvT+bD1eeCPmhSJa4Z872O5W6rKMzHzkKWegXePUs
         sNIw==
X-Forwarded-Encrypted: i=1; AHgh+Rpa0/55/9wxQBE+OxDH6SRCpn9yX1SZQLfX9G7FsUzP3QuvC9GpkqvhMgQ3jtDLO3U8LJEXeLU=@vger.kernel.org
X-Gm-Message-State: AFuF++nzcFZZ1wuebl3pHzaBBi8wXyXfH0opu7eE4w4lU/InSpqv/c7e
	tZADhK9GTo1THnmgTeP16IRiQxNq8l8r+tOAraeYiU8aGMnhLNNdA31Zw82p0byPANApjmqguyZ
	N4OsJgcNcxck=
X-Gm-Gg: AR+sD12Y2SL8EGbgwfQ3CITD9MOdqa3FHWSj4dCaPlcpveoZjo5ISL3ccbz8KTnpAEX
	VsfiOnaJWP4FObGdvcTpLtdNf0QeT9acb6DCTHBv/igexeNwTO+Y3qlG4sxfWULsonU+s3TEeMu
	f7CAX58CgVxO1vTYfm8MexZm5resUQ3YsCgF41pQC95wNi+lQ4n/nXH66pnMtt6JmmnsBi8n+3y
	uk06mebxPrqzuAdbWDpPLKAbinD1ggp/1XQ8t3mPUKLYlQvkp/3UCKhj1U/KGiZHdeAxgoytc6P
	XM4xHLwYAMfpx+Q1pIJWt4IwI8eMAZZj49ozS2U29zNU8BOj9gUc7xEzFFdJnizECEatMDxtuqf
	/1yt8XKEnK+ZoYPXQLrh2tmHgHtNRaVSpM2W7amVOwSCzjSpEsl3fJAvwb1ZyQrq660kUtZbmeW
	M0CaeeIvwkJxwyJ0dcqKDuhhTsld2J5mvhyJPuDGnHixE9iAvA6pT7lN1hke372u7ppaGGDjRfF
	+IHivg+Kj2NNFyTpiw=
X-Received: by 2002:a05:6a00:188e:b0:84e:c851:a058 with SMTP id d2e1a72fcca58-85bca701c7emr3830291b3a.10.1788270492052;
        Tue, 01 Sep 2026 06:48:12 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be5d9bcd7sm1166303b3a.11.2026.09.01.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:48:10 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH nf 1/1] netfilter: x_tables: avoid holding mutex over faultable user copies
Date: Tue,  1 Sep 2026 13:47:54 +0000
Message-ID: <ced14892f76660c0be9ea6136872ba3d56a07238.1788244146.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788244146.git.zihanx@nebusec.ai>
References: <cover.1788244146.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy IPv4, IPv6 and ARP table GET_INFO and GET_ENTRIES paths hold
the per-family xtables mutexes while copying table data to userspace. A
faultable destination can therefore sleep indefinitely with the mutex held,
blocking unrelated table and registry operations.

Disable page faults during the locked copy, release the lock, fault in the
output range, and retry once. Move GET_INFO's fixed-size copy outside the
table locks and apply the same retry handling to compat GET_ENTRIES paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/netfilter/arp_tables.c | 33 ++++++++++++++++++++++++++++-----
 net/ipv4/netfilter/ip_tables.c  | 33 ++++++++++++++++++++++++++++-----
 net/ipv6/netfilter/ip6_tables.c | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index a87e07e80..d36e6770b 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
+#include <linux/pagemap.h>
 #include <net/compat.h>
 #include <net/sock.h>
 #include <linux/uaccess.h>
@@ -696,6 +697,7 @@ static int copy_entries_to_user(unsigned int total_size,
 
 	loc_cpu_entry = private->entries;
 
+	pagefault_disable();
 	/* FIXME: use iterator macros --RR */
 	/* ... then go back and fix counters and names */
 	for (off = 0, num = 0; off < total_size; off += e->next_offset, num++){
@@ -720,6 +722,7 @@ static int copy_entries_to_user(unsigned int total_size,
 	}
 
  free_counters:
+	pagefault_enable();
 	vfree(counters);
 	return ret;
 }
@@ -800,6 +803,7 @@ static int compat_table_info(const struct xt_table_info *info,
 
 static int get_info(struct net *net, void __user *user, const int *len)
 {
+	struct arpt_getinfo info;
 	char name[XT_TABLE_MAXNAMELEN];
 	struct xt_table *t;
 	int ret;
@@ -817,7 +821,6 @@ static int get_info(struct net *net, void __user *user, const int *len)
 #endif
 	t = xt_request_find_table_lock(net, NFPROTO_ARP, name);
 	if (!IS_ERR(t)) {
-		struct arpt_getinfo info;
 		const struct xt_table_info *private = t->private;
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 		struct xt_table_info tmp;
@@ -838,10 +841,7 @@ static int get_info(struct net *net, void __user *user, const int *len)
 		info.size = private->size;
 		strscpy(info.name, name);
 
-		if (copy_to_user(user, &info, *len) != 0)
-			ret = -EFAULT;
-		else
-			ret = 0;
+		ret = 0;
 		xt_table_unlock(t);
 		module_put(t->me);
 	} else
@@ -850,6 +850,8 @@ static int get_info(struct net *net, void __user *user, const int *len)
 	if (in_compat_syscall())
 		xt_compat_unlock(NFPROTO_ARP);
 #endif
+	if (!ret && copy_to_user(user, &info, *len) != 0)
+		ret = -EFAULT;
 	return ret;
 }
 
@@ -859,6 +861,7 @@ static int get_entries(struct net *net, struct arpt_get_entries __user *uptr,
 	int ret;
 	struct arpt_get_entries get;
 	struct xt_table *t;
+	bool faulted = false;
 
 	if (*len < sizeof(get))
 		return -EINVAL;
@@ -869,6 +872,7 @@ static int get_entries(struct net *net, struct arpt_get_entries __user *uptr,
 
 	get.name[sizeof(get.name) - 1] = '\0';
 
+ retry:
 	t = xt_find_table_lock(net, NFPROTO_ARP, get.name);
 	if (!IS_ERR(t)) {
 		const struct xt_table_info *private = t->private;
@@ -884,6 +888,14 @@ static int get_entries(struct net *net, struct arpt_get_entries __user *uptr,
 	} else
 		ret = PTR_ERR(t);
 
+	if (ret == -EFAULT && !faulted) {
+		faulted = true;
+		if (fault_in_writeable((char __user *)uptr->entrytable,
+				       get.size))
+			return -EFAULT;
+		goto retry;
+	}
+
 	return ret;
 }
 
@@ -1363,12 +1375,14 @@ static int compat_copy_entries_to_user(unsigned int total_size,
 
 	pos = userptr;
 	size = total_size;
+	pagefault_disable();
 	xt_entry_foreach(iter, private->entries, total_size) {
 		ret = compat_copy_entry_to_user(iter, &pos,
 						&size, counters, i++);
 		if (ret != 0)
 			break;
 	}
+	pagefault_enable();
 	vfree(counters);
 	return ret;
 }
@@ -1386,6 +1400,7 @@ static int compat_get_entries(struct net *net,
 	int ret;
 	struct compat_arpt_get_entries get;
 	struct xt_table *t;
+	bool faulted = false;
 
 	if (*len < sizeof(get))
 		return -EINVAL;
@@ -1396,6 +1411,7 @@ static int compat_get_entries(struct net *net,
 
 	get.name[sizeof(get.name) - 1] = '\0';
 
+ retry:
 	xt_compat_lock(NFPROTO_ARP);
 	t = xt_find_table_lock(net, NFPROTO_ARP, get.name);
 	if (!IS_ERR(t)) {
@@ -1416,6 +1432,13 @@ static int compat_get_entries(struct net *net,
 		ret = PTR_ERR(t);
 
 	xt_compat_unlock(NFPROTO_ARP);
+	if (ret == -EFAULT && !faulted) {
+		faulted = true;
+		if (fault_in_writeable((char __user *)uptr->entrytable,
+				       get.size))
+			return -EFAULT;
+		goto retry;
+	}
 	return ret;
 }
 #endif
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 809441ced..e029072b0 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -21,6 +21,7 @@
 #include <linux/proc_fs.h>
 #include <linux/err.h>
 #include <linux/cpumask.h>
+#include <linux/pagemap.h>
 
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
@@ -824,6 +825,7 @@ copy_entries_to_user(unsigned int total_size,
 
 	loc_cpu_entry = private->entries;
 
+	pagefault_disable();
 	/* FIXME: use iterator macros --RR */
 	/* ... then go back and fix counters and names */
 	for (off = 0, num = 0; off < total_size; off += e->next_offset, num++){
@@ -861,6 +863,7 @@ copy_entries_to_user(unsigned int total_size,
 	}
 
  free_counters:
+	pagefault_enable();
 	vfree(counters);
 	return ret;
 }
@@ -943,6 +946,7 @@ static int compat_table_info(const struct xt_table_info *info,
 
 static int get_info(struct net *net, void __user *user, const int *len)
 {
+	struct ipt_getinfo info;
 	char name[XT_TABLE_MAXNAMELEN];
 	struct xt_table *t;
 	int ret;
@@ -960,7 +964,6 @@ static int get_info(struct net *net, void __user *user, const int *len)
 #endif
 	t = xt_request_find_table_lock(net, AF_INET, name);
 	if (!IS_ERR(t)) {
-		struct ipt_getinfo info;
 		const struct xt_table_info *private = t->private;
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 		struct xt_table_info tmp;
@@ -981,10 +984,7 @@ static int get_info(struct net *net, void __user *user, const int *len)
 		info.size = private->size;
 		strscpy(info.name, name);
 
-		if (copy_to_user(user, &info, *len) != 0)
-			ret = -EFAULT;
-		else
-			ret = 0;
+		ret = 0;
 
 		xt_table_unlock(t);
 		module_put(t->me);
@@ -994,6 +994,8 @@ static int get_info(struct net *net, void __user *user, const int *len)
 	if (in_compat_syscall())
 		xt_compat_unlock(AF_INET);
 #endif
+	if (!ret && copy_to_user(user, &info, *len) != 0)
+		ret = -EFAULT;
 	return ret;
 }
 
@@ -1004,6 +1006,7 @@ get_entries(struct net *net, struct ipt_get_entries __user *uptr,
 	int ret;
 	struct ipt_get_entries get;
 	struct xt_table *t;
+	bool faulted = false;
 
 	if (*len < sizeof(get))
 		return -EINVAL;
@@ -1013,6 +1016,7 @@ get_entries(struct net *net, struct ipt_get_entries __user *uptr,
 		return -EINVAL;
 	get.name[sizeof(get.name) - 1] = '\0';
 
+ retry:
 	t = xt_find_table_lock(net, AF_INET, get.name);
 	if (!IS_ERR(t)) {
 		const struct xt_table_info *private = t->private;
@@ -1027,6 +1031,14 @@ get_entries(struct net *net, struct ipt_get_entries __user *uptr,
 	} else
 		ret = PTR_ERR(t);
 
+	if (ret == -EFAULT && !faulted) {
+		faulted = true;
+		if (fault_in_writeable((char __user *)uptr->entrytable,
+				       get.size))
+			return -EFAULT;
+		goto retry;
+	}
+
 	return ret;
 }
 
@@ -1561,12 +1573,14 @@ compat_copy_entries_to_user(unsigned int total_size, struct xt_table *table,
 
 	pos = userptr;
 	size = total_size;
+	pagefault_disable();
 	xt_entry_foreach(iter, private->entries, total_size) {
 		ret = compat_copy_entry_to_user(iter, &pos,
 						&size, counters, i++);
 		if (ret != 0)
 			break;
 	}
+	pagefault_enable();
 
 	vfree(counters);
 	return ret;
@@ -1579,6 +1593,7 @@ compat_get_entries(struct net *net, struct compat_ipt_get_entries __user *uptr,
 	int ret;
 	struct compat_ipt_get_entries get;
 	struct xt_table *t;
+	bool faulted = false;
 
 	if (*len < sizeof(get))
 		return -EINVAL;
@@ -1591,6 +1606,7 @@ compat_get_entries(struct net *net, struct compat_ipt_get_entries __user *uptr,
 
 	get.name[sizeof(get.name) - 1] = '\0';
 
+ retry:
 	xt_compat_lock(AF_INET);
 	t = xt_find_table_lock(net, AF_INET, get.name);
 	if (!IS_ERR(t)) {
@@ -1610,6 +1626,13 @@ compat_get_entries(struct net *net, struct compat_ipt_get_entries __user *uptr,
 		ret = PTR_ERR(t);
 
 	xt_compat_unlock(AF_INET);
+	if (ret == -EFAULT && !faulted) {
+		faulted = true;
+		if (fault_in_writeable((char __user *)uptr->entrytable,
+				       get.size))
+			return -EFAULT;
+		goto retry;
+	}
 	return ret;
 }
 #endif
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index f42fb96ef..493e6fbc6 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -25,6 +25,7 @@
 #include <linux/proc_fs.h>
 #include <linux/err.h>
 #include <linux/cpumask.h>
+#include <linux/pagemap.h>
 
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter/x_tables.h>
@@ -840,6 +841,7 @@ copy_entries_to_user(unsigned int total_size,
 
 	loc_cpu_entry = private->entries;
 
+	pagefault_disable();
 	/* FIXME: use iterator macros --RR */
 	/* ... then go back and fix counters and names */
 	for (off = 0, num = 0; off < total_size; off += e->next_offset, num++){
@@ -877,6 +879,7 @@ copy_entries_to_user(unsigned int total_size,
 	}
 
  free_counters:
+	pagefault_enable();
 	vfree(counters);
 	return ret;
 }
@@ -959,6 +962,7 @@ static int compat_table_info(const struct xt_table_info *info,
 
 static int get_info(struct net *net, void __user *user, const int *len)
 {
+	struct ip6t_getinfo info;
 	char name[XT_TABLE_MAXNAMELEN];
 	struct xt_table *t;
 	int ret;
@@ -976,7 +980,6 @@ static int get_info(struct net *net, void __user *user, const int *len)
 #endif
 	t = xt_request_find_table_lock(net, AF_INET6, name);
 	if (!IS_ERR(t)) {
-		struct ip6t_getinfo info;
 		const struct xt_table_info *private = t->private;
 #ifdef CONFIG_NETFILTER_XTABLES_COMPAT
 		struct xt_table_info tmp;
@@ -997,10 +1000,7 @@ static int get_info(struct net *net, void __user *user, const int *len)
 		info.size = private->size;
 		strcpy(info.name, name);
 
-		if (copy_to_user(user, &info, *len) != 0)
-			ret = -EFAULT;
-		else
-			ret = 0;
+		ret = 0;
 
 		xt_table_unlock(t);
 		module_put(t->me);
@@ -1010,6 +1010,8 @@ static int get_info(struct net *net, void __user *user, const int *len)
 	if (in_compat_syscall())
 		xt_compat_unlock(AF_INET6);
 #endif
+	if (!ret && copy_to_user(user, &info, *len) != 0)
+		ret = -EFAULT;
 	return ret;
 }
 
@@ -1020,6 +1022,7 @@ get_entries(struct net *net, struct ip6t_get_entries __user *uptr,
 	int ret;
 	struct ip6t_get_entries get;
 	struct xt_table *t;
+	bool faulted = false;
 
 	if (*len < sizeof(get))
 		return -EINVAL;
@@ -1030,6 +1033,7 @@ get_entries(struct net *net, struct ip6t_get_entries __user *uptr,
 
 	get.name[sizeof(get.name) - 1] = '\0';
 
+ retry:
 	t = xt_find_table_lock(net, AF_INET6, get.name);
 	if (!IS_ERR(t)) {
 		struct xt_table_info *private = t->private;
@@ -1044,6 +1048,14 @@ get_entries(struct net *net, struct ip6t_get_entries __user *uptr,
 	} else
 		ret = PTR_ERR(t);
 
+	if (ret == -EFAULT && !faulted) {
+		faulted = true;
+		if (fault_in_writeable((char __user *)uptr->entrytable,
+				       get.size))
+			return -EFAULT;
+		goto retry;
+	}
+
 	return ret;
 }
 
@@ -1570,12 +1582,14 @@ compat_copy_entries_to_user(unsigned int total_size, struct xt_table *table,
 
 	pos = userptr;
 	size = total_size;
+	pagefault_disable();
 	xt_entry_foreach(iter, private->entries, total_size) {
 		ret = compat_copy_entry_to_user(iter, &pos,
 						&size, counters, i++);
 		if (ret != 0)
 			break;
 	}
+	pagefault_enable();
 
 	vfree(counters);
 	return ret;
@@ -1588,6 +1602,7 @@ compat_get_entries(struct net *net, struct compat_ip6t_get_entries __user *uptr,
 	int ret;
 	struct compat_ip6t_get_entries get;
 	struct xt_table *t;
+	bool faulted = false;
 
 	if (*len < sizeof(get))
 		return -EINVAL;
@@ -1600,6 +1615,7 @@ compat_get_entries(struct net *net, struct compat_ip6t_get_entries __user *uptr,
 
 	get.name[sizeof(get.name) - 1] = '\0';
 
+ retry:
 	xt_compat_lock(AF_INET6);
 	t = xt_find_table_lock(net, AF_INET6, get.name);
 	if (!IS_ERR(t)) {
@@ -1619,6 +1635,13 @@ compat_get_entries(struct net *net, struct compat_ip6t_get_entries __user *uptr,
 		ret = PTR_ERR(t);
 
 	xt_compat_unlock(AF_INET6);
+	if (ret == -EFAULT && !faulted) {
+		faulted = true;
+		if (fault_in_writeable((char __user *)uptr->entrytable,
+				       get.size))
+			return -EFAULT;
+		goto retry;
+	}
 	return ret;
 }
 #endif
-- 
2.43.0

