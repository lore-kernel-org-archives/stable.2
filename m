Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890462;
	b=NqXBuRlbc2uHBfT6Z3pvT/RY+2pAQTiX9oD4lmSSHwRkfbNMofTczB6QMElAZdQZzhET
	 KdQcQDoSwPSmHvUPmsICJ26HtLCCtMMqTs2mtdDfhg3v8ubw+nN1YGkz45E/0SJ0xWv6N
	 xbuVgjo8EF8V7i5im+N40yUhnYQ+BRD7/tIQNH2CN37JB2ZI0L/1o2gzP2icvNlGDI80R
	 vdkcki5VPdpW6zJSyses72JO4yHy+7c3ohP7eqg81KqNEtXIoUcl0I/LkYpk8EiRypZfl
	 6HdI7CFdfJqeaLA2D2IrDbVsL619Lgupn3maZO53q3QwhunpcmLSPqJcj/q42fsUEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890462;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KDmDo1zIwKf1kDoo+5UfHTTv0nqQmqvncVjZDKBfgtE=;
	b=i0jtfSR0txBVBUwC08iDCPnpcxHiBVsY2bvAMQXY3xpLSna3BCq5UUXcWl3kEIn70YjY
	 QvOcGNfF4Ns6QYXf+T/f8iR4ZL16TL8da3DUhDVO+OKiWB43xq11D7YAvrAPZEoAqjoPM
	 2F0t3oJBWkBYPzCrumiBdpHOuXxtjkYjnGdaefrsDWZfrhNETLE5NEeeutzDymY8MF51u
	 oyi9pV9CDpfWYkctmiwgJ4pUDRvrGX7sEdwzrOe6AXXwBAdZxmsITZ3zvp4FxZH+sdPpz
	 6AbvPN62pVFthxpsptH5VmzWYOnqNy2nsaVBGlHhNizo48ZX0VX8/7KW4mH1gdEPH4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="TplfSrd/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rI31Aho1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8965606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8965606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TplfSrd/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rI31Aho1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793890460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDmDo1zIwKf1kDoo+5UfHTTv0nqQmqvncVjZDKBfgtE=;
	b=TplfSrd/XJ6hJ8gfrtecSiwimzs1UI/khQ0QUj+TTvUEMN36Ty1sxla5eIZWuIkEjvMpWn
	gmHA5TTdPIzcDCPXAIa8J396yTvKGP15zATa2MXGYE3EK8jnhJDtuAHt5H2R5B6CBSln3A
	8w/LskK1iQzZPxvbzJeQagyopsfZl2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-jmJlFoKZOa2TqFyEzL74iw-1; Thu, 05 Nov 2026 09:54:16 -0500
X-MC-Unique: jmJlFoKZOa2TqFyEzL74iw-1
X-Mimecast-MFC-AGG-ID: jmJlFoKZOa2TqFyEzL74iw_1793890455
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso1520199f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793890455; x=1794495255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDmDo1zIwKf1kDoo+5UfHTTv0nqQmqvncVjZDKBfgtE=;
        b=rI31Aho18kcB7yUQx/DtzjdFtd43smlk2mYpoD+NUCrMBC4UkqZYMQ1bzuHhbrGH0Z
         eV2s1dwk9a4DSynWlVPpwLMFvyNa9PDSGMITCUiDNwgzSqDjeU3kjYuV74o76xEFYY7d
         2uuNjXwbNho5St4lrI7TYFAPsE8hXoXW8bRQa6ZW9bfKPGvXMMGDNOqp2BWQu83ArB45
         gy921T4sbN3dU/2VQLWYWVKE8k7odE+yW+GK+4gygRJ7U7pj33iUJEo1z67lgsMz6zRN
         fMB4VSIvSsNn2o+jgbBy4ncn6d7kCEjxeQO2M/UhGeUZpia8mEYZ6led6Xgbs7xfI3ZH
         SICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890455; x=1794495255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDmDo1zIwKf1kDoo+5UfHTTv0nqQmqvncVjZDKBfgtE=;
        b=zDNemn+Jk0uifpRtyRXvLgUUHLJi620gmXb73/vK90P1M6ZLqguuP87/UARND06VcK
         oOzY2oQo0VdVo/31e1tpAbb3hNjebo+2CJgnkZsl/X0XZPOYh0T9DXhGfWp63Y9mKAsv
         5pCHehMqUtamjppCC5ojT+LWlx4KwR24FAwvrwAr3MoM83Y2SVEn0mf+M74RN2MfjLW8
         /hLOj63x6tf9nnMIRiPQCc2Evv0IJbnBiLLa0u6neAsDcF6aiB3awTYiV4SD9zOGeEeX
         ytW+5gZbNwAXFFLjeK9XNm8Q6wczH7yw22VUZrN3qDgbBI2m0Nkoy8Xn7NNziU3m/k/3
         h3fg==
X-Gm-Message-State: APuU4Z8RsIE+IWYOh/QCQsl/vkcGHp6Ms7fhcUFieSeYM63MdTxAzQHn
	+rw96wXgb5Fu/+ZHsmOnBzBjNyvhqab8TzAFxnooHF/WVbWTtMLg0UDnMYjqZkR2+TJbGLXgHJT
	nrYKc9XgM5i+1UYh9V1o7IQLZuSlc4TIs4jg3Sef5Xox0HEe6BVJ/8D2VtA==
