Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216450;
	b=immjrYqovJ7VWDlBbezWC4sFpvPFBaYdBq8dqbqXc+fDmEQ8n2emtS22JWwuQMTicDfe
	 2gO/eiVwOgUqH4WbL5yhbyE/dxVKEQRgE7Io8Um4nkPZdoGRyKfDzcrHhRKC8+Fz/om5P
	 v87SIh3GK4W3MVarNy9QvpzVUpkAHGqS3uAPOot1qUPGudo6P1SsKV4Vco65jPaExODsJ
	 JM/DGrgzL32nJiEoIrHnZyri11FObriJR7xHWKd+UVeLQuZWWi61J9tzZzbp/YBOhHKI4
	 rshP1qTkB6mVd/iEcnjxep15FgdvxHN1QIsnL2WFAUFu/RFCAN+6re+oZcjsjoa1gOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SQiSSUnkgfdQDioXSaElBSsat+w/04YkyQNDvuI8C3M=;
	b=CAogTb8T8n05w4dY2BlsvqEDHELRXKWuVygwzc7lAkjGlUEj5EC9Y1XrbcPOl2OQS/KL
	 wRHY7065NbNxerMYv1OM76Z/GNKyXuDicwtANjGN4iqmchWABMZh5TaKKDyngsAQsIJVQ
	 ujxJhu6/U9ltWP5jboF4mpYxWD+0MZB9EZYHp9a+lDXz/z5bMEdMU9ZPmv4z+zX5Ib/LV
	 RmLNtLq53boqBwyWqbZEkEbyd0if/11DnHhECjDeb6oriUH6lTz6vUwvT/QRTvDLDER5h
	 Q7F9pUMI77DkPz0h1xOMogl4EaFf9YXttLX0KQRYC9fCTT3J5OxhnNLL8VSSM3J6f2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MuZh3eT/";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E6606A691
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A3E6606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuZh3eT/
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso798489f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795216443; x=1795821243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQiSSUnkgfdQDioXSaElBSsat+w/04YkyQNDvuI8C3M=;
        b=MuZh3eT/vZxJJ/N89NPDd5NNty+NyzEGy7GKK0yySN6e/qsLHlQsHAJtbF9v7ULWyV
         7yqkHgJzD/+gL3YbrTL0nn1ypGlsmkO162LbIOZDykZyzWGZ70N1A11uRjrnH4l+V8Og
         XXdRSv5nEGEOatS5j5PWmZ+W+bGC7MPRLOt4IaaDdRUIX9kR4KdDYRaCzogDSG+1bihL
         iDhMDU28Ut5bAZBNsqt/0JS1NY+VVDO07++ELiy2qoMuDvTQOrvtnZj69y0aJy5oPIED
         3KcctILSm4VfDr3tPl0uq4adrPLY0GnZNoHkcBN8zrmKhQxc7hDho6jjgpq29oofmf9U
         fY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795216443; x=1795821243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQiSSUnkgfdQDioXSaElBSsat+w/04YkyQNDvuI8C3M=;
        b=PTRbtm+LB1eS33ZBdBVtC9fUnvVJI7T7ojvi0Vzem5X/SMFNT+op5mEUhOnPcgf2Vj
         v9rRgpNsooTtKNSPqFkfz9gUr7txzMUdqJ/nEUX4uYRfS6Ze4p3mfIhCI4SgiEIGWLVA
         hOOo9Bsewt1I2Upc0N8h5TF7DNFj45q2LV9YI7siQmMGMd9hl96nOSTb9ZsiW2uFrjtc
         QOLF+LgMne70adVs8DEWUvVn0VNLfRJ4PKFl5bMeEZ8BGQjwHcRdwSJ52WO9WiL65jAF
         Fart506G2Hmemi3ImtZ3c6bkW/Oa25d4mCEROuife47ZlNlSB7GXGVpYBsr7w5jFP6hD
         bwDQ==
X-Forwarded-Encrypted: i=1; AL+hErFD0joo8wsF60QrYH1Q5dgWVnrm7SpXyXznrK38G4J9HISFpzePBRC3+/DHlNxKUV/EWjhxm8s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5UPTo7XlLiJw+HGCR6z4la5gVohS2RArfx5F1Kjmy8JPfBQUV
	OQmUeB6ZCWWHrAwXz1wURMcRyyrea/LJGqBYRLrDlrWUEMLtcdVvZNo=
