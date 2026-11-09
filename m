Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217385;
	b=X4Twxp3p6W3mJihTGJW6h4QqiVKZYhAXi9fw+9hjwbMgPoU5uoQKJQ3qIprMx0cs4/DE
	 fH6NIJLjsux35vs9AqPesYNbVdovVpOzNS0LCr9P0pdny+1Rf7cWzEhfXM82pUjw74MBt
	 uOj56LAvlkUhzF64LAM2kKuOU0i32pNTgOWcRUw442EcXRemdCVh86m/JsjvXC+T8YWX2
	 VKJJFG2dVpuVEv2GJECUovL3Y9I8OAGh3YQGxqbQ6s02Jbul37sqwRyp5nyKwhp0UwMNE
	 Z4eFBz/E+UINXnyCvU5lPAgAqifUbEny9nsmGYaaYoAMcunkhg2PczRdthrXhjYsH0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gqkduDJsU90RYsspBtEDgzAr8laZJiGJQKiyzYsJO0s=;
	b=BI0x3ev17CIgjRxdeC/mBAQNjSG39asip+vMSV5fCS5Rn/6oWu0sSlz+SE3Q6XAyJZi+
	 yp2nPAhAGwSRL8Rw9MwhihcL8a/XX4NA1doeZFcnPcUQ/cXAR5FmQTp/AhwNJ52uNl1EL
	 QBKKO56zlmJdy0htLX0IirltkVbcY96SzOYWS4fqaWw/YAh1URw6vvV7CflW6yvIf+Uiv
	 SBSFiQNcbElHZPuLb5iP3pZNRHz7glMaD2QbPZKdoYZD60VbIicJc5ppxVVwW4QOIrr6S
	 +xWPPGsNg/80rShk5gHGYg1cqFcj09jY4noJMKz02s9Gv4bS0Ei3vPkM7vUY6r68Ibg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHWq1h8k;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52563606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52563606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHWq1h8k
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso241348eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217383; x=1794822183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gqkduDJsU90RYsspBtEDgzAr8laZJiGJQKiyzYsJO0s=;
        b=qHWq1h8kuhl8AnKXCghZeFn5xVLptWCV/ciN7hxaj5pXpeSOCQxm8wsMuipKyOPZwA
         PfR2oEtDNbO+wRHq8IpdTgYmyxXk3mWbaWHHdy893/JNZxhMWuUL1LzXHhf607xQQ1bE
         mDlbhIJTCEFXBY2s54BrA5Xw4TemH0YB1aIjQmSXesWrL0PE0d2qksQX92gZXSaFAMSn
         uOMFoHxqllV0o1N3oKtjoHIsWTnqHA8PMlrxzNXZTvwt9HCu5SEHhZVvFZCm5CxivgPF
         2tLebjJr+Dg9D1ijz7P/+9id1mlghHRBOgh+jfsF74RDO1wAx+bAqjFtl+wivzHo3kEC
         N0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217383; x=1794822183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gqkduDJsU90RYsspBtEDgzAr8laZJiGJQKiyzYsJO0s=;
        b=hbTzamrAc18CLTexJcBQz4jIINfYuiT2xGEhE/3XF1AkDKXJLY7fpu6eSrv+sFxkU9
         MNtLhGzL0PTOGTTgu/imQRV2fov55T6NFeGr7kxy0K9IrAPZf0TvYL08RHw58oiY84Vm
         GhNL9JCjq+6VXswtzDYFMFPK4+iUYBgyZhMDX+oVbyDeLXuLNTbje87pcZ/ogu5nWvuA
         Vc4WRsBn4OuNs+/1674Il7TwnaoxNwI0AOA4TFHo+Ye9Xf/xI1xNayxBCnL10QfZdEVf
         ivHYa8Kx5SCN0ZUM5GHLoJPrfgG8i5DuEqYXlBqV8PqcEhmalS8fSDgfbOT0Mf/Mo4Rg
         Ecnw==
