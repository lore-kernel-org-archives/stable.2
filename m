Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793626092;
	b=nvZcb8XOxGQ/5Mj2L+bH0OTJy8DnCmxbzrceERdX5lGeLLESUIkqwO7XTpVGqUga6Nze
	 b+8OCPrHAaqUlb3894PhjQlJRfEU1PNyzVH0R9YfspnOtAasTgTLCA4q6VTSq9YWkBqiy
	 OCnqCCfWlmi+QsXV4a/QDgoiqcSLqQNQIUL1cHSqviMfFexxKtcMRbpDg0as+LRyjupjT
	 4lZcduzxqPVHJ5ybrBCI6wzoViacyBtO69Iqn1LXRjOOsy5/Kc8G3mfrGF/+qLAZs48n4
	 WlA29foHrFzA5VWnhWJL+477uWxBnElTMR0WuaGxTP/PsPTjKJ4sRQoJ/pL+YfrcnoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
	b=RBKMErTU2qZJyUwPBjxlX0SCzOJPlhsnxEVHaaRcprkxcCh6/dFYsfC4OS2DEMelCyNk
	 Uw665UpIk1EeROCFlWaiKEIqHzyrCOOpEZX9eMkN6yNns147NFLtAS9Z637tB8EQ03Xdw
	 U591GPhV4yNIzHcXsqQTu5d6aohmAcbx0vcwHuwpZRsoKc4OyVe7GTV0Xx5sNIrqxvjuW
	 UQuzVPdwoys2H5gOeGjUPZ/j2JCrK4msSe43Rz4cudLDJUD6hYThu95JPmtCWlaagLKkT
	 4HWkG6GBOA9x0yKoxF8SnaqdjJuGRX0sVnwwQ/yz5tr4++QIdjuJBrcOgYc+MbARX5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYS07XxP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308B606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5308B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYS07XxP
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4322d310e7so490776666b.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793626090; cv=none;
        d=google.com; s=arc-20260327;
        b=n63NZfL4OOM1VNlh2V4GSJ4aGzQXIiGWlH8G06jtEj7dOnvMo7SgT3HS2fEN1Q2v3T
         6Pxz1ZCg4pD8MNB8RvYi26G0SItZDI19skcZZumKBbkSuHARPivvsxSWizusTM12EstR
         osDEnY3tSyOURGKUUkumHh+Znf9I5uvcB8/NJ5hOzp+oxVUTUrKuVkGV+DdGn7LfupKt
         vJ9XJJviS8W0GsI7WuF9V8aJbXcKB8eNFy38kl4FeOqY0gsspZ2VEONh0cgKWmv+FUOC
         fzc1nTCuhhcMoUguf9oyzSPkWEOUz8ICPIvRc0E/NQRiR4809gt9VMhY3BrjF6sTG1Of
         JSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
        fh=r/MlaERVxNJ6xLPXehanvij6aiRPLMa8j+4ddyk0PFA=;
        b=GVa87huBeFLxAxNnoupGFzssG6GwR+Q6wwJgnSdZPHYJahBd3j24ERqmqbi6Ps1vQX
         ePF2aVhJPwBgDefMHqL6aYI6qFEz1htUZvBoh7UE9Xw+fpo7WBeSwf3vP2S3UWqiKEWC
         EGfp4JRV5hdGmggTGtICnqxzZ2K+RjSOWWewCrKR4wBm0LdFkgBvdWda41gjQYJsE6bZ
         8giZODxblW9xHfy6TYNxdi/N3SY8ikSOm0qk7ApUMpwrI4h5RKFzIzJioFfj0BDlEDRw
         ceY1LQMmi1JZs18umIPmZ7Tmlqj/yPeBvsA+GTNnMOhkB20DHuIJBwTvrJrISv/OZQTT
         nWbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793626090; x=1794230890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
        b=eYS07XxP8utYTK8HWQxrIfweY2AEeSo05MdTGi9bbVESvlC58yszyY6JPLobaWZfxc
         imk/gxvuIXAaaTqV46KdtWmW3Q1ueQHZpbb2oWgLi8gNn6uXtkdbIzybF0KYsU5j+ayW
         aKmXNPi+TN8LKEygHmb6+CngLX/IJwGYm57T1XXuB/0Hwxb0BVyeMHl6mO+yjqoQM26r
         QIGMCxuRZeD0eC9omZ6Wonuh4ev5nNkK8FsviHCI0KaI33iz9G45ISt/6jkeihUvAQhw
         AZzS1P60h62yvfPoc/o74f7YuADHPSqe7dJKIFt5i7QNTmMya1RJRdwQUTAclTJTikIQ
         PtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626090; x=1794230890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjPej5w11WbikcynHTF6kveEbA3S0oHjvCfUZQriRUU=;
        b=O1/6Z4n+xvTnfsgYX8zgTKIB8dio84WMXDkjBKI+BNBIzK/4jHBcQ0MX903K0t+Ma6
         61TLbdBSq2nCz7CZXWh2WStynP0zMnfqFcsuRz9I1I5jw5Rsb5vAoQnbdOjxstMAGZFY
         IJgSxYTc8xHtZ+7OoL6Ni1AAw6CECiH9lVj4PmlPwAGjNYPuLm8BegI6+jZ5JQTfhP9U
         FBCpUvSWnkxQVES6pK4jLgA2DRWHSGIxwC7IorY1SWh45XmJYuI9hjhmBkiRIedKPHXd
         LtYf0LoaUEIYcdcLKzKlEBDBznz6j8x+IF0XpVETSR242xBYShNGkyl9ZAs+S7bty4+m
         ndfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzPtlM4ejSWXVjh4Vuyp59nSjfwOb6B+9e+4khej+3FnJj43Lx03c9oNgWddvFIzRpVREglrA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jRuNhthGvUJv4AUHI5HMBoiR3YamitLcIe8PXBaUOaCesp1f+
	aXDPI900nKE830vfNeKGswtx1UeEKU3RBQjEMuRg4vyLuZK0OeV+BMJEl/Ljd2AOYJvodpurQ1y
	Rz7TvB1n3dcHWc6uC4+O36KkbSuqqzHM=
