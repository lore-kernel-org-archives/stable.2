Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794979567;
	b=kpGcEXU7HdBH5TL+MaifCOYhEoS33r/EfIdNThbjUb8ALtqcdNOPlqWQN0r6AwsyLYab
	 Ezj573ECCDrb7PJUxc5oMB2oMc4o/S4pB/Z1th3l9a62l8s5Jpm089wwEYbuiRG3wdnU/
	 wHHeyJ12UTyc61vIKI/A9H87aV5Pq9Xi1fHwtUVpttlW/5sMIRQg8CspLepg+LUWUUdHD
	 7lf58WyTmilJWcfOLp+J+b7n8bU3KCK+QRX2ZN8NJPsEvXhuqCOmVSCojMRCszITihEn+
	 Qa2GrqtACc649z9snbORGRT4WTs2f2c4GU8aM4NgAWrltwkMPQ2vJJMVy//qbTIdkcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=MYg91d5wzYF4TFnjBxzz+qg6N7tTURDQA5SFNzxK9ys=;
	b=MovvTWiE4ajAIGvnDSJtksdJmYqB8hMjJk0YaQNufUr62toN2BNC0jfUmYRY7Jc8WoNs
	 r3u/TOUBViU/5DGgLAdzzUkklA9cTficIHPqRKVaqOKbCa9FmlmpNP4i4+uThKhUOQx9u
	 aGBGcHxce2lE5ZEKkI0Fl4NQo6kkk1tMgq7Ph7pNw026z69nQCcbHbvvaQLDhM96uKFCa
	 uHW3ZsrQ4o1483xq2QzM4oUjIEKXC1/FZfAOB4GltHODrUnp92feZmPeufESiLw7mhI5p
	 74qtvk3eq/Te0g6yT99loNK9WsJxnktIF3MrLO4HvReNGzIQkeoSzJeuw18fO2X7Ddw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KEg3+T8J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A0606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29A0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KEg3+T8J
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dee593f18so347667f8f.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 21:26:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794979565; cv=none;
        d=google.com; s=arc-20260327;
        b=VhFhX0oNs9q+iQfFxerhZ5eJe7JCXre8/B0/bGCsnSqdSUhOf7L1Hbu1bizpPjper/
         SrzaGOwQ0o6x5Uozne3w4Xe7dPz00ei2IQtdIZkn0kcOuIqF7kkN1NcwvViJl2LI2gMo
         Kq9l39FS+JYivKF6c50nAXUn4ouMgIckCaBQisjoNQP5lhmpozSQHvrFrqCkfwclgjpW
         i05UkgleMSl6ZXb6QGy+W0+9Osv8hXPHcCHsLmv5H1Cy5JwmMN5zijHcbinIdXe1W8Xm
         4Wi+JSsG9kOR+TU0YKIF9sAL8BXn2XcIlVKcismz+oIRmEog+WSsj3if0wQA8ex4tzUk
         VMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MYg91d5wzYF4TFnjBxzz+qg6N7tTURDQA5SFNzxK9ys=;
        fh=lxYj0OgZIbLnG2l6+Iepyf5MEB8sbioLewbxCgnOOfQ=;
        b=McRC2RGg4L7A34HNQOc1KovOkml89twZqtA3RkY3I1rfGfg6ONtubuV5FCSWNAA+xc
         j3QwyKcAy1M/OFMJcqjh1m9iSH9NrM5WBBSubwi9czodrPphj99zu+IhOAzgcLRpBSsU
         AdhTvYb2XFsSPS6ePAF1ni/QcgwVK1ebW21DEl9kqSxUgrpZhgCBFI0yPBGiWuznz5L2
         nVJ72J+PpKw9qdQ0LIy0GaouR1jp83nD5HOYDl/sI3t4AXF1ehuPftt9SLmF7SJXnSzw
         WiG2dIRku9Q2wMXKKasPnJypm0Ci45sdryanm51Ho+ErMVXnaUPK27+9Yke8uqtsLvKz
         oZEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794979565; x=1795584365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYg91d5wzYF4TFnjBxzz+qg6N7tTURDQA5SFNzxK9ys=;
        b=KEg3+T8Jpl59hWzw+ks9zQ56eCeJlD1hhOj4JYBgQIdmKYKtYcmqknpvlahLT+ksPL
         9i76OOd8iGDCyzQbUGeLrwQ8m9dxzo+v+GjJYRftTH00k5/Le9jmNGXs+84QDaNg4rMR
         7SIQkJ8hi/FNdzWOpFjeo0IVNkCakl025/HTxqKe3wvZLYsp5wjiKh6fNdSS/WCPfuaj
         fzs1UT0tX0ouEpg4wxJpy/J9XFFyAErNhwcG2ledaYKMTIhjWEbg0UlXelppmWN9FGHm
         EkROWlTNd1/wW9MmaStkrbTilUeqwbNbvfXqIO/TWwbJEna9VkcNUcu+3Ar16ciHTqtq
         tD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794979565; x=1795584365;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MYg91d5wzYF4TFnjBxzz+qg6N7tTURDQA5SFNzxK9ys=;
        b=kKKddjtbBk4xkRFSurMEfXOS82ZESCJaEKnmqdfqU1C7o4EP9qeMERR2644U/vJDix
         kHseuMQ4x9PVHLSUuJZ7xWfaF+YEM+kqkRaW1WkyTeskwWqY3nNGAfJ3Qq8RCJOEH6dd
         CHybB6HXjgRTdEu/6wNm0WWijaRNEebH1LyTYMmbW+hDE0t+z4VkzyNFSrs1xLoeIMp/
         sOtakdNXBD+G6cN0ujlvuGR7NRWhu4OVEPIs6HYsvN6bLN5U+cwbo82fSIiZpVBee3AZ
         d0v8XKQZ/OiClrr3JSH5tu+X7Cq5xwafnyMjqZYP9QEF6Ozi2s+IQBd6BLQLYlyUpsB2
         iUsg==
