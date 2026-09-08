Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E63C81B5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900740; cv=none; b=gCK7d1q8jHrqNu6Y0bA+9CGT42c3hsuiiu0Uo0DYa3Tey8Vhl3Fwl9UTIcb+kPeGAKSf0yceBFdQb9JXLRHaIpAjnYaDZE3OCF2cI/DBCBtFEgrORWQCeLcKsDVzIIzNpMR77y3c1F8D4Oac1oe7YEJ72q/rsazhnCa2Sq4LmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900740; c=relaxed/simple;
	bh=/T8Ge+0H/oozUNaNPsKgNdMMXhldvR/6NLwBw+hfiYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVjWwFRw8xgr+YuyGXmgf18Ddh3KLA+3eCbm+5dw6kOqzklLSJn2mW15WrIaOEJ9j2Fb29EuBdnDUx4DqwfpHfL7Hu14MnH/x8eGILUvV5hwj7rRrYinEJ5VKDIvyt4dfHz/RtQdv631C0VmyMG4Ec6jlksaPKrt2O9x6RKeqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrpaBloj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrpaBloj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso42963065e9.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900737; x=1789505537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A0mtaTtQYz4wQ5P5X6eMd5pS4o/Mqyck5LWsd7xeYwc=;
        b=NrpaBlojtxSz8WyvmuugbJphxc01wu5ceybzwykacopowV9s4C4q+obdyPU3nIzPTm
         bEXisvfAFNHM8zUYgOGUyhyXRkRqyyANz+ReyZJf2sirJ8tDB7vCKg4zw4VUyzGdId2N
         0kY1s5I8IoQUXcK0kkoQ//QpeVnNE/u7O4qus+ggQo75AJjhvJaUiCkol8I2VtKVYf3p
         qRU+/+OG54GP8MkmJODHAQePl1YSxVsMEsL+Tkq1+qttf4jjJBSU1mzT6/5VfU7e4SDo
         EtI3n3tJodmcn90Ki/zinDSmKUhw4bI7FL9uvB2vesOsVYeEryHU7AJxQ5c/d+i9cUir
         HF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900737; x=1789505537;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0mtaTtQYz4wQ5P5X6eMd5pS4o/Mqyck5LWsd7xeYwc=;
        b=R+JRK/y7DALV+/gBBURNvOYGITQFCu87FDv9ito49NlCSESKMj07bsX72aSLVxfjTD
         zTIAI+e0uFpgjep8NqwnPmACDE3g2CZJxEB6GE6HOUvzlYiljUH+I/HpbaTd2+aVX8zk
         hpEDVFxUOtsnxbSSmHXlkc2+Ig5c85IWCHb+01VovRWd/idbVIFm553frxtBr88ilMyf
         9x8u5rWVNjWWv6v0A1brfNZEmObBDjWQXCm2Lp1KM3uxNDdh7ixmoOCZu6jesMBFZIJY
         POoatqjqO4gFvtjDRS4ZQ6e86lYJ6fS2FYdRtdZuXPsG5ak4hilvirXsLL3ALWXByBaT
         o7mw==
X-Forwarded-Encrypted: i=1; AKwUvBzQ8lXVhtLzHISprCRRMDcaa96PogaPVA08O4Bl669QBLG28An2IUNdWfb77ghKDsNaNTQOEsA=@vger.kernel.org
X-Gm-Message-State: AFuF++mMfIqC0GRslptcAAZX3zz1rQd8yonSkIJsKMxlX6i5FiBMBHfq
	/cL/Fp7VNbAATOYK7H/RwLw0XF7+ii7tv1P2u6kg1RzN9TXc8hzuHTZA
X-Gm-Gg: AYBFou3AmdXyE8XIIiyDfFpFWcO6zWektFr3gQX3oDvv6HoV2WSvj9nyT9pdmeEthMP
	Bi8PhH3aLmFBaugpt+n32eaY0EVdu7m93Rzn6/BwDgct0zheYylW0UOUOnVngQeNGT+1v465JRn
	qKO2z/GEcIJrM6Awyk8EIJdDlqsWnTs3nFL6ZV7z1M4luy1k6nZxOPLbQLEiekNqUCfQUhydSJQ
	J+LE2CVrWpCuyINp4G3yqMAtfnByDetgP50mQ1vbE2sw9ujY3j/nUSu4SWjTeyAK8AxfswETK/5
	2Nk5PsHSQo6yF6TY2j/Bu4m6gF13oQq7zMQ2NHlq0p2XBjp9cTRBdMiJejKnmuHzRoPbSaRavqE
	E5GSM2FCZ+qAlFQ48FNDs5KA+Be+QJ54LqkjncoyirY5FwxXrmFETnMiRUe5q27pfEjifkqg/6R
	vZ79w4wusO1TYRP4RTt4vAdjf4F97gjFmoBW9F/JTTA+p2lMPnKDwCc0MDLQzBU/Xl0G/KxtNbK
	CtnkJIve492+6XlCUxYgmDFlw==
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr411374975e9.12.1788900736223;
        Tue, 08 Sep 2026 13:52:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm368295445e9.14.2026.09.08.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:52:14 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:52:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
 james.morse@arm.com, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, stable@vger.kernel.org, usama.anjum@arm.com,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v3 16/21] arm64: percpu: Implement preemptible void RMW
 ops
Message-ID: <20260908215209.01f64b82@pumpkin>
In-Reply-To: <aqAkvK6zylxwq5J2@J2N7QTR9R3>
References: <20260904161758.376504-1-mark.rutland@arm.com>
	<20260904161758.376504-17-mark.rutland@arm.com>
	<20260905100319.0a50c17f@pumpkin>
	<aqAkvK6zylxwq5J2@J2N7QTR9R3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 16:07:40 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Sat, Sep 05, 2026 at 10:03:19AM +0100, David Laight wrote:
> > On Fri,  4 Sep 2026 17:17:53 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> >   
> > > Use the PCPU GPR infrastructure to implement all of the RMW ops which do
> > > not return a value.  
> > ...  
> > >  #define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\  
> > 
> > Isn't this definition exactly the same as __PERCPU_RET_OP_CASE() except
> > for s/tmp/ret/ and the 'return ret'?  
> 
> Not exactly the same; the __PERCPU_RET_OP_CASE() assembly also performs
> an additional instruction at the end in order to generate the RETURN
> value.

I had missed that - it is only in the LSE atomics alternative.
However it also replaces a nop so wouldn't affect code size or
execution speed.

David

> 
> > Since the compiler will just ignore the unwanted return value
> > there is not point replicating the definition.  
> 
> We could consider sharing the assembly, but it's not quite that simple,
> so I'm going to leave this as-is for now.
> 
> Mark.
> 

