Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCD3AAF7E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161818; cv=none; b=o9cWD9re8m0nN/PNV9fUXJuG1PQOg18VEjOa3fAmaW2d0Ue7UJp0veBqON3+RSf90KHZgg+5+WuhYlf8b6T27hZLhAkWuXvobUu/1AZqJMku6rWVHiV9Aexx7Otftjtl2OpZrvzU1gRNchHE8zRPAVq/tkZ+7Q+WXbeegWT9qHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161818; c=relaxed/simple;
	bh=A/+Sr7tx4D5ZREKYnrRAnL8aFLsHkN0hJrmaBtU7YrY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NJG1xRlCZHSCrzVda1PfHsc764qAx65gFHKdkVsdP4pyutlr/XiLPBxGT8k0vHqokoYMPv7Q5k5YMFLnfyjUirZm4I407qJxEVc5XUIX4LYJZ/HtmdhlELPU8VbG3K57Xw12PXjNzlnmZr/JTku751WIIzrri3TnR2Qz+GNFXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=mgy7NTI/; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="mgy7NTI/"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so564388a12.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1790161816; x=1790766616; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z9avEEAnjpEf+bLzxYVfU8riO/8xZqKHcMVkzWtu7O4=;
        b=mgy7NTI/3R1D/3AMop0EXt9y9YxnWS83VYR5w+jlL103Ij8Ux9J6/pMqy1NX9kHZOD
         BmFw4rtEZ2ImFnunwfOPOly/2BwNZU7j8d8BdD6pmw/waKumV4YZDzg2MplRfijSR27J
         9we+PEQPMrUUxuaPUL1h2CJEVTa9TBswXl5c1oMUwXgawturPgJ8e7LDFWFYZcmQsEZX
         1Mh83c2Rdr2/gH9j0L1OdogEKgEvodNMnTfPCce0oVoK3uPV8eJvk3GiifUek6cF1E1h
         usLT6KVoW/djsoQaqzoD+hg/7zCUKajZikNywpWPQXawUrN0p7fP2ekpZartx7MN8mGd
         h9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161816; x=1790766616;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9avEEAnjpEf+bLzxYVfU8riO/8xZqKHcMVkzWtu7O4=;
        b=YXniwClY7OxSYF13tiG27KF2FmwHrK3fuaGuAZcbRlOUA5omkbNk0x3fn+MgUCrMV5
         ymq2aVygISUrZDSK2hIU9QB5PEhroRdNBlqooz4JLx/5zU6Jt04oX4pbmqPX0rdV5nwu
         brCNMnmWbOMlF2Vdf/7BZJaqDOlvi/TqXd7HDjG8Ra4vd/iym0IeHjlSSlAskpKy8kej
         6uJqZV7FY/tshjXe5Ol38aCvhiH1Ut8s+CJnVp+eGaOaJVvjLQ8EFfkybXjcuVHBRkSN
         f5Vdh2M12We3ODhKLZxgJk1NskhBRftu/pPIsTFW4Q5wlpl9J5ii71Tlx/wOL5ZB7Ybu
         SRsw==
X-Forwarded-Encrypted: i=1; AKwUvBxpwlGOklm8NEnbxM3MqWNxl1XSw0JYhs4C1KlC+pjhgaIz2drlFZVwS35x9ifn8T+J8AmcqjY=@vger.kernel.org
X-Gm-Message-State: AFuF++k42uk3C/Ou27ElD/QrkXMoLheUtqohlp/4EoxKJ0y//5uOVrpG
	iuhSTUXWy6bvZ27aoEzvJaapM/71Chg0yFLhkrs0LanPBSUB8UT/8HANtpE0S3P8NIQ=
X-Gm-Gg: AYBFou2d6XtRTRcB/SkE7sERU8dl6BkT9KWgPdlR5/AutQU4ZA5XCYv9oT90Z93VjLU
	g3zxDj4qAX8wMdG+t0KKSeGwxt8PRFDP2nKG97aISD+t35xpB2ODyRuaVNlZnCfNyeW4+T9Ge79
	mg4CJe5qIhSKhci/JLAaM3T4sDShCt2hZNivRGbn7cl1poch4iqUBo6G8bBdhG3PLpAyzgfxH8C
	lRnd3o4X/av3BVWqQIr9yRdEGR5YzaV80hexb9Lgn/LJHv9me7fTU1bKOgin7C6vQ7ZUgbA7F06
	1RPumwm9UZhpBya+NqSrGCBNl0YxXTdc8I+7p4wm5myWaJffoOtHXPmWieePU6GyYV1K/glKzXU
	GPDpScs9d9XqPcHwDVK7o8JjP2g9xm4BFT8s4cuLDNOd1jrZri78VFFHnGtUxzp6Zaw6mELovP0
	LqtnaVTdNgpiKVgxBxNKu6jG15O8NcdjmJxTgfQfg0B3KBirPMlszYCZgyMzS7ih0cgP9uMkBFp
	MeOxfbId4b9BSkD9P5uwocCYHW3M3dWKuRerfQ/Nd2quGO8yLtiL/srdrKE4jvB
