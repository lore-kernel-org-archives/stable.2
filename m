Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CB1DF254;
	Mon,  3 Aug 2026 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787205; cv=none; b=VNiNmO5fD01TctstBOCu0YlbxjK/aJL3ChEEadcPJ5vEbimqj2Ckat8bdCP4FCMQQA5xoRWPL0Zu9UgBSfcOzvYEp9JMU7W7O5IwpbQ1/EC5eCeOXKntAKh8kdPbOev/sCzruP7NJiLmb/PZ0yAaZCcAjN1nlf3Opb/TdBxQnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787205; c=relaxed/simple;
	bh=N5DuxHgLQXFzoNwPxlyFkHCIuaRivT7pGLAvoqnqNdw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aNQlezBnRdOQpmdyvNH6hCX5+pypojcI92OFS8EDAkNE3X5Z+pY7DYecMprEyqTYRVPnNyoY7vnbON5+c6aJs9BiNMLB20yrfaSStTKhO14HDVoMWAsO5gYYyG7bf1k+BUuo7lLZh274spYct9B0QrAWm5EKRWTIxXJArS23+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eitr07sA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eitr07sA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4222C1F000E9;
	Mon,  3 Aug 2026 20:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787202;
	bh=aBXzxBlghdnjFgR0Al9u5YGLup5L1LoJrVwR7yu5sVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Eitr07sA8VY6kHIeaY/MR4SjkfqFLOuu4ns4fJ4PHkuh8u8cT99oK6K3dBtL/6cNP
	 3vQe+ghPXfjd0L5YPu9KQJ0vQRhQ5anXqRDW2LpmDUfR41m/+c09pwN9UpNJM44yOb
	 zoAC3BSqbscrLVcnBrgYzh3dsZx3EPuk9NvSLYCIAUzF57KGrhlZfie2SJtPRit3kF
	 I8NSVsNAuzXJ4boUVcPRwvd0U61iuIJPBljdjLfWyv0r95dEVh1LyZiSIBNpKDEXw5
	 0bOtkHTLZPz/x3VmM/qyfbWlB6+OaUsJEbDT3uj7eSk77RyvhUbs1Eu9SVM2nj7l7t
	 Gl1k3aSsz7goQ==
Date: Mon, 3 Aug 2026 21:59:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Andre Eikmeyer <dev@deq.rocks>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Aditya Garg <gargaditya08@live.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: apple: preserve keyboard backlight across T2
 resume
In-Reply-To: <20260718121527.15924-1-dev@deq.rocks>
Message-ID: <1p49r2s3-n371-r0rp-5qr9-o5p471no1sp0@xreary.bet>
References: <20260718121527.15924-1-dev@deq.rocks>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 18 Jul 2026, Andre Eikmeyer wrote:

> The T2 virtual USB host controller re-enumerates the internal keyboard
> after system resume. The butterfly keyboard backlight currently uses
> LED_CORE_SUSPENDRESUME, so the LED core sends a blocking request to the
> old HID device while it is disappearing. That request fails with -ENODEV
> and the newly probed device starts with its backlight off.
> 
> To fix this, we cache the requested brightness when the old HID device is
> removed and restore it when the replacement is probed. We let
> re-enumeration handle restoration instead of issuing a request through the
> stale device.
> 
> Fixes: 1f95a6cd5ad7 ("HID: apple: ensure the keyboard backlight is off if suspending")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

The series is now queued in hid.git#for-7.3/apple. Thanks,

-- 
Jiri Kosina
SUSE Labs

