Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930474CC287
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644747; cv=none; b=vE32WXReKMBreBrZncT+T2BNyw/rBjjFpz2frpjDkEVUpBcsQouvGI+mS0OFL6gFyeZ/4dksFcQO/WmiUpc2oS5Jqun4mQcPVUknZ4uTZcMxp0Plz6MUoAMJ5ZdJfzP1X0B0HCxS0y0uIJxzRD82CmbmoV5yQdmOk2Gvoa+qiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644747; c=relaxed/simple;
	bh=fc0MBKgFMCco8akdatxV82l5kxzLDGNl9JV6szck0KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYkEvs7I0Ob8O87dMvvS2T36QMciUy/GBNxcwKs5yKSiG6n9Xw+I7AU5A/5NfW8oWjjS9CtLm14nQYiY3AL7g7rj7tLIUih9SHq8i3hIHq+o7dOROv5nIWboy16myu4YiDFfXs3Fu7W3uFUkgoQ8Elbf1qAS80k2FiNHrVqKu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RffoVAJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGB0P5m3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RffoVAJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGB0P5m3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 99DBB1D00072;
	Thu, 17 Sep 2026 07:32:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Sep 2026 07:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789644744; x=1789731144; bh=V3M7wkzr3h
	JdEaSvbv8oGCMUml7+pIaQWNZ8wU+Y6Is=; b=RffoVAJrgTXtCRxSjXtm971Ond
	42EPGdqo6KDxmUZ2NtIlgxfcPf/pWo171J4o2Nc0etdq1QZa8z48PVFUTfTFBHRv
	MmYOrPe8zpiK1BMSB7cPMqh4O4Jb991E6Lb6vVWCPtq56cIfVGgIPo/oy65HvnKr
	KZcjm73m0arZ+ftCN0OCXK0xTiIn4ziiBkSqCj5MFj3qqZEpAvV3Ej2qvoibsyJu
	yvBF6C5TYJv+J0BYz+Lfzo7pPGnR2kK6OkBhtTB/TebBAVbBdnbVsi77zmv9Ya5j
	+ii/dVtI9FNKFoXbIvLsNAnXxuM+b4/nC6VuTpIMONxK0AdUAOgO69rFvN4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789644744; x=1789731144; bh=V3M7wkzr3hJdEaSvbv8oGCMUml7+pIaQWNZ
	8wU+Y6Is=; b=RGB0P5m3eYB268Mx77KEkm5++JcUvmtMF7mYEK9zUrp4b1XLFMJ
	FVjBQBOQw91dE7RUg0iy77oGajo2E5Tl/0gqwL+a6MgIzMDcyrwC1t3RXF/5lrj0
	yUNxYHUzEmME7x1XFZCT4Ht/YW4K8Tfq00F7lzoIPrl9ZZFHrQc1HiaytiuNm53s
	oi1PnMGZO2gd97SlEo02JuqLOV4EauWsij3yRCgMm9Ly7Nx3eJYGG8rrbPRZirjj
	njcY49qNjh/FEtoe/ezF5wXjV7HeHxdSJ+4Q299AjfKkzkuli9Nx/wAe1w4SQ4t7
	S2DTXapw5JnG7GmDleqtJvshht1zLSPF86A==
X-ME-Sender: <xms:yM-rai2gWtFRs8tCsFOrHx1nqmYlDtsnPC7tm6QHHla_ZqUoCGiQqQ>
    <xme:yM-raoKib2_DK4PgJ-9EmUEpR483gg0gFX0lbL-3xGoVXaB1kaK-tiK0xkeD4MAOY
    W4ktFlHB3uTFY6hAcrfgPAP0CISV2yXLEoyx39JcsU3ICcsP1A>
