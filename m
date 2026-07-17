Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA383C5523;
	Fri, 17 Jul 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283387; cv=none; b=fBwyvwm8FUw0nGH+Xy+pV+MTsTlND3OjDsm510p4LD+01y7lyddFbJ/aNd1e57dm+5AIWCTlhSZClpCVjUnXkBnSp1NEN98uXFN/lY8+zkauk61TTgNSClvJQCQif/y5K6hlcrW4ybgxGwllYkKuMcDJFLpgAQcOLXFu4Opr4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283387; c=relaxed/simple;
	bh=BdhS9yvmn5Yq/YaENAWVpoirpRgw3bQiq47TSTob03c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH310bDGX6Ag+FvZvQ2I2pkeQiYIYcrD7S/Bvw2kRPT1h1cPslSW1/P9x0jZDt/IbZtLIqc6/OZwJh1CbduQv3401nWd7hwwzE2mcarPIfv1/P90xLdzqt1e2Ne3oERAHgTPkkVcOmoJ895oFr1pIJoTyFOadjBBctqlc0TvnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yC/Qv8Zo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yC/Qv8Zo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7369C1F00A3A;
	Fri, 17 Jul 2026 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784283380;
	bh=Z10+3eYhKXZYs/JisbiOPFbJ8g1kFgXTyiMYwOnxBAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yC/Qv8ZobEpVBWOjzNZLKl+X/A48reChO1gFYRqnBHiU93uBNIK7GyIr7IJKXMv0J
	 /JaLkt1Vs3VDR9DHdc1VBaTnaWHO8i4OZKor9Nsp3RLvvFEKFbvw0LRFLVn1EvoUvp
	 V1z5lGFgFHYQgH12z2IdcVL5sbx28569c7GZoFpE=
Date: Fri, 17 Jul 2026 12:16:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Jack Pham <quic_jackp@quicinc.com>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Correct teardown ordering in
 ucsi_init() error path
Message-ID: <2026071705-vertigo-retorted-ea53@gregkh>
References: <20260717095006.101389-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717095006.101389-1-akuchynski@chromium.org>

On Fri, Jul 17, 2026 at 09:50:06AM +0000, Andrei Kuchynski wrote:
> The commit 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and
> ordering in port unregistration") consolidated port teardown into the
> ucsi_unregister_port() helper. However, it introduced an ordering problem
> in the ucsi_init() error path.
> 
> Fix this by ensuring ucsi_unregister_port() is called before we unregister
> their corresponding lockdep keys.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
> Link: https://lore.kernel.org/all/22064276-6c56-411a-9f20-6917ceeb865f@intel.com/
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You forgot a reported-by: tag :(

