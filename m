Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F33AE6E4;
	Tue,  9 Jun 2026 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028314; cv=none; b=OIh+DEDWKQlnT+yTPhhW9rv0T/bva4J7eR0sji9kx6ML9W8KPz9kCFSmC9CRFCZ+4mk0IIOWYgbL/RsAfohhcXvlZxRdMIoFl2m7U7IO9XUAGP7Oyir9q7FPD8DPs7jRxp4WN/c2CkBkZhxYY3fGYBxWDizL9HczbkP+e+330yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028314; c=relaxed/simple;
	bh=Q2pbyf24Y8mCLGLVEjomlmAT8v4TIbHOmlKXN9CPP/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppwbgm3+nq2NFWz9K50NPgiEnozDoB9ygGh8gR+W3N46uAjisSf+brJPbL4p+sdCE+OdErKzhXfL+iecp5zbv5JjbrlCWo5MQa0oRqh3LyOnJ5T7Ng106eJHiczDETlOEva7UYt30utAFXFjs6M+WzM2mr89sUgt8r+rRAfUnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/yy6ctb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/yy6ctb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781028313; x=1812564313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q2pbyf24Y8mCLGLVEjomlmAT8v4TIbHOmlKXN9CPP/c=;
  b=i/yy6ctbTfghmEhdxMZf5dRlkLULHsv6K1mLneJCT/bJGOK7TzBkuhR9
   8RDvewyWuOVLwV1RbN33uvjL3XMd4MWjEQE7oPlslsHfReqxzmp39+7ti
   TiN9IoiSkGhn+NhXa3/T7gWHBeLC//yhzKEM8R+dn5B593SrzeGVsdac6
   svZmAX7rqSODixT6fVnaBUKpLczvMgXGm42UFLC526qSu77xM5cZQM4Lz
   7pMWnzU5aiAy8x4tBEcNGQhOyvKXcUzXRIiZgbPXOOusJAOnT49B6Xtcy
   fF81iwQaX9vu+p7fD723s9bN4SB1yFKQ0HuqhS3rFCXj6CPpT0WrUYIkO
   g==;
X-CSE-ConnectionGUID: z/nL99wtRRejn5Zi+bmZtg==
X-CSE-MsgGUID: DDdxhby5TkqQ6T+IeZ/T/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85426932"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85426932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:05:13 -0700
X-CSE-ConnectionGUID: 0YMtFG0qRHaj+Fis1SZg3g==
X-CSE-MsgGUID: ryX5TYa/Qw2eIRPCBhFjag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="244790650"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:05:10 -0700
Date: Tue, 9 Jun 2026 21:05:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nika bakuradze <nbakuradze28@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Khushal Chitturi <khushalchitturi@gmail.com>,
	Archit Anant <architanant5@gmail.com>,
	Minu Jin <s9430939@naver.com>, Kees Cook <kees@kernel.org>,
	Hans de Goede <hansg@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: avoid NULL pointer dereference
 in c2h_wk_callback
Message-ID: <aihV0187aqMh_rMA@ashevche-desk.local>
References: <20260608190700.85755-1-nbakuradze28@gmail.com>
 <aie9bqpiNDJ_IU0M@ashevche-desk.local>
 <CAHyzTT3R-cOpJdE=hKPGSBSdC-BiY29y40DURvKjCN4V+w5EAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHyzTT3R-cOpJdE=hKPGSBSdC-BiY29y40DURvKjCN4V+w5EAg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 08:40:39PM +0400, nika bakuradze wrote:

First of all, do not top-post!

> You're right, kmalloc(16) effectively won't fail. This is my first
> kernel patch so I was being overcautious with the framing.
> 
> Should I resend v2 with the else continue form you suggested,
> or drop the patch entirely?

To some extent the patch makes sense (at least for you to train your skills in
Linux kernel processes, et cetera). I would go with the v2 that uses my approach.
Also drop Fixes tag, consider this as an improvement to make code robust.

> On Tue, Jun 9, 2026 at 11:15 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Jun 08, 2026 at 11:06:58PM +0400, Nikoloz Bakuradze wrote:
> > > c2h_wk_callback() allocates a 16-byte buffer with kmalloc(GFP_ATOMIC)
> > > when the c2h event needs to be read by the host. The existing guard
> > > only wraps the read step, so on allocation failure the loop body falls
> > > through with a NULL c2h_evt and dereferences it in rtw_hal_c2h_valid()
> > > (via c2h_evt_valid() which reads buf->id).
> > >
> > > Restructure the check into an early continue so the rest of the loop
> > > iteration cannot be reached with a NULL pointer.
> >
> >
> > Not sure if we need any Fixes tag. kmalloc(16) won't ever fail (otherwise
> > the system is already in the state when nothing can help).

...

> > >                       c2h_evt = kmalloc(16, GFP_ATOMIC);
> > > -                     if (c2h_evt) {
> > > -                             /* This C2H event is not read, read & clear now */
> > > -                             if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
> > > -                                     kfree(c2h_evt);
> > > -                                     continue;
> > > -                             }
> >
> > > +                     if (!c2h_evt)
> > > +                             continue;
> > > +                     /* This C2H event is not read, read & clear now */
> > > +                     if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
> > > +                             kfree(c2h_evt);
> > > +                             continue;
> >
> > It's too verbose way of saying
> >
> >                         } else
> >                                 continue;
> >
> > here.
> >
> > >                       }

-- 
With Best Regards,
Andy Shevchenko


