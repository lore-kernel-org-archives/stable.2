Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270366;
	b=1O+WIrc41maDKgzBuSYTymh5pfMdnMJbQw3Davd5ELnng221tSpqEhemRW/HYis99efQ
	 RC+ezWXYCt6S2fj79CBbwS3ZtaKSOXeUoj/uqguHmlmoy6w7fJcDht60I1P8AN9Zu+M5u
	 VKSSVHuY5x4PmewEAxqeY47PInjX/MUKpGl1H/fdQucpp9W786FRqlExBodNqRUoqk2Ai
	 2t2ADWq/rH23IYks2ik7aQqEJhe8xEQH2E4ICuI+wYBN4Z29AC/JDS4STwRQWTQ5gY6DR
	 f/2TUUfDLB9ZVnoRsijm8dprxxsYc4F3Jv88IaGotECvXcmv8Xkqxy0RQCFULJSUQfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xgI79fkxqFLajK7iDGLVXmUc9XmvD6di/dY1FwycFRk=;
	b=Ut9/GD5KzftK7IiSh/Iq8drPf4t4iebQN1cYoAFXdQK6iEKN0nlzqHm6rtUO3oYT7sRq
	 PV2QNQs6vZF2GHJosbg409jnpWX4RYvLQZiJ3Pd3N0QVl1ErF15rcpJo8rcXYydTz04dL
	 zZp5065EAdTsz0BuI9X+XW8KY54pO9ALZvWg8aqDao0tkH4SCLFpzdawrHRaX0eiW4kck
	 cOom3kwO1Z8MqvvnbfdHcUCyo/DEIAiQJJur7KQUnVez7T3LvAkgWnfPDubFpQ5rxNRxn
	 Vrws4jXH1qxwlC8IV0BknI3nNHh7xNBFj15FzIJKVAgUoRV2unigTNwCQihn2DW64TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0tsWCG2o;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582B606A33C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D582B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0tsWCG2o
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c423b145922so277757966b.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270364; x=1793875164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgI79fkxqFLajK7iDGLVXmUc9XmvD6di/dY1FwycFRk=;
        b=0tsWCG2oAp4YyD/tVOlTufIkez3k959y9Lsw3Z7v642aMAUm7Por3flopgT27Qulbs
         zAKOhC4x11WYsNe1rOKhx9RXf7I0EJneW5FOp1aKhDmCGReVz7vHOKRXr+XsGqrgBHwl
         DajmL0F46MYGvadTfx+XaOYZxHgKjljtNGwpi2+QIXm7KW1SH8xKe+zww3QRVssI5pf+
         Xg5s7mIALZGB87aWX6YhHa0qGlTvuUax8zZQrmlIJ0h1+EhaE0naU1gImSkoNuHbKhPR
         5SVPOYZn5TUdfwAwiWWNsnvrLrvT5TCTM4e7Ef0j/1DMH3PSl2UT7fGbIyvAvkTKH9Uj
         zUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270364; x=1793875164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgI79fkxqFLajK7iDGLVXmUc9XmvD6di/dY1FwycFRk=;
        b=rC8m+V5fQnVwJFxEvqSAgmo2r6cIzYVS0nwXdUCOHRIXKVj16hH0ab48kigs5hEPV9
         GAHo13UI7utINrYCAfD3zXEp6OpVIruFBARxnIg0itMGmFdXpYA7RDnjS9F5laXAU3UP
         1Dlq9Y7RpfcxkwoQm1gnoebbV3sLrFmT8w2jZR9pNJ/Y2JN9edREnDO4x+FcR+9fFzDU
         LCv4oLIGUa7gnyUb0uh2IEP2LmPfQKYKSynUBrf/CFCWzNOJiNFOb939d4ytAH7EuWub
         d+GC29DaOEuGNtfiv6yhM/ia94ly5h5ZDJe/7lN7UgFVqRTXdmMvL70Kw2s5g2ospl5D
         FrZQ==