X-Received: by 2002:a17:90b:3806:b0:3a0:4146:2955 with SMTP id 98e67ed59e1d1-3a07e693c71mr1949123a91.61.1790161815923;
        Wed, 23 Sep 2026 04:10:15 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [24.64.171.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07db882a5sm4644779a91.1.2026.09.23.04.10.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:10:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH] ext4: clear in-inode xattr space before adding the first
 xattr
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260916084723.877552-1-r772577952@gmail.com>
Date: Wed, 23 Sep 2026 05:10:03 -0600
Cc: linux-ext4@vger.kernel.org,
 tytso@mit.edu,
 jack@suse.cz,
 libaokun@linux.alibaba.com,
 linux-kernel@vger.kernel.org,
 ojaswin@linux.ibm.com,
 ritesh.list@gmail.com,
 syzkaller@googlegroups.com,
 yi.zhang@huawei.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <50CE75D5-930B-4DD6-B0DF-7B956EBA0A62@dilger.ca>
References: <CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com>
 <20260916084723.877552-1-r772577952@gmail.com>
To: Jiaming Zhang <r772577952@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

On Sep 16, 2026, at 02:47, Jiaming Zhang <r772577952@gmail.com> wrote:
>=20
> An inode can hold extended attributes in the space that follows its =
extra
> fields, whose size is given by i_extra_isize.  When ext4 loads an =
inode,
> ext4_iget_extra_inode() validates that space only if it starts with =
the
> xattr magic, and only then sets EXT4_STATE_XATTR.  Without the magic, =
the
> space is treated as empty and is not checked.
>=20
> ext4_xattr_ibody_set() passes the space to ext4_xattr_set_entry() =
whether
> or not EXT4_STATE_XATTR is set.  ext4_xattr_set_entry() walks the =
entries
> there to find min_offs, the lowest value offset.  That offset decides
> whether the new value fits and where the value is copied:
>=20
> free =3D min_offs - ((void *)last - s->base) - sizeof(__u32);
> ...
> void *val =3D s->base + min_offs - new_size;
>=20
> A crafted image can leave non-zero bytes in that space without the =
magic
> where ext4 looks for it, for example by shrinking i_extra_isize.  =
Those
> bytes are parsed as entries, and an entry that claims an in-inode =
value at
> offset 0 sets min_offs to 0.  Because free is a size_t, the =
subtraction
> then wraps around to a huge value, and the free space check passes =
although
> the value does not fit.  The value is copied new_size bytes before the
> start of the space, over the inode's own fields and, for a large =
value, the
> memory in front of the inode.
>=20
> On a kernel without KASAN, the copy corrupts memory: it overwrites the
> inode's own fields and, for a large value, also the memory in front of =
the
> inode.  The bytes and their length are decided by the setxattr() =
caller.
> Nothing is freed and reused here, so the use-after-free in the report =
only
> reflects where the write happened to land.
>=20
> Triggering this issue requires mounting a crafted image, which needs
> CAP_SYS_ADMIN or automounting of removable media; after that, any
> setxattr() on the file reaches this path.  The issue was found by =
fuzzing
> and has not been seen in production; a reproducer is available in the
> linked report.
>=20
> Clear the space in ext4_xattr_ibody_set() before calling
> ext4_xattr_set_entry() when EXT4_STATE_XATTR is not set, so that the =
walk
> starts from the empty entry list.
>=20
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Closes: =
https://lore.kernel.org/lkml/CANypQFZzxTAH=3D4QRRDoqH6VAw1daAq88NDWiQKoM7Q=
TOnP40sg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code:claude-opus-5
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>

Looks good to me.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/xattr.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5c310747b965..2e5f39b710bd 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2274,6 +2274,10 @@ int ext4_xattr_ibody_set(handle_t *handle, =
struct inode *inode,
>  		if (IS_ERR(ea_inode))
>  			return PTR_ERR(ea_inode);
>  	}
> +
> +	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> +		memset(s->first, 0, s->end - (void *)s->first);
> +
>  	error =3D ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
>  				     false /* is_block */);
>  	if (error) {
> --=20
> 2.43.0
>=20


Cheers, Andreas





