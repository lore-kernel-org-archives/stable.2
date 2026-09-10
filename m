Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172603D9549;
	Thu, 10 Sep 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032831; cv=none; b=rWefb2oTXuKRRZVA87fTcomzW7oJ4ubWkpZCDo9r28o5fs6Ythhd7WtNAGsrUey+EE+o6Q4sGa18naOA09GEy/vEhQmeZ5HQ83dDMQbFaD8Oz4l0EXSpeBj6gLMxy/WKqk2twbBmPZHohQa35cgOmv54kPu+FuDMYKhpRmhjt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032831; c=relaxed/simple;
	bh=Jwh4+7LHpGg9xSW1Coyg9Vi5EOs5vAMxDStHli6bcv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nq0NkqSwC6NjRrMvGZJSO2KgdxAgkGf2odEzW76KO1kSoX6izw08et9JWRvfM8LCaw1BbgiSe/vsTe7fHdQNx+ZaYFtaCbKrrYvLwdVf453bJW0GK3TphbYcbF7ajj4Ako69+8PA0rpaBb4c0HZHHg/n7YVyjIJkaOGxWl2yDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cK1G+v5Q; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cK1G+v5Q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A252B1A1A91;
	Thu, 10 Sep 2026 09:33:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71250602B8;
	Thu, 10 Sep 2026 09:33:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42CFA11C78279;
	Thu, 10 Sep 2026 11:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789032821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QI+N1LsIeIqVwD7/ezD2/TXfd1mqYGhxBGBovU1NpOA=;
	b=cK1G+v5QgGp34yXNKlX9AhxKkwk6j0YWxsa2VseD+qFlM+pqAFDZoqMhfOOqtjAFYVIS44
	McaJmzevk4mAkagNS0sGqLIR9WcLj93hSJyqiha7mvtUY0LWSqNt6WchM/Mt55w3EqXKLr
	tr2dgz2paFGE1cqsjjgY5KMcORCX0rMJOdwJeK5KOFq3lzEBpCloyNYCFybdxxlGw+Vy4/
	lxQ2OLbeKyVg+L4SGVXCWix75x0yutnXECuIYm5MiJfw7b4N9m3GEnkXqRzam96HZCxyDm
	w8/TR01zdzyCKO7xyHxaMd+cSkBzGt74Oj+KxIcopKOt1yi8EgNAHlCK3ax/pQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Thu, 10 Sep 2026 11:33:28 +0200
Subject: [PATCH 5.15.y] bpf: Enforce expected_attach_type for tailcall
 compatibility
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-cve-2025-40123-5-15-v1-1-547774d4a00b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CQAyE4Vchc7ZkWyiKr2I8yFq1HtDsKtEQ3
 t1Vj98k88/IltwyttWMZJNnv40FvKoQL4fxbOTHYkiQLvQcKE5GBUptYGlIiZWkF9s060G72KI
 878lO/vpVd9CatX5j/9/zc7hafHyTWJYPDLz4i38AAAA=
X-Change-ID: 20260910-cve-2025-40123-5-15-292e837b56c4
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Andrey Ignatov <rdna@fb.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Dongliang Mu <dzm91@hust.edu.cn>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789032812; l=4232;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=gUafZzjf5WznKHgn5eGzWtYE9PDR/yy9rByv/cE7nj0=;
 b=rdJ8ORMUYXYJCLg3EYIF+yQSpZpNS/4UOHMkmHhO26KsbwXacq43+wV6Q86ZRO07SKity1EKS
 MfbZQqiYikRDmW1bFd0LJJWB9B+g+KRfSkFA5csyDOH3E989NKvuWq6
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 4540aed51b12bc13364149bf95f6ecef013197c0 ]

Yinhao et al. recently reported:

  Our fuzzer tool discovered an uninitialized pointer issue in the
  bpf_prog_test_run_xdp() function within the Linux kernel's BPF subsystem.
  This leads to a NULL pointer dereference when a BPF program attempts to
  deference the txq member of struct xdp_buff object.

The test initializes two programs of BPF_PROG_TYPE_XDP: progA acts as the
entry point for bpf_prog_test_run_xdp() and its expected_attach_type can
neither be of be BPF_XDP_DEVMAP nor BPF_XDP_CPUMAP. progA calls into a slot
of a tailcall map it owns. progB's expected_attach_type must be BPF_XDP_DEVMAP
to pass xdp_is_valid_access() validation. The program returns struct xdp_md's
egress_ifindex, and the latter is only allowed to be accessed under mentioned
expected_attach_type. progB is then inserted into the tailcall which progA
calls.

The underlying issue goes beyond XDP though. Another example are programs
of type BPF_PROG_TYPE_CGROUP_SOCK_ADDR. sock_addr_is_valid_access() as well
as sock_addr_func_proto() have different logic depending on the programs'
expected_attach_type. Similarly, a program attached to BPF_CGROUP_INET4_GETPEERNAME
should not be allowed doing a tailcall into a program which calls bpf_bind()
out of BPF which is only enabled for BPF_CGROUP_INET4_CONNECT.

In short, specifying expected_attach_type allows to open up additional
functionality or restrictions beyond what the basic bpf_prog_type enables.
The use of tailcalls must not violate these constraints. Fix it by enforcing
expected_attach_type in __bpf_prog_map_compatible().

Note that we only enforce this for tailcall maps, but not for BPF devmaps or
cpumaps: There, the programs are invoked through dev_map_bpf_prog_run*() and
cpu_map_bpf_prog_run*() which set up a new environment / context and therefore
these situations are not prone to this issue.

Fixes: 5e43f899b03a ("bpf: Check attach type at prog load time")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20250926171201.188490-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ed42bac04a79..e9081b1ec436 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -259,6 +259,7 @@ struct bpf_map_owner {
 	bool xdp_has_frags;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
+	enum bpf_attach_type expected_attach_type;
 };
 
 struct bpf_map {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ac921214059f..bbf95bc2d408 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1854,6 +1854,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->jited = fp->jited;
 		/* Note: xdp_has_frags doesn't exist in aux yet in our branch */
 		/* map->owner->xdp_has_frags = aux->xdp_has_frags; */
+		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
 			map->owner->storage_cookie[i] =
@@ -1866,6 +1867,10 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		      map->owner->jited == fp->jited;
 		/* Note: xdp_has_frags check would go here when available */
 		/* && map->owner->xdp_has_frags == aux->xdp_has_frags; */
+		if (ret &&
+		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
+		    map->owner->expected_attach_type != fp->expected_attach_type)
+			ret = false;
 		for_each_cgroup_storage_type(i) {
 			if (!ret)
 				break;

---
base-commit: 0996e0926f6b4d6123e1b94407d726bc9810248e
change-id: 20260910-cve-2025-40123-5-15-292e837b56c4

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

