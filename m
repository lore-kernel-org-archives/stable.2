Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907663;
	b=aKKvRjvWkh6dUZxFkcaddHrFLXdA37Y40Heq4CHwumwgkbH4ky7VJ8WEfBfmgsXHm7nH
	 lnBtkocfBCCtkPx7NdEaO5zdkmT83wNfA6pL3MggYdTcSMua3zoBARxXspsI+9K9Mlb+s
	 5a07gpGpyN0KHMrYOfD5ojsoF6qcEEenZRC+EDTR8nEmBJLfD9vwvLsD2zmMNzNiq8uMs
	 I56HDWHn8O27rvFCnnTeSUFagrMqhhFvFz5PlzjE8C36sFh1wZ3ZMVglrbdS0MZiHU/Ny
	 zhaeul895wURUm6d0C5GO3Iwpt+WG+aQNjjfGyzmjk/T/vYo9HTns1d35BGrmTgh7/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aDSdHKsmTGGWkDOKCvZtMPEPFRR2Z2wRDeQx9ZQTN3o=;
	b=OSxE79dIY3JUgMZmiuo6WHUwcKHzFn5kvfz0ELOQ+/HTrZg/00pNcJMYuzSMRRhlDlUy
	 TNEPyF1iTzJW9Dmxes7lZz2HaVfv8kHyl+kX+EVlO8PF7VmU4NuR8+DBlnY3u3r5ydKIJ
	 EgLevSrIeN1T/9pt42K9FkQhI1ONb4DN/W3pt3aI/+rRm4P54kcXjZwPuHQWAeQ6JzFRY
	 cK4mIC8B1UIgBa9c+LKpSt0knpS3XZbAxKOBse3wHefl1QabaPtDrp1Ai629boDsWUXtE
	 qsmQI1uQi5wakNYJfoBP8RdtO5LGxMr0Aqt5plFo/JaKdTrwg1f6av0n9UCGK4l0/8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0SeRLO/C";
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F278606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F278606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SeRLO/C
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1521c45a248so3040300c88.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794907661; x=1795512461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aDSdHKsmTGGWkDOKCvZtMPEPFRR2Z2wRDeQx9ZQTN3o=;
        b=0SeRLO/Cu/Z7fD38T1aAPibopqP6aQGUmhp1Bo9C+KNJ0zCPPS4ridEDVsmduTWVMB
         IcSiChIYc5OtxT7LxawZZwt+I4vRJx+Vqq/qgo8Z8FQoveqYdA9YRJcwE/sXvxSDpMRr
         xicb0QeRwgjZ9gDwefSkUvHASJVJQlsYzMLlQ4EAKa7se1CKQDlqSiZO4Xwi4Wnc/QC2
         VNJwxXOQsdQW6+6QcfmItcKP+zjvb/hOjtnhCrZe6LlBjJf4dHf/HEeX6Tndo67/JG2A
         sGSH6TS8rkRN0Xbzr2uiSUXWh7FLBkPXcSgHu7bfSdxyrlnkvQ/DQ6n04bjGVmj+umb1
         eyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907661; x=1795512461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDSdHKsmTGGWkDOKCvZtMPEPFRR2Z2wRDeQx9ZQTN3o=;
        b=xmiEZJsSsGhH0Kq5zFicjkbf0faHxpD0oiTjwurOay5aQkp+9iVxvvUd+RkRBaL6ha
         c5egfoEVlcy+OMbZC4uWHDzwqQiJNo8EssdpN61e2RicjO83LjDhaM1ho1BAkaBsbH4B
         tbciv4f1oydFlHPDwT6OPDMFWUUT4qbLDC45xxox52LUtP6U0S8/jdBoIsYjo/BvWoul
         1HMa2sx8HaFEpymJNoJsszlhg3IOvWz9mg6lYCX8CjsmUeMkZTveX/Ibcn+m0YYVWsoG
         gW8rOTdT6H1SLDlkE0RsOf3rFMiTR/s9UReBxcZ4Bu6Jtx6nUoPsfJLIA2CSgPErgZ5H
         1mZg==
X-Forwarded-Encrypted: i=1; AL+hErFG1VD+XZewNRuIRIZX95L2QQiO6MPBwabcXJUWMwbuZTBKBuo9NA/hbnGs4nhj+xoLbK2nNLU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S5a4mp6ndPXYIrvEMdGdzvg8hyNAdjuBeD4nWIknuC6d4YFAX
	QftHD5ubbuSQia0izoiiY8/U6oO39iOKeYgLKw+toD7HwBp+GPaFRkv6
