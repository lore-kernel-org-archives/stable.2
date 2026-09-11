Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16613CD8CC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129429; cv=none; b=WLJ6rdXFDGB59sMBQSHQVsJYdOemOCP00509V9aomdZOPg3f++qM5jAn7+dMEJVwKInwXpYUpbDWQ3q6Aix+RwKCiMeADq90VJq3mGeNAeJAvOmKZ7ePeu2VQG5zOYAsxhH+UhZG10xwTz59c0nMB1nUg1+JB4otBpwoSuVn2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129429; c=relaxed/simple;
	bh=jgzmmBDOYPQRj3L4iSiZnb+kT/SAQNlE9ZFyRWb0hS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHgztKghv+9XGmjJjD9frMNkVtVRCSSbs4I6FwQsBfS5uI76t5ipWTRue8YrrYvXPZ0tbRRX9cxHKUSYg/Io5FmZ5rtziLPfXHokRVQ6UXh0a/MqLZvkixw08VOiJfmtFbAH3O5CeG7q3qjQYjxyqzEipPLin99e/5B5wA4RbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=bPqN75j4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKoMee21; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bPqN75j4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKoMee21"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 880161D00117;
	Fri, 11 Sep 2026 08:23:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 11 Sep 2026 08:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129423; x=1789215823; bh=Kc5k3fYXq/
	Uv5m3zqCilVZEWn7kVClhcdnDSdVt5eMI=; b=bPqN75j4N5GDjkhbnftQsPaifM
	mvbDRvALPp7ho0m4iQcfnhMj0ExUH9Dmct3wfBqt5tKF3me15UXHyhJdwVhLt3YA
	0bkN7oWyQJuiWTDwb4swgZ/bmhF0sgNbpE3NGXgVixiUG1Kw3uN9UzRDmup/JHpa
	f8vWrZz2iln72I22mScEkvKvfuxDE0JvvUyq3vhPaOrjEVBP5JcraUw+2CNdhdLI
	JjpfDwQ6FMzSndk+I3WaVt4Zmfoo/IVvNbQIIgkc7Hl2EW/1+OMDspid2e3ySoGi
	NqurKGLo2erQPrEnEBZ5o0U640X9jnQ9tyvKNjhk8+Hw38ttt/BgD+ehTmaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129423; x=1789215823; bh=Kc5k3fYXq/Uv5m3zqCilVZEWn7kVClhcdnD
	SdVt5eMI=; b=UKoMee21uQL/yTU3TgchHz1lYQVNgDrP6w0B0dAOxhSg6HEvPev
	Km954k1v412rtDuRIy0jzPLigJJ6BENJwRNfAaMP2Y1/+LFLp4aW6kYWGI3n38ix
	5DXDrgUJzh/Shz3sEroRyLi19RYFNKORGZ+Vf/rF65FH3zQUv2ZwpdDBSxTi4PGQ
	lGKiB0m6r/FSYQVugD0HKBzseTsqfkAcsZaUxZZOhZzRZHSPg+Mth5KRRi5RUYV5
	oJWmq8B3VO9elx5c0kWBi6lDNqfCS4m1A0Bm8vbZD/2I9354wAy7Aa1zgUuoFzm5
	dm121laeSqA+Qn0fPk8wTBiWOglq4P05C8w==
X-ME-Sender: <xms:z_KjavV0a4TFQUsX6bo1wiXLxWRM_1dRF2Eam6hq4AiWrYdTMgJv9Q>
    <xme:z_KjahkImqlbYP5G8bA9sKo-Jwar8ym09YlFwAQgAmwRMzqPjQClpOCuXWh9mkvIT
    1OXfWqqm_7ZdkviecIi8vfEVuqxlw55NJAVk1bQgijwY6zv8Pn2>
X-ME-Received: <xmr:z_KjaiB3JueM259q9ChsJWsoDr9UO62BUcqLP7DiwS-FBMstlhkRXsUjcFzgppkID2ibF0UQ-VcBUmpZ1LORVopeIX6q9-gTE56GJr7l5hQ>
X-ME-Proxy-Cause: dmFkZTE+6EtaDKw1FhMvfcnRri4SgjWYnFWmAFh7um+ZvIT5cPTnfVndZwC6eLRXypZhk3
    AI0iNquSPX4B7H3xQILtOD+Xt7tVM6TgXZEe70ofy9xhNdmKlffYIbIQiTT3bq4yoou2mX
    ozVD81Fc2KVz2hT/rbH5rU6DbeQwImUVE8e7X2rCGdkaYMCW9mDV77hgd02M+WQ54LJncU
    ighyqUn0fvyhPecQJQZfefjgWNLf3cjsMCdUEZ3I8cLOH65nF6Jeq5CJTdjPsfYgPPpijy
    JOKb6DBUfkXR/3O08kKWgs8OhJQD0ZOmsmLvGPGO3pJrYm7dpKCGlYfY5EiM29u2FOlDA/
    ajwPjuUmSen/oo3WJevwS/tCyCs375ZuMVFV2ZI0nyM7i0IZWe7COYULPIisrGY9iT4UUQ
    pNNdrCUZ8VWJKjX+kjj5tL55RHFN97mKAaeW6l41uFlSRulBhP75cxddEYry8Ni2p54gch
    m+WYNP6xXktjk81bvZGQJWVa4WLik7JlVgBkbHwMV1sPt8nSpdYJzWavUouhy1YIJ8bt5y
    JpeuNT+3ybrvLpN8FoGfJV+tnIqmwms4tQXzQHYTdNGYH0PyjIiS8K0v2xbk0sktC4YNid
    vhlNWgLqCyC0dYLZPhfWwFsbrlz4q0GIuxLF+cIPJ2E6BoC6dJO2YIlVQeBg
