Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903214;
	b=Hb74LfBpHNKpK5kzKYJTncpuGR55UN9jGW6WHf6BtsO212q97qnU9iS3GpJpHogYm4rE
	 MDw8rPGIfHgcHFtSEP7xUm80o/f2vmZrUCAnaK50cgJhtUW4jOvkrcIdVQfsndtQ6lq3I
	 z/kmyjhMyRVrWDHVwo/cWP81MPN6rhGGs/owi5badLM0PyFAJZHWuZ0kf1hqlAyrDtVc9
	 ARjgpPD7NPniw5ysHiexB3UevccDQVTt9WgNphEe0PJyrbegvG191ms3gVbNDYwvh6YqT
	 On91QF+AszUfu/jSqDLOOU6O/9R2FIqeGs4MwL2Cu78allSuAeR+zwWnJ7SyePFO2/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903214;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dfDgTO3yvVCZXtsYkXmpJ5oJ23yL/kKV2KveBtf9m/Y=;
	b=UEkGq8rtjhUfTm/XdAcHpO8DZPGMcLIiPM4XmNx3iIMCANxtlG22+h+jhCyiBypFDq7h
	 WfvV3tMCFH3QDjx8k9NG5wjETa645dViwm6zaWyvEUQkNb/+J6PRwCLzlhequf/M+4dB/
	 jaqlcdtps2aMXSi5nlPnAlg+1w/pRgwn+s9ffJ7CeJlm6VffbJJq8J2tbyackWXBUBIe0
	 hfbJ+DadthC4+KgfBLiQjr1CUCRLxWbS0UgMPBo8FFsU2v2ODFvF7MFs4eXMLBGH0o+5p
	 54nCYWTqRDeV5KUerIkluozIowNyniUiTz9GotsAzSJJ+smg702GrTBz+rMay+eC7Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpLtKeP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3719606A326;
	Thu,  5 Nov 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpLtKeP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC461F000C1;
	Thu,  5 Nov 2026 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903213;
	bh=dfDgTO3yvVCZXtsYkXmpJ5oJ23yL/kKV2KveBtf9m/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZpLtKeP4zBE9Z8UmQX+svuJ+lV/fyrpuDasHH5GEICirAYqT988m3dqbWivKck0/D
	 /h2NZjt2LGcRNUQO8oFcC5Kn67pTRaOliO/52Jhjkqv8X64bv9OBL6g46orTXkyA6Y
	 IcfCaVLCBai7PvktWxkYaw4YtAZ4zbqfirp9i1knn8OFMuYK0QyrfW/T6TXc0U/mF1
	 iTbJ29y5WoOnfmvzPLoMjKHIpRuYr6zMbp5Xsv1QoWSzYL6oSOU3pOGSQfy8t/8v0U
	 GwdjuMtbTXh32rBBa8dcg3v1u86G7vKk8cv4rqPIUPOEcTo365suEtsEq/VUvVLuaO
	 ggMPqRPEel3SQ==
Date: Thu, 5 Nov 2026 18:26:48 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Drew Fustini <dfustini@baylibre.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] pwm: axi-pwmgen: Enable clocks before accessing
 hardware registers in probe()
Message-ID: <20261105182648.GN1650678@google.com>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-5-lee@kernel.org>
 <auylN53GJra88-E3@monoceros>
 <20261105182626.GM1650678@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105182626.GM1650678@google.com>

On Thu, 05 Nov 2026, Lee Jones wrote:

> On Thu, 05 Nov 2026, Uwe Kleine-König wrote:
> 
> > On Thu, Nov 05, 2026 at 02:38:06PM +0000, Lee Jones wrote:
> > > axi_pwmgen_probe() calls axi_pwmgen_setup(), which reads and writes MMIO
> > > registers to verify the IP core version and determine the channel count,
> > > before acquiring and enabling axi_clk.  If the bootloader leaves the AXI
> > > peripheral clock gated, accessing the registers causes an unclocked bus
> > > access fault.
> > 
> > Do you have the hardware? Or what convinced you that an access fault
> > happens?
> 
> These are Sashiko bugs, as we discussed out-of-band.
> 
> None of these have been tested on real h/w.

I'll make that clear in the cover-letters going forward.

-- 
Lee Jones
