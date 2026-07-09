Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92305396587
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614995; cv=none; b=OYfk3UNvD1vPzQKSrTfq3cPKPT6u63Czn/TI9FOLDwqs+0cgfDjaweS3CramKcnFB98S07aVZxVUHstjq4DC/AVImca1nsO++h4D8RbgjPHspEhYXYlILVYmtINaoZ/nV7eaQAiYEstnrQnkbpAZQOb+/4B399FuxFSEQ5svDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614995; c=relaxed/simple;
	bh=UsbaNrmIn63ARuAebfUPXUmtATO3t4qV3jGnIvUWHz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2ceRUtk3Sb/L8FGoRFT7vD227msqEUyL0aeIwZKP2Z5E4GHi5EP5ScYaUO1MN+p/JexczVL9SUhFHSKkk2EzFY+ZKcDUTdLPeqiMkDO5VcBMWxujHSPrL9QF4p63SaE3RfAyYHoG5I/aK1WUgyc+DXQ1P/vn06bfJMSUB8YPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQ6zC61f; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ6zC61f"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b779003fso6125145e9.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783614991; x=1784219791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XpHK7z6dsHMMY8QknSXEZPqq3A8a/T0iO7+AZZEhDvk=;
        b=rQ6zC61fV7LeVAKVwVH9oG2GLeUbHYDTIP94zEfcNbV0ZSbLscsrapE+FtOAyokL49
         vQD0VcRe3nfiSFMG/eWYbRk6DFMZK7ckZ62KWHUI0XTFxS2SxL7GMHh3jJKC1+6INCQ1
         XUryu8rDCHgNOZk3sXemNeyh1+w0+sMHZZ4ribsblXP4LUroDqS3JLesSDL1voUZoUra
         8NiAUIR5xVIW/aEajV0Hr21bQzErLNDqf0e7RTnTZ6kBQFJ3KAhpxTxHdghBNplMQny5
         LX2k+HtUvgvIU0YRa8IaJEqKj7pkudn2gD3tl5nk3yhg8pN2r5dhXYuC9JkgCIUap6op
         eE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614991; x=1784219791;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XpHK7z6dsHMMY8QknSXEZPqq3A8a/T0iO7+AZZEhDvk=;
        b=K7NrttAVYbTvs2zBu6Yfx1hIeSa5IjZS6varkzuOqKz6TVvLG4LHjPBS++Nz9YxYcj
         rCKKbgkNi5EGNnUwJYZbjuyscB9ZeMU67X2ZRTD4PZ2rQ5XFXDTwyjjzsGCvZwjUCDMr
         jy4uuAfK7Ra7apuAJTZDkj6GF5Zs/pYQ+7/ltlZSgaA5N+MkUf41PVrJj6xP/wzmTyyd
         VGYVv7ZMHi/7zoZi6J9eGYUJFzVwdAwREtn3MUB/oJSHKxwLGWO8zuYUKUtPDvegF4I9
         +dELATAlN6i7wVOmKKZMks19ocR+FDsZXJP0DC6WGhY7CFpMvYL04cMes+076nLpb7jB
         36/A==
X-Forwarded-Encrypted: i=1; AHgh+Rrs/Kq4sl7kqI26bl8ilNyNbxmMy2O93HeoYJ/loVZo2w7cQrbZzEeWsF/8qR+OdtiF74PD2q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqtN+/gaNZSV+gXYHvkFzlkrVTykL5cNe09C/2yyUfnXm1J+h
	M6l4KZKXgXlmrWqZk7LAEaW3mBnmNPOjlprsJQC24uPaQARwdIikQBpi
X-Gm-Gg: AfdE7cmTV9AqT6zk7uk3I4mgkaUojjyjavQ9HP3+IyDiE5aonw3ibf0o0mdyL0UubS2
	z7dFpXTHw8owjn/+abI4MXoYmWrDpwwMgPwWlyTpEFLKmYymo3ZWqQ2poHmMj5WCY7KhL+jHNe6
	irIYtJJq6HeDe936codk5XYw9c+cidSCrMdSy1L2Ohy6qqXQoOKho38uwugpSBx3MC5c+cUXNNO
	agy7mudf/LHnNmonS8l+vGyWTkHj4JHL84d4KorRkKwciMR3asKvAtf4HBer8MxcuWtXw/ij+aN
	WC2gwgkc9JMpRvw0KrWrs57rHi4I/NhRbrieF4lP77aD7QA7oFFNfridbIJ+joPQ9FuNwR31TpL
	ZmDMK4XZ8lCbX7Htb8CbWydhBKRPY5dl2wKTL5V5YQ4BW/Fem5OjXoSG2x+/pLg3yFPOshVVfsn
	Iso1qFmK1ICEEsh919Fl/mxPklBwX55nLFalE1TqngZLVxPA==
X-Received: by 2002:a05:600c:310f:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-493e6c05de0mr72385005e9.0.1783614990763;
        Thu, 09 Jul 2026 09:36:30 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm174062095e9.2.2026.07.09.09.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:36:30 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:36:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: raoxu <raoxu@uniontech.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix atime clamp check in read completion
Message-ID: <20260709173628.22eeb7f7@pumpkin>
In-Reply-To: <527C2DB5ABAE200F+20260707133017.1740557-1-raoxu@uniontech.com>
References: <527C2DB5ABAE200F+20260707133017.1740557-1-raoxu@uniontech.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 21:30:17 +0800
raoxu <raoxu@uniontech.com> wrote:

> From: Xu Rao <raoxu@uniontech.com>
> 
> cifs_rreq_done() updates the inode atime to current_time(inode) after a
> netfs read.  It then preserves the CIFS rule that atime should not be
> older than mtime, because some applications break if atime is less than
> mtime.  That rule only requires clamping when atime < mtime.
> 
> The current check uses the raw non-zero result of timespec64_compare().
> It therefore takes the clamp path for both atime < mtime and
> atime > mtime.  The latter is the normal case when reading an older file:
> the newly recorded atime is newer than the file mtime.  The completion
> handler then immediately moves atime back to mtime, losing the access
> time that was just recorded.  Userspace tools that rely on atime, such as
> stat, find -atime, backup tools or cold-data classifiers, can therefore
> see a recently read CIFS file as not recently accessed.
> 
> This is easy to miss because the bug is silent: read I/O still succeeds,
> no error is reported, and many systems either do not check atime after
> reads or mount with policies such as relatime/noatime.  It becomes
> visible when a CIFS file has an mtime older than the current time, the
> file is read, and the local inode atime is inspected before a later
> revalidation replaces the cached timestamps.
> 
> Clamp only when atime is actually older than mtime.  This matches the
> same atime/mtime rule used when applying CIFS inode attributes.
> 
> Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  fs/smb/client/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 58430ba51b10..62605928d2b8 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -301,7 +301,7 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
>  	/* we do not want atime to be less than mtime, it broke some apps */
>  	atime = inode_set_atime_to_ts(inode, current_time(inode));
>  	mtime = inode_get_mtime(inode);
> -	if (timespec64_compare(&atime, &mtime))
> +	if (timespec64_compare(&atime, &mtime) < 0)
>  		inode_set_atime_to_ts(inode, inode_get_mtime(inode));

Should that be calling inode_get_mtime() again?
It seems to have the value cached.

	David

>  }
> 
> --
> 2.50.1
> 
> 

