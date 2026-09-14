Received: from griffin.linux.hr (griffin.linux.hr [193.198.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DF375F9C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.198.212.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369897; cv=none; b=Mgisn3GazsM/8MhI3SCxJfFyIaL65DifxWdLxAgb0WzV0LfT8O+DjnABsoa6j5RKB8m4LOtxPKULHFr1LyDdLE5aHSPp5oGZBf/kRcxJUFIaUMEro6bf9xaizCuGWzIEOVWsFEhYev88VDw6osZRgpjQqFXXEVOoL++wOaZHeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369897; c=relaxed/simple;
	bh=YmA+xNL7Z4HkxFxV/jfSQYTb/mLChvNvtB/HOwnhYEE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DfzcPIHgGRgaFyL3IzVqQ5Y/D5vXciEF9039+eOmBv3bRrf2vuj5uaZ0ni7Cyb8by5Ls0odWVozhfsCCN/ZztP8cTm7izP55AQ1+J+n9NFJL/eJooSYaPg+Y/Xysyqo5Ng8F+MtU3/sqyiCi0sruRp4QRJbHdoCpAMxf2jq6mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.hr; spf=none smtp.mailfrom=griffin.linux.hr; arc=none smtp.client-ip=193.198.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.hr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=griffin.linux.hr
Received: from vkosturj by griffin.linux.hr with local (Exim 4.94.2)
	(envelope-from <vkosturj@griffin.linux.hr>)
	id 1x60SI-0002HQ-Bd
	for stable@vger.kernel.org; Mon, 14 Sep 2026 08:46:18 +0200
Date: Mon, 14 Sep 2026 08:46:18 +0200
From: Vlatko Kosturjak <kost@linux.hr>
To: stable@vger.kernel.org
Subject: [PATCH] ppp_async: drop the errored frame instead of resetting its
 headroom
Message-ID: <aqeYOh8P7EfhggfP@griffin.linux.hr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Vlatko Kosturjak <vkosturj@griffin.linux.hr>
X-SA-Exim-Connect-IP: <locally generated>

Please backport commit 8dc5d98a16fa ("ppp_async: drop the errored frame instead of resetting its headroom") to the currently supported stable kernels.

This fixes a remotely triggerable kernel panic/DoS in the PPP async receive path. On an errored frame, ppp_async currently reuses the skb after resetting its headroom. A subsequent frame can then cause the skb data pointer to be moved before the skb head, resulting in an skb_under_panic. CCP decompression can also access memory before the skb head.

The fix drops the errored skb and clears ap->rpkt instead of attempting to reuse it.

The fix applies cleanly to the relevant stable branches.

Fixes: 6722e78c9005 ("[PPP]: handle misaligned accesses")
Upstream commit: 8dc5d98a16fa ("ppp_async: drop the errored frame instead of resetting its headroom")
-- 
Vlatko Kosturjak
