Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029677;
	b=SBheaY9g0sLfiPg4ffyOfQUHMzGmHuUCOekk+73TF1zyaviCEubajFecsDB6/+Kpc5DE
	 mMvUjdMmDZMQ5g8Ae8WpUZJAVwkqCS7M0aborxN/UJlw6OSN5Ho/ZXE0Z3w+6XqNnDXs0
	 9Ke8NbO0RsEQslKa++B+nEK8+/VB9VxtRcVjW4osSBE95z0ODxvToHKmcZXjsXLf1xC69
	 j6d8Tt/oRYl1AqSfud2jqim8yRc8zfXoaRw96IIpP7vRJHGxbsVJtsyLUycC/Eo4pOeU7
	 PIuuHj65gbOMQ0sZ9wM2/G7/hgYy9dmWgkyIi9NazVgaKbURzQZK9sksRhFbIr3S1cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=35uD3sVJLZUeRHcPV8RyOPRby60btWRa2sdjDc5SOss=;
	b=rDG+YuBUYyvCOzdBuuWz29wROwl06nzAnGt4uqy4IuJRFG0HBIkDCLe9r8e8RqhFxZLf
	 DvEcsoc3uf0H2mi/KlD9iZ0L+aZcRNpPQn6toMzWpVmKybrx2awPP2uFY883TkUvaTLAf
	 Bv6VHmpQtk273ZC4x3SWKXNNjhJZtI7xF3uD7HP137EqCMWbzgJ7XVGw48ei90saPVB//
	 H3y0gsVhF8Db/pfBN9KArGCKNhz6MfGjNMWcymQ5EJGBOgfLIOf9rn7oJ2ZvEmTGMVVwt
	 cDMqHQnyL9RkKXS5eHVunliT+WYnVpIUxSVDqEsvzgVhwuZpbg7+plE/rk91JoZh/qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=byeEQHUb;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC9606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CC9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=byeEQHUb
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-917997ab0d9so34715176d6.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793029670; x=1793634470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35uD3sVJLZUeRHcPV8RyOPRby60btWRa2sdjDc5SOss=;
        b=byeEQHUb9OieTIHdICY6bBwgtkoir/eSMZRVgp0AgET5gmLTzKoGnbdPTANdmvWh0x
         R/w21WuGyFo3i0Wn8ZRzJcbCzbVowwmFMUFcY9tthfzKWmDvvFE4vC3vDAj76ccxPUrU
         QjOeAPjy+HI3uU8nNAGddmdjUVXhMF60qe5SGvsHvO5fimwTxVuQAWTnT2bP6Ox7HGVE
         wgNWlkJrBQ4MJ7/3aSElBcfFX7WzqjY/OY8DdVFQaZd1ghqVk9n2w9EiCzNi0qQzg9IM
         /03JYdoZuMiqgGa9xspW9dHEXKBLJsycQp32/ZQuXaBq2pTeurr7DG3rO3sBJMu7JDXW
         wVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029670; x=1793634470;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35uD3sVJLZUeRHcPV8RyOPRby60btWRa2sdjDc5SOss=;
        b=O7b4bDiA4ExpLkLLTTgFed52w/HR4cN1miMN4nAIKNvC/3WAeFILeUnbZpZcIdLuhy
         tvMEqe/Hrt+4w/kY3VHNCFkpUwyf/0pgGvuYu3YrC+djhUrI/JrroFPSQn7/mTsTe8lo
         +KCPLQUAASJZLhqq6tqCoJRXL2qDS/R54OKFGP8Cod8o1DkPQ7DBjhUqeGn9cHe7FLcY
         kwzQWp7BghAYG9A88oFSjNPFmS/K36bqJ1zjInyI4xnSt1XzGyymdJ4Yj25aYMIAd8Yp
         Fr183gLw1hfQOR8oVczvKm9x/vxy0v7BpcFormR/4h5R3ueFwEXLe5Jscc1fP6M4vyst
         Xj/g==
X-Forwarded-Encrypted: i=1; AKwUvBxZYEsP3Gz5/VIcKkr3LcnomrBQ//HyWI65+eMI7CWYJDpTSNVvt+iZLXb6BtzofoNyLD/vdFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/TrN+Wk4BDNcC8auubnfmVVt95PEG1crxNxCireszBLbNBVhc
	KGMwwkBCHXh/8IPR1p4LqIsig7rVFjU8GLbcuu7ELbF6tAV4JYfAK8t8PShAiFq91pA=
