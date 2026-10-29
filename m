Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263564;
	b=TJ9pW2/BXXIl87+4unYkySf0Hur5AFXPRR7ZR0fT9DaFU6c8tQyVsUNDYN8K34YFLl3L
	 4lVHTJ3XXis3zlkLhziC1QB4JU78JG6rQVmpJFoV//EXZWylHB7hQpHEes2cFAU/3QOIT
	 yU4n2x6zj1KHghtTvpl3cE/VHGcBAMp41BWqX1ZqPw4f10u28xP09O+Gn4fm22cR/ZD76
	 6XFf7dgGRekUtmSWLn5onUeJO7Tn235I2C3fv4jUAYyWIlETqYCwCjZdMY2kP8n9580Ze
	 smLlodpm1XFOY1LSCsl5HnEnZ4hEzTcj3eFkB2wmy2aAQeIXmlHb0gvuMqDgp48IdvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263564;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=MPYG+Fviw9Kir/qJCzSTQG7LTDlKBETDMXGxhQ8sSH4=;
	b=Pi7uZO8dUeTYd5118MdKlYoACIMMkW4yk3DecFOrrI4Q6n0AuxH44wVlVydbSBiWaStF
	 vhzaS1yWuSkB4q8KXIYdzbJr/AyaveRsUakKt0nKkGTZFcClzkZz8qS3EMNJer5TKw0KK
	 vkJcdJglhVII3DK9edEWnrSy4ZlikHuYhoO1J7e3fZ0nABnQRdTojtlEI23FdudDelzLD
	 Q0gr3vvsC3sNsZfaF4CcKM5E6whlkGVp5X6dyQ6pC1O1dBFxO1f6meqXDFJ0ahpoK3DSe
	 bzG66fCIc0deF5NO5UXXhIf4+liINykL87OnpWKMKEZkoQG8nJV5c2d3opknfflDwuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9C606A31C;
	Thu, 29 Oct 2026 08:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F9C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFd9h5HF4z5PkGk;
	Thu, 29 Oct 2026 16:46:00 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 69T8jlsK055908;
	Thu, 29 Oct 2026 16:45:47 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 29 Oct 2026 16:45:49 +0800 (CST)
X-Zmail-TransId: 2afa6ae307bda81-28cfc
X-Mailer: Zmail v1.0
Message-ID: <20261029164549455vmvRvpHkZ8cVjNxAzoyoO@zte.com.cn>
Date: Thu, 29 Oct 2026 16:45:49 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB1YmlmczogZml4IGZzY3J5cHRfbmFtZSBsZWFrIHdoZW4gcHVyZ2luZyB4YXR0cnMgZmFpbHPCoA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69T8jlsK055908
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 16:46:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE307C8.001/4jFd9h5HF4z5PkGk

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ubifs_unlink() and ubifs_rmdir() call fscrypt_setup_filename() and
then ubifs_purge_xattrs().  For an encrypted directory the former
allocates the buffer holding the encrypted on-disk name, and every
later error path of both functions releases it through the out_fname
label.  The purge failure path returns directly instead, so that
buffer is leaked.

ubifs_purge_xattrs() only does real work when the inode claims more
xattrs than UBIFS allows, in which case it deletes them one by one.
That can fail, for example with -ENOSPC from ubifs_budget_space() or
with an I/O error.  Every such failed unlink() or rmdir() then leaks
one buffer of up to NAME_MAX bytes, so repeated attempts leak memory
without bound.

Jump to the existing cleanup label instead.  do_rename() is not
affected: it purges the xattrs before it calls
fscrypt_setup_filename().

Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index c67954f6bee0..73594d476fe3 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -846,7 +846,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)

 	err = ubifs_purge_xattrs(inode);
 	if (err)
-		return err;
+		goto out_fname;

 	sz_change = CALC_DENT_SIZE(fname_len(&nm));

@@ -955,7 +955,7 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)

 	err = ubifs_purge_xattrs(inode);
 	if (err)
-		return err;
+		goto out_fname;

 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
