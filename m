Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454637E2EE;
	Sat, 22 Aug 2026 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435564; cv=none; b=fj6WPTYdiK8iSNZikNzVw99uZQbdfe7gvLaih1JOsUmgXmlJPga1jiAyX4jZCmcCHtF5hZ1mMZ1+a134QKzt7GbswlqQMMY7GxB2yaHNVCs9aGqY35bg62E96NiaUd/i7QJIvcjeCNQr5ExrBClOyIggxlYrP1RDnfQ0rqoIS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435564; c=relaxed/simple;
	bh=z1SFF23kVHjUkQ8VtNcI4T1dgFBUNWmSzi/kF5hFdoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfxLhnh64hR4VSScPyGMS56BnvBNahQBiyBKo9oVR32JIWxCgVR4+Qt4YdzynzyZeczqEhg42lD/0JUBYO6ICL+DUufU5NvskXzmQMVjYxXz0+NmIOVobHt1p+NRgHnIy38YhW2eOmGaQ9iYSXdhnUmk353pzHXebHwuHIPRFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=PThRT9JF; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="PThRT9JF"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6DDC34020C;
	Sat, 22 Aug 2026 21:52:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 14AC830;
	Sat, 22 Aug 2026 21:52:21 +0000 (UTC)
Date: Sat, 22 Aug 2026 17:52:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <include@grrlz.net>
Cc: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, bsegall@google.com,
 dietmar.eggemann@arm.com, kees@kernel.org, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] fork: initialize function graph state before
 copy_exec_state()
Message-ID: <20260822175209.3bc255d3@fedora>
In-Reply-To: <20260822170928.1acba2cc@fedora>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
	<20260822170928.1acba2cc@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oecqcq3jg44x6sad1zai3jhigekgdk18
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 14AC830
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18o9nZPijjm5fLztvCCYL2gxznxJRGXRfA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=pEt8O7LRcCyZgmO9qoneCT5b17y2bffjN5bHSaZ1+eQ=; b=PThRT9JFyMELxlt4cDT4fWfwjdtR7AgQl9vRmrqmB1Y0I9sKW+S0KsrzrOsJpcrldSRFc2iN71iMuTJNFm7Zo4egyYwX1MYPOUn97SpBbCbjB2v2chfOJVv1vUuWDAJeWWohshECSRwo+pGqlFBK/zkBiqxLAEMZYms9D1JJgJw=
X-HE-Tag: 1787435541-503601
X-HE-Meta: U2FsdGVkX19UINL0mmjW3hpFQxrhf/7zY2aOpgFoZTxOywy6YXM+r6/gNO/T+lLGHzD/Xbox/2BzdIxNf+HbCZpVOcRoj2LT68FMo14DGhu7Tdv9WRXcWJ0rMyDnf/sijEig2VhxgnptJgcRLP5jgEfg0Vc+yakLccQB4HsruOWMZ0mbLZG9E6XrT9jEvnWGj6bcD8tJzEOQmkw6eX+jm92d7nDJ2pC3SJXPVB0y8dSpifkSsEZQWD48mbAeOGY+Rn/LePQn4/38xbCd7mEytgfAN6MCZxEtUXHGBt72PB+pKvAzil/f0b7HqvNOvxT8hgS3tnHptvs3c9UAz0aSZc24pDAY1YFAVWzI7x8AjXcIl5ubOzp+P1MIwMVpIO96

On Sat, 22 Aug 2026 17:09:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > >Resending v2     
> > 
> > (no! V3!!)   
> 
> Right, when resending, it is best to add "[RESEND]" to the subject:

I shouldn't have said "right" because it wasn't. You add "RESEND" not
v3. You should not up the version if the patch has not changed and you
are only resending to update the Cc. I do that all the time.

-- Steve

> 
>    [RESEND][PATCH v2] fork: initialize function graph state before copy_exec_state()