X-Forwarded-Encrypted: i=1; AKwUvByfWumjxK9YcZ82kwhzvhyV4bFc1JVZ7JcTIfME9eoly+1ukWwT7RccJ5/9jOmmlA+ivmDpU10=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNj4QpXvkpBM/3cA+xIsBT1zzeQ5Udx2QKPgBGsE+YajYEwVgt
	QSwpaOS3gnaOKr9eFdIjyGwerShxqpkbOgXzvuzZdPjYitMpfxgCwK8U
X-Gm-Gg: AYBFou1hPv57PjWOc16MOGlvpyUqowzWCIAxOa0ISFzD90rAncgVcugyxdV1bzzCY93
	xq+hbbfWQbG9P1BtzQchJQWZyc/JfupA4PWouahB1Yggj3JUL5pfeaPeo3SNAB3Z8iaw0K4+1/t
	Mw3Pana3YtVlEhRVl690VBc7ZNmeJ3DbF3mWNDuKwqluyimpzp7lxlss5g1u/4L0iKGE+tuMKrl
	MJtw2sb2UssNTLTm1LiiUjHXC716fm+xPzMOYO5A3QkM7SyCxqzNxd1hWySeE/3oW5wUOQLz0mY
	FRHhhgO/Fys8xlmdgtJ1wakbao4mGfNuc+jRfo0YRkVh4wBnN9RekPybnI7yFPmoW3SZk3LAlAw
	/skpu2ZNrAQVrR6oCQCFWNawVddoPQdgHE3q1C9BvmkmMCJgt9k8EyX7VuRr0EcnmJUulHZhGK1
	kQkcr3OW/Nl62lT9ZBZH0DpRf/IRlj5dwHzBEIGd2niCRU0c80zOYOf8u6rdfb12cJccRAx/K7w
	pf42vJrtiP0wSICr5vQgmLEaTuk4czjD51Q5fINOgBLfmSBm3EnxhM7q9IKBeAGF+RWJl/ZQXht
	+PUvOaRIAFYJ1PwnsZBvnT9MH2XChMd3RiD+RsPcRNbSVEgM/Kfri8syUi+SfVYdGvJiC1BbpNG
	O5EFWK/N0hSsOJat1JU/uRpk1f9P7FMaqfQ==
X-Received: by 2002:a17:907:86a0:b0:c41:b94c:4538 with SMTP id a640c23a62f3a-c49bdf84407mr432048766b.47.1793270364216;
        Thu, 29 Oct 2026 03:39:24 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e995dsm711863366b.25.2026.10.29.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 08/16] ovl: do not take a name snapshot in RCU walk
Date: Thu, 29 Oct 2026 11:39:12 +0100
Message-ID: <20261029103913.2785828-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

A path lookup on an overlay over FUSE loops in the kernel for ever and
stalls RCU.

take_dentry_name_snapshot() needs a dentry that the caller keeps alive,
because for a dead dentry the refcount of an external name stays at
zero and the function retries without end. In RCU walk
ovl_revalidate_real() holds no reference on the real dentry, and the
eviction of the overlay inode on another CPU can drop the last one.

With a delay in ovl_revalidate_real(), a stat() loop on a 48 byte name
in an overlay over FUSE, raced with drop_caches, spun for ever in
take_dentry_name_snapshot() and stalled RCU.

Fix this by using try_take_dentry_name_snapshot() in RCU walk, and by
returning -ECHILD when it fails.

Fixes: 5be1fa8abd7b ("Pass parent directory inode and expected name to ->d_revalidate()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use try_take_dentry_name_snapshot() instead of open coded snapshot]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 18f56d463572a..cc4b0959faf61 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -100,11 +100,17 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 			dir = d_inode_rcu(parent);
 			if (!dir)
 				return -ECHILD;
+			/*
+			 * Nothing pins d in RCU walk: eviction of the overlay
+			 * inode may drop the last reference at any time.
+			 */
+			if (!try_take_dentry_name_snapshot(&n, d))
+				return -ECHILD;
 		} else {
 			parent = dget_parent(d);
 			dir = d_inode(parent);
+			take_dentry_name_snapshot(&n, d);
 		}
-		take_dentry_name_snapshot(&n, d);
 		ret = d->d_op->d_revalidate(dir, &n.name, d, flags);
 		release_dentry_name_snapshot(&n);
 		if (!(flags & LOOKUP_RCU))
-- 
2.55.0