X-Gm-Gg: AZFdTZfdcKIXOG7wd7B9/hnSBpMEiv8dcwsvaVugNmsxIR6Qblpe3ddqvxhmrqnt6yF
	+42VKuPwaBmfmWrKAh8cnzAOm5GrrPB59gfQ5Sk0myv3cx1AJAL9lD8TZBOHWjAZQnRo89hAENV
	dtOxb9M3x0/8hA84480gH7p970GsbEMdNGQR9VSqYQVtsBPxMkPyEn3q6eSLDQT3MsUOphWGFu0
	Wf3/1a74yeG8uySXVQJ8DcoelfeG2P9fMygt4MXh4emZcK1Ho7HtoLf2P1FQu2kv7LnjczDB6Kf
	bC/IQVSAnnkWZ6sWb12ueZzEjhKc8HB0bwoix/6n2R3AL6IFbPky18w1qeRON6Ny2qwfaXUcppY
	NTmalTatbu87Vf9EPrHb4Gw7aBfXSttk3GReUjXzhYPmNtxe+ZAYvY6M/G+jH+YXTKqSj72EqJD
	G5b2W8svOq8kIKm80YhbrSDN/bxvorkAtup1QAvN6gox3pwyrH5Hh7t6rH1F7VkPrrgkyz0hKNl
	2ZjyCVhP5vrZaAZG2DGxEg7xdg+/DzUpAUO5u/WG2XRDKthwnYQJBnMEZ8G9l8QmpTwEAHrMF+C
	HdDTEHlvEXckGJxNpSq8d6j6b+rN
X-Received: by 2002:a05:6000:2c04:b0:4ad:2699:74ec with SMTP id ffacd0b85a97d-4ad269975e8mr6501403f8f.39.1795216443071;
        Fri, 20 Nov 2026 15:14:03 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm8151832f8f.58.2026.11.20.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:14:02 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 net] net/sched: cls_flow: pin file with get_file_active before reading f_cred
Date: Fri, 20 Nov 2026 23:13:54 +0000
Message-ID: <20261120231354.1361803-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flow_get_skuid() and flow_get_skgid() read sk->sk_socket->file->f_cred
without holding a reference to the file. Since the file slab uses
SLAB_TYPESAFE_BY_RCU, a concurrent close() may free and recycle the file
object, causing stale credential data to be read through f_cred.

Pin the file with get_file_active() before accessing its credentials and
release with fput() afterwards.

Found by manual code inspection; not triggered at runtime.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Use get_file_active() instead of get_file_rcu() since socket->file is
  not __rcu-annotated, fixing sparse warnings (Jakub Kicinski)
- Include discovery method per sashiko-bot request

 net/sched/cls_flow.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 2ef449706638b..8653e6fdcfa2a 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -17,6 +17,7 @@
 #include <linux/ipv6.h>
 #include <linux/if_vlan.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <net/inet_sock.h>
 
@@ -208,10 +209,16 @@ static u32 flow_get_rtclassid(const struct sk_buff *skb)
 static u32 flow_get_skuid(const struct sk_buff *skb)
 {
 	struct sock *sk = skb_to_full_sk(skb);
+	struct file *filp;
 
-	if (sk && sk->sk_socket && sk->sk_socket->file) {
-		kuid_t skuid = sk->sk_socket->file->f_cred->fsuid;
+	if (!sk || !sk->sk_socket)
+		return 0;
+
+	filp = get_file_active(&sk->sk_socket->file);
+	if (filp) {
+		kuid_t skuid = filp->f_cred->fsuid;
 
+		fput(filp);
 		return from_kuid(&init_user_ns, skuid);
 	}
 	return 0;
@@ -220,10 +227,16 @@ static u32 flow_get_skuid(const struct sk_buff *skb)
 static u32 flow_get_skgid(const struct sk_buff *skb)
 {
 	struct sock *sk = skb_to_full_sk(skb);
+	struct file *filp;
+
+	if (!sk || !sk->sk_socket)
+		return 0;
 
-	if (sk && sk->sk_socket && sk->sk_socket->file) {
-		kgid_t skgid = sk->sk_socket->file->f_cred->fsgid;
+	filp = get_file_active(&sk->sk_socket->file);
+	if (filp) {
+		kgid_t skgid = filp->f_cred->fsgid;
 
+		fput(filp);
 		return from_kgid(&init_user_ns, skgid);
 	}
 	return 0;
-- 
2.47.3