X-ME-Received: <xmr:yM-raljVfqY2mHZte4i9OzO-UkHXXV1pBvRueG1THYZLVMun_t9SiYxyHNR2>
X-ME-Proxy-Cause: dmFkZTF4jFiT15z3EbwAIVeQmog/+LzdR3rdSS4kef5wRAKtv+TIqGirGhPlI3lt/OE9Ra
    npdRV3UYI/cduvupjyyRcBubDqBc0ek2p2+XQVV0pu5xb/wJAqsaf0TJXY6vhcpcl+VATZ
    ihGgF8MuZmnCTRI0LLIriieSbLkIEN6I/pn5+VyLyh8SYwpqaqNfn++pf7xtdOvIUPl7L1
    LHCZH8DKL2rLuT3Y58i3fUC5XGhl4Q1z344hzQ7uzkuHpZXdtyUYioqZUtwYmejY3InanH
    dJd/PaQ+byZU600eiJjfHAx0MA1WXA0yiivqoBpPjKCsHJ/kRFAYlYH1nYpMxYc8asiUZ2
    ywu6af9H5js+WSpF9mWDmnLnDZfbWKTmcjhXSlSD0QSea/0TDMxQOA8g08aKEB+50MQ02p
    UpdpnYTjh5CFs0an5LwLF8k7hd8evZfTMV464iynhDyAo09D6pffebmR5wu7CqkG2AbwkN
    sfCEgFb2tdfzveBgMLf04SYY4T0b2UG0AKfT2N1CeaCM/st8FprUlQPCRnuXYe1N4+u2mc
    xj0nJbMs380E7V6IFH+u331mroS2CxvNKCFjr6+UIFM880NJE/GITD4hoJ8cFO9zakbDeZ
    Gdjsj0ZeT6t14VE9f7OWO5zDTva5EOqpCWv6++f8wzQV+sDOX5/y49jfc8QQ
X-ME-Proxy: <xmx:yM-ragBe0K0zO9W0UY87QmAiw4vTVKUOrENp3VelDeXGCzlR9z0GGA>
    <xmx:yM-rav5u7HHBj7wVI_cM8UJkmY8InixGsZCoFJixmhy0MgCYkUGdow>
    <xmx:yM-ratGG_UWyesFLj_6l4kXqk96AulDjyaKsGLz0MoV0662oKlilKQ>
    <xmx:yM-raiDvOKSN1QtH01kpOExn3HB-1zPfq9sk9XYpoFcpPp0bSzyg_w>
    <xmx:yM-ramGR3Lf4pHHA42oTDYWCYjD8Cx8mKYPHYRa__-bqEvYk9ivDwCxZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:32:23 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:28:27 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Michael Bommarito <michael.bommarito@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 6.12.y] ceph: cap delegated inode count in
 ceph_parse_deleg_inos()
Message-ID: <2026091723-navigator-fall-1954@gregkh>
References: <2026090354-clumsily-rug-0488@gregkh>
 <20260906143752.1258918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906143752.1258918-1-sashal@kernel.org>