X-Forwarded-Encrypted: i=1; AL+hErFcaM4UTafVpWQMamW9IcJYZLkMFE0TQt3jlCZ+2URoaYaUAyY8s2IGvwxdvvMb5VBeXg+jlIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YE9AyyqXUuBFvc1WPDPYR9B+VlO33nBWNKoJLdxM+k5lYY5c9
	LRREbSc1HOqw+kF02MlZ3cSou4pHUHzk/LxvGr1oqERTR1Ac153fqrPxRMsD5w==
X-Gm-Gg: AYBFou2c9MDtogpz2brSJfO8e9aq7DufGBWJE4YBOJiB6JVzHcw17z7J7ZydYc7UkRK
	8VI2qa8mv2Ezeozeq19etoWk5FECGskF5kdXNe7TG1wcpTK7JjajQKDWPBW0/y/trqTDmByK2yd
	ehVse9hvyeCjoiJanraPIkHydULkoXdNluqF+l1FyGzxYlpCY61kE2rbdHoCoBCBK9ifdrSK1Yo
	/VwVsVYRg11obgj7j9LUu+XldTSFOMFedxkFdDeJXtuQ9LypiXMj9J9Y9We6528YZRPdPNCqPyu
	ODuv9RRjAEvgRyJtjUffaunRbDGylquYgFYfr9OniBaEZznQCKqB3ji5pqIzB6riuZ4LmQBNrrg
	0JXreqmmHM1UrNSGuLaelfQG1oHo7tMDJT4vE/9y7xKbq6RJhQ1x/PbosPb+Yj+6i4xxUzI8pxF
	WVPTUrtKWKE3pfSuGCR8ID6FXIVkIG1IxQjQ1+oLWCP7p1A5KvCQOKf+RxX1ekNefYqC8pncYU8
	dfcKTZQ60iuRUNqtkxQOOzQxaa0UcyathnMn3455uvX0h/Q1EA2QCfrgE1WwtqMZ43qTnq780G8
	ASlXcqERed3ZQwYE8pVAXSrWx/wKcYBI6RPEYrQi
X-Received: by 2002:a05:693c:8801:10b0:351:207d:bff4 with SMTP id 5a478bee46e88-3725302c1fdmr7378443eec.4.1794217383012;
        Mon, 09 Nov 2026 01:43:03 -0800 (PST)
Received: from buddy.mshome.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a179c1sm11189758eec.11.2026.11.09.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:43:02 -0800 (PST)
From: Jun Yao <yaojun8558363@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Jun Yao <yaojun8558363@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fuse: hold inode reference across d_splice_alias()
Date: Mon,  9 Nov 2026 17:40:06 +0800
Message-ID: <20261109094006.205170-1-yaojun8558363@gmail.com>
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

When fuse_direntplus_link() calls d_splice_alias() with an inode
returned by fuse_iget(), d_splice_alias() can drop that reference
before returning an error. In particular, __d_unalias() can return
-ESTALE when it cannot move the old directory alias. The caller then
decrements nlookup through the inode pointer. A concurrent
FUSE_NOTIFY_INVAL_ENTRY can drop the last alias and let RCU free the
fuse_inode before that access.

Take an extra inode reference before d_splice_alias() and release it after
the nlookup rollback or after a successful splice.

Fixes: b8bd342d50cb ("fuse: nlookup missing decrement in fuse_direntplus_link")
Cc: stable@vger.kernel.org
Signed-off-by: Jun Yao <yaojun8558363@gmail.com>

---
 fs/fuse/readdir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 1f6cf5654..aca25e5db 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -238,8 +238,11 @@ static int fuse_direntplus_link(struct file *file,
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
 				  &o->attr, ATTR_TIMEOUT(o),
 				  attr_version, evict_ctr);
+		/* Keep inode alive if d_splice_alias() drops its reference. */
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		else
+			ihold(inode);
 
 		alias = d_splice_alias(inode, dentry);
 		d_lookup_done(dentry);
@@ -254,9 +257,12 @@ static int fuse_direntplus_link(struct file *file,
 				spin_lock(&fi->lock);
 				fi->nlookup--;
 				spin_unlock(&fi->lock);
+				iput(inode);
 			}
 			return PTR_ERR(dentry);
 		}
+		if (!IS_ERR(inode))
+			iput(inode);
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
