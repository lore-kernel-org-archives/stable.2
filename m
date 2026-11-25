Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615611;
	b=FUz63BLt+bEgQsFzFNIVv5bGkQJMt3zNRrRYrFIQmUPOmOQQ1h4nY73HKbSVOtTNvJac
	 nxbRpI+juyuSGeVc9b1pt3Bx7UwkaXf3mkPk/u1zvK3Tab5oiid2MVr8VAJWKE2QbGBfN
	 YbXdX4l2uCjN6XHLo+HLk1uNVGiX0jUu/Jv5e2E2/05wip8Ie+dpJZQ3lcdZ2vhkACwCs
	 JKkFFmIAAveONAWcmLRmZbQnhMKI8uwvCQTmG3kfcaEIR1L6XXRSS6hv+Uqf4bXnp1RDT
	 MfMCQGYpbPFhnfGEkEdSK8dgDp3+APg1qw5gcACBtLSHcHxDgnXDde72vx711Jh2Qyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615611;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=wiGsBwL9W3KlU8RDQ1hovQ1ERHqUTXj7So3F61y0kyM=;
	b=42x2i9qWrfPJ82X8bHesiX8qL2IVHnLh/9AUXjzzpaApQO8pbhz7wSxTYSIn79c8wxZB
	 XdW+XFuEH1CfDxt8LaEhE36eUKwhO2yXggzGTnQDXuUbTMQ8rNb1zmK97YYIKozhSYXVp
	 7ti+Wfve+vvsBo0KgrCHU3MKyxRlzP5CnS4yKlkaOnKKsxJZqsQe/5VtR/j9E6uTEohWL
	 dFMjJVCnTlEtXDj304sXtLaxuIVg0cf8KxeunrH4FP19PX07qZLdedaueNsXgh3OwsKBx
	 nwidj/2pfGyRzBM3BPdTGhvro259o5i8mXgqcWTVKivakLUXFdUFryFNbuoh1EZQ1tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d1N+OCtR;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EBE606A321;
	Wed, 25 Nov 2026 14:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EBE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d1N+OCtR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wiGsBwL9W3KlU8RDQ1hovQ1ERHqUTXj7So3F61y0kyM=;
	b=d1N+OCtRr2dplnP5cVj5cTOix/kglzEm+CFYzK+D6QQn7jeotaDJexKOZRyMB/
	MQfUWWmxu9XGY3iWub4ptwrTFGZ6Sh2rT18CC/NAaDoGFVsFZG60IN/Jn5AdZFGJ
	3IovdM14lllUk/ywa080XVl46qVgw/NVzvrkRzz3a2Skk=
Received: from [IPV6:2409:8900:1a90:8163:5fb3:f207:88ec:aa89] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCn6io+6wZrBf_GIA--.52509S2;
	Wed, 25 Nov 2026 22:05:52 +0800 (CST)
Message-ID: <89ca24c7-1ba8-41e1-81ef-1b60b7cc64bd@163.com>
Date: Wed, 25 Nov 2026 22:05:50 +0800
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
Subject: Re: [PATCH 2/6] ntfs: roll back the size update when the attribute
 lookup fails
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20261125073547.154150-1-zenghongling@kylinos.cn>
 <20261125073547.154150-3-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125073547.154150-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCn6io+6wZrBf_GIA--.52509S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry8KrykurW8uFWfuryDJrb_yoWrXrWrpr
	9rGFyFk390q3s7Grn3Ka4UX3WYg3yv9r4UuFy7tF1fAF98Jw1IqFyrtryxKan2yryktwsY
	vr4qgFZ3CFyqvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTCJQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QBnMmsG60C-zQAA3I



在 2026/11/25 15:35, Hongling Zeng 写道:
> ntfs_enlarge_attribute() truncates the attribute to the end of the
> write before looking it up again, because the truncation can move the
> attribute to a different mft record. If that lookup fails, the error
> is returned but the attribute stays at the extended size, so a failed
> write extends the file.
> 
> Undo the truncation before returning the error. If the rollback fails
> as well, mark the volume as having errors and synchronize i_size with
> the current data_size instead of the old snapshot.
> 
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/inode.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 4fbdcd459652..7d7bb741455e 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -3842,8 +3842,19 @@ static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
>   {
>   	struct ntfs_inode *ni = NTFS_I(vi);
>   	struct super_block *sb = vi->i_sb;
> +	unsigned long flags;
> +	s64 old_data_size;
>   	int ret;
>   
> +	/*
> +	 * Snapshot the old data_size under size_lock: it is the rollback
> +	 * target, the other sizes are updated by ntfs_attr_truncate()
> +	 * itself
> +	 */
> +	read_lock_irqsave(&ni->size_lock, flags);
> +	old_data_size = ni->data_size;
> +	read_unlock_irqrestore(&ni->size_lock, flags);
> +
>   	if (pos + count <= ni->initialized_size)
>   		return 0;
>   
> @@ -3853,7 +3864,7 @@ static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
>   	if (NInoCompressed(ni))
>   		return -EOPNOTSUPP;
>   
> -	if (pos + count > ni->data_size) {
> +	if (pos + count > old_data_size) {
>   		ret = ntfs_attr_truncate(ni, pos + count);
>   		if (ret) {
>   			ntfs_debug("Failed to truncate attribute");
> @@ -3865,7 +3876,40 @@ static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
>   				       CASE_SENSITIVE,
>   				       0, NULL, 0, ctx);
>   		if (ret) {
> -			ntfs_error(sb, "Failed to look up attr %#x", ni->type);
> +			int rollback_err;
> +
> +			/*
> +			 * The truncation already happened, so undo it
> +			 * before returning the error
> +			 */
> +			rollback_err = ntfs_attr_truncate(ni, old_data_size);

Hi Hongling,
    Thanks for sending this patch series.

    Could this rollback deadlock with writeback?
    ntfs_inode_attr_pwrite() holds mrec_ni->mrec_lock when calling
ntfs_enlarge_attribute(). For a non-resident attribute, the rollback
can reach ntfs_non_resident_attr_shrink() and truncate_inode_pages(),
which may wait for a folio lock.
    Meanwhile, iomap writeback can hold that folio lock and wait for the
same mrec_lock in ntfs_write_iomap_begin_non_resident():
   rollback:  mrec_lock -> folio lock
   writeback: folio lock -> mrec_lock

    The folio containing the old EOF may already be dirty from an earlier
write, so this does not require the failed write to have copied any
data.
    Could we avoid waiting for folios while holding mrec_lock, without
allowing concurrent writes to interfere with the rollback?

Thanks,
Baolin.


> +			if (rollback_err) {
> +				s64 current_data_size;
> +
> +				/*
> +				 * Rollback failed, the sizes may be
> +				 * inconsistent. Mark the volume as having
> +				 * errors and sync i_size with the current
> +				 * data_size
> +				 */
> +				read_lock_irqsave(&ni->size_lock, flags);
> +				current_data_size = ni->data_size;
> +				read_unlock_irqrestore(&ni->size_lock, flags);
> +
> +				i_size_write(vi, current_data_size);
> +				NVolSetErrors(ni->vol);
> +				ntfs_error(sb,
> +					"Failed to look up attr %#x and "
> +					"roll back the size update: %d",
> +					ni->type, rollback_err);
> +			} else {
> +				/*
> +				 * Rollback succeeded, the sizes were updated
> +				 * by ntfs_attr_truncate() itself
> +				 */
> +				ntfs_error(sb, "Failed to look up attr %#x",
> +					ni->type);
> +			}
>   			return ret;
>   		}
>   	}