X-Gm-Gg: AYBFou1PWDz5n/DN72pot/LBR+A6kAtb9iwxaILwXh+MgF/OmjFORhUlqfv9PzxbomG
	qvPuPqr37z40IpQrogtHOchd1Q4OUpL3MQhz0bZm5g41NufQCczbUxQtuCyX59+ccVWmB7FfuN+
	KkaHGIPtOWx5AFkUmx9T08PGjTbWccygQq3hi/qcPm+k115BRRj4hGa7Vf0825jW8GX4A0MQ/mu
	U+0iFOqY00Xhts9AcTzljBr674k1VCmIGAdL53YmzRgdVV99zKwa/LnyK4lbOKSU0u29S36y0xX
	eLe50YOd90lH7WY0jGRXca9uTAuuYIoBqCUZONvlvFxZFznMjmn5ztiO32nqdC8ujKSMeWohOIY
	R6d4FJpj0YwTsAxJ1+fJdFw9bj1EfVuU69P8r+R6ryf+SeUAy7Q/OJwO/og39rnFZFO6WhW0vCZ
	zcYHxlknmjZnZ7WqvznIKOHbCoKizv2a/x/OmYulE5V5M=
X-Received: by 2002:a05:6000:4311:b0:48e:20ed:d5e7 with SMTP id ffacd0b85a97d-48e6e2ff167mr39495595f8f.34.1793890455372;
        Thu, 05 Nov 2026 06:54:15 -0800 (PST)
X-Received: by 2002:a05:6000:4311:b0:48e:20ed:d5e7 with SMTP id ffacd0b85a97d-48e6e2ff167mr39495569f8f.34.1793890454978;
        Thu, 05 Nov 2026 06:54:14 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (188-142-154-142.pool.digikabel.hu. [188.142.154.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed08536dsm9296429f8f.32.2026.11.05.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:54:14 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 2/6] fuse: fix possible UAF in fuse_direntplus_link()
Date: Thu,  5 Nov 2026 15:54:06 +0100
Message-ID: <20261105145412.83058-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105145412.83058-1-mszeredi@redhat.com>
References: <20261105145412.83058-1-mszeredi@redhat.com>
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

In fuse_direntplus_link() a use-after-free occurs on struct fuse_inode when
linking a newly allocated in-lookup dentry during FUSE_READDIRPLUS
processing fails inside d_splice_alias().

When d_in_lookup(dentry) is true, fuse_iget() returns an inode with an
incremented reference count and fi->nlookup, which is then passed to
d_splice_alias(). Inside d_splice_alias_ops(), if the directory inode has
an existing alias and splicing fails with -ELOOP in d_ancestor() or -ESTALE
in __d_unalias(), the function drops the alias reference via dput(new) and
unconditionally consumes the caller's inode reference via iput(inode)
before returning the error pointer.

If the existing alias is concurrently unhashed and dropped, iput(inode)
drops the final inode reference and evicts the inode immediately via
fuse_evict_inode(), sending a FUSE_FORGET request for fi->nlookup and
freeing struct fuse_inode via RCU. Because fuse_direntplus_link()
subsequently checks !IS_ERR(inode) outside an RCU read-side critical
section, it dereferences the freed inode to acquire fi->lock and decrement
fi->nlookup, and its caller parse_dirplusfile() then invokes
fuse_force_forget() on the error return, issuing a duplicate FUSE_FORGET
request to the server.

Fixes: b8bd342d50cb ("fuse: nlookup missing decrement in fuse_direntplus_link")
Cc: stable@vger.kernel.org #v6.6+
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-0a00a32c-3732-46fe-9cdb-3c67a11903cc
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/readdir.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 295cbd645653..f4f9590f8ae5 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -236,9 +236,13 @@ static int fuse_direntplus_link(struct file *file,
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
 				  &o->attr, ATTR_TIMEOUT(o),
 				  attr_version, evict_ctr);
-		if (!inode)
-			inode = ERR_PTR(-ENOMEM);
+		if (!inode) {
+			d_lookup_done(dentry);
+			dput(dentry);
+			return -ENOMEM;
+		}
 
+		ihold(inode); /* d_splice_alias() eats a reference */
 		alias = d_splice_alias(inode, dentry);
 		d_lookup_done(dentry);
 		if (alias) {
@@ -246,15 +250,15 @@ static int fuse_direntplus_link(struct file *file,
 			dentry = alias;
 		}
 		if (IS_ERR(dentry)) {
-			if (!IS_ERR(inode)) {
-				struct fuse_inode *fi = get_fuse_inode(inode);
+			struct fuse_inode *fi = get_fuse_inode(inode);
 
-				spin_lock(&fi->lock);
-				fi->nlookup--;
-				spin_unlock(&fi->lock);
-			}
+			spin_lock(&fi->lock);
+			fi->nlookup--;
+			spin_unlock(&fi->lock);
+			iput(inode);
 			return PTR_ERR(dentry);
 		}
+		iput(inode);
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
-- 
2.56.0