X-Gm-Gg: AYBFou3PTSacNuTpt9MrdOlBOCYjmBBX8YP/rvjFwuglnXhTBnBJI3FsFloIQs3iRDa
	DzQ3/L/maWVoEDSN+44UPQco20M54AD1cBVgK9hoShq5oK+B4WAUvhZmyxlG1JG8tGDAYIQFuDE
	a9ZoZimsxcv1mEQshR9Sj40l5mJuvxJJEYqC3RJKzTvXCmkNZcFgwDUzMcA4iqViITm2UI3gYJp
	qMf/8VHd7ljFgIr9+qIfYktTMMSl/S7eEvYi5HjzTN6XBSsUtEy3kS6FRxfd0N0UP+C8s+AgdYA
	1XAUhMBlfNiohmR6r727oAJR9Gw8VagJHMsKg+0cR7/29zpLSajTn/WzAfeTiqndKMSonxiHn5e
	MDr8zj04OWfv0ebcYHJevf3h+bXJlt5bRYwbacIqq/Kv84thWDgrxn4/Uz4Myq5vgOgrfiewvTA
	6CmSOhYHrioMJn8cbZPcWBScMgZOkQpLu9LCaY5pWnTX6bLM+VwZLry7kMzgklNDK/rvhKQU5wN
	PWnyn8vuoTCiPQ+GcqThwqSwHoorvv5MyHNx0iPHE2C06JtCvyJ6F8LtZXoKY0DM7b3ProcaSuM
	ExeqH80hJ64UPzKtuyL+0m/DOGOtVgGIVWpXX3iIyFK+EEG+22fbtOOqtmqWfKprUJxNoLE4nOm
	0eg==
X-Received: by 2002:a05:7022:438e:b0:1b2:539b:496c with SMTP id a92af1059eb24-1b503175d03mr21231997c88.35.1794907661127;
        Tue, 17 Nov 2026 01:27:41 -0800 (PST)
Received: from DESKTOP-GSNRJ5L.tail4a8ad8.ts.net ([104.28.223.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm38381531c88.2.2026.11.17.01.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:27:40 -0800 (PST)
From: onLeaf <onleaf322@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	onLeaf <onleaf322@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netfilter: ipset: exclude add-path GC during resize
Date: Tue, 17 Nov 2026 18:27:31 +0900
Message-ID: <20261117092731.14656-1-onleaf322@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mtype_resize() copies elements to the new table including their extension
pointers. Garbage collection of an expired element in the old table after
the copy therefore frees an extension still referenced by the new table.

Commit cffcf57bf03c ("netfilter: ipset: exclude gc when resize is in
progress") prevents the delayed-work collector from running during resize.
However, mtype_add() also invokes mtype_gc_do() directly when its target
region is full. The packet path can enter this call while a userspace
resize is copying the old table. It then frees the old copy's comment, and
collection of the published copy queues the same object for freeing again.

An unprivileged process can reach packet-side ipset add with CAP_NET_ADMIN
in newly created user and network namespaces. The resulting duplicate free
was reproduced with KASAN on x86-64 and exploited from UID 1000 to UID 0 in
the initial user namespace on a non-KASAN build.

Serialize the direct collector with the same GC lock and honor the pinned
table's resizing flag, just as the delayed-work collector does. The table
remains pinned by uref while the lock is held.

The issue was found through AI-assisted source review. On the fixed kernel,
the same copy/old-GC/publish/new-GC ordering completed without producing a
duplicate object; /etc/passwd remained unchanged and the test ended in
LPE_FAIL.

This change was prepared with assistance from OpenAI Codex.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports")
Cc: stable@vger.kernel.org
Signed-off-by: onLeaf <onleaf322@gmail.com>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 80ca523f304b..70f768ba7b44 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1009,8 +1009,12 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	maxelem = t->maxelem;
 	if (elements >= maxelem) {
 		u32 e;
-		if (SET_WITH_TIMEOUT(set))
-			mtype_gc_do(set, h, t, r);
+		if (SET_WITH_TIMEOUT(set)) {
+			spin_lock_bh(&h->gc.lock);
+			if (!t->resizing)
+				mtype_gc_do(set, h, t, r);
+			spin_unlock_bh(&h->gc.lock);
+		}
 		maxelem = h->maxelem;
 		elements = 0;
 		for (e = 0; e < ahash_numof_locks(t->htable_bits); e++)
-- 
2.43.0

