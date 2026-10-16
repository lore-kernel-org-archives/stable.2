Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1B51118B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168078; cv=none; b=QkvcCaO9DrzdsgTLJBwp01UPN9SA4noECut46bpUfqbBQXQCq1CV6+CT7qE0Gid91BSxvmcVxID1f9QWbgPvK3xCwJQFzlFm3UZrszLhnuHw5m/Q03MvALcw1V90GHGunYSYfYnnUMl8AKVOxkN5qMRZH0QG+s8bySjU059ORnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168078; c=relaxed/simple;
	bh=lTVs+lGesT+Gfa6wXY66cDp9GiFHypF9sIduHB1Sjp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc4Lo+0Ib3MtQ3jRcj6VRiQLXl2wYA1OUOSCLwimoLq12Y5VkWyYjPxVKN9RML87hzi9+oQLWnlaOhfYL82NIxg0/SkSP7c/f8lUjhwN+mqkVzWx79aDc0o7avXjG4+5eScmH/X+aN1dQGNcUJQi1GADzaEuDUk/e3uDwgGjMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=m1L/BjUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rt8ZuPVg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="m1L/BjUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rt8ZuPVg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 419C3EC020C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:27:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 12:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792168076; x=1792254476; bh=pun4GvrJQ3
	Bvu7jvHXSNT7fMfZZxlz+130bhBZZWLRQ=; b=m1L/BjUsAyOF3Qvaz1jnjjCZk2
	Z2DITXkig6BeccTu4Dlf/15QTIKfrgov7tJW8tpOcyrGfYAOIaEbUKzjbM8hdanw
	1TtzGHsZqc6gHwPRHbMSLvYn2s9IqEvHzUSzIsy8SxkzZmxEw/HVyiJAOURCjDLv
	WbdQQwjWIKQDC1VEPspDd/xxnoADVRTjbKKp4CQ4/otRTA5dDH8yIR8Q4N2LZR/v
	LIqGHztiDF59cYeaV3VhKKYq8FiWxdc1vGDBfeN2VVp6EgNb/Y3k4jDXD43AwtoR
	d+WQOOqammCtk9HFYByHFBuNdeOy1gNc92EUBPdMOfzWrXfXALop2lqsHbMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792168076; x=1792254476; bh=pun4GvrJQ3Bvu7jvHXSNT7fMfZZxlz+130b
	hBZZWLRQ=; b=Rt8ZuPVgC3KKkfLQek6KJE+bBcBYaLwqg0qgWyjF5/UXDIwLgxo
	ZwDL4gxCBAo6L1GPAQqg+UyIt9E0ccKXFAGFu4aKKfivzYFzSA2WCvHr2OikdDi2
	Es0ClkIAfOg3QIAoekkP+feFjW2I3952Q4luu2d1NC/CAGpz0RiRoheukwyJPIjj
	VV80VXMla9VrmN3G05BLD2h6sSkkHwdo+WDncEB81qbb1Y+iM1+OY96vX975cvGy
	ZzMbw5fhzhAIHOZ3XQABymvtv9Ha66j102Wo0vrBHZ+qu0PmYo4k6NqfHqqjXKM2
	vuMLOEODiownXDJjqjRqafmF2QRl/Mp//Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792168076; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:g5ned47/Gmg2Rp5lZPolQtLjKZtRQ5PD6oH11f7i+8IVav4
	v7vGOvpw1VifomqSJyarEevjU8uSAFzZjcG1YT0kKFrN54lLYlyFhr+xN1vUXRyQ
	kdGSdZx6VWSjH1Ii07ags6pCtLHimNholJdLvSDAMK2tQwhzfyMRccuPP69CMjBE
	1shhhZIvvail9/TMuwY5akB6BEHcj75d1U2xQVk9Trdy2XNIg31kFM1CTVR2yXMX
	upfGMAXtSnynRayrfzHijzIqYPEVepFKiZvHi0vJXmO2hB79jfdq/goRLVY2Hnl5
	q9Xv5Mb6hJNZKTp/Uk21FQxXZSUDDHYK4mM6gmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CuAKkxrIJo2NjdoexkFMIq44LPm4X6oS1ymjc2ogW2Y=:lTVs+lGesT+Gfa6wXY66cDp9GiFHypF9sIduHB1Sjp8=;
