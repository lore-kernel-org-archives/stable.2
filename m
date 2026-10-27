Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085199;
	b=zoG8D5H7tgsiDzYqlpVERTAdWu+ZsCDMlLhcZdxj1oWbw+G6xHx7R4CeY3OjhGgRlu3u
	 ZkPUwXeN9SXO8dRdVUSEkuFtTfDRxJ2hgeiGwztsZ0GhSh0TdOENB2S+tIBQBRAHQLh44
	 CVMIMggUtvAg53LH+skMJRzRCbw+KNDiWRnVDaqmN4btRCU0F6LPi13AyrNmp5uJpyOiZ
	 vqp4fHtEGUfPRjTW7A2RzGtLxuyecUbdGf23igxTMWEdsqA/8GkCbrZZA6HfeQubt6amf
	 +uhQrmkSdVDUwXkKuapuRU3ABdrQUF9yuBYxBZRDFPqa6HpXsVRKiquutCZBoG2ELzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085199;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=y5AwK/AFW3HmxN3+8Mjy9hadHmPsg+2oiGkIheQk+Io=;
	b=KftT9xSNlESZA2Ec5hH7xSs9NglSnUZfnEYXIfpN5ctzyrOVPe/wHA1EpV35EiS9lXKH
	 tMaKI5oHgjUOM5FqBpoRGbKbcP4DA09eW5S05Frg9JDI7jDgpXuHb97DbWx60LodQp/ch
	 oiDooZSYLUZHxqaWidFYUgkcfM62C+lMFC9Tih5xiOIxeOC914tCdD4O7APHWVUgMZqOa
	 JD4qZqWdxegr9i9wNkpIMYS7YGTHhPg4MD1UJ8045EDqwXjWRIx81BBillaWiwseMZfrj
	 0iIGaz1p3GHmHdPabN363GXnKMMIg5Me93pEPWqei//X43FZdYhsXU1cgwtovD2Q1Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=bJY1UlJH;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BA606A31B;
	Tue, 27 Oct 2026 07:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80BA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=bJY1UlJH
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id EC3AD1F83F;
	Tue, 27 Oct 2026 08:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1793085194;
	bh=y5AwK/AFW3HmxN3+8Mjy9hadHmPsg+2oiGkIheQk+Io=; h=From:To:Subject;
	b=bJY1UlJHTJ8zSLuc+90120HLRBT5s9/aTG9uQb+5+rQFwS8HjnbNCDT44Tq1kFBi2
	 YZ6ql6VG5YGXNv1CKgpNHKb5ga/f2SS3T03+KEbJcD7YtF9qxTuwO1M2R9HSODJM9Z
	 PABC8poZTTd3s61ipFV9Ed2wOmuk1DOma/dRGodnYPR9hXfBS7QJzupl7htxTAF3h5
	 6AO0+bqGJzQGmLzRxTuXjTm7RZfc17CejadOdyC72pQZrIEeUce2mxBIkkkBhHGde1
	 04zRz3eVQMieukqXTL42Q1iEAbDJm1TB/9VWlqgMRI8wiAeX9sVWAfTORKFfuooZTP
	 CqJq+cl8blbOw==
Date: Tue, 27 Oct 2026 08:13:09 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: serialize synchronous command buffer
 access
Message-ID: <20261027071309.GA28049@francesco-nb>
References: <20261027065700.918360-1-lee@jaeyeong.cc>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027065700.918360-1-lee@jaeyeong.cc>

On Tue, Oct 27, 2026 at 06:57:07AM +0000, Jaeyeong Lee wrote:

[...]

> Compile-tested with LLVM 22.1.8 and W=1. Runtime testing was not possible
> because no supported mwifiex hardware was available.

What's the point of such a patch you did not even test?
No, thanks?

Francesco


