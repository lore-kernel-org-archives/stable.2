Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCF3F39E4
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795048; cv=none; b=MUUo1H3Hfjy0rtJJJ1oDH8aOKQhF7WLpmsbbBcjhKmp7oHJwMJmE2+wsgLOXzndSmA1wOWYs1ePxOPSypm+FTgzjBZTu51GXXs5M7szsPBx23TkFsVU2zFoiV8WGEf/QIPdaJd0K9jt7Q48FHhKbDuXqtC8yQgooPq5oPZlm5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795048; c=relaxed/simple;
	bh=JBaS2Q04aweXvZXdinCzXRPAu6r6BImK2OJJhyEx5oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1XtI+B0cUB1cV1pSPaYb/HgVdf3lN/wK/JMjzqckF0vOPvkNeY/kfadurq8W5jOg5vrWZELCh+7Yk96ZShkx5to7JabsAn7YnpRnN7xUHPZskFPBVhrtd974fZEN7b/LE/H8MQZFD1hx44bXp32f64E794B4lmb8WFIqKo4Jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhWNkd4X; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhWNkd4X"
Date: Thu, 18 Jun 2026 17:03:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781795034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxMSge6U8hvyu9/832/EnznJ2DrtkqE2xb+8/H+YGPA=;
	b=fhWNkd4X/h/ypJbhfis2IstvBh8uI7J514JuTfWcWek6GsuH0I+raKAvA2vLvAhURqvpNc
	YG0eorUUqjC8FfwhVHFsd1IWW3xCzPRB8Ltom+1Eg1Dy3cg8bwsOiwDOuJq7Q5bE4H74dB
	WHJBF1G1B4aykGvqKxODAOEyW+cREUk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <ajQI0mJwobsGHj6F@linux.dev>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
 <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 17, 2026 at 09:54:00PM -0700, Borislav Petkov wrote:
> On Wed, Jun 17, 2026 at 03:04:18PM +0200, Thorsten Blum wrote:
> > cmdline_find_option() returns the full length of the argument value even
> > if it is truncated. However, get_cmdline_acpi_rsdp() only checks whether
> > acpi_rsdp= is present and does not reject truncated values that do not
> > fit in the buffer.
> > 
> > Reject truncated values early to prevent boot_kstrtoul() from parsing a
> > partial value and thus from silently using the wrong RSDP address.
> 
> And?
> 
> If it uses the wrong address, it'll crash'n'burn later. As it should be.

The problem is that we don't necessarily use the user-supplied address.

get_cmdline_acpi_rsdp() can truncate it into a different, parseable
address and use that instead. That might not crash at all.

We already return 0 and fail gracefully when boot_kstrtoul() cannot
parse the value; this does the same when cmdline_find_option() reports
the value was truncated because it didn't fit the buffer.
