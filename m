Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484440;
	b=HmKxT1IpsZi0vx/0PsVxJok5mhU9gybyQFdREdOoXBQf3KMHj+2fj8yEVDjyIJSiGf2g
	 7OD5DRAxtTxtVxDfL2/3I4QNboSwoIxFqcTJ8+TFEB09Og0bTotu80yX8GymbVaXAPKK0
	 k1Viwn33nt4APScZHE5gwlwxoSNivlH+TrJAh96Vj3bgiitQfdTxoMeM1lonRfcgvSkyb
	 A3L4/ij6J5K3KvR9+D/gwODHz05cavT0NHE6iN7pgFQxw/soFX9hnp0V/OS3dnq8svSLe
	 dCXjb4MEDafuO0Eh6l6sHI/N+cde1ix3EpsM9dONtsUzyTccxE1LxOANvBRi+4REQ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484440;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=gw+BWflLHCBFzthayOlMnIYIaUbwH5DQLgkmA/dcpOs=;
	b=WrFAhUhb9P0j7FmqYRaEVjmzIH6AfLhLFZ+wZtUIiUgSD90PukEfiQt/Csxh2rrXQnSk
	 aQkVUiqcrlMpd06S+czV9CohzuUlkfuX8iDzqs/j7kHZQvc3oQAeJjGXPAaiA579FJ8ud
	 XkhzbE6T0L5WCdaOVaiX3stSYV4E2varwj8RZrVT8s4sGv0wRQa3dagngjfkdQI+tIM/u
	 T4JkPFZew48CGyghv3cZLCqUKOKk/159va3c+JwfH69WRky4tKDad1jW014MpS/qDydkZ
	 GRNdIg5DBojlLYTMMg9CZ/mb4u4Dk3JP3+z2oJmmQIxhwdub334SrWFi06hmnQUrRtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NfEBNQ5m;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B6606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC9B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NfEBNQ5m
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 60BAE4E4128D;
	Tue, 20 Oct 2026 08:20:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2DA6F60393;
	Tue, 20 Oct 2026 08:20:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B42E310328A45;
	Tue, 20 Oct 2026 10:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792484436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gw+BWflLHCBFzthayOlMnIYIaUbwH5DQLgkmA/dcpOs=;
	b=NfEBNQ5mC0HCPQtKBcLrsfthSb8lL7aGFVaTgD13bmoosGv5TbTxwC6V/GoFz6yR9d8el4
	hl7QsWswNAYjfbaZi0UtUs6Yi19n70Dz1Ituy2oVo19yCTeyCNgfgEBexYVW+vPvSOK2lH
	sgAvYrjhqzQ9h9XVcje/kD73OA+WPD9f0b4jIUOrDcdNlvS2PrugX24v8JhCLvzuS+2DWq
	a9aGZz9YaF1Zvc4DyUNNjJ3mjggjZSLYDfgf7eHzZPmXfmI6KPnpMASkAUEOZWfAzfJ0rt
	aGg8AbF/wURudfyOzWnWLexEM5zreKohyd7+tv+CGtui7NH4H4tpPQmLyHP7yQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 10:20:32 +0200
Subject: [PATCH 6.1.y] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
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
Message-Id: <20261020-cve-2024-38564-v1-1-0f8b454b9ef6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3YJi7SxvorxIHXQ9YCmRaIhv
 LtVj98k8y/ITMaMfbUgcbZs97FANxXi9TReKHYuRtu0XhsNEmdKQSfbnfOdREcfejeEoEQ5PRI
 He/2CB/ha6zeO/zk/+xvj9I1hXT8XpDJWeQAAAA==
X-Change-ID: 20261019-cve-2024-38564-c5e69b5f991e
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 syzbot+838346b979830606c854@syzkaller.appspotmail.com, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792484434; l=4125;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=o5dsTVSaRd1rOJQI39PbWpLWalk7hp2FVLk4sokhrlY=;
 b=SLTbjX+Ejl6ZOpgkcYGI2ccVHujki3C0glcTiby1V2cpxZngmCE6gIFQ8Gl+zDxU+zzjKIuC3
 eNDw98gtTf5A6UgjnwKPUKCFInZDUuVOm0h0Gvpwn6xifaTq6HuXiln
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 543576ec15b17c0c93301ac8297333c7b6e84ac7 ]

bpf_prog_attach uses attach_type_to_prog_type to enforce proper
attach type for BPF_PROG_TYPE_CGROUP_SKB. link_create uses
bpf_prog_get and relies on bpf_prog_attach_check_attach_type
to properly verify prog_type <> attach_type association.

Add missing attach_type enforcement for the link_create case.
Otherwise, it's currently possible to attach cgroup_skb prog
types to other cgroup hooks.

[Added ptype variable declaration at the top of the function
bpf_prog_attach_check_attach_type, and moved it under
attach_type_to_prog_type (similar to what is done in
3505cb9fa26cfec9512744466e754a8cbc2365b0 ("bpf: Add attach_type checks
under bpf_prog_attach_check_attach_type") ]

Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
Link: https://lore.kernel.org/bpf/0000000000004792a90615a1dde0@google.com/
Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240426231621.2716876-2-sdf@google.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 kernel/bpf/syscall.c | 62 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d630d1665c6b..6cbed5a3aaf4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3427,33 +3427,6 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	return fd;
 }
 
-static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
-					     enum bpf_attach_type attach_type)
-{
-	switch (prog->type) {
-	case BPF_PROG_TYPE_CGROUP_SOCK:
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-	case BPF_PROG_TYPE_SK_LOOKUP:
-		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
-	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
-			/* cg-skb progs can be loaded by unpriv user.
-			 * check permissions at attach time.
-			 */
-			return -EPERM;
-		return prog->enforce_expected_attach_type &&
-			prog->expected_attach_type != attach_type ?
-			-EINVAL : 0;
-	case BPF_PROG_TYPE_KPROBE:
-		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
-		    attach_type != BPF_TRACE_KPROBE_MULTI)
-			return -EINVAL;
-		return 0;
-	default:
-		return 0;
-	}
-}
 
 static enum bpf_prog_type
 attach_type_to_prog_type(enum bpf_attach_type attach_type)
@@ -3518,6 +3491,41 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	}
 }
 
+static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
+					     enum bpf_attach_type attach_type)
+{
+	enum bpf_prog_type ptype;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_SK_LOOKUP:
+		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		if (!capable(CAP_NET_ADMIN))
+			/* cg-skb progs can be loaded by unpriv user.
+			 * check permissions at attach time.
+			 */
+			return -EPERM;
+
+		ptype = attach_type_to_prog_type(attach_type);
+		if (prog->type != ptype)
+			return -EINVAL;
+
+		return prog->enforce_expected_attach_type &&
+			prog->expected_attach_type != attach_type ?
+			-EINVAL : 0;
+	case BPF_PROG_TYPE_KPROBE:
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI)
+			return -EINVAL;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
 #define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
 
 #define BPF_F_ATTACH_MASK \

---
base-commit: 79807e970724c1f90cee1316361d61b80db4eef6
change-id: 20261019-cve-2024-38564-c5e69b5f991e

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