X-Gm-Gg: AYBFou39HV3w5y+ZKSK7UHhib2iAnW5RDeGDdw3CYA10OC6hSyK0LcCjJyGyx74G2MT
	UYGmkWWw6X0qSWOvrM7oV3BOXoQmQGaL+ahq/OGTaepwYpVh56WeFqUP4YdWQYbeV6mGJslAZN5
	5/+SioeOheechVNGXVsGuJ1y9uaBC730dHleWn/toGlQ9+djPjgOqqyFqtHf+pB8ZojbMdZwA1k
	xilIr/sFLypkLghK4lVIUqBL1N5x1+AF6ceaQ01DKemKUID0YVT8VeI1UbIacE3bGMQRay4jvQx
	kbzhjdh6xez2E6nnRdrMfwMsTLxY5ApYEJQOEOooVvYoS25yZwBsJY+AmWyYSxr9z6zwGvcYahY
	vOk0O7Zi0e+guOTf3OvqAdAWEQCxq59DAMe9KEc8=
X-Received: by 2002:a17:907:7212:b0:c2e:3f49:df04 with SMTP id
 a640c23a62f3a-c4ca793bcd1mr794308466b.1.1793626089392; Mon, 02 Nov 2026
 05:28:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021085635.3633692-1-r772577952@gmail.com>
In-Reply-To: <20261021085635.3633692-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Mon, 2 Nov 2026 21:27:28 +0800
X-Gm-Features: AclHuK8kt_THxReORpsQp5Tyrq7frAGmxk4veLrbcHUVI_TWp6z1LJSbwSMGjP0
Message-ID: <CANypQFYcKGJP7BxP-UAiKUXQ2Uw+H06WJY7kkCxuVQ742QbK_Q@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: clear in-inode xattr space before adding the
 first xattr
To: jack@suse.cz, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca
Cc: libaokun@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, stable@vger.kernel.org, 
	yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 16:56=E5=86=99=E9=81=93=EF=BC=9A
>
> An inode can hold extended attributes in the space that follows its extra
> fields, whose size is given by i_extra_isize.  When ext4 loads an inode,
> ext4_iget_extra_inode() validates that space only if it starts with the
> xattr magic, and only then sets EXT4_STATE_XATTR.  Without the magic, the
> space is treated as empty and is not checked.
>
> ext4_xattr_ibody_set() passes the space to ext4_xattr_set_entry() whether
> or not EXT4_STATE_XATTR is set.  ext4_xattr_set_entry() walks the entries
> there to find min_offs, the lowest value offset.  That offset decides
> whether the new value fits and where the value is copied:
>
>         free =3D min_offs - ((void *)last - s->base) - sizeof(__u32);
>         ...
>         void *val =3D s->base + min_offs - new_size;
>
> A crafted image can leave non-zero bytes in that space without the magic
> where ext4 looks for it, for example by shrinking i_extra_isize.  Those
> bytes are parsed as entries, and an entry that claims an in-inode value a=
t
> offset 0 sets min_offs to 0.  Because free is a size_t, the subtraction
> then wraps around to a huge value, and the free space check passes althou=
gh
> the value does not fit.  The value is copied new_size bytes before the
> start of the space, over the inode's own fields and, for a large value, t=
he
> memory in front of the inode.
>
> On a kernel without KASAN, the copy corrupts memory: it overwrites the
> inode's own fields and, for a large value, also the memory in front of th=
e
> inode.  The bytes and their length are decided by the setxattr() caller.
> Nothing is freed and reused here, so the use-after-free in the report onl=
y
> reflects where the write happened to land.
>
> Triggering this issue requires mounting a crafted image, which needs
> CAP_SYS_ADMIN or automounting of removable media; after that, any
> setxattr() on the file reaches this path.  The issue was found by fuzzing
> and has not been seen in production; a reproducer is available in the
> linked report.
>
> When EXT4_STATE_XATTR is not set, zero the first 32 bits of the space in
> ext4_xattr_ibody_set() before calling ext4_xattr_set_entry().  These are
> the bits IS_LAST_ENTRY() reads, so the space is treated as empty and the
> walk stops before reading any stale entry.
>
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Closes: https://lore.kernel.org/lkml/CANypQFZzxTAH=3D4QRRDoqH6VAw1daAq88N=
DWiQKoM7QTOnP40sg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code:claude-opus-5-5
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v2:
> - Zero only the first 32 bits space instead of the whole space.
> - Add a comment above the check.
> - v1: https://lore.kernel.org/lkml/20260916084723.877552-1-r772577952@gma=
il.com/
>
>  fs/ext4/xattr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5c310747b965..8e1fd26329d3 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2274,6 +2274,14 @@ int ext4_xattr_ibody_set(handle_t *handle, struct =
inode *inode,
>                 if (IS_ERR(ea_inode))
>                         return PTR_ERR(ea_inode);
>         }
> +
> +       /*
> +        * Make sure xattr space is properly initialized so that
> +        * IS_LAST_ENTRY() returns true for its first entry
> +        */
> +       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> +               *(__u32 *)s->first =3D 0;
> +
>         error =3D ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
>                                      false /* is_block */);
>         if (error) {
> --
> 2.43.0
>

Friendly ping, please tell me if any further change is needed.
