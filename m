Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684635;
	b=nRiBYYtVp5o17didizmnNbiY82DO9tRsPBQMRocwPPFeVSzjCjo6w3340H9AlvkQ+hq0
	 yfcYp3S91tekYFKGSs18nYX/Xb/3v1nTLwS04hsQLQLT/0s4J5FFODa3eQ7N571EQjR86
	 Zv2xuMK+FV0Vf6cfPaAUGFTb/2Ze42UhxPRXS9wZazimd+krqNgO/doEQpPUtr/UcMTF1
	 orQ0ELGL3gUahKzHKICWY9BLhNW0KEpZnzgh8Rvs9JOAoLYUn8/7/074Soo4n+PLQ3T7q
	 sBui8x1qvR0BDG+ydBr28oppuKej2rcQ2FtVYb2BiBemxgasQRxAaS2zsulHdhYTXng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=C/z0kFZffqp1LFtR2rltFphJVQEqkB2za+Qwi9gT7eY=;
	b=NwznK4iS2oq0XGDFODfoGUNkme7re5nOZy3KVjTSGHamL53gv7Hct8SNV2WhP3nz9DWx
	 oOvK1L0JRGO/bsa0dRNi2v/LJlUUgoLkS1VcqsezL4ZdkW7pIFyWDNiSagl5xs/ZFRh6a
	 tzSMsqYifXvMPnePCjJDL7DtsyerDKWJYMhfkSx4xhZ/1PsAH+E5o4oHZqZbmXgm3zCUn
	 awsozb79PoP7GoXxn7chiyVowspv/A6v53z2LQzs3YeZbN/rmTsdNbR56sduJ4dTnLTB1
	 oCCXNQuQXGvpvz/CnhB2AsozpT0//fJBRDm1h0KF6Ow6RwiNUsaoSAifIpi5a/KwEtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6p70MTL;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCA606A33A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CCCA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6p70MTL
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b40b3772f0so816696a91.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795684634; x=1796289434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/z0kFZffqp1LFtR2rltFphJVQEqkB2za+Qwi9gT7eY=;
        b=r6p70MTL3/Xp7tYLBv0xUqK504I7RvC/GMoANlXUQwqgpJFW0Q4Y2tC2alhflbNCcq
         /A8OA8nFLlUaOsHPDDxNBtdwCZPltr1p2LvUwRUQhOyArmF/IR3WwgGe5dXg6IfHlKNS
         +CdwQ4IQmsDjXCIdGvgan72z07pP11kM/KVZ7xqRc2CWoZryv8mmX51MM67mmPj4Vmd8
         AxWq64uSSQvpvxxiJteq0d46UF1dtU+vczWaEJGHBm41Bpnx1gBebTGekyVP+MR/n0dn
         7+pRd2c9o37KOdlt2eNX23MFQlOe1WECONDYqFpdILvnKHPceVidEXjVbPBliyfgliAY
         EYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795684634; x=1796289434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C/z0kFZffqp1LFtR2rltFphJVQEqkB2za+Qwi9gT7eY=;
        b=aNo81ez33WdQbqpO7ggDPq1ZHUYKTmX+6PBlE1uIVJlHA0jvPgrNmFtIcqqeXR8c8x
         L4MWpqsP9W1JM75QX7kz9bLlhqcFrc6mK6e8WNXvD36b3sYoODVJ8Tf2XlyqkhrgSfYI
         H3QaBuzzPWzeCkareEiS706XnKa6se2m9cNQuaHJ/m9RowZDUH2JC7iMOyAWasKROuWx
         ZKOAWywE/RHib/fFN2SoTARvOKgOEEM0QuyNqNNZRtik7dbUBI77A3sogX3LU9+7EUKI
         1CcNO4xIx6/P+pizAksNNFc5QvT9ofZH1k6/3jHl74wBKJpPIOMTe7EPC9yxAyPpm5sY
         JURQ==
