Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6C1E511;
	Sat, 30 May 2026 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780125087; cv=none; b=RYyObkS1Rn0y/6gNgHHtyOTmLXnt9Kk1m5jRdtYRo0FSH/2fgWWuCIonk77f3voW0AJeIju+NDNibUwXoE4NFYGaUORKfzXTiY0JO4YKI+VlVYC23qE4tOXC/60WLaYfUTTJICFS6dlj9o0iReqyIyHlWjAnwLCo8Wh/gvg7NyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780125087; c=relaxed/simple;
	bh=aQE7YLdOdh4HVVgpHqMwXQxekJPVDFADSjrCaLryOYw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUkxqQ0HSFhPCiNZsXWqhma/hkFjsKwqcu2D+4inqPzp+1WAJjpOMyI56lbSaHhv200bsHx12s0ot2aQm29OujcNQGRVRCJ/PhbNPqnpZZCPSZZv7EE7u6xQ+JEcqwFxNa69re7JcVQVxDI+YkvgowuK+vVVoTBOeVnJ2OP4fCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=IStRB+M6; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="IStRB+M6"
Date: Sat, 30 May 2026 09:11:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mareichelt.com;
	s=202107; t=1780125084;
	bh=6+8id0CIj0Jup+mjx3ciOKIrKUQpIDG7ZN/h2hlbm7E=;
	h=Date:From:To:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:date:
	 author:from:to:subject:message-id:in-reply-to:references:
	 mail-followup-to:openpgp:mime-version:content-type:
	 content-transfer-encoding:author:from:subject:date:to:cc:
	 resent-author:resent-date:resent-from:resent-sender:resent-to:
	 resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
	 mime-version:content-type:content-transfer-encoding:
	 content-disposition:content-id:content-description:message-id:
	 mail-followup-to:openpgp;
	b=IStRB+M6qq3pf32/IUzRUkPII1waneNclXaV17yo44qs3YHmAwRZLVjMQFgQM9xzO
	 dimm9IqbXKRLc0S7+wBuvDxu89eJHy4C59GGwsOpqMNPS/Xgg4hhaOuoWp6V2R15Nh
	 cDeW6coZ+6Dv8vHBi3/9xobZT7VVK4Ho7TT9m05/fcdrE8PDhIbmfpdQij3t7gAGmv
	 nBWeRTVBZr9cuKF4AXxIo4szni2qtprrr5MP/s0mnrw70JQQ1Qiwy0FZZUH4MdwNTC
	 fRTW708PJ2g/QwJHHQTAyjwuKPOA0N2JL1nhyoNmCPrvf0GdyO1FLjY9Xy/A2XAUna
	 ajCQz5NZpbvrw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Message-ID: <20260530071124.GC23638@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260528194646.819809818@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 30 May 2026 19:45:49 +0000.
> Anything received after that time might be too late.

Hi Greg

7.0.11-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
with custom .config

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