X-Gm-Gg: AYBFou0euIo2b8Vg15HTFAlUCSsu2VLiPwVg3X8DlBNMJSaitmYqG4dH7asP9lwLFMB
	ZnuzzqjFd9zjSfYg9bBOSP+RNYroDK2uDtN9u+NvWOIHWJB53uoJgIzDInN7s5cxTub4MbpAi53
	/qdngCWgrKzK15WH5CGy0TrhrHOxsOf9DvrFgnupKeNbJjY2ct82nte9UJn5YE+/eybxy2R/+KY
	oCwwfHloU7a3uJuQjigY+U32RV0CE6IIZLJd+2WLRV8oJup3dYYjaTXvQXiTCIqfj22DkIdal7q
	X+RG+VgXWlhknPwrYlQjdmkXqoncztbv3z3oMj9yI+XM703hJPP1ZNteZNbmrdfdY2XEG1XRCr6
	B1nNO5L0agaS2CsPMA8W9bGTFbf/vr38jGHfSPF+PKkRu6a6g1hAyMa+DvOfBtD7XbMKppFNrWe
	c5nXsRvrLPYvolVaqaSl0H6bqztAW7dZUwCBxxVgzQ/QqPT2CNFaJlGzNiSsRsDj+Y9dMyx7VWm
	iyGjNQughFAaXvCghwt4Ldwneg6jHO2BOiYa7mRIllLmZdVgoFEaY5wL7QMJYPjEWwyOGI52V2k
	QD2okNaZEVMdLLRirABq+cHLW06wWc+BdhtL
X-Received: by 2002:a05:620a:4515:b0:93e:48fc:aa85 with SMTP id af79cd13be357-940ef9571aamr1034017685a.43.1793029670123;
        Mon, 26 Oct 2026 08:47:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066731esm719609385a.9.2026.10.26.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:47:48 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:47:46 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, honggyu.kim@sk.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: recompute automatic interleave weights on
 memory hotplug
Message-ID: <at91WFlW96PH-a8A@gourry-fedora-PF4VCD3F>
References: <20261024170415.4121901-1-gourry@gourry.net>
 <e3a1ae72-9370-4c3c-8935-6a410a74377b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a1ae72-9370-4c3c-8935-6a410a74377b@kernel.org>

On Mon, Oct 26, 2026 at 12:19:21PM +0100, David Hildenbrand (Arm) wrote:
> > +/* Recompute the weights from node_bw_table, unless they were set manually */
> > +static int wi_state_refresh(void)
> > +{
> > +	struct weighted_interleave_state *new_wi_state, *old_wi_state;
> > +	int i;
> > +
> > +	new_wi_state = kmalloc_flex(*new_wi_state, iw_table, nr_node_ids);
> > +	if (!new_wi_state)
> > +		return -ENOMEM;
> > +	new_wi_state->mode_auto = true;
> > +	for (i = 0; i < nr_node_ids; i++)
> > +		new_wi_state->iw_table[i] = 1;
> > +
> > +	mutex_lock(&wi_state_lock);
> > +	old_wi_state = rcu_dereference_protected(wi_state,
> > +					lockdep_is_held(&wi_state_lock));
> > +	/* NULL wi_state assumes auto=true */
> > +	if (!node_bw_table || (old_wi_state && !old_wi_state->mode_auto)) {
> 
> 
> I was confused about the node_bw_table check at first. Maybe
> 
> /*
>  * We can get hotplug events before any BW data was recorded.
>  * ...
>  */
> 

I went back and forth on whether to do the mutex in or outside this
function, but ultimately decided inside is just better structurally.

But yes, this comment seems warranted in this case.

> > +	/*
> > +	 * HMAT and CXL report a node's bandwidth only when it first gains
> > +	 * memory, so recompute the weights whenever N_MEMORY changes.
> > +	 */
> > +	wi_state_refresh();
> 
> If the function fails, should we at least pr_warn_once() ?
>

The only failure state is -ENOMEM, wasn't sure that was worth warning
on.  I actually debated whether to just make this a void function.

I don't have a strong feeling here, but happy to add a warn if you
prefer it.

~Gregory
