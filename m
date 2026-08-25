Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F272ECD1D;
	Tue, 25 Aug 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639958; cv=none; b=Lbl6Ym/+9ZZ1Xs/ncEN/rXDn/8dSh4bYIk+FovHUwM5Z74gWUdva/hssuYkg/UeWVOE7BxAk9Nq+XDV18tkBtB/3bv0WM0AIXpipW5HNtUfWtvJsccAcT5HHNLB68Xx6a3A3GsH6yjlRSUNGwYb+NFk9XoLxC7DoJwR1ZryQFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639958; c=relaxed/simple;
	bh=CwpEMT+6obrXNPoGYL4TwI96s15Xzh7GCNyvputM6N0=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=k8Z53/aanWPtBOx0ysz0d/izwv5A1LUlghlnCgYt9PGVDI8nIy2fmXqle1o05dQWUCcr3ugofst6z72G7EB7OoixAVPriohiWLm4y3Rg7STsYqkeXz1h4nlJS7+5HMl7SJ7TB/5o+F77Hb/f7etraIVtdY69YAJDE40DiXHDzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=io4hfADw; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="io4hfADw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=5XhpfCexG4A9Liwi5Mrf5Vqtwp6eN4jWsBJOvp7i3ek=;
	b=io4hfADwbZ2XyUDZ5zKzZceKoHdPgyix00XfgfeTw4kx+z23xzuF080jhdF64B
	45elmQkmFT2zp1ytLmGu+F/2RgElnbteSV2iq4v8ipsdjifDY5jnCF1jm54Lw7II
	gXADxSfmVUovqP3966uXkT/CeaBeaOLn9K908Tqc+z1ik=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3__boN41q1a5aGg--.60125S2;
	Tue, 25 Aug 2026 14:36:25 +0800 (CST)
Message-ID: <6A8D37D1.7010800@126.com>
Date: Tue, 25 Aug 2026 14:36:01 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Hyunchul Lee <hyc.lee@gmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: linkinjeon@kernel.org, ntfs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix memmove overlap in ntfs_new_attr_flags
References: <20260824075935.170457-1-zenghongling@kylinos.cn> <CANFS6bZczfbx3HKO9pN2wOm9Wy8oCX0GAA_uAoXzhu1j34Jo7w@mail.gmail.com>
In-Reply-To: <CANFS6bZczfbx3HKO9pN2wOm9Wy8oCX0GAA_uAoXzhu1j34Jo7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3__boN41q1a5aGg--.60125S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUXryUZFyDZry5Gr4rXwb_yoW5CF43p3
	ykGF93Kw4xXF13KFsxtFsxG3y5X3s7Kw1Utry7tw18CFn3WwnYyFyIkr9Y9a45Grn0qw4F
	qF4UZrW3GFn0qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI1v3UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoAkG1mqNN+m8SQAA31


在 2026年08月25日 13:45, Hyunchul Lee 写道:
> Hi Hongling,
>
> 2026년 8월 24일 (월) 오후 4:59, Hongling Zeng <zenghongling@kylinos.cn>님이 작성:
>> When the record shrinks while the payload offsets increase (e.g., enabling
>> compression reduces padding, making arec_size < old_arec_size, but the header
>> grows by 8 bytes), moving the name first can overwrite the old mapping_pairs
>> before they are copied. Move mapping_pairs first in this case.
> Can this situation occur even when
> it is not a crafted image?
Hi Hyunchul

   Yes. This can occur during normal operations when modifying 
system.ntfs_attrib
   on a file with a named non-resident attribute. The header grows 
(adding the
   compressed_size field) while the total record shrinks (reduced padding),
   causing name_ofs and mp_ofs to increase and creating the memmove overlap.

   No crafted image is required - a valid NTFS filesystem with the right
   attribute layout will trigger this path.

   Thanks for the review.

>> Since mp_ofs is derived from name_ofs, they always change in the same
>> direction. Checking name_ofs alone is sufficient.
>>
>> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   fs/ntfs/ea.c | 33 +++++++++++++++++++++++++++------
>>   1 file changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
>> index 534f7efaf128..c836d33ab0d3 100644
>> --- a/fs/ntfs/ea.c
>> +++ b/fs/ntfs/ea.c
>> @@ -729,15 +729,36 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
>>          old_arec_size = le32_to_cpu(a->length);
>>
>>          /*
>> -        * Move payloads before shrinking the record.  Otherwise resizing moves
>> +        * Move payloads before shrinking the record. Otherwise resizing moves
>>           * the following attribute over the old payload before it can be copied.
>> +        *
>> +        * When offsets increase, move mapping_pairs first to avoid name
>> +        * overwriting the start of mapping_pairs.
>>           */
>>          if (arec_size < old_arec_size) {
>> -               if (a->name_length && name_ofs != old_name_ofs)
>> -                       memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
>> -                               a->name_length * sizeof(__le16));
>> -               if (mp_ofs != old_mp_ofs)
>> -                       memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
>> +               if (name_ofs > old_name_ofs) {
>> +                       /* Payload offsets increased: move mapping pairs first. */
>> +                       if (mp_ofs != old_mp_ofs)
>> +                               memmove((u8 *)a + mp_ofs,
>> +                                               (u8 *)a + old_mp_ofs,
>> +                                               mp_size);
>> +                       if (a->name_length && name_ofs != old_name_ofs)
>> +                               memmove((u8 *)a + name_ofs,
>> +                                               (u8 *)a + old_name_ofs,
>> +                                               a->name_length *
>> +                                                       sizeof(__le16));
>> +               } else {
>> +                       /* Payload offsets decreased or unchanged: move name first. */
>> +                       if (a->name_length && name_ofs != old_name_ofs)
>> +                               memmove((u8 *)a + name_ofs,
>> +                                               (u8 *)a + old_name_ofs,
>> +                                               a->name_length *
>> +                                                       sizeof(__le16));
>> +                       if (mp_ofs != old_mp_ofs)
>> +                               memmove((u8 *)a + mp_ofs,
>> +                                               (u8 *)a + old_mp_ofs,
>> +                                               mp_size);
>> +               }
>>          }
>>
>>          err = ntfs_attr_record_resize(ctx->mrec, a, arec_size);
>> --
>> 2.25.1
>>
>

