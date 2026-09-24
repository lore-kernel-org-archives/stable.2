Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121B283142;
	Thu, 24 Sep 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264275; cv=none; b=gldPhbcA1+3qxxSDUL0U+e+6dFYdTPNwp4CuBh4zrtgm++4T4lBPl+wBpmXfI58uh2dQyx/5ZzloLiChTSlvqFl2n5VmiBDIcJsu9BDMpix9NuGVwvxIbbDTQHpm/tD6onb9x56P/J+cAhgEb6Q/700djX/Rof7eS31bnmBt5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264275; c=relaxed/simple;
	bh=HFhIzutKAudwdFNC+cleGjBdZZCjB/fqMCHXbjRWN10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pmDuAouDmWExIKydNZIU4FI0JxfFtIQIsgbOyDRBDXX2C4YfGOBN8fNb0zPuPaSfOZMgezUFJxDmuuWOmTmhmIYXSioNsmrknnqPmHNEQyvvl4Bs+6nXXU1Mz7dJhnmNZR7ESJIfqWdHahXEcRGJGgMPxOCAUKAeacIKSEno8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=b6jEo3II; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="b6jEo3II"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E44B71D78;
	Thu, 24 Sep 2026 15:38:45 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=b6jEo3II;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id BA3361D70;
	Thu, 24 Sep 2026 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1790264271;
	bh=7MdZ1IAQ1TJ15dkq//OCizL11C8OFiUrTiLnRpRIcw8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=b6jEo3IIjap952K80BeZhOCG2J13zXywvcfGUCZkSMRiCVkpRYqVQaCeIXhEjcFDf
	 pTsJeVSgccMxp3gsoYaMattIoeABU9ntJMLi59g64XzIAJo2Kp7g2QjWf8G6jnCoMW
	 GDorm9jQSUHMXEN2hAcuK32dMIHpUlTdP9726tPM=
Received: from [192.168.95.128] (172.30.20.214) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 24 Sep 2026 18:37:50 +0300
Message-ID: <3f5e12a0-c8f8-463a-88b5-d0b590340201@paragon-software.com>
Date: Thu, 24 Sep 2026 17:37:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: Fix heap overflow after ALIGN in mi_pack_runs()
To: =?UTF-8?Q?Alexandro_Cal=C3=B2?= <alexandro.calo@nozominetworks.com>
CC: "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <D3832EA7-E99D-4705-AF8F-7E17310B8B05@nozominetworks.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <D3832EA7-E99D-4705-AF8F-7E17310B8B05@nozominetworks.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/8/26 16:56, Alexandro Calò wrote:

>  From 70cdcdc3203f73fe2a77b70aa32d31140290cc99 Mon Sep 17 00:00:00 2001
> From: Alexandro Calo <alexandro.calo@nozominetworks.com>
> Date: Wed, 8 Jul 2026 16:16:39 +0200
> Subject: [PATCH] fs/ntfs3: Fix heap overflow after ALIGN in mi_pack_runs()
>
> When run_pack() returns a non-aligned byte count, ALIGN(err, 8)
> inflates it by 1-7 bytes, and since the destination of the memmove() is
> computed from that inflated value, the entire attribute tail could be
> copied 1-7 bytes past where the record buffer ends.
>
> The memmove() destination is next + new_run_size - run_size. For it to
> stay within the record, new_run_size must not exceed run_size + dsize,
> the space actually available.
>
> Since new_run_size = ALIGN(err, 8), a fix could be to ensures there is
> enough room that whatever ALIGN does to err, the result still fits within
> the available space. Restricting the budget of run_pack() should
> guarantee that.
>
> Something like:
>      u32 avail = (run_size + dsize) & ~7u;
>      err = run_pack(run, svcn, len, Add2Ptr(attr, run_off), avail, &plen);
>
> Now, run_pack() should never return 0. As now, the function returns at
> least 1. So this is fine. Negative values are caught as errors by
> if(err<0).
>
> The rounded-down avail may be smaller than the existing run size,
> if avail=0 run_pack is called and will write run_buf[0] = 0; that will be
> OOB, because the buffer size is zero, so imo the caller should avoid
> calling run_pack() with avail=0.
>
> After run_pack(), if plen = 0, then svcn + plen - 1 becomes svcn - 1.
> So, after run_pack(), it may be worth ensuring if(!plen).
>
> Lastly, I'm not sure if -ENOSPC is the right error code here, but
> it seems reasonable for a space condition.
>
> This heap out-of-bounds write requires a crafted filesystem image,
> which is not in the kernel threat model, but fixing memory errors would be
> nice to keep things secure.
>
> Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
> ---
>   fs/ntfs3/record.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index 32bdb034c2a3..2466dba15241 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -637,18 +637,32 @@ int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
>          u32 run_size = asize - run_off;
>          u32 tail = used - aoff - asize;
>          u32 dsize = sbi->record_size - used;
> +       u32 avail;
>
>          /* Make a maximum gap in current record. */
>          memmove(next + dsize, next, tail);
>
> +       /* Leave room for the 8-byte ALIGN() to avoid OOB write */
> +       avail = (run_size + dsize) & ~7u;
> +
> +       if (!avail) {
> +               memmove(next, next + dsize, tail);
> +               return -ENOSPC;
> +       }
> +
>          /* Pack as much as possible. */
> -       err = run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size + dsize,
> +       err = run_pack(run, svcn, len, Add2Ptr(attr, run_off), avail,
>                         &plen);
>          if (err < 0) {
>                  memmove(next, next + dsize, tail);
>                  return err;
>          }
>
> +       if (!plen) {
> +               memmove(next, next + dsize, tail);
> +               return -ENOSPC;
> +       }
> +
>          new_run_size = ALIGN(err, 8);
>
>          memmove(next + new_run_size - run_size, next + dsize, tail);
>
> base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> --
> 2.47.3

Hello,

Sorry for the delay.
Your patch is applied, thanks.

Regards,
Konstantin

