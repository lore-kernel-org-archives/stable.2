Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30E4EBADB;
	Wed, 16 Sep 2026 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556927; cv=none; b=Lm4/YE4g+a3gYrMsTzTYQnF4YFqB9I0aBAWdJuRAEH2JybOw1gqlsUCe3xtZ5Mz3PZUq9DgVZoS+0b0zdHEG+cb8/IOLmMleRnFUfN8WdtOFdyI5HB1Yd/IvXM2rdQAFEWKk6RSuenGVdlHPNzfWkN+Xd1YjS0kHffQJzlQvgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556927; c=relaxed/simple;
	bh=jEnWy80E7lHIXQzMor6J5G9w/M4dWH8O8hHqSAnqygI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l1lXA1PTDa6Jc0LHeZfCBfIDyY+76Lvyz9Mi7M0kA1OmY7jSkVqJ+9f2A4DUHpwqwQZaP51gVQlRCBMO01Vf2gfhdyOuvQMkmIFhQ8+ls/2OmX3vguH6GgIbPOIMmq3XNs4mvZ4P83+v+b6d+H0fBNg8s8HWHnlWEHAzbysQHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=gpglgaET; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="gpglgaET"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 986071D42;
	Wed, 16 Sep 2026 11:09:29 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=gpglgaET;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CE63D21F5;
	Wed, 16 Sep 2026 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1789556913;
	bh=uzbLqvO1VBUa7r1AIhCHMOEL+lyZM1vXjq7ZEuwSGTQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gpglgaETRTa4oi6ro7lfJABgBwpwH0SmeslgktrWOPBAriUFVeW2+cOWG4XnGKge6
	 dUSN+mjqk1lP0LItvzGoN4oaK/pr6iPwxT1RNAJwbJhaos2rhSgab9OPfWyLHEMt0k
	 rn36dw7365SMBinWfWXt8pNbo94jLClLT+CH4qkI=
Received: from [192.168.95.128] (172.30.20.192) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 16 Sep 2026 14:08:32 +0300
Message-ID: <bbf5c349-86d4-44ec-8023-66f406d3d703@paragon-software.com>
Date: Wed, 16 Sep 2026 13:08:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: bound index head insertions by buffer capacity
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<syzbot+45ef5a8d661162757547@syzkaller.appspotmail.com>
References: <20260628095559.47891-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260628095559.47891-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 6/28/26 11:55, Yousef Alhouseen wrote:

> hdr_insert_head() shifts the existing index entries by ins_bytes without
> checking that the resulting used size fits within hdr->total. A directory
> index root larger than the newly allocated index buffer can therefore make
> the memmove write beyond the buffer.
>
> Reject insertions whose size would exceed the index header capacity and
> make both split callers unwind the new node when that happens.
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Reported-by: syzbot+45ef5a8d661162757547@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=45ef5a8d661162757547
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>   fs/ntfs3/index.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 5344b29b0577..64e1be9b7aca 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -594,6 +594,8 @@ static const struct NTFS_DE *hdr_insert_head(struct INDEX_HDR *hdr,
>
>          if (!e)
>                  return NULL;
> +       if (size_add(used, ins_bytes) > le32_to_cpu(hdr->total))
> +               return NULL;
>
>          /* Now we just make room for the inserted entries and jam it in. */
>          to_move = used - le32_to_cpu(hdr->de_off);
> @@ -1743,7 +1745,10 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>          hdr_total = le32_to_cpu(hdr->total);
>
>          /* Copy root entries into new buffer. */
> -       hdr_insert_head(hdr, re, to_move);
> +       if (!hdr_insert_head(hdr, re, to_move)) {
> +               err = -EINVAL;
> +               goto out_put_n;
> +       }
>
>          /* Update bitmap attribute. */
>          indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
> @@ -1881,7 +1886,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
>          /* Copy all the entries <= sp into the new buffer. */
>          de_t = hdr_first_de(hdr1);
>          to_copy = PtrOffset(de_t, sp);
> -       hdr_insert_head(hdr2, de_t, to_copy);
> +       if (!hdr_insert_head(hdr2, de_t, to_copy)) {
> +               err = -EINVAL;
> +               put_indx_node(n2);
> +               goto out;
> +       }
>
>          /* Remove all entries (sp including) from hdr1. */
>          used = used1 - to_copy - sp_size;
> --
> 2.54.0

Hello,

Sorry for the delay.
Your patch was applied, thank you.

Regards,
Konstantin

