Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22D38D6BD
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788030201; cv=none; b=K7c+ancPPfikQFO0mmzh4BeHjw73eQwAnujlOl8k+A7Mmqe7QEPUPmfx59knjmQsGQ52+ztB+Id5ikKbcwDGhtDjC0PvSXDd/I8Smn7LVcHJB8wY8MAPoT6nNtyceT81NJbmhy6Xb4j13/Sx2GZeE89HhFLBVqiTPYzLG2L92lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788030201; c=relaxed/simple;
	bh=TIh4DOnD+S/iXHsrfiIEXNJifWn+ISjtMrnm++DfHQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO4K9fPAfYQ52VYho0aPnzoIQytbuOXdlYv4CV4wBwc5H5MkI//wa9KI8EHEvcabZlo7o+1sXVwuRAEXLQ68AsRv9YFd/1bfcKzSiO0JnC/K1ehFk7OPVzFKwjnHj8OTJV5RURyKVuQH2SIrqI3ZNseIQa7JQP8ORJ3hbvbmO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHwNax/x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHwNax/x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce7d2adef4so32491835ad.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788030199; x=1788634999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwBa+9bQ9e6n2dIJ1FHVXbNuvQY4O8W1fjuVGTSJWDM=;
        b=rHwNax/xGH5RNCmO73Uz+d8CXObAOns7PN9z+pQAIALA4xDb1O0ElYqqsfUZDvdwCJ
         DsRd75piWpwTsMcNnEOo6u913+e2Iavm8PjLrA7hMRE0aaC6z+ZcRSiSOvCLkGscdTTs
         lUD/KDSix4+LRELTVf3/whOB+BRKO9RMSZE9REJ9Fju9IaEiC1gVbzN4QonS5zs40nru
         OaFsK6orOAzx/ksFkNDB6qaeQsv5wshBrNKwh1HxZu8vJb7GhnkKPGBb90jWHSErw5N1
         VG4Br6ENhyjUZZQkiSz/o5SuJ2xYkOwhAtRsiHLSSQuVunexPnL/D7Q8x+1iEcDZWFcI
         MxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788030199; x=1788634999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pwBa+9bQ9e6n2dIJ1FHVXbNuvQY4O8W1fjuVGTSJWDM=;
        b=NUR8bhj0dmDa6tYevWiKhlK33uaYI5t7ysQ0nqSwSASwFHamPt4baUcogH7ZO1pybI
         2Gbngn4GWS5Vkdio2ZfgdmrHkeJVloPMSdAZy/8U9VDBzQIXM/bmvguScHah8+gbXac6
         hWCHYXzAMjjFlhcPUzR88DHlRE/eqbGtUQkxTvwlohJrW9ClBRr5iOzf/4VCsjcYN6RJ
         HJBe4lExKLhX9famJBVkN9v1HJLYgaKBxnw/UuqtkcK6GynU8kwK8gdgqasT4JeqjMOU
         8Xdn521eXe3uPhpYgHT2flW86Km73v59tjj+9vIDaRRuDfoHVeRxsC7zmbQ13cDgQatk
         aN4A==
X-Forwarded-Encrypted: i=1; AKwUvBwHI0s60KA8zvUsrPkrocCjjpRo2NbCIl7b3f4DEzdfGukJPgpDCTE040k3OcpVeqSL+qfGuO4=@vger.kernel.org
X-Gm-Message-State: AFuF++mvrXouBetPcZxKwyf8LCTxEpXESSTncndtjdppBFgwqbyN4SJg
	rTloKX8cZ5IbE9JWaVFEefsNR4JVRzMmmgzQVcLUPVUWdQMUXb53X7n9
