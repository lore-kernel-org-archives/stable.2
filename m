Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD33DC4DE;
	Fri, 28 Aug 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901056; cv=none; b=ewyoVGc7CCbilWWUGbEF6uYJgCxSYFH6OhHF26tky6LvLqrk+JGATVR+QWYWPLg/5lpxyuNAJ2UWOCbVxTNleHTZn+co6mm4F3e6Qg717bzfbLQLEpwlGU29uU/eE4Pc1U+5q/qbhqJhfcVTYX3FGSVjrw/fNAjB3qhLc92DzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901056; c=relaxed/simple;
	bh=GH+2BGvQdVddsbkQX85S0FzQEnTHKd1Lwfa8+9jrmPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ5HaXeUp+G7tiXRVa8vK1BZcVtMGUZvfwOPO+EH5s80YDkmgOC3M55/Saz3w49NshWucaklb9kABYAFXWvV76tgS2uENV1vtZzsTISTDJSQBQNBfRhEDU+GecwFYleyFj4www4kQRtgEIWhG74cGK9vtHF4/cG4blhCR9ttWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoOU63ek; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoOU63ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787901052; x=1819437052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GH+2BGvQdVddsbkQX85S0FzQEnTHKd1Lwfa8+9jrmPs=;
  b=IoOU63ekSnpjzE3vJgg+q42JiQoPGB/mYfP1GU4ixMBu7ZoqhHFS6NCQ
   n44cDhv6Q/BBOgAyf1vjstfopcGWp5FnmIBLcjuvOUIKNB60wZqmGALnI
   x8DfLVzK4LSYyJdg+1fPaztAeZP3I7l91X8aTmJzBmU2ebJdI0Njc2YqR
   bcNxAb8MlyrpUJQhPdPGRhILzJoUILTvpTxMeMQl1E02jX/PTgIse0Mf8
   s6P+I9C9wqfFtTGKZa0Hmz2OxwLVfq9OT2CuKKzRSxFUURnxXPiyoygLi
   JEwr+HQbEr2jZvTJFe2fOp5ycGxuMRvMNbrtHRbUYm7XPZDTzp/9lVB/l
   A==;
X-CSE-ConnectionGUID: Yscn+rL2QHWATzvWlXeJcA==
X-CSE-MsgGUID: HU0vLp3GTOeGsyhbQVMZkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="87349706"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="87349706"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:10:51 -0700
X-CSE-ConnectionGUID: Iw2sTN9qQPanwe8WFQKQhg==
X-CSE-MsgGUID: FSdjeaUgRQqmI9qO2FUvYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="268113610"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.42])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:10:46 -0700
Date: Fri, 28 Aug 2026 10:10:42 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>, Gerhard Engleder <eg@keba.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Message-ID: <apE0cj_mrXvmiT-s@tlindgre-MOBL1>
References: <20260826084654.1392851-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084654.1392851-1-linuxoid@gmail.com>

On Wed, Aug 26, 2026 at 10:46:54AM +0200, Ruslan Valiyev wrote:
> Return early when there is no port device, and read port->port_dev
> under port_mutex.
> 
> Also clear port->port_dev on the serial_core_register_port() error
> path, where the port device has already been removed.

These look like valid fixes to me:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
