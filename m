Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629243;
	b=U//PJAm/4P+JuT+TPlfVvhKucPI7oD+NDIFWOHGipngQCLY0p2T0D56cbXrdTD1b6kee
	 jVilgtD9ZNND1zHJKVir1q/cggcF30QlXKjbAI81cgccZjsdZKRKuaFWbmIbf/gC2xiTT
	 lRRPeVM7VCielTOYuh0fQyOg4UaKqbZOtahPlE4dT+5xs7dg2aQ2TNmnRLXPJQ7Vb/ec+
	 nLSjRUGPwA4qvzQo6nEQD6a6ulLT+hFjWK/sGxAMBVjmqGy1Q7goZ2VprWR/uaNIkvV/T
	 epxmMBBdbuIwqKdpR9pWydM1VXN/Pp9I4mPAo9vdXkPQsoHplxPxe6vjGdJiNzEFKVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629243;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rnqkMZ8CRclQ6FinRgL34ebPpXHJ+z3PKdKH9rEdEPc=;
	b=kFpNetsWTrizE5DwDTZ/iikbUnZncIbapIGN+o4nRvRAMk+unqsGKjP+rqn/JCHzK9r8
	 GDWoxzKBMabC0cvVLwhTXbLf8QMfy6HDvhk/40z4jTMmHMUqu92atMHoCRQHXoKXuANKf
	 FaHHiaM0Xiyil/eJwIg+/FR72radoJ2Spu6XW4j1dzodR+0EP5T0Se2P64SDmZFwAXIhP
	 JPRTzHtpQ9fldyhdhTz8iz86rKCqvoOQSW3JCTVDrxmzshJXJZ0DgjEfCcdSK9W7+gd2E
	 zU83eVJfKJxs7OYa9MoSKQm76CohSbmts+mnB/liEnDTvKIdzTDsrcF/NjNtaG6SzRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=krAaTW0J;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070F606A337;
	Mon,  2 Nov 2026 14:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9070F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=krAaTW0J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793629243; x=1825165243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6IYdIllU7Skva9Xh9DLUseReR/l/v2CrWzARN5qQP60=;
  b=krAaTW0JLUmJBkWxjnEAQFBC4ZeLrzOOzIjhqW87ipXireXmq7krvsPB
   NXV220wh5cb+y/nUvm+ECo7fhjuEF6Vltum16l6NL1mSnyh2dEx9Q4e69
   QQj0bmQx4/12r2/Xxnn4hhEJDxY/3zrD6JkhTIpRsf4AdO0VtSISJLiTS
   L1ZdOWvafCqzeBN+8c7AqKUz6Lo9fZHzuDF4PjFSQOP24rXBdo0pePjp2
   nvx0cvdKscXlGhycBCuoxa732z/fzhgwaQbJt95iZ0UQRQ+NGodzB0BPz
   DnYzBt8FAbFMV9FLOg/+k2w4BBxXo4mYkeG6BN5jjlr0SupTzQasOSFac
   g==;
X-CSE-ConnectionGUID: BvFLyJmsRPuYcvXx9Sl9XA==
X-CSE-MsgGUID: JxQz9LAeSUSXii12jkCYWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2338480"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2338480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 06:19:32 -0800
X-CSE-ConnectionGUID: 3L6NF0M2SF+LAJ8WyX+9kQ==
X-CSE-MsgGUID: /gSbkW4gQdOl7/nqG217/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5986053"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Nov 2026 06:19:29 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3E5F499; Mon, 02 Nov 2026 15:19:28 +0100 (CET)
Date: Mon, 2 Nov 2026 15:19:28 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: JaeGwon Go <ceo@logictree.app>
Cc: linux-usb@vger.kernel.org, westeri@kernel.org, andreas.noever@gmail.com,
	YehezkelShB@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Send header-only XDomain properties changed
 response
Message-ID: <20261102141928.GX158991@black.igk.intel.com>
References: <20261029081834.91559-1-ceo@logictree.app>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029081834.91559-1-ceo@logictree.app>

Hi,

On Thu, Oct 29, 2026 at 05:18:34PM +0900, JaeGwon Go wrote:
> Commit 19813551701d ("thunderbolt: xdomain: Avoid potential stack OOB
> read") turned struct tb_xdp_properties_changed_response into a union of
> struct tb_xdp_error_response and struct tb_xdp_header, so that
> tb_xdp_handle_error() can safely read the error field of a received
> response. tb_xdp_properties_changed_response() still sends sizeof(res),
> so since that commit the response Linux sends is 36 bytes instead of
> 32: it carries the zeroed error field, and its XDomain length field
> says 6 dwords instead of 5. The other responses changed by that commit
> are not affected, because their non-error members are already larger
> than struct tb_xdp_error_response.
> 
> macOS sends this response as the header only. macOS 27.2 (26B123) keeps
> re-sending PROPERTIES_CHANGED_REQUEST when it gets the longer response:
> after link-up it repeats the request every 1.5 s, ten times, and then
> resets the link, about 15 seconds after it came up. thunderbolt-net
> logs in and passes traffic before the reset. The same host stayed
> connected to the same Mac for about 23 hours while the Mac ran macOS
> 27.0.1, so the change in behavior came with macOS 27.2.
> 
> Send only the header again, as before that commit. The union stays, so
> a received response still has room for the error field. Linux
> requesters accept the shorter response: tb_xdomain_match() requires
> only frame.size >= response_size / 4, and tb_xdp_handle_error() reads
> the error field only when the type is ERROR_RESPONSE.
> 
> Tested on an ASMedia ASM4242 USB4 host running an Ubuntu 7.0.0-38
> kernel, connected to a Mac17,6 running macOS 27.2. With this change
> macOS stops re-sending after the first answers, and tracing shows an
> 8-dword response with length 5, the same as the response macOS sends.
> The link has stayed up for over 1.5 hours, about 80 minutes of which
> carried a multi-gigabyte transfer every few minutes. Not tested: a
> Linux peer, the error response path, and macOS releases other than
> 27.2.
> 
> The analysis, the fix and the tests were done with an AI coding
> assistant.
> 
> Fixes: 19813551701d ("thunderbolt: xdomain: Avoid potential stack OOB read")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: JaeGwon Go <ceo@logictree.app>

Applied to thunderbolt.git/fixes, thanks!
