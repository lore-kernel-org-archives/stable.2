Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D137F737;
	Thu, 25 Jun 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425961; cv=none; b=sNpx4V8e+sL02nglSXR+ktvhXBKnTTYVioZI8nBod8z4RSTzsrTId14ED+Rg+1id8SbVpqFazw0nMXmFufsDYfTOuCYpsZPvZ0IRU4MWk8+fuXJy1m+nVpJG/91K9/urAjvr3QBYcg87GvaI7xYB1dTsUEkFZzHYfWU8IfptTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425961; c=relaxed/simple;
	bh=hcicJlfK8T5L5/HEK78jokcPzZyJx5jTeAgBKwX0N7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=OtNN6KLL2se6ta8EOwVGdgDvGmKm9evt+FFs9YorKraW8RU7PCqv0bO+HF5DO0dhpt5Iw+gh39vAGu7bPgYmbVfn2EPKRL0bVdFrjc45iap/FjX6jYFo6IsSYxvjbPt33SzUbPc4Vw9FMPhvBH9ZJB2JbchK6w43NuIKznbPkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=fEBnOpob; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="fEBnOpob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782425960; x=1813961960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqfHYJGq1OA4xHUtal9D1MJSyJMcOMtM3Z2ja3x61Is=;
  b=fEBnOpobgZYkytumD/TAhUknTBXpe75d7B4Y8ogCqKKE3U6Uf8CEeATq
   n8v9ntkrK9shj8hheOO/Bn/hRR1xCuvXL1DcrH7y65oZXLSjUAkxKcq4v
   gpK7SWLRYNSSnOfHC5lf6WYMDIO94l10DwXdC7mYyN+LyVx8EEjT+0P/B
   UrkfRfrd9lrI8B5FuRwZ8CA7llB27tCyH02sF71K1pM+pnE84oSp89rvm
   y04ESmXQtodCotpjXqpjAI2G46FJb10Aegx4RBSGELM94g95kF/mA+0ty
   ELq8DQhP3z5ypZDcWPCnGbiBup3r4PLXhsiXc8Bxd9Rw9xWYRTwxQNVkc
   w==;
X-CSE-ConnectionGUID: ibPfposvRVi0YbYajB8Nqg==
X-CSE-MsgGUID: i4hSxOCDQOyHW158eNz3YA==
X-IronPort-AV: E=Sophos;i="6.24,225,1774310400"; 
   d="scan'208";a="22299701"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 22:19:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:11485]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.61:2525] with esmtp (Farcaster)
 id 66017a07-fe43-45c5-b0e0-c45c7745dcbc; Thu, 25 Jun 2026 22:19:17 +0000 (UTC)
X-Farcaster-Flow-ID: 66017a07-fe43-45c5-b0e0-c45c7745dcbc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 22:19:16 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 22:19:15 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Sasha Levin <sashal@kernel.org>
CC: Bjoern Doebel <doebel@amazon.de>, <stable@vger.kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, David Howells
	<dhowells@redhat.com>
Subject: Re: [PATCH 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 22:19:00 +0000
Message-ID: <aj2pQ2IPGP5eR2TO@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625054005.0014.ringbuf-515@kernel.org>
References: <20260624122351.2477592-1-doebel@amazon.de> <20260625054005.0014.ringbuf-515@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: 7bit

On Thu, Jun 25, 2026 at 06:41:58AM -0400, Sasha Levin wrote:
> > [PATCH 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
> 
> I had to drop this one for 5.15. The upstream guard(raw_spinlock_irqsave)
> conversion in ring_buffer_read_start() introduces a new
> -Wdeclaration-after-statement warning on 5.15 (the guard variable ends up after
> a statement), which the build flags as an
> error there.
> 
> Could you respin a warning-free version for 5.15 (and 5.10, which has the same
> problem)? E.g. hoisting the declaration or keeping the explicit
> raw_spin_lock/unlock instead of guard() on these older trees.  6.6 and 6.1 are
> already queued.

Absolutely, I'll send a v2.

Best,
Bjoern




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

