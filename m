Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0C48EBC2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333177; cv=none; b=kS1C4IkUKGY+3gPH/4uwJBEufmz2az2y2C+x9JrTb4KOajG8kgzLzohHrGTy9r6xDlthICCm+sboEnnIONYD7bnEfMHy+HCH1pdJd1j/jxaQoHeQIpuI3bPbFgQSiVeTsAinib6cmKX+aSEt/pSjsNQTOxfK4f1d6Kus65XYF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333177; c=relaxed/simple;
	bh=U9jP5g2UlQMpLn1Q6VDzXuieWkoFot4JFR3mrV1ZUZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/Ok62d/kSeAOhvMgMranEF3w8bUhxGiQ/3T6DydGRznmR5rpmDtqPezYxnv/5zCvETqe1uO3AGW+zCQKukv35vk7hrlytmkGTynf6r5lvM5MbMzRpwUrXT2qGJw4588LmF3ggKW7fER82O0VOrVNwLK6mzTmxhaFDtL7Dc4fcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fquSvSb3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyuBJNRU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fquSvSb3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyuBJNRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785333172;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm746TS8EnyhI8+mzBi8QtOCUfuL1ZTqgnyHRBXxPjM=;
	b=fquSvSb32qazqbqvtUOuDJN9N2OiDmC0FgfHyB3t7nTgF5dF7829UwLaCAwqailpLsG2YE
	V3Kop9O9L7b+HCyFpw8BYHibjMz2KiAX5GT4nSoYLa+k3uVWI+p96WXdkzqpHc6Zfqkm6J
	QrFLDHArephW+b+pKsyfzQ1mE6/gj8Y=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-AHj5jFO6Pia6usGoaEbxQA-1; Wed, 29 Jul 2026 09:52:48 -0400
X-MC-Unique: AHj5jFO6Pia6usGoaEbxQA-1
X-Mimecast-MFC-AGG-ID: AHj5jFO6Pia6usGoaEbxQA_1785333168
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7eb6a8c61deso679686a34.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785333168; x=1785937968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dm746TS8EnyhI8+mzBi8QtOCUfuL1ZTqgnyHRBXxPjM=;
        b=HyuBJNRUPVDZtzo6Ba/87MLpIglkg8d78vbvwFUCv0QeulondIAOb1MXFbiIFcbX65
         6AvMAvCZLbWWhusYqMBbaxqgyngrpXZB/9odBpuEp+wK89rIMcw4VPIqGR+d1HJfLbl0
         V+MU85eLdmbIWa6jgv+r30hQldMLsj6+TKv4FDcTDibc/SjBIWqRdsScM5c2ZLNRFuWC
         yEa0qXc9/GoVq4tl6S4qirrojznQAeRn2ew87I1Ow8MDH9lTXyMzMa3EmYr2C/HB9Woc
         meMceORTFaFBrdOZOxCJT6R42jhgzmezV5vOzJKlaOrbjQWiwKikQGkNlGTWzGRDS1My
         G1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333168; x=1785937968;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dm746TS8EnyhI8+mzBi8QtOCUfuL1ZTqgnyHRBXxPjM=;
        b=R3HlQCeXmWl1jpMpIbhOqEvxyg6jFctCDVMpVklW+kbR5JlkJEOM2XgdA4LhD/evbt
         dBNoIg5AbWtNbkK8FWOeCEkZAZipdwFfLgCrFdbCQLvba/lrasP2Q12UOdI05Grebn7o
         ct0FVLBl3S6StwvrFkqPepksydhiDhHRAHgahT4Yzr2ZKM5MImC2G68TBqrFTPojOjy4
         Pqqic7uFfDz211GTZdDB4BiSGTYhrLmnCnoX71z0k7KQRZU8L9otSxvqOwnXmQO8cSEX
         3Nfo5aACYGTyd5vHSSF7haay3NsN3p3ZdhBBOAhSFnKcrPSgW5fWBNpVHHn2848hCFUb
         90xA==
X-Gm-Message-State: AOJu0YwCYc9RGhELPQqV68dvVbqg4M2/9FCbpZnmCnUS7x4l6ViN9Tln
	wjkHU0vnVcLUcWHQpQlbDWfw15PhiIPIO4tASn3qXjJFIQkG4CcCfuh1sJ4FPu6l2kHFw3ORZa1
	xKQl+vmFGxnCHq5FUTWQAtpkPsiKmxNw7iPAgvqVZGodDu84JzwxXoevBkA==
X-Gm-Gg: AR+sD13BJCz8B5Ghfci+0+bCdQYxFg9Yur+64xz5AGK+UUS35Q+CxMyeXBCE4JyszLY
	SEHBDvGIJDPEdzzxLt0qe02ju6qfg64LSbMdrrWBWxCKQnxNkD/22a/G5pzlNTbETwnT1puArO+
	XozuIdX0HuXOdWDvGeEwVy/3Eo6/6Iz8jcPf5b7VyXVku8fQnq6t8VI+03IVhmhaZyPFANFNppc
	4kF3al581gxUyfs4K2hYwZSSDAW7Rfs+MbFSR0IcwbelsCPe4HWNrV1VAdr0Em9IBx+ygnwpEgU
	yuwX8/TTYMeTAx3aiUTSBHIKVkb9RQcIOI478EYvGQla369NjobbDiBSUJT8KRDCk/A7O99FCl7
	jHTMMKgbN2Jzf/iWNimIQngD4E0sLlO4SDmdelCKs