X-Gm-Gg: AYBFou2YWyNbWtXscr1v+/DW5WEMbD9pRJ4qbDlVaSN16gC/9dpMCv2yl53eJulREjH
	7NkPcDACkHOIF9jl+lhyd/JhwypeS60cJZoAdPpkEmN4U1QtpNBK+guJ6tr6KK/xVjFVSFWDNX0
	M13ynHafTPW8c/kaTDslp/yzv4xSzS0rX6DFA8SrtAYf+sa2aYa6vWFt7SRP+3n4d24V8VTlwYm
	LyWS1UeUTJ5ZCy22e9gKd2od3vtUzLRBrK7CrfjZVCffMZpB4M0R06kTKj8r7i5WCs/qusmIojk
	sHBvNp8tie7XS0HpCB0sL72onZeDsfougfz1E/yoEcnBm0knFmPfRXGb3MaWwEkt7dzTtYmamS8
	R61R9SIuO9H/gGB0ySlXX00BV9hWrdbdFXIxYrDmWXSzbSaAj407GmnZ9PkRNgYgkqIdCBunpZW
	Z+S31IR2uv8xkDhh8kLUFwBOp05dh9qGPwWQzhqCRxY76vCWh2WHMRfD9GEbEdnsqoffKQU2bV3
	eIRWeeYB7kMbD1U
X-Received: by 2002:a17:902:fc4d:b0:2d8:d4cc:5bb0 with SMTP id d9443c01a7336-2d8d4cc5d79mr139929965ad.16.1788030199448;
        Sat, 29 Aug 2026 12:03:19 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d9055ddfdcsm900305ad.18.2026.08.29.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 12:03:18 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 03:03:27 +0800
Message-ID: <20260829190327.17400-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829161509.77406-1-sj@kernel.org>
References: <20260829161509.77406-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 09:15:08 -0700 SJ Park <sj@kernel.org> wrote:

> On Sat, 29 Aug 2026 16:34:26 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Fri, 28 Aug 2026 11:29:09 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > As you replied to Sashiko, let's do the last region handling in every case.
> > > While doing that, let's do the charge_{target,addr}_from reset in only one
> > > place, like below.
> > > 
> > > '''
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2688,36 +2688,40 @@ static bool damos_skip_charged_region(struct damon_target *t,
> > >  {
> > >         struct damos_quota *quota = &s->quota;
> > >         unsigned long sz_to_skip;
> > > +       bool skip = false;
> > > 
> > >         /* Skip previously charged regions */
> > >         if (quota->charge_target_from) {
> > >                 if (t != quota->charge_target_from)
> > >                         return true;
> > > -               if (r == damon_last_region(t)) {
> > > -                       quota->charge_target_from = NULL;
> > > -                       quota->charge_addr_from = 0;
> > > -                       return true;
> > > -               }
> > >                 if (quota->charge_addr_from &&
> > > -                               r->ar.end <= quota->charge_addr_from)
> > > -                       return true;
> > > +                               r->ar.end <= quota->charge_addr_from) {
> > > +                       skip = true;
> > > +                       goto out;
> > > +               }
> > > 
> > >                 if (quota->charge_addr_from && r->ar.start <
> > >                                 quota->charge_addr_from) {
> > >                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> > >                                         r->ar.start, min_region_sz);
> > >                         if (!sz_to_skip) {
> > > -                               if (damon_sz_region(r) <= min_region_sz)
> > > -                                       return true;
> > > +                               if (damon_sz_region(r) <= min_region_sz) {
> > > +                                       skip = true;
> > > +                                       goto out;
> > > +                               }
> > >                                 sz_to_skip = min_region_sz;
> > >                         }
> > >                         damon_split_region_at(t, r, sz_to_skip);
> > > -                       return true;
> > > +                       skip = true;
> > >                 }
> > > +       }
> > > +out:
> > > +       if (r == damon_last_region(t)) {
> > >                 quota->charge_target_from = NULL;
> > >                 quota->charge_addr_from = 0;
> > > +               return true;
> > >         }
> > > -       return false;
> > > +       return skip;
> > >  }
> > > 
> > >  static void damos_update_stat(struct damos *s,
> > > '''
> > 
> > I noticed a potential subtle issue in the suggested fix above:
> > 
> > '''
> > +out:
> > +       if (r == damon_last_region(t)) {
> >                 quota->charge_target_from = NULL;
> >                 quota->charge_addr_from = 0;
> > +               return true;
> >         }
> > '''
> > 
> > If 'skip' is false (region should be processed), but it happens to be
> > the last region, the condition 'if (r == damon_last_region(t))' would
> > still be met.  This would cause it to reset the state and 'return true'
> > (skip it), which inadvertently re-introduces the original bug we are
> > trying to fix.
> 
> Ah, good catch.  The 'return true' is a wrong copy-pasta.  Let's drop the line.
> 
> > 
> > To ensure the reset logic is centralized and correct, I refined the fix
> > as follows.  The comment is intended to help you and other reviewers
> > quickly understand the rationale behind the compound condition.  I will
> > remove this comment in the next revision.
> > 
> > '''
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a1656..82c5aed8a417 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2342,36 +2342,48 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  {
> >         struct damos_quota *quota = &s->quota;
> >         unsigned long sz_to_skip;
> > +       bool skip = false;
> >  
> >         /* Skip previously charged regions */
> >         if (quota->charge_target_from) {
> >                 if (t != quota->charge_target_from)
> >                         return true;
> > -               if (r == damon_last_region(t)) {
> > -                       quota->charge_target_from = NULL;
> > -                       quota->charge_addr_from = 0;
> > -                       return true;
> > -               }
> >                 if (quota->charge_addr_from &&
> > -                               r->ar.end <= quota->charge_addr_from)
> > -                       return true;
> > +                               r->ar.end <= quota->charge_addr_from) {
> > +                       skip = true;
> > +                       goto out;
> > +               }
> >  
> >                 if (quota->charge_addr_from && r->ar.start <
> >                                 quota->charge_addr_from) {
> >                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> >                                         r->ar.start, min_region_sz);
> >                         if (!sz_to_skip) {
> > -                               if (damon_sz_region(r) <= min_region_sz)
> > -                                       return true;
> > +                               if (damon_sz_region(r) <= min_region_sz) {
> > +                                       skip = true;
> > +                                       goto out;
> > +                               }
> >                                 sz_to_skip = min_region_sz;
> >                         }
> >                         damon_split_region_at(t, r, sz_to_skip);
> > -                       return true;
> > +                       skip = true;
> >                 }
> > +       }
> > +out:
> > +       /*
> > +        * The last region may remain unapplied for extended period due to
> > +        * various regions (e.g., it is invalid or has been filtered out),
> > +        * preventing other regions from being applied (those preceding the last
> > +        * region and all regions with different targets).  Therefore, when
> > +        * encountering a region that needs to be processed, reset
> > +        * charge_{target,addr}_from.  If necessary, this parameters will be set
> > +        * to the correct value in damos_do_apply() due to quota is full.
> > +        */
> 
> Looks too verbose to me.  Let's drop this.
> 
> > +       if ((r == damon_last_region(t) && skip) || !skip) {
> 
> Why this becomes this complex?  We should reset charge_{target,addr}_from if it
> is the last region, always.  Am I missing something?

Thank you for pointing this out!  As long as it is the last region, we
should reset.

> 
> >                 quota->charge_target_from = NULL;
> >                 quota->charge_addr_from = 0;
> >         }
> > -       return false;
> > +       return skip;
> >  }
> >  
> >  static void damos_update_stat(struct damos *s,
> > '''
> 
> > 
> > > 
> > > Btw, I think damos_skip_charged_region() may deserve a kunit test.
> > 
> > I agree that a kunit test would be valuable.  While I am still getting
> > familiar with the kunit and it might take me a little time, I plan to
> > work on it.
> 
> Nice.  Looking forward to your patch.
> 
> > 
> > Should the tests include these scenarios?
> 
> Let's not add new topics.  We can discuss this on your kunit patch.  Please
> ensure it covers at least the corner case this patch is trying to fix.

Okay, I will ensure that.  Should the test be sent along with this
patch (as part of the same series), or should they be sent separately?

Best regards,
Rui Yan
