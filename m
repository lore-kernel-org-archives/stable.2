Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C33DD52C;
	Thu,  1 Oct 2026 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847978; cv=none; b=sEDugf0aNPwJ/IpSLNvhJ4/29eQZFLfAujQlnq1LQcjGOinDuR1xYnaXVnxmVnfo76eBE5+9n0NGqnaSxr0srUhrjoHkyiGHLiShPEmJk2Mooj21UlBYDVR/Nf7HoEznqBOyHWoE3/e53yB742FzaLd67VxtrijGUhgBjnzSUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847978; c=relaxed/simple;
	bh=aqKyfLjMfoBc3ezdQ5GZeOo7oGDNp+lHe4qj6rHtEnk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fEjOyXGuhV/1VGplnio1ceewK8k+BPR5O+jh2nOknKP6DMNu+Ukdt+nDuI6ih9mhf0YCoSqpx2VqH7lHkAgPCjKHPqDz18bfMwfdOlh5proPG5HihmNs7WKTZknYYCiSj9o1+SeJc4ZHdrR/v93E56QF4cWtbBngGNALzK2UXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk7tNdQA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk7tNdQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790847975; x=1822383975;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aqKyfLjMfoBc3ezdQ5GZeOo7oGDNp+lHe4qj6rHtEnk=;
  b=Fk7tNdQAUL00nCb92TuiD7n399eGMpbZdOo0sjLW6eMaas97nHd8VaCA
   THGvwOfKah2akHFKzhKVlehLo4HJHlRBU5gI3ZKeFx6bH4runsbzaQ8YI
   24l6q72CYZuOT2/EbS60ZcHrTp5LMPGtiDtcOJCtT7EM+0Uw28u/rlxye
   sKbwh6d/Hgf8ZWoHZywfmUjBuTtLM5jQJ/FNT2mvhlW797ORqFoXTRSx8
   H4WLnT95xC2ORphE52JIlIKZ8NMyGKrAZVzZD+Vjn2Nxw5r7L1mC8r6ox
   T/dN9PyywntPZEdMG4/0faT3yKfbpJ4mrOMex64OsjTKFuF8X46+MVUJ6
   w==;
X-CSE-ConnectionGUID: w7HQjcGXRuOL71uTxiT8UA==
X-CSE-MsgGUID: rcFnMOFjQ9iIvLmctavaIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90366666"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="90366666"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: X6l3l0FmQZe5k1FwQCaicw==
X-CSE-MsgGUID: u1giBiXeTC68uOKfUM1Drg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="275156008"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 02:46:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 1 Oct 2026 12:46:05 +0300 (EEST)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hui Peng <benquike@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
    John Ogness <john.ogness@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] serial: core: fix baud rate fallback in
 uart_get_baud_rate()
In-Reply-To: <2026100156-watch-balsamic-32db@gregkh>
Message-ID: <5085df04-f813-8b3f-1d05-87d5bbf00499@linux.intel.com>
References: <20260930125901.778868-1-benquike@gmail.com> <20260930125901.778868-2-benquike@gmail.com> <2026100156-watch-balsamic-32db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Oct 2026, Greg Kroah-Hartman wrote:

> On Wed, Sep 30, 2026 at 12:59:00PM +0000, Hui Peng wrote:
> > When uart_get_baud_rate() is called with a baud rate exceeding the port's
> > maximum supported speed (port->uartclk / 16), it clips baud to [min,
> > max - 1] and encodes it into termios via tty_termios_encode_baud_rate().
> > 
> > However, because the loop bound is for (try = 0; try < 2; try++), the
> > loop terminates immediately after try == 1 without re-evaluating
> 
> But try == 1 should keep the loop going as it is < 2, right?  What am I
> missing here?  Do I need more coffee?
>
> > baud = tty_termios_baud_rate(termios) for the clipped rate, hitting
> > WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> > (Oops: divide error) in uart_get_divisor():
> > 
> >   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260
> >   [ ... ]
> >   divide error: 0000 [#1] PREEMPT SMP KASAN
> > 
> > Increase the retry count in uart_get_baud_rate() from 2 to 3 iterations so
> > that clipped baud rates are re-evaluated in the third iteration.
> 
> What is the magic 2 here, and why turning it into a magic 3 somehow fix
> things?

Hi Greg & Hui,

First of all, I'm withdrawing my Reviewed-by from this!!!

Lets hope the submitter can finally get his/her act together and not make 
unlisted changes between versions or send non-sense.

While the code change is still fine, it seems the submitter (or more 
likely AI) has changed the changelog from what I read when I reviewed 
this. And the new one is way worse than it used to be so not being able 
to follow what's going on is very understandable given the lackluster 
explanation that remains.


What you're missing is that the baud returns happens within the loop, so:

try == 0: use new, if baud is out of bound and old is available, switch to 
          old
try == 1: if old is also out of bounds, there's the last resort rule 
          towards the end of the loop which is applied forcing baud to the 
          accetable range.
try == 2: loop exits => WARN_ON(1) triggers.

What we'd want to happen with try == 2, is for it to use the return baud 
which is within the loop body.


Hui, I suggest keeping the previous versions of the patches available as 
files. And right before sending the next version, go manually throught the 
diff of diffs to make sure there are ZERO unexpected changes from version 
to version (has saved me tons of times from making stupid mistakes).


-- 
 i.