X-Received: by 2002:a05:6830:6ab1:b0:7e9:d250:a731 with SMTP id 46e09a7af769-7efff247ec7mr3509866a34.20.1785333167880;
        Wed, 29 Jul 2026 06:52:47 -0700 (PDT)
X-Received: by 2002:a05:6830:6ab1:b0:7e9:d250:a731 with SMTP id 46e09a7af769-7efff247ec7mr3509859a34.20.1785333167468;
        Wed, 29 Jul 2026 06:52:47 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d94d404sm2325351a34.23.2026.07.29.06.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:52:47 -0700 (PDT)
Message-ID: <1c417111-ebaa-4da8-af32-11ce073dee43@redhat.com>
Date: Wed, 29 Jul 2026 08:52:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH 1/3] cifs: use cifs_invalidate_cache() in
 cifs_do_truncate() for O_TRUNC
To: Huiwen He <hehuiwen@kylinos.cn>, linux-cifs@vger.kernel.org,
 pc@manguebit.org, stfrench@microsoft.com
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.com>
References: <20260728211438.3859107-1-sorenson@redhat.com>
 <20260728211438.3859107-2-sorenson@redhat.com>
 <b21c1885-a46c-44d5-9b20-2b0072a3b50d@kylinos.cn>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <b21c1885-a46c-44d5-9b20-2b0072a3b50d@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Huiwen,

Okay, that makes sense.  Thanks for explaining further.  Let me work on 
that.

Frank


On 7/28/26 11:20 PM, Huiwen He wrote:
> Hi Frank,
>
> Patch 1 handles the quiescent-cookie case, but the cookie is not
> guaranteed to be quiescent here: another open may already keep it
> active. In that case, cifs_setsize() may still call
> fscache_resize_cookie() without i_rwsem before the invalidation.
>
> Maybe we could keep cifs_setsize() as the basic size/page-cache helper
> and add a wrapper for the paths holding i_rwsem, for example:
>
>   /* Caller must hold inode->i_rwsem for write. */
>   void cifs_resize_file_locked(struct inode *inode, loff_t offset)
>   {
>       struct fscache_cookie *cookie = cifs_inode_cookie(inode);
>
>       lockdep_assert_held_write(&inode->i_rwsem);
>
>       netfs_resize_file(netfs_inode(inode), offset, true);
>       cifs_setsize(inode, offset);
>
>       if (!cookie)
>           return;
>
>       fscache_use_cookie(cookie, true);
>       fscache_resize_cookie(cookie, offset);
>       cifs_fscache_unuse_inode_cookie(inode, true);
>   }
>
> cifs_file_set_size(), smb2_duplicate_extents(), and both
> smb3_simple_falloc() branches could use this wrapper, since those 
> paths already hold i_rwsem. O_TRUNC could continue to use cifs_setsize()
> followed by cifs_invalidate_cache(), without attempting a resize.
>
> Patches 2 and 3 look good to me.
>
> Thanks,
>
> Huiwen
>
>
> 在 2026/7/29 05:14, Frank Sorenson 写道:
>> cifs_setsize() now calls fscache_resize_cookie() since commit
>> fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()").
>> However, cifs_do_truncate() is called from cifs_open() before
>> fscache_use_cookie() activates the cookie, so the fscache cookie is
>> still quiescent at this point.  fscache_begin_operation() requires
>> FSCACHE_COOKIE_IS_CACHING to be set and returns failure for a quiescent
>> cookie, making fscache_resize_cookie() a null operation in this path.
>>
>> The correct fix for this path is cifs_invalidate_cache(), which calls
>> fscache_invalidate().  Unlike fscache_resize_cookie(), 
>> fscache_invalidate()
>> works on quiescent cookies: it unconditionally increments inval_counter
>> and sets FSCACHE_COOKIE_NO_DATA_TO_READ, ensuring that stale cached data
>> is not served once the cookie is later activated by 
>> fscache_use_cookie().
>>
>> Truncation to zero leaves no valid cached data, making invalidation the
>> correct semantic.  No inode lock is required for 
>> cifs_invalidate_cache().
>>
>> Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to 
>> cifs_setsize()")
>> Cc: stable@vger.kernel.org
>> Cc: Huiwen He <hehuiwen@kylinos.cn>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Paulo Alcantara <pc@manguebit.com>
>> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
>> ---
>>   fs/smb/client/file.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
>> index ac89c1ba56b1..389083f9ce00 100644
>> --- a/fs/smb/client/file.c
>> +++ b/fs/smb/client/file.c
>> @@ -1016,6 +1016,7 @@ static int cifs_do_truncate(const unsigned int 
>> xid, struct dentry *dentry)
>>           if (!rc) {
>>               netfs_resize_file(&cinode->netfs, 0, true);
>>               cifs_setsize(inode, 0);
>> +            cifs_invalidate_cache(inode, 0);
>>           }
>>       }
>>       if (cfile)
>
-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

