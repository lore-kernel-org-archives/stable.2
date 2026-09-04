Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC4480DE8;
	Fri,  4 Sep 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519180; cv=none; b=T2Scky0xmz6S6WO8pQwrAlzfUOY1F1mYaVbO3KfS9g8tFJ/KIIOg6w7lHkdOr/JjAs6OUZwtw7yotNsZAbYXlQh4gAt3+dtmidNtCJhe7TdvU4oohp/6Oce1DtAaJf1yxZQC2y24PsRw8rUOhb7EEEzVSKGGNUMvHKygz1ADN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519180; c=relaxed/simple;
	bh=Alrr5L7q88NEL8Szn4wVstpVZHeCBflFtA7F3yDieCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XDB1TGkyzhJC04YCrigi5hnd+uFBlK+ucrfM6FK2QoRQlmmwwOyV93bZj9rU9m1AjgZAPoXwSMvuQG3TR9AiZWrWt7t35JJMqaxF2tkU2zYPDvF/t9oWq2nW+XNCPc6T2BAboA/tE1VRLhOiEYjz59mc+IjxCIx4/rU1h71HdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SGuM5PWv; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SGuM5PWv"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 183CE1B5;
	Fri,  4 Sep 2026 10:53:43 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=SGuM5PWv;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E08762205;
	Fri,  4 Sep 2026 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1788519164;
	bh=vefyIiQtac2+EOvQfCttqEQxxQyjgqS4+yO7HGAhC2Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SGuM5PWvpE/F/J0lyuPm9C5cfvM62eWe+Vlgbqv2KrjEHuK/q+mjapy9TW++p2YF1
	 GPOE7qGZ8wFZNbPB5lZI4mYHzSCCHuKYrKxuaB++sUEQej0LnQq6BOlkkD9+IY3uaK
	 mFplFmv6778EDheMyXAUfEvrM3iGWUA1jd2FnKwU=
Received: from [192.168.95.128] (172.30.20.203) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 4 Sep 2026 13:52:43 +0300
Message-ID: <8d28e6a2-ff75-426b-9971-b8a0e9371bfe@paragon-software.com>
Date: Fri, 4 Sep 2026 12:52:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds write in
 ni_create_attr_list()
To: =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260625031932.9412-1-skyexpoc@gmail.com>
 <CAOC0qyLj55itFPEurfNddWpzzcPJ4j3bvDxfWBRev_GzPLL+mw@mail.gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <CAOC0qyLj55itFPEurfNddWpzzcPJ4j3bvDxfWBRev_GzPLL+mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/6/26 06:40, HE WEI（ギカク） wrote:

