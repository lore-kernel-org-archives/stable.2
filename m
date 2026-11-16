Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807881;
	b=dh69lviGwQ4vgDCzqqaxAqUfhxfM4+1BNEm8NRu0M6JZhpofNAM0FyVN6nlWUhBpCtrS
	 H5ma5RdnDPR5ajho7IuvZvlkwMa6fOWp5F863YPatq42yIVyVMfb0t5DdT7ETvJ13MCru
	 xXjGj2fP5Z9dhaRmhW88JJ3QodVNYuuIOYNm7YvyQoeHSD2+JB6tcAWUO+a7F+uMcC3Pn
	 eWVddbL+Zrwm3tG88yJZN4iwVzeVzTik2b3RTCe3JOs0MtItqNnUoMCxmMIlmXqWTeXUF
	 MS7SUUrU8yfYzEvMiFsm7c9XK6qFTcO2rP4EeJj4C3Lw105n3KlpRqXj52scWPRAuDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807881;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=YH442YWUNRpnQkaRImDBTqOX7zg5nlBfCdBGvA+8K7Y=;
	b=xlBHIPKpodMIScEHm8qN2nDnl1twbcbuagEWhSQ62n3V65t3xmzjrh4WslkqpG8Z1m2l
	 IGx2/00r7j5/OzaJE7ZuYDVSL8z04Ab6SbO6pmXNWPtdqiIagdfuhQy3xsaY7/BxSUcLi
	 k9xRj7Xm8SiMhd9vOAX2bBJIg+mj0nkErZbqLi1XvAqxnxrKt5Q5iQxQnNN1ph//Ux2BS
	 HktMMTN66Ie7ZzXz/uIiqowqmwyk/dXLNSHLHACbzayo96Nou6vam2emh8dfEo3u3dmZC
	 mDwt7bjFF4M3An8AOqNEgDHtfUB4r31aGv3wKCG/Q1kW8U0JcHWLae2o9xzlluCQzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABF606A33B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56ABF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-85a6d046af0so1159359a34.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807879; x=1795412679;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YH442YWUNRpnQkaRImDBTqOX7zg5nlBfCdBGvA+8K7Y=;
        b=jmHGLql9K8jsKtx9hue4SDNuc3o1KB19UO6uqtv1F+gL9+JO9n3ybCezJ2EA9mtmfF
         WSki7STzRsmYI7oslKXuuePY7mGnOSubbInJ+aGPDc8UH1CyU4U+Sq81wlQB9tDbBLdx
         GEv0gLZBoGIUvzh/2mGJ+5OYtfw3heXYVWnMWOYzc4TJOTVE060b1Xlryd3z9/jsnSKp
         lwqW3tdtvNiBjauLE7JqVAKPxf1S4lHbFvPpHniNdMyDGrjqipP3jw2601yx4y3bhu4D
         VKXCzw23wU6bGB0bt76Em2bMiby3bNjChnP1QRqHgvlDtUt/KSTu4gbCuuE9X0lLCiC1
         jabQ==
X-Forwarded-Encrypted: i=1; AL+hErE/59IBltqS+1zmM7Dj1An1GepsyFMbN9zya9DFpYUNRqe7iOvQRRK/qqd7MTWQTupsLjZ39aw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+M8JB8T267Xuy7/sqdCPscKRD2Xs64Ea387CKvKf94rRJ1AAM1
	+W0906O/KkP7fHhwTRC8Toa0NukAzUlMQXYNkAG5bgN17QlFG1BqCGip24j9Mjgsu+J8u05cUXa
	GsFsNhJeeA/3fx3wYL9iYX7QwIqQm2VfmbO6KB0Qk1sEbZJ1TQj8iv7yDjig=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6809:211:10b0:571:7f0f:924a with SMTP id
 5614622812f47-5717f10b319mr4111005b6e.35.1794807879376; Sun, 15 Nov 2026
 21:44:39 -0800 (PST)
Date: Sun, 15 Nov 2026 21:44:39 -0800
In-Reply-To: <20261116054424.62067-1-diasyzhang@tencent.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afa9847.b64ae673.1498f1.0dc5.GAE@google.com>
Subject: Re: [PATCH] ext4: attach jinode before inline data conversion in setattr
From: syzbot <syzbot+9c29b92a3b6500bb347d@syzkaller.appspotmail.com>
To: diasyzhangqing@gmail.com
Cc: adilger.kernel@dilger.ca, ahmadpsn95@gmail.com, diasyzhang@tencent.com, 
	diasyzhangqing@gmail.com, jack@suse.cz, kartikey406@gmail.com, 
	libaokun@linux.alibaba.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	stable@vger.kernel.org, tytso@mit.edu, yi.zhang@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Commit ed9356a30e59 ("ext4: convert inline data to extents when
> truncate exceeds inline size") added inline data conversion to
> ext4_setattr(). Pathname-based truncate bypasses ext4_file_open(),
> so the inode may lack a jinode. In ordered mode, the conversion
> can pass this NULL jinode to jbd2_journal_file_inode(), causing a
> NULL pointer dereference.
>
> Attach the jinode before ext4_convert_inline_data() and propagate
> attachment errors. The attachment in ext4_truncate_up() occurs
> after the conversion and is too late.
>
> Fixes: ed9356a30e59 ("ext4: convert inline data to extents when truncate exceeds inline size")
> Reported-by: Ahmed Khan <ahmadpsn95@gmail.com>
> Link: https://lore.kernel.org/r/CAOaS1==g3mdoqmS2AjOC0_-woXJbA_X0LJQt7+M7d1=+gfyQqw@mail.gmail.com
> Reported-by: syzbot+9c29b92a3b6500bb347d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9c29b92a3b6500bb347d
> Cc: stable@vger.kernel.org
> Signed-off-by: Qing Zhang <diasyzhang@tencent.com>
> ---
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Patch testing via #syz test is temporarily disabled.
See https://github.com/google/syzkaller/issues/8122 for details.

>  fs/ext4/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10cd85d4c721..1e31933ae98c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -7127,6 +7127,9 @@ int ext4_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
>  		 */
>  		if (ext4_has_inline_data(inode) &&
>  		    attr->ia_size > EXT4_I(inode)->i_inline_size) {
> +			error = ext4_inode_attach_jinode(inode);
> +			if (error)
> +				goto err_out;
>  			error = ext4_convert_inline_data(inode);
>  			if (error)
>  				goto err_out;
> -- 
> 2.43.7
>
