Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755643655E0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995735; cv=none; b=O0YuJVIlONFZLbehV0sLU7ksajqMJuGsQqRySkkVr5RkifbXlMzEAVCQwA7/vMxPBDGYAiWYkU3MA7b42JOkPKqoXpaH+lv6QV/qanZpAK7tLti5w2qPCPI+5tjqxmia3OT7/mdF0Awj4XYLbM1YSpbhiMxJHft+n2VzFmrT20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995735; c=relaxed/simple;
	bh=vZPEqbc76leFg0jCNLJ8ZIJ4OGRVsxYaxTANcWFl5Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyjX0As+lKya72lAY6h6vz36SzfaIMFJMlMU6EWoC1E1QctI4AZ8Tz3pVAAqe+KCm6x5wgYMdxuoozGnytobKhhYPNyfzwUsm7DwiDq1qi0CA3CUPQu++HjX2JXMql0nlIoSsFvznaxtS9Yh0ajM32XKrtLBL12PqkxpAeQQaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=axzA4YVM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="axzA4YVM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53505bc6524so13599831cf.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791995732; x=1792600532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3LCiZCX1tQyW/7JZu4KAyjpWEpR2mOgBTcl8BdXvK6Q=;
        b=axzA4YVMbAaMfeUEMWy8dLdTaO+A1e9CwHq6GAe/1+FwyYVzoMWwALnsJ3RtWVl8If
         2/BwGZJYvThuvxUc4++13VZqSW8hc1DoOFP5cswtlHu3rhaBNxRWS69nDcU6CDYrLjaD
         XfIhC9V57rC603gwysO92pNcc1AHBUf8iX/R4cRy5PwMQauSqEmHsgBzj226hkeE6528
         pYSh3PDOEUNSDbKN7+AoXFTVd4IZUumhT6AxraGXIn5k+W/JeIUWbfwS6fdwG2e5LNrB
         NH47oCfG/MyjmBMfTLKdxINb5Qt2vv5PU2QgzEE4G1Frox1CsP5BDa8Q3TkD74cVZyJC
         8gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995732; x=1792600532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LCiZCX1tQyW/7JZu4KAyjpWEpR2mOgBTcl8BdXvK6Q=;
        b=KAtLTgTyJpl2Wh8g4DE95O5vAcRX1fhzeWP4VEzBnWMw/9aMCUiZE1FOSZtaO4saby
         GeAbPWUEzb9SPGH+ge23NUDrjlimrB3D1mF+CfAmQVp/wGcf/jUXbGdFJp4b4eV4LS4+
         AyASxB6enRD2EdxLBqdpbhIxlViagMBC+e6LVUd3rdWh1g2pKToD2saOLGGO8f/MHUKu
         TDB0TJvzVAjG/t6Qv54+tS4dR54vSAnWBHDriyu8fBGQxX11KDlyddp/IgD1kgxu+//4
         Z7tkW+6mZq1Q/hcCyL7imUwqVhejuoQk5Yqfk1ngWL58ttJAllqKekmAhy2HMUzGv9YT
         G8kw==
X-Forwarded-Encrypted: i=1; AKwUvBz7MMRrB4qwGgNFlK1cKxTt4p9WyhdhYf/4nPxs19/s3PiM9vK4J5rKG7/yhED5oiiUX8/x/WI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGh9ka/WaTBmk1wCCXIRmH53Mjm+f67ZUC9i6+U4BMuglqGqAp
	KAxXI5ZK9SUmOCnSA1L53z7eX8icgYGtOB3/KxYAAO2hxJUzfj/asxIiywlPcuDnJXU=
X-Gm-Gg: AYBFou3YdfBl/VYf+7kPE/fL9bL45FuyQTKlVIaJYftrFW3cysXLlcXCvakKD06KlQU
	kWTRUk+RTAJLUOa0ogH+xFvlkP1UAiZyxndQ1vjyzHwJtc8DasrecpFbHAVIr3btpAZrQMD10af
	UWmiFJ8hR+kAZZcEwzRuFLtLfEjOp0eBj1Pr/U9a+qubrgHnQs0lEj9QSjBUQIlCbWRmR1aLEzW
	JlWgx7a34AK+ihJrx26B7LDKPB0/yVXO7v2UZ635P8BAWjEQZhQcjp/HY3R4eDc+BdboArr1IlS
	ujSaA7JEd9imdVZq5PmSQZqTh9IFvBlru/KA2bXq1hNrnf9bRs+pAdT2Pu5W9mDiXP/u9JRJscR
	C4iEpjSU9wMcrFPNW4z9GYhnLOYNCW3pqOFigfKF4cVjiqF6RQAqHSAi48alPC92t8Tj8hfolP0
	TpG16o3GM4Aq51BQsz5p/KvLWYsrAfTJJPYc1R6u1pvPZSyNAY3zeVlk6LedggajRoeh6v90MvL
	GKGoeGNJCCtwnhiQZo3Rb2npG8RJ8GmnbVTSvkPWkQexyVO+BIUlXA=
X-Received: by 2002:a05:622a:258a:b0:535:22c2:f161 with SMTP id d75a77b69052e-535a618a2camr237942081cf.21.1791995732352;
        Wed, 14 Oct 2026 09:35:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536128418b2sm1108391cf.30.2026.10.14.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:35:31 -0700 (PDT)
Date: Wed, 14 Oct 2026 12:35:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, stable@vger.kernel.org, 
	Samarth Narang <samarth.colleges@gmail.com>
Subject: Re: [PATCH] mm/madvise: atomically clear the young bit on THP
 MADV_COLD
Message-ID: <as-uTYp6--OM1CYr@gourry-fedora-PF4VCD3F>
References: <20261013191719.95502-1-pfalcato@suse.de>
 <as-dr-S6c3FALwQb@gremlin>
 <as-iHm9Y4wxRTG5d@pedro-suse.tail5790ac.ts.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-iHm9Y4wxRTG5d@pedro-suse.tail5790ac.ts.net>

On Wed, Oct 14, 2026 at 04:52:59PM +0100, Pedro Falcato wrote:
> On Wed, Oct 14, 2026 at 04:37:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> > +cc Gregory
> > 
> > On Tue, Oct 13, 2026 at 08:17:19PM +0100, Pedro Falcato wrote:
> > > As-is, madvise_cold_or_pageout_pte_range() discards the hardware young
> > 
> > The function from hell... Gregory - PLEASE FIX THIS SOON :))
> 
> :))
>

Sending up selftests and reworks shortly.
