Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A0472068;
	Fri, 11 Sep 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134471; cv=none; b=BtgTuZ24aFwFftXrLa4SSQyfikDA68fHR7ZN96HdtL7cJriqMEVbEffaiPom/0JzAmKfYm8/J2M9ez0olpsuahcDkFMtxi/OYdY+nkbkw8i+kbbDrRGAgaiS+jRKw0TP4sl+q7pLDd6VZzIEUBwMshLJr5JxMeebo9PW8Cq4mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134471; c=relaxed/simple;
	bh=q02BnkdO2sJh/ZuZC/YhgRkZFmAF8Ri3Yezw+KMdQis=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nuVl51RdqgzycMgCsy70ukGWSSZ4lmV/4u8iElNnxa+TCqGII3Znz4/0QkhOTBZQADr1LMi3PGrByqFf+pyprIrs8MgnsEPgejH5BO6ocYjQPTUUoU5rlsAtMWu6VfGZyKoP6jS358VIAhklORBmm3FuqMH/x7DxLE6J27PDln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+kyxSUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+kyxSUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA601F000FF;
	Fri, 11 Sep 2026 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134460;
	bh=LcihR+7fa3+RNgDoK8hekhRM6EZ1Upp/g6TmCKw6W6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=B+kyxSUpWbrcE0/fFYdwzG529n+VqZH3wbD1Kl9X//iMG/uNnMmceQ7A7s4ifN1rC
	 b7JAJC31CcJ1uFtc7JfS0HHdQvEtAgjxwtn2sWCspAeaJ7XntR5iI9QKjVckEB3Wse
	 hPNfsBzY29ILxSi9b/0zJ9IZ6XRbrWvzjTtO/PLfmmAQS1WMoNmGb4XqUF2Ta1+ccN
	 xLyRGQcDxHI//wkoXBpd/0K7MHS1TWs7KM3DfGKeBEfjs21Iqzi0SX1heKTrsMDEzj
	 wY7UhNUWGaMGi41pJ2kAOX+xvv8jFxUCkqB2kcXdpE0+rj0q7kagi2x+cLePCUMM5E
	 v8RzGXlPp6tGg==
Date: Fri, 11 Sep 2026 15:47:37 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Aaron Skomra <aaron.skomra@wacom.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 1/5] HID: wacom: Use hdev->product in
 wacom_setup_touch_input_capabilities
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Message-ID: <07snqo29-s1qs-1867-2705-pp6s81qp249p@xreary.bet>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Lee Jones wrote:

> Replace the lookup-dependent 'wacom_wac->shared->touch->product' references
> with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
> 'hdev' is already available (via container_of) and represents the touch
> device itself.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

