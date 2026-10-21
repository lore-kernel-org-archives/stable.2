Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597661;
	b=LYYrTOA5rbq6L9xIzCHmj2ejPJxvRTzI1MTlOQihGGJxe3XU/qhygNsv8KeLv9mj2cvJ
	 kdSIhMiJZh78Rpe06bYIvmQUGZTN2LfTTgGU5raDouRZFXYsNG7UdVe0dwDAetfDypdRk
	 cpKQon0v8rM6JzFZGfSxjx/kkk7eEIslNnIgI5p8QbrpiudHBUuW4xDcSw6v8gL0zIDK8
	 nzU8xx3rIIvsVSKYXMgGFXMcDvN8tyrsYEMUBXue52HWUER/NLIxCKPGRfc2SVWEf80m6
	 H2haEGi/MkLMVdpaXso6na3HnDjhaADOosJodnb7KVo7RC9JJSDVmmSQPVfuOT5GCnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597661;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=8qgA8w2sH2bh3z2kNuYay7MeLSP++FG6E6X3KcotEQA=;
	b=l9GEXkY5Co7b2IBVgw2//h3P6HOgVunSjajgEBq+DcW2MDJlbpHNQe6oo3kmq3VhNDMR
	 clB5xb4Egbmi9r8hPX5VCTyrFEcK8HjdrYzHFozOvg95Dqq+jFua2HqrYd7vxSjipnOG+
	 jEiRrYyaElCDJQccRZvvDq9Rs+ulfpXdP0LDNIwH0DfrofnKXJFMr0f2mpLxW9BD5gyQN
	 u3IhAxwQukJx1V3wmqd7qIOlOqn9ItzNjzo9it+RqFAG9nWsiuI3NppdtqMMlBBnYYVge
	 H7RpaEzCOGKKNubq5+/7P6Emjc37ihx5xo6tEvMBHy2lSBejUbIlatI4w8nlWawbBLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bx9mWcma;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD231606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD231606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bx9mWcma
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792597659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qgA8w2sH2bh3z2kNuYay7MeLSP++FG6E6X3KcotEQA=;
	b=Bx9mWcmaWha6NzfnaDQyzjsGLPrrETd7vpg5wmSqbl+7LkSDwySv3HexqM6SD/aE/iOZ5H
	EL/VEkCPwj90AuaNACM9Gggj0XgXSqodDn/uoa6NR58Z0k1KjMFr/z/VTNFYu5BbFP/WSL
	1gqkkyoGszzeNOSbJ6udVEvrCZDvQWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-sv1qX5g2NYa-Lyi2M27u-A-1; Wed,
 21 Oct 2026 15:47:37 +0000
X-MC-Unique: sv1qX5g2NYa-Lyi2M27u-A-1
X-Mimecast-MFC-AGG-ID: sv1qX5g2NYa-Lyi2M27u-A_1792597656
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A931018004D2;
	Wed, 21 Oct 2026 15:47:35 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FD3B18002B1;
	Wed, 21 Oct 2026 15:47:34 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 5.10.y 02/16] ns: Free anonymous mount namespaces via ns_common_free()
Date: Wed, 21 Oct 2026 11:46:51 -0400
Message-ID: <20261021154705.2737365-3-loberman@redhat.com>
In-Reply-To: <20261021154705.2737365-1-loberman@redhat.com>
References: <2026102131-walmart-preschool-d157@gregkh>
 <20261021154705.2737365-1-loberman@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Christian Brauner <brauner@kernel.org>

free_mnt_ns() skipped ns_common_free() for anonymous mount namespaces
(the "if (!is_anon_ns(ns))" guard) because they carry the reserved inum
MNT_NS_ANON_INO, which proc_free_inum() must never release.

A following change needs ns_common_free() to run for every namespace, to
release per-namespace state attached during __ns_common_init().  Move
the reserved-inum decision into __ns_common_free() and let free_mnt_ns()
call ns_common_free() unconditionally.

__ns_common_free() is shared by all namespace types, so it gates
proc_free_inum() on ns->inum > MNT_NS_INO_SPECIAL_MAX (a new alias for
MNT_NS_ANON_INO) rather than the mount-specific is_anon_ns().  The
reserved inums (MNT_NS_ANON_INO and the *_NS_INIT_INO values just above
it) belong to namespaces that are never freed, except the anonymous
mount namespace; dynamically allocated inums are >= PROC_DYNAMIC_FIRST.
So the comparison frees every dynamic inum and skips exactly the
anonymous mount namespace, matching the previous guard.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Co-developed-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/namespace.c            | 3 +--
 include/uapi/linux/nsfs.h | 1 +
 kernel/nscommon.c         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1ecd96c918b3..8d4009cfbf5b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4193,8 +4193,7 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
 
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
-	if (!is_anon_ns(ns))
-		ns_common_free(ns);
+	ns_common_free(ns);
 	dec_mnt_namespaces(ns->ucounts);
 	mnt_ns_tree_remove(ns);
 }
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 007fed5971b4..e5909266ec3f 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -55,6 +55,7 @@ enum init_ns_ino {
 	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
 #ifdef __KERNEL__
 	MNT_NS_ANON_INO		= 0xEFFFFFF7U,
+	MNT_NS_INO_SPECIAL_MAX	= MNT_NS_ANON_INO,
 #endif
 };
 
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 3166c1fd844a..e6f623e1bc37 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -91,7 +91,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 
 void __ns_common_free(struct ns_common *ns)
 {
-	proc_free_inum(ns->inum);
+	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
+		proc_free_inum(ns->inum);
 }
 
 struct ns_common *__must_check ns_owner(struct ns_common *ns)
-- 
2.56.0