X-ME-Proxy: <xmx:z_Kjaoh2n2w2Rv40QrPhNVA9WUnEh0ay4O1URH92s6FTRwuSIgjgKA>
    <xmx:z_Kjanz4hjyeWiXaqZAhbgDE8xBJScS5DPgBla2gkf2m-sXqYIOHxw>
    <xmx:z_Kjah0Vu9Xxvn_TjwbqoFOGer0ji11koTwzcmiKRG6WjyR6-ou9qg>
    <xmx:z_Kjak_geTkYxXkL7abSA_y9SSS7TkkuZcg1yxti_i8pPNIZh4U4vw>
    <xmx:z_KjappslQL8rEfnHNmmrTGSppOcDgOqoSWOILv_mocVFn2CkUKXyupc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:23:42 -0400 (EDT)
Date: Fri, 11 Sep 2026 14:23:32 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 7.2.y] dm-pcache: reject a kset that overruns its segment
Message-ID: <2026091127-bubble-cupping-a7ee@gregkh>
References: <2026090425-mutiny-unsent-560b@gregkh>
 <20260910001834.3752050-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910001834.3752050-1-sashal@kernel.org>

On Wed, Sep 09, 2026 at 08:18:34PM -0400, Sasha Levin wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> [ Upstream commit 7ac1f10f987a2ffae4aecf0e2ceca8f552b665cb ]
> 
> cache_replay(), the writeback worker and the GC worker read a kset of
> get_kset_onmedia_size() bytes and advance the position by it. A forged
> key_num makes that size exceed the segment's remaining space, so the
> advance walks past the segment and trips the cache_pos_advance() BUG_ON.
> 
> Reject a kset whose on-media size exceeds cache_seg_remain() before use.
> 
> Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> [ backported missing writeback_errors support from the upstream dependency. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/md/dm-pcache/cache.h           | 1 +
>  drivers/md/dm-pcache/cache_gc.c        | 5 +++++
>  drivers/md/dm-pcache/cache_key.c       | 5 +++++
>  drivers/md/dm-pcache/cache_writeback.c | 8 ++++++++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
> index afc112b79496a..93c1e699a3944 100644
> --- a/drivers/md/dm-pcache/cache.h
> +++ b/drivers/md/dm-pcache/cache.h
> @@ -180,6 +180,7 @@ struct pcache_cache {
>  		u32 advance;
>  		int ret;
>  	} writeback_ctx;
> +	atomic_t		writeback_errors;
>  
>  	char gc_kset_onmedia_buf[PCACHE_KSET_ONMEDIA_SIZE_MAX];
>  	struct delayed_work	gc_work;
> diff --git a/drivers/md/dm-pcache/cache_gc.c b/drivers/md/dm-pcache/cache_gc.c
> index 3088cfef951bc..99999a92c4e67 100644
> --- a/drivers/md/dm-pcache/cache_gc.c
> +++ b/drivers/md/dm-pcache/cache_gc.c
> @@ -134,6 +134,11 @@ void pcache_cache_gc_fn(struct work_struct *work)
>  			continue;
>  		}
>  
> +		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&key_tail)) {
> +			atomic_inc(&cache->gc_errors);
> +			return;
> +		}
> +
>  		for (i = 0; i < kset_onmedia->key_num; i++) {
>  			struct pcache_cache_key key_tmp = { 0 };
>  
> diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
> index 51dd1ccf4e2fd..93933651d2c96 100644
> --- a/drivers/md/dm-pcache/cache_key.c
> +++ b/drivers/md/dm-pcache/cache_key.c
> @@ -811,6 +811,11 @@ int cache_replay(struct pcache_cache *cache)
>  		}
>  
>  		/* Replay the kset and check for errors. */
> +		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(pos)) {
> +			ret = -EIO;
> +			goto out;
> +		}
> +
>  		ret = kset_replay(cache, kset_onmedia);
>  		if (ret)
>  			goto out;
> diff --git a/drivers/md/dm-pcache/cache_writeback.c b/drivers/md/dm-pcache/cache_writeback.c
> index 3df8687e2382f..656e4d0489121 100644
> --- a/drivers/md/dm-pcache/cache_writeback.c
> +++ b/drivers/md/dm-pcache/cache_writeback.c
> @@ -229,6 +229,9 @@ void cache_writeback_fn(struct work_struct *work)
>  	if (pcache_is_stopping(pcache))
>  		goto unlock;
>  
> +	if (atomic_read(&cache->writeback_errors))
> +		goto unlock;
> +
>  	kset_onmedia = (struct pcache_cache_kset_onmedia *)cache->wb_kset_onmedia_buf;
>  
>  	mutex_lock(&cache->dirty_tail_lock);
> @@ -246,6 +249,11 @@ void cache_writeback_fn(struct work_struct *work)
>  		goto queue_work;
>  	}
>  
> +	if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&dirty_tail)) {
> +		atomic_inc(&cache->writeback_errors);
> +		goto unlock;
> +	}
> +
>  	ret = cache_kset_insert_tree(cache, kset_onmedia);
>  	if (ret) {
>  		delay = PCACHE_CACHE_WRITEBACK_INTERVAL;
> -- 
> 2.53.0
> 
> 

Does not apply :(
