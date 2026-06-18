Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B03DB960;
	Thu, 18 Jun 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783221; cv=none; b=Jbs18qWeooMJ82d17Umk9TMYV8dS6Yn9gMprMJ063viU+ZjY/N33Y7pe3qkSjAqQPxnGYMv9rSVojxvq0RR71xnBBwyl/JiJtLEhsSXetrEUtGJMLim0GxQ4ZSxL2kNZlfAegfCDbTSrkEZvT69YACyKf3TvXvfLfSkZyUTjHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783221; c=relaxed/simple;
	bh=JlHQpb3Akaav7Z1DtiBkWE/hvieT8Kz6OIdHLEk4zwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fULMDOq2b09ZtkhKSD3Aq2ztz+be9CJPWt0HC5f4kFq0mNQ0agCgG4catdXQ1xEK3x/aiA33vxatE2EGbJGrf8oBU1X/SaCLQaDvL+BMrBIiI1mgd/JQB4KMqmim3aGfEVwNpCiyrJH44i0iIic7z8rvd2Fap20Jo2+I7yg9UsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.at; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tMU9azvM; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tMU9azvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781783219; x=1813319219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=taecWU3jnHxMf9ugrv3nPfNpQVzrtNwEuDwfkVyBLUY=;
  b=tMU9azvMEdGufl/yCWnyHYXSJkOzBnYpAgLUPgA0c2pGk5zU2W1tyuRR
   T7pPtVk33vDxCXfhrzxq7yHzLpszmKSHtj0B+mIRwmiIWOG6NQYpi0sY0
   xBQksG+DmWzPPyXBDRUkSaaQu/01+D9ECTWq/iMPuy9kbWQx52kUac3Y5
   TqGumEZyCmIfBwTD8UOoOjWeFe6m23UrlVUNaTHg+wwFjOQ2DmHxFZVDo
   DBgX5AcdhqFc0my2XiuDR1gQJsx7U5ae9QS20XxJ71H2bVuFXJsUNo+QV
   KSt/2DRTpYKJjQ1t8njenX5+X8tt3topEA7MiMV5XTzLohYRIBEDALJMl
   w==;
X-CSE-ConnectionGUID: c4GMWpK3RbqlBrK7ugd/cA==
X-CSE-MsgGUID: QGsarvsbTPCQq9heOoEMKw==
X-IronPort-AV: E=Sophos;i="6.24,211,1774310400"; 
   d="scan'208";a="21522631"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 11:46:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:18253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.192:2525] with esmtp (Farcaster)
 id e9395c1f-d102-4c51-9d42-2f9d744b53c6; Thu, 18 Jun 2026 11:46:56 +0000 (UTC)
X-Farcaster-Flow-ID: e9395c1f-d102-4c51-9d42-2f9d744b53c6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 18 Jun 2026 11:46:56 +0000
Received: from bcd0741a98fd.amazon.com (10.1.213.12) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 18 Jun 2026 11:46:54 +0000
From: Michael Tautschnig <tautschn@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Michael Tautschnig <tautschn@amazon.com>
Subject: Re: [PATCH] staging: vme_user: fix heap OOB in buffer_from_user and buffer_to_user
Date: Thu, 18 Jun 2026 13:46:24 +0200
Message-ID: <20260618114624.71348-1-tautschn@amazon.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026061535-hardened-presuming-96b2@gregkh>
References: <20260614195318.40397-1-tautschn@amazon.com> <2026061535-hardened-presuming-96b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 15, 2026 at 04:27:38AM +0200, Greg Kroah-Hartman wrote:
> Nice, but why did you not use get_maintainers.pl to determine who to
> send this to?  You cut out the staging list?

My fault -- v1 went only to you and stable@.  v2 is Cc'd to
linux-staging@lists.linux.dev and linux-kernel@vger.kernel.org per
scripts/get_maintainer.pl (VME is S: Orphan, so that's the full set).

> > +	/* Clamp to the fixed kern_buf (size_buf): the VME window
> > +	 * (image_size) may exceed PCI_BUF_SIZE, so *ppos + count can
> > +	 * run past kern_buf otherwise.
> > +	 */
>
> Not a network driver, so you can use normal coding style for comments.

Fixed in v2 -- switched to the normal (non-networking) multi-line comment
style.

> > +	if (*ppos >= image[minor].size_buf)
> > +		return 0;
>
> No error?
[...]
> Again, why not return an error?

This is the end-of-buffer case, and returning 0 matches what the driver
already does: vme_user_read()/vme_user_write() already "return 0" when
*ppos > image_size - 1.  A 0-byte return at/after the end of the buffer
is the normal read(2)/write(2) convention (EOF for read; for write it
mirrors the driver's existing behaviour).  Returning an error here would
make the SLAVE path diverge from both the existing *ppos check two lines
up and the MASTER path, which seemed wrong for a Cc: stable fix.

> > +	if (count > image[minor].size_buf - *ppos)
> > +		count = image[minor].size_buf - *ppos;
>
> Why are you covering up for userspace errors, shouldn't this just fail?
[...]
> Same here, shouldn't this fail?

The clamp mirrors behaviour that already exists in this driver rather
than inventing new policy: vme_user_read()/vme_user_write() already clamp
count to image_size - *ppos (a short transfer), and the MASTER-path
resource_to_user()/resource_from_user() already clamp count to size_buf.
A short transfer is standard read/write semantics -- userspace is
expected to loop -- so the SLAVE path was simply missing the size_buf
bound that MASTER already has; it clamped to the VME window (image_size,
up to 4 GiB from the user-set slave.size) instead of the fixed 128 KiB
kern_buf.  v2 keeps the established short-transfer contract and just
fixes the bound.

That said, you're the maintainer: if you'd rather an over-large request
fail outright (e.g. -EFBIG / -ENOSPC) I'm happy to send that, but I'd do
it as a separate, clearly-marked behaviour change rather than fold it
into the stable fix.

> And no chance for this to wrap again, right?

No wrap in the added code: the caller already rejects *ppos < 0, and the
early "if (*ppos >= size_buf) return 0;" means 0 <= *ppos < size_buf at
the subtraction, so "size_buf - *ppos" is a positive u64 and the
"count > size_buf - *ppos" comparison can't overflow.

It also tightens a pre-existing wrap: the caller's
"if (*ppos + count > image_size)" adds loff_t + size_t and can overflow
for a huge count; the new "count > size_buf - *ppos" re-bounds count
regardless, so the copy stays within kern_buf even if that earlier clamp
is bypassed.

v2 also adds Fixes: f00a86d98a1e ("Staging: vme: add VME userspace
driver") and keeps the KASAN reproducer in the changelog.

Thanks,
Michael


Amazon Development Center Austria GmbH
Brueckenkopfgasse 1
8020 Graz
Oesterreich
Sitz in Graz
Firmenbuchnummer: FN 439453 f
Firmenbuchgericht: Landesgericht fuer Zivilrechtssachen Graz



