Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485139;
	b=E/RQ79HVqbjGH9sHesSjUcMvZjUoD1Fz0Aw+uQeqqtns0aPMI6lMYqHus7tW8XerOyjL
	 RD2mEahRbueg7Aul7gwRdRCokzYmnXvfY4rY5s5rt3USxKNSmW9CJLsiK7udFTe3UXNoI
	 Fi9lW8a4KYqs67r3I6f49ulasJLltM21lNa9VZj4o6klaLpdyt6HuUSxIvIx/JQy8Nx3q
	 HzCk2Jf5JyWH86iCHC1jRIb91bPOsbTmznTZzjSn/lQPZLmWBTN13C0RaEYBilEfyeHL3
	 00kruNwjV0moZv7XaiDIqIjHDK07DY4Hn3H5zgGzok20gVBOQtWziIr2pve904BsDTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485139;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=SFguEddrmA88iw9wMAeTNrR0nfiHVOBL6aWH5vEPxEw=;
	b=wgTxPRNIHpGv+2+Gxfj0I0VmlwzeTS9h0Z9SZQ40lVMf7LhNax1CxecKH/LiHG8pM1Yt
	 MkjDJe9H5uumdV1mU+I7Yp7Td3x3HHVSCpUkSadQP2YxERPR110m3nOq5mz/PizP6qNRI
	 EY4aS7hK5gg2UexlmDqURie9r/NHK6dRw+LxSaNnBxFqYm5tx7SE8VFvxLS6TZveKXpBs
	 Gjr6ehGAO5jwh/AfGdOhsXrvBq0W5HYardUniKt9Imex8fegSn6rX+3AAU2BpN8RKKOIP
	 1HtGRZYhwGbJzxriVvkKL6GQjblLUND7gM6EBW3M37+dvq2EfVmlBn1VL5sOo/PZuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WAn7UuyR;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD6606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WAn7UuyR
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ECCC1C63454;
	Tue, 20 Oct 2026 08:33:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8270060393;
	Tue, 20 Oct 2026 08:32:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE7FA1032840C;
	Tue, 20 Oct 2026 10:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792485135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SFguEddrmA88iw9wMAeTNrR0nfiHVOBL6aWH5vEPxEw=;
	b=WAn7UuyR2zZzetiae+YFIXRseFD00ed8vobk0/5k9Cqrzq2ktbDMfYEP0IG9TQ4K7w436A
	7O+4npuIwJlXQT0tXLPa2hKM68lQK9G0hx+ELVyZ+W3/kt0iCUzQFdat1An1bxYygLmNNA
	OsMxyaj1uTRvNLJsQFXVQeXtWrb0W2p1NRcRNzie65QZNqioVQ5yh5Ntgqo96ZA1ui6+jv
	xt8NskgN56RhQfkJUD0ooiKm+96Eg3wbaAGtVlhetG8SBYz9SdrwCLKDzc3imP40JNvxy7
	gYLuX4H/xIUjhVUcbCA1D7VjhZh+zvL9qbmgy5pvEl6at4r8KjOxr/y9wq1fJg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 10:32:12 +0200
Subject: [PATCH 5.15.y] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
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
Message-Id: <20261020-cve-2024-38564-5-15-v1-1-9c9412a9c0a7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQri2ZDhRHr2JcOKVoXaCZUaIh3
 N0Rlt9L3j9D1mSa4VjNkHSybI+xgHYVyO0yXhWtLwbvfEfOO5RJsaDFJnDXIiMxcpQoB9r7JgQ
 oz2fSwT5r9QRcE9dfOG97fse7yuufhGX5AUrEn7t/AAAA
X-Change-ID: 20261020-cve-2024-38564-5-15-5bcbc9172388
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 syzbot+838346b979830606c854@syzkaller.appspotmail.com, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792485133; l=3786;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=o8mTa8+0JN+ictHrdcM8Gk+zeTysxghhPHL8xd8oI7o=;
 b=NM/qVU2eYYV8o4grNECVcwXm7Ldhnz6WCkvhj8mkwEtko6EKlSvlNlCTfbCBvH19tBDmwZnCq
 T6AGqZqyu39DHjcF76m3dS/qNDPjpzggZ4U1jxILfPuhea83ST2u5hm
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
 kernel/bpf/syscall.c | 54 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b80d125dcea9..9765afbd1b1d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3131,29 +3131,6 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	return err;
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
-	default:
-		return 0;
-	}
-}
-
 static enum bpf_prog_type
 attach_type_to_prog_type(enum bpf_attach_type attach_type)
 {
@@ -3209,6 +3186,37 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	}
 }
 
+static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
+					     enum bpf_attach_type attach_type)
+{
+
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
+	default:
+		return 0;
+	}
+}
+
 #define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
 
 #define BPF_F_ATTACH_MASK \

---
base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
change-id: 20261020-cve-2024-38564-5-15-5bcbc9172388

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

