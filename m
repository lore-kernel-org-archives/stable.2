Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055715;
	b=43+dqNASFq7AEfD4/S77kaiiC9xjX5W0bUZrPB8wFl86pQ7WgbISQ50w5AvDDtp+X28n
	 lBNxb0VYFSo1LLEnkxQYdZD/vlpActfW9kv31q/YKWVppa7mfbbWJ+Tan9qyAEV7jQ+4L
	 9nWNCWrYcfQC0qnwQgtTZRcNp+D3jTftrp9rHS7jtQTyJmhN38MX5PtTnWttYxPZu350z
	 IShvINb2VSXiD0UXN3k7Y7wuxpEssEF55WxL2DbqYHcuTty9J4ZlGFX/j+E61bNNBWpnQ
	 GpPLtzeJllqRVKNNiaNaBY0PS9DZKcoyIsTOxuBvO6GteCtI6A/AmPTHCTa5Jc/kHGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c0h4dPwM7Lc2ThvwHjpwKfbW4C8bAJIrwdRbNwJK6ik=;
	b=u2dl6V0kfb+oSFhZD7sDUtH+bCFOHPx7YZJdelezy0ofXSWquxyfaR5T4qnhRPG1kKvz
	 STqWr8VfdBMNAmF79iTFNOp08C6QDK/2/gOFjP9ngNb2xYL95ieJGyAnKCn0LjfOsR4zO
	 KsapHhindV/SU1Rym0VFK2mNCTeYmmcxqL98HroNgE6izXMHMJxwoEhNf6VfKWbaI5Rn/
	 uyXDj3gfJ1BlsOVIe8VDVdQSjhefGyk6TkRrZqwaJ3PmmMpJ/04/sOO5/p861ayCpGnN+
	 woSA+x1crs8lr9qAER8Q4wm1OBW7eYpGGRabcoRFG3lntupRR7P3FDpsF3d78kUQrVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJA4LueD;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABA606A327
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83ABA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJA4LueD
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20edd106so3048058f8f.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793055714; x=1793660514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c0h4dPwM7Lc2ThvwHjpwKfbW4C8bAJIrwdRbNwJK6ik=;
        b=JJA4LueDcJQO8MY4dVrb5Xb2+MSwjo5dLXPT75rPafojjir+k/OsWyG9+UrwTdhM+9
         pKIl0y/fpvExNndABZxIiVys+KKNt2agaeNb6vvMU8F4PMbPB0p406kPxzNBlu5s4sf3
         PFHyAnGP0t8N/Wuvna7ENMT7wsaLxaWJtoz1KE4ykuQGf1/cLEngOiapYlwtyNA/g4UA
         5eyTVqY4UTDfu0FyLphVkWzZdthBj2C+CoAM5MtYMrypUXtWIl9rmk51XucuQ/zYlbwE
         NpWpWL79pg1sYXtLkeAR3GngK3Pq2LBqDj8tsiPQ1rTO7z5ox3PMlpvgnZyNG8VYn9BR
         Gz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055714; x=1793660514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0h4dPwM7Lc2ThvwHjpwKfbW4C8bAJIrwdRbNwJK6ik=;
        b=s6EEzEqg64mfbya/fcydluY5qcjek/Uh1v7ENDk8zg2uKKW+FDoxq3SjAolZ8OzBUe
         BqPTgGTH1Ui43vhvBtKx4+3i5wC+KAuVSotJVP1g+b01devuql0Rq6lc5GyUWhEpKJnt
         1a/z48CMMeQCYSNWNjuuPnU8pvMFLhZEvpmQ2PVZmG+g+QwHuW0ZAyGYXToCLJs0AQXg
         rS4UUpVBvOb5ku2BTqsn9A7F+9rCbPTPU2QPL7Q4OfDUmAXIaX2s/N96NDROf2SFpM3H
         h4EZSf6llTpaaJsJtRisoY9sb9vpwLThO1mSDWshOcgH97uGDWNksqA2OeI5pL9iNhQS
         QdQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYJHEeYKYULNaSk3uWCE8Xw2w2pLYaZbD5fv7JZV1xdUMfHN05wqCNEJ2ULakjRBKdg+vgiZw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW0pyFUtpfkGu1XswBAFLRTOnIW4XBswr2g0WwLRIM+/oqukBj
	q7BmAmZFT4DOpV3a7A0Jkl7i6qDzCgF454G06GzSkTUUY9k3obPSvBk=
