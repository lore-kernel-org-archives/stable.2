Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411078;
	b=mGTv3QZ1Y9ihO9CSyYQEmR2kRYgW/Wd9PLWaAmHp8eITPT2XEMpbCTeN2hsit0s9dO00
	 QDWZAcReyyZymVgPxvYm3eKPXxy/c6xFxZ6gFrYgV/BP7rPKrqb1Pm1U8bFbibO+CwDwU
	 EKlInsL982TFNl/JoaZbWGWcLsinMOl+Sp8byjU5WO2fsp1nPA5jxThz7ZeOJDPT6QEbz
	 B0FRWactiN5B93F99DItWPqwPy2w27cScrMTFU/EjsnxJCc0oqF2RHaxq5nx17a/pYYJ6
	 y4ffQyQJFyJEjtmae3Jw0aOdfFRG7/uaoAjMImMXunHswEzRJRSjKhWe/OKcspG/TlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jMbE98rH640PDimDt/5oPcA8BfJO9FWfDPET1eqatTE=;
	b=farVXYwizBlAnnIrC+gL78Ecr4vdRZrEh0np9HYC1VDJc2KnwInb77BvxbzrZA7j9bJP
	 MgpY7CXevMUhoThTdmYhHa/Ldu4K/fa16+qrvtAUwEnGrBSHExMWlUm0+/BuERvpRRi8U
	 OzADjVji5HpEC4zeiEUAOICQtaFBuSZRE3EGQgjIzOX5NMqxNN/Qw6KoLclJP+KI5g4Qu
	 fRHilE6kI07Njq5RzLYon9KrmnCV0AS/ihMKs2kWPuR14qeEuOzQDrdhE7oNGnOW5NC+S
	 vncAhCvYfBc6d19Pm/4E5A+AdxFetN03EzyLCpjCZT9JQX6GzoTwPwTXJG/gC90Igtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwZFkqnk;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B55606A335
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B55606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwZFkqnk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so25654205e9.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411077; x=1795015877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jMbE98rH640PDimDt/5oPcA8BfJO9FWfDPET1eqatTE=;
        b=QwZFkqnkqQgmKMaucvqUUEhBhCr0CHfKdRo56wmiBm1nt1B06ewHmhGQFcN1McJkGi
         Y/h/HgWV5gvyg000piSpcg7wedMpZsjEd0iTLO+PD30VerIoqP9qIeSPzs/jGZpZAAWl
         p3YkVlhx22iVP4VgqJXKfdnOtzciiHM5NqJO5vHBstLl/najug9+sUBetrRtwIFoufl5
         JQJGDf20tM/YDaiCXhIvherz/n7N6yUNO8dsm59dUOnRPnhMWvVQgCm2Xg0jmnmKH5fy
         vB5OHjhNq00CTpz2vuPlCSMcqs12L90cc4QJi2Rxbh4lE18kbfkYVfn4K0CY/Gds6XLg
         89YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411077; x=1795015877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMbE98rH640PDimDt/5oPcA8BfJO9FWfDPET1eqatTE=;
        b=WN9O7fZE75Ya6FtgQNTWWeRaxGe8/mg8zgWMlg6Y4fKOeiLyNzTVEW0vb4ke5caLsM
         joH7tyUWlzEZFZxrfgYLaHG/GpijS/tcqLlo/v781dH+5JnjLvEGd+6Myw64MhcRhJJ7
         MV5v0ykBeurMLKsZaewgeMEUhRq+CYORn33Gc6617vTqXiAD4EgggBtM73JgYaqVaeGD
         v9ywcc9nt1/g7k5aMv7qS5i4M/vWQhpmY3JVryq1LL+Yo0x8tKFrROMZPLA5L3NjKHOP
         UuAaH7n5Kk91M1+l6l7bABChS7uAqADUGZdoFNpFh4icOdsrc56PW/LUvv0fG9UupWYi
         a1TA==
X-Forwarded-Encrypted: i=1; AL+hErEM/ohFB04ZMOA0eW5L0nv1cp4GoQVmqmU1DA6+piEzcunX18lRIhYZ0ebSNCIp5YA7Gb5A1jA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ol+lU6lv/E2WIIeaIPOEuaKFAuw3B5vBI+9D8Q9JbMrHyyap/
	Vw/jCp8RDaMv3Y0lqqToF7cdFkx6eDVA3aUjhTq3+JA/bARS2+BvoIk=
X-Gm-Gg: AYBFou0KKnvrnF4Wv10q+f1j0BkjJvuORgyG7k0PXujTL6EUTFTcYf5xVYieWejRQ57
	n22g+sCfHmif+Z6lmO2mnDKAK3o9q4GQYh0jHiYcrjV3KYXfsnFMqg2JslqKMUxYPM2+pKMRiyz
	XqrLISv3QAceK4iYeFBWw83vQGAi3q6gA0oYpfjbpemot+2CeOg1SCYPj0j94I1AVhEhH74pyFv
	UplvrjJngmKRANZXcttbYVvaEweVDSGYLPCiT3m/NQRnpFNoWaiwki2jxuHFJ7XatwrfvrXNpUY
	p2UzjokkuKycsxhUX13r1xKyyqLxewerWm3r8IC+w7DemEzHAnh3a345zrfAHBVHeXYaVdSqBLG
	RfFBhkXbowr7R4bX20TU4IRYCLkg1T/orqSXGQhOwbl3oaVNUeWI1ofbUBVUR21Tfr4m3hE4fl1
	OjV20KCGKsNNrtTgKRPOKuGkkOZ+3ptAbUu7uwt3xtb1ynWoxgqJ5uAlqfXfbTbUrGuksHRadWs
	lXgps4j9Yf5lcQMGLMtAklFUQzpz7DBpuMbGSGasL/Npq2CiHNkbtWUR6YrBbbVsktq23shmHgt
	Ihj7cBleO67M1lc=
X-Received: by 2002:a05:600c:1986:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4ba0935dad6mr50320995e9.8.1794411076662;
        Wed, 11 Nov 2026 07:31:16 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c5e2fd6sm2261365e9.10.2026.11.11.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:31:15 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
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
Subject: [PATCH net] net/sched: cls_flow: pin file with get_file_rcu before reading f_cred
Date: Wed, 11 Nov 2026 15:31:06 +0000
Message-ID: <20261111153106.580776-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

flow_get_skuid() and flow_get_skgid() read sk->sk_socket->file->f_cred
without holding a reference to the file. Since the file slab uses
SLAB_TYPESAFE_BY_RCU, a concurrent close() may free and recycle the file
object, causing stale credential data to be read through f_cred.

Pin the file with get_file_rcu() before accessing its credentials and
release with fput() afterwards.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/sched/cls_flow.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index a9ac3acf6eda0..233ca13299930 100644
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
+	filp = get_file_rcu(&sk->sk_socket->file);
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
+	filp = get_file_rcu(&sk->sk_socket->file);
+	if (filp) {
+		kgid_t skgid = filp->f_cred->fsgid;
 
+		fput(filp);
 		return from_kgid(&init_user_ns, skgid);
 	}
 	return 0;
-- 
2.47.3

