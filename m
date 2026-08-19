Received: from mta1.migadu.com (out-75.mta1.migadu.com [95.215.58.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9F277CA5
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787114999; cv=none; b=UXC7awlh4XugUQWo+PJjLmvSD3d5BWSbcAAgC+lFHL0VcO/lITc+Vwj3HOWLZUyA17sZrQtpFmJKgLl4LkxPzey0M+KWuGg1bUvqrt3H5dFXJTjGF0Hbk8MDJSCqCcBH4kOGdttGEupdZIVnf22yeloC22jXFBVlcPMQLPWvAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787114999; c=relaxed/simple;
	bh=vK1GcmrCM2HBb97Fmyp4VUN3T6osFaaIJirq/q1oYnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of8B4/jEeLZLwFkj8smO8l0fC3yZLDyG9bDwUgbstV7uZOdTwgoA2c1Mxr024ckheukbyIMdJ1NP2egRPI49l9ztx5jRg+TJd059kC1JC0+cPviyl9xL56nF++WsDbPvBF3uqeDjlNmb06z3mD/m5VIm5mLudaIJt+d89nZmwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q51s+J3v; arc=none smtp.client-ip=95.215.58.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q51s+J3v"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vK1GcmrCM2HBb97Fmyp4VUN3T6osFaaIJirq/q1oYnc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787114994; v=1; x=1787719794;
 b=q51s+J3vUu/ihprkt8BCyXAXdFWj6T7YHbwYk7TJNZDhX56fMUSxSBQktZZXqJ8CzMc+XlJ4
 +WKaJfLqpSKA8du9vNz+I1ZKKXlhJexT6EGXcSSEWMaBSglQ/0RRHuh+7m2oZpzEEFlI9ilOpoD
 efrM3jSnHAUMB1rwHBbxmmRI=
X-Envelope-To: stable@vger.kernel.org
Received: from linux.dev (52.89.24.131)
	by smtp.migadu.com with ESMTPS id 30761f6d58e5e484;
	Wed, 19 Aug 2026 04:49:44 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 04:49:37 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	patches@lists.linux.dev
Subject: Re: [PATCH 6.18 227/250] eventfs: Use children field for rcu head
 and add memory barriers
Message-ID: <aoU1on2mnwB4pSGa@linux.dev>
References: <20260817132536.466235697@linuxfoundation.org>
 <20260817132545.791907087@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817132545.791907087@linuxfoundation.org>

Hi Greg,

Harshit's report on the 6.12 copy of this patch applies to 6.18 as
well:

  https://lore.kernel.org/stable/24644fdf-54f1-470c-9183-8f5c420c760f@oracle.com/

6.18.y also lacks 4d9b262031ff ("eventfs: Simplify code using
guard()s"), so the new direct return leaks the SRCU read lock. The same
fixup works here. Lockdep confirms the leak on 6.18.44 with the two
eventfs patches applied, and is quiet with the fixup. This one is also
from AI-assisted review, which I checked.

6.6 needs the same fixup too. 7.1 has 4d9b262031ff, so it is fine.

Thanks,
Jose
