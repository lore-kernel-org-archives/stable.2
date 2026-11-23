Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.157.23.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436321;
	b=IHb45Vht83gyUEUyV2KhYbVvApTexX+4ynanTEL+iIaJHxhcjtW3qkwjJ9IudECYKxV5
	 JZFM+jEuEYrraWPzegG7UwI3HmotSEPFjzypZaL+aRD/Uyo97IiTL3HYOIn2YKXDZ6VtE
	 wkUgv9wjCAvIJn3+lM9FnRyKHgScc/4xHAFphqtvqflyPbzDlF8uQskfvrqIpwbRomlro
	 JUEOiLEnbeYEA1G9xsRiXyx3vsADwcevDY0C7rIyfOiFjal4YYSkmrhHgNX4sb3ITuOFo
	 47T70rFT4qF31BdDZBVvzlCRK8WLxL8+n6K8BirLOtaRwaNR0KCOuYs91zkzPRP1lCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436321;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=9UvAxivFiSEq0LyKR6ra3EBoI2lwxNjSzVoAx32rpNE=;
	b=cAYycJ8EGaNQ+k76BxeIL1NRv169k+qe2EfRSGwR4SSatWHsirGl/iShwDbpW/3gSxAR
	 VTeLrZWYfUk+s5lOQErJ4khGeJW9T13pNmjngI14X9QvHGdV/39yxLTpo3eONTupkj9Gz
	 miSbI/Kgk1JuOVkCs9PdozHx5FxCSUzishqDXR6m81PPDP3xGHbWkZgxLfVtBfA6qbTQg
	 1PDMcY6jDqbBNDZYXGq+hyGEEVAllYjdPK9SKEMtxOSf0WCQ9b3VUUn2D2eJJ0NHU7UZ0
	 0VFjAEkaJJmP+8J87HM7wfp3BS4A6Wg/ENPf9y0TBp00Xrh2IVXaIHRfN4tL14pYZbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paragon-software.com;
	spf=pass smtp.mailfrom=paragon-software.com;
	dkim=pass header.d=paragon-software.com header.i=@paragon-software.com header.a=rsa-sha256 header.s=mail header.b=JEqYHYvc;
	arc=none smtp.remote-ip=35.157.23.187
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F08606A33C;
	Mon, 23 Nov 2026 12:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F08606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.a=rsa-sha256 header.s=mail header.b=JEqYHYvc
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D45201D1B;
	Mon, 23 Nov 2026 12:19:17 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=JEqYHYvc;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6AAF2454;
	Mon, 23 Nov 2026 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1795436315;
	bh=9UvAxivFiSEq0LyKR6ra3EBoI2lwxNjSzVoAx32rpNE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JEqYHYvcMAB3uyJPTO06nd2fyPz4RKx3mR06PccD6rASuaAovpH5RMkslkNrTbwz3
	 UK6IL9YEaqfzLtpVhtqEFUSun/RIYYQau2NKmJL2U89ip0wKTUp4GGmr6MCUKkVnP7
	 48xQWhxVX0Mp3UD5JRp2NfkJ7q+uBHOUng5i7+9I=
Received: from [192.168.95.128] (172.30.20.204) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 23 Nov 2026 15:18:34 +0300
Message-ID: <f831dbca-286b-4b33-9f37-69bc9388a026@paragon-software.com>
Date: Mon, 23 Nov 2026 13:18:32 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: Fix out-of-bounds write in resident insert
 range
To: Bruno Produit <bruno.produit@trailofbits.com>
CC: <ntfs3@lists.linux.dev>, Kyle Zeng <kylebot@openai.com>,
	<linux-kernel@vger.kernel.org>, Dominik Czarnota
	<dominik.czarnota@trailofbits.com>, <stable@vger.kernel.org>
References: <20260922114018.1829807-1-bruno.produit@trailofbits.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260922114018.1829807-1-bruno.produit@trailofbits.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 9/22/26 13:40, Bruno Produit wrote:

> From: Kyle Zeng <kylebot@openai.com>
>
> attr_insert_range() grows a resident value before shifting data at and
> after the insertion offset.  The current copy instead moves @bytes bytes
> from the start of the value, so both its source offset and length are
> wrong.
>
> For example, inserting 2048 bytes at offset 512 in a 513-byte resident
> value copies 2048 bytes to data + 2048 even though the tail is only one
> byte long.  The resulting destination can extend beyond the MFT record
> allocation.
>
> Move the original tail from the insertion offset to its new location,
> then clear the inserted range.
>
> Fixes: aa30eccb24e5 ("fs/ntfs3: Fallocate (FALLOC_FL_INSERT_RANGE) implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> ---
>   fs/ntfs3/attrib.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index b1c315206..4bd758133 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -2610,8 +2610,9 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
>                          char *data = Add2Ptr(attr_b,
>                                               le16_to_cpu(attr_b->res.data_off));
>
> -                       memmove(data + bytes, data, bytes);
> -                       memset(data, 0, bytes);
> +                       memmove(data + vbo + bytes, data + vbo,
> +                               data_size - vbo);
> +                       memset(data + vbo, 0, bytes);
>                          goto done;
>                  }
>
> --
> 2.53.0

Hello,

Thanks for the patch. Alon Shakevsky previously submitted the same
fix in "ntfs3: fix INSERT_RANGE for resident data".

Regards,
Konstantin

