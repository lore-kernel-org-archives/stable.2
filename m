Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485083;
	b=h9cfdLX6Y8CVUuwfjRpbyNP1BpLiWpx1nAiz2D6e7/Vy4thMolD3TGTUzkes/1iCQGRP
	 fn/jdjaTJPkJKWAYjvGbgsv2AINTQGVS+N+wBQrAt9oH6sLNpqaVEeWuzmibBq17vugJu
	 Xg4fSvstsaMpHCv+/fP5evgEo4fPyx8wkpL94mwtLOlVJewU95ZwsC+R484k+LO6LIDv2
	 x5R1rxwBzTsn/0AoJP7C6vvPXeQiXaL3i/oUCZKCUPZaGS/N4QRqfjcTTrviLX7qYYdKc
	 gBySKtdvMR7Ak9/gZ5HWxl0c1u+TO0yYzvTYpI5Y4odRiVL+5ZEZCoMlxMD4Q0Fvmuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485083;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=GgmyQreitXQ3eM+tXDefs/IIki0/zSir+S+PRm7R4nU=;
	b=IwOxXB35Sg8IeeM8bmL5QfphCtqBjtJZuSRAEfpRgOh2TvTu1oKMZ3R0bk2FKS4qFihu
	 +0JfeE5UVnJ0NyPIJCFC4dIsDQbSrzoutTiF/7yXvIHzuVp5Zqf68Shdjy+wokXaxFbPs
	 k3DRTzb/3FdVqzJ8T0megSQPMEmP/xiKj0lVfXpPha1f+ayjtz52/tcz/7EmV2mWy6s6H
	 96HPhxtUBzJKU4rRYSwDj9V/nQjWWDQeetCz/Wgi56EP16t4Iitz1ppvmzQqtSpNpe5sn
	 zF9+RuUWHAiwnuhcYAgzrLAbnSphVsPITc1xNrmZdjVZxRI/b2sMynXyfxbTFhWx1Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Lq0r5m23;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFB606A321
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CFB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Lq0r5m23
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 79F981A12A4;
	Tue, 20 Oct 2026 08:31:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DB3160393;
	Tue, 20 Oct 2026 08:31:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BDC11032840C;
	Tue, 20 Oct 2026 10:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792485079; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GgmyQreitXQ3eM+tXDefs/IIki0/zSir+S+PRm7R4nU=;
	b=Lq0r5m23DMl0lNOU3ICwQecv0viINh9NPiBhjtohO1D32B5A6gyOkrLVeW7/ezuzHHYXGy
	/DNehV+Ht68/QLTOD94fkYquqmHj+0dBGTwkdXHyi6vMxXPc3XfFJQCEfvbpcI625+EMUw
	bpoJRt6pqZiiJvGjRslr/VGE+yvQMBn8UcPidrHhnc7LhTSg6JmT1CcLQDWNSMf7vSYHP+
	5D8K6LlXTZE3Kx70EgLfQ2kigNaasbwmuof2ZhLelSE8bOHMYqpd4RZrOFTu7szUv0Je9P
	5K5ouK3hJiAsgaXGcHdUKo2gA+mDbT2qyjw1H+ilGjX3gRK2qkTTwPsCnJSdEw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 10:31:16 +0200
Subject: [PATCH 5.10.y] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
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
Message-Id: <20261020-cve-2024-38564-5-10-v1-1-785c0999bf7e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQri1pRzpRr2JcSClaF2hmkGgId
 3fA5feS98+QLbllOFUzJJs8+3Mo4F0Fer8ON0PviiFQiEyBUCfDggb3B4kNCjJhr6KdHNvIHKE
 8X8l6/2zVM0jNVH/h8t/zu32YjmsSluUHfiVo5X8AAAA=
X-Change-ID: 20261020-cve-2024-38564-5-10-fc5cd59b6116
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 syzbot+838346b979830606c854@syzkaller.appspotmail.com, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792485077; l=3786;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=Ahc7yLIZAfSfRC/cdQHXFW0Kx1RDabAZW9hRDposRLo=;
 b=Sc22T78qQt28aVB4KCJv4Aqtzc8vsSb32qxA0aEvy3O+bsXFV+dq/g+iKhnC4vAtBj4AI5pXm
 BAEEAQeioBYATZ0tVKQ0yUrwAKdURUg4COEaXvVvtLpz2FgMLYP17X9
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
index dc3d9a111cf1..9c611a715ed6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2934,29 +2934,6 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
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
@@ -3011,6 +2988,37 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
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
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261020-cve-2024-38564-5-10-fc5cd59b6116

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

