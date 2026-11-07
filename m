Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070379;
	b=0gH1zmyeyuG1IvuiEbqwmbxOPY9rSlUi2Wu2smkwnvRVkzmWYytc4YVpf8KPk8HcwWSj
	 YFH9W2l/J7LT4IgqERN+txtUsCWayRgoaZtBcQNwqxPrCMdJUKdCfk/Z0t0mP1Ce0nu1E
	 nxIi6ELQbbRLNubyYe5sTP1xck0lqgAI4vlvG3L3qkAG+wT1MlWZvZbtK0QAb64xs2yS1
	 znmq4guXDmgtrBOxH3e2fY2U5v51J/xweAAAENcRLXgncnRqBfg6tuHOr7pq9ysLnhR8a
	 u0lpIq0m55GzhUqRix2iOuPyH9HFAi+DOzwQlLYnxLKkI9s9fM85Av6cDwwKojxkPYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OX53f82pg8rAzuHCIXr3W8ktDCdjNfY0YDDamqZGbzs=;
	b=NVV0s55Iwa+OBNStgXP6jznHgF5a85BS1nzBAKSU/eoK2GIy6C11qJvUilwrXA1A+My1
	 TnYmhhFJftP2PFTrhPaKyftQ5LEc0KP4pH/bz6FhNywW92bckrniJYaDUOLAn7Fc8VHqZ
	 hcMD/MU23QM3MqYVr3kyJrhjgxXeGgIK9x0J++4V2KMySq8lmSulnwPB6ohmDb8k4z0xh
	 7ygifE1VT4OPNqy3wJ+bZGb4XclSfUrItRbrMq5UyhTl7hDpyNjAL1943ttulVHSaikdk
	 Eg7ZfHQx5dNBJ7LiM6lMEsTNzvirQpGpw9QKq6sUkiGP3xtCXq6T10R04KcDbxGBMWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l20rkbso;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A5606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94A5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l20rkbso
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso70617a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794070377; x=1794675177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OX53f82pg8rAzuHCIXr3W8ktDCdjNfY0YDDamqZGbzs=;
        b=l20rkbso1w2CKDV3qqva9CCmi8ZfT3r/ydjSwEyT28X+YT1e5HxNbk0Lei9pLEtMOR
         1AGRqlEw80l3VG2EB20DfZPTqTqhEsickI/j2cz1mrVF0wOQ+EQL3oK2CbFW9f8wIyPJ
         OfGg5NO9x/06OsFBhKo8Z968v91WsNhlei4xq6tzglGViwwmOwSenspTgRlSxD/0w8SZ
         GXJy0CaS1QI22z29LYBUqbYCJ4XJMyilbxYisyiKvW+q4J+g3oi14o5iTdjjg02mt40O
         PGjSX0HKu966FX69A5+iobmB+2+z7Iakh9pJPHLMfaKGy8E4L/H52zyT4Ukt0G8toSr3
         UZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070377; x=1794675177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OX53f82pg8rAzuHCIXr3W8ktDCdjNfY0YDDamqZGbzs=;
        b=CD1sq7BZpVe130esb1LgiWBz5hyw90kGZ2zXPyU2iG9S6+OAkY6GkyGk9vyGhsRRnK
         HQDItWSc52FV+GXscwFKlnWSXoMUAzKYdPoXSeMue5IjP6tgfQIsQdIsQ939WX+RUUHS
         FoGy5UU0s9F4+oKjlSPbZurO2rKN/vkxtKBffRRAG5KgPWsPQm5BHv6UrLbfDnQJ5iAw
         HSIOKHC5nt4Rx2U5DXAax5crupJTVoeUqYG4TZCQx9YmgoaVAogq6N0+JfUvyYJK1iY2
         KDR9SqeixpPH/zzZLPCAe7R+D/atWupXtQ483pDLwZTAhcLCVpa/gvVHKTqF31cbM+7L
         kAEA==
X-Forwarded-Encrypted: i=1; AL+hErEMhyNN9I44gozZ8ZNwJ3QnSGs+ZI/2QPnE1rcvH+pvQzIIFEXkMqKWDh2Wbpy7R8OpIOHkrr8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XkGI89bucTtZpQrwGV6YKxYai4eiSQ64snphAyWKDkEYVrSsG
	41edrRul0izTSgqbZZ0yIEbW6YdqdZ1CVR3HO+UYyIJEFMu5oRhg2jAhl5c/2Ipa