On Sun, Sep 06, 2026 at 10:37:52AM -0400, Sasha Levin wrote:
> From: Michael Bommarito <michael.bommarito@gmail.com>
> 
> [ Upstream commit 4bd3158bd62466d57ed72a3f7bc5f205fedd6919 ]
> 
> ceph_parse_deleg_inos() decodes interval sets of delegated inode numbers
> from an MDS create-with-delegation reply. For each set it reads a 64-bit
> start and a 64-bit len with ceph_decode_64_safe(), which only validates
> that the eight bytes are present in the message, not the value, and then
> loops over len while inserting entries into s_delegated_inos.
> 
> len is fully attacker controlled. A malicious or compromised MDS can send
> one huge interval, many intervals in one reply, duplicate intervals, or
> repeated replies that accumulate delegated inodes on the same session.
> The original code bounded none of these and could spin the insert loop or
> grow the xarray without limit.
> 
> Bound both dimensions with a single enforcement point. Track the number
> of delegated inodes held by each MDS session in an atomic counter and
> grow it only in ceph_insert_deleg_ino(), which uses atomic_add_unless()
> to refuse to push the count past CEPH_MAX_DELEG_INOS. Because that helper
> is the only place the counter grows, the per-session population can never
> exceed the cap, so no separate per-session pre-check is needed. The
> counter is decremented when async create consumes a delegated inode or
> when an insert fails, incremented when a delegated inode is restored,
> initialized with the session xarray, and reset when reconnect destroys
> the xarray.
> 
> A per-session cap alone still lets one reply spin the insert loop on
> duplicate ranges without growing the counter, so also cap the aggregate
> interval length accepted from a single reply. Together these bound both
> the loop trip count per reply and the xarray population across replies.
> 
> The cap is a fixed, client-chosen constant rather than a value derived
> from the MDS. mds_client_prealloc_inos is a userspace MDS configuration
> option; it is never sent to the kernel client on the wire, and a
> server-supplied bound could not be trusted for a defensive limit in any
> case. The constant is set well above that option's documented default of
> 1000 (a generous multiple), so legitimate refill behavior is unaffected
> while the CPU and xarray memory a malformed delegation stream can consume
> stays bounded.
> 
> Impact: a malicious or compromised Ceph MDS can no longer make a client
> spin through an unbounded delegated-inode interval or grow one session's
> delegated-inode xarray without limit.
> 
> Cc: stable@vger.kernel.org
> Fixes: d48464878708 ("ceph: decode interval_sets for delegated inos")
> Suggested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> [ adapted counter reset placement to the older reconnect control flow ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ceph/mds_client.c | 59 +++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/mds_client.h |  1 +
>  fs/ceph/super.h      |  9 +++++++
>  3 files changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 5f2b70b846e71..c1b48b46029d8 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -570,10 +570,36 @@ static int parse_reply_info_filelock(void **p, void *end,
>  
>  #define DELEGATED_INO_AVAILABLE		xa_mk_value(1)
>  
> +static int ceph_insert_deleg_ino(struct ceph_mds_session *s, u64 ino)
> +{
> +	struct ceph_client *cl = s->s_mdsc->fsc->client;
> +	int err;
> +
> +	/*
> +	 * Cap how many delegated inodes a single session may hold. This is
> +	 * the only place that grows the count, so atomic_add_unless() bounds
> +	 * it at exactly CEPH_MAX_DELEG_INOS; s_num_deleg_inos can never exceed
> +	 * that.
> +	 */
> +	if (!atomic_add_unless(&s->s_num_deleg_inos, 1, CEPH_MAX_DELEG_INOS)) {
> +		pr_warn_ratelimited_client(cl,
> +			"MDS session already holds %d delegated inodes\n",
> +			CEPH_MAX_DELEG_INOS);
> +		return -EOVERFLOW;
> +	}
> +
> +	err = xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
> +			GFP_KERNEL);
> +	if (err)
> +		atomic_dec(&s->s_num_deleg_inos);
> +	return err;
> +}
> +
>  static int ceph_parse_deleg_inos(void **p, void *end,
>  				 struct ceph_mds_session *s)
>  {
>  	struct ceph_client *cl = s->s_mdsc->fsc->client;
> +	u64 msg_deleg_inos = 0;
>  	u32 sets;
>  
>  	ceph_decode_32_safe(p, end, sets, bad);
> @@ -591,16 +617,34 @@ static int ceph_parse_deleg_inos(void **p, void *end,
>  				start, len);
>  			continue;
>  		}
> +
> +		/*
> +		 * Bound the number of inodes one reply may delegate.
> +		 * ceph_insert_deleg_ino() separately caps the per-session
> +		 * population, so this only has to stop one reply from spinning
> +		 * the insert loop under an attacker-controlled len.
> +		 */
> +		if (len > (u64)CEPH_MAX_DELEG_INOS ||
> +		    msg_deleg_inos > (u64)CEPH_MAX_DELEG_INOS - len) {
> +			pr_warn_ratelimited_client(cl,
> +				"MDS reply delegates too many inodes (have %llu, +%llu, max %d)\n",
> +				msg_deleg_inos, len, CEPH_MAX_DELEG_INOS);
> +			return -EIO;
> +		}
> +		msg_deleg_inos += len;
> +
>  		while (len--) {
> -			int err = xa_insert(&s->s_delegated_inos, start++,
> -					    DELEGATED_INO_AVAILABLE,
> -					    GFP_KERNEL);
> +			int err = ceph_insert_deleg_ino(s, start++);
> +
>  			if (!err) {
>  				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
>  			} else if (err == -EBUSY) {
>  				pr_warn_client(cl,
>  					"MDS delegated inode 0x%llx more than once.\n",
>  					start - 1);
> +			} else if (err == -EOVERFLOW) {
> +				/* ceph_insert_deleg_ino() already warned. */
> +				return -EIO;
>  			} else {
>  				return err;
>  			}
> @@ -618,16 +662,17 @@ u64 ceph_get_deleg_ino(struct ceph_mds_session *s)
>  
>  	xa_for_each(&s->s_delegated_inos, ino, val) {
>  		val = xa_erase(&s->s_delegated_inos, ino);
> -		if (val == DELEGATED_INO_AVAILABLE)
> +		if (val == DELEGATED_INO_AVAILABLE) {
> +			atomic_dec(&s->s_num_deleg_inos);
>  			return ino;
> +		}
>  	}
>  	return 0;
>  }
>  
>  int ceph_restore_deleg_ino(struct ceph_mds_session *s, u64 ino)
>  {
> -	return xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
> -			 GFP_KERNEL);
> +	return ceph_insert_deleg_ino(s, ino);
>  }
>  #else /* BITS_PER_LONG == 64 */
>  /*
> @@ -1011,6 +1056,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
>  	INIT_LIST_HEAD(&s->s_waiting);
>  	INIT_LIST_HEAD(&s->s_unsafe);
>  	xa_init(&s->s_delegated_inos);
> +	atomic_set(&s->s_num_deleg_inos, 0);
>  	INIT_LIST_HEAD(&s->s_cap_releases);
>  	INIT_WORK(&s->s_cap_release_work, ceph_cap_release_work);
>  
> @@ -4908,6 +4954,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
>  		goto fail_nomsg;
>  
>  	xa_destroy(&session->s_delegated_inos);
> +	atomic_set(&session->s_num_deleg_inos, 0);
>  
>  	mutex_lock(&session->s_mutex);
>  	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 8987d0ff96252..3e4b074d03147 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -252,6 +252,7 @@ struct ceph_mds_session {
>  	struct list_head  s_waiting;  /* waiting requests */
>  	struct list_head  s_unsafe;   /* unsafe requests */
>  	struct xarray	  s_delegated_inos;
> +	atomic_t	  s_num_deleg_inos;
>  };
>  
>  /*
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index d1defb6a9aefc..4cc60b403a845 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -623,6 +623,15 @@ static inline int ceph_ino_compare(struct inode *inode, void *data)
>  #define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
>  #define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) + (CEPH_MAX_MDS * CEPH_NUM_STRAY))
>  
> +/*
> + * Upper bound on the number of delegated inodes a single MDS session may
> + * hold. The MDS normally hands out a small preallocation window (the
> + * userspace mds_client_prealloc_inos option defaults to 1000) and refills
> + * it as the client consumes entries. This leaves generous headroom while
> + * bounding the CPU and memory a malformed delegation interval can consume.
> + */
> +#define CEPH_MAX_DELEG_INOS		8192
> +
>  static inline bool ceph_vino_is_reserved(const struct ceph_vino vino)
>  {
>  	if (vino.ino >= CEPH_INO_SYSTEM_BASE ||
> -- 
> 2.53.0
> 
> 

Does not apply
