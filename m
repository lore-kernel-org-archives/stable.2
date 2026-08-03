Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989A4334B2;
	Mon,  3 Aug 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783790; cv=none; b=rkTsqWOHBolUpCXRx/auC9k8cf1o8mSKQihGbbuNZks+QMMlQzW43zPsMNcmqf+Fr+6+hWnm5w4Wf6gzJA5JCvAj3HBiBNxQLmgTDBvfjr+rUpDQMc+zeb4tkV6vsHcQz39UWydOSsTzrvwWDXlLehxv/gGeZgESitggR7Vsc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783790; c=relaxed/simple;
	bh=q79nvBknNJwlsPFH3ffiXtIe7Otx+TdZPcim1Cc1BB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=USc/d0/VoVohJ3sxIW9H932FEJjXj6yCyT3v3rpIslpVJQD9OtbSJSHWYbh14qFl4JMzy6k2GMNd7mMOtnkJtvfIiqOfdNT74PTpjeOlzpVLt0pCNcZxuGWcI5TK24NyaASKWcwSEgLLvE6Yqjlc5HZ1viZnqtgaE2Q4tQPj/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J06W7bLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J06W7bLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E67A1F000E9;
	Mon,  3 Aug 2026 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783789;
	bh=FoBvKsqdoyz4c3zKUfYQSTb6gh4q85lnXIpmkbUqoBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=J06W7bLPcPFQqbF10mXIU98Nj6EUEQfnkA+1S8wHbyKW5Fhv8OFiFW9m17y5ke96y
	 0JXeUhhJgeR4j6dX6lDIZwIXFnM2zeMbWt6EHHFQyynLPhaSL2MF+NHY1uMXNntWZf
	 gYzcoSvJyTufPvc63/M5RTJPWynaRIh+tCIKBEG7RQ4QoZOwihSY2YIgXBTsw7sspa
	 zGw7b+cmXDYeIIA2kc62vLjvfmMfECbFkS65Oqp18EJ68tpGXYKZ1TY8Dqjs05dRaI
	 2NPXwMbxO+CsYTLI4YR+g3SQW7a716uuGCN+7ShkjZBlDfUgvFjnKnOn+PyvO5Mddb
	 gyVin951eeSOg==
Date: Mon, 3 Aug 2026 21:03:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Andrei Fed <andfed.net@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: fix battery reporting for Bluetooth
 Magic Trackpad USB-C
In-Reply-To: <20260706175507.47288-1-andfed.net@gmail.com>
Message-ID: <s548r57p-qnq7-34o4-2989-9r4911q0r2q2@xreary.bet>
References: <20260706175507.47288-1-andfed.net@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Jul 2026, Andrei Fed wrote:

> The Apple Magic Trackpad 2 (USB-C) reports a wildly wrong battery
> capacity over Bluetooth, for example a constant 4% for a pack that is
> actually at 74%.
[ ... snip ... ]

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