X-Forwarded-Encrypted: i=1; AL+hErE70K+JLX3cKS5muRHNH+lQGDTlo5UyTI3G9+1ymOiZPmUT9v53fjgrzD/CMUldvFGq7P1ImxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1rOOPZ7e8MSsqO5xWB9ZUD8feKGPGTiVzQilwySN9LQq+J/ED
	HItcT7mkl4MEeJXbmQ+UmoCJuD2wVZxsz7/VAowaIr/37cAvl+xhgHgn
X-Gm-Gg: AZFdTZeRD41Dmo2qNOmcVhHd91ct1ODNBjb6sShNWgpCWx5VwmCo7JCaoNzoau/+WCs
	IJC23LDJsR19O4UWN6K+xQ5cI/Y3JUuaXIU5iikKesur1WY2/931Zd4MOf3qpZJeOO34ACNWIww
	NAsEFlHE0DpaROg4NQ+hPRM+dmbuZqBzUL03Wq5Zf8g3HntPiVbeY2odtmRUd5SbNZJESBsaSAk
	IdOsafRtP9dJJnTm+k5FTuFfnBFni2NXTG+SCUTSplOTttkHqMq8/MBhDiF4hgiRMPOOAIIr2Fg
	c0gcrZKnFckGC/s6Q1SKVm//FlFdmoVf23egKdVTmma4psCWiyJpZ82aKr0q9a6C+YrAkBkXw8d
	uW7TkM2azdvT7XAlp+O0+DMLHh32+I2bkIyideWumXPmQYj91Bg4ABZaojFx8XdzkNz8t93cfgz
	OuWTgpjdIW9u3fr3UvOmO8j+qz9LYJ50c7x3u2O2Y06V4bz1B1I0NOFD6gsaRaIoVmaiAJ2ZeRo
	VRIQLdnG6lpeca9mFZAbcA3SV5aiErUJBa7dK5/+lr49HGVaBAQ/RrGii0p6NE+W0i7LZXIlcuE
	nZucf52rAdc41MsFMBSssoAqIGVuoXUVJeR74U9WQsz4HQ==
X-Received: by 2002:a17:90b:498c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3b41c55b914mr29233956a91.0.1795684634345;
        Thu, 26 Nov 2026 01:17:14 -0800 (PST)
Received: from gmail.com ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm11023723a91.17.2026.11.26.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:17:13 -0800 (PST)
Date: Thu, 26 Nov 2026 17:16:42 +0800
From: Wenwu Hou <hwenwur@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <awf4-hjPFkBxPUev@gmail.com>
References: <20261125084600.2306377-1-hwenwur@gmail.com>
 <awbklFE66PIMKFop@localhost.localdomain>
 <20261125103822.2129a7ec@gandalf.local.home>
 <awcLwio_qyE3d1bL@localhost.localdomain>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awcLwio_qyE3d1bL@localhost.localdomain>

On Wed, Nov 25, 2026 at 05:24:34PM +0100, Frederic Weisbecker wrote:
> Le Wed, Nov 25, 2026 at 10:38:22AM -0500, Steven Rostedt a écrit :
> > On Wed, 25 Nov 2026 14:37:24 +0100
> > Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > > >  static int kthread_fn(void *data)
> > > >  {
> > > > +	unsigned long flags;
> > > >  	u64 interval;
> > > >  
> > > > +	/*
> > > > +	 * kthread_bind_mask() sets PF_NO_SETAFFINITY to keep the initial
> > > > +	 * affinity from being overridden by kthread_affine_node(). Clear it
> > > > +	 * now to allow userspace affinity changes and cgroup migration, but
> > > > +	 * keep per-CPU threads bound to their CPUs.
> > > > +	 */
> > > > +	if (hwlat_data.thread_mode != MODE_PER_CPU) {
> > > > +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> > > > +		current->flags &= ~PF_NO_SETAFFINITY;
> > > > +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);  
> > > 
> > > This is not pretty but moreover, is it a good idea to let the user override
> > > that affinity?
> > 
> > No, but we used to. Perhaps we should make that not possible instead? :-/
> 
> Right, the affinity should only be changed by the kernel if tracing_cpumask is
> written. Otherwise it doesn't seem to make sense to let the user play with the
> affinity.

I agree. Perhaps v1 is better.

> -- 
> Frederic Weisbecker
> SUSE Labs