X-Gm-Message-State: APuU4Z/u7SJ14mMd4dwOPykAHJkEVB+POGm/KbGGI11M9xTLmH/8MiDg
	eMbT5QgRX/OoyXJu33GTlgAiFotz83Z8/o30TblklpQ5wZT2VNuOSzdPcvh2eeHkLghWxcPG1SW
	6NeGiHWJTPH+3W+eZ+CDDR3LMSJPFUgZzj6kjr5JDdvMR3BEy07zuGW8=
X-Gm-Gg: AZFdTZfO2ePyEGvUT4+xXcX1qGZEpwTY+nngbgsyk559vDUK1yESbQ3SI+D6NXt5W/A
	p5Po2U7ZWcNg+DovFOEA3GCqKmA1YRM80czxQD5Fp1gtbS+u2jMY3nddsneaUGSFylc5gwt7akK
	vOrwOSyDjuPA5A1TNbBkZTBxd9RHcTw05jJN3iwPw9pXjwCUOoAwqap6jGcyeI7ArN+WK00KXIC
	ZMuPPLHkaGj3Jrv4b5FHxdJ7iPhTOX7ch03dMVgovznGjTEuMMFnYK73fNTUI3i6l98ehmLLTVM
	1zeOD2gOI9I+aQ8QyDje8cTXZDVAAMwuXss54ja/w/Ec6Sw4L1e2ce7xkBdchKdq6Yht7ohrYwU
	wwjGUSrQ/28QSXwfvE50fdEEe7rpH4y7mVaLh4ycSWAocmYuTPvcpsaL604ccz26zM2bGzB5BYn
	sJm3IIPHuCBSCrBxUgLOXxFCW7pVrHDbeiIw==
X-Received: by 2002:a05:6000:41c9:b0:491:da8f:7276 with SMTP id
 ffacd0b85a97d-4a63928a16amr2991274f8f.26.1794979565234; Tue, 17 Nov 2026
 21:26:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117144250.1672000-1-sashal@kernel.org>
In-Reply-To: <20261117144250.1672000-1-sashal@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Nov 2026 06:25:54 +0100
X-Gm-Features: Aa3M54pt4s8JZQ09SHgzJ60SVUZ5zUG3qwR1jl-XEhQCOcpAkdJV0O_28T8TwwU
Message-ID: <CAPjX3Fd6-adZNF1hC2n1BPJW_nDOH9yGgGbpYnEY3AUnn2Jd=g@mail.gmail.com>
Subject: Re: Patch "btrfs: use bio::remaining for async checksumming
 synchronization" has been added to the 7.3-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 15:42, Sasha Levin <sashal@kernel.org> wrote:
