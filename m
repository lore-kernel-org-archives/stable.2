Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189124F93B5;
	Mon, 28 Sep 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616136; cv=none; b=c1uwFbkUa83IwLQGeYzJF3n78ZtM+/hShB5ukcWlJoBajKHCLW8bzmCd8BVnRWC8SOqm4OcqCvd5LdEglIHq+NNVU8vOJAWvcoc1otHB+gurOUE9MKJD5XoNpY893bDrCyB1q9VCNcJe2YhFp/XDwp83cQccQ8yP2U8duSLr3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616136; c=relaxed/simple;
	bh=5RvctZUCAf0FL3NxVqZcjM6pEbtTPWL0VQnh4iXuH+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZTGEpkiTLBfZUCK8X4EMlYcLtYgEzeNtI69BuRuWj9OIUwGAzFOiC3pAlCJTXq6Bi9vhMQO1SOZIftDVW442WfZsFq3hR4TMrkdVbBoWNOuyqV743adqd58vow0p3hSqeSQ/OE0ixkOBkxPnf4EOrkMemyT6H+edy1rO/SedYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=i0Ea0Jti; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="i0Ea0Jti"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 474B032C;
	Mon, 28 Sep 2026 17:22:48 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=i0Ea0Jti;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E181C2187;
	Mon, 28 Sep 2026 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1790616114;
	bh=igqSE9WbsAuz84abPqqeKEyX2eYBhV8g04lvS+mTwlY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=i0Ea0JtiWMbn+Avk+U9Uze5gRhKzKQFL9TYG8rKrh7lzQjFvxbFVkWIZOGU42qeaZ
	 e5cvOu/NQSde8Vh5VSALwwaqqZoIwEuIij7uK1Pv2gdduSGxL3C+5WwNpWmVwoAluZ
	 uSMDLEtfzzb8v+EaiKrykCNffdny06U07qmsTPu8=
Received: from [192.168.95.128] (172.30.20.196) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 28 Sep 2026 20:21:53 +0300
Message-ID: <7feaa304-022b-4e50-b20a-de72fb16fd9a@paragon-software.com>
Date: Mon, 28 Sep 2026 19:21:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix integer overflow in find_log_rec() causing
 OOB read
To: Ibrahim Hashimov <security@auditcode.ai>
CC: <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260708224618.1328-1-security@auditcode.ai>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260708224618.1328-1-security@auditcode.ai>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/9/26 00:46, Ibrahim Hashimov wrote:

> find_log_rec() validates the on-disk LFS_RECORD_HDR.client_data_len
> field (`len`, a raw u32 read straight from a mounted $LogFile page)
> against the log's total available space:
>
>      len = le32_to_cpu(rh->client_data_len);
>      rec_len = len + log->record_header_len;
>      if (rec_len >= log->total_avail)
>              return -EINVAL;
>
> The addition is unchecked. For len in [0xffffffd0, 0xffffffff] (i.e.
> log->record_header_len away from UINT_MAX), `rec_len` wraps to a small
> u32 value that trivially clears the `rec_len >= log->total_avail`
> guard, so a record whose declared length is actually ~4 GiB is
> reported as valid and in-page.
>
> Because find_log_rec() wrongly accepts the record, its caller
> read_log_rec_lcb() hands it back to log_replay() as good. On the
> transaction-table replay leg, log_replay() re-derives the record
> length directly from the same raw, still-unclamped client_data_len
> field and uses it to size the restart-table blob:
>
>      rec_len = le32_to_cpu(frh->client_data_len);   /* ~0xffffffff */
>      ...
>      t16 = le16_to_cpu(lrh->redo_off);
>      rt  = Add2Ptr(lrh, t16);
>      t32 = rec_len - t16;                            /* still ~4 GiB */
>      if (!check_rstbl(rt, t32))
>              return -EINVAL;
>
> check_rstbl()'s own `bytes < ts` bounds guard is defeated because the
> caller-supplied `bytes` (t32) is itself the poisoned ~4 GiB value, so
> the guard can never trigger. The subsequent entry-validation loop then
> walks `rt->used` (also attacker-controlled) entries of
> sizeof(struct RESTART_TABLE) == 0x18 bytes each straight past the end
> of the kmalloc(log->page_size) log-page buffer allocated in
> read_log_page(), producing an out-of-bounds read that is reachable
> simply by mounting a crafted $LogFile (no genuine dirty-page /
> crash-recovery state is required). Confirmed via KASAN as a
> slab-out-of-bounds read in check_rstbl(), called from log_replay() ->
> ntfs_loadlog_and_replay() -> ntfs_fill_super() -> mount(2).
>
> Fix the root cause instead of hardening every downstream consumer of
> the poisoned length: make the addition in find_log_rec() overflow-safe
> with check_add_overflow(), mirroring the pattern fs/ntfs3/run.c
> already uses to validate other attacker-controlled on-disk
> length/offset arithmetic decoded from MAPPING_PAIRS runs, e.g.:
>
>      if (check_add_overflow(vcn64, len, &next_vcn))
>              return -EINVAL;
>      ...
>      if (check_add_overflow(lcn, len, &lcn_end))
>              return -EINVAL;
>
> (fs/ntfs3/run.c, run_unpack()).
>
> With the overflow rejected instead of silently wrapped, `rec_len` is
> only ever a true, non-wrapped sum, so the existing
> `rec_len >= log->total_avail` check now correctly rejects any
> oversized record up front. log_replay()'s transaction-table leg then
> never gets a chance to re-read the poisoned client_data_len, and
> check_rstbl() is never invoked with an attacker-inflated `bytes` for
> this path.
>
> Verified on a v6.19 KASAN build: mounting a crafted $LogFile whose
> client_data_len overflows trips a KASAN slab-out-of-bounds-read
> report in check_rstbl() before this fix; with check_add_overflow()
> applied, the same image is cleanly rejected during log replay and no
> KASAN report fires.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>   fs/ntfs3/fslog.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index f038c799e7ac..e5b63a02b827 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -7,6 +7,7 @@
>
>   #include <linux/blkdev.h>
>   #include <linux/fs.h>
> +#include <linux/overflow.h>
>   #include <linux/random.h>
>   #include <linux/slab.h>
>
> @@ -2424,7 +2425,8 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)
>           * Check that the length field isn't greater than the total
>           * available space the log file.
>           */
> -       rec_len = len + log->record_header_len;
> +       if (check_add_overflow(len, log->record_header_len, &rec_len))
> +               return -EINVAL;
>          if (rec_len >= log->total_avail)
>                  return -EINVAL;
>
> --
> 2.50.1 (Apple Git-155)

Hello,

Your patch was applied, thanks.

Regards,
Konstantin