X-ME-Sender: <xms:ilDSatNPHT26IoIcN7pqaOHKEdWiEzsqmJnt2-0fpYEpILJms7fgkA>
    <xme:ilDSatdxpGVRJYdkK-NJjeKNfjY7MzCgDtKii71_IVUt9_h7VN_qMvJYF22BMqBl4
    ImKJirYgShh4KVePWmgsNQWBdb33J9Vteow--8dN4LS3V02Jw>
X-ME-Received: <xmr:ilDSau6VRQcrFtZPQDnESqGUPBvhNm4J8_Ancbhq0WfVtYA_y2h10GnE-ee4UobWpXNgwwB6u9wSbDw4N4zBBJ7mTrzclFf-mLcJpN-QU2Q>
X-ME-Proxy-Cause: dmFkZTEf+6FkbPH2Eo8DuiCPeR/tum8ePzpWuPs2ZCySZ5ad7cVy6QAe4RnxZq5EM/8vbS
    3hskwxukLV4ajHCAudDffbDNUgYdiSd+mSF5AqhE2gJMuCfI5MpYjPLwBRU/tn75iLh2Al
    SPnHL56ERHYI11XoLcF+9WeOhlAcsfmzxKkrm6cqfIhxawGgwKnyLPFvV47Df+SNGIPU/n
    nqw5hlId2uy8IlBJoNxGqKAFM4Cy57evZaOpALHZg1TRnehWI1mkGSOthoOQ2VoUirCpht
    ahRsw0CRLZPflp/DnpYlgb/Nwi3fDZdKlVx01nXrUP2F/axSrDoDJB691XVw5xugLleGBk
    znYSKLia7FwsmD94iNhEbQ4XJ9rWK0HNDXkFGY6UjDVNjq6ek55fjTDZwsq/RpS9bGzw5V
    Mj8JwGB1q5yGAciOOTDZGWRpGiMuhKPuBWHc+2biL2d0ULDn/O5iEGqtglbjMEzBFQWt09
    TT+O1Ib6gDtxzNXNejo8jETsG3wRWijhnt0ZWCyynTCxBfWK0R/2XRfeYORjPk4/L2hUf6
    8cub7WimiFwetyTuZXnbq8xkhO/Ri/7vo0250PzgMV5Pcw4VQPHtnjP0oqQvH86x1CI/gk
    qW0pOxB1dPfRRs4iux3vFGYC6AtNwx8UW3luK/JIwpAtlNdSVSJN4V9sNojw
X-ME-Proxy: <xmx:ilDSavL3MwAWf9c4T75kC5ps4gheVWoy1h5zDaFJjzbN_srkgWg0Pg>
    <xmx:ilDSaoVFfGZrsdLOVyU1tQNojJhxjkx8pGnXFbVj5vD6Yjq88GhHfg>
    <xmx:ilDSarGfZdUERzoX6SDo4Kc71v1hCtzj58zpso5AO8bFr3Cie5OHvQ>
    <xmx:ilDSan5DCH0en2w5VtVLBQQ-TVO4WJ2Qdw7_YzmiNKKAZZ5U_OIr6A>
    <xmx:jFDSamztmz4cPUucxtte-xuA8oKgNej4EaHULpqarwLLokeMq_VLsURX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 12:27:54 -0400 (EDT)
Date: Fri, 16 Oct 2026 18:27:58 +0200
From: Greg KH <greg@kroah.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: stable@vger.kernel.org, sashal@kernel.org, technoboy85@gmail.com,
	hirofumi@mail.parknet.co.jp, brauner@kernel.org
Subject: Re: Please backport FAT end-of-directory fix to 6.18 and 6.12
Message-ID: <2026101626-tattling-mutation-26ee@gregkh>
References: <96dbd7d103fa6df33b0bbd492e309bd7@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96dbd7d103fa6df33b0bbd492e309bd7@tipi-net.de>

On Fri, Oct 16, 2026 at 02:25:02PM +0200, Nicolai Buchwitz wrote:
> Hi,
> 
> Please consider backporting upstream commit
> 
> 6a2875517c778ac1111b6920e94cbab91cda8724
> fat: stop reading directory entries past the end-of-directory marker
> 
> to 6.18.y and 6.12.y, and any other affected supported stable branches.
> 
> The fix prevents directory traversal from interpreting residual data
> after the FAT end-of-directory marker as real directory entries,
> resulting in bogus filenames and I/O errors.
> 
> This affects FAT16 CompactFlash media written by devices such as the
> Psion Series 7/netBook running EPOC32.

It does not apply cleanly to 6.12.y so please provide a working version
for there, and older kernels, if you wish to see it applied there.

thanks,

greg k-h