> This is a note to let you know that I've just added the patch titled
>
>     btrfs: use bio::remaining for async checksumming synchronization
>
> to the 7.3-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      btrfs-use-bio-remaining-for-async-checksumming-synch.patch
> and it can be found in the queue-7.3 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This one is only worth for CONFIG_BTRFS_EXPERIMENTAL builds.
I'm not sure it makes sense pulling it to stable.

--nX

> commit f1d59a15198b62c45ec7062017ef72cace97ef0d
> Author: Daniel Vacek <neelx@suse.com>
> Date:   Wed Sep 2 15:56:27 2026 +0200
>
>     btrfs: use bio::remaining for async checksumming synchronization
>
>     [ Upstream commit e54f700d6ae3203221745c168dae20d88f2be4f1 ]
>
>     We can use bio::remaining counter to sync the offloaded checksumming.
>     As a result we can slim down the btrfs_bio structure by 24 bytes
>     and simplify the code a bit.
>
>     Difference in pahole output:
>
>     -       /* size: 328, cachelines: 6, members: 15 */
>     +       /* size: 304, cachelines: 5, members: 14 */
>
>     Moreover this will allow us enabling async checksumming with encryption
>     where we need to checksum the bounce bio instead of our regular one
>     embedded in btrfs_bio. And so we need to extend it's lifetime. This is
>     the preferred way to do so.
>
>     This also fixes a bug in experimental build where the async checksumming
>     was using the system workqueue instead of fs_info::endio_workers.
>
>     Fixes: dd57c78aec39 ("btrfs: introduce btrfs_bio::async_csum")
>     Reviewed-by: Qu Wenruo <wqu@suse.com>
>     Signed-off-by: Daniel Vacek <neelx@suse.com>
>     Signed-off-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 19b4855969f53..771b7d598aeee 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -103,7 +103,6 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>         bbio->can_use_append = orig_bbio->can_use_append;
>         bbio->is_scrub = orig_bbio->is_scrub;
>         bbio->is_remap = orig_bbio->is_remap;
> -       bbio->async_csum = orig_bbio->async_csum;
>
>         atomic_inc(&orig_bbio->pending_ios);
>         return bbio;
> @@ -114,9 +113,6 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>         /* Make sure we're already in task context. */
>         ASSERT(in_task());
>
> -       if (bbio->async_csum)
> -               wait_for_completion(&bbio->csum_done);
> -
>         bbio->bio.bi_status = status;
>         if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>                 struct btrfs_bio *orig_bbio = bbio->private;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index b7bd377a01624..bbf362b8668bb 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -58,7 +58,6 @@ struct btrfs_bio {
>                         struct btrfs_ordered_extent *ordered;
>                         struct btrfs_ordered_sum *sums;
>                         struct work_struct csum_work;
> -                       struct completion csum_done;
>                         struct bvec_iter csum_saved_iter;
>                         u64 orig_physical;
>                         u64 orig_logical;
> @@ -93,9 +92,6 @@ struct btrfs_bio {
>         /* Whether the bio is coming from copy_remapped_data_io(). */
>         bool is_remap:1;
>
> -       /* Whether the csum generation for data write is async. */
> -       bool async_csum:1;
> -
>         /* Whether the bio is written using zone append. */
>         bool can_use_append:1;
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 2c6c14dfe3932..ae1fd4da38d31 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -819,9 +819,8 @@ static void csum_one_bio_work(struct work_struct *work)
>         struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, csum_work);
>
>         ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
> -       ASSERT(bbio->async_csum == true);
>         csum_one_bio(bbio);
> -       complete(&bbio->csum_done);
> +       bio_endio(&bbio->bio);
>  }
>
>  /*
> @@ -855,10 +854,9 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>                 csum_one_bio(bbio);
>                 return 0;
>         }
> -       init_completion(&bbio->csum_done);
> -       bbio->async_csum = true;
> +       bio_inc_remaining(bio);
>         INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> -       schedule_work(&bbio->csum_work);
> +       queue_work(fs_info->endio_workers, &bbio->csum_work);
>         return 0;
>  }
>
