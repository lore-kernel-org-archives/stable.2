Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2A3624C5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263854; cv=none; b=STVsfR/tp50oSRctGpZGYZvSRT4pscjDdEbZjWX+goYbTj6h3KwBgpwrUD//YRNcqijtP1AnamdhUngN9Pr0NtRrVVSuKalwnkvXQgiQcddvI0az83SReA+aLEJCMjv6t3z/7YfCiMSvPWZO98HjGb4Eyd5JbIdqp5QJNLu/ZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263854; c=relaxed/simple;
	bh=fYX0YsAcdzC3xGEnENhr8nj3ott/n5K1kE753y4IEY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUHFJn+zn7F3R01N7Y5pQF2W2qEjMoR3A9MLjck81u/0EbvNTes7Ef+rbfOxHACeC4Q1aGK8fK+7fzgklOPWG6HKrUkOvWTNNbhH/RgDT6uI2OT91hvNmwuUuJ63+E54eRuZxzIFskKP/mDlXAYavo2LPg5PsozI78fk8IWhork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ZZobjISj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ZZobjISj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9db539a54so320875ad.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788263852; x=1788868652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhTA2r8ETchpWXwEm0IQgD6dzKUlsK2Lh7nqwYCs0is=;
        b=ZZobjISjfj2FXJOdLSNPxxP+qsEfbeuJs9jBORYUd8TArWG0YcQQX/iCoDufCvU8Ey
         9vtA68YxO9j1Ijil2ZPAaKYq6ra1+UEHEk+pvPr9Aw28xFdl1x3AK7ATw8aAXXlUUeDP
         aEcXKAkMR32QohYN5//ShcumNTOsC3+hK5qEFSqmaeYnxPi7aqcNxdELRIaCSXFEZphr
         pX7Pa6Q15rKIRGrRi7hZKqo66j6K11EfCnJfnDqUB/mLlxMjbxSw2Xgu9oWge12flbNQ
         /enWngI+0t0NM37dHKVK88ypRD8aV1v3pcwAih9XGvbCdkBcIR1JZ0ABt8PR9cPvS+gl
         08DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788263852; x=1788868652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vhTA2r8ETchpWXwEm0IQgD6dzKUlsK2Lh7nqwYCs0is=;
        b=c9327yguzQOGyH7u66FsOlWhwuFeHHNXHw4V2QpLgiL9Zt+YZk9azBSHMY/AfLGofi
         S+CzM1uGvVPQnAO4GOsjWVQXbkT//yHOuEAaawACVfb2vp/DkYV3ojxs4eZDR+KLkn5P
         LBF1W6e9QYB+3oEt19ZCzRMsDRAoFplMhchsyfb0eyx2lpj/j0msn3/R00RRbcHtL+8l
         kKuh7LYrFz7mUMSGl6CKHRYoZ+Bj4QnuEl0p60oQCNGG4i5v4Wqiyms0xpNbAVYOiupE
         bAUGD3OrNUVJ7Kc/vrYjPVBaR8OSal8rPFgIpjPixlCa9xomZtQgqKAggzH6UcBrLrN6
         v3QA==
X-Forwarded-Encrypted: i=1; AHgh+RrikONW7FzAkGIU38KLyhcDpxITovEe27Gtnbt3KTG5aI43VvYbmLX/SBrsHQzlZridztwNOBs=@vger.kernel.org
X-Gm-Message-State: AFuF++nz0As1+VCDyNg2Ug8uwzJ0r1n0O4DKSF3gH8Y7VsjhscqODUvn
	+SJHYmUk2wAOYje2LjMV0rWLfEPvf70dgh2BgybxO8wYTVymR/fdTTDP97b3piXw3QE=
X-Gm-Gg: AR+sD11jvdfXBUbYfJynkfL15ZOT5FH1kEo5SbXf/eusPrH0I1gM73PG0mcsRMrgHRL
	wmv7WkSD0VtIxbbm/lquqGpbY9/d/89XpojBBldvNOnkZkck9X3jTKdLMHIlA8iA2IbRmCLVQL7
	/a2ZSRM94DMVJQJS2TEDFAhMeIzJ3AmIUihO1GLwHWdn/ItBJN2WKf9y7MvnsRXSSICDwPUNYGg
	+TIBl9liKdPSVc3VZP6LGolYrNxOECkkAtUaWbJeIuWUp+3JkpWRiPW3GTYWMVtLuskg4PVnH0v
	hi/WMXMWgC+06/Psn24JaS3Ayu60nqfhmGxAHLodv4fKfDhkbnwLN+WwaiCeocYt5qHRw+yJdH7
	pZqNNiGChNFjih0lcokybC4zSE7cgJ7aKdC3zWp1ORd7+wsqMjpbx8H78LauNZ3p+7K82UMePoq
	Ir4UbvMhJ+BBsqZolyYQIFyc3Y5hWcZ9OHcxJPVi5bzw==
X-Received: by 2002:a17:903:350c:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2d94a90e6e6mr107425595ad.17.1788263851931;
        Tue, 01 Sep 2026 04:57:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d911a9651csm34613995ad.21.2026.09.01.04.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:57:31 -0700 (PDT)
Date: Tue, 1 Sep 2026 04:57:30 -0700
From: Joe Damato <joe@dama.to>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>

On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
> On 8/28/26 9:08 PM, Joe Damato wrote:

[...]

> > ---
> > v4:
> >   - Moved bp->max_tpa_roundup_size init out of the early return path and
> >     documented that TPA is unsupported there, as suggested by Michael.
> 
> Clashiko quite convincingly elaborates that the above is not enough:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
> 
> Could you please have a look?

I looked. There are 4 separate things Clashiko reports, so in order from top
to bottom:

1.) "This isn't a bug introduced by this patch, but the line right below the last
context line here still uses the raw firmware ID as a table index: ..."

This seems impossible. If FW emits an ID > 1024 that's a firmware bug and if
we wanted to guard against that possiblity that would be a separate patch and
a different Fixes.

2.) "This isn't a bug introduced by this patch, but the loop count here changes
from bp->max_tpa to bp->max_tpa_roundup_size,  ...."

I mentioned previously in my v3 that this is real, but is pre-existing and is
a different Fixes unrelated to this change.

3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
device whose firmware reports max_aggs_supported == 0, does
bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."

Michael commented in the v3 that this is a false positive, hence why I changed
the code from what it was in the v3 to this.

4.) "This isn't a bug introduced by this patch, but the loop bound grows here
(for example 64 instead of 48 when max_tpa is not a power of two), so there
are more mandatory allocations that can fail, and the failure is not
propagated by two callers...."

I mentioned previously in the v3 that this is real, but this is pre-existing
and unrelated to this change. Fixing this would be a separate patch with a
different Fixes.

Michael: please feel free to confirm (or let me know if I'm wrong here), but I
think this patch can be merged.
