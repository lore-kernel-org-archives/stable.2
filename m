Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BC3290B9;
	Mon,  3 Aug 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779195; cv=none; b=JaDfDBalommxfvVizB2kl1IrB4Hrqbx4TDw+cGTECFaAkotaYBAyh47zwSCUspsNZgsoALQd/G8afz0CMBSL34P0jRHoGll2EIt24JtdZenrb85MpzpA95gGvSOAo2pPWW8GSqFq8RAeQ8NAonO9NB9S718jvypI7Xjr88OTgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779195; c=relaxed/simple;
	bh=Jv03YdJypRlKMqeTPuP54VwFCUe79BCf0SVecokVhCY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qcSpYpIZNJa3cuNWNKpScunJvH3yBXA0meOV0jjZ00NZ/TTEXvABJ5G/QW//V6s3a+SZTkCsjJaeMyHyglXHI0IUOxYH4GBHGhFfjXxKfvXrxjWSGl3Mwf+Z7XommUwruiCigs7YN4BoTtq3UvDgEDKYcIbi8J+OO/owCurVTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBu2vWDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBu2vWDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80911F000E9;
	Mon,  3 Aug 2026 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779194;
	bh=bw7W2C30haTMcWUYbm86u/RBXeYStpNYSsBRQRSIEoE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OBu2vWDY+JuErGrPeeyjVLQI1dNC/1ALVCn7NYZNmOeXafL2gvXxGvSQuHAabbt1t
	 fXsGduGEpOrIlNnkTm898TZ0zxijNMppFjf9RIt3h2FIywr7PQwn0xX8qgXw22ddjt
	 3mu/UxtvWplr1gTSsYpFPPDq6i2Ol4OXCWYUhjD8P2+BZrY7nMjAWSsdlGtlPtpV9n
	 f8xz3DxT6aDONabbcaiFijI8QCnC1iRFrEeHH+3ydGSwPIjFIXHzwceJvjjOrkYZhs
	 QnX7p3qTGum7ixWAjjx2byHIZkoWDrVs8peQWKl2QR+P2X3ymiRsb5d/1Tq1o36H3j
	 VqNz1qnO6Lqqg==
Date: Mon, 3 Aug 2026 19:46:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: corsair-void: Check size of status and firmware
 events before reading them
In-Reply-To: <20260630010656.626157-3-stuart.a.hayhurst@gmail.com>
Message-ID: <2rqpp566-6oq0-p024-s784-p3714q02oqpo@xreary.bet>
References: <20260630010656.626157-3-stuart.a.hayhurst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jun 2026, Stuart Hayhurst wrote:

> Malformed status and firmware events could cause an out-of-bounds read since
> the size wasn't being checked. Check the size and warn on unexpected values to
> avoid this.
> 
> Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