X-Gm-Gg: AYBFou0Cf7BhFKZLD3fmjVORBvJn6pLckrrEo5f+myzU2p5R3Vih40xxJcwMfIzfc7G
	UzK4XiiZFY5aaXWXxESdPzJ5B0rCP6vAQvYqv24km5aJcrbOLs/VZkoaDriNjKsmtYWsnIyjcdG
	A1sWk5gqcCxeGMLysMvxUGvr5FvMjzcKKItJowEEBgAbWcbiSfQJdtvXWWIMCQxGllyfYqXBrjq
	3MQrmVt2n5YvV+PzRpaqmPy8J9X8tvrS0/93bVOyD68fxmFfw6DFl0WaP364XlKQqSeoDvseyR/
	RZDden0MY3KxLfZbrRDF4g2ce82eeJGdIoH0QD7emzf0WO/IwNSNV0KeMHXkyEPHkW8Rz8FcQS/
	QD9Pj6xHPFIIr3K0l32NeN7yQcs77pBAll8Td/sR8yZmWaCxQa+O0L1z3kAQa4Qmezp9rkBEK76
	HKpiSa3pgBvby1QaSKEVZE7FWDK2eSrN99JvgcKO94nPtpFRpqGkO10ek/Ws9eNR9UrTEMOFUw/
	cgtzjf2X4NgK54b2nTTDNNICwjFMPFkLul5PfiyTt0JfbE4VcI6MvLU5tdgPBPA1WiI4Cd8UODs
	JIDVvPbwvw1zinEEszgqbd18AAoNHswXMSBrDVESwesIZOfLLFGHse3dpgsa5BYXoRt4O82D0IU
	ILCXt5FDj1YhXrlQmyFW/653hgO231UXL
X-Received: by 2002:aa7:d987:0:b0:6ab:6e:a8e4 with SMTP id 4fb4d7f45d1cf-6b5978378a2mr2719660a12.44.1794070377007;
        Sat, 07 Nov 2026 08:52:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b65d6b3811sm1908827a12.5.2026.11.07.08.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:52:56 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <giuseppe@scrivano.org>,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ovl: do not check the deferred lowerdata redirect on index lookup
Date: Sat,  7 Nov 2026 17:52:54 +0100
Message-ID: <20261107165254.3989119-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107165254.3989119-1-amir73il@gmail.com>
References: <20261107165254.3989119-1-amir73il@gmail.com>
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

When a lower metacopy has an absolute redirect into a data-only layer,
ovl_lookup_layers() defers the data lookup and skips
ovl_check_follow_redirect(), but leaves the redirect in d->redirect.
If there is no upper dentry and a sibling hardlink was already copied
up to the index dir, the index branch calls ovl_check_follow_redirect()
again and, with redirect_dir=nofollow (e.g. forced by userxattr), fails
the lookup with -EPERM because of the lower data redirect.

Take the lowerdata redirect out of d->redirect at the point where the
data lookup is deferred, so that the index check only validates the
redirect and metacopy state of the index entry.

Fixes: 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for lower -> data redirect")
Closes: https://sashiko.dev/#/bug/linux-29bea9ea-5376-4e54-88f6-04dabce4db70
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e25858c8dbcd7..b7fb5bb2e597f 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -27,6 +27,7 @@ struct ovl_lookup_data {
 	bool last;
 	char *redirect;
 	char *upperredirect;
+	char *lowerdata_redirect;
 	int metacopy;
 	/* Referring to last redirect xattr */
 	bool absolute_redirect;
@@ -1250,6 +1251,8 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 	if (d->metacopy && ctx->ctr && ofs->numdatalayer && d->absolute_redirect) {
 		d->metacopy = 0;
 		ctx->ctr++;
+		d->lowerdata_redirect = d->redirect;
+		d->redirect = NULL;
 	} else if (!ovl_check_follow_redirect(d)) {
 		err = -EPERM;
 		return err;
@@ -1366,15 +1369,14 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry)
-			oip.lowerdata_redirect = d->redirect;
+		if (d->lowerdata_redirect)
+			oip.lowerdata_redirect = d->lowerdata_redirect;
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (oip.lowerdata_redirect)
-			d->redirect = NULL;
+		d->lowerdata_redirect = NULL;
 
 		ctx->inode = inode;
 		if (ctx->upperdentry && !uppermetacopy)
@@ -1427,6 +1429,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	dput(ctx.index);
 	ovl_stack_free(ctx.stack, ctx.ctr);
 	kfree(d.redirect);
+	kfree(d.lowerdata_redirect);
 
 	if (err) {
 		ovl_free_entry(ctx.oe);
-- 
2.56.0

