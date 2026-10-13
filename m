Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52E4E324F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935023; cv=none; b=V6SAjwT4Fcmav7L/ALPRUSw+++kU+f2lxjrbv5ANLJDRZggayxMnlRNGQ1pv5EYo6bFztuFM4zPutnq2dPTfKNAvR/nt3kUPYPa/YWB12bDVIGszFgWacbE6T+ATKnjKib4eonxo92AYXlg1PJY6pX2yxgea9590neO+sZLO/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935023; c=relaxed/simple;
	bh=bfxbVwtokcd01M2enVtTeTKpJh0bxmFffQUww3wsOoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hnbl6RP/r0IH40iyDNHcapJblHU5/IHNsiRpYM0yJD3VQFqoT7c4c6qDMFXRKY8O7IBSnb7nDVsOj89fvH2ltQ4qKkXFvVnPjiVFQnpBwDfVoXr1ssVpCAkGzWfIwB84JRRfuH+0HZqgSWE46VMIVIU9c376Hwscf431a23klqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loHNLw79; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loHNLw79"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso25410955e9.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935020; x=1792539820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbK6BK/Sj/b7bRnCH5dsivi2mNCZdQNMtkOnxkkzFB4=;
        b=loHNLw79zd9r57jsdzG0utlCvC8KHig8WqWCvYY0xOzvUd3S0gdZXRxyrlOgc8ftL7
         WkmnhH5dJPYRWLNG2K1CXrvmUT30dS3sa3+8WJvfkRwJ7m+yFWncgXYILgmywjXUjlvW
         K47P1MK3h0aTB4owJsfkMY+G9bf4ZTas0XYV2Ufuldv/g37IZfj5n0djv6cxeEdsn9Vq
         UgDoDy9U474zQUnu+qbjYDl/G59qgmq83BJezspZ/UQj8ffzYcRfVCmr/ccIv75cFQll
         fweRaxb48zenmYHz/olzaVM1kAZ6o6rBFE5aXHGIEUiUPu7ve++XsEAZ0YGHkhZ3/yRM
         A76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935020; x=1792539820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbK6BK/Sj/b7bRnCH5dsivi2mNCZdQNMtkOnxkkzFB4=;
        b=pt2LuDZ/th93CQuqujCeV0cJr+iFHx2AmI4ZsOZLxezZr16K/9vlPBf9BEtm7UK7P5
         cQ9JMjOmHCoKVGvwWT2PIWwXdpAJ9TApfWcgvhjveNF8MB8qLjfFFfB51CJCUv39GrBp
         Ruej5Zch3TP3pbslIa6wUDhrlSppdPoOglIR0opx5naGPfnOTbUlVBZMHmuN1aJceA2g
         nm9HqZ8NKJvobFDMyuHNs4QzahwQnQkvYxEHIEdwaaKOgCCmkhHiOOOCvoEp9/mxlcu2
         YKsqx6wqb1jH26sF1O6cVlaCzjMJ4box/gGXFFJPDjLV4xVS1nYJTmQcYNimPkGcwkRY
         Ld+A==
X-Forwarded-Encrypted: i=1; AKwUvByO1RrEA3VcOsZksj8uJ1Z1BvhwT14HdVQ+pUoKo9w4WCmXgK2reAkwtoI1RpsFim1Xwo5fiZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpBrWLmX3ZlhzyCtm/NoiMZaJaXFXeP2YvdJTA2K7K+FZS2RGc
	J2cvDfK62K5cFqDMqtRrjsovK5/OcT15UcTggXrzbm5Bl0/fuRWXnuE=
X-Gm-Gg: AYBFou124BOuhfh00PrBDB9mNOjIXt3FYgW+a8fMuZ4q6bdltJhGgZGJLQ5BW8829a1
	FHuzmOBXQ7mTzdl/pElZSDJUkdxDep6Ujk4WY/K4VCZrOh1qsL0eCnYeShrkDa7sdtcfyUWamUv
	LC/Kp7GMdBY8VefzdOe/nlvRo2XSuHz3XO1o1I9ja6LzlzhluZHUv6ysCKgQw+zjdKhOln5N8F2
	dhKf1l4sb2mukcj0i80GGepoK/9w1xGP3dCTAE8EEyyxYN/ctR02FPgdKw3EFRN0NzGtZbURO99
	cdsWPbFkCkArkQCnRH3hXeZyCyzTDICQsjjMvfSRXJ0CwnlEvk+fM3pUSKwMQlrIZEnvJ0aed4m
	exrs1pVvepLrwAegTyHZE0yAz5pOvDwBgDXCf4pAFje6gcltgFTRG4M9NjJjZaR/8lSJrsOhVl6
	UV3pqGzON85lZfCX60xgXGSOWtev2+MOCvABQSMYw=
X-Received: by 2002:a05:600c:c104:b0:4a1:96cd:2f73 with SMTP id 5b1f17b1804b1-4a196cd32b0mr144209005e9.1.1791935020199;
        Tue, 13 Oct 2026 16:43:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm390372155e9.13.2026.10.13.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:43:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH nf 3/5] netfilter: nfnetlink_log: pin file with get_file_rcu() before reading f_cred
Date: Tue, 13 Oct 2026 23:43:26 +0000
Message-ID: <20261013234329.2797868-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013234329.2797868-1-tristmd@gmail.com>
References: <20261013234329.2797868-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Since commit 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU"),
struct file objects can have their slab slot reused while RCU readers
still hold pointers to them. The NFLOG UID/GID metadata construction
reads file->f_cred without pinning the file, which could lead to
logging credentials from an unrelated file if the slab slot is reused.

Use get_file_rcu() to take a reference on the file before reading
credentials, and fput() to release it after extracting uid/gid values.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nfnetlink_log.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index d923f2cb13980..8c9e297a7dc18 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -632,22 +632,27 @@ __build_packet_message(struct nfnl_log_net *log,
 	/* UID */
 	sk = skb->sk;
 	if (sk && sk_fullsock(sk)) {
-		const struct socket *sock;
-		const struct file *file;
+		struct socket *sock;
+		struct file *file;
 
 		/* The sk pointer remains valid as long as the skb is.
 		 * The sk_socket and file pointer may become NULL
-		 * if the socket is closed.
-		 * Both structures (including file->cred) are RCU freed
-		 * which means they can be accessed within a RCU read section.
+		 * if the socket is closed. Since struct file uses
+		 * SLAB_TYPESAFE_BY_RCU, pin the file with
+		 * get_file_rcu() to ensure f_cred is not from a
+		 * reused slab slot.
 		 */
 		sock = READ_ONCE(sk->sk_socket);
-		file = sock ? READ_ONCE(sock->file) : NULL;
+		if (sock)
+			file = get_file_rcu(&sock->file);
+		else
+			file = NULL;
 		if (file) {
 			const struct cred *cred = file->f_cred;
 			struct user_namespace *user_ns = inst->peer_user_ns;
 			__be32 uid = htonl(from_kuid_munged(user_ns, cred->fsuid));
 			__be32 gid = htonl(from_kgid_munged(user_ns, cred->fsgid));
+			fput(file);
 			if (nla_put_be32(inst->skb, NFULA_UID, uid) ||
 			    nla_put_be32(inst->skb, NFULA_GID, gid))
 				goto nla_put_failure;
-- 
2.47.3

