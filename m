Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE85435ED0;
	Tue, 21 Jul 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620691; cv=none; b=LR5Y0gdewCEQVNlMFsxDQQozISdI1mB7noJy9PkJro3BqCjNoXgpjyuHw8ZsDQMEEKamNvywbKk+pZko0t09vv2pDX+uNpcZ4w3WFFbydEF05sNrva0NIDjnwpd4Znd9RSY005jklxX+HIYExfKTwq3xm7zXRaagnXGpzDOHWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620691; c=relaxed/simple;
	bh=RWff8lwUU1fQXYbpbGi6oRIr5MzfK1wFsSqxASFAKVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8QZM7ysgtXDWQFX6uKauuSwdUTjJ2fuvQqeWMudtKfy1gA/pkNidDLzeXReR1FMSKJo7t9gh5y0kWGwZsoeiYxYuXBnjP+oRKi4oUmjr9tlXhAacqqFjR2GNiBJX9iya5n/BS6gKG+JZohUfnguqI6lOVc4DYideAxj8UYYFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luBtBdZ8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luBtBdZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784620689; x=1816156689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWff8lwUU1fQXYbpbGi6oRIr5MzfK1wFsSqxASFAKVI=;
  b=luBtBdZ85XvP9vVEfx8u4pRVFUrlJwC8UbZeHsDTTjJobHh4zOFQG6iK
   xSpQUrRZ4uhKOEz+FUV5wEM1Cz7DpeL/pn402Cyg3C3hXssSbO6wvmpLI
   cpUzCTGEA5FI+gXgK5PPPTOuuTp66nnVqo3mjIFBAscz/PnlrAg7U2HZG
   S3nDr+PG2V+kJmkbMPxn2M/CptwE2Yf4FwsFW6ZoNKSZdemzOtSDpxdMK
   3jZUA0cLV8w3WBN4b04aQVXtLPs62z1hFwFT0wXu6v+1tml4EXycvvKUE
   Ly8JQM1s/I+3ymnKnukvdYI9BbtbBommCukMTI/rwVfxWT8flMcRLd+aq
   g==;
X-CSE-ConnectionGUID: cCazxefYTqOtxUyP94nQsA==
X-CSE-MsgGUID: 7zZUcNrEQZKwVAQ8nttVIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="107999605"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="107999605"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:58:08 -0700
X-CSE-ConnectionGUID: JvGsazslQ+SEQsgbVnXghw==
X-CSE-MsgGUID: oQJ4BENaTVOvFK2bFwG3Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="257753285"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 21 Jul 2026 00:58:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id B6B7295; Tue, 21 Jul 2026 09:58:03 +0200 (CEST)
Date: Tue, 21 Jul 2026 10:57:59 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Jameson Thies <jthies@google.com>, Benson Leung <bleung@chromium.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Jack Pham <quic_jackp@quicinc.com>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Correct teardown ordering in
 ucsi_init() error path
Message-ID: <al8mhw7t2K6kKuSV@kuha>
References: <20260717104614.325250-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717104614.325250-1-akuchynski@chromium.org>

On Fri, Jul 17, 2026 at 10:46:14AM +0000, Andrei Kuchynski wrote:
> The commit 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and
> ordering in port unregistration") consolidated port teardown into the
> ucsi_unregister_port() helper. However, it introduced an ordering problem
> in the ucsi_init() error path.
> 
> Fix this by ensuring ucsi_unregister_port() is called before we unregister
> their corresponding lockdep keys.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
> Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/all/22064276-6c56-411a-9f20-6917ceeb865f@intel.com/
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - Added Reported-by tag.
> 
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 1ae4224d2dfc3..49f1c53721bbd 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -2142,11 +2142,11 @@ static int ucsi_init(struct ucsi *ucsi)
>  	return 0;
>  
>  err_unregister:
> +	for (con = connector; con->port; con++)
> +		ucsi_unregister_port(con);
>  	for (i = 0; i < ucsi->cap.num_connectors; i++)
>  		lockdep_unregister_key(&connector[i].lock_key);
>  
> -	for (con = connector; con->port; con++)
> -		ucsi_unregister_port(con);
>  	kfree(connector);
>  err_reset:
>  	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
> -- 
> 2.55.0.229.g6434b31f56-goog

-- 
heikki