> Hi Konstantin,
>
> Gentle ping on this v2. It's an attacker-controlled on-disk image heap
> out-of-bounds write in ni_create_attr_list(),
> reachable via setxattr on a crafted, loop-mounted NTFS image (KASAN
> trace is in the commit message), which is why it's Cc'd to stable.
>
> For the record, the fix was first posted as v1 on 2026-06-10:
> https://lore.kernel.org/ntfs3/20260610002929.51765-1-skyexpoc@gmail.com/
> This v2 (2026-06-25) only adds Cc: stable and widens review to
> linux-fsdevel; the fix itself is unchanged from v1.
>
> Could you let me know if you'd like any changes, or whether it can be
> queued for a future bugfix pull? I'm happy to rebase or adjust as
> needed.
>
> Thanks,
> HE WEI (ギカク)
>
> hewei-gikaku <skyexpoc@gmail.com> 于2026年6月25日周四 12:19写道：
>> From: HE WEI (ギカク) <skyexpoc@gmail.com>
>>
>> ni_create_attr_list() allocates a fixed buffer of al_aligned(record_size)
>> (== record_size) bytes and then walks every attribute of the primary MFT
>> record, writing one ATTR_LIST_ENTRY per attribute and advancing the cursor
>> by le_size(name_len), with no check against the end of the buffer; the
>> total size is only computed after the loop.
>>
>> A minimum-size resident attribute occupies SIZEOF_RESIDENT (0x18 = 24)
>> bytes on disk, but an unnamed attribute expands to le_size(0) (0x20 = 32)
>> bytes in the list.  Because the number of attributes in a record is not
>> bounded (mi_enum_attr() accepts arbitrarily many equal-type, nameless
>> minimum-size attributes), a crafted record packed with such attributes
>> produces a list larger than record_size and overflows the heap buffer.
>>
>> This is reachable from a crafted, loop-mounted NTFS image: opening the file
>> and adding an attribute (e.g. via setxattr) drives ntfs_set_ea() ->
>> ni_insert_resident() -> ni_insert_attr() -> ni_ins_attr_ext() ->
>> ni_create_attr_list().
>>
>>    BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0xc48/0x1058
>>    Write of size 4 at addr ffff000008984c00 by task setfattr/345
>>     ni_create_attr_list+0xc48/0x1058
>>     ni_ins_attr_ext+0x510/0x7c0
>>     ni_insert_attr+0x3f8/0x70c
>>     ni_insert_resident+0xc8/0x3b0
>>     ntfs_set_ea+0x66c/0xd28
>>     ntfs_setxattr+0x4d8/0x5b0
>>     __arm64_sys_setxattr+0xa4/0x124
>>    Allocated by task 345:
>>     ni_create_attr_list+0x188/0x1058
>>    The buggy address belongs to the cache kmalloc-1k of size 1024
>>    (the write lands at object+1024).
>>
>> Size the buffer from the actual attributes instead of assuming a single
>> record_size is always enough.
>>
>> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
>> ---
>> v2:
>>   - Add Cc: stable@vger.kernel.org: this is an attacker-controlled on-disk
>>     image heap out-of-bounds write and should be backported.
>>   - No functional change from v1; widening Cc (linux-fsdevel, VFS) for
>>     review, as the v1 posting received no response.
>>   - Drop a redundant self Reported-by.
>>
>> v1: https://lore.kernel.org/all/20260610002929.51765-1-skyexpoc@gmail.com/
>> ---
>>   fs/ntfs3/frecord.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>> index 2e901d073fe9..6488d7a415c0 100644
>> --- a/fs/ntfs3/frecord.c
>> +++ b/fs/ntfs3/frecord.c
>> @@ -768,10 +768,23 @@ int ni_create_attr_list(struct ntfs_inode *ni)
>>          rs = sbi->record_size;
>>
>>          /*
>> -        * Skip estimating exact memory requirement.
>> -        * Looks like one record_size is always enough.
>> +        * Compute the exact size of the attribute list.  Each attribute in the
>> +        * record yields one ATTR_LIST_ENTRY of le_size(name_len) bytes.  The
>> +        * minimum on-disk attribute is SIZEOF_RESIDENT (0x18) bytes, but an
>> +        * unnamed one expands to le_size(0) (0x20) here, so a record crafted
>> +        * with many such attributes needs more than a single record_size; the
>> +        * previous fixed kzalloc(record_size) could therefore be overflowed by
>> +        * an attacker-controlled record.
>>           */
>> -       le = kzalloc(al_aligned(rs), GFP_NOFS);
>> +       lsize = 0;
>> +       attr = NULL;
>> +       while ((attr = mi_enum_attr(ni, &ni->mi, attr)))
>> +               lsize += le_size(attr->name_len);
>> +
>> +       if (!lsize)
>> +               return -EINVAL;
>> +
>> +       le = kzalloc(al_aligned(lsize), GFP_NOFS);
>>          if (!le)
>>                  return -ENOMEM;
>>
>> @@ -781,7 +794,6 @@ int ni_create_attr_list(struct ntfs_inode *ni)
>>          attr = NULL;
>>          nb = 0;
>>          free_b = 0;
>> -       attr = NULL;
>>
>>          for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
>>                  sz = le_size(attr->name_len);
>> --
>> 2.43.0

Hello,

Sorry for the delay. Sure, the patch is not applied yet but I'll inform
you as soon as it will be.

Regards,
Konstantin