X-Gm-Gg: AYBFou2ZwDXyhWHW2MJoOp6P1i1ntSU43o5JrH+XIYeyMnpqvPTBoIf50KLV8JkwRpr
	gXdEn3uUaqpyNEPL6NHM+JmWOBCGb+GnU5pDpybfH1+8Hwo9gAqCAIwI9C0CmSIvFixT/z/xapM
	7w33ngnlHn7QPu8pv8B3e0B/Pw4ak0kpheBSpTmwYtK1a9pVHVHfsuakNyvKkrf8psqT1WrNDDR
	3SgBIPfevWmUUNa1ms+47HhkWBxy0mhaANayFZEmZmR4SUFluMtRcAvZWTZGid/EAPCXZFa1XPb
	I3DJqdQs+bv+kSWYpOPNXAOYPqKCgc/h7epNdTzk9/2FeIscOd3eTe9UhPcordy+0NcWpUPi2hC
	HTpcjoeula5RXosTtrrC2VUYmCkAnS40CqrYqAsAvvj6JxyaprHxr0/07VM/g/87SNym0MquFhG
	n130WBBve2sZnFcGWLFDBpxSeq77/gn6scYaaH62gymenJialY9l8e6caccj1McRFeJEiFIvun0
	q0TpNJ/bfCvn4danbEHTgvmBRA7hqbWamgVLQ==
X-Received: by 2002:adf:fe8f:0:b0:48c:67d6:a87a with SMTP id ffacd0b85a97d-48e3eb8bdbbmr11263342f8f.32.1793055713530;
        Mon, 26 Oct 2026 16:01:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb40733sm14827198f8f.0.2026.10.26.16.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:01:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] nfsd: pin client reference across async copy reaper cleanup
Date: Mon, 26 Oct 2026 23:01:51 +0000
Message-ID: <20261026230151.2474608-1-tristan@talencesecurity.com>
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

nfsd4_async_copy_reaper() detaches completed async copies from the
client list and later calls cleanup_async_copy(), which eventually
drops the stid reference via nfs4_put_stid().  That path accesses
stid->sc_client unconditionally, but the client is not pinned during
the cleanup phase.

A concurrent expire_client() or force_expire_client() can free the
client between the nn->client_lock drop and the cleanup loop, leaving
nfs4_put_stid() with a stale sc_client pointer.

This is the same missed pattern that Chuck Lever addressed in seven
other nfsd4_laundromat() paths with cl_rpc_users pinning (v7.3-rc2).
The async copy reaper was not covered by that series.

Fix this by:
  1. Skipping expired clients (cl_time == 0) during iteration.
  2. Taking a cl_rpc_users reference before moving the copy to the
     reaplist.
  3. Dropping the reference with put_client_no_renew() after
     cleanup_async_copy().

Export put_client_no_renew() so it is accessible from nfs4proc.c.

Fixes: ac0514f4d198 ("NFSD: Add a laundromat reaper for async copy state")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/nfsd/nfs4proc.c  | 5 +++++
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/state.h     | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 50c07561e31f3..1f36afceb1fe1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1501,6 +1501,9 @@ void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 			if (test_bit(NFSD4_COPY_F_OFFLOAD_DONE,
 				     &copy->cp_copy.cp_flags)) {
 				if (!--copy->cp_ttl) {
+					if (clp->cl_time == 0)
+						continue;
+					atomic_inc(&clp->cl_rpc_users);
 					list_del_init(&copy->copies);
 					list_add(&copy->copies, &reaplist);
 				}
@@ -1513,8 +1516,10 @@ void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 	while (!list_empty(&reaplist)) {
 		copy = list_first_entry(&reaplist, struct nfsd4_async_copy,
 					copies);
+		clp = copy->cp_stid.sc_client;
 		list_del_init(&copy->copies);
 		cleanup_async_copy(copy);
+		put_client_no_renew(clp);
 	}
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9c4adf3110aea..10e864ca7407a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -252,7 +252,7 @@ static void put_client_no_renew_locked(struct nfs4_client *clp)
 		__put_client_locked(clp, false);
 }
 
-static void put_client_no_renew(struct nfs4_client *clp)
+void put_client_no_renew(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 2d00a411c6634..1d3a7e35bb9ff 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -918,6 +918,7 @@ extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 void nfsd4_put_client(struct nfs4_client *clp);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);
+void put_client_no_renew(struct nfs4_client *clp);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
 void nfsd_update_cmtime_attr(struct file *f, unsigned int flags);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
-- 
2.47.3

